Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8B278E71;
	Fri, 11 Apr 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369715; cv=fail; b=l3TnSPpnqvKqjs1Fg1Fphn2bTb01myxwqYWBlhHDGog/KRDw+URVJEmjTPTRsulUlGhE0Qhvxb/06yf6Q9c4TlU37auCrPVzCQoc8ZVxNuyCoKixZFcmWuJck9niE/6a6ScX5e7ivUXO4HdrSSNPHuAUv+5kl6cHqtpTwQokxSY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369715; c=relaxed/simple;
	bh=LyCjTEmTD1cPBjodKKcsEIPzDOR4hW3U6gxj1GUJIm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9nc/joIj5iH/MBjTEdyM8yGDfHtqo66DBsKixyktg4+6mI4MGTJ6mZ+n6hooON1WQlubYXAm54IBzSymQP6IlZw8yy7RLGtcOeI/RA2EfRRJIu59GDQ234OYzwKVbS1xZB98/ALG7wZO/HF96qOvkJgLyAlfK4FSZ3f8wR+JIg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FwyyZ3W/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FwyyZ3W/; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FwyyZ3W/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FwyyZ3W/"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GKpKTkTHzbtG4HK6k3GGQ8XGyQ3krUbRfsyfhqakjFbD6T7GwGRiqUS0hxH0kNYyyITTah5gHcOVeeHbRrcuRDGRevt5DlRPtzbXoFokD0w97YqVZTx8dvNVNI94SAMjQDdBW96lPcT0u9wz9G9tIRAizumC38/bjGguWA0BKqQ9onRmZTCln7PASM9c3MvGjyNn1GLXsOABw/9zdAWQn+0EX9UhDNy6pNBeDknnQAYcdS8vGdd4Pfon+v/Jj3cpg4imHVPAanb73xrQc3W5GPXj9cXFOyaA4ZHWDUxM7t3VPF2NgP4dP/cSsOXZWRdU+67bonVNZfOFw7iXZEKKWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pp6Zcg8Oi2b9kdeAp4Q2dl4oZArJmbsOraFv+YktGg=;
 b=bT49xfjQvYSAQiu4AWDe2PcQmG/238xGuEX5v0GIERffHswRBnHnseTF5HJ1kgoOBTG+iBfxZHq+zNJxcVfyI32qUwCr5ftnXrLsI82zC+6waxuaVk0hGtgZ+v/tHMzQmTQbziqwo+S9+BpuXNeHSh1oNzzG3HgNaS21iEbT0yRjMvIhpeu47E1DdqfvjevnEWkbE1cwXu+2NgJO4WLIweKb6X9vSRu9z5SVqxjuuf+XZgpz8QC1IwBTIh+UVOQXFk9rBIlNkX8HrI0OZV69O18lxhL5FZDjWJ5GjNMxb4OXDFT7oJ2H/InAL9fK6h5qdIXt09FRZOdRmc0kTOIhqA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pp6Zcg8Oi2b9kdeAp4Q2dl4oZArJmbsOraFv+YktGg=;
 b=FwyyZ3W/n7VHSZvKnYG6sRWkOR2IxiPfj4Le9uO63LVSH/bk2E2SjPNkGbkmX/G9odz+XislCXC0Irq0suz0cxWFPoYIw1a7RClIe2yYVRX4TE3cam+mbLadrHTA5QsRW2TWvE8Tm4/Hey60jbe8oICxBohSCvAaTj+j8cBJzXU=
Received: from DB9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::6) by GVXPR08MB10449.eurprd08.prod.outlook.com
 (2603:10a6:150:157::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 11:08:24 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::b3) by DB9PR01CA0001.outlook.office365.com
 (2603:10a6:10:1d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 11:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Fri, 11 Apr 2025 11:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcH/dGzvaHhY3yt/gq8PAjwosBmJduaBNnGcm0Xn4K3qu9uyxemo5avq5MoVde0I/y7K697GSxeEdWDcTQDuJ6vYiPQJKxL5WstMtUYNZcmHI9EZbS85pFfi31JNkY+giCDUwV3+vFYqvWKazAcr0FW+sPVGHhEX+bcV0HaBCcHBxDwCbdkcungIkDyRfG7A5V2Nm9ZV0d7UzL1uFf8gqdI1Qa0EI+cLx7NIjg5Ipz5s6Pq07EjZajtrwFRU/1dW/KMnjjdHDvOO+dO8NQ1M8wVWASxfOs0d81/DPiIwPeF1dYdmtXuoa57tTyFB9i4lRukwE9/+mXRgHJEtqCcOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pp6Zcg8Oi2b9kdeAp4Q2dl4oZArJmbsOraFv+YktGg=;
 b=V7xKLdtJsYPnT8kv1L2kz6Iyr6KC562iaVoVlVWlDIiRnf7x3GMd0TBIIvmuTHhSIPlfR5mWe6UTyqLPf96cRLSdT+MOahBwq3wSSJIbxIMfaklVl0b1p7wVQd9lcSOtzM9P7IWr8yo6S4Jf5Y/P4KZJZdIDr6iUIvrIZ5T9XYTmRyv3xXkywc2b2Cq1XYmj6gF2aFHDUAmQxQfTbtB1bNQXnoh6bPoTXFLMNusoZViMxO8WSZY5S1RqbIYRXv2dbSGiNqJErlwJHpujzYDWgGiXlaXh+MoEo00rDTPXn3tuUzdhywm3MBiLDKAEZ6RpZAy/7vmwuJVPbYoSXdtOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Pp6Zcg8Oi2b9kdeAp4Q2dl4oZArJmbsOraFv+YktGg=;
 b=FwyyZ3W/n7VHSZvKnYG6sRWkOR2IxiPfj4Le9uO63LVSH/bk2E2SjPNkGbkmX/G9odz+XislCXC0Irq0suz0cxWFPoYIw1a7RClIe2yYVRX4TE3cam+mbLadrHTA5QsRW2TWvE8Tm4/Hey60jbe8oICxBohSCvAaTj+j8cBJzXU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6)
 by PAVPR08MB9332.eurprd08.prod.outlook.com (2603:10a6:102:302::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 11:07:50 +0000
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb]) by DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb%7]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 11:07:50 +0000
Message-ID: <2fa741d8-13c7-49c0-a6c5-540a7c2cf3a7@arm.com>
Date: Fri, 11 Apr 2025 12:07:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for per-function
 metrics
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
 deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
 james.clark@arm.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <Z_ZcRiHTGljxEEdN@gmail.com>
Content-Language: en-US
From: Mark Barnett <mark.barnett@arm.com>
In-Reply-To: <Z_ZcRiHTGljxEEdN@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0294.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::11) To DB9PR08MB7584.eurprd08.prod.outlook.com
 (2603:10a6:10:308::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7584:EE_|PAVPR08MB9332:EE_|DB1PEPF000509E8:EE_|GVXPR08MB10449:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dc237f-ffc5-45ed-f6ef-08dd78e92d7f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VlB2UDJZZkFOT1N0M3ZGcStiWGk3RDlrQnFSRXFXamxhUjhQd2RhSkoxN21x?=
 =?utf-8?B?WmNERVhtYUtUVHJDbUlaQjNEQlljOWhOUzR1cGVUakhNY3JBZlc0MG00clJs?=
 =?utf-8?B?THVrWk0zWDhIQWY4cSt0dlJmR1YvUW4zQTBrSXdiM29PTzRhWHFkVUQ1eU9p?=
 =?utf-8?B?ekFBTkRVYStDeE1acXVidytMemNLTXlxaHZ5YzZHb1NIUEVyZit5cUVwMmJa?=
 =?utf-8?B?dk9UajdDNjZGbWlJaTA1ajh2SVUzUVI0cTh2VWNTWWpRTXhodlE2OWpmS2F2?=
 =?utf-8?B?RjBIZDBwblJxZmxCV3NjUjBTNW5paUFUNnhRSHdWcXVwNnMrdFpsZnVsWEdK?=
 =?utf-8?B?Wm8zYU82bnkyK2Q3Vy92QURQMVlpQTBTdGlJdThyZEhxL1VRemhWSUZWS0Zs?=
 =?utf-8?B?SUNMa0kycFp6enZ2WWQ4bUw3OVlGdzNtM3ZnQmJZSS9QUEtZR0VRQ29oK1RE?=
 =?utf-8?B?S0JwbS9SNDdlUWdSS1VuZUpDS2UvOGZqWkp0SWJ2SFJ2ckI3TUxSSGdmcDF2?=
 =?utf-8?B?SVdyNmxXVlQxNTcydmtlMUgrL0REdWdvSkhQMzczQ0ppSUxoVWJTZWl4eGZN?=
 =?utf-8?B?QjFuTXU3bVhodU1Ja01tSDlEN3Mrb3FVTDRJMElIS0lqN3A2Zk51dzlvdWpt?=
 =?utf-8?B?Rkt6UlpRZjlUKzlqMXM5THA5RXdkSExoN2FCUTl2R010RmRCNkM5RnZPc3Nx?=
 =?utf-8?B?UXNVQmpqOC91dmM0VTJaenhpR1RkOWNCelpleXM5cXBwTXJ5bTBQWm9tZXRz?=
 =?utf-8?B?ZzFWdk9TMm03Z3lJSEIzM0R1OTdoQ042dFVtcUlmUmtIUXUzRTZ5Uy90c2VL?=
 =?utf-8?B?aVBCNXEycEVsSFlKMXZneVd6UGZVOFdUL0dFUnhNR0gzbTNrRW9NY3M4Kzdu?=
 =?utf-8?B?NWpyWVVxcEJTUlEvTWx2V3BabGh2VkN3T255UTE1T3U3aWZwZ29GeWg1MXpO?=
 =?utf-8?B?Zm1zODhQYWc4b1ZRZ1VzSGxmMlpSRU91elJydjZOTGsvQTh3VVpmSVZ6WGw4?=
 =?utf-8?B?RlNnS1NvU2VOSkRZUjQ0dmpDdnpJYmd1NnVkK3RpbVdxdmdNMml2a0xIMGth?=
 =?utf-8?B?YlpEYk9jcE1HcVRrcXVHYVhrOTFkRUFQUGF2WjdzeWFveHVCa2RHVTZueHdM?=
 =?utf-8?B?SHNBM2k3YWFmbVpaczVpR0N4ZjRkVFdUcDhCMitseWZqTW1QeHhOV2gwNmp1?=
 =?utf-8?B?R2VnYjB5anpNYWFiMHR0YWdoZnN3WWVQZldWbFZGMy9aSFhZaDk2ZWFoQzZw?=
 =?utf-8?B?WVhXaCtCbjIwOWxxWDNkcVZ3TkRGbmZkOFJYaG4xQ2NYVkxyMUs4eTJCZ1Jq?=
 =?utf-8?B?endkdXpqdWhNZi9NRklrb0VKbUlPbjZEL1dOMlpNU3AyUVVwT2JFTEEvemQv?=
 =?utf-8?B?SUVRcm9IWktjRWdUTStSbHpBT2pHQlZvR0kvRFFtOVlIaER0SVhJbHUzbVdV?=
 =?utf-8?B?UmZZcXkyQXJHRGo4WkZha05XL0J3OTBTdXh2SExndDMvalhZaEk0aU9qV00v?=
 =?utf-8?B?TVhUUmpBSThOZU9xbHYxL3kvZk9wNDdiaUcxM0JoRS9lSmxTa3RaUTViM1Nm?=
 =?utf-8?B?MVNWNGJIZVY3UWVTbitGS2Jnckp6bTUyUUk3UU9tcTNPZE9MMm5SNVR6cVE3?=
 =?utf-8?B?SVpYcmRlYW5aTEN3Zy85ZVZnTUErRTk1blBSZHlUN2s5UjR3ejJ4ZUNZT01Q?=
 =?utf-8?B?Q3dtUU1oMTVyUFlMRW9FR2Q4SFpzd2g5MytLMXpsbzlDUGpicDErbWpxU09M?=
 =?utf-8?B?NVd6Ym1NRjI0dFF2V3YzTVE0ZFRYNGlYemlKRkwrblhtcmFheFRjNkZzQmVt?=
 =?utf-8?B?TFdyTERDTlVwMEFvUjRFOTdUa2M2andkaksxanBjY3FtdFg2aUgzM2R1RzhU?=
 =?utf-8?B?YVFjbUMyRmRoN2tjTG9VNi9uN0tQSmFtU3pycUFsNHV0cUhlVmVzN2ZVcHhx?=
 =?utf-8?Q?c5t60OoXU+4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7584.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9332
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ddbae298-04a3-449f-92d2-08dd78e9192c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|35042699022|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEZuc1lEbityQWJmMmN6VHY3WHprdklGTnVGQ1FURjFVc09JOUZJdFJoY3JR?=
 =?utf-8?B?dElPcDNzcGxNZU5sZVNxVlBsYTZWeUF5RG44Zkc2MDlBdVpoSDNlUXgwTFBM?=
 =?utf-8?B?aEdSVW9UMG55V04ycktPb0g0ak54RlRpemZVcjBleG5kYVNpSmVqa3VUYjU5?=
 =?utf-8?B?Vit6SDEwUng1cGMvdzVnRDV5UFpHcnBxUDlTUHpyTk9yYXVqYisxRTRncG15?=
 =?utf-8?B?MSs3VGFiRkphUEhlekxXN1BUL2d4MmFTbHpNV1lncG1zc1U0NG85TTlxNWZ6?=
 =?utf-8?B?dksvUzlNbFkyMzZ2bmxxODJUcG1RWUIyZldUbUpLbkFFMnQ3TFpmbGgwWnps?=
 =?utf-8?B?SGllcDdlcEl5S3NPaS9nVXkydXFTNzJ3dEdYRC9meUN1anlXN1duUUp5MWh4?=
 =?utf-8?B?UmNPK1E5YnBwbDN2RXNLSzRXZS8yY2cyLzdGWjRzRnRGUlFOVGdmajA4T2s5?=
 =?utf-8?B?MjZNc0JWREdlR0FSNXp6cGhyRU9JekIzMHBKbExUTjB1eDZxYURsYkhMYzh3?=
 =?utf-8?B?UENVSVV6QmVUZXJNcW1zbU01dk5SNlB4RFF2T0ZDT1l0NFpxbE9ja2RFUm9o?=
 =?utf-8?B?K1pNQWV2ZkEreEpwUC9iRzNIWWJsNFl3KzZCdXlVcnBWOHhPRVdwSFRBNm1t?=
 =?utf-8?B?bTNPQkxaRUx2K1BsblZuU0VvNzF2T1ZRTXp1M25LU3hsOXFUTlYzdDl2WWQz?=
 =?utf-8?B?VitRT1ZjOFA0M3E2QmQ3OWpET0s5bk5Rd0YrNHAvVHZvVnJ0alc0OWJvbE5K?=
 =?utf-8?B?dWFkS2c1bi9YWG04TU1jYlR5c0VLZmtIbCt0TkNtdmpoRzZoank0UFZDY3cr?=
 =?utf-8?B?TDVTL3NOeEtQbXE4UVA4Sld5dDQwaEFWQ05NNXJhN3dmL2xSN01VRjNaSzdG?=
 =?utf-8?B?S0ZHYVM2T2NJYUVwTFc5WlJVTzRMelhVSGlPZHdZQ1NGVWxhU3NleEk0OVY3?=
 =?utf-8?B?ZVNzTFFjTjA5dFNIUW1BU3Q1SU8zY0RrMk8wRm5lcGd3blIyWDdsL2liSlVt?=
 =?utf-8?B?NnhVZVB0Qk5JS3RvYkNMNitRT0ZnRmdNUnI4YkRqbFdQSXEweFdLV25YUnZ3?=
 =?utf-8?B?QmxMc1Z1MERtejNDQ2tnRWdJZVkzYkoxcnJadksxbkk1NVZNMThubWRWampU?=
 =?utf-8?B?aTRZUDJKSHN2SnRLdzh4V1hDTEYzNXBxc21yUXhiNkM2MkZJVTg5TEJadFly?=
 =?utf-8?B?aDhyanJmVWhadXZqZUZZRnFaYjRXV29QUVRxUmRob05oV1VjcG9SN3c3NHFO?=
 =?utf-8?B?TkxjZjhLTXVDR3dvOGFpT2x5aThKcVBjL1ZZZlN4bHZyOUxPbUs3MStlbTJC?=
 =?utf-8?B?elQzVThyQktZbktaYUd4NkFPVndDL3h5Z1poODhTNUxYdk5lRVhxZWQzOXJp?=
 =?utf-8?B?ZXZkMisxYmJDNXkzUldVUzBKTTlGK1NZMHc1NHJNdlFLQ3NhMVRueWpCc3ly?=
 =?utf-8?B?QVpNMVp3cUNFcEtQMmxLbzQ2eXVnRG5OWXlsNWdCWVpjaHV0amdxaGlZVjlp?=
 =?utf-8?B?QVphZEE0THFEZFU4VU1Bd2QySlYyTjZHMFI3eUFTaDdrVjVJTXdkRG0vbHVZ?=
 =?utf-8?B?UjNWVXcvakhCaldubHArWnJyVnk2ZFQ3L2xUY3l6OUMwaFFEMEYyUXptemND?=
 =?utf-8?B?QnNsdUQvYW9CdVZZRGZtNjhGZmt3aGZSQjZwK3BnWXVEclJXWTY0cHdiMGpE?=
 =?utf-8?B?eEVwSEQwWVpPTDJNSjB2c0ppcDd3ZlkxT0VhTmd5QVM1cjZCSlFKdURvNTE4?=
 =?utf-8?B?bC9CaDcxMlhtWldqeE11QU1keVAzeTRiVXl1WHQ0VVYzKzZ3aTRVeWhDbEsz?=
 =?utf-8?B?Wk9oRHhYL3lVSUdXdUpmMnh3aDdjczdVaUI0bmVsOGNsREJaeXNMMGpFU1pJ?=
 =?utf-8?B?K2QzcFd4ME1UM3BMRjVOTkJwSjYxRk1WOEdSdnpyKzR2THl5SXFqeWJ5dXFL?=
 =?utf-8?B?T00rR2sxZTFRcUZvSFRRUHhpbVF0bE1MUzRSVDh6S0VjNjJxMkUvSzRRYzlj?=
 =?utf-8?B?OXlhT3MvV2FrdG8yVnJ2d29YbGl0eGc3a25ReXd3YTJyM25TN2dWZWszd3pE?=
 =?utf-8?B?a3dGUkxpYjd2U2w1QUJVN0FSeVZKalozZ3FkZz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(35042699022)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 11:08:24.1458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dc237f-ffc5-45ed-f6ef-08dd78e92d7f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10449

On 4/9/25 12:38, Ingo Molnar wrote:
> 
> * mark.barnett@arm.com <mark.barnett@arm.com> wrote:
> 
>> From: Mark Barnett <mark.barnett@arm.com>
>>
>> This patch introduces the concept of an alternating sample rate to perf
>> core and provides the necessary basic changes in the tools to activate
>> that option.
>>
>> The primary use case for this change is to be able to enable collecting
>> per-function performance metrics using the Arm PMU, as per the following
>> approach:
>>
>>   * Starting with a simple periodic sampling (hotspot) profile,
>>     augment each sample with PMU counters accumulated over a short window
>>     up to the point the sample was taken.
>>   * For each sample, perform some filtering to improve attribution of
>>     the accumulated PMU counters (ensure they are attributed to a single
>>     function)
>>   * For each function accumulate a total for each PMU counter so that
>>     metrics may be derived.
>>
>> Without modification, and sampling at a typical rate associated
>> with hotspot profiling (~1mS) leads to poor results. Such an
>> approach gives you a reasonable estimation of where the profiled
>> application is spending time for relatively low overhead, but the
>> PMU counters cannot easily be attributed to a single function as the
>> window over which they are collected is too large. A modern CPU may
>> execute many millions of instructions over many thousands of functions
>> within 1mS window. With this approach, the per-function metrics tend
>> to trend to some average value across the top N functions in the
>> profile.
>>
>> In order to ensure a reasonable likelihood that the counters are
>> attributed to a single function, the sampling window must be rather
>> short; typically something in the order of a few hundred cycles proves
>> well as tested on a range of aarch64 Cortex and Neoverse cores.
>>
>> As it stands, it is possible to achieve this with perf using a very high
>> sampling rate (e.g ~300cy), but there are at least three major concerns
>> with this approach:
>>
>>   * For speculatively executing, out of order cores, can the results be
>>     accurately attributed to a give function or the given sample window?
>>   * A short sample window is not guaranteed to cover a single function.
>>   * The overhead of sampling every few hundred cycles is very high and
>>     is highly likely to cause throttling which is undesirable as it leads
>>     to patchy results; i.e. the profile alternates between periods of
>>     high frequency samples followed by longer periods of no samples.
>>
>> This patch does not address the first two points directly. Some means
>> to address those are discussed on the RFC v2 cover letter. The patch
>> focuses on addressing the final point, though happily this approach
>> gives us a way to perform basic filtering on the second point.
>>
>> The alternating sample period allows us to do two things:
>>
>>   * We can control the risk of throttling and reduce overhead by
>>     alternating between a long and short period. This allows us to
>>     decouple the "periodic" sampling rate (as might be used for hotspot
>>     profiling) from the short sampling window needed for collecting
>>     the PMU counters.
>>   * The sample taken at the end of the long period can be otherwise
>>     discarded (as the PMU data is not useful), but the
>>     PERF_RECORD_CALLCHAIN information can be used to identify the current
>>     function at the start of the short sample window. This is useful
>>     for filtering samples where the PMU counter data cannot be attributed
>>     to a single function.
>>
>> There are several reasons why it is desirable to reduce the overhead and
>> risk of throttling:
>>
>>    * PMU counter overflow typically causes an interrupt into the kernel;
>>      this affects program runtime, and can affect things like branch
>>      prediction, cache locality and so on which can skew the metrics.
>>    * The very high sample rate produces significant amounts of data.
>>      Depending on the configuration of the profiling session and machine,
>>      it is easily possible to produce many orders of magnitude more data
>>      which is costly for tools to post-process and increases the chance
>>      of data loss. This is especially relevant on larger core count
>>      systems where it is very easy to produce massive recordings.
>>      Whilst the kernel will throttle such a configuration,
>>      which helps to mitigate a large portion of the bandwidth and capture
>>      overhead, it is not something that can be controlled for on a per
>>      event basis, or for non-root users, and because throttling is
>>      controlled as a percentage of time its affects vary from machine to
>>      machine. AIUI throttling may also produce an uneven temporal
>>      distribution of samples. Finally, whilst throttling does a good job
>>      at reducing the overall amount of data produced, it still leads to
>>      much larger captures than with this method; typically we have
>>      observed 1-2 orders of magnitude larger captures.
>>
>> This patch set modifies perf core to support alternating between two
>> sample_period values, providing a simple and inexpensive way for tools
>> to separate out the sample window (time over which events are
>> counted) from the sample period (time between interesting samples).
> 
> Upstreaming path:
> =================
> 
> So, while this looks interesting and it might work, a big problem as I
> see it is to get tools to use it: the usual kernel feature catch-22.
> 
> So I think a hard precondition for an upstream merge would be for the
> usage of this new ABI to be built into 'perf top/record' and used by
> default, so the kernel side code gets tested and verified - and our
> default profiling output would improve rather substantially as well.
> 
> ABI details:
> ============
> 
> I'd propose a couple of common-sense extensions to the ABI:
> 
> 1)
> 
> I think a better approach would be to also batch the short periods,
> i.e. instead of interleaved long-short periods:
> 
>     L S L S L
> 
> we'd support batches of short periods:
> 
>     L SSSS L SSSS L SSSS L SSSS
> 
> As long as the long periods are 'long enough', throttling wouldn't
> (or, at least, shouldn't) trigger. (If throttling triggers, it's the
> throttling code that needs to be fixed.)
> 
> This means that your proposed ABI would also require an additional
> parameter: [long,short,batch-count]. Your current proposal is basically
> [long,short,1].
> 
> Advantages of batching the short periods (let's coin it
> 'burst-profiling'?) would be:
> 
>   - Performance: the caching of the profiling machinery, which would
>     reduce the per-short-sample overhead rather substantially I believe.
>     With your current approach we bring all that code into CPU caches
>     and use it 1-2 times for a single data record, which is kind of a
>     waste.
> 
>   - Data quality: batching increases the effective data rate of
>     'relevant' short samples, with very little overall performance
>     impact. By tuning the long-period and the batch length the overall
>     tradeoff between profiling overhead and amount of data extracted can
>     be finetuned pretty well IMHO. (Tools might even opt to discard the
>     first 'short' sample to decouple it from the first cache-cold
>     execution of the perf machinery.)
> 
> 2)
> 
> I agree with the random-jitter approach as well, to remove short-period
> sampling artifacts that may arise out of the period length resonating
> with the execution time of key code sequences, especially in the 2-3
> digits long integers sampling period spectrum, but maybe it should be
> expressed in terms of a generic period length, not as a random 4-bit
> parameter overlaid on another parameter.
> 
> Ie. the ABI would be something like:
> 
>    [period_long, period_short, period_jitter, batch_count]
> 
> I see no reason why the random jitter has to be necessarily 4 bits
> short, and it could apply to the 'long' periods as well. Obviously this
> all complicates the math on the tooling side a bit. ;-)
> 
> If data size is a concern: there's no real need to save space all that
> much on the perf_attr ABI side: it's a setup/configuration structure,
> not a per sample field where every bit counts.
> 
> Implementation:
> ===============
> 
> Instead of making it an entirely different mode, we could allow
> period_long to be zero, and map regular periodic events to
> [0,period_short,0,1], or so? But only if that simplifies/unifies the
> code.
> 
> Summary:
> ========
> 
> Anyway, would something like this work for you? I think the most
> important aspect is to demonstrate working tooling side. Good thing
> we have tools/perf/ in-tree for exactly such purposes. ;-)
> 
> Thanks,
> 
> 	Ingo

Thanks, Ingo, for the detailed notes. Your feedback is very much 
appreciated.

Tool Integration
==================

We've been using a python script to process the data into a report. We 
can look at implementing this directly in perf report, if that is 
required. However, I'm nervous about making the new feature the default 
behaviour for the tool.

This feature has been integrated into our tools [1] for the last 12 
months, and has received a lot of testing on Arm Neoverse hardware. 
Other platforms have received less rigorous testing. In my opinion, more 
work would be needed to validate the PMU hardware & software 
characteristics of other architectures before this can be made the default.

Burst Sampling
================

I like the burst sampling idea. Increased I-Cache pressure is an 
inherent weakness of this sampling method, and this would help to 
alleviate that somewhat. I'll add this in the next spin.

Period Jitter
===============

Yes, we can apply this to both periods. I will make that change.

I'm not sure I've fully understood your suggestion here. In its current 
state, the 4-bit jitter field acts as a base-2 exponent. This gives us a 
random jitter value of up to 2**15. Is the suggestion to change this to 
a fixed, absolute value that can be applied to both long & short periods?


Thanks,
Mark

[1] 
https://developer.arm.com/documentation/109847/9-3/Overview-of-Streamline-CLI-Tools
