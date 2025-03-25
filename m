Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFD2040A7;
	Tue, 25 Mar 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888368; cv=fail; b=K3kJMoGnO2hKUI3Y/FUBFTFFa/EJ9F/Zfxa8yMEdZD8hV6c63K3uar8lrUfc5HU6hkSQ++O8Dd0hgHI6cXJUGEDg/Wg1Qnq2dRGvYFYp1In5beI4a72rKOu84rs61Xm9icBuDqQsjVhLimkBpprGdpnj01ZdmMEuO1ga+ZL3JfQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888368; c=relaxed/simple;
	bh=w4qxrlVtfikVUuuluANPxypZmqhtxb0KFDOt7E4Af9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X99k1ls5pWUFotNvRb/O+RNc1Ls7GxP2Q+5Ocw4/8uDcx/bkFGVSdQjXwS7qjKx9iez6QMCK4C4U3y8F1syHh8APLxhBxRHLiBGHBgdaqemFr3g4a5pVbq7Fvy9oMYv8yK6lspPoLf8AsnUHvIl9zdf3/ZVJ1n04YL83cs/9+54=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PQh90Bl8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PQh90Bl8; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PQh90Bl8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PQh90Bl8"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LyN9pNyHHMM/99POAMFNQS23P0PX0I1e5Op023v0/izJoal1Vce3WLQUxejeGvXPa81+b7LzyheLFDFi/FmQNY/dw5NpOXTXBzWQfspAd/f6pOs7qvlJUTYob+3vgI5MZEn3aN+Q8eD31wOhfKda8Aj1xgMU1rKvAGMF/tydC56bSUNURBPYehgw2lc6GZbcIMk9+rH3shcz9na32i30HLItj4LNBi3RJdjbhvl339b2S6pUtuN6KB91ZmVsSmgylzh3FcmYctGOamZZC5OZfIMP/3ER1YPCipN/PFo7kE7h0mmfvbKyFIsQjTSL0iF2/Xr7lcMNXR1Q68a9kRQEtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y9xepnarh+S14kpLGFGZTfzmOAJWoJrLrrh2Jf5aZM=;
 b=e4XINcqKy/cmXkArj/nlIbcJkvgeGlBg+51JM02NAGPIY53yMr6pXo7PUaV9sMdJPa3LH6jNanq0+wOU+tdDkUw56P43qNIdMTQqjUlkqNfz3s8PKiHZcetR8yvgHnyVpnUthZQ21djgtvlwhlXxs/a8EMKPAtsh54dw+GkhBJprnIMdJHeeEYCkNsFk/WEorDSQCDpIHAuiGU8/rUWI/GFmKHyYMoQnYoc7unMew/SGQFY5HLy97Aa+5WS+0opuVEZtAINTXRBVL8jg8f55vzrgOg0C+eB6I3WqXlTVN8egBUaNWFmq5SXM6sp55JsITVg6vvbbDM5O0UAPMy0S9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y9xepnarh+S14kpLGFGZTfzmOAJWoJrLrrh2Jf5aZM=;
 b=PQh90Bl8tVZd+EdYs+qcnDkeOzgu5iUkCBeq9DkC0qqP6iPqvlQOXxmxVj8/+A+2heKn7ZEjh41hm22XxZiSR0tdOvlZkmRA89TyjnX3rwqAjawUVAXg2dD7dq7hea3OPoEHEp3K/Ty2XQEnvCyK/K+5kJVMJ21QDGFqIMwTZ8I=
Received: from AM0PR02CA0015.eurprd02.prod.outlook.com (2603:10a6:208:3e::28)
 by DU0PR08MB9347.eurprd08.prod.outlook.com (2603:10a6:10:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:39:20 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:208:3e:cafe::eb) by AM0PR02CA0015.outlook.office365.com
 (2603:10a6:208:3e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 07:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Tue, 25 Mar 2025 07:39:20 +0000
Received: ("Tessian outbound 42ac64abf51c:v601"); Tue, 25 Mar 2025 07:39:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0e352d6e83731803
X-TessianGatewayMetadata: b26J6uHqu/UOOQuc3deKUtr1ZkgTQkfxfwjlEuy1J+oAWiRqKZIgFtsJGPPKizxnKYphX8TauBy38Oo1roqsocxZlH9xgQ4MKakiOT7dvU/OdHiNKnbLoPGhF3/r+tf8yFTPRtQ2ACbr1IHp7LGE6A==
X-CR-MTA-TID: 64aa7808
Received: from L23000e15d892.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6C2C6ADF-DA43-4E92-BE92-B77ADBED77ED.1;
	Tue, 25 Mar 2025 07:39:09 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L23000e15d892.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Tue, 25 Mar 2025 07:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZWY2TDcrAciVSJ1hu/s7PK6YcLTAmqbVVpgukQgCrbvqSIyLwQ5ZmLsbGBWvPf9WTD7LonwBzG8N+omyrkqucQrrhFkxQaQ0F5Q4OsKUv4AtR2a2Bp+ZmCBGu1iuo7hcf8mlNzTlgR79LMvVJUaS9NjCFyXuzCKn00Qx0wG8JsjJB475ZzbvoJw9bFdBl9TgFnZuKmUy8E83OVsWSO4cUCXqiZ/KTtC9b9thIBF2mMHkvOI1FJBWzprHy91kVHJy+QUGOqRYpJGmSnOVo7mjX6b8aTnmUrDangRJtz3vPC/rq2A1cUCBnQQz8B7ThrQQy/FEhCKNCcIRnWcTuj1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y9xepnarh+S14kpLGFGZTfzmOAJWoJrLrrh2Jf5aZM=;
 b=lfNAr6CF01AWjXbm7JCxwPaYO6RUTkJkAoAqyuPKNhirsJ1vb0nuT1BFkPHYCloT3xASclrH2GKM0gqQM63FmTga1+QCCKbq018Jsdj8P8dok3kxGdDyIW3Prh2jMwFPIFpRzYtCP4olMvOb2WaJ021u8BZQ7ERM1+nCVjC57tw/VKpBj0vfzmdaHjVL0v3pCxGWi82o1C7jOtqzzH90I95UZS/j+6YfL1ufh1wm9PNf+mamojlVKtgPDgkPmI29jzIceJi0FToeOxcK3kBCkBre61E6T1fd0PwGUI+ZEKIVcO4zvzAUtYMqWHld257k3q0ylJOTZXUUmXZyRfc+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y9xepnarh+S14kpLGFGZTfzmOAJWoJrLrrh2Jf5aZM=;
 b=PQh90Bl8tVZd+EdYs+qcnDkeOzgu5iUkCBeq9DkC0qqP6iPqvlQOXxmxVj8/+A+2heKn7ZEjh41hm22XxZiSR0tdOvlZkmRA89TyjnX3rwqAjawUVAXg2dD7dq7hea3OPoEHEp3K/Ty2XQEnvCyK/K+5kJVMJ21QDGFqIMwTZ8I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBBPR08MB5931.eurprd08.prod.outlook.com
 (2603:10a6:10:1f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:39:06 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:39:05 +0000
Date: Tue, 25 Mar 2025 07:39:03 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: mingo@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, Mark.Rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Message-ID: <Z+Jdl99Y2EpDHciK@e129823.arm.com>
References: <20250306123350.1650114-1-yeoreum.yun@arm.com>
 <20250324194758.GB604566@e132581.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324194758.GB604566@e132581.arm.com>
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBBPR08MB5931:EE_|AM3PEPF0000A792:EE_|DU0PR08MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 655118c6-c5c2-49a8-a6d2-08dd6b7027ce
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?MItRyNS5tq+/JVWJ/2dzQBMW4VNw+Jm2knaIyl04oKV/aI2NSnZv4MqYHwDs?=
 =?us-ascii?Q?f6ymcW1KVB78wIyUf6wSTWE4+PYa0JkcSNEUXjDyMUgI8LTxhYRJ2uEBFeBS?=
 =?us-ascii?Q?mMy7F1uA/Qv+K5n0hsjG2fcZ1+bJqOvComTcV8TN9uFmMiMOhQcQf66GOWW3?=
 =?us-ascii?Q?1JtU9Tk5m7tkrY7TfI3WXLTONIrjSQUp8mPq6PRJcXbIYn6TxIj0z/EBLSw6?=
 =?us-ascii?Q?seJc3x9HyNhhIwyQe6lf8pW6SpKS22hRimekFJmD+darFjp0R+fZa+PMKQid?=
 =?us-ascii?Q?LLAFEdlFKcr/7YzSYx7mt3Z3GiYRilmsaaau0PxzxjjAe/GVR7nHOgNU5cHF?=
 =?us-ascii?Q?vpUozHi0TSNBoPQ1PNhpx+dqnJdsDwfBoSvyFPkX8WDkIGeOQ7fEXhSOBAU0?=
 =?us-ascii?Q?XWmJCDvuhFXaaVbees4LUgG48479Dr3y/eh122o3U9/ag77Om6+PPfEYOFZX?=
 =?us-ascii?Q?zpc3C3GNnH+cpDvJLZM1F0KNSsidmNqebZ6E1uwgv5vOrQOVbK0rFZiKCl5T?=
 =?us-ascii?Q?lg+rxcQ3r4HFYmj1vxFWZuBP8xsj7gfqJp3k1Yh6Jb8hBgxPxOIaTzkQY73z?=
 =?us-ascii?Q?W8qy/rC9mUsDY+jnjCmWs1Y5QyXAQWJBYPwC6HqZtOc58d3pinarrNc+dqba?=
 =?us-ascii?Q?KVYF4+tpB5Vo0yiK6meC7vhgJ8uHcFDKLEFl6lKlfHxgA6CDcHGI+FzO+mcP?=
 =?us-ascii?Q?tuLCY5RZUgAC6Cw60X5r1MygRJvQV02J/vGlOqTaqbgaeERJGGy1iL7A/Sil?=
 =?us-ascii?Q?5hMZfGxscqkF+Sy9gh8gIL9YMgPd1+C9f58npo2khakEx/bwTfYN3D8q2d0g?=
 =?us-ascii?Q?FC/YQ2vEDyE/DUhNoGjBSioQJPD5JxgDk68cfD+hC1Xq7ZwSMko1FNCR+t5P?=
 =?us-ascii?Q?vtopgYBjTzstK47AsD4IW9Ot63burdfipwpztm5YI7knT0xC+r3ZL/6+St23?=
 =?us-ascii?Q?JGI1G/kQNH8MQP1Gaa0iLTrup09je8E1q0/5bfsTH3N5UlirU2NBeA4cE4bz?=
 =?us-ascii?Q?y4/pn+YgR0GkdCcEAIAQhV5t6N69KruYZv7jcV8a7+DRc+dzAUglyWnlyrfP?=
 =?us-ascii?Q?zDr1TDxkWBstqEoaL6Ze+XPBwK3Lgnv2SPd5xMW+Lgt39JLsdlNE3l4SQ98s?=
 =?us-ascii?Q?OTjYg1b8sJS402etcrMsrf4KT00NbO38WPjW598VabNEdMvp1Gb4imEYLtr1?=
 =?us-ascii?Q?q+eS0qpgVu/KNLviptvv7mI2kxN2Ps480Z3AaQmiib6MSTrfWzuBUx79gnDc?=
 =?us-ascii?Q?4ohB+Urf7cTPu7Kl5tN4vQn2wRHhcRRNH6bkkzhcrtv7orISFR0ZETVKLi9h?=
 =?us-ascii?Q?oJmAvlNf9DVwDNvj+kLE7Vo6t7ssn9cEZMA5UeO4rki1rq+k3rYHbQqCN0+z?=
 =?us-ascii?Q?VQ3dLk4DumKAnNZURdwbNVe6IrFR?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5931
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	284c91bd-3553-491f-4b1f-08dd6b701efb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oLKx68lXaL7QJDqwuLO+F9S8z56y2KekWthQtI+dn26RuUcuatIxiITz+Ut6?=
 =?us-ascii?Q?/xTXrijYcoSKWsqrVwLoZGvtHuEx9P3O2f2tAZwWoJwrMDJw40va0VBiraXr?=
 =?us-ascii?Q?at0Kcp9P9VKKkzxo5MEaa92e7BPUL8QnVSMfU97Bd+E50zkmIFiB+veXVmNH?=
 =?us-ascii?Q?Wba/cdVHw9bks2k9Z3eN7TTNjgXZK+4LEYt2mXLfHqiK8zkxqSTwniDceCgI?=
 =?us-ascii?Q?N1OlE5p5diqcpan9a7urw5soXPICzPT7e3C320Xgji66CAm8JOKnlaEpdyo+?=
 =?us-ascii?Q?bQlxSe/uNZeINDaBUyq5L76zaB/bbC/EdJcpyM2mswcwx5NnEZTXia5DsHeP?=
 =?us-ascii?Q?TO/cDonk1R0taxQ2StUu+2DOZL029O+4uJjvoJuX91LdNF1zggtKYomJsLvs?=
 =?us-ascii?Q?kIoZmwc2h3syKj+uK6z2uoA2HouDw1e1oIyGgywo9pgoxMVGBEzyWQV+Uqtk?=
 =?us-ascii?Q?1Qcqj+T9h/U01VUhc7VlbnaBW0ayQlhRKoojzPSDAe+JIrrloHdEr01zINvM?=
 =?us-ascii?Q?YG/Y9DspUzIPrQ2n8kwEZZQK0U9W5oy5LB4tuGqApzzmBSS35RcG8l7Zif3Z?=
 =?us-ascii?Q?KRHnM0JWyI7Q/oSWs7ffuLTiSrH2kO1xNhOB/LgKzTxCba/z+Y/StFzNpHvi?=
 =?us-ascii?Q?/st6ZOExt2m6u7sI3aZy7FyZBoe0HkCmlZBmeFiHMkvkJsfVr8oH3uLtjOfC?=
 =?us-ascii?Q?6kDufhzMX5bK/t96cptckvVQDbUqi7GeFWr3x/WqtaFEkIJGGplVgCGNmwbq?=
 =?us-ascii?Q?k6tLKSngdKbdVjx8UbRRTbuVkqf3/aj5T3HcqfdpO6VRniEAozRqrBdfBqrT?=
 =?us-ascii?Q?OdvoAdRJOpE/NkXeN/fgg6rkvNOheqxhZWxSclXb2Ckgctc4Z1LFQhPHRKox?=
 =?us-ascii?Q?3VjEg5c1glFeV83TXXyFs9IZeDHj2F9D2N3H2PNmW+xn4sylnafHF7XBLpwP?=
 =?us-ascii?Q?zRB7IZP9RBxOXYKNgJ5ZV9H42S+BYFUH3bUKzYwnE1V3aGwktdvAVOnj1eW4?=
 =?us-ascii?Q?5Oh2pabG6vizTlMlrfMFwWsltGMawSIbx7vCQ3qFL7Psz+0s6tOyizWM7/ax?=
 =?us-ascii?Q?6FblwJIYw9b3blx6HW4BduKmluS+m+qkMjR45HhFpJMYIW/TMUO03DnEtTjF?=
 =?us-ascii?Q?pAn23rdghuqBf2MsFh49Wqst1ABTqhUOt4rBpHyVchlAJsWDOqibH2xMg8WD?=
 =?us-ascii?Q?GAIgZu1rripgsWCg8ymizpCtjH5MWd0xRfD9kYLOhKlamRtbB1vaIY0o9V7T?=
 =?us-ascii?Q?Sodatafc9FHnQmslL3TRzvzLBstdchxzEKI1fgDib6A5e2JNaa2KG5nvZkOr?=
 =?us-ascii?Q?ggVhzQ/PUYp//bz8JLzFypcFscjneoW8RU0K+xTE1b8sXJoN47nxj35Ca3sZ?=
 =?us-ascii?Q?GRuvY05TL83NYuBfnNvd4VjQw0DOGqEe8uknekYH+vQMZs2uo1TO4/gQ82pF?=
 =?us-ascii?Q?sq5TmG7Kf29kWexY/rQhVSjSuaZh+o34u4nHKECazxuVb5r9HgK2lCsLmsEe?=
 =?us-ascii?Q?D1rTkq8yY7cJ6fk=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:39:20.3904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655118c6-c5c2-49a8-a6d2-08dd6b7027ce
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9347

Hi Leo,

> Hi Levi,
>
> I tested this patch and it works for me.

Thanks ;)

>
> I would suggestion to improve a bit commit log for easier understanding.
> And a minor comment for the code, otherwise, LGTM.
>
> On Thu, Mar 06, 2025 at 12:33:50PM +0000, Yeoreum Yun wrote:
> > The perf core code fails to account for total_enable_time of event
> > when its state is inactive.
> >
> > Here is the error case for failure to account for total_enable_time for
> > core event:
>
> Here is a failure case for accouting total_enable_time for CPU PMU
> events:
>
> > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> > ...
> >
> > /*
> >  * three number represetns each
> >  *   scaled count / total_enable_time / total_total_running_time
> >  */
> > armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> >                                       ^^^^^^^^^^
> > armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
> >                                       ^^^^^^^^^^
>
> You could use below syntax like:
>
>   armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
>   armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
>                               `          `          `> child_total_time_running
>                                `          `> child_total_time_enabled
>                                 `> child_count
> >
> >  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> >
> >      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
> >      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
> >
> > Since above two events are belong to the same task context and
> > mutually-exclusive per cpu (they couldn't be active at the same time on the same cpu),
> > the total_enable_time should be the same (marked with ^^^^^^^^^^^)
> > and the summation of ratio should be 100%.
>
> The two events above are opened on two different CPU PMUs, for example,
> each event is opened for a cluster in an Arm big.LITTLE system, they
> will never run on the same CPU.  In theory, the total enabled time should
> be same for both events, as two events are opened and closed together.
>
> > This account failure of total_enable_time because of
> > account failure of child_total_enable_time of child event when
> > child task exit.
>
> As the result show, the two events' child total enabled time are
> different (2289429840 vs 1950025700).  This is because child events
> are not accounted properly if a event is INACTIVE state when the
> task exits.
>
> > Below table explains how the child_total_enable_time is failed to account at
> > exiting child task which switch cpus as time passes by (CPU0 -> CPU1 -> CPU0)
> >
> >  - in means sched_in.
> >  - out means sched_out.
> >  - exit means at the exit of child task.
> >    NOTE: the value is before calling list_del_event(). which mean
> >          the value at exit column will be added at parent event's
> >           child_total_enable_time when child task exit.
> >  - ctx is the child_task_ctx,
> >  - e0 is the child_event which set with cpu == -1 and opened with pmu0 only
> >    added in CPU0,
> >  - e1 is the child_event which set with cpu == -1 and opened with pmu1 only
> >    added in CPU1,
> >  - e0 and e1 belongs to same child_task_ctx.
> >
> >           CPU0 (run t1)        CPU1 (run t2)          CPU0 (run t3)
> >           |  in | out |       | in  | out     |       | in      | exit        |
> > ------------------------------------------------------------------------------
> > ctx->time |  0  | t1  |       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2 + t3|
> > ------------------------------------------------------------------------------
> > e0->ena   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t2 + t3|
> > ------------------------------------------------------------------------------
> > e0->run   |  0  | t1  |       | t1  | t1     *|       | t1      | t1 + t3     |
> > ------------------------------------------------------------------------------
> > e1->ena   |  0  | 0  *|       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2    X|
> > ------------------------------------------------------------------------------
> > e1->run   |  0  | 0  *|       | 0   | t2      |       | t2      | t2         X|
> > ------------------------------------------------------------------------------
> >
> > The value marked with * means it doesn't updates since event->state was
> > INACTIVE.
> >
> > Please see the last CPU0's column with exit (marked with X).
> > Since e1's state is INACTIVE its total_enable_time doesn't update
> > and it remains with former value without accounting t3 time.
> >
> > In this situation, at __perf_remove_from_context() while exit child_task,
> > sync_child_event() where adds child_event's total_enable_time to
> > parent event's child_total_enable_time in perf_child_detach() is called
> > before list_del_event() in which event time is updated by setting
> > the event state as OFF.
>
> In this case, the call sequence is:
>
>   perf_event_exit_event()
>     `> perf_remove_from_context()
>          `> __perf_remove_from_context()
>               `> perf_child_detach()   -> Accumulate child_total_time_enabled
>               `> list_del_event()      -> Update child event's time
>
> The problem is the time accumulation happens prior to child event's time
> updating.  Thus, it misses to account the last period's time when event
> exits.
>
> > That means child_total_enable_time is added with missing
> > amount of last enable time -- t3.
> >
> > In case of parent event's total_enable_time is updated properly in
> > list_del_event() when the task exit.
> > However, the child_total_enable_time is missed when child_task exited,
> > the perf prints error amount of enable_time (which is summation of
> > total_enable_time + child_total_enable_time).
> >
> > To address this, update event state via perf_event_state() in
> > __perf_remove_from_context() and call it before perf_child_detach()
> > where parent's total_enable_time is updated.
> >
>
> The perf core layer follows the rule that timekeeping is tied to state
> change.  To address the issue, invokes perf_event_state() for updating
> state alongside with accouting the time.  Then, perf_child_detach()
> populates the time into parent's time metrics.
>
> > After this patch, this problem is gone like:
> >
> > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
> > ...
> > armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
> > armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940
> >
> >  Performance counter stats for 'stress-ng --pthread=2 -t 10s':
> >
> >     15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
> >     22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > Suggsted-by: Peter Zijlstra <peterz@infradead.org>
>
> /Suggsted-by/Suggested-by/

Thanks ;) I'll respin.

> > ---
> >  kernel/events/core.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 6364319e2f88..058533a50493 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2407,6 +2407,7 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
> >  #define DETACH_GROUP	0x01UL
> >  #define DETACH_CHILD	0x02UL
> >  #define DETACH_DEAD	0x04UL
> > +#define DETACH_EXIT	0x08UL
> >
> >  /*
> >   * Cross CPU call to remove a performance event
> > @@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
> >  			   void *info)
> >  {
> >  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> > +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
> >  	unsigned long flags = (unsigned long)info;
> >
> >  	ctx_time_update(cpuctx, ctx);
> > @@ -2429,16 +2431,19 @@ __perf_remove_from_context(struct perf_event *event,
> >  	 * Ensure event_sched_out() switches to OFF, at the very least
> >  	 * this avoids raising perf_pending_task() at this time.
> >  	 */
> > -	if (flags & DETACH_DEAD)
> > +	if (flags & DETACH_EXIT)
> > +		state = PERF_EVENT_STATE_EXIT;
> > +	if (flags & DETACH_DEAD) {
> >  		event->pending_disable = 1;
> > +		state = PERF_EVENT_STATE_DEAD;
> > +	}
> >  	event_sched_out(event, ctx);
> > +	perf_event_set_state(event, min(event->state, state));
>
> Nitpick: can we move perf_event_set_state() before event_sched_out()?
>
> So the function handles the state machine ahead, then proceed for
> other operations.

No It couldn't. IIUC, event_sched_out() disable pmu with ACTIVE state
event only.
If state is changed first from active state, it wouldn't be sched out by
event_sched_out.


Thanks

>
> >  	if (flags & DETACH_GROUP)
> >  		perf_group_detach(event);
> >  	if (flags & DETACH_CHILD)
> >  		perf_child_detach(event);
> >  	list_del_event(event, ctx);
> > -	if (flags & DETACH_DEAD)
> > -		event->state = PERF_EVENT_STATE_DEAD;
> >
> >  	if (!pmu_ctx->nr_events) {
> >  		pmu_ctx->rotate_necessary = 0;
> > @@ -13424,12 +13429,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> >  		mutex_lock(&parent_event->child_mutex);
> >  	}
> >
> > -	perf_remove_from_context(event, detach_flags);
> > -
> > -	raw_spin_lock_irq(&ctx->lock);
> > -	if (event->state > PERF_EVENT_STATE_EXIT)
> > -		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
> > -	raw_spin_unlock_irq(&ctx->lock);
> > +	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
> >
> >  	/*
> >  	 * Child events can be freed.
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
