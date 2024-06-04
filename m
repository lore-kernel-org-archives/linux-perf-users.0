Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93BD535;
	Tue,  4 Jun 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521294; cv=fail; b=b/J2SRAUF0dl/NlYS5zIKqvX6T5OYYK/+NncwYL3yrKM70KbXHAU8agsVgpezHSxjyEAQ+uWH338/BTnBMbNrCOuZEfCkvb4qgZZxjNtUz71SFLYuWnL/9TXG6eDWqYDLibFAjaWTZOsaJrqVJBsa3nMENehnbZi2TW5xcetzlA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521294; c=relaxed/simple;
	bh=r+naqzfRwt5Ffoq0CGaVFVrzOoUNUgTUO7LvL5HpOmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=byFlS68pQPHGZDfXJCs9aNLXyUVeHETAGtPBwVZ3GYo6pl2xxMuCmN982JGfZC31tgm1W9DNd3gIEO553zXG4hR8AphlL+lO6JMNkn20rgNyJKznDFQ00ynCUT+d6HG3ZBprnXjsu7rJtYwbWiRAcCkGynnuV00/602nCRL4rlg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ib3GaNUv; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ib3GaNUv; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ib3GaNUv";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ib3GaNUv"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WLKboIycXFdyc5EmsSO4CqBmxrAAdSKj178/yZ4gEHD1DD46lXWq1PpckA9PlFacWPqas2C60CGo32RcV5cwiQGMIibgjRvltY/SYJnsZsl4ZxoAmWst/DsMP6trPbGBaa2V0BVNNwbhFk15Em+XE9vHTBAXyCnrApTAgAZcgthMXNWuvRQIn8O+2qopUt2gBpjRr4CyavLsT+2MD5TUVFI4up+/D5QMoZKLuMV3GK9dnnLu7YsJb/LiGJdwmtM0ze+u/+aN3IvgUCv/dchncqFRgjSDvI1bo++65UNuTysWyObwFArIJ2QSq3uZR93mtDPL48KqXFSIXTBfsebNLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEdgidZ/BDhhCQ7XSKzuKeKADlbulcLzqSpBxtzqPS0=;
 b=ODNt27YhgIya7OYiZDBtGVlON9j0f6dqGy7tVdgM67sBUSo11sGEDUbgZHe9/2v4A30fXZBFgJJtFq7Q5QwwIceZ8B49iys9Nu/hxLr6rJsv2aTPs/xnI425jzx0QnO2qiJ+Nblk2FgMda4YebXmV300iCIhmgceCXzd6n3kXqeZWHOoVJ41V19FIZExjXGBN0PQSPkk7g0HdJyzht51gcYPR4WnqhJgUjaudSZtntvKgNiFBo/bX2mBNoLsVjQb/u57tnoAccBsfi7vrRO5g67QlI1Np5qdwT7FyERWFUmotkpPtn5LhBLwFwu9vTwcw2sjPmQ+CPMSkmK0FFOoVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEdgidZ/BDhhCQ7XSKzuKeKADlbulcLzqSpBxtzqPS0=;
 b=Ib3GaNUvtmBRppjeIIWuex2PnAshfmhcHjCi6L38rCPmLOY0gpXsADvWC2mx5g+hWnM4Z/UkB1OBBieLBYys0QqdcIezuntpnZvuIwtOlK//gnZrbYzOwipl2iZuHM60x81fZ97tf78uX2QoZ9ZMvUOr5i6yJkgjCTX83Dkp6jM=
Received: from DU2P250CA0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::12)
 by GV2PR08MB8074.eurprd08.prod.outlook.com (2603:10a6:150:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:14:42 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::d2) by DU2P250CA0007.outlook.office365.com
 (2603:10a6:10:231::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Tue, 4 Jun 2024 17:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Tue, 4 Jun 2024 17:14:41 +0000
Received: ("Tessian outbound db9e50018dd2:v327"); Tue, 04 Jun 2024 17:14:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7ea69185574911e1
X-CR-MTA-TID: 64aa7808
Received: from 9084580b6eeb.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5B777C29-F4DA-4797-AFA4-6103640D9CC9.1;
	Tue, 04 Jun 2024 17:14:32 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9084580b6eeb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 04 Jun 2024 17:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9ZGQNlUcrvDzxGIJ4dZJvuOXhvlDKdWKaM5iG2vCB8xBEdhPlSIU9Uusg4wmyWsWh2YPsfifk2bo13XhIXt3thVGWVGCvNqqtm4BxKee1wNb77FcBiq9gu4XipAmRphi7X+xcX3C2CFHEGYfqrT9AqbHjRFaI38D5+W0Hy2fY33pB6xzfYawljNbWqjjrneAyUhAgQSCY3X8Rfh/KNa1QWb1eqXagR6aEgczbb7jCZt+L0gl91MaonO+sganOo4UkSFPLlanTJ1iE5GsiCl2xaGzXfVsTTiTm86nY1G4/p81gbEWHMs35tk118V/dKWw84xvOvZ2z/2hKTX4c/v3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEdgidZ/BDhhCQ7XSKzuKeKADlbulcLzqSpBxtzqPS0=;
 b=iXgpMaYT+sNmP5S/TbmqDxD3qjPGwa42l6GQqPVfF3x1XqiIj+Z/Xq5YJ2ErfBrhu0ysF/o1BqhOGMtRERsy2PsZkk+mlGoG8EJkYmMEsItBrzs/Sm5Oty0tu0lTjIb1sL9Xgr8nxbPveLKmxKSqsVBczKzatv+BrgeSZ6GWx/4RAI4KuwW46xE08o5P8Du5CqdVh9dZRJIBISqC3gBnYCrZppZzGbd7xwMEu9+2a8qQHVpdSqgm4cwyt/jEBjMhbMjB6UovYU3qg3cD2kdn4WjamaQdqNgjE0uiOnuhRxzGwYyZqvUrrh+WzQTxzctdXh3J1aGkphvHUR+R2Wfdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEdgidZ/BDhhCQ7XSKzuKeKADlbulcLzqSpBxtzqPS0=;
 b=Ib3GaNUvtmBRppjeIIWuex2PnAshfmhcHjCi6L38rCPmLOY0gpXsADvWC2mx5g+hWnM4Z/UkB1OBBieLBYys0QqdcIezuntpnZvuIwtOlK//gnZrbYzOwipl2iZuHM60x81fZ97tf78uX2QoZ9ZMvUOr5i6yJkgjCTX83Dkp6jM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13)
 by VE1PR08MB5712.eurprd08.prod.outlook.com (2603:10a6:800:1a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 17:14:25 +0000
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad]) by PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:14:25 +0000
Message-ID: <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com>
Date: Tue, 4 Jun 2024 18:14:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
To: Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>, Will Deacon <will@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>
References: <Zl4MYzhP0NB-Z1DW@x1> <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To PAXPR08MB6591.eurprd08.prod.outlook.com
 (2603:10a6:102:150::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR08MB6591:EE_|VE1PR08MB5712:EE_|DB5PEPF00014B8B:EE_|GV2PR08MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 432e44af-0010-4d62-df5b-08dc84b9d2a4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SjE0UEN6dWgzbEM0V3FhUC9NS254dVkzWHlYQVB6dFFKWkVFaDc0VnZaNVN6?=
 =?utf-8?B?VWtGd1R6SS91R0RwL2sxZkUxK0ZpYUFpTWdvZ25TQUdEek5PQ0E2bmJFeCtL?=
 =?utf-8?B?ZEFybVVBNnNYUHlHcmRWNGkvWG4rS0d3QXBsRlozcHZzMmhsWnZDMzVVYnJR?=
 =?utf-8?B?dUNZaWpvTWFZM21uOFlmNzNwZ1NqaHhsUVVBdmVsTFFEMnBFdlppMHJqb3Y4?=
 =?utf-8?B?UGcvSUdvYi9sZHBON1JqbTh5YlRwWVcwOUpMOWZ3NFlXTHhtdUVpOC9DVjdz?=
 =?utf-8?B?eUNzWlJ3WlJOTGQrTlM0VmdXNmEyNU05Unl0MW9kbTdFVzk0M3JkdVV0azJx?=
 =?utf-8?B?b0tnK2JzSytZbGUyWlRZSUFmZFVKS0FKbTFtaEhRbmdiNlpSMnVUWTROVklX?=
 =?utf-8?B?ZTF6THJ3TnVyeVFvRkwvdElMWnNrdUVwL3NyNTRDaGl2d2VqMXJZUUlKZXho?=
 =?utf-8?B?VDZvZmplblg0NHVLdkZRYWxocjhJeGpHVEZZRHo2TnoxWnFLMDBLVFdlY3pk?=
 =?utf-8?B?dnk2VFAvM2wzcWhtdEFLc1VrV3VzM2FZeUw0VEVJcDRQV2p6aGVMYWQveTRw?=
 =?utf-8?B?VisrQUtOV1V2RTUvWXIvL2IreGVOb2RiWFdYeU5FWmdxOUo0YXZhRFhzSzQx?=
 =?utf-8?B?RU5mQ3BKT1lid0VFbXdsYXhmRmtoWUE2NUhwMFJlWUlJNGx2dkU0V0hrenIv?=
 =?utf-8?B?ZEhlRmJFMUpKM0FiOEtTakNzRlpNRFR4NVlWMVF4V05vYkxSVzNXQTNrek1I?=
 =?utf-8?B?SnVQT0xSM1dPZ3d1MnI3d0VnN2lTVUFFeTZiOGdHUmx1ZUpPWDRDMUpydCt2?=
 =?utf-8?B?YjlpY1dBc1NTbmoxcjUyWVFFRGIycDBWT0poNkNoV1VkZGVDN1g5YlBJSWZx?=
 =?utf-8?B?STBWeFc4bS80WGxtTWRSRmdudFljOWgwWEZGSWRuWjBiVGlmMDlqeXlac09j?=
 =?utf-8?B?Z0FIUHN5SnF4cHZnaW5VTmNoNk1LS09ZZjJBa2Q5RmN0TmhBMkNQTVloUlpM?=
 =?utf-8?B?SVFlaFQ4aXYvdVFUQmdtc1hqSHdYTWdSVWdHU2IvQVZWd2FGbEhJWXU2WVpR?=
 =?utf-8?B?ZVZ5dVpmMmpNUHpxdkJKMXI4eUhBWTBrLytkTnhoWW1PVXVVUHdDL2JPcDdy?=
 =?utf-8?B?TEpjbDV4aFJHVDdQUUVBSWp0cEphN3lLcUNTblBqSkR5WWpQaGcwSGdJc1RN?=
 =?utf-8?B?QnIwYm14RlNWNWRjTUFJaDBVb3VacG9XNldWSDVjQ05jN3FIZDZ0YTdpa2VM?=
 =?utf-8?B?ZXpFOWkzVXdBSW9XUlNXRHB2UnAzVHQ3NGdHYktKbHo5MVhtNlAvb0xIaTFt?=
 =?utf-8?B?SHdyS1RVZmhpVzhFWU51b25KbkpYVzJ2VTJFRENJc29OVmFLZHd6QXYxK0RP?=
 =?utf-8?B?VjhSeUUyR3gzM1BNNXovamJyYldaa1N5V25PbERwb01GdGdvVm9WZS9VZGhv?=
 =?utf-8?B?ZVpISUhoY1BKbDM4Q0RKTU85V0NiVG0weU1iNVpCNGxVZ2dvZTZyTkcyZVJ1?=
 =?utf-8?B?OWV6S1ZSd3RMeUVBcUdGVGp4TDg2R0RncWlnTHQya3VtV3F3WktQbzUyckxt?=
 =?utf-8?B?MVlOTUlnMzVjVzI1N1JOc0xUSmRVOUIwUkJDZjdsYnZuNmllTFNKZ2hnZWtE?=
 =?utf-8?B?bC9yNHpKckFFMGZhUGdUcFBBWEJ0aS9sbjRuRmMvaWxyY0FURE44WW1sZHJS?=
 =?utf-8?B?ZHZuK1ZhZjBWemhsQW9RaHJ1ZzUzMWpaSWw2Wk9nbjhrcWNYVkI1b0txQzZF?=
 =?utf-8?Q?r5Dmv2kcgJT41FwPfKnYBpWjEClfbSWGUuTB1Iw?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6591.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5712
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	daa94d6e-be55-478e-c39a-08dc84b9c89c
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZPL1RUcGRtL1FSWjdlRy96SmJhVEhtL1lTcGtsaTlwdGlqRG54NkxMaFd0?=
 =?utf-8?B?K0xUWG5iemFmVERmWlp3alQ4VUlVcWdOOTRLTEdJUEFnNkpZY1RRVk12QWxB?=
 =?utf-8?B?Y3JwOGFEM3N3SkxZQXJXam00cU9GdmQwR1B4bHhDVGp3cFYvMEk2ZDBwSW0w?=
 =?utf-8?B?T0VXMVJZUkhjSFQ3bGtoVmRWZnhsVGEwYUdrSXd5eE54M0MxaE5LQUtSMmJp?=
 =?utf-8?B?NVdDZTBxNE13RFlwcVlDRUxwVFYxUm1OV3hsTU5ieXZJSnpOUVRXNFpKRmpY?=
 =?utf-8?B?TXBKckNHaGc2eGRzbXFQaXc2ZUg2VnBrZmtSUEZTRkJIcWhJMUE1RlJrY2Zr?=
 =?utf-8?B?V24vZVQyU2NXV3ZTSWxFLys0VERvMmxWWDdqd21YbWhURmgxOGZTd2hldnFE?=
 =?utf-8?B?djFvelBjaER0Vk1jeVRvL00rODMrTkQ0VDl0RmZib2s3bmovVWltVlk3K2o1?=
 =?utf-8?B?dzJHRU1qaUNjcDFiUUs3eUU5cFdaSENZYXFtWnFGMlF3WFRpVHVjaEkwMFZR?=
 =?utf-8?B?S1pmYzV4dTI3UFRvMWRJZ3cyMGw5QTFwRlJWdVNCT0t3UU5OSW5ZTFUxNVo4?=
 =?utf-8?B?OTlSb0ZmOFl2QnZnb2VlMW15OVJnRjFTa0FBRnFIOGpMMzlsT2FDSitQWExN?=
 =?utf-8?B?d1oySVhuRFVLY3hrVzNlN0tackZVV292akVkVFRvT0grck0wTlBRb3czcW9D?=
 =?utf-8?B?ems1bmEzYkFKTGJXTFNQSk9tYnR6cDE2TGNVcUhxaTVTWnVMVHpNOXYya213?=
 =?utf-8?B?UUZyMWhMbW8ycC9tYnlsZXVvQVBhVi9hWkt6c2g4bVhVaEIwMkVFTVRiajRC?=
 =?utf-8?B?N2RDQUlkazVQNnBnT0pwY3BoaS9CNERKUzRPaGhwaEpWWWNaMDByRjBWNDNR?=
 =?utf-8?B?MmJ4YjY3REVnaldLeVEySHMwVDNUWjZEdEx5VXNDek1sL0EvOFhWZkFON1ov?=
 =?utf-8?B?Zi9wSHlNYy9pWmJUYzRjbWdJMk1nK2VMQlMwanhJalc3SkdBTksyTTVUcWlq?=
 =?utf-8?B?WXczZWdvTi95eEt1NS9XYUhvbUpPdFFEVlNhM3NkVjdnU0Z4Z1FDOTRkeFNE?=
 =?utf-8?B?Z3BEc2Q3YmdyancyM0NkZWNPSlVrRkFMb051YzVENG5zMk56WWlZdWxpMk80?=
 =?utf-8?B?eGhhT0NHemhZREpGd3REcmFYYVdUWXRhZ0ZObXFKd05oTEhnQ1VEZG10S3ZV?=
 =?utf-8?B?eGh6KzQ5dUJzcHBRY0JubmRiSng1SEpkR3Y5My9rZVJMLzhIQjV1azhkMjBV?=
 =?utf-8?B?NjhVTnQzaXNHSTZ4TUhyNGJueDAxOWhuM2p6eGpWbHhtSGNLay82eG1TNWpa?=
 =?utf-8?B?WVhjUWFOaFhEY3kxSXdUbHB4TXZERVNoa3R1M0laKzNpODNVMXdTR09IaXlG?=
 =?utf-8?B?S0JZaTlJNEhoNnpqMHhGN3k3clBjV2xUOFh2T09iOWd5WHBTMmRpTDVFOXph?=
 =?utf-8?B?VzZBd2s4UGtnSmJ1dFNYTUNUYjZleEM2MjBGazZoNkppUUd0U202eVJrMkQr?=
 =?utf-8?B?Z2Z4a3ZDWTFYYkZhVGtGOHp1bkF1d2hQRHhRRVpYNGo3VmxBdDJrVFpWK21N?=
 =?utf-8?B?eVZzdjBDZkpFNTFUSDhIVWJnLzQvM2pwNkNmMXp1ZXFCcHI2a3B1T1pBMFJU?=
 =?utf-8?B?NUJkZGREM3l6Z3M2M3FNTzBZckpVbllFWXpQcndZSVhPZDhEVkszZWx1RGp1?=
 =?utf-8?B?UzFPeGJYZ0hvbXdnckRsZEh2NWlZc2YwRG5JZnYzNzVnandEMk1HanRNZjBN?=
 =?utf-8?B?Z3hsNEkvcUp5Y2l3UHFMNGl6b2F6WnZualkxc3l1UkZLcHd6djdlY01nQ3Ja?=
 =?utf-8?B?UWhYQ3hOMm02VFcvcVY3Z1FXN2wwWU5aTjFJN05wWDZaMElrZlhDVU9oRHoy?=
 =?utf-8?Q?vbRD3uEyoJ3EH?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(35042699013)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:14:41.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 432e44af-0010-4d62-df5b-08dc84b9d2a4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8074

On 6/4/24 10:11, Mark Rutland wrote:
> Hi Arnaldo,
> 
> On Mon, Jun 03, 2024 at 03:33:07PM -0300, Arnaldo Carvalho de Melo wrote:
>> To get the changes in:
>>
>>    0ce85db6c2141b7f ("arm64: cputype: Add Neoverse-V3 definitions")
>>    02a0a04676fa7796 ("arm64: cputype: Add Cortex-X4 definitions")
>>    f4d9d9dcc70b96b5 ("arm64: Add Neoverse-V2 part")
> 
> As a heads-up, there are likely to be a couple more updates here
> shortly:
> 
>    https://lore.kernel.org/linux-arm-kernel/20240603111812.1514101-1-mark.rutland@arm.com/
> 
>> That makes this perf source code to be rebuilt:
>>
>>    CC      /tmp/build/perf-tools/util/arm-spe.o
>>
>> The changes in the above patch add MIDR_NEOVERSE_V[23] and
>> MIDR_NEOVERSE_V1 is used in arm-spe.c, so probably we need to add those
>> and perhaps MIDR_CORTEX_X4 to that array? Or maybe we need to leave this
>> for later when this is all tested on those machines?
> 
> Hmm... looking at where that was added this is somewhat misnamed, this
> is really saying that these cores use the same IMPLEMENTATION DEFINED
> encoding of the source field. That's not really a property of Neoverse
> specifically, and I'm not sure what Arm's policy is here going forwards.
> 
> We should probably rename that to something like
> common_data_source_encoding, with a big comment about exactly what it
> implies.

Agreed.

I went through Neoverse-V2/V3/V4, Cortex-X4, Cortex-X4, Cortex-A720, and 
Cortex-X925, all of them have the same definition for data source packet 
format. It makes sense to change name to Neoverse specific to a more 
general name.

> I would not touch this for now -- someone would have to go audit the
> TRMs to check that those other cores have the same encoding, and I think
> it'd be better to do that as a follow-up.

So far, it's fine to not change the file util/arm-spe.c.

Now more and more Arm CPUs support the data source in SPE and share the 
same data source format. It's not scalable for us to adding every CPU 
variant into the file util/arm-spe.c.

I would like to expose the PMSIDR_EL1.LDS bit (Data source indicator for 
sampled load instructions) via the 'cap' folder, and then we can save 
this info into the perf meta data during record phase.  In the perf 
report, we can parse the meta data and if the PMSIDR_EL1.LDS bit is set, 
the tool will parse the data source packet based on the common format.

Thanks,
Leo
