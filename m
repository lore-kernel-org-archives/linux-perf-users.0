Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67ED226556;
	Mon, 10 Mar 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624091; cv=fail; b=YyzADWTflmEYaDXnBkXe2uCQIB9cOjAwDaD3dh7UAQ0z7572AcPjuEqVnYsHFi/LCELweFzeSwBfYDA4jANJpNPO8lfZB4vdPfyEID8PfJ5hZk8JB/svaF3buyibQnaWmvnfQLXl9GjJpLPxTev9fx2i9N9JuGnrnfcF8R/ITRw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624091; c=relaxed/simple;
	bh=AwlJuLbjEsHDDxNBKYtGwDPsguXS/Wi7jH/dPDEUav8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dL4JWqrSBqEjc4koHYtBOYLMW74P//KOuTGI/ohhUjr/Vlh/AHb5FIdJBdnDwjLPp8Zk/EaNu6wTTLkvpT810lp6K5QgiIfR6FETwtxOoLZOZ9P4CRCDZ+rYbI3zBabuS4H7IJwuyjXehFBDfw8b36w5focFArcWC8nmC9R+jzE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rIsDiQL6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rIsDiQL6; arc=fail smtp.client-ip=40.107.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rIsDiQL6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rIsDiQL6"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Dgpx/8k/sPIz6E9RclWgVjp2B6NFKLQfGem3zxaWC/Ljqp2vMODeeNs6kOnM483kQCqxFfCydOs+PnVk3O2p8tYoNU5t1O6lPZ5Rm14H3/3SvMErTFBySmIWiGMCkTKRVfdmloQGRKrVYHcd2aEhAiC1Z9fyeq+9VhnLmeWVlEV10rr/L+jJj3l+lFSqlxdX6dWgKLSxYKhUJ/xnBwQ2DDWK4rwqvY0hYyWkRXiVp9meQDwmg+0voJVrgQfs71wG6yh5Qg808Dt6VJNADOZfLUX/JnuCSlxQ7XXjh7B0dls9AGW1we5VjZN/1xWBLzB+hrZEJt9QHac6wCZsb9nf8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ACru2Fv/wc9B72VckRpeA0qj1sPWiHVQ32AE3+dcC4=;
 b=LACF2TKo7BxDZ7nVVO4V32DcjGETCTpQ5it2oylacAM9C+NcVcnKdKe6oTspQK2edQATjcu5UzhKZx6NfID/jV0MkJu8nQIVuy2YtOWYarRYwCHiExov0zGkzK2CG8vEAFAq2tbraXOZsFV+A0fTFmcfBCxAEyQWeHqzSqOoI3sb39gICf2USA8itznHkjMyjuMBfS5W8HQAxGdU5hL6lHMSTDIDIHBhgwo+ZdtdmvcN6rVD6xvGE970sUeeeSWybLmKxJKtWHXAnC6pY5EIDKPze2Zz1eyAWEv+VMgMHh7onF3jXEy4QtVFbrfSMyt8Yk5DXTiif66BH6AgGm42nA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ACru2Fv/wc9B72VckRpeA0qj1sPWiHVQ32AE3+dcC4=;
 b=rIsDiQL6s730IuaCRyzIrjlNRiVBcraUZbn0bszUTfqHzoDzvYdrsv4SZSd+wH2qc/LWm+aUCjiMYx+8vsUHzq0Qlq3phQFzjpljfl6mX3tc8Y8iGDNrNckJYZEpz0QMBq34xNkG1qZUIGDLLNIFGnxW/uQRkgsbVjgAJlh9gZQ=
Received: from AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::28)
 by GV1PR08MB10905.eurprd08.prod.outlook.com (2603:10a6:150:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:28:02 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:150:cafe::f7) by AM0PR10CA0048.outlook.office365.com
 (2603:10a6:20b:150::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Mon, 10 Mar 2025 16:28:02 +0000
Received: ("Tessian outbound bc832f6acacf:v585"); Mon, 10 Mar 2025 16:28:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 43fedfe3853d5f5a
X-TessianGatewayMetadata: BR4u9AYK4DBuzZHOhTd9B2g+l9Bk+2+hCBALlANdJvnjsoqDy6C3Z6sIZEuJrDdTOJNoZTpzZ65Zl+4pVLpEN1v5YqkQRaUNfjmIbPWjQWlQLfpykEviaz7/IUO1wNWJRguzsmmSMO7RHmSlziC2VCiMswiyIpUkJ0+NgOKei84=
X-CR-MTA-TID: 64aa7808
Received: from L9e50b749c071.3
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 675D28DF-5710-48E6-ACF4-6228DF858684.1;
	Mon, 10 Mar 2025 16:27:51 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L9e50b749c071.3
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 10 Mar 2025 16:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3GummD7fbLmpo7uBvyWxvV/JV+MpS7teUcsatHFqdD+/W101H49dunexMFQ1sDNzx4jLksEwdcUQ0SjmWFbSL7if0kD0ADabH2v5/HBOid9GUoqZ/u2THSFJgvWJ1Kh7jj7j+08WibrFarmlUz3plPMkNHK39SeB8Fgu1gWEkASvFaT+twSG4Y83pOESoVN2tiNpe3H5ZPB7Cu54BGB/XB0+Q891fxTChfxoIRba00Pb1geUvpHbfa2toYskymiKZLvNurGQjiQddRt+sa/E5kZrqL/hD9e7mumu0rb6ETVo/IXQ3FrBBKB4AP/zpBhtJoo6AKeHBJUkV7Imj7NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ACru2Fv/wc9B72VckRpeA0qj1sPWiHVQ32AE3+dcC4=;
 b=E1PeK3ntL6ffnPZxMN9dSdWPUQyCNlCbODxc8HLozpPwaEagkAmejRJUO/EtGv/89Uc5H0s/h/ke09PlFhNao59ARsNYyIhaBYp/NVSDa5vqFhqdzphoMC93sl6zYt2ciJv2Bm1qC+FbTsh1b2KWwxaAT3baplOYyLBrFGqYU1dDoklwr/LhPfjuuzMYqYX0sbvW19wqTzebQGuFWlWEOtrXYhCZuP6JEWTUzevWqvmn3pTeJrQEkhLsIErxBz709fxgxoPdEXDMCAou1ZYuqWd+FjifGyyQiWdR+9hh7a0RmVdVjdTCuig23YTOHyVsZqm41U0ter1545EaL1yfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ACru2Fv/wc9B72VckRpeA0qj1sPWiHVQ32AE3+dcC4=;
 b=rIsDiQL6s730IuaCRyzIrjlNRiVBcraUZbn0bszUTfqHzoDzvYdrsv4SZSd+wH2qc/LWm+aUCjiMYx+8vsUHzq0Qlq3phQFzjpljfl6mX3tc8Y8iGDNrNckJYZEpz0QMBq34xNkG1qZUIGDLLNIFGnxW/uQRkgsbVjgAJlh9gZQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6)
 by PAVPR08MB9330.eurprd08.prod.outlook.com (2603:10a6:102:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:27:49 +0000
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb]) by DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:27:46 +0000
Message-ID: <73edda3b-7305-4903-8950-8528c94051b1@arm.com>
Date: Mon, 10 Mar 2025 16:27:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
 ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
 <20250310124735.GR5880@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mark Barnett <mark.barnett@arm.com>
In-Reply-To: <20250310124735.GR5880@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0298.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::15) To DB9PR08MB7584.eurprd08.prod.outlook.com
 (2603:10a6:10:308::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7584:EE_|PAVPR08MB9330:EE_|AM2PEPF0001C709:EE_|GV1PR08MB10905:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bab3d5b-6acc-4682-b9b9-08dd5ff08785
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bTg2TGxxL2N6d1hDK2dwWGRwUGF4bWFTUjlmaE1rTGR5a0dZbGNJd1M5QXd5?=
 =?utf-8?B?YW5KMDJYS1JvYmErZ0dKL21aT2F1bEcyRTJTR2Yrc3VtWTExam8ydStwcDVs?=
 =?utf-8?B?VE9ZWDRNMkRtSmNLbFlsWEV2YS9hYW9LSCt6V25WTEE3NUhjR1lFbmFYaU10?=
 =?utf-8?B?K1lyUElpc1pIeWx3MVc1VzRzWXM5ZUJwMStKNjU0T2FTRjZibDFsR3NCcnMv?=
 =?utf-8?B?MWgrUWl6bXdobURrMlB3UmIwRkpJc09RMVIxbjM4K3Q2SlhxTjRZZzlXUGlQ?=
 =?utf-8?B?QjlWTy96aFh6dkhEU3MzSlFIYUVGS0ZUNWZ0MzBhd3hOQTh1bGdXTTY4SThM?=
 =?utf-8?B?L0ZPeFp6REs1OTR3bnVFQzNJQVdWMVdMSTZRTnhWT2NIODRUTXVUTU5kTTdj?=
 =?utf-8?B?NEFBc2pOOVVLYk1vRTNHSGxRNUhXN3cxaDhGSVRpU3VUTVBWZ2t6YkxlVEZX?=
 =?utf-8?B?Z3ltN1lFckRxKy8xNXlYSk91aTl0bTlhUTNBVEo0Mm5FQXVlMjBLN1lOQzB3?=
 =?utf-8?B?Rnp2REpjSHo1MTlxcTF4SE1NVktKdnRkeTJXMUNOaklSVDFHbjBBcytFemh5?=
 =?utf-8?B?ZElVZjNKM01xNGhwQ3FuenlhNUo0bzJzbDdkMmNsNVFNQWdWYzZ0Q1ROdm8y?=
 =?utf-8?B?ZUw5Tm4rdm1jaW8yMXlGdGQwVFVYVU9LT2NXdjQzU2tZbXVMRDNQNVZvZGMr?=
 =?utf-8?B?UldRZWkzRkpnV1hTYXFub0lXTkpkR0xYMlIrUldEaEZmWlp2SldybFNSK1Rm?=
 =?utf-8?B?RmpqY0FTRGFudjJPWFVqY3JPUEtaZ2xsZXd1ckVRY0R0Zm9lb3krVHdNM3lS?=
 =?utf-8?B?N21XL2pubDRQUzN4ZVVIQWNUWGwwWEFaUzBMeHIrZUVFbDJBQ1QybW11elpI?=
 =?utf-8?B?Wjl1T1FoTW8yV1BpNFBBS0NtUHc1Uml5Z3Zqbm4vdGlNS1NEbCsrU2NvT3dy?=
 =?utf-8?B?TGNVTndhTDNlNzI4cGdxRE9zTlJBbmxvcTcvQTNSM0tOc29HODU3c3kzT2VT?=
 =?utf-8?B?QVkyMmlROThyR0x3WTJPRCttcGpUNWVqQ0RzREdJcXU3aE1FOVpKRkhkcm50?=
 =?utf-8?B?bWUzUnpZWTM0R3F1dDJVS21URG5ENWFUU1BQT1FpRk51ZHk5Nm10WitWbkox?=
 =?utf-8?B?S3N6ZUIxakdXZE5OazU5bmxnWHJUS1pqQjJWb3dBUnptMngxRDJ0MTFpUldZ?=
 =?utf-8?B?elVab0gvUGUvSEw0TEhGcXozVFlNNFluWTNIaExvcytHVDhxOWtxR1JHZVpK?=
 =?utf-8?B?b2pMb1Exc3ZkV242b3JXVmloUlNNMzRzMXdYQnVjR0UvM2FHVk1zNzEvTXZF?=
 =?utf-8?B?V1ZZK1pNeU54bzREQTNTMTdLOGJYK0RWU1g0RFJCbkMrL0tLWUw0WjBBRHB6?=
 =?utf-8?B?TDdoUGVCUWRhK0R3RVc0ZWhLMEJKSk9BRFA4QzJEVkN6VFRDUjdZdjZWUFAw?=
 =?utf-8?B?SmdaSElZOGZpbWIzWFZReG5udzlSdEpOYWIrUzBiZWZaYXdVK0ZtbGFaVXZJ?=
 =?utf-8?B?TmdrbEZhRVJWUzlERkdVdXJTLzBSRFovU0RTQlpjSUd2UWlaMzF5Y3BqbzQ5?=
 =?utf-8?B?L2E1QmdHbU9vMklCSmt3SHlVQ3F1Z3pGQU9BKzNSZ0lJT09RSjdGRGQ1L0xt?=
 =?utf-8?B?VFpIeElwUG9XU0NYNW1RUHprVkxaR3RqRkx2dVJJVGNFdW5oaDFPcEJXaTZG?=
 =?utf-8?B?UnkvRXdlWW1EUVNvOWp6d2FhdFBnTjlPb1BBdGtRMFBDTmtOck9iNTZzK0dQ?=
 =?utf-8?B?dzhPWXlZMzZaYkYyZDJzQUhRV2lBaFJMMk5HaytDOENvcGd6YWlKVWFOQjVr?=
 =?utf-8?B?NjgxaXFNUWFTdlJRNEpCUktWVXVyaFRqVEFPRHN5T3dOellGTy9iZHNscVZ6?=
 =?utf-8?Q?7X+qZF/f+Pgfb?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7584.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9330
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:308::6];domain=DB9PR08MB7584.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	737ace40-b140-4101-a2d5-08dd5ff07dcf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0ZvODZVYmlmaHg2d0RrcVFDUjV5Y3lRU1lUYnFTOHRocmFmVll0bHROOG5k?=
 =?utf-8?B?bnByWG5pbE1LZ1U2aFJxNk5SQko2NUZzUk0xVmZKRnBUbC9lbGxZYWFvTGcy?=
 =?utf-8?B?a0xBOSs2Z3U0RXI1MXJHa0tRcWR1Ynoybnh5dGN4clZzV1NhR0t6cGJvN3RM?=
 =?utf-8?B?aE5NUlZobitaeUxkZGlzT2c5OFNOc0JLWkJJS1dIRE1EcW1tRWUxa2NaWFJY?=
 =?utf-8?B?SUFEK3FrMUhnOXFkUWx4R1hVak1meWJXdExLM0tIbDMzMXZlcjVGdnRPYjVi?=
 =?utf-8?B?VWJxU2o2NDNGR0pqVTlEMDY2K2ZRVlZtRTRoR1RGU0lIQXEwNWd5b1h0cTVW?=
 =?utf-8?B?aGdFMy9xSllaL0pNbFhMRjlOK2NLb1ZXRE1aWEtnaC9hU2l6eHRPNkhoQzNJ?=
 =?utf-8?B?TFZXbUN3WTdqMlZ4ZTVNT29vQU5NcVkvb0hBWXpVQ3dVQ1pVWjdHTnhFSThQ?=
 =?utf-8?B?eDVPVHowSW9aeVFGcm9iS1NsN08rTTBPWkkwZGF3ay9RalhGbmF5VytHdzBI?=
 =?utf-8?B?RSs2dG5jOVdYNm9UcjAxV1pwLzFEOVM3VUQyNm9QN1E5L2J0ck5ETHlUdnA5?=
 =?utf-8?B?aWZxTmZmVU5PaEJHMmF5dlgybjNEcFpwUTlEbzIzSWYxR2VsT3pyZGZmcnBC?=
 =?utf-8?B?a0Zwb3lUVHVMYWhvWkVXYjliUUQ1ZWlLTXArb09ZdXk2VHQxQlhzbXJoODlG?=
 =?utf-8?B?a1hoUjlMUUp2ZDFOMTErRkR3bUpja0V3WStub1ZDRG94S0c0ZGFtVjhaeTZ4?=
 =?utf-8?B?RG8zRHJUcnJPM21vY1JSRCsyTXJWUG9QOVNxVjByN2JTc245ZzlidW53dFc3?=
 =?utf-8?B?aCs3VUEvUWVuVnN0NC9keHFIaEt1UzNiOFFmRDVJTTRYMGRjVTRGMEdKRmx1?=
 =?utf-8?B?UFpCUGFCOWp2RTFpdnV4c3ZuVld3aERkL210eHBGcmtMdUV1Q3NueUZTM0JI?=
 =?utf-8?B?OWRJUzJLOHNWRjhNdUMya0JWQlRuaTA0QVhsME1rQ2FYb3ppZWJVcmtHMXJL?=
 =?utf-8?B?MkE5cGxHR0h4UEVFVUdCWGVBUzZIOHcyVnRBZzc4WWJGblg1ZHh1ZFhGdFlO?=
 =?utf-8?B?K2NxbVVla2E3djZyVHh1azg4OVBNMGJJc09kOHNIT3RtbnRLa0xoZ3prbEtM?=
 =?utf-8?B?UmQ2UjY2UFdocDFCeWMzSWNLRk8rN3JXVy8wKzBqYUxxZVpzK2VvcWI5SUJ6?=
 =?utf-8?B?Nll4YTRjQnN0b3ltVXVIU2VUczRDOWZidjF1REZuQ3pIOVhmTnNsU01kN3Nu?=
 =?utf-8?B?RkMrK0twMUc1RW1BbE1WNWhRM0ttdmpVTDlQSVJZTVVMMnBKbjZRMDFGUDIr?=
 =?utf-8?B?NENieUhmSUt2eHRhdVN0ZE0yMTd6TU05VXJTUWpjTmI0ODdjVm03RG8yVGRH?=
 =?utf-8?B?OERuc0VYcVdVSnp6V1IzZTJqRktLK2lwMGRpTWF5RTJ2WFhlSncvMUozNnZn?=
 =?utf-8?B?UWJBMG1xaTRCMCtsc212YTZEc1RQRTFzanByaXpBS1A3NWVDRlFvSWdOMldQ?=
 =?utf-8?B?Q2dYdlBudVpKRUdRM2l1TFNaSUF2U3Z3NzlmSWVZYjl6UDFoYlY2KzJGbU1j?=
 =?utf-8?B?a0YvemVreXd4aFplVEVpY1pBbEFvZ3FlVDlsdHYzeVBuQjE4Rk0rcTc5QjNk?=
 =?utf-8?B?dUpmcTdOMnRwZjZid2NBRWUwUFoyN0tmWEp2M01Bc3c3ZUU4TlkyNGRzUVA1?=
 =?utf-8?B?TTVZUEhRbHJqNnJmSHkvSnN2ZU04aTNkUUpKY1lzbWxLTzVGNzc3eFdaSHBF?=
 =?utf-8?B?ZFJzNjhZMVRMZGZFTEUwaTFmekxsaTNpdkdETUw3NE8xTTNGdWVKTnlabkJs?=
 =?utf-8?B?R2E2LzR6WFc5MmtPZVI1WlExcVVaSVhDcXpOc1paZTFCeENHNGNXdDNKZnFH?=
 =?utf-8?B?WTBRNXZCNUVUbWxhR3FHZEZOWVFoeG5qSTlUZVlTbXl4Sjczb28vUUxCV3hj?=
 =?utf-8?B?b3JISXRUOHZna2FNTUlwYzZXb0xRZlNVRjVtY0VqUW1US0NRVUNpRWJYbUVD?=
 =?utf-8?Q?IFjOERw4BXIqeitZMbDzMrXmcoeJnY=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:28:02.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bab3d5b-6acc-4682-b9b9-08dd5ff08785
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10905

On 3/10/25 12:47, Peter Zijlstra wrote:
> On Fri, Mar 07, 2025 at 08:22:45PM +0000, mark.barnett@arm.com wrote:
>> @@ -9922,7 +9923,10 @@ static int __perf_event_overflow(struct perf_event *event,
>>   	if (event->attr.alt_sample_period) {
>>   		bool using_alt = hwc->using_alt_sample_period;
>>   		u64 sample_period = (using_alt ? event->attr.sample_period
>> -					       : event->attr.alt_sample_period);
>> +					       : event->attr.alt_sample_period)
>> +				  + (event->attr.jitter_alt_period
>> +					? get_random_u32_below(2 << event->attr.jitter_alt_period)
>> +					: 0);
> 
> So, ... this here is NMI context, right? Have you looked at the guts of
> get_random_u32_below() ?
> 
> I would strongly suggest you go do so.
> 

Good catch. I think a pseudo-random generator would be fine here and it 
looks like the implementation of prandom is safe to use in an interrupt 
context. I can change to use that.

>>   
>>   		hwc->sample_period = sample_period;
>>   		hwc->using_alt_sample_period = !using_alt;

