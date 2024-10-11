Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA81CDA31;
	Fri, 11 Oct 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633748; cv=fail; b=AFBMHFPT3Oyi3praFzxET5FcuzZqzQZTaEXt+oKjKs0532UAwl8xQcY4ys+nU5UFlDwtwdBW1s8QueZ29U+dtyw0T1Voc3Y/WElcSY4xE9Xg1dfkNmd3gtyXDfSZEopneAzZWnjY3nCv4J8Nou3ttqfKgj0SYwA7HWiNdfdI4G8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633748; c=relaxed/simple;
	bh=0lmWkfMU8UWfRLrPJpIzs4NcR7XikJ+wWdOy2Aob8tY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+jDmZ0ZhbfY9zMUCo8yrbs4S3s9ccpxXSi7YdxfkLaRIArMOvka00H+k0DEMgZj61tq6L8i2spZHkkpIZf9sC+dJpVdnkFRHFVYjCY6FQxFWnNQvKDF7flJfNAxdSKpj10nATU04rwcar4L98f8JYyPfIentG+uOCFSI2oSx2I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EJaft/+o; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EJaft/+o; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EJaft/+o";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EJaft/+o"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CBsMovHB6zKyUF4cuDfTC1nZe5I7gtfOq2xsbLknSI2dLzYigqgz3uFGaYzQ6ATqVZfQghgNGAoQjI6cFQ7O2wcJvBtnpXJdvEO0DCd3wd1NJbGaLZm3/+i/WVIG3kX/N1CuGirLcNfTk7cG8oxQwWi/b6fWUNk/6xPADenWk7oM7gBway/HvIsde49eZDozJCZ/0ACdEfrRy88PC9EIYnZ+euKHBV84jEg0oaFrNnBW0m/yuS/tSUQufeOEWPueLQOvNm6szTxs98Upy/e/BuwhSVwIpx5T/bmHc2oxv3VDJq+VoxXI38zjO80YLde3SMdUFdduezFgXRrPgO1EWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lmWkfMU8UWfRLrPJpIzs4NcR7XikJ+wWdOy2Aob8tY=;
 b=icqczsJ6i6/0Aep+3mMEnPm4cdNsyvhsjm/uMIL4UPrKiVqlfeMrvmbXfwPrkWrapt1uyy6zPcu4lOftxI4dxQT9+Isrn8+TeHyQTOIa4K8lVO1pb2FUlcfFAQo2z0vadT6KFAKJaa1PTbK/YLIGzpGgrfJtXo7yle17d9uRcoytQ8JmC8YpU9G8IjQUfwkN37ULF/jVRyEubuWb5kKeTjqoliQ0ThEPugnogpHZxpPqCcGe1jWPYVPH2HXvAsb/IYIv2pRQCp4pGPmHD39i1403zKJKfGVk/nIATvv5iyMaEJx+q/A5k3+F0JQVfRUaZYCrLJMA3QaVRDkjeKRELg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lmWkfMU8UWfRLrPJpIzs4NcR7XikJ+wWdOy2Aob8tY=;
 b=EJaft/+oxKPbhjIgPYuJkaLEQFGnqrVgRClvSQDojJ0GynefRO9ILHybrErkXd6PfBJmrw24f/D7yQARtPp0dNO8+hah182ImQmtZvSi3swslDgrnvKBd18P+FvbCmv27j00k1EoSWyPqwGXsaoVuS4XWs8//Qr8M9TtES7nQyw=
Received: from DU2PR04CA0295.eurprd04.prod.outlook.com (2603:10a6:10:28c::30)
 by DU5PR08MB10577.eurprd08.prod.outlook.com (2603:10a6:10:51a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 08:02:18 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::2f) by DU2PR04CA0295.outlook.office365.com
 (2603:10a6:10:28c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Fri, 11 Oct 2024 08:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8048.13
 via Frontend Transport; Fri, 11 Oct 2024 08:02:16 +0000
Received: ("Tessian outbound 40ef283ec771:v473"); Fri, 11 Oct 2024 08:02:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b75e48a13b02e37b
X-TessianGatewayMetadata: gMOzRW+uBz1sFrcV+isb5TAd6qQkbWDmcTF6JhHNVzaiJWr3tJOgx5z6LgO7uEa67uNkRCafjFJtK6HEjIKJfxWq8nRbTbGQ6T56Yo4m/CttFMQWSwxNdAvVgU61zOM408cEZynzaJOViDxyG3789J9Wkozf0ObevS2nge3ViIzPqfgwtji5T4GiF+3IZzwB
X-CR-MTA-TID: 64aa7808
Received: from L91c89d5a3d31.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 25E8ECF8-97AE-4683-A92A-89A98C7F18E2.1;
	Fri, 11 Oct 2024 08:02:09 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L91c89d5a3d31.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2024 08:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzLOIrHfMcAIFayahIORnXTd6XdvGq2ce+pw6JcxpljFZJpESVP2zi+vxRiMMbb6tKvipUv3L0HV1wbsFbAjwSXDiL/gtFaYcdJT3b9KlpxhLO3X4NC5yred+Je50qfGdfuYJu0m52AomG11ovYlDnbOrk0vc6VUdS6c8HVtkeQOe9kYFV/yHJ+1y3UjS2wgjq8FqbesLZE9kkQ7CGd0jGWkxvcZO0viK38EXwEccCb7RPpxxhag0MB6zHa5V+59WpT5yOw23UI0WiaI2CsioJcC5yxGd/zq+hRChuA6qA4Gjl5Izg+LKzdMVMUrGU/lWMCvO701FFEDA86komVbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lmWkfMU8UWfRLrPJpIzs4NcR7XikJ+wWdOy2Aob8tY=;
 b=gB6neg9g3JF5clSbO6JLMBDSMcfD6e++Vd+TtpON1z8Kn5iIPs37uT12WEvnFvSUlSbCFaM4imV33g+R5BFtUu0wAfw519RoBt06ae9pqN4cGnHb+WGZ4qVLdljzUwPNxnFxXuRe5tr+Mr0M/219+uTaFWvaADPmKq9BC1g3KoGPfkNYd+6CWg3TBTDu+XmXOStNg3v+luj3WR8OkVUWDa7kfmAylN/7gX4Jeyjndf+x5c4Yc77Q9mdIBJtJ0LhzFTB6r56ud+3XyOqJHkk1fexkrdgLbsWHSQjC6/+9wCvzd3h1QBPlJIEjFngqutbqKb4DFnkshoE2nDS0LyXTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lmWkfMU8UWfRLrPJpIzs4NcR7XikJ+wWdOy2Aob8tY=;
 b=EJaft/+oxKPbhjIgPYuJkaLEQFGnqrVgRClvSQDojJ0GynefRO9ILHybrErkXd6PfBJmrw24f/D7yQARtPp0dNO8+hah182ImQmtZvSi3swslDgrnvKBd18P+FvbCmv27j00k1EoSWyPqwGXsaoVuS4XWs8//Qr8M9TtES7nQyw=
Received: from DU0PR08MB9486.eurprd08.prod.outlook.com (2603:10a6:10:42d::21)
 by VI0PR08MB11081.eurprd08.prod.outlook.com (2603:10a6:800:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 08:02:04 +0000
Received: from DU0PR08MB9486.eurprd08.prod.outlook.com
 ([fe80::814b:b5cd:2cf1:554c]) by DU0PR08MB9486.eurprd08.prod.outlook.com
 ([fe80::814b:b5cd:2cf1:554c%6]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 08:02:04 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "acme@kernel.org"
	<acme@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "jolsa@kernel.org" <jolsa@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH] perf evsel: Fix missing inherit + sample read check
Thread-Topic: [PATCH] perf evsel: Fix missing inherit + sample read check
Thread-Index: AQHbGhOtKNh/V83HGkq038YD2Rf4BrKBM4+A
Date: Fri, 11 Oct 2024 08:02:04 +0000
Message-ID: <7ced2109944c4aa773804a2d25854974b76d8fb6.camel@arm.com>
References: <20241009062250.730192-1-namhyung@kernel.org>
In-Reply-To: <20241009062250.730192-1-namhyung@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.0 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DU0PR08MB9486:EE_|VI0PR08MB11081:EE_|DU2PEPF00028D09:EE_|DU5PR08MB10577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0122879b-1024-44e4-7082-08dce9cb05ed
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U0RzcDZEMlYxWjM4cHh5TXB1MG55d21BVllMeGZoL2I3Q3hLcWdZN3IzUnFJ?=
 =?utf-8?B?cjVDMmtGVmpJdndpcG9jSFI0U3RhWnZGWVo3blp6TDlZZW8zLzBHVHdFTFdv?=
 =?utf-8?B?WU5LMmdWM0V2U0JvY0xWcW1Fd3V1MDlGV1BqNmtXOHJ6TXlUY3kwVkd5UnY2?=
 =?utf-8?B?YTJxajNZaTBQL2gxbmVtQ051Y3hmYTY4TjJsZ25pWmR2SGhicmd0ck5kQUFk?=
 =?utf-8?B?eU9jVko5N04ybHNwME5EVVhpWThaN3NiV3pKaEc3cXJVRkI2ei9rbWFWeDFq?=
 =?utf-8?B?RFlNWTNiUS85a0lkMVVIMG0veS9kaWY2VWh0dkpwMW1EdUxBTXVYWHdqRVBD?=
 =?utf-8?B?cldNZzY1ZGQ1QW4xYk9VMmpzVC9ZKytsbEhNNTIwVW1HU1JtblZpOThKSE5k?=
 =?utf-8?B?Q1Vpeko4UStIZWk5ME9MM1U1bnk4cHQ0M2IvSXk0cGw5dFA2djNrTUJNZk5a?=
 =?utf-8?B?WWZuTjQ4WnJYbzhad3dzVTFmV2FLMVhiZ25lWjJwVjBSclFPdFhoemhyM292?=
 =?utf-8?B?SkduWVFTWGYvd1RaY01DNExWczFObjR6Mlp2TFh0eGFBNzNCcm1CbThOb1Rp?=
 =?utf-8?B?YTZUUFNpMEhTZERsSDZ4MUVEaFlEbGpKdjRzWkZqZGhUZTM1M2hvWFBNYlNU?=
 =?utf-8?B?UWM5TG1vaWhvQ2wvNEpHSlFnbmorb2lXbjBPS3RjbExpSG5EZDZLYUZlVnpX?=
 =?utf-8?B?MGdWWGVVbHRORWsyRFV5MG5EcVVZS1hJNVg1Y3pSNC9DN0tTTm5abndBM0Zu?=
 =?utf-8?B?VS9QTTNHZENJb1RuaGNibXJzUmFuTEE0d2R5K01ZTTI4LzV4NkNNclNXUkxl?=
 =?utf-8?B?bVNXWUI2S2ZNR1N1M2gyMGdudFg4dDd2UU1wNTBuTnpCT1RoOUQ1UGpRVEp4?=
 =?utf-8?B?QmtrMGZ4bTQ4K2hwV0hWTjZwZVBkTG1CMnJqajlzWGFJZTlEWmxKZWVRYzJD?=
 =?utf-8?B?MzMzMWNldDFOT1NrWlViUjF5WW56WVFWOERWYUYyWVFINFFoYm1YS3dTMC9B?=
 =?utf-8?B?ZHdWaW44dGlZc3RxTWhXK1I1cHNUZlR2TzgyWFlDTXRreUFISGQ1d2w3bWpF?=
 =?utf-8?B?cTZ6L1ZBY1phNUloM0luVW1uWFBFMmlOM00yaXVWcXdTdTRPeHZScFk4RWtk?=
 =?utf-8?B?ekxNNkU3M3B6aDl3NU9jc2JtYWdhT2VwMURZclRZM1VvMVNpRGhJQ0VOKytU?=
 =?utf-8?B?Z1daakRMYXc1c2VHMTdCai9WUU0zRWo0dkZJbWtHTkRiczFmaXd4WE9CRSty?=
 =?utf-8?B?UUxvbW9EdjJxRFlVN2FQVE1Ja1VrcFdxRURiSHJOeXhhTjlETFZkN2MvbWxQ?=
 =?utf-8?B?Sy9DNjJVWVVPVEJRc2RlTFhCUDlyZ3JBalV4RzZ2Ny9mSitsckMrem1WRFpP?=
 =?utf-8?B?NXBhMmFNWlc5VFBMR3BTTHpoN20wKy9LSndtUXV6OTh2RU9aQmJPTXNwaTVY?=
 =?utf-8?B?SkU4RnVkajJlYmxpSFVYeGEwcGMzMDZ5UEVKQzJIRmZmYWZsV2gvZHY3eGNl?=
 =?utf-8?B?SVg4ekNsSFZOcjBmc0NHams1aGtqMDNVR0p4K3hXdk9DT2JYbEk5V3pJNVV3?=
 =?utf-8?B?b2JNWGZtUUlhQlRqY0UwMks0UGJoK3h4UVFvWTV2MHdjRHVITU1MNFlqVWx0?=
 =?utf-8?B?WHJXcGlsc1ZFbnMrWHhmTUM0bGI3bkxRNEVOQjhWSDFzYWZOME5WYS9xU0k3?=
 =?utf-8?B?Zm5QTy9LUzNrMWpRUTJUcjJYZndxZEpET0JlMUVPUHVLb2RoR2FiRmVaSE9T?=
 =?utf-8?B?VU5XUWZUVVIvSUxXTi8xSUdNMjZqTGNSb003Y3F3djlOWnNDemdCK0lLWk5v?=
 =?utf-8?B?SkdxSCtpc3FlZWQzdW5uUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9486.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AB6E66386AAAB40BE41964CEB806B83@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11081
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:42d::21];domain=DU0PR08MB9486.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	537b0cb0-3faf-4998-b47e-08dce9cafea3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDZiVnIrNTNXTUNWc3JsTFlkeGFpa2ExcVVldk0vMUdrbyt1VVF5V2FaTlUw?=
 =?utf-8?B?OWVZcTBac0hhbUtRT0JsRm5nR0RLamt2cDlRWEh5Q2IvNCthOWc0WUd1ME1O?=
 =?utf-8?B?VU93R3pYdWE3N09aMjVFOTlnRk9yN3Uzbkh2bWZVYzZiMlYwT1ZTOFk1WlFV?=
 =?utf-8?B?SUNhazNrSGQyNTNkRC9jY09qMUxRY2FaL3o4MGswUXdQdzdrZDBlUmlWc2Zu?=
 =?utf-8?B?QlZIMm9ON0Y3cHlwQ1pMZi9hMjFzbEdJNnpuNmltRWtSZUp2QTNmZUlRaGdV?=
 =?utf-8?B?UTBGdFdITnc5dURmMTEwR0xvYktQL1VndEhhRW9CVDNhR25UYnBoV0JlcW5X?=
 =?utf-8?B?L3JYb0hMR0NCODVMVXVmcjdRc3g5K1pvcE1EOHFFVEoxZ3BPUm9rckVJTExz?=
 =?utf-8?B?bXMyYmRzWlNVYTNIdVM2UEtWallCNEVoQXNrWGM1UDl1MVZTNisxVEZZYUpL?=
 =?utf-8?B?Zk12V1Z2VzYrUTdEY0pqMzJhNkVtS3ExWGNEZ1BzYTNFR1ZGUklZKzdqSXIw?=
 =?utf-8?B?dGozc05KcFNzTytYWnA1a2Y0TXlKb1FqMGkzV3lUcnpTamNQN3BOTEduTTRL?=
 =?utf-8?B?Z0xIOXNCd2pCVTZWUENCM1RDUi9ZMzAvZUNRdTNBQUxHWU9oYnJPeHN0NTVC?=
 =?utf-8?B?SStnMWthKzdIeHd0ZldUR1E5SVBva205cWpxVHQ4N29rcVlZckxJeGwwY21C?=
 =?utf-8?B?cXBYV2lCMGZOT1V2MEwvZEd5OWYxeERmUU1nSzI4a0I2OVRoejdmbm9PcW1O?=
 =?utf-8?B?Q1hRc3NmNlI3V0MzK1NoZzR2OGEyM2FuTGxWcWtsdjgxclJxSC9Id29mVHFz?=
 =?utf-8?B?R3RqWTZvbHlRcjhIY0l2SXlqelZramM3eDM1amJLeGNlQUJWdFB5YU83TEtP?=
 =?utf-8?B?UGF0N21STEdWVG8yMUxGTWpLMUZ0S3JwR1JiM2lJa1BXaVlBNGtzcE85WlpQ?=
 =?utf-8?B?UkVZMkpMdUd4Lzl5T01MRTJXQWxQaWdacE9QWDBLYmUwQUtkY3YyL0ZrSk1z?=
 =?utf-8?B?ZnlIRWJwWjdESWZxMjh3MHQ1d3djK0VQSlJUVGpHNVJSWTllaHdXOGtFNDBV?=
 =?utf-8?B?VnFYS1gvWUMveEFwbFB1VDNHQzZMQ3NZYVNsWFU1VjNadlB5MWdDdm13SHcy?=
 =?utf-8?B?VGJOTVQ3YmtqN3VJeHVHOEgrVmtVSjFnVjZuUXlJWU1NNEJlQXZvY1VISUdB?=
 =?utf-8?B?VnIyTUMzVnFQSTBCc2NSMGgwa2VMcXhzT2wvcng1SDFlbUk1VmxmSW5LV3Nr?=
 =?utf-8?B?alFrbmxwcS9LY3RvSHk4RytzMEVkVjNoUk11VUszMTBJZTR3L2pDQjZ4aDVI?=
 =?utf-8?B?aGJ5RGt1N3drZTJMY21PWXQrMURpVDVCcHJIQTR1T2dKQXlCWVUvY0FVR1ZO?=
 =?utf-8?B?U0laMExIMzU0Y0VzTmc1bnNwTVovR29pc3F4d2pwY0MzcFd3NEVDdmpYSk1u?=
 =?utf-8?B?d1IwTHlzdGFYVUN6UDJGenR4S21JbmFFSmJWL24vSHBOOTlybTBwcllyM3pv?=
 =?utf-8?B?OEpRYzVvSytCY0JOZDFucXowTFBuMlMrZGxJQjZORCtML3REbTFicnZDMSsw?=
 =?utf-8?B?eHl5Y2xBRDNMU2ZIZWFEd0d3VjN5TDVNRHhTazB5SG5TQTcvZm92S2pzSGlm?=
 =?utf-8?B?d2lHTW84NU5CZmFWODFXajR3bmpNN3VkbEVUZ1Z5ZVQwQ1lNRmh5dUx0eDUy?=
 =?utf-8?B?VkJ3THd6aGZPeGpNYlo5cnBaM1YwYitueXdaLzBHZ0hBMzArdDQ1VVpmMVp4?=
 =?utf-8?B?d0hJQi9vTUdySkg1cXdQQ0hDYmtIYVY4UFBvYjVTeEw1WG91Zk5pQ21CenlY?=
 =?utf-8?B?YzI0QmNobmtRRGtxQmlWUFFwRmFVOXl0UG53UVhUQ2E1dFJlb3hnRHZYS2N0?=
 =?utf-8?Q?/gpqTwQbsYG+x?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 08:02:16.6691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0122879b-1024-44e4-7082-08dce9cb05ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10577

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDIzOjIyIC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEl0IHNob3VsZCBub3QgY2xlYXIgdGhlIGluaGVyaXQgYml0IHNpbXBseSBiZWNhdXNlIHRoZSBr
ZXJuZWwgZG9lc24ndA0KPiBzdXBwb3J0IHRoZSBzYW1wbGUgcmVhZCB3aXRoIGl0LsKgIElPVyB0
aGUgaW5oZXJpdCBiaXQgc2hvdWxkIGJlIGtlcHQNCj4gd2hlbiB0aGUgc2FtcGxlIHJlYWQgaXMg
bm90IHJlcXVlc3RlZCBmb3IgdGhlIGV2ZW50Lg0KDQoNCkFoLCBzb3JyeS4gR29vZCBzcG90Lg0K
DQpUaGFua3MNCkJlbg0KDQoNCg0KPiANCj4gRml4ZXM6IDkwMDM1ZDNjZDg3NmNiNzEgKCJ0b29s
cy9wZXJmOiBBbGxvdyBpbmhlcml0ICsNCj4gUEVSRl9TQU1QTEVfUkVBRCB3aGVuIG9wZW5pbmcg
ZXZlbnRzIikNCj4gQ2M6IEJlbiBHYWluZXkgPGJlbi5nYWluZXlAYXJtLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gwqB0
b29scy9wZXJmL3V0aWwvZXZzZWwuYyB8IDMgKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYv
dXRpbC9ldnNlbC5jIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gaW5kZXggZDhmZDQ5M2Fm
MDE0NThiNy4uNTA3ZjUyNmNjYmJjZmMzNiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVyZi91dGls
L2V2c2VsLmMNCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gQEAgLTIxMTIsNyAr
MjExMiw4IEBAIHN0YXRpYyBpbnQgX19ldnNlbF9fcHJlcGFyZV9vcGVuKHN0cnVjdCBldnNlbA0K
PiAqZXZzZWwsIHN0cnVjdCBwZXJmX2NwdV9tYXAgKmNwdXMsDQo+IMKgDQo+IMKgc3RhdGljIHZv
aWQgZXZzZWxfX2Rpc2FibGVfbWlzc2luZ19mZWF0dXJlcyhzdHJ1Y3QgZXZzZWwgKmV2c2VsKQ0K
PiDCoHsNCj4gLSBpZiAocGVyZl9taXNzaW5nX2ZlYXR1cmVzLmluaGVyaXRfc2FtcGxlX3JlYWQp
DQo+ICsgaWYgKHBlcmZfbWlzc2luZ19mZWF0dXJlcy5pbmhlcml0X3NhbXBsZV9yZWFkICYmIGV2
c2VsLQ0KPiA+Y29yZS5hdHRyLmluaGVyaXQgJiYNCj4gKyDCoMKgwqAgKGV2c2VsLT5jb3JlLmF0
dHIuc2FtcGxlX3R5cGUgJiBQRVJGX1NBTVBMRV9SRUFEKSkNCj4gwqAgZXZzZWwtPmNvcmUuYXR0
ci5pbmhlcml0ID0gMDsNCj4gwqAgaWYgKHBlcmZfbWlzc2luZ19mZWF0dXJlcy5icmFuY2hfY291
bnRlcnMpDQo+IMKgIGV2c2VsLT5jb3JlLmF0dHIuYnJhbmNoX3NhbXBsZV90eXBlICY9DQo+IH5Q
RVJGX1NBTVBMRV9CUkFOQ0hfQ09VTlRFUlM7DQoNCg==
