local Player = game:GetService('Players').LocalPlayer;
local UIS = game:GetService('UserInputService');
local Mouse = Player:GetMouse();
local tService = game:GetService('TweenService');
local runService = game:GetService('RunService');
local HttpService = game:GetService('HttpService');
local Stepped
local items = {};
local uiToggled = false;
local keyToHide = Enum.KeyCode.F4;-- Key to hide gui
local sEffect = 270126064; -- clink/click sound effect
local sEffect2 = 2668781453; -- Buttonpress
local notifVolume = 4;
local notifSound = 5649595739; -- put audio id here

local RippleClick = true;
getgenv().autoCompleteStatus = true;
getgenv().merchantESP = true;
getgenv().bossESP = true;

function WTS(part)		
	local Screen = workspace.CurrentCamera:WorldToViewportPoint(part.Position);
	return Vector2.new(Screen.x, Screen.y);
end

function calcDistance(p1, p2)
	return math.floor(((p1.Position - p2.Position).magnitude) / 3.28084);
end

function ESP(part, name, color, Type)

	repeat wait() until part.Parent:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('HumanoidRootPart')

	local distanceText = Drawing.new("Text");
	distanceText.Text = name;
	distanceText.Color = color;
	distanceText.Position = WTS(part);
	distanceText.Size = 16.0;
	distanceText.Outline = true;
	distanceText.Center = true;
	distanceText.Visible = true;

	local circle = Drawing.new("Circle");
	circle.Position = WTS(part);
	circle.Color = color;
	circle.Thickness = 0.1;
	circle.NumSides = 16.0;
	circle.Radius = 4.0;
	circle.Visible = true;
	circle.Filled = true;

	local Stepped = runService.Stepped:Connect(function()
		pcall(function()

			if part.Parent:FindFirstChild('HumanoidRootPart') ~= nil or Player.Character:FindFirstChild('HumanoidRootPart') ~= nil then

				part.AncestryChanged:Connect(function()
					if (not part:IsDescendantOf(workspace.NPCs)) and distanceText ~= nil and circle ~= nil then
						distanceText:Remove();
						circle:Remove();
						distanceText = nil;
						circle = nil;		
					end
				end)

				if part.Parent:FindFirstChild('HumanoidRootPart') ~= nil and Player.Character:FindFirstChild('HumanoidRootPart') ~= nil then
					distanceText.Position = WTS(part);
					circle.Position = WTS(part);
					distanceText.Text = name.."("..calcDistance(part, Player.Character:WaitForChild('HumanoidRootPart')).."m"..")";
				else
					Stepped:Disconnect();
				end

				local _, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position);

				if onScreen then

					if not getgenv().merchantESP and Type == 'Merchant' then
						distanceText.Visible = false;
						circle.Visible = false;
					elseif getgenv().merchantESP and Type == 'Merchant' then
						distanceText.Visible = true;
						circle.Visible = true;
					end
					
					if not getgenv().bossESP and Type == 'Boss' then
						distanceText.Visible = false;
						circle.Visible = false;
					elseif getgenv().bossESP and Type == 'Boss' then
						distanceText.Visible = true;
						circle.Visible = true;
					end
					
				else
					distanceText.Visible = false;
					circle.Visible = false;
				end
			else
				Stepped:Disconnect();
			end

		end)
	end)
end

local sUI = Instance.new('ScreenGui', game.CoreGui);
sUI.Name = 'PgMrMyRORt';

local mainFrame = Instance.new('ImageLabel', sUI);
mainFrame.Name = 'Main';
local mainFrameCorner = Instance.new('UICorner', mainFrame);

local rippleCircle = Instance.new('ImageLabel', mainFrame);
rippleCircle.Name = 'Circle';

local tabFrame = Instance.new('Frame', mainFrame);
tabFrame.Name = 'Tabs';
local tabFrameCorner = Instance.new('UICorner', tabFrame);
local tabFrameListLayout = Instance.new('UIListLayout', tabFrame);
local tabFramePadding = Instance.new('UIPadding', tabFrame);

local titleGasman = Instance.new('TextLabel', tabFrame);
titleGasman.Name = 'Title';

local bossTab = Instance.new('TextButton', tabFrame);
bossTab.Name = 'bossTab';
local bossTabCorner = Instance.new('UICorner', bossTab);

local merchantTab = Instance.new('TextButton', tabFrame);
merchantTab.Name = 'merchantTab';
local merchantTabCorner = Instance.new('UICorner', merchantTab);

local slidesBG = Instance.new('Frame', mainFrame);
slidesBG.Name = 'Slides';
local slidesBGPageLayout = Instance.new('UIPageLayout', slidesBG);

local firstSlide = Instance.new('Frame', slidesBG);
firstSlide.Name = 'firstSlide';
local firstSlideListLayout = Instance.new('UIListLayout', firstSlide);
local firstSlidePadding = Instance.new('UIPadding', firstSlide);

local merchantText = Instance.new('TextLabel', firstSlide);
merchantText.Name = 'merchantText';
local merchantTextCorner = Instance.new('UICorner', merchantText);

local npcNameInput = Instance.new('TextBox', firstSlide);
npcNameInput.Name = 'npcNameInput';
local npcNameInputCorner = Instance.new('UICorner', npcNameInput);

local itemList = Instance.new('TextLabel', firstSlide);
itemList.Name = 'itemList';
local itemListCorner = Instance.new('UICorner', itemList);

local completeFrame = Instance.new('Frame', firstSlide);
local completeFrameCorner = Instance.new('UICorner', completeFrame);
local completeButton = Instance.new('TextButton', completeFrame);
local completeButtonCorner = Instance.new('UICorner', completeButton);
local completeButtonCircle = Instance.new('Frame', completeButton);
local completeButtonCircleCorner = Instance.new('UICorner', completeButtonCircle);
local completeText = Instance.new('TextLabel', completeFrame);

local espMerchantFrame = Instance.new('Frame', firstSlide);
local espMerchantFrameCorner = Instance.new('UICorner', espMerchantFrame);
local espMerchantButton = Instance.new('TextButton', espMerchantFrame);
local espMerchantButtonCorner = Instance.new('UICorner', espMerchantButton);
local espMerchantButtonCircle = Instance.new('Frame', espMerchantButton);
local espMerchantButtonCircleCorner = Instance.new('UICorner', espMerchantButtonCircle);
local espMerchantText = Instance.new('TextLabel', espMerchantFrame);

local secondSlide = Instance.new('Frame', slidesBG);
local secondSlideListLayout = Instance.new('UIListLayout', secondSlide);
local secondSlidePadding = Instance.new('UIPadding', secondSlide);

local bossText = Instance.new('TextLabel', secondSlide);
local bossTextCorner = Instance.new('UICorner', bossText);

local espBossFrame = Instance.new('Frame', secondSlide);
local espBossFrameCorner = Instance.new('UICorner', espBossFrame);
local espBossButton = Instance.new('TextButton', espBossFrame);
local espBossButtonCorner = Instance.new('UICorner', espBossButton);
local espBossButtonCircle = Instance.new('Frame', espBossButton);
local espBossButtonCircleCorner = Instance.new('UICorner', espBossButtonCircle);
local espBossText = Instance.new('TextLabel', espBossFrame);

local itemFoundSound = Instance.new('Sound', mainFrame);
local toggleSound = Instance.new('Sound', mainFrame);

local notifSUI = Instance.new('ScreenGui', game.CoreGui);
notifSUI.Name = 'zUSBZwVYLk';

local notifFrame = Instance.new('ImageLabel', notifSUI);
local notifFrameCorner = Instance.new('UICorner', notifFrame);
local notifFrameListLayout = Instance.new('UIListLayout', notifFrame);

local notifText = Instance.new('TextLabel', notifFrame);

local checkButton = Instance.new('ImageButton', notifFrame);
local checkButtonCorner = Instance.new('UICorner', checkButton);

local notifClick = Instance.new('Sound', notifFrame);
local notif = Instance.new('Sound', notifFrame);

mainFrame.BackgroundTransparency = 0;
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 26);
mainFrame.BorderSizePixel = 0;
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5);
mainFrame.Size = UDim2.new(0.4, 0, 0.45, 0);
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
mainFrame.ClipsDescendants = true;
mainFrame.Image = 'rbxassetid://0';
mainFrameCorner.CornerRadius = UDim.new(0, 12);

rippleCircle.BackgroundTransparency = 1;
rippleCircle.BorderSizePixel = 0;
rippleCircle.ZIndex = 10;
rippleCircle.Image = 'rbxassetid://266543268';
rippleCircle.ImageColor3 = Color3.fromRGB(150, 150, 150);
rippleCircle.ImageTransparency = 0.9;
rippleCircle.ScaleType = Enum.ScaleType.Stretch;

tabFrame.BackgroundTransparency = 0;
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
tabFrame.BorderSizePixel = 0;
tabFrame.AnchorPoint = Vector2.new(0, 0);
tabFrame.Size = UDim2.new(0.2, 0, 1, 0);
tabFrame.Position = UDim2.new(0, 0, 0, 0);
tabFrameCorner.CornerRadius = UDim.new(0, 10);

tabFrameListLayout.Padding = UDim.new(0.03, 0);
tabFrameListLayout.FillDirection = Enum.FillDirection.Vertical;
tabFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
tabFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
tabFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder;

tabFramePadding.PaddingBottom = UDim.new(0, 0);
tabFramePadding.PaddingLeft = UDim.new(0, 0);
tabFramePadding.PaddingRight = UDim.new(0, 0);
tabFramePadding.PaddingTop = UDim.new(0.025, 0);

titleGasman.BackgroundTransparency = 1;
titleGasman.AnchorPoint = Vector2.new(0, 0);
titleGasman.Size = UDim2.new(1, 0, 0.06, 0);
titleGasman.Font = Enum.Font.Highway;
titleGasman.Text = "Gasman's AO";
titleGasman.TextScaled = true;
titleGasman.TextWrapped = true;
titleGasman.TextColor3 = Color3.fromRGB(242, 242, 242);
titleGasman.LayoutOrder = 0;

merchantTab.BackgroundTransparency = 0;
merchantTab.BackgroundColor3 = Color3.fromRGB(20, 22, 26);
merchantTab.BorderSizePixel = 0;
merchantTab.AnchorPoint = Vector2.new(0, 0);
merchantTab.Size = UDim2.new(0.9, 0, 0.09, 0);
merchantTab.Font = Enum.Font.Gotham;
merchantTab.Text = 'Merchant';
merchantTab.TextColor3 = Color3.fromRGB(242, 242, 242);
merchantTab.TextSize = 26;
merchantTab.TextWrapped = true;
merchantTab.LayoutOrder = 1;
merchantTab.AutoButtonColor = false;
merchantTab.ClipsDescendants = true;
merchantTabCorner.CornerRadius = UDim.new(0, 6);

bossTab.BackgroundTransparency = 0;
bossTab.BackgroundColor3 = Color3.fromRGB(20, 22, 26);
bossTab.BorderSizePixel = 0;
bossTab.AnchorPoint = Vector2.new(0, 0);
bossTab.Size = UDim2.new(0.9, 0, 0.09, 0);
bossTab.Font = Enum.Font.Gotham;
bossTab.Text = 'Boss';
bossTab.TextColor3 = Color3.fromRGB(242, 242, 242);
bossTab.TextSize = 26;
bossTab.TextWrapped = true;
bossTab.LayoutOrder = 2;
bossTab.AutoButtonColor = false;
bossTab.ClipsDescendants = true;
bossTabCorner.CornerRadius = UDim.new(0, 6);

slidesBG.BackgroundTransparency = 1;
slidesBG.AnchorPoint = Vector2.new(0, 0);
slidesBG.Size = UDim2.new(0.8, 0, 1, 0);
slidesBG.Position = UDim2.new(0.2, 0, 0, 0);

slidesBGPageLayout.Animated = true;
slidesBGPageLayout.Circular = false;
slidesBGPageLayout.EasingDirection = Enum.EasingDirection.Out;
slidesBGPageLayout.EasingStyle = Enum.EasingStyle.Quart;
slidesBGPageLayout.Padding = UDim.new(0, 0);
slidesBGPageLayout.TweenTime = 0.8;
slidesBGPageLayout.FillDirection = Enum.FillDirection.Vertical;
slidesBGPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
slidesBGPageLayout.SortOrder = Enum.SortOrder.LayoutOrder;
slidesBGPageLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
slidesBGPageLayout.GamepadInputEnabled = false;
slidesBGPageLayout.ScrollWheelInputEnabled = false;
slidesBGPageLayout.TouchInputEnabled = false;

firstSlide.BackgroundTransparency = 1;
firstSlide.AnchorPoint = Vector2.new(0, 0);
firstSlide.Size = UDim2.new(1, 0, 1, 0);
firstSlide.LayoutOrder = 0;

firstSlideListLayout.Padding = UDim.new(0.025, 0);
firstSlideListLayout.FillDirection = Enum.FillDirection.Vertical;
firstSlideListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
firstSlideListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
firstSlideListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;

firstSlidePadding.PaddingBottom = UDim.new(0, 0);
firstSlidePadding.PaddingLeft = UDim.new(0, 0);
firstSlidePadding.PaddingRight = UDim.new(0, 0);
firstSlidePadding.PaddingTop = UDim.new(0.025, 0);

merchantText.BackgroundTransparency = 0;
merchantText.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
merchantText.AnchorPoint = Vector2.new(0, 0);
merchantText.Size = UDim2.new(0.9, 0, 0.09, 0);
merchantText.Font = Enum.Font.Gotham;
merchantText.Text = 'Merchant Hackermans';
merchantText.TextColor3 = Color3.fromRGB(242, 242, 242);
merchantText.TextSize = 25;
merchantText.LayoutOrder = 0;
merchantTextCorner.CornerRadius = UDim.new(0, 8);

npcNameInput.BackgroundTransparency = 0;
npcNameInput.BackgroundColor3 = Color3.fromRGB(41, 44, 50);
npcNameInput.Size = UDim2.new(0.5, 0, 0.09, 0);
npcNameInput.Font = Enum.Font.Nunito;
npcNameInput.PlaceholderText = 'NPC NAME HERE'
npcNameInput.PlaceholderColor3 = Color3.fromRGB(242, 242, 242);
npcNameInput.TextScaled = true;
npcNameInput.TextWrapped = true;
npcNameInput.TextColor3 = Color3.fromRGB(242, 242, 242);
npcNameInput.Text = '';
npcNameInput.LayoutOrder = 1;
npcNameInputCorner.CornerRadius = UDim.new(0, 8);

itemList.BackgroundTransparency = 0;
itemList.BackgroundColor3 = Color3.fromRGB(41, 44, 50);
itemList.BorderSizePixel = 0;
itemList.AnchorPoint = Vector2.new(0, 0);
itemList.Size = UDim2.new(0.7, 0, 0.5, 0);
itemList.LayoutOrder = 2;
itemList.Font = Enum.Font.Nunito;
itemList.TextScaled = true;
itemList.TextWrapped = true;
itemList.TextColor3 = Color3.fromRGB(242, 242, 242);
itemList.Text = '';
itemList.LayoutOrder = 2;
itemListCorner.CornerRadius = UDim.new(0, 8);

espMerchantFrame.BackgroundTransparency = 0;
espMerchantFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
espMerchantFrame.BorderSizePixel = 0;
espMerchantFrame.AnchorPoint = Vector2.new(0, 0);
espMerchantFrame.Size = UDim2.new(0.5, 0, 0.09, 0);
espMerchantFrame.LayoutOrder = 3;
espMerchantFrameCorner.CornerRadius = UDim.new(0, 10);

espMerchantText.BackgroundTransparency = 1;
espMerchantText.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
espMerchantText.Size = UDim2.new(0.7, 0, 1, 0);
espMerchantText.Position = UDim2.new(0, 0, 0, 0);
espMerchantText.Font = Enum.Font.Nunito;
espMerchantText.Text = 'ESP';
espMerchantText.TextSize = 26;
espMerchantText.TextColor3 = Color3.fromRGB(242, 242, 242);

espMerchantButton.BackgroundTransparency = 0;
espMerchantButton.BackgroundColor3 = Color3.fromRGB(85, 255, 125);
espMerchantButton.Size = UDim2.new(0.2, 0, 0.65, 0);
espMerchantButton.Position = UDim2.new(0.75, 0, 0.2, 0);
espMerchantButton.Text = '';
espMerchantButtonCorner.CornerRadius = UDim.new(1, 0);

espMerchantButtonCircle.BackgroundTransparency = 0;
espMerchantButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
espMerchantButtonCircle.Size = UDim2.new(0.313, 0, 0.7, 0);
espMerchantButtonCircle.Position = UDim2.new(0.55, 0, 0.14, 0);
espMerchantButtonCircleCorner.CornerRadius = UDim.new(1, 0);

completeFrame.BackgroundTransparency = 0;
completeFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
completeFrame.BorderSizePixel = 0;
completeFrame.AnchorPoint = Vector2.new(0, 0);
completeFrame.Size = UDim2.new(0.5, 0, 0.09, 0);
completeFrame.LayoutOrder = 4;
completeFrameCorner.CornerRadius = UDim.new(0, 10);

completeText.BackgroundTransparency = 1;
completeText.Size = UDim2.new(0.7, 0, 1, 0);
completeText.Position = UDim2.new(0, 0, 0, 0);
completeText.Font = Enum.Font.Nunito;
completeText.Text = 'Autocomplete Name';
completeText.TextSize = 26;
completeText.TextColor3 = Color3.fromRGB(242, 242, 242);

completeButton.BackgroundTransparency = 0;
completeButton.BackgroundColor3 = Color3.fromRGB(85, 255, 125);
completeButton.Size = UDim2.new(0.2, 0, 0.65, 0);
completeButton.Position = UDim2.new(0.75, 0, 0.2, 0);
completeButton.Text = '';
completeButtonCorner.CornerRadius = UDim.new(1, 0);

completeButtonCircle.BackgroundTransparency = 0;
completeButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
completeButtonCircle.Size = UDim2.new(0.313, 0, 0.7, 0);
completeButtonCircle.Position = UDim2.new(0.55, 0, 0.14, 0);
completeButtonCircleCorner.CornerRadius = UDim.new(1, 0);

secondSlide.BackgroundTransparency = 1;
secondSlide.AnchorPoint = Vector2.new(0, 0);
secondSlide.Size = UDim2.new(1, 0, 1, 0);
secondSlide.LayoutOrder = 1;

secondSlideListLayout.Padding = UDim.new(0.025, 0);
secondSlideListLayout.FillDirection = Enum.FillDirection.Vertical;
secondSlideListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
secondSlideListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
secondSlideListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;

secondSlidePadding.PaddingBottom = UDim.new(0, 0);
secondSlidePadding.PaddingLeft = UDim.new(0, 0);
secondSlidePadding.PaddingRight = UDim.new(0, 0);
secondSlidePadding.PaddingTop = UDim.new(0.025, 0);

bossText.BackgroundTransparency = 0;
bossText.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
bossText.AnchorPoint = Vector2.new(0, 0);
bossText.Size = UDim2.new(0.9, 0, 0.09, 0);
bossText.Font = Enum.Font.Gotham;
bossText.Text = 'Boss Hackermans';
bossText.TextColor3 = Color3.fromRGB(242, 242, 242);
bossText.TextSize = 26;
bossText.LayoutOrder = 0;
bossTextCorner.CornerRadius = UDim.new(0, 8);

espBossFrame.BackgroundTransparency = 0;
espBossFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
espBossFrame.BorderSizePixel = 0;
espBossFrame.AnchorPoint = Vector2.new(0, 0);
espBossFrame.Size = UDim2.new(0.5, 0, 0.09, 0);
espBossFrame.LayoutOrder = 1
espBossFrameCorner.CornerRadius = UDim.new(0, 10);

espBossText.BackgroundTransparency = 1;
espBossText.Size = UDim2.new(0.7, 0, 1, 0);
espBossText.Position = UDim2.new(0, 0, 0, 0);
espBossText.Font = Enum.Font.Nunito;
espBossText.Text = 'ESP';
espBossText.TextSize = 26;
espBossText.TextColor3 = Color3.fromRGB(242, 242, 242);

espBossButton.BackgroundTransparency = 0;
espBossButton.BackgroundColor3 = Color3.fromRGB(85, 255, 125);
espBossButton.Size = UDim2.new(0.2, 0, 0.65, 0);
espBossButton.Position = UDim2.new(0.75, 0, 0.2, 0);
espBossButton.Text = '';
espBossButtonCorner.CornerRadius = UDim.new(1, 0);

espBossButtonCircle.BackgroundTransparency = 0;
espBossButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
espBossButtonCircle.Size = UDim2.new(0.313, 0, 0.7, 0);
espBossButtonCircle.Position = UDim2.new(0.55, 0, 0.14, 0);
espBossButtonCircleCorner.CornerRadius = UDim.new(1, 0);

local itemFoundSound = Instance.new('Sound', mainFrame);
itemFoundSound.SoundId = 'rbxassetid://'..sEffect;
itemFoundSound.Volume = 2.5;
itemFoundSound.Looped = false;
itemFoundSound.Name = 'FrgxeUxoMf';

toggleSound.SoundId = 'rbxassetid://'..sEffect2;
toggleSound.Volume = 3;
toggleSound.Looped = false;
toggleSound.Name = 'oVFmYpQWZA';

notifFrame.BackgroundTransparency = 0;
notifFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 36);
notifFrame.AnchorPoint = Vector2.new(0.5, 0.5);
notifFrame.Size = UDim2.new(0.2, 0, 0.1, 0);
notifFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
notifFrame.ClipsDescendants = true;
notifFrame.ZIndex = 3;
notifFrameCorner.CornerRadius = UDim.new(0, 12);

notifFrameListLayout.Padding = UDim.new(0.02, 0);
notifFrameListLayout.FillDirection = Enum.FillDirection.Vertical;
notifFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
notifFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
notifFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;

notifText.BackgroundTransparency = 1;
notifText.AnchorPoint = Vector2.new(0, 0);
notifText.Size = UDim2.new(1, 0, 0.5, 0);
notifText.Font = Enum.Font.Gotham;
notifText.TextSize = 28;
notifText.TextColor3 = Color3.fromRGB(242, 242, 242);
notifText.Text = '';
notifText.LayoutOrder = 0;
notifText.ZIndex = 4;

checkButton.Image = 'rbxassetid://5679803726';
checkButton.BackgroundTransparency = 0;
checkButton.BackgroundColor3 = Color3.fromRGB(0, 255, 125);
checkButton.AnchorPoint = Vector2.new(0, 0);
checkButton.Size = UDim2.new(0.15, 0, 0.35, 0);
checkButton.ImageColor3 = Color3.fromRGB(25, 25, 25);
checkButton.BackgroundTransparency = 0;
checkButton.ScaleType = Enum.ScaleType.Fit;
checkButton.Name = 'checkButton';
checkButton.LayoutOrder = 1;
checkButton.ZIndex = 4;
checkButtonCorner.CornerRadius = UDim.new(0, 8);

notifClick.SoundId = 'rbxassetid://578970639';
notifClick.Volume = 6;
notifClick.Looped = false;
notifClick.Name = 'OaiEWIhlHf';

notif.SoundId = 'rbxassetid://5649595739';
notif.Volume = notifVolume;
notif.Looped = true;
notif.Name = 'MGzEXxhbAt';
notif.Parent = notifFrame;

notifFrame.Size = UDim2.new(0.2, 0, 0, 0);
notifFrame.Visible = false;

function startNotif()
	notifFrame.Visible = true;
	tService:Create(notifFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0.2, 0, 0.1, 0)}):Play();
end

function endNotif()
	tService:Create(notifFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0.2, 0, 0, 0)}):Play();
end

function Ripple(Button, X, Y)
	coroutine.resume(coroutine.create(function()

		Button.ClipsDescendants = true;

		local Circle = rippleCircle:Clone();
		Circle.Parent = Button;
		local NewX = X - Circle.AbsolutePosition.X;
		local NewY = Y - Circle.AbsolutePosition.Y;
		Circle.Position = UDim2.new(0, NewX, 0, NewY);

		local Size = 0;
		if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5;
		elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.Y*1.5;
		elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																																																																														
			Size = Button.AbsoluteSize.X*1.5;
		end

		local Time = 0.5;
		Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quart", Time, false, nil);
		for i=1,10 do
			Circle.ImageTransparency = Circle.ImageTransparency + 0.01;
			wait(Time/10);
		end
		Circle:Destroy();
	end))
end

spawn(function()
	
	for _, checkNPC in pairs(workspace.NPCs:GetDescendants()) do

		if checkNPC:IsA('StringValue') and checkNPC.Name == 'Title' and checkNPC.Value == 'Merchant' then
			ESP(checkNPC.Parent.Parent:FindFirstChild('HumanoidRootPart'), checkNPC.Parent.Parent.Name, Color3.fromRGB(0, 255, 130), 'Merchant');
		end

		if checkNPC:IsA('StringValue') and checkNPC.Name == 'Title' and checkNPC.Value == 'Smuggler' then
			ESP(checkNPC.Parent.Parent:FindFirstChild('HumanoidRootPart'), checkNPC.Parent.Parent.Name, Color3.fromRGB(255, 0, 0), 'Merchant');
		end

	end
	
	if workspace.NPCs:FindFirstChild('The Exiled') then
		ESP(workspace.NPCs['The Exiled'].HumanoidRootPart, 'Exiled', Color3.fromRGB(0, 255, 130), 'Boss');
	end

	if workspace.NPCs:FindFirstChild('Minotaur') then
		ESP(workspace.NPCs.Minotaur.HumanoidRootPart, 'Minotaur', Color3.fromRGB(255, 0, 0), 'Boss');
	end

end)


workspace.NPCs.ChildAdded:Connect(function(newNPC)
	wait(0.5);
	
	for _, checkTitle in pairs(newNPC:GetDescendants()) do

		if checkTitle:IsA('StringValue') and checkTitle.Name == 'Title' and checkTitle.Value == 'Merchant' then
			repeat wait() until checkTitle.Parent.Parent:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('HumanoidRootPart')
			ESP(checkTitle.Parent.Parent:FindFirstChild('HumanoidRootPart'), checkTitle.Parent.Parent.Name, Color3.fromRGB(0, 255, 130), 'Merchant');
		end

		if checkTitle:IsA('StringValue') and checkTitle.Name == 'Title' and checkTitle.Value == 'Smuggler' then
			repeat wait() until checkTitle.Parent.Parent:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('HumanoidRootPart')
			ESP(checkTitle.Parent.Parent:FindFirstChild('HumanoidRootPart'), checkTitle.Parent.Parent.Name, Color3.fromRGB(255, 0, 0), 'Merchant');
		end

	end
	
	if newNPC.Name == 'The Exiled' then
		repeat wait() until workspace.NPCs['The Exiled']:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('HumanoidRootPart')

		notif:Play();

		if notifText.Text == 'Minotaur Spawned' then
			notifText.Text = 'Exiled & Minotaur Spawned';
		else
			notifText.Text = 'Exiled Spawned';
		end

		startNotif()
		ESP(workspace.NPCs['The Exiled']:FindFirstChild('HumanoidRootPart'), 'Exiled', Color3.fromRGB(0, 255, 130), 'Boss');
	end

	if newNPC.Name == 'Minotaur' then
		repeat wait() until workspace.NPCs.Minotaur:FindFirstChild('HumanoidRootPart') and Player.Character:FindFirstChild('HumanoidRootPart')

		notif:Play();

		if notifText.Text == 'Exiled Spawned' then
			notifText.Text = 'Exiled & Minotaur Spawned';
		else
			notifText.Text = 'Minotaur Spawned';
		end

		startNotif()
		ESP(workspace.NPCs.Minotaur:FindFirstChild('HumanoidRootPart'), 'Minotaur', Color3.fromRGB(255, 0, 0), 'Boss');	
	end

end)


function getItems()
	for _, v in pairs(workspace.NPCs[npcNameInput.Text]:GetDescendants()) do
		if v:IsA('StringValue') and v.Parent.Name == 'ShopItems' and v:IsDescendantOf(workspace.NPCs) then
			local realdeal = HttpService:JSONDecode(v.Value);
			local actualItem = realdeal.Name;
			table.insert(items, actualItem);
		end
	end
end

npcNameInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then

		if getgenv().autoCompleteStatus then

			for _, v in pairs(workspace.NPCs:GetChildren()) do
				if (string.sub(string.lower(v.Name),1,string.len(npcNameInput.Text))) == string.lower(npcNameInput.Text) then
					npcNameInput.Text = v.Name;
				end
			end

		end

		spawn(function()
			for i = 1, 0, -0.25 do
				wait();
				npcNameInput.BackgroundTransparency = i;
			end
		end)

		itemList.Text = '';
		items = {};
		wait(0.5);

		if workspace.NPCs:FindFirstChild(npcNameInput.Text) then
			getItems();
			local gotItems = table.concat(items, ", ");
			itemList.Text = gotItems;
			itemFoundSound:Play();
		else
			npcNameInput.Text = 'NPC not found'
		end

	end
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == keyToHide and not gameProcessed then
		if uiToggled then
			sUI.Enabled = not sUI.Enabled;
			uiToggled = not uiToggled;
		else
			sUI.Enabled = not sUI.Enabled;
			uiToggled = not uiToggled;
		end
	end
end)

merchantTab.MouseButton1Click:Connect(function()
	toggleSound:Play();
	Ripple(merchantTab, Mouse.X, Mouse.Y);
	slidesBGPageLayout:JumpTo(firstSlide);
end)

bossTab.MouseButton1Click:Connect(function()
	toggleSound:Play();
	Ripple(bossTab, Mouse.X, Mouse.Y);
	slidesBGPageLayout:JumpTo(secondSlide);
end)

completeButton.MouseButton1Click:Connect(function()

	if getgenv().autoCompleteStatus then
		toggleSound:Play();
		getgenv().autoCompleteStatus = not getgenv().autoCompleteStatus;
		completeButton.BackgroundColor3 = Color3.fromRGB(185, 185, 185);
		local moveLeft = tService:Create(completeButtonCircle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.1, 0, 0.14, 0)});
		moveLeft:Play();
	else
		toggleSound:Play()
		completeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 125);
		getgenv().autoCompleteStatus = not getgenv().autoCompleteStatus;
		local moveRight = tService:Create(completeButtonCircle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.55, 0, 0.14, 0)});
		moveRight:Play();
	end

end)

espMerchantButton.MouseButton1Click:Connect(function()

	if getgenv().merchantESP then
		toggleSound:Play();
		getgenv().merchantESP = not getgenv().merchantESP;
		espMerchantButton.BackgroundColor3 = Color3.fromRGB(185, 185, 185);
		local moveLeft = tService:Create(espMerchantButtonCircle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.1, 0, 0.14, 0)});
		moveLeft:Play();
	else
		toggleSound:Play();
		getgenv().merchantESP = not getgenv().merchantESP;
		espMerchantButton.BackgroundColor3 = Color3.fromRGB(0, 255, 125);
		local moveRight = tService:Create(espMerchantButtonCircle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.55, 0, 0.14, 0)});
		moveRight:Play();
	end
	
end)

espBossButton.MouseButton1Click:Connect(function()
	
	if getgenv().bossESP then
		toggleSound:Play();
		getgenv().bossESP = not getgenv().bossESP;
		espBossButton.BackgroundColor3 = Color3.fromRGB(185, 185, 185);
		local moveLeft = tService:Create(espBossButtonCircle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.1, 0, 0.14, 0)});
		moveLeft:Play();
	else
		toggleSound:Play();
		getgenv().bossESP = not getgenv().bossESP;
		espBossButton.BackgroundColor3 = Color3.fromRGB(0, 255, 125);
		local moveRight = tService:Create(espBossButtonCircle, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {Position = UDim2.new(0.55, 0, 0.14, 0)});
		moveRight:Play();
	end
	
end)
checkButton.MouseButton1Click:Connect(function()
	notifClick:Play();
	endNotif();
	notifText.Text = '';
	notif:Stop();
	wait(.8);
	notifFrame.Visible = false;
end)