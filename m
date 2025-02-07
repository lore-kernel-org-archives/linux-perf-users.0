Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0321A3159;
	Fri,  7 Feb 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956227; cv=fail; b=dxtr48AnxeTfAd0ycFu970LFsui/2c9U5Mhmd+ljGe9q6tvqcegepqraPu8VlTzJKySbEVh3ZTeinFCXufUfbU+VV+/gT/lnNDj5AvW+Ee9f1zX3gWQI/0PLHJNr+QJUeSvfAtK+k8R5OXyUaKOY9pi9vnIGvoZ6Achg7q3gZH0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956227; c=relaxed/simple;
	bh=IILhsrHuHpowGgizqop6elXBxcYmYF6eQGklgO8AUbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HivsZTjnmusVBZffqawJL6dIK90vbmPJ4n3i6wPHUWFxXYa3k/1cgGL4Nt7InAOfzhsWB/g2FzqD0nuemsRSFuhQ0ImneTtCL98AKWeavhG2mX1tZDRcWecF85Ebs/uuOBCo4bOTYy78J/fYSL8H62Y42wt1NYb0BV6xF7a63ro=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pkzu+YS2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pkzu+YS2; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pkzu+YS2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pkzu+YS2"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jW+H/sdCeLdvugJO0SWxVdaGIpKmd1ktZi4c23CAFavyo+w+jRClpG215j+BSUh8WMhvQ35nrbMgDSzhvDk56MThBK1Mk2arAMI7PuK7jW/7cV894VKWY3CVylwFlMs4sV+ZWKaqU5n1HWAnpfvX3DkJiYv2KiF7E+Kwa7PH3Vzqpy50nw2y6pGMfIWWZBJDlAn8hFflvuxSUNHf8xIR76ntcpJ+c/MgFNt5aerpIHqaUE6OUjiQ8sboqr1RSWBx9Inpb+6TG2yiJh2XK9JvBcpFbrYLR2l1dopyN4b97RdpIIu/vG3o2wHynmWZ6NLknTzIrFKcG1YV2mgy6uhhNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aipSqgLpoDnEPQysiAsIkB3yfOtvsCXrv8LkMUaF/OA=;
 b=GdjQUO8YQyXfWxpB7U2NQ44CMrpFwFQJWmtwo9cUZ+cpTycNcZJ4spYYbubJGVU5xGZRfIMFGuKyIOXMZtS3zbpJdzbhks8Pivq21PLSEHl3IfsJuqyxzdCgcZFqzD6lJC65YDIg8N5ViHipe/KEZj43mimB/pm43qlVGxRFoE+mi8UuorMQ3teeGa2Uiw5FVYQbPiMMfjNKiIUrriT/jC/TivNpSDC7ALPm3RolA4iBzR8jt4pgOX4PjC5nyPk9VF8b0pDMyAa/Y2IR3fYnKTTLqJMhDQgSf3Y6IBW4XxAwX7uGP//jJh4S0Ji9ehLnqijXl9QQ5JDyf0D8bnoMAw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aipSqgLpoDnEPQysiAsIkB3yfOtvsCXrv8LkMUaF/OA=;
 b=Pkzu+YS2wKlXLGWc/spq+KkLPUu9dzZnpNmSUOJdAWY9LnucFvS0v2oJh0FHz0pXMXlerfPnSAjR5YJXFadhsYxQkS38TsC/iKaJ/Wj+8PqsTdt/vWIZJ43ev37VhkksJgAM3Xcwbyy/RogfVCBpB+eyRDUQvIlYkhdeOgpazMY=
Received: from AM0PR02CA0206.eurprd02.prod.outlook.com (2603:10a6:20b:28f::13)
 by DB9PR08MB8316.eurprd08.prod.outlook.com (2603:10a6:10:3dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 19:23:37 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::d4) by AM0PR02CA0206.outlook.office365.com
 (2603:10a6:20b:28f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 19:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Fri, 7 Feb 2025 19:23:35 +0000
Received: ("Tessian outbound c79bb2535b53:v567"); Fri, 07 Feb 2025 19:23:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1fe9282f02dec424
X-TessianGatewayMetadata: 6ZFWwtMxPats07uXs2Jlpe/t2p8z61JyJgJ0auCJmvHHluNGCl2HGGLEvl7ySz5HQg5DziM80bzSYROt0tw/DpJHNWg2byQKPITvoe1RX76ZrJiPndgU532eUPcThL9GjOFlJz+XYRQwnyJBXae0ZwZze6tXN/Vo0erYWisN8Do=
X-CR-MTA-TID: 64aa7808
Received: from L7dae6bd2ee6b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id DD93DFF3-9155-4AA0-ADC0-642EB00ACE57.1;
	Fri, 07 Feb 2025 19:23:24 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L7dae6bd2ee6b.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 07 Feb 2025 19:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBX1n+ZtW82DpBOAnLmh1dXkIYs7KvrB67jPcJFLMh1Opj4S+T1pPr56eDFcuZpwipOmoS317NWx1G61lVYw2+/KljK3RXtZoVnafhPFAyM9JwZ7fQ/83/nt477llMKEoVFJmGS0clfFC6Dd2JdetU10I3s43mBy7YOHca+IXRGGb8r6HNATfsY6VrIC+0pIwDfxRpdPkUClS0yat4asq0BUu1ftMi1/kN2AMj/zgMANXolhh4/TjWHH116BDx26T2zZTSwO7jH2prrQf7YbgajrxjQvUKfHtwqllVqxihiJYXoD37O1VP0W3q7HA4XdbNZ+nABlX2u0B5Dd2eij6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aipSqgLpoDnEPQysiAsIkB3yfOtvsCXrv8LkMUaF/OA=;
 b=BjAN/p/cErzRqCMlYY+qZ/7q/Cv1/T4J0Ix7IActhMa1Hgto/nc/lhqcIjv0pHSW2JKwomBwI0I34S1GEIvboqQd4n8Am00iEMrc3RPMlfi7bF9ZDUzr2ycCbqf/TAB0ERrJw/JSoC1jfQzQbyRxWqsjo7xwN9s1KLCbQgBc3GP6n0vvrxDI4NYZX97K8uXeb26iUNe8BOet6g4TVixLITtKB8EYv+x7VX3LSeP172Nq1eZ77aG5yEGF/3oKVKwIM26nt570z3GoNgYhFN5Gy3pkN16gdWfVn03ZVnEHdBspMRu+GOQlUHT87/dYWw6OQeng/yGE84jsfhcADUkOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aipSqgLpoDnEPQysiAsIkB3yfOtvsCXrv8LkMUaF/OA=;
 b=Pkzu+YS2wKlXLGWc/spq+KkLPUu9dzZnpNmSUOJdAWY9LnucFvS0v2oJh0FHz0pXMXlerfPnSAjR5YJXFadhsYxQkS38TsC/iKaJ/Wj+8PqsTdt/vWIZJ43ev37VhkksJgAM3Xcwbyy/RogfVCBpB+eyRDUQvIlYkhdeOgpazMY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6)
 by PAXPR08MB7442.eurprd08.prod.outlook.com (2603:10a6:102:2b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 19:23:22 +0000
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb]) by DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb%5]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 19:23:22 +0000
Message-ID: <b4302bc7-f2c2-4105-a39e-57a60aa242ff@arm.com>
Date: Fri, 7 Feb 2025 19:23:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] A mechanism for efficient support for per-function
 metrics
To: James Clark <james.clark@linaro.org>
Cc: ben.gainey@arm.com, deepak.surti@arm.com, ak@linux.intel.com,
 will@kernel.org, james.clark@arm.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20250106120156.227273-1-mark.barnett@arm.com>
 <ca8de228-68c2-4b2c-bb58-30f275afc49e@linaro.org>
Content-Language: en-US
From: Mark Barnett <mark.barnett@arm.com>
In-Reply-To: <ca8de228-68c2-4b2c-bb58-30f275afc49e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To DB9PR08MB7584.eurprd08.prod.outlook.com
 (2603:10a6:10:308::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7584:EE_|PAXPR08MB7442:EE_|AMS0EPF000001A5:EE_|DB9PR08MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bae4927-0d67-4f47-0450-08dd47aceaff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Qno3Q0U4QWVrZUlhRm5WSElpV2RobzBMTHplY0FkZllkWjZBNEpvYTg3d0No?=
 =?utf-8?B?d1o2WHZlMytQWm5rZmpVNzV6MDJURFVNY0ZvNHVIK2JtRmJpOW9ESGwxQzFR?=
 =?utf-8?B?MWl1SWlvVXJpcjdWY0lhNGNJbXhKNlg5K0NYMko4WGpnaDhMT0wzSTlvbGZN?=
 =?utf-8?B?N1dTTmpoUnRZOE96bmRwc2RleUYwL3MvOGJsMmFwYmVocWZnSXRRK2k0amZs?=
 =?utf-8?B?YWozWlFheU5jeFNvRk0zTDBaRkVJaFV3ZUQ4bGo3ektXVlJ1OGxIQ2JkaTh5?=
 =?utf-8?B?K25RbmpEZVpqMzY5cVlrTUNRYlpzV3h0RDVuT2s5QXAvWnBRd3FsWU85WThD?=
 =?utf-8?B?RTlRNWs4WlBYNEpJdFQvT1NtOU1MRWJIYmJGTnVGekxFdTkzZzBwYkVuT2pQ?=
 =?utf-8?B?L2p1Z0hQSEpaU1RGYjZFeFFUQWxqVXh1ZUwrcVJ2aTVRQ09mdGZ2ejR0Y0hV?=
 =?utf-8?B?Q0U1cUw3S0JzYUw1am8vb2U3NklxL3BoRVQ3ZUFQRTVuYitQTmw1R1c2UW1p?=
 =?utf-8?B?VFp6MElPQjRzVDVvYVU4UVY0aWRYVUJsRHJGdFlFUlBoK1FCSC8reFh4eFVG?=
 =?utf-8?B?am1IRkRYR1ltSm9ONVpDQlQvSXVBUVBmL0NDZVVlRWFZNkNpa1hub1pUM2lr?=
 =?utf-8?B?dnRqcUdmQkJ1KzQ0RWh2VGNVL00xMHZZUkFHS0NSU0ZjTnNOYTlLbWNEbFY0?=
 =?utf-8?B?aS9KUU9oblJkL3NSMVErWmhlUFo2d3VhdkxUMGt5WnpMaTBpeHFqcFAxZTg4?=
 =?utf-8?B?OVJnVWhaSHEvNjJ2cG12bGlUNkY1cUJPUStKTDFETGxEM3JzN0l3SDZ4ckY0?=
 =?utf-8?B?dEY0cHdxd2VKd29acHErYkNFWE5maUIzd0lLbXhjTjlGc256ZWR1eW5ob2VB?=
 =?utf-8?B?K2MzNU90M0FTaXZxb2UzUUNwUUZrUi8zYkJ4MjM5eU5xYWhXdTFZR21YNGl2?=
 =?utf-8?B?di9od3lmMWhLbkx5QVl3YUdtUlloV21wbEc5dE02dUhhLzhaWC8rWEZTTmJa?=
 =?utf-8?B?bDdDS1Z2WlNLMUdGclZjM1NVekdtMzQybjE5aDBMLytaTnNPY0NjWDZrbmU1?=
 =?utf-8?B?S0d3WEI0VkJmaW56d1d0c1RUa3V3Vk1xSFpFVlB1VkNyS2xuVUdhSERwcnpa?=
 =?utf-8?B?ZGxYQldUaStjZFgyL3lJc2l2clViTG82anIrMHBCR2lZQmpTUXo2ekNWZTVK?=
 =?utf-8?B?QWE4VHZXOUpxNlpBWHBjZHRyTDNWR0ZMa21aZW44UE9SZTVMN2hQSHJmaHpM?=
 =?utf-8?B?TjVTL1VSUlhTK01KTjBhcUVSUHZvL1l2cXAyUUovdG5TZUZRUmhEOFcranE3?=
 =?utf-8?B?WmtSKytROVF2UzgvUGJScnZKbW5Xa3A5OWs1ek5ZNzNmZmxCd21MOS9hbzNw?=
 =?utf-8?B?aWxUTnRJZU1COUdhcFZITlpKS0V5Ym9GbXJwemsrMUloamowbWJIOENlVFBv?=
 =?utf-8?B?U0RrMENyRGZaSFBadlJEUDdsOFdaQTBVdDJVZnBjdHIvVnpBb2JyZW8vUUlN?=
 =?utf-8?B?M0FGL3g1Y0laYURPQkdkM3dSckNkSnJVWmNwejFUalQwRlJZVk14V2VibFhl?=
 =?utf-8?B?M0IrQVBSTm5WVWdBN3ZvS2Q1WVBhVTJmVUl1Nk9FSnFBcm9TRDRSaEFtMEtR?=
 =?utf-8?B?dkVlMm5ScXI3YVF2Z0ZEazdKVUpqKy9JWkxBZDc1S3F5NHRWUUJ0cGtFdWhE?=
 =?utf-8?B?bTJBVEcwTys3Z3gvK3RXeUJVbU5xRnNCS2d5UVI2d0dsQUNkb2Jwemw1Zlhi?=
 =?utf-8?B?NG5zZVV6K0laalZDTS9xeHFDQklWTlpZeHB5Tks3YXhyRFJ3dVRFSEk2Mjla?=
 =?utf-8?B?R2VTUTNDRnRLSnByakFnUDVWZjExekJ4V0UxZlJreHpTdDMwM3B4cUUwSFAw?=
 =?utf-8?Q?hg01URj39EYvh?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7584.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7442
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:308::6];domain=DB9PR08MB7584.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	14c3fc49-cef2-4de1-8a85-08dd47ace302
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVdqTHNUMkJnQTRaL3Z4VDE4U0NaZURubzcyeVplR0VZYUgxQURvdDJyNU1j?=
 =?utf-8?B?SmU5Tm1IWGxmU3NRMEJXRCtZWUhuRUV5eGYyZ2FVK3luRVk5SUZrRVNFTHdh?=
 =?utf-8?B?MUdXbUdjUHVJUFpqZllGcElxeXlFb09EcEtBZ0dLTVhvV1hDZkV1V1VSTHJh?=
 =?utf-8?B?R2g0djRLeWo4cDB6SjFYQm1TQXRqNFJSRG1WbkF5N29mVFBReWxxVnVqVGRj?=
 =?utf-8?B?V05LVXNHU2REWm9sZUhmTHFPeWdFazZUSHpqYlEydHRld0xZa3Q4eEZHZWNK?=
 =?utf-8?B?NUtQYUx4d0ZZM2hZQ1dnN3cwdlhwUG9IbTArUDlmUjFWREVTdG1JQlJCdG9W?=
 =?utf-8?B?TUZrR1BwRkF6cWxVSjhFek01N0U0Zm1xbldmdmxWV3dvb2lhaVdVWXM1SXlr?=
 =?utf-8?B?YmRHd1pISTUvWmdBMS93VlVRaTY2azJNVC91ZlF4MjJlVE5VZXo5TXZGMHcw?=
 =?utf-8?B?a0dxZmdFaCtVZjJCMkc4bnB6RkkzaUU0dGU1SW5vWnU4RjNJUmx4VDNkNFpF?=
 =?utf-8?B?SSswS2ZHQUZ4eC9oRXNNNkZVUzZHbUhZWkhydll6dzdXZ0JqcFNTR2t1SndX?=
 =?utf-8?B?NHRwZFJIc0JUZ2lUazNpVFQ3SXkvaGsxRUlqdDZxRDZPWmVmY3Njdzg2Q1hX?=
 =?utf-8?B?a1JEOHgxNmN0OVdULytOVTExYzM3dnd4eFpiZDlweEpaSTlBUDM3RUdrck1H?=
 =?utf-8?B?bnZBa1BBTXFCR3drUFU0cWVYWmxYejRzOENHUXZzODU3L01KZUdCa29RUlQz?=
 =?utf-8?B?UmU2c2hrOG9uU2lmazBIL3FJQzJJbFozVk9sdzM5THNLSWxocmt3SlhWWGs5?=
 =?utf-8?B?NkxvSHBVL01IT2ZhdWF4bHJZWU9kM0RSYnduQ1pjaytQOERITGYxTjRIU0Rs?=
 =?utf-8?B?cnFUTTNFVlhhemFJV1VwSTh4UWZUVUI4bGFycmUyUVcvRU9NTU5rUi9ZcE9K?=
 =?utf-8?B?TVdra0JHYmlLZzljcVNPS05YcXdDckp0M1g2eGEvc1pkb3FmYUhKYjRSNml0?=
 =?utf-8?B?UXVSN2VPME9TTFBDbGhBMmk0VHJ3d2hWaEF4S0p5dzM5N2w3akdHQmx1UlZF?=
 =?utf-8?B?RXRPY1pGakw2TzVLaDdJemYrdW1IQ2Q0a3RVM0RaTnpDaGE0dElqZUFsRjhU?=
 =?utf-8?B?ZFJHRnBudldrQy9meFpGcjhhUGYzYnBFcCtKZU81Vitmd2hWNVpmZVNJUkVh?=
 =?utf-8?B?S2pwdHZQd3ZLMklZYXQvVlN1UkRVQTUwWlVPbzFadDdMczlIL2JQSXFPVDlv?=
 =?utf-8?B?Z0VYOCtKcmVjTlZ4YXJyWElLMStrdVdHamtsMWI5L2ZoRG01c3lLQUpVdEtK?=
 =?utf-8?B?VVVWMThBakZlVWlEN3JCTG1TZGZFVjdFZndLYUtEYlE2ZWpjdUlld1I3RU1R?=
 =?utf-8?B?dllLQnFJcFRMdDZ4b0swRWN3ZWRwNjJwTDZWTnlhMGtTK1RpR2c5c242dnRr?=
 =?utf-8?B?Rkt3YkYvdC9JYVI1WHE1c0JSc0FwVjBCS09acXBMVjRmZEcyYUFldmxTamNB?=
 =?utf-8?B?TCt2UXQ5ckMzK2pxVng4d0RVeVkxVllhLzFlNTZOeW5XbThDdXp0eE1aM043?=
 =?utf-8?B?eHZCMk1kRVg3VnQxYzEwdmpFTytqOEhsNll3c0diYjg3SUNzaDNMZ0tHbC9a?=
 =?utf-8?B?aSthM2FkTDllSWxHOGVZelJRZDRtYllyOUpCN3R5aGRlck4yOWR2VkhKNXRv?=
 =?utf-8?B?cXNuakdoK3VnN3dNYVlkSFdnNXpJdXEyaSs0VjBmT2xEOFZrMStiVVViSmM3?=
 =?utf-8?B?ai9LQ3FQMlhHSytxUEVJS2E1QkRqRVNqY2ZsM2lSZTl0T2w5T3doZFJuU0M2?=
 =?utf-8?B?Z2RDaXVYcXB4WEdSSjgyNFpYVGpBc0N5eXJpaUxjdlAzRVhadmsweDhab0pK?=
 =?utf-8?B?WEpLa0oveUVrL3VTcG8yT2E0L2l1YlhkOVgxc2t1dnc0V29MSUFqVlNSL3cz?=
 =?utf-8?B?QkdtL21ybkRhcXhUT2tBQkNiWEhRamVVM0dNZFdmYTdybVJSeFRVSkF0NnZp?=
 =?utf-8?Q?L+/w826NMVEKs3XKYUpUWbzcZoA4ms=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:23:35.8381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bae4927-0d67-4f47-0450-08dd47aceaff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8316

On 1/22/25 16:47, James Clark wrote:
> 
> 
> On 06/01/2025 12:01 pm, mark.barnett@arm.com wrote:
>> From: Mark Barnett <mark.barnett@arm.com>
>>
>> This patch introduces the concept of an alternating sample rate to perf
>> core and provides the necessary basic changes in the tools to activate
>> that option.
>>
> 
> [...]
> 
>> Changes since v1:
>>   - Rebased onto perf-tools-next, as per request from Ian Rogers.
>>   - Removed unnecessary code that truncated period_left to 0 and 
>> restarted
>>     the PMU.
>>   - Renamed variables to use the shorter 'alt_period' instead of
>>     'alterantive_period'.
>>   - Added patch #5 that addresses an issue in the x86 and PowerPC 
>> drivers that
>>     caused the opposite period to be reported in the sample record.
> 
> It sounds like it would be better if patch 5 comes first otherwise the 
> feature is introduced as broken.
> 
> 

Thanks, James. I'll re-order them with the next submission.

Mark
