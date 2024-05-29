Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022019.outbound.protection.outlook.com [52.101.186.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B817F378;
	Wed, 29 May 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995772; cv=fail; b=mgzdOm8kt0GywbO/6hiuqVIYjJtzXIs66V2DxPOCKemBdM0IcQ+uE+7RJA1FSWSVUN60lJnJp0VkiDGJphABU23kcNC+H6bOv74IlsG4Kwhdv6ytdqo3VGvgCUchDZgeba5DujjHOYnGIAepbdLpePDI1Pj1rX8CR6uGpHkuEoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995772; c=relaxed/simple;
	bh=uXLUsUgyQPorHXFBUBu1Vx6hQt+3fSnCgCDKk4N3YAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XuuQVyNkiMCm1214cGSrJ5tOg393NM5ToK4STO4thH1kwrccdm9UVw9/Xr81iwKx+LHZ4acKYWawFUO26yFpLPa+rPCn9CWsP3YiqJOCQ9AfA4JcJYUtIqbkbtP+XUDaHbZhOKI/m3vyN5/tEuE4U4oI2NDBLWfJiq2PqazpTc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=P3lMOkJ4; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=P3lMOkJ4; arc=fail smtp.client-ip=52.101.186.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="P3lMOkJ4";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="P3lMOkJ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNbwDBxkSShXD4mt4VJPGva1nlVifMZVTIBrvxVgSv28YdjNrPxRnFZBKHAQ4v9vPTaJn5gW1EzsyEAra0AFuND+NmKhkXL2biBHFllLXbWtkXWnLrJBGEql9/TEe9TGyYmCoLoH6GVw8r7ZCobpyiFBqrH2xFjd3k9RvtOnYRDMToUuY+Q0tfor/pkwB4zefMuS5+LQchjLEuTYGTxtRIMkgKZefjsGkfU1fhpyYMCO/y7tVylap9fFWgl3rnL9JiBge4qXxGst5RY6wfARRDvRBKnrVmDL5veCp2HWS481H7MuHpu/RPSWu9NPeBiAJy00nuFefpmcEIYAMdqgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttePHExuxUMraw6+vG4//J2Gxll45Y0hjVjJ1hS6WJg=;
 b=kVaFjXymwyH2SIoO3BSYN8zaI9wOpi/bz0drlIYt5x3+rhwCLQOiNxH88KbdssRytd/T32Ata+SVKh7b+r3DEWpMwCX82NRztFDL4/sYriAL7KeJCqE5O4TEYJ5fYH2kr9XWVHzGJc6Qe0XV/ISuoAqNFBDUvq+BTL2MnRDxBp+xxQxTgnNSLLf4ZmVyjR2HGt3OqYN39ugNCgU19Wqj2i5Nn4TJKqUHQOASazwDREL9ktVYipGctCF9YITAXgdlz2RnkMXyOFrC+0VzFKV4/p6aFO9Wwx4XvO+FhJNqztHY0Iy5A973TFJyrORsAAKQDFru/duof2rkrq7SjtX2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=arm.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttePHExuxUMraw6+vG4//J2Gxll45Y0hjVjJ1hS6WJg=;
 b=P3lMOkJ4umBoAC2QwwBoKJnrNhoOuOY2W7Pt3lSMcwHDEIa9NtvRnHT3bbiu8MePW9JjEyn3OJixGjl+sbO1S/H8wDKlbYXLkFXcC4ZUAP8aHhLAXIElKFjETio1I6LBtX0GJ82oiQKdUkbjpK+z2KFFglaIadTm/unduNJdKao=
Received: from AM6P193CA0136.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::41)
 by ZR1P278MB1657.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 15:16:03 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:209:85:cafe::8) by AM6P193CA0136.outlook.office365.com
 (2603:10a6:209:85::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 15:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 15:16:03 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTP id 2741FFE13F;
	Wed, 29 May 2024 17:16:03 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com [40.93.85.1])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 08BA7FDFC1;
	Wed, 29 May 2024 17:16:01 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=P3lMOkJ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttePHExuxUMraw6+vG4//J2Gxll45Y0hjVjJ1hS6WJg=;
 b=P3lMOkJ4umBoAC2QwwBoKJnrNhoOuOY2W7Pt3lSMcwHDEIa9NtvRnHT3bbiu8MePW9JjEyn3OJixGjl+sbO1S/H8wDKlbYXLkFXcC4ZUAP8aHhLAXIElKFjETio1I6LBtX0GJ82oiQKdUkbjpK+z2KFFglaIadTm/unduNJdKao=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:35::7) by
 GV0P278MB0115.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.19; Wed, 29 May 2024 15:15:59 +0000
Received: from GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2518:d1f5:2f27:2cc5]) by GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2518:d1f5:2f27:2cc5%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 15:15:59 +0000
Date: Wed, 29 May 2024 17:15:56 +0200
From: Guilherme Amadio <amadio@cern.ch>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Artem Savkov <asavkov@redhat.com>, Ian Rogers <irogers@google.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <ZldGrKGQzGikxgqL@cern.ch>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
 <ZlTCvelaGVb6lCia@x1>
 <ZlTG-kPuYUyHLQZ2@x1>
 <CAP-5=fWmmtagTVfacFZgdhughvU--Dz0=jkoqFB8CP1Qd3o3Yw@mail.gmail.com>
 <20240528115703.GB449511@alecto.usersys.redhat.com>
 <97818e63-051f-4fcf-8c20-75730c08e98a@linux.intel.com>
 <ZlYgVYI6ABqmwb-d@x1>
Content-Type: multipart/mixed; boundary="lWGWlWdjNDUCCWce"
Content-Disposition: inline
In-Reply-To: <ZlYgVYI6ABqmwb-d@x1>
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:35::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV0P278MB0387:EE_|GV0P278MB0115:EE_|AMS0EPF000001B1:EE_|ZR1P278MB1657:EE_
X-MS-Office365-Filtering-Correlation-Id: 624fd260-e68f-4ec8-0984-08dc7ff2415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?JiF5BLVyiTESYS9PwbGZe5qXU4jOVKM4dHQrbZgcMQZK0c+7v/JSdfcygHFW?=
 =?us-ascii?Q?H8HHnV8qKJxKw+vfYRK8vuGXpTMdoHEggYAebBi3shtf4yld45bmTVCulBmp?=
 =?us-ascii?Q?KtpSp3gZ3O2qxtmvzWaln/IeiS//ExBq3xq8tfPSgf1OGjTMTWCbvcP4LbAy?=
 =?us-ascii?Q?3WYk+fqrsiCjfknODF9xTOk8DVr/KVXhK1RplFL/XMtzNW/vNKE+0m1MEIxh?=
 =?us-ascii?Q?VZLnrGHbJEqWt+Ubduk8B4sHOtK1wkxAfWHm3bkM4W8UBiXfG5v/0665bkVM?=
 =?us-ascii?Q?C5yDDJY8tja32tGQHGSrJs6kcrwot13Pfx0Xn6BNbNT75LIYf/zxRiSk89qT?=
 =?us-ascii?Q?2lU2eamQuLL4o0kPw47Y0amJFCJLxY3l37ChBYu/2xXfu7+yR9FrTIKGQqhy?=
 =?us-ascii?Q?+AMuGnrL/sjDZZfZC5ZLHgtRSGhZrIiZmNgfTeD4fEizfHxs5tKIoGbDjaFp?=
 =?us-ascii?Q?IanCLkUyg5SiKt1/k77No+E1zqzCEf7pTfYweUEfNXi//xSSL49kTTGRM3JK?=
 =?us-ascii?Q?srI0RcvJPjEhQmYbRgF0B9DZS2jzDcVJ+/MF7B1zQhZ1MCS9zQbDhm9DZwGN?=
 =?us-ascii?Q?Ba/xqq8k0A/jm4EKuOORZhfOpbefyiOn8wDbDt+EiiFsY4vD7PVYghDyKXMV?=
 =?us-ascii?Q?zvGEvomKRa8jQrnAW2MD1cDUfWmbP5kSjWvgOqQ36fKGf6yKS4IdqdnKn7bB?=
 =?us-ascii?Q?8JuAvx8B66K6S+4gahesNlppoSiIYsL06Hsrm67fAc2uZzMsuTueByP6Qe8g?=
 =?us-ascii?Q?U3WuFMTXPOGbzQ3kCGnWTxJtsbGVkPo2fhTRCrIlUnL7GsG2DmrcZEniOwav?=
 =?us-ascii?Q?XC/gS6JwcZkUlFEjpf3fMeaflKm+WJd7x5GI6gag33E3aaff9Rb2mHYAYRJm?=
 =?us-ascii?Q?lhUaFFeW0PTWcP1Eyf6a3oGvi+YAV/R9tUvGH8qot2qTSSY6O3juNrDIF5K3?=
 =?us-ascii?Q?bjq9dWVr5DTunyykpPD2G/1ENUZ7iZtHnPx34EnyEF+e4hekQ6oBr8bFKNFr?=
 =?us-ascii?Q?ub+uP3gVLLKyLMZJ5YPm8JBtaXWPhTcOxxN/N1J6So9qX1oW/yu/qqZay1Qy?=
 =?us-ascii?Q?CA1waHq3wXNngmKElE9TUBFWmFfiFhkJHymD9jPom6/ICPjetldwCGul0T5B?=
 =?us-ascii?Q?/+wOEBT4h1DTHLue1iFRza7vrrK/I7Pf8JShbeEbIJ/TqzvnQOm6MppoTDWZ?=
 =?us-ascii?Q?GQ6Y3Bz5tS24BSrwaWzdbzFZTwTz7L8qhGnlGkKLi85Gy+vE5oKT3CEC16w?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0115
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e22cf0f1-ea20-41b7-4897-08dc7ff23e91
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|376005|1800799015|35042699013|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czk2NUozb241TThYbWpPK25MQTRmc1ZhMlFoOEFGUVVOeEwvamZsVXZiUFFj?=
 =?utf-8?B?NlBFMUZUeEpaU0lFckhzVndlSDYvK2tiUmQyUVNTQ1BWVVJ3SHFPQTdvOEVH?=
 =?utf-8?B?ZTdWRU5FeVRrNUZ4UjRJc3EwQ21ZWGtxV0hMMnN5T094c3V6aWxlNUhQMVA0?=
 =?utf-8?B?YnNuQVlBUElMWEI5WEdCVjdXOWFVak9BM2VIaVVicnNvRUExSksyNFVQYmI3?=
 =?utf-8?B?ek5zZ0tybTNQTVU3Njk4MUZqOCtNaWROM2tlbU54T1h4WVhlNUs4UU9LZFRZ?=
 =?utf-8?B?K3NXTHFGazR3Y2FKZE40UVljMGlaNHRiSWgrdExqQWJpUEFVWFJySG1nNVgr?=
 =?utf-8?B?NWJQdEQ1SzkxKzVhTlRweTB5WkdEWWhsV25nU3phUEYwdElpQnhHL0gxQ2NH?=
 =?utf-8?B?RmtCejV4TTdFOXBtd1oxVmoxWjJQcFhXVFRHeGRpOXFEUlYrdDlNREFlTGJP?=
 =?utf-8?B?ODF4Uk1RL0ZyQWZ0eWdjWU5SRExnOGdVUGRFaDQyeEd0SHpza1J1b2l0WC9T?=
 =?utf-8?B?MFRMUUE4VjdTeGl6VzJ6c09PZWg3T1pSaGxVcWgyT2wxOFhZNUxyMlJSYlkr?=
 =?utf-8?B?UWhSQ2YyZmRwNXZJWUhuZ2NNOUxPd0VVWjN5VGl5ZFJSKzEvZUVLQ0UzUkRv?=
 =?utf-8?B?ZGZtRnRMM0w2QWJ6UVhCUjJNbkVLRFdvSThlRHBGc0N5WWQyNXFKZDhONUJB?=
 =?utf-8?B?alovdlh6Z3NtekFwWlgvU3YwNGlzanh2bllPM3E0RTBJVGVUekJhQVVBRzI4?=
 =?utf-8?B?R2N3MnFuYWtJV0pDWit1TEtTandwWHFDdWo5VnlJS3hFL1JBd3R6ZEpBcytL?=
 =?utf-8?B?RFdwSS9IeCtMMWQybnliVjBnWklFbjhMYU5aZ1A1RTUzMDBTVXExZzF0cExY?=
 =?utf-8?B?dXFFcWxTVFQvSGRyU0ZnMFRmZHhqUTd6VTBZZ2FFN05uWFg0MmJscGMwblVL?=
 =?utf-8?B?ZlVWMUpCOHU0SlBpTXF1MUY0eU01c2JsaW5oQnVVMThwK3BFSkNOV3ZnV05r?=
 =?utf-8?B?OTFLOEc0TjQwMHp2R0FQcEZ3RHVxOUZXNjBTSDBpczFGdEh6anVLZGZqOEhD?=
 =?utf-8?B?bnZValhGZXFPTlFQOXlENFhDU0lENy94M0tHSitDSTl1RmgvM2xuNFBqOWU3?=
 =?utf-8?B?dnNGOUsyUnhOZ0JsQmlod2FIZHJJeDN6dzI1ZHZpTHNxZy9mRldkQmdYR1ha?=
 =?utf-8?B?azRpRDJhZ0pCODh4TDhoTk5tRTloSDdCV3NTcWx0N1Q2UFpBVWh5bTBhK25K?=
 =?utf-8?B?ZmhWSk1aUkl0Ym91L0U0ajNnZXFGaFo3aHZvdWxkZkpTSUFiMENGMmVla2dE?=
 =?utf-8?B?UzVmQ1hjbVNVK2ZzTzF0OUQyRnNDSVlDSlg0eEtVQVgvTGVsMDNOclNzaTFE?=
 =?utf-8?B?dktERjNiWVN0S0R3RGM1LzVQalU0aUJlU05CeW5wNnVxWm1jMUJGclJGLzF0?=
 =?utf-8?B?bUJMeW5Xbnk3NS82NC8vZTlQRFAxY0lqRVE5V3E0R2t1NTNWNTRhMTExQzQr?=
 =?utf-8?B?MXpHeElCeUpBdUxhRkk1ZUx1Tm8zb2FYektIVW1rZVFwc3MyZjMzOFdRUTIz?=
 =?utf-8?B?bWpPb0w0RG03TXdYSjg4VkVpbGFIa1J1MDhaOU8xaXZ0WDJ6bWFZU3NtK1hY?=
 =?utf-8?B?dmpxd3Vpc2hzL29SN0lWNjByeDgrblpHOFRGSmJXdTdPT1Y1Q01haklVTmJD?=
 =?utf-8?B?Zyt0VnhNdlBXWHQwUGJxVWZjcklsTGdCbGxmMytqZVFTVFpFUHBBVVlUaFN3?=
 =?utf-8?Q?YLaumLTlfIbsC/yGYamth0fcIQZebnOYvKNu0+Y?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(1800799015)(35042699013)(82310400017);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 15:16:03.4703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624fd260-e68f-4ec8-0984-08dc7ff2415f
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1657

--lWGWlWdjNDUCCWce
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Tue, May 28, 2024 at 08:20:05PM +0200, Arnaldo Carvalho de Melo wrote:
> On Tue, May 28, 2024 at 11:55:00AM -0400, Liang, Kan wrote:
> > On 2024-05-28 7:57 a.m., Artem Savkov wrote:
> > > On Mon, May 27, 2024 at 10:01:37PM -0700, Ian Rogers wrote:
> > >> On Mon, May 27, 2024 at 10:46=E2=80=AFAM Arnaldo Carvalho de Melo
> > >> <acme@kernel.org> wrote:
> > >>>
> > >>> On Mon, May 27, 2024 at 02:28:32PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > >>>> On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo=
 wrote:
> > >>>>> On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > >>>>>> On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > >>>>>>> Add -M/--metrics option to perf-record providing a shortcut to =
record
> > >>>>>>> metrics and metricgroups. This option mirrors the one in perf-s=
tat.
> > >>>>
> > >>>>>>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > >>>>>>> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > >>>
> > >>>> How did you test this?
> > >>>
> > >>>> The idea, from my notes, was to be able to have extra columns in '=
perf
> > >>>> report' with things like IPC and other metrics, probably not all m=
etrics
> > >>>> will apply. We need to find a way to find out which ones are OK fo=
r that
> > >>>> purpose, for instance:
> > >>>
> > >>> One that may make sense:
> > >>>
> > >>> root@number:~# perf record -M tma_fb_full
> > >>> ^C[ perf record: Woken up 1 times to write data ]
> > >>> [ perf record: Captured and wrote 3.846 MB perf.data (21745 samples=
) ]
> > >>>
> > >>> root@number:~# perf evlist
> > >>> cpu_core/CPU_CLK_UNHALTED.THREAD/
> > >>> cpu_core/L1D_PEND_MISS.FB_FULL/
> > >>> dummy:u
> > >>> root@number:~#
> > >>>
> > >>> But then we need to read both to do the math, maybe something like:
> > >>>
> > >>> root@number:~# perf record -e '{cpu_core/CPU_CLK_UNHALTED.THREAD/,c=
pu_core/L1D_PEND_MISS.FB_FULL/}:S'
> > >>> ^C[ perf record: Woken up 40 times to write data ]
> > >>> [ perf record: Captured and wrote 14.640 MB perf.data (219990 sampl=
es) ]
> > >>>
> > >>> root@number:~# perf script | head
> > >>>     cc1plus 1339704 [000] 36028.995981:  2011389 cpu_core/CPU_CLK_U=
NHALTED.THREAD/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-li=
nux-gnu/13/cc1plus)
> > >>>     cc1plus 1339704 [000] 36028.995981:    26231   cpu_core/L1D_PEN=
D_MISS.FB_FULL/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc-li=
nux-gnu/13/cc1plus)
> > >>>     cc1plus 1340011 [001] 36028.996008:  2004568 cpu_core/CPU_CLK_U=
NHALTED.THREAD/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-li=
nux-gnu/13/cc1plus)
> > >>>     cc1plus 1340011 [001] 36028.996008:    20113   cpu_core/L1D_PEN=
D_MISS.FB_FULL/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc-li=
nux-gnu/13/cc1plus)
> > >>>       clang 1340462 [002] 36028.996043:  2007356 cpu_core/CPU_CLK_U=
NHALTED.THREAD/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
> > >>>       clang 1340462 [002] 36028.996043:    23481   cpu_core/L1D_PEN=
D_MISS.FB_FULL/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms])
> > >>>     cc1plus 1339622 [003] 36028.996066:  2004148 cpu_core/CPU_CLK_U=
NHALTED.THREAD/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-li=
nux-gnu/13/cc1plus)
> > >>>     cc1plus 1339622 [003] 36028.996066:    31935   cpu_core/L1D_PEN=
D_MISS.FB_FULL/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc-li=
nux-gnu/13/cc1plus)
> > >>>          as 1340513 [004] 36028.996097:  2005052 cpu_core/CPU_CLK_U=
NHALTED.THREAD/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kalls=
yms])
> > >>>          as 1340513 [004] 36028.996097:    45084   cpu_core/L1D_PEN=
D_MISS.FB_FULL/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.kalls=
yms])
> > >>> root@number:~#
> > >>>
> > >>> root@number:~# perf report --stdio -F +period | head -20
> > >>> # To display the perf.data header info, please use --header/--heade=
r-only options.
> > >>> #
> > >>> #
> > >>> # Total Lost Samples: 0
> > >>> #
> > >>> # Samples: 219K of events 'anon group { cpu_core/CPU_CLK_UNHALTED.T=
HREAD/, cpu_core/L1D_PEND_MISS.FB_FULL/ }'
> > >>> # Event count (approx.): 216528524863
> > >>> #
> > >>> #         Overhead                Period  Command    Shared Object =
     Symbol
> > >>> # ................  ....................  .........  ..............=
...  ....................................
> > >>> #
> > >>>      4.01%   1.09%  8538169256  39826572  podman     [kernel.kallsy=
ms]  [k] native_queued_spin_lock_slowpath
> > >>>      1.35%   1.17%  2863376078  42829266  cc1plus    cc1plus       =
     [.] 0x00000000003f6bcc
> > >>>      0.94%   0.78%  1990639149  28408591  cc1plus    cc1plus       =
     [.] 0x00000000003f6be4
> > >>>      0.65%   0.17%  1375916283   6109515  podman     [kernel.kallsy=
ms]  [k] _raw_spin_lock_irqsave
> > >>>      0.61%   0.99%  1304418325  36198834  cc1plus    [kernel.kallsy=
ms]  [k] get_mem_cgroup_from_mm
> > >>>      0.52%   0.42%  1103054030  15427418  cc1plus    cc1plus       =
     [.] 0x0000000000ca6c69
> > >>>      0.51%   0.17%  1094200572   6299289  podman     [kernel.kallsy=
ms]  [k] psi_group_change
> > >>>      0.42%   0.41%   893633315  14778675  cc1plus    cc1plus       =
     [.] 0x00000000018afafe
> > >>>      0.42%   1.29%   887664793  47046952  cc1plus    [kernel.kallsy=
ms]  [k] asm_exc_page_fault
> > >>> root@number:~#
> > >>>
> > >>> That 'tma_fb_full' metric then would be another column, calculated =
from
> > >>> the sampled components of its metric equation:
> > >>>
> > >>> root@number:~# perf list tma_fb_full | head
> > >>>
> > >>> Metric Groups:
> > >>>
> > >>> MemoryBW: [Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet]
> > >>>   tma_fb_full
> > >>>        [This metric does a *rough estimation* of how often L1D Fill=
 Buffer
> > >>>         unavailability limited additional L1D miss memory access re=
quests to
> > >>>         proceed]
> > >>>
> > >>> TopdownL4: [Metrics for top-down breakdown at level 4]
> > >>> root@number:~#
> > >>>
> > >>> This is roughly what we brainstormed, to support metrics in other t=
ools
> > >>> than 'perf stat' but we need to check the possibilities and limitat=
ions
> > >>> of such an idea, hopefully this discussion will help with that,
> > >>
> > >> Putting metrics next to code in perf report/annotate sounds good to
> > >> me, opening all events from a metric as if we want to sample on them
> > >> less so.
> > >=20
> > > The idea was to record whatever data was asked on record step and
> > > provide the list of all metrics that can be calculated out of that da=
ta
> > > in perf report, e.g. you could record tma_info_thread_ipc but report
> > > will suggest both it and tma_info_thread_cpi.
> > >
> >=20
> > Do you mean that sample all the events in a metrics, and report both
> > samples and its metrics calculation result in the report?
> > That doesn't work for all the metrics.
>=20
> IIRC Guilherme was mentioning having extra metrics on report was
> something he missed that is available on tools such as VTune, Guilherme?

Thanks for asking. I will try to explain the motivation behind metric
sampling. VTune offers something called a Microarchitecture Analysis
report, which will show a break down of all the TMA metrics per symbol:

https://www.intel.com/content/www/us/en/docs/vtune-profiler/cookbook/2023-0=
/top-down-microarchitecture-analysis-method.html

The link above has a small screenshot showing function, instructions,
CPI, and the metrics. This is much better than just counting, because in
a large detector simulation, for example, there are many different kinds
of bottlenecks the code can have, and the break down per symbol helps to
identify which functions suffer from bad speculation, which suffer from
cache misses, etc. This allows one to choose what kind of change to make
to the software to optimize it. So as a first step, having TMA level 0
(i.e. a breakdown of the pipelines for Front-End Bound, Bad Speculation,
Core Bound, and Memory Bound) would already be quite far towards the
goal of understanding bottlenecks in specific parts of the code. VTune
forces sampling without collecting call stacks for this, perf could do
the same. Hotspots usually have lots of samples, which then allows
computing metrics relatively accurately. VTune uses multiplexing and
very large sampling expression, which I am pasting at the end of this
message=C2=B2. I extracted that command from the report file after using
"vtune -collect uarch-exploration <command>" to produce a report. I
tried that with standard perf record and it failed to parse, so likely
amplxe-perf is required to be able to record that, but I thought it'd
be useful information.

As for the interface, I suggest adding a "perf mlist" similar to
perf evlist, that would just print what metrics could be calculated
from the events recorded in the input file. Then one could be selected
for use with perf report or perf annotate.

I hope this explains enough to clarify things for you. I am attaching a
screenshot example for the classic matrix multiplication with wrong
indexing as well, which shows that only certain lines get the metric,
whereas lines with low number of samples just get 0.0%.

Best regards,
-Guilherme

> > - For the topdown related metrics, especially on ICL and later
> > platforms, the perf metrics feature is used by default. It doesn't
> > support sampling.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/Documentation/topdown.txt?#n293
> > - Some PMUs which doesn't support sampling as well, e.g., uncore, Power=
,
> > MSR.
> > - There are some SW events, e.g.,duration_time, you may don't want to d=
o
> > sampling
> >=20
> > You probable need to introduce a flag to ignore those metrics in perf
> > record.
> >=20
> > >> We don't have metrics working with `perf stat record`, I
> > >> think Kan may have volunteered for that, but it seems like something
> > >> more urgent than expanding `perf record`. Presumably the way the
> > >> metric would be recorded for that could also benefit this effort.
> > >>
> > >> If you look at the tma metrics a number of them have a "Sample with"=
.
> > >> For example:
> > >> ```
> > >> $ perf list -v
> > >> ...
> > >>   tma_branch_mispredicts
> > >>        [This metric represents fraction of slots the CPU has wasted
> > >> due to Branch Misprediction.
> > >>         These slots are either wasted by uops fetched from an
> > >> incorrectly speculated program path;
> > >>         or stalls when the out-of-order part of the machine needs to
> > >> recover its state from a
> > >>         speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES.
> > >> Related metrics:
> > >>         tma_info_bad_spec_branch_misprediction_cost,tma_info_bottlen=
eck_mispredictions,
> > >>         tma_mispredicts_resteers]
> > >> ...
> > >> ```
> > >> It could be logical for `perf record -M tma_branch_mispredicts ...` =
to
> > >> be translated to `perf record -e BR_MISP_RETIRED.ALL_BRANCHES ...`
> > >> rather than to do any form of counting.
> > >=20
> > > Thanks for the pointer, I'll see how this could be done.
> >=20
> > It sounds more reasonable to me that we can sample some typical events,
> > and read the other members in the metrics. So we can put metrics next t=
o
> > the code in perf report/annotate as Ian mentioned. It could also addres=
s
> > limits of some metrics, especially for the topdown related metrics.
> > (But I'm not sure if the "Sample with" can give you the right hints. I
> > will ask around internally.)
> >=20
> > But there is also some limits for the sampling read. Everything has to
> > be in a group. That could be a problem for some big metrics.
> > Thanks,
> > Kan

2. runCmd: amplxe-perf record -v --control=3Dfd:21,24 -o system-wide.perf -=
N -B -T --sample-cpu -d -a --compression-level=3D1 --threads --clockid=3DCL=
OCK_MONOTONIC_RAW -e cpu/period=3D0xa037a0,event=3D0x3c,name=3D'CPU_CLK_UNH=
ALTED.THREAD'/Duk,cpu/period=3D0xa037a0,umask=3D0x3,name=3D'CPU_CLK_UNHALTE=
D.REF_TSC'/Duk,cpu/period=3D0xa037a0,event=3D0xc0,name=3D'INST_RETIRED.ANY'=
/Duk,cpu/period=3D0x7a12f,event=3D0x3c,umask=3D0x1,name=3D'CPU_CLK_UNHALTED=
.REF_XCLK'/uk,cpu/period=3D0x7a12f,event=3D0x3c,umask=3D0x2,name=3D'CPU_CLK=
_UNHALTED.ONE_THREAD_ACTIVE'/uk,cpu/period=3D0x98968f,event=3D0x3c,name=3D'=
CPU_CLK_UNHALTED.THREAD_P'/uk,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0x=
14,cmask=3D0x14,name=3D'CYCLE_ACTIVITY.STALLS_MEM_ANY'/uk,cpu/period=3D0x98=
968f,event=3D0xa3,umask=3D0x4,cmask=3D0x4,name=3D'CYCLE_ACTIVITY.STALLS_TOT=
AL'/uk,cpu/period=3D0x98968f,event=3D0xa6,umask=3D0x2,name=3D'EXE_ACTIVITY.=
1_PORTS_UTIL'/uk,cpu/period=3D0x98968f,event=3D0xa6,umask=3D0x4,name=3D'EXE=
_ACTIVITY.2_PORTS_UTIL'/uk,cpu/period=3D0x98968f,event=3D0xa6,umask=3D0x40,=
name=3D'EXE_ACTIVITY.BOUND_ON_STORES'/uk,cpu/period=3D0x7a143,event=3D0xc6,=
umask=3D0x1,frontend=3D0x400406,name=3D'FRONTEND_RETIRED.LATENCY_GE_4_PS'/u=
kpp,cpu/period=3D0x98968f,event=3D0x9c,umask=3D0x1,name=3D'IDQ_UOPS_NOT_DEL=
IVERED.CORE'/uk,cpu/period=3D0x98968f,event=3D0xd,umask=3D0x1,name=3D'INT_M=
ISC.RECOVERY_CYCLES'/uk,cpu/period=3D0x98968f,event=3D0xe,umask=3D0x1,name=
=3D'UOPS_ISSUED.ANY'/uk,cpu/period=3D0x98968f,event=3D0xc2,umask=3D0x2,name=
=3D'UOPS_RETIRED.RETIRE_SLOTS'/uk,cpu/period=3D0x7a12f,event=3D0xe6,umask=
=3D0x1,name=3D'BACLEARS.ANY'/uk,cpu/period=3D0x1e84ad,event=3D0xc5,name=3D'=
BR_MISP_RETIRED.ALL_BRANCHES'/uk,cpu/period=3D0x98968f,event=3D0xab,umask=
=3D0x2,name=3D'DSB2MITE_SWITCHES.PENALTY_CYCLES'/uk,cpu/period=3D0x7a143,ev=
ent=3D0xc6,umask=3D0x1,frontend=3D0x1,name=3D'FRONTEND_RETIRED.ANY_DSB_MISS=
'/uk,cpu/period=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x11,name=3D'=
FRONTEND_RETIRED.DSB_MISS_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xc6,umask=
=3D0x1,frontend=3D0x13,name=3D'FRONTEND_RETIRED.L2_MISS_PS'/ukpp,cpu/period=
=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x401006,name=3D'FRONTEND_RE=
TIRED.LATENCY_GE_16_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xc6,umask=3D0x1,=
frontend=3D0x100206,name=3D'FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS'/=
ukpp,cpu/period=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x15,name=3D'=
FRONTEND_RETIRED.STLB_MISS_PS'/ukpp,cpu/period=3D0x98968f,event=3D0x80,umas=
k=3D0x4,name=3D'ICACHE_16B.IFDATA_STALL'/uk,cpu/period=3D0x98968f,event=3D0=
x80,edge=3D0x1,umask=3D0x4,cmask=3D0x1,name=3D'ICACHE_16B.IFDATA_STALL:cmas=
k=3D1:e=3Dyes'/uk,cpu/period=3D0xf424f,event=3D0x83,umask=3D0x4,name=3D'ICA=
CHE_64B.IFTAG_STALL'/uk,cpu/period=3D0x98968f,event=3D0x79,umask=3D0x18,cma=
sk=3D0x4,name=3D'IDQ.ALL_DSB_CYCLES_4_UOPS'/uk,cpu/period=3D0x98968f,event=
=3D0x79,umask=3D0x18,cmask=3D0x1,name=3D'IDQ.ALL_DSB_CYCLES_ANY_UOPS'/uk,cp=
u/period=3D0x98968f,event=3D0x79,umask=3D0x24,cmask=3D0x4,name=3D'IDQ.ALL_M=
ITE_CYCLES_4_UOPS'/uk,cpu/period=3D0x98968f,event=3D0x79,umask=3D0x24,cmask=
=3D0x1,name=3D'IDQ.ALL_MITE_CYCLES_ANY_UOPS'/uk,cpu/period=3D0x98968f,event=
=3D0x79,umask=3D0x8,name=3D'IDQ.DSB_UOPS'/uk,cpu/period=3D0x98968f,event=3D=
0x79,umask=3D0x4,name=3D'IDQ.MITE_UOPS'/uk,cpu/period=3D0x98968f,event=3D0x=
79,edge=3D0x1,umask=3D0x30,cmask=3D0x1,name=3D'IDQ.MS_SWITCHES'/uk,cpu/peri=
od=3D0x98968f,event=3D0x79,umask=3D0x30,name=3D'IDQ.MS_UOPS'/uk,cpu/period=
=3D0x98968f,event=3D0x9c,umask=3D0x1,cmask=3D0x4,name=3D'IDQ_UOPS_NOT_DELIV=
ERED.CYCLES_0_UOPS_DELIV.CORE'/uk,cpu/period=3D0x98968f,event=3D0x87,umask=
=3D0x1,name=3D'ILD_STALL.LCP'/uk,cpu/period=3D0x98968f,event=3D0x55,umask=
=3D0x1,cmask=3D0x1,name=3D'INST_DECODED.DECODERS:cmask=3D1'/uk,cpu/period=
=3D0x98968f,event=3D0x55,umask=3D0x1,cmask=3D0x2,name=3D'INST_DECODED.DECOD=
ERS:cmask=3D2'/uk,cpu/period=3D0x98968f,event=3D0xd,umask=3D0x80,name=3D'IN=
T_MISC.CLEAR_RESTEER_CYCLES'/uk,cpu/period=3D0x7a12f,event=3D0xc3,edge=3D0x=
1,umask=3D0x1,cmask=3D0x1,name=3D'MACHINE_CLEARS.COUNT'/uk,cpu/period=3D0x1=
e84ad,event=3D0xc5,umask=3D0x4,name=3D'BR_MISP_RETIRED.ALL_BRANCHES_PS'/ukp=
p,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0x8,cmask=3D0x8,name=3D'CYCLE_=
ACTIVITY.CYCLES_L1D_MISS'/uk,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0x1=
0,cmask=3D0x10,name=3D'CYCLE_ACTIVITY.CYCLES_MEM_ANY'/uk,cpu/period=3D0x989=
68f,event=3D0xa3,umask=3D0xc,cmask=3D0xc,name=3D'CYCLE_ACTIVITY.STALLS_L1D_=
MISS'/uk,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0x5,cmask=3D0x5,name=3D=
'CYCLE_ACTIVITY.STALLS_L2_MISS'/uk,cpu/period=3D0x98968f,event=3D0xa3,umask=
=3D0x6,cmask=3D0x6,name=3D'CYCLE_ACTIVITY.STALLS_L3_MISS'/uk,cpu/period=3D0=
x98968f,event=3D0x8,umask=3D0x20,cmask=3D0x1,name=3D'DTLB_LOAD_MISSES.STLB_=
HIT:cmask=3D1'/uk,cpu/period=3D0x7a12f,event=3D0x8,umask=3D0x10,cmask=3D0x1=
,name=3D'DTLB_LOAD_MISSES.WALK_ACTIVE'/uk,cpu/period=3D0x7a12f,event=3D0x49=
,umask=3D0x20,cmask=3D0x1,name=3D'DTLB_STORE_MISSES.STLB_HIT:cmask=3D1'/uk,=
cpu/period=3D0x7a12f,event=3D0x49,umask=3D0x10,cmask=3D0x1,name=3D'DTLB_STO=
RE_MISSES.WALK_ACTIVE'/uk,cpu/period=3D0x98968f,event=3D0x48,umask=3D0x2,cm=
ask=3D0x1,name=3D'L1D_PEND_MISS.FB_FULL:cmask=3D1'/uk,cpu/period=3D0x98968f=
,event=3D0x48,umask=3D0x1,name=3D'L1D_PEND_MISS.PENDING'/uk,cpu/period=3D0x=
f424f,event=3D0x24,umask=3D0xe2,name=3D'L2_RQSTS.ALL_RFO'/uk,cpu/period=3D0=
xf424f,event=3D0x24,umask=3D0xc2,name=3D'L2_RQSTS.RFO_HIT'/uk,cpu/period=3D=
0x7a12f,event=3D0x3,umask=3D0x8,name=3D'LD_BLOCKS.NO_SR'/uk,cpu/period=3D0x=
7a12f,event=3D0x3,umask=3D0x2,name=3D'LD_BLOCKS.STORE_FORWARD'/uk,cpu/perio=
d=3D0x7a12f,event=3D0x7,umask=3D0x1,name=3D'LD_BLOCKS_PARTIAL.ADDRESS_ALIAS=
'/uk,cpu/period=3D0x98968f,event=3D0xd0,umask=3D0x82,name=3D'MEM_INST_RETIR=
ED.ALL_STORES_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd0,umask=3D0x21,name=
=3D'MEM_INST_RETIRED.LOCK_LOADS_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd0,=
umask=3D0x41,name=3D'MEM_INST_RETIRED.SPLIT_LOADS_PS'/ukpp,cpu/period=3D0x7=
a12f,event=3D0xd0,umask=3D0x42,name=3D'MEM_INST_RETIRED.SPLIT_STORES_PS'/uk=
pp,cpu/period=3D0x7a12f,event=3D0xd0,umask=3D0x11,name=3D'MEM_INST_RETIRED.=
STLB_MISS_LOADS_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd0,umask=3D0x12,nam=
e=3D'MEM_INST_RETIRED.STLB_MISS_STORES_PS'/ukpp,cpu/period=3D0x186d7,event=
=3D0xd2,umask=3D0x4,name=3D'MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS'/ukpp,cpu/=
period=3D0x186d7,event=3D0xd2,umask=3D0x2,name=3D'MEM_LOAD_L3_HIT_RETIRED.X=
SNP_HIT_PS'/ukpp,cpu/period=3D0x186d7,event=3D0xd2,umask=3D0x1,name=3D'MEM_=
LOAD_L3_HIT_RETIRED.XSNP_MISS_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd3,um=
ask=3D0x1,name=3D'MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS'/ukpp,cpu/period=
=3D0x7a143,event=3D0xd3,umask=3D0x2,name=3D'MEM_LOAD_L3_MISS_RETIRED.REMOTE=
_DRAM_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd3,umask=3D0x8,name=3D'MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_FWD'/uk,cpu/period=3D0x7a143,event=3D0xd3,umask=
=3D0x4,name=3D'MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS'/ukpp,cpu/period=3D0=
x7a143,event=3D0xd3,umask=3D0x10,name=3D'MEM_LOAD_L3_MISS_RETIRED.REMOTE_PM=
M_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd1,umask=3D0x40,name=3D'MEM_LOAD_=
RETIRED.FB_HIT_PS'/ukpp,cpu/period=3D0x98968f,event=3D0xd1,umask=3D0x1,name=
=3D'MEM_LOAD_RETIRED.L1_HIT_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd1,umas=
k=3D0x8,name=3D'MEM_LOAD_RETIRED.L1_MISS_PS'/ukpp,cpu/period=3D0x7a12f,even=
t=3D0xd1,umask=3D0x2,name=3D'MEM_LOAD_RETIRED.L2_HIT_PS'/ukpp,cpu/period=3D=
0x3d0f9,event=3D0xd1,umask=3D0x4,name=3D'MEM_LOAD_RETIRED.L3_HIT_PS'/ukpp,c=
pu/period=3D0x7a143,event=3D0xd1,umask=3D0x20,name=3D'MEM_LOAD_RETIRED.L3_M=
ISS_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd1,umask=3D0x80,name=3D'MEM_LOA=
D_RETIRED.LOCAL_PMM_PS'/ukpp,cpu/period=3D0x98968f,event=3D0xb2,umask=3D0x1=
,name=3D'OFFCORE_REQUESTS_BUFFER.SQ_FULL'/uk,cpu/period=3D0x98968f,event=3D=
0x60,umask=3D0x8,cmask=3D0x4,name=3D'OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_=
RD:cmask=3D4'/uk,cpu/period=3D0x98968f,event=3D0x60,umask=3D0x8,cmask=3D0x1=
,name=3D'OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD'/uk,cpu/period=3D=
0x98968f,event=3D0x60,umask=3D0x4,cmask=3D0x1,name=3D'OFFCORE_REQUESTS_OUTS=
TANDING.CYCLES_WITH_DEMAND_RFO'/uk,cpu/period=3D0x98968f,event=3D0x14,umask=
=3D0x1,cmask=3D0x1,name=3D'ARITH.DIVIDER_ACTIVE'/uk,cpu/period=3D0x98968f,e=
vent=3D0xa6,umask=3D0x1,name=3D'EXE_ACTIVITY.EXE_BOUND_0_PORTS'/uk,cpu/peri=
od=3D0x98968f,event=3D0xc7,name=3D'FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE=
:umask=3D0xfc'/uk,cpu/period=3D0x98968f,event=3D0xc7,name=3D'FP_ARITH_INST_=
RETIRED.SCALAR_SINGLE:umask=3D0x03'/uk,cpu/period=3D0x98968f,event=3D0x59,u=
mask=3D0x1,name=3D'PARTIAL_RAT_STALLS.SCOREBOARD'/uk,cpu/period=3D0x98968f,=
event=3D0xc0,umask=3D0x1,name=3D'INST_RETIRED.PREC_DIST'/ukpp,cpu/period=3D=
0x98968f,event=3D0xcc,umask=3D0x40,name=3D'ROB_MISC_EVENTS.PAUSE_INST'/uk,c=
pu/period=3D0x98968f,event=3D0xa1,umask=3D0x1,name=3D'UOPS_DISPATCHED_PORT.=
PORT_0'/uk,cpu/period=3D0x98968f,event=3D0xa1,umask=3D0x2,name=3D'UOPS_DISP=
ATCHED_PORT.PORT_1'/uk,cpu/period=3D0x98968f,event=3D0xa1,umask=3D0x4,name=
=3D'UOPS_DISPATCHED_PORT.PORT_2'/uk,cpu/period=3D0x98968f,event=3D0xa1,umas=
k=3D0x8,name=3D'UOPS_DISPATCHED_PORT.PORT_3'/uk,cpu/period=3D0x98968f,event=
=3D0xa1,umask=3D0x10,name=3D'UOPS_DISPATCHED_PORT.PORT_4'/uk,cpu/period=3D0=
x98968f,event=3D0xa1,umask=3D0x20,name=3D'UOPS_DISPATCHED_PORT.PORT_5'/uk,c=
pu/period=3D0x98968f,event=3D0xa1,umask=3D0x40,name=3D'UOPS_DISPATCHED_PORT=
.PORT_6'/uk,cpu/period=3D0x98968f,event=3D0xa1,umask=3D0x80,name=3D'UOPS_DI=
SPATCHED_PORT.PORT_7'/uk,cpu/period=3D0x98968f,event=3D0xb1,umask=3D0x2,cma=
sk=3D0x1,name=3D'UOPS_EXECUTED.CORE_CYCLES_GE_1'/uk,cpu/period=3D0x98968f,e=
vent=3D0xb1,umask=3D0x2,cmask=3D0x2,name=3D'UOPS_EXECUTED.CORE_CYCLES_GE_2'=
/uk,cpu/period=3D0x98968f,event=3D0xb1,umask=3D0x2,cmask=3D0x3,name=3D'UOPS=
_EXECUTED.CORE_CYCLES_GE_3'/uk,cpu/period=3D0x98968f,event=3D0xb1,inv=3D0x1=
,umask=3D0x2,cmask=3D0x1,name=3D'UOPS_EXECUTED.CORE_CYCLES_NONE'/uk,cpu/per=
iod=3D0x98968f,event=3D0xb1,umask=3D0x1,name=3D'UOPS_EXECUTED.THREAD'/uk,cp=
u/period=3D0x98968f,event=3D0xb1,umask=3D0x10,name=3D'UOPS_EXECUTED.X87'/uk=
,cpu/period=3D0x98968f,event=3D0xe,umask=3D0x2,name=3D'UOPS_ISSUED.VECTOR_W=
IDTH_MISMATCH'/uk,cpu/period=3D0x98968f,event=3D0xc2,umask=3D0x4,name=3D'UO=
PS_RETIRED.MACRO_FUSED'/uk,cpu/period=3D0x1e84ad,event=3D0xc4,name=3D'BR_IN=
ST_RETIRED.ALL_BRANCHES'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x4,=
name=3D'FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE'/uk,cpu/period=3D0x98968f,=
event=3D0xc7,umask=3D0x8,name=3D'FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE'/=
uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x10,name=3D'FP_ARITH_INST_RE=
TIRED.256B_PACKED_DOUBLE'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x2=
0,name=3D'FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE'/uk,cpu/period=3D0x98968=
f,event=3D0xc7,umask=3D0x40,name=3D'FP_ARITH_INST_RETIRED.512B_PACKED_DOUBL=
E'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x80,name=3D'FP_ARITH_INST=
_RETIRED.512B_PACKED_SINGLE'/uk,cpu/period=3D0x7a12f,event=3D0xca,umask=3D0=
x1e,cmask=3D0x1,name=3D'FP_ASSIST.ANY'/uk,cpu/period=3D0x98968f,event=3D0xc=
0,umask=3D0x2,name=3D'INST_RETIRED.NOP'/uk,cpu/period=3D0x98968f,event=3D0x=
d0,umask=3D0x83,name=3D'MEM_INST_RETIRED.ANY'/uk,cpu/period=3D0x7a12f,event=
=3D0xc1,umask=3D0x3f,name=3D'OTHER_ASSISTS.ANY'/uk,cpu/period=3D0x7a12f,eve=
nt=3D0xb7,offcore_rsp=3D0x8003c0001,umask=3D0x1,name=3D'OCR.DEMAND_DATA_RD.=
L3_HIT.HIT_OTHER_CORE_FWD'/uk,cpu/period=3D0x7a12f,event=3D0xbb,offcore_rsp=
=3D0x10003c0002,umask=3D0x1,name=3D'OCR.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE'/=
uk,cpu/period=3D0x7a12f,event=3D0xb7,offcore_rsp=3D0x103fc00020,umask=3D0x1=
,name=3D'OCR.PF_L2_RFO.L3_MISS.REMOTE_HITM'/uk,cpu/period=3D0x7a12f,event=
=3D0xbb,offcore_rsp=3D0x10003c0001,umask=3D0x1,name=3D'OCR.DEMAND_DATA_RD.L=
3_HIT.HITM_OTHER_CORE'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x2,na=
me=3D'FP_ARITH_INST_RETIRED.SCALAR_SINGLE'/uk,cpu/period=3D0x98968f,event=
=3D0xc7,umask=3D0x1,name=3D'FP_ARITH_INST_RETIRED.SCALAR_DOUBLE'/uk,cpu/per=
iod=3D0x7a12f,event=3D0xb7,offcore_rsp=3D0x103fc00002,umask=3D0x1,name=3D'O=
CR.DEMAND_RFO.L3_MISS.REMOTE_HITM'/uk,cpu/period=3D0x7a12f,event=3D0xbb,off=
core_rsp=3D0x10003c0020,umask=3D0x1,name=3D'OCR.PF_L2_RFO.L3_HIT.HITM_OTHER=
_CORE'/uk amplxe-perf-sync sync sys

--lWGWlWdjNDUCCWce
Content-Type: image/png
Content-Disposition: attachment; filename="matrix.png"
Content-Transfer-Encoding: base64

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
//TTxszM6ziOjxo1avny5T07I3FaWlpFRcXkyZNvHf9cW1u7f//+MWPG0Gi0I0eOTJw4ccCAAT1b
u14euObm5vr4+PwnI9i7YGqv0P392NXVldWLd2DPksvlZWVlXa+jUCg2bdp048aNGTNmCASCCxcu
vPHGG59//nlQUFDvuTWd1EvKAQAAAADQDzjvcXV1dV22bFlJScmOHTtQFJ0yZcrZs2d9fHwcDscf
f/xRXFxMJpO1Wq1SqbTb7d3fPovFCgkJOXzokFwuP3fuXHZ29n9VU61W2/E3tVptsVhuWoFMJoeF
hZlMpmPHjlVXV6enp7e3tz+YsnV0dHz00UdUKuXdd9999913q6qqVq5c6XD05HQgarW6paXl1loj
CKLX6ysqKiwWi4uLy+DBg3tbxyMAN8EwrLi4+MLFi889//yjjz46duzY1157zdfXt7a2FsOw9PT0
CRMmxMfHv/TSS/X19SqVav369U888URqaurJkydbW1tXr14dExMzY8aM+51bGwJXAAAAAICeh6Ko
r6/vqlWrfvjhh9ra2jffegvH8cTExKeffjoiImLYsGFBQUFGo3H16tW1tbXd3yyHw5k5c2ZHR0dK
Ssqff/4pFAqJvs0Hb9q0aQP/Nm7cuNvO9+vp6bl8+fKPPvpo5syZzc3NDyyEa2hs1Gg0jz322MiR
I0eNGvXZZ59xuVy1Wp2WljZ+/Phly5alpqa++OKLTU1NCIK0tbUtWrQoMDBwypQply9fRhBEp9Nt
2bIlNjY2IiLi22+/NRqNy5Yt++OPPxAEUSgUH3/88e7du52fVVpaunjx4pCQEB8fn7feequ1tXXr
1q179uz55JNPDh06dPDgwfr6erPZ/PHHHxNj+NetW2e1Wm/cuLFq1arnn39+0KBBEydOvH79+l39
fgFAD7JarQUFBQI+f8jgwQwGg0qlikSiTz/9dMSIEa2trTNnzly2fPnevXv5fP6nn36q1Wqrq6sR
BHn77bdTUlLeeOMNs9l84sSJhQsXfvTRRzU1NfevnDBUGAAAAACgZ4SGhq5fv975lEQizZkzZ86c
/5s68qeffuq8Mo/H27NnD/GYiKBWr15NPOXz+WvWrCEeO+eAjYuLKyoqslgsNptt3bp1Uqm0vLz8
+++/v3V08QNgMt0mQeukSZOcj48ePUo8mD59+vTp0x9w8YJkMi8vrw8//HDSpMmDB6d4eHhs2LCB
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
cVVVVUJCgry1tV2p7PHSQuAKAAAAAABAfzZ79uzbZoul0+mTJk2aNGlS7ymqt7f3J598jCAfd144
fty4nv0UlUqlqK19SI6+SqW600v19fVHjx7FcbypqSk9PX348OHDhw8vKio6ceKEXC6/cOFCamqq
v79/YGDggf37jx49Wl9fX1JSctuE0hwOJzEx8fTp0zwer6CgoLKioscrAoErAAAAAAAA4CFSX19f
j159SCp7p0mnQkJCCgsLifvSuVzulClTJk+eLBQKFy5cuHv37h07dgQEBHz22WcIggwdMqSyouLw
4cMhISFz58719fV1cXGJiooich0LBIKRI0cyGIzJkyebTKY///wzMDBw8uTJnZNO9QgIXAEAAAAA
AOjDbDbbuXPnysvLiacsFisxMbGn5llVq9WZmZkDBw687QDRe1BZWXnt2jWiG5BEInl6eo4aNaqn
khI3Njbm5OSMHz+eRqN1sVp0dHTKuLkPSfOQy+UnT568dfmcOXPmzJlz6/Lw8PD333+/8xI+n79q
1aqbVnM2sMDAwO+++w5BEBcXl2XLli1btuw+VQQCVwAAAAAAAPowq9W6c+dOlUoVGhqKoqhGo0lL
S/v+++8lEsm/33h7e/sff/xB5EPqkdIWFBTs3LnTy8tLKBRardZjx46p1eqFCxf2yMarq6u3bt06
YsSIrgNX0BdB4AoAAAAAAECfN3Xq1Dlz5pDJ5IKCghkzZuj1ej6fX1hYeOTIkY6Ojri4uIkTJ4rF
4o8//viJJ57w8/Mzm80///zzyJEj1Wp1RkaGQCAoLS318/ObO3euQCBoaWnZunWrQqHw8PC4q+le
u8PX13fp0qUymcxoNK5atSozM3PhwoUGg+HKlSunT59GUTQ1NXXYsGEGg+H7779//fXXWSxWe3v7
d999t3Llytzc3Pz8fBRFW1pakpKSxo0bx2azs7Kydu/e7XA43NzcoCX0V5BFGgAAAAAAgD7vl19+
eeaZZxYvXvzBBx/MnDlTKpVWV1dv2bKFSqUmJCRcuXLlxImTer3+xIkTSqUSQRC73f7XX3+1trbW
1NTs27fPaDQOGjTo/PnzV69etVqta9as0el0w4YNU6vVLS0tPVvUsrKyN998c/HixcuWLSsvL3/s
scfsdnt2dva2bduCgoODgoL279+fkZHR0dFx+PBhm82GIIjBYDh69KjRaMzNzU1LS3N3dw8NDf39
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
o6MXL158Rh7R4FKjDs6ePfvEdhUWFgZ2eYVy+PDh4uLi8XuPg60+ZyNjMAMDw4QgD5MV5M2oqz9G
kIQqUpmWksjjcSEIqq5pjI+LiYwI16ijM9NT9pVXwjCsVUelJf8SyKCto0sVoQwLk8AwHBUV0d3X
v2tfRaxWrY6KnA6iYRgGbLbt27ejKJqXlwf26nu93oMHD55//vmxsbHp6elVVVU//PADh8MpKioK
zp8GAoGBgQG1Wg2mzNVq9ZGqKoqiioqKpirlD4vFysjI8NXW7ty5E0XRzMxMII7FYqmsrIyOjhaJ
ROnp6TU1NUCc3NxcIE5eXp7T6fzxxx/ZbHZyckpycjKCIFlZWS63G7gmpaamjnM6cmLFSUlJcTid
O3fuRBAkMzNTrVaDOfQDBw4sXLgwISEhNTW1qqpqy5YtQJzgCjNIE6pWq4VCIUiPUV9fTxBEXl7e
2I5aZwkEQWJiYsxm84H9+yEISkxMjIuLA3qye/fuxYsXp6enJyQkmEymHTt2sDAsPS1No9EE38WN
jY1arVYsFtM0rY6Orqqqam9vnzlz5qhFwukDgiDR0dFpaWmHKipomo6Li0tKSgKjiP3795eUlCgU
iri4OIPBAHQ1NTU1Li4uOONTW1ur1WqBckZHRx86dKivtzc1NfX3z8IH4fF4F1xwwYEDB5qPHZNK
pQUFBcDs7OnpsdlsEolEqVQWFRXW1tZWVlbK5fLzzjsvOE0wNDQEw7BSqURRNDIyUqPRfP3112Fh
YcFYIb8TFEVTUlI8Hs/evXthGAZJqoAyHDhwYP78+cnJyampqdXV1Vu2bGGz2VlZWQqFAhQgSbKt
rU2tVotEIqD5DQ0NOI7n5eVN0+3QvxYZNPbTigwa+2lFnvDGDhQ7ISEhVLGB/bx///45c+aEhYUl
JCRYrdadO3eCHuxExQaapo6OPnLkSF9vb2Zm5hkpNnwql56DBw/OHkd0GYYzxWq1Pv/88//6179C
D5pMpo0bNy5YsCA2NnYS6nD06NH4+HiRSDT++ePh4eH9+/fn5uaekbk7teh0Or/fr9Vqz2gU9emn
nyYlJc2ZM+e3/ejLL7+8YsWKuLi4cZbHcXz//v2NjY3XXnvtNM+ozsAwUbz11lv3339/f39/fU3F
orK8aV5bmqYJgvT5fBRNszGMw/l5Z5HT5cZYLC6XQ9M0juM+nx+CIDabzeH8ss/Q7/fTNARciymK
8vn8BEmy2VjoXkQIgurajEXFJVMiHYhuGggEYBgG3owwDINcoDweD8MwkiT9fj+O4yD9WzDQLjgx
OFmO4ziI/xdaBoIgu91uMBgm7cUBIvz5/f5QcXAc93q9IOtPqDjAyQ1MeoJsEyDzB5vNBgf9fj/Y
8MLlckcNAfv7+1ksFjCMJ1kcsMDC5/MxDAPBL0aJA5TW5/Od9um4XK6BgYG0tLTJaUdAFpqmQYQI
UA2bzcbn89ls9klVEZzr9XqDQTQIggABV0PlhSDI5/O1trbOnDlz+vQb4LaDeXn28R2JwLuSw+EE
FSxU64LygpsAQRBJkiBXyqh7AkFQdXV1fn7+b64hSZIg5RII2wFGSiB4CkikBBoOCMTN4/GC5geO
4yDCLTji9XrBpmWw1St4/ZaWFrAE9zs1P/TmAB/yUG05reYDlQtqvmvf95ZPnwO/Ir3qPvFFN04T
hTl7Igcbe09PT+hux9/fkE+q2KcSZJRiEwQRjL8TqtgEQTRv/Eq66W3wr+j8FbLr/xZaAWbFdbKR
yWRBq7W/v//rr7/W6XQ4jl977bVqtXpy6nBGPfuTTz7pdrtZLFZ+fv4fyGqFIOiMhhSffPLJsWPH
KIqSSqW33HLLb/7Rxx577IzKYxi2YMGCBQsWME2DgWF6AsMwhrEwbPSWB5FQECwAHBdPPDfU2kEQ
hD89PIRDAeboKLcUBEGCa1koip50pQKcGPwXw7Dp4LcJhnSjYjKF1u2k4sAwfOJNAAOsqQ1DelJx
YBgOGgMIgpz06QCJptXTAaPYE5eAgmv4J1VFQOhBFov1hwhneKpuIfjsxlCwUHlRFD1xp9KEgKLo
iaFcQ+tzKrUZdfxUT23CNT/07p1KW6ah5p9jIp+qIYfWczyKzWKxfpvzNmO4TiVarfaRRx6Z5pV8
4YUX/gzP4tZbb2UUkoGBgYGBgYGBgWF6csoICpMc9p2BgYGBgeHPCZt1zkb4h2F4OsdE+c2A7BR/
dClA7opzRtPOGVnGyTQfqI9ybGZgGvv4NWeMb0/+OnE6neHh4UyKDgYGBgaGswdOUE53gLkPUhHn
XH3hEgQBkmyfY3KBDWZ/dLlARopz4+lQFCUWi/9UA1eQP3naVo/H4+E4Pt1qGAjJ5urz+eg/jcKQ
JBnMODWdoWlaJBKNkcbn5Iar0WgcHh6ezrl6GRgYGBj+6Pj8hN7C5IKC7K6An9adk6KBSCF/iE2J
Z0RolJE/LgRBeL3eEzc6/hGhKMrpdIKstn8SbDab2+2ettUDKZGn2yofy2YL7s50OBy47tzseE/a
2D0ez7QNxB2EpmnCYpGO8QRPejQ+Pn54eHhyAs0xMDAwMPypAClGIAgSCdiJGilzQ+rajOfqC3eS
owpPGpMTVfhsM5lRhc82IKrwn2rgWl1dPZ3l/T1Rhc+izhvaLMc/K5VK8Z9GYUBU4enfQAiCaG45
MkaBc3ZfDQMDAwMDAwMDAwMDA8O5AWO4MjAwMDAwMDAwMDAwMExrmHQ4DAwMDAwMp4SiKJPJ3NDU
6vH61NGq1OSEUelYKYoaHNQ1tXRQFBUXo0lKjGOzMafL3dDUYrXa42I0GenJEAR5vb7O7p5whSIy
Inz6SOf3+9va2np6elAUnTFjRnR0NMgmH8Ttdre0tAwODvJ4vNzcXLlcjiCIwWA4cuQIhmFpaWka
jQaCoMHBQYfDERsbe9K0opMpTmdnZ3d3NwzDmZmZWq32RHHa29v7+vp4PF52dnZERASCICRJNjc3
d3V1sdmc1NSU2NhYcLC1ra27q4uiqLS0tOTk5MkXJxAIdHR0BMXRaDSjQhl7PJ62tragOEqlEkVR
i8VSWVmJIEhaWlpMTAwEQcPDw1arVavVTuFmY4Igent729raSJJMSUmJi4sbFRQXPLuuri4Mw9LT
06Ojo1ksls1mq6ioIEkyNTUVOJybzebh4eHo6GiZTDad+w2CIIaHhxsbG3EcT0pKio+PH7UjGsfx
rq6ujo4OGIbT0tK0Wi2GYXa7vbq62uVypaampqSkQBBks9kGBwdVKpVcLp/YGrpcrqqqKovFEh4e
npWVFRYWNqqAwWA4evSo0+lUqVQ5OTk8Hg90F319feAUkGC2rq5OJBIlJiZOrOb39PR0dHRAEJSa
mhoXF3ei5oOWzuVyMzMzVSpVUPMhCMrIyAhqvsViiYmJmf7b7IHI7e3tMAyfVuQZM2aENvbJFJkg
iIGBgZaWllMptt/vB88ORdGUlJSgYldWVvp8vqBig4b8GxSbWXFlYGBgYGA4JR6P90DFEYKkIpSK
3r6B9o5ugiBCC1ittr0HKkVCQZhM0tre2d3TR9N0a2tHwI8nJcbV1DXa7Q6KoqxWe0/PoEgomD6i
0TTd0dHR3tGhVCr5fP6uXbtGxZwMBAItLS39/f0qlYogyf3794OojYcOHZLJZHK5vLGx0ev14jje
09NDUdTUBmIB4rS0tMjCwvh8/v79+0eJg+N4S0tLV1cXEKeiosLr9dI03dnZWV1drVKpuFxOXV1d
f38/BEFdXV1NjY0KhSI8PHzXrl0DAwOTL05PTw8QRygU7t+/32w20zQdKk5HR0dXV1dkZCQQx+l0
0jS9f/9+sVisUqnq6uo8Hg9BEP39/X6/fwqzp9A0PTIyUnf0qEAgkMlk1dXVQ0NDFPVL6FCSJAcG
BhobGxUKBcpiHTlyxGAw0DRdVVUlFApTUlKOHDnicrlIkhweHrbZbDwebzp3GjRNm83myspKDper
UCjq6+v7+vpIkgwWoChqeHi4pqZGJpMJhMK6ujqdTkfTdG1tLYqiWVlZhw4dcjgcJEkaDAaj0Tjh
80EURf30009Wmy0xMdFutx88eNDv94cWcLvdO3fuhCAoPj5+YHCwoqKCpmm9Xj88PBwTE2MymXQ6
HUmSXq+3urp6Yo1qoPmNjY1isVgoFB46dOikmt/a2hoZGQlBUOXhw6GaHxMTU1dX53a7gea7XK7p
n+AzKDJo7KcVeVRjnzSRgWJX19SEKnZoQ6YoamBgACg2h8MJVWwulwsU2+l0gob82xSbMVynEoqi
amtrX3nllWefffbpp59uamoK7df6+vruuOOO//73v+AlGuTll18+dOhQ6JGRkZHPPvvs//7v/+rq
6kb9xMjIyNNPP/3mm28ePXp01FeXXHJJaD8VvEhFRcWES0oQxJYtWx5++OFnnnlm9+7doa2RgYGB
YTrT1z/odLnnlMzKnZmVGB87rDdYbb8yhxqbW4VCYeGsnLycLI06qrd/0O326I1mhVwWF6PBMJbJ
bAkE8M7unpgY9ajV2qnF4XD09vbGaLV5eXmzZ8/m8XjHjh0LLWCxWHQ6XWJiYm5ubtl551mt1sHB
QQiCBgYGkpKSoqKicBx3uVxDQ0MkSUZERExtylaXy9Xb26tSqWbl58+ePVsoFI4Sx26363S6uLg4
II7b4xkcHKRp+vDhw8nJybm5uXl5eWKxuLOz0+/3t7a2arXaGTNmzJo1Kz4+vqqqagrFKS4uFgqF
LS0toYMEu90+MDAQFxeXl5cHxBkYGAAj4OTkZLVaDQLtjoyMeL1elUo1hdMKPp+vt7dXJBQWFRUV
FhaGh4d3dXUFAr+kwvJ6vZ2dnVFRUbNmzZpdUoKiaH9/P47jAwMDycnJYCnJbrdbrVaTyaRWqzkc
znTuNAKBQG9vLw1BJcXFs2bNioyM7OvrC414HAgEWltbIyIiCgoKigoL+Xx+X19fIBAYGhrSaDRx
cXEIglgsFqfTqdPpNBrNhMev1ul0vb29C88/Pysra9asWW63e9TUTEtLC03TxcXFWVlZJcXFXV1d
oD4oiiYkJIDMQwRB1NTUJCcnS6XSCaybx+Pp7e0NCwsrKCgoLi6WyWQn1XyNRpOXlzdnzhySIAYG
BkiSBJqv1WopinI4HEDzo6Ojp3/+0qDIoLGfVmTQ2CdfZKDYbAwLVezQHDSBQKCzsxModnFxcahi
x8fHA8W2Wq1Op9NkMv02xWYM16mEIIiIiIgbbrjhkUce+ctf/nLgwAGDwRD8FkXRtLS066+/Pjo6
OvSsgoKCUZEMlUrlNddcU1hYOMonCvxEWFjYXXfdlZmZOeqryy67LNQPIXiRs5Ew2mQyVVVV/fOf
/7zxxpuMRlN9fT3z9BkYGP4Q6I2mcIWcz+dhGEsmk+AE4XL9KoXP4KBeHa1iszE2my2TSQicdLrc
AgHf6XR7PF6bwyERi+x2h27YmJqScDY62N8MWNKRyWQYhnE4HLVaDezSIE6nE7xEMAwTCARyuXxk
ZASCIIlEYjAYPB5PIBDAMGxwcFAgEISFhU2tdGBFTiaTsdlsDocTHR09ShywIqFQKIA4Crl8ZGQk
EAiMjIzExsZiGCYSicLCwhwOh16vd7lckZGRPB4Pw7DExMT+/v5JnnJ1uVx+vz9UnJGRkdDFDbfb
7fP5QsUxmUwURclkMr1e7/F4vF4vm83W6XQYhikUiil8Oj6fz+FwyOVyDofDZrMjIyNtNluo54Lf
77fZbBERERiG8fl8uVxut9txHJdIJGAs7nK5eDyewWDw+/3R0dHTqh2dSCAQsFqt4QoFl8tls9kR
ERFOp9Pn8wUL4DhuMplUKhWbzeZyuWFhYeBpisVis9kMbpdIJDKZTA6HIyYmZsLlHR4eDg8PF4lE
KIoKhUKJRGIymUILDA0NAf1HUVQqlQoEAqPRyOFwCIKw2+1Op5PH4wUCgWPHjhUUFExs9Twej9/v
B9rC4XBUKtVJNV+pVAa1xWQyEQQBNN/r9Xq9Xi6XCzQ/MjJymmtLqMigsZ9WZMUUiQwUW/FrxQ6d
gcJx3GazAcXm8Xihim0wGIBiC4VCk8nk9/t/m2Ize1zPOkaj8ZVXXmlpaVGr1RiG0TSNIEhOTs4t
t9zCZrODRil4oqHvRRiGMQwLnY0YHBz87LPPampq7r77bjABCUAQhMPhnHR+BYZhFEVDnWr27du3
bds2MEFSU1Pz7rvvjrrI2VD3qiNHFi9eLBQKhUJhW1trT0/PzJkzwVdfffXVHXfc8dXq1csuvZTR
FgYGhumG2+0Vi4SgY8QwjCIpHMdDCzhdbpFQCIFOm4XREB0IBHKyM/aVV67++ljOzEyFQr5zz4H0
tCTONPNYCwQCEAyz2WwgnUAgcDqdoQVwHKdpGqxuwTAsEAhA3sj58+f/+OOPGIbNnj0bWCAJCQmj
dmRNPjiOQzDM4XBOJQ5BEKHi8Ph8t9sNzF2QyxRBEDabDdYuUBQNvhBFIpHf7/f7/ZOZuBXHcRqC
QsVxu92hgwSCIEiSDBXH43bTNL1kyZKNGzdCEFRaWurxeNxud2Ji4tQuhpMkiRMEl8cDsnC53FED
Hoqi/H4/GKuABLl2u50kyblz537//ffl5eWlpaUQBA0PDyckJEz/BTSKovyBgOz4VA6Xyw0EAqEL
aDRNe71e4CcJwzCHy8UJgiTJ0tLSrVu3Hjp0qLS0lM/n19XVJScnnw15XW63SCwG1QNqH7puBkEQ
mLiBYRiGYQRBOFyux+NJS0sbHh7esGFDTEyMRqNpbGzMysqacLdtgiBoCOJwuaB6fD7/pJoPGiMM
w1wez26zBTWfJMmysrJAIDAdNP8siTyqsU+ayECxlXz+GIrt9/tPqtibNm0CDZnFYvX29v7mhswY
rmed8PDwsrKyefPmzZs374UXXrj55pujoqJeeumlYIHh4eHvvvtu9+7d9913X3j4WEE71Gr1P/7x
jx0//cT+Hb1YWVlZWVkZ+PzII4/8NsX9/vvvjx07FmxUCIIkJiauXLnyVKfohoZmZGeDzxiGhTrf
x8bGLV26NEarZVSFgYFhGkIQBIL+7MyCwAhNQ9SvV94IkkCRn+f7YBiGIJqiaalUfOnFi8BBs9mi
15tzsjO2bNttsdqTEmOzs9J4k2gCnQqKomiKDk5WoigaOgQBBSiKChZAUJT0ByAIio6OvuOOOyAI
8vv9tbW1HA7HarXu2bMHguHS2bPVavWJ7j+TIQ5N0xQNw8cfFoKMLQ6KICRJkSQJhubBs8BDDz0R
2OShCyCTIw5FUWckDkXREAQplcrbb78dgiAcx+vr6xEE8Xq9a9euJSmquKgoJiZm8qcYaJomSRIJ
0TSKokLH5T8XCD4FFKVpiKYhhUJx2223QRBEkmR7e7vP58MwbN26dT6fD7hwT08j9ri8vzw7mqZH
yUsQxK+0jqZpmpbL5ddeey30c8i3QafTKRKJ1q9f73a7s7Oz09LSJmrvYmj1gP6P0i7QLoL/IghC
URSPx5szZ86cOXMgCLLb7b29vRdddNHOnTv7+vqioqJKS0vBBNDEaD50mn4pePeA5tM0Har5zc3N
QPO/+eYbnCCKi4q0Wu20NWLPksgT3thHNeSTKvavGnKIYt90001AkO7ubqfTiWEYUOzc3NykpKTx
KzZjuE4SwJkH+GKFvmkgCFKpVPfcc8/ixYt3796dlpYWERExzWWBYXju3LmFhYWhB8eeh0ZRNOhL
MGpFd9as/M8++4w7DcZwDAwMDCeCYRhB/DyGICkSQWAU/ZVVxsHY+PECYPDBChkrUCR1qKo2OzNV
bzD5A/jc84pa2zsHB4eTEuOmXDQURWH4F3sMx/FRowcURcGAFfxL4Dib/YudAAJ1+Hy+6Ojorq6u
vLw8l8vV1NSkUqmmxHBFEQSGIYr6+VkQBDG2ODhBsNkY8IQClioYdcEwzOFw6OPAMBwIBIAP1CSL
gyDIGYmDYazQp2O1Wu12e3R0dH9/f0ZGBkVRbW1tkZGRkx/5GUaQ0LE4QRCj3LtgGGaxWKEFUBaK
HJ8PAuuT/f39cXFxQ0NDUdHRYTJZd3e3QqGY8Fi7EyPvz+IQv4iDoqGNAqhTUF6SIBAECS2A43hj
Y2NycrJOpwsLC8vOzu7q6oqIiACxeSakW3MSjuDtJUlylHqD6gGbhIagUQUoimpqakpMTHQ4HK2t
rTfffHNlZWVTU1NxcfGEa/6p+qVfqxMrqE5A8w0Gg0aj6e/vT0hIYLFYbW1tcrlcIpFMQ235DSLj
4xN5whv7SdrpCYodWuCkit3R0ZGcnDw0NAQUu7OzUy6Xj1+xmT2uUwmO4x6PB7x14uLiPB7PKA+0
aUt9ff327du3HWf79u21tbVjlE9KTm5oaIAgyOfzjfK22rx584YNGyZ5JpuBgYFhnEjEIrvDCQZw
fr8fQeBRHr9Sqdhmt0PHvaSAt2rwW92I3mJ1JMTHOJxueZhUIhZxMLbb7ZkOogEfP7/fD6Sz2Wyj
UoxwOBwURcHePIqi7Ha7WCwOfuv3+4eHh3k8Hp/PZ7FYQpFIpVI5nc6p6s/BbQeBgk8qDpvNRlHU
4/EAcZwOBwhbyuFwbDYbBEEgSiqLxZLJZDAMBy9lNptFItEkL9dwOBwUQULFER/37QyKg2FYqDhC
oTBYAMfx4eFhDMMkEgkMwyKRKCIiwuPxjFrJmRwwFovL4QS9H8EOydDhLIvF4vP5IHwRRVFul4vL
4QQXi2iaBlGIIyIicByXSiQKhSIQCIRurptWsFgsPo8H4r5CEORyuTgcTqj+IAgiFAodDieQzu12
YxgWWmBwcNDj8URHR/t8PqlMBuzzUYF/fw9SicRms4HqEQTh9XpHZU+RSqUOhwPM3ZAE4XG7Q1dT
rVar0WiMjY01m82RKhWXy1UoFBaLZULqxmazUQTxeDygeg6H46SaD7YtgAhkQqEwqE4gYi2CIEDz
xWIx0PxRbhTTijMW2eEYj8gT3tiBYrtcrlDFDl3URRCEz+ePrdiBQCA6OhrHcaDYJEmekWIzK65n
HZ/PNzIyYrfbMzIyIAhqaWlJSUnx+XwDAwMSiaS9vd3v97NYLJ/PJ5PJxl547O3tNRqNra2toIuX
SqVTklkOhmHg+Tz+U2ZkZ3/yyScHDx70eDwejycvLw8cdzgcTz/99LJly6Z8cxQDAwPDSYmKVHZ2
9w6PGIRCgW7YwOVwRCIhBEFmi4XD5giFgvg4TXtnT1pqIgzDI3ojn88L5rwhCKKmrrEwfyaGsdgY
5nS6AjhOUhQLmxYvX7FYzOPxdMPDSqUSZOebMWMGBEEkSZrNZolEIpFIOBzO0NCQTCZzOBwgoyM4
F8zxG43GnJwcBEEomiZwHCwUTFUoFKFQyOPxRkZG1Go1SZKDg4Pp6ekQBPn9fofDIZPJgI06NDSk
VCodDofdbp85cyaLxYqNjW1tbQ0LC3O5XAaDAazjyWSy/v5+hUKBomhzc3NSUtIkywWiQgBxgONo
cnIycLI1Go0SiQQUGBoaCg8Pdzqddrs9PT0djGVpmnY4HIODg7m5ucCexwmC9npZLNaUPB0Qf0in
05nNZhRFBwcHgRsaBEEjIyNAzcLDwwcGBoCpZrFYEhMTg4tOPp+vpaUlNzeXzWYjKBoIBHw+36il
nmkFm80ODw9vbm42Go1sNntoaEgqlYK1L71eLxQKMQyLiooaGOiPidESJGk2m1UqVXAEiOP40aNH
c3NzwaA/4PeDyaMJHClFR0fv37+/t68vMiJiZGTE6XQCdz+Xy0UQhFAojI2NPXy4ymAwyGQykPJE
oVCAc0mS7OjoUKvVYrHYZrOBBRifzzdRrnN8Pl8oFOr1emAJDw4OBpOa6vV6MNkkFApBeluX222z
2YIbO4GxNDg4OGPGjJ81H8fBbNS01ZZQkW02G2jsY4sMGvtpRZ7wxg4Uu6OjI1SxwY/q9XqRSIRh
WHh4OFBsHMfHUGwERYFig1g8468DY7iedQiCUCqVPp+PoqjCwkKr1cpisWbNmuVwOMLDwxEEAdMk
EATNnz9/7ITaNptNp9MJ+HwYhkEGrT/KTRCLxQsWLGhtbeVyuSAfMTh+9OhRrVZ75513MnrCwMAw
PVGplKpI5eEjdQIB3+v1pSYniEVCCIKO1DRER6myMlKSEuJ6+wYrD9eiKOoPBLIzU7ncn1dch4f1
gQCeEK9FEESplPcPDh1raYdhWKmYFv6NfD4/Pj6+oaHh0KFDBEGIRKKEhAQIgrxe78GDBwsKCiIi
IjQaTVtbm8Ph8Hg8MTExwc0sBEHodDoej6dQKAiCEAmFXV1dfr9fo9FM1UQkj8eLj49vbGo6dOgQ
CGQCxDGbzdXV1fPnzxcKhUCciooKj8cTGRkZEREBw3Bubm55eXlFRQVBkCDbB4ZhKamp1dXVIAtO
IBAIBhScTHFiY2Prjh49dOgQRVFcLjc+Ph5BEBzH9+/fX1RUpFKpYmJimpqaQELayMhIlUoFhqoU
RQ0NDbHZbKVSSZKkWCzu6+0lCAJE+5z8R8Nms7Va7fDw8KFDh1AUpWk6Li4OGK67du0qLi6OjY2N
i4urqqqqqKjACUIgEKjV6qAi9fX1wTAcHR1NUVSYTNbf328ymRQKhUAwjbIih8JisdRq9cDAwKHK
SjaGBQKBzMxM4OCwb9++GTNmJCUlJSQklJeXHzp0iKJpDMNCd2D29vZSFAVicMrl8o6ODqfTyefz
J2QHKSAsLCwjI6OysjJCqbTb7VFRUaBpd3d3u1yu7Ozs2NjYzs7OI0eOiEQis8WSmZkZ/HWLxeJw
ODIzM0H8WwSGa2trLRZLSkrKhNSNw+HExsYera8HqR9RFAWaD0HQ/v37Z82apVarY2JiGhsbKyoq
fD5fWFhYcHsCyCPKZrNVKhXQ/MHBQYqiQs2naUioyBRFnVZk0NhPK/KEN3ag2P39/aGKDQzXffv2
5ebmgpw3hw8fBp3wSRVbo9FAEBQmk/X29jqdTolEckaKzRiuZx2hUHjp8Xi5ixcvBh+uvPJK8CE3
Nzc3N/ekJ4Jcz3v37s3KygJeIjNnzjzpu9Nutzc2NoJsTqO+Al5e27dvT01NDQ1EDEGQwWAI9QwJ
XgSo1MSComhOTk5OTs6o42w2++9//3twCp+BgYFhusHl8ooL8voHh3Acl4fJVJFKMJ5WR6tkUgkE
QSKRqGxO0ZBuhKah8HB5pPKXvCMYGyspygOvbWW4IjsrzeVyhyvkcrlsOogGw3BMTAybzTYajSiK
arVa8FLAMCw2NlYgELBYrMTERB6PZ7Vao6KiYmJigoM/GIbDw8NjY2NRFAXJ24aGhiAIio2NnaqV
DSAOl8s1GAwIgqjVaiAOn8+PiYkBi1eJiYkCgcBsNkdFRYEsgjAMa7XaOXPmGI1GDMNUKhWIkqhR
q1EE0ev1MAzPnDlz7NCJZ0kctVrNYrEMBgMMwxqNRiqVgjg68fHx4OnExsay2WyLxcJmszUajUAg
ALoHw7BMJouKigJPJzk5GWSs1Wq1UxLNCIZhhUJRUFAwPDxM03RUVFQwPU9iYqJIJEIQRKVSFRYW
GgwGsBoJvLXB6QKBoLCwEMgCVC4QCGg0msnfrDt+eaVSaVFRETAhIiMjwUIFBEHx8fESiQRBkPDw
8JKSEr1ejyBIVFSUXC4Pystms2fPng36DbVaDfYgqFSqCTRcEQQpKSnp6upyu92gLQDFCAsLA6rF
5XLPO++8vr4+v9+v1WpDM5ewWKz09HRQYZFIVFZWZjQaQTbRCdR8Nps9MjICJiyA5oO7B5z2Y2Nj
uVyuyWTCMEytVodqPnCUDWo+WObRarXT2XA9U5G1Wu14RJ7wxg4Uu7CwUKfTnajYYrEYNGSg2CiK
qlSqUyl2bGwsi8UC2a3OSLHhU+UlO3jw4OzZs6ftM/4z4Ha7GxsbRSKRVqsd+6F6PJ7+/n6Hw5GU
lDRqzdbn87W3t1MUFR0dDd67zc3Nx44dIwjCZDIVFxfn5+ePukh8fHzQIeRs4/F4OBwOgiDTP8sW
AwPDRPHWW2/df//9/f399TUVi8rymBtS12YsKi45J0Wz2+0GgyEpKekck6u/v5/FYo3Kqf6Hw+Vy
DQwMpKWlnQNPxOfztba2Tv7C+BRSXV0dHMJNQ1paWqKioqZbPCTXvu8tnz4HPkuvuk980Y1/Em1x
uVw9PT1ZWVnTvJ4EQTRv/Eq66W3wr+j8FbLr/xZagFlxnb4IBIKioqLxlOTz+ampqSf9isvlZh/P
QwMA/hIgsnZ8fPx4LnL2mLbTpQwMDAwMDAwMDAwM0wfGcP3TIZPJxt5Jy8DAwMDAwMDAwMDAMK04
peEaGxvL3B0GBgYGBoazTXT4NI0x8/sBeTLOPbmkUul0DlI6TjgcjlKpPDeeyDnguX2mqNXq6Vw9
pVI5nbeV/tkAkbSmfz0RBFEoFGNkLjq54VpXV+fxeHp7e5knzcDAwMBwljDbfdUtBuY+QBDUrz/I
3AQGht9JR0fHn0rerq4u5qGfEYLOzrDjn3t7e50H/1wdb1tb2/SvpMhkkp7625Mbrjk5OUxwJgYG
BgaGs0F1dTX4IJdw89POkQWf3wMTnOkPBxOcabrBBGeabkzT4EyE0bL/58+xsbHiP42l43K5uhsa
U9jTfQ2coOmxJ2P+8I4uDAwMDAwMDAwMDAwMDOc2jOHKwMDAwMDAwMDAwMDAMK1hogozMDAwMDBA
EAQRBDEwqOvs7qMoKikhLjZGjSBIIIA3Hmsd0o2AMspweVpqkkT8S25tiqL6B3XtHd0URaujIxPj
Y7lcjtvtaWppt9nssVp1SnICBEFen6+nd0AhD1OGy6dQRpIkGxoaUBQFmdI8Hk9HR8fQ0BAMwwkJ
CQkJCSiKhpZ3OBxtbW0Gg0EoFGZnZ0skEgRBTCZTbW0thmEpKSnAXVan07lcLo1Gw+PxplC6QCDQ
09PT09MDw3BaWpparT5pCCW/319bW6tUKmNjY4PyglsRERERGRkZWrilpcVkMs2ZM2dynk55eXlO
To5YLAYK2d/f39nZieN4XFxcUlIShmEnnmWxWHp7exMSEoBbptVqPXLkCIqiycnJGo0GgiC9Xm+z
2dRqtUAwZWHAKIqy2+1Wq5WiqLCwMIlEMkrTSJK0Wq02mw1BELlcLhKJEATx+Xw6nY6m6bCwMJAQ
wev1ut1uoVA4zQP/kCQ5MjLS3NyM43hCQkJsbCyHwwktgON4b29vZ2cngiApKSlqtZrFYjkcjrq6
OrfbnZycnJiYCEGQ3W7X6XQRERFhYWET3lhGRkZ8Ph+PxwsPDz/xfno8HoPBEAgEBAKBUqnEMIwg
CKvV6nA4wClAG/V6PZvNnth0FSRJAm2BIEgul4vF4lENGcdxm81mt9tRFFUoFEKhEIZhr9c7PDwM
TgFtweVy+Xw+sVjMZrOns7acqcjh4eECgWByRCZJ8kBtzYzkFJlE8nOnNDLSNdBP01CSVquOiBjV
KVkdjupjTV6/H/ybpNUmarU+f6Cm+ZjP70+KiU3QaEAxvdkUIZfLxGfmTM4YrgwMDAwMDBAEQcea
279Ys95oNsMwAkHQU4/dHx+ndTicr/37wyHdSHRUJARBM7LSIiOUoYbr0NDI86+8Q5EkDUEoAl99
5aXzzivZtffgjl37eVy2bsT4zr+elUrEPb0D73246p47b5paw7W7u/u+++7Lycl5++23A4HAjh07
NmzYQNM0DUEBv//Jv/89OyRDvcPh2Lhx4+bNm8GYOz09/e6775ZKpZ988klzc7NYLI6MjHzggQdY
LNaGDRtYLNZVV101hYYrTdNVVVVffvml3W7HcTwsLOyFF14IDw8/sWRlZeWDDz54ww033HnnncB8
8vv9W7du/fzzz++4446LLrooWNJoND755JMmk2n//v1nu/44jm/cuPGpp576+uuvs7KyaJpubm7+
+OOPjUYjjCB+n+/JJ5+cMWPGKHvPZrOtWbNm69atL7zwwowZMyAI+uSTT+rr68PCwoRC4RNPPMFm
s7du3epwOK6++uqpMlxpmrZardXV1S6XC4IgDocza9YspVIJwzAoQFGUwWA4cuQISZIEQchkstzc
XJlM1tzc3NfXJxQKW1tbzz//fAzDBgcHR0ZGsrOzp7PhStP04ODg+++/39PTgyAIj8e766678vPz
g8+OJMmOjo7XX3/d6/USBKHRaG677ba0tLQNGzbs27dPLpevXbv27bffFolEdXV1u3btuvnmmyfW
cKVp+ujRo93d3Xw+PxAIqNXq/Px8FusXo8Dv91dWVlqtVhaL5Q8E0lJTMzMzLRZLfX09QRA4jufm
5kZFRZEkuXv37uLi4gk0XGma1uv19fX1Xq+XoigulztnzhyxWBzUFpIkBwcHGxsbSZLECUKhUBQW
FPD5/Lq6OoPBwOfz+/r6SkpKWCxWV1eX2+2eMWPGNDdcz1TkCKUyPz9/EkQmSHJv1eE7n3tmzSuv
F2RlURTVNTDw3trVNqcThmGJUHj75VdkJCUjx+tJ03RrT/cDr70Sr9bwuVwIgi6dO0+ritq4Z9ee
qiplWNi3O7a/+bfHBDxeZcPRww0NN166jDFc/6T4fL6mpia9Xo9hmFgsHtUBTQgGg8FgMKSkpGAY
ZrFYKisrY2JiUlNTR71EJ4Th4eFjx455vV6FQjFz5szfMBKyWq1VR45IJZJZs2ZNedKC4eHhlpYW
u91eUFAQHR09sRevrqnp7uq6/PLLf8+D8Pl8DQ0N6enpQqGQaU0Mf058Pv+OXfttDseD99zO5/Pu
uu+JLdv33HPXjQEcN5nNd916TUnxLAiCeFxumOxXL9r9B6uajrV+/vG/ERj6zydf/bS7fFbejJ17
yrMz0664bMklV9zS1t6VnZVeWVUboVQkJ8VNoYwEQbzzzjvDw8M5OTkQBOl0uq1bt8bFxd14440E
Qdx///1r16wJNVzb29u3bNmSm5u7cuXKwcHBhx9+uKCgYMGCBatXr37//fchCHrvvff0er3X69Xp
dBdffPHUBmKxOxybNm1CEOTJJ5/0+XwPPfTQ7t27V6xYMarY8PDwpk2b+vr6gkccDsfXX3+9atUq
j8cTWpIkyc8//7ylpeWk1u/EYjab165du2bNGpvNBo64XK6tW7e63e6HH35YKpU+/sQTe/bsycjI
CO3qh4eH16xZs2bNmtDX3EcfffTf//5XJpM99dRTOp0OgqC+vr7S0lK5fMpmTAiC6Ovrc7vdxcXF
LBZr//79PT09YWFhwbUav9/f1dUFw/CcOXPcHs+hQ4cGBwclEsmxY8dKS0sjIiK++eYbu93O4/GM
RmNYWJhIJJrOnYnf7z9YUVFTU/P8889LJJIXX3xx586dCQkJwdRQXq9327ZtHo/nqaeecrvdr776
6p49e+Lj47/77rvrrrvu0ksvLSkp6ezqitFq6+vrY2NjY2JiJraGNputqqpqwYIFGo2mu7u7sbEx
JiYmNF3KwMBAT0/PggUL5HJ5S0tLXV1dfHy8xWKhabqoqKi2ttZkMimVyp6eHgzDwML+RBEIBLq6
unCCKCkpoWl67969PT09WVlZQc13u91dXV1sNrugoMButx88eFCv18fGxh49enTJkiUSieSnn35y
Op0wDNtsNpVKxefzp/nbJyhyaWkpSZKnFXnfvn0ajeZsi2xzOreVH1i7dcuI2fyz3vr9B2prDBbL
k3fciSLI3995e39NTaI2hnd8FomiabPdHqlQPPuXeyQiIQRBEqGIx+F8v2vXzZddvrCo6Lybb+gZ
GopSKlu6e2Kjo7WqM45vx+xxPUfo6urq7e3FMIzL5XI4nOAkzQQ2qra2tubm5p/1BkGMRmN3dzdF
URMui9PpbGpqMhqNPB6voaGht7eXJMkz1mwEGRke7unpoWn6TM9taGjYunXrb/jRU4GiKJfLbWlp
MRgmPvMHSZLV1dWnqm0wfGsoFotlZGQEx/HgEZqmR0ZGdu3axTQlhj8tMAxlpqdce9Wy9LTkpMS4
hPiY1vZOCII8Ho/V5sjNyYqL0cTFaCIjwkfNZOsNRgiGpBKxRCLmcjkkSdIQxEJRAkCSKIqOjBj2
Hjh05fKLz8ZM3/jZvHlzc3NzMGUAiqJz5sy5/PLLgRtqXl5eS0tLaPmBgQG/3z9//vzY2NiSkhK1
Wl1+8CAEQRiG+f1+kiQpmiYIory8PCwsLCUlZWpnCYd1upGRkYKCgvT09Pz8/Llz527ZsmVUGb/f
v23btlEBgXt7e3ft2lVYWDjKQK2oqKiqqiopmYyAz/X19YcOHbrxxhuDR3Q6XV9f35w5c2bOnJmQ
kPC3Rx4pLi4epT9tbW3Hjh3LysoKTZb7y9OhKIqiqqqqWCxWdnb2FD4dr9cL7ByVSqVUKrVarV6v
D30H+Xw+vV4fExOjUCg0arU8LMxkMgUCAQRBCIKgKAq8yo1Go9vt1mg00zyJrtPpbGhoSElJKSgo
SEtLKysr6+joMBqNwQIej+fQoUPz5s1LT0/Pzc3NyMjo7Oy02WwYhuE4DpadEQTp6Ohob28///zz
J7zfGBoa4nA4KSkpQqEwJiZGKBQCj9Mg3d3dERER0dHRQqEwOTmZJEmDwQDGlkCvYBjGcby2trao
qGhiq+fxeOx2uyoyMiIiQqVSabXavr6+0NGm0+l0OBxarTYsLCwmJkYmkw0PD4M7RpIkfRydTocg
SFRU1IQPiSecoMjh4eHjEVksFk+CyG29PYcbGuYXFLKPTzAhMJyo1d546aWZiUlp8QlKuVxnNPpD
GjJOEDq9XikLy0xMjItWx0WrwyQSBEFYLBZOBAiSJEkKhqHO/j692TSvoBA984bMrLj+4aEoqr29
fdWqVQRBJCcnczicJUuWgD69q6tr586dLBaLx+Pl5uampqaC3mrPnj0QBCUnJ1dWVvL5/FkFBTOy
s8f+lZGRkcbGxjlz5oD5UalUmpaWBnzxn3nmGR6Pt2TJkszMzAmRqL+/3263L1y4UKFQKBSK2tpa
jUYDVgK9Xu+aNWtaW1vvvOuuhPj4MS4ikUgSEhJcLpfP7//wP//BcXzZsmVJSUljv+16eno2b94c
Ha1OS0sdo9lTFDU0NLRz504IglAUhWE4Ly8vPT2doqi9e/eCBMgwDF966aXAt0epVCqVyt7e3lHL
4AMDAz/88AOYaBAIBEVFRVqtFny1b9++f//730/+/e/5eXlj367kpCTgrrNz164d27cvWbJk1qxZ
QX+wjRs3nhguXzc8bLNaBQJBcLabw+EkJyevWrVq/vz503wmm4HhLMFms+fPnQ3DMAxDRxuaa442
/d9fb4EgqH9w2Gyxfb1uc/+gLjU58YrLlsTFaEL7hwVzZ2/YvO3GOx5EEITH5dxz141CAf+ySy74
et3mR468UJA3Iz016bMvv01PTUpOnMrl1t7e3mefffa1117bvXs38NhUqVTLli0DdrjH4zlw4EBh
YeGosxAEAd0mgiAURXV3dUEQdM8993zwwQcCgWBOaanNZtPpdKWlpRO7ye03ALZHKpVKUOGEhITt
27ePKlNbW1tbW3vJJZcE52EhCIqOjn7sscdQFH366aeDB/V6/YcffnjJJZcYDIZJyA6anJz8xBNP
JCQkBOtgMpn8fv/w8PCjjz5qMpkWLVq0bNmyUS+R1NTURx55pLm5+euvvw4efOKJJz766COBQFBW
Vubz+bq7u2fOnDmFy60QBOE47vP7IyIiQMMRi8WdnZ2h860EQXg8HrCzF0EQkUhkNpsJgsjPzz96
9Ghzc3NsbCyLxdLpdEqlcvq/pHw+n8loDE7lqNVqi8XidruDBQKBwODgYGxsLARBKIqqVKqhoSG3
233rrbeuXbt269at559/fpRK9cUXX2RmZk7seibAarWGyeWgeiwWi8/nO53OUQXUajUMwzAMs1gs
gVAIDCedTrdv3z42mx0ZGdnT0yOVSic8KZTf7ycpCuzhhCBIIpF0dnaGWnF+v58gCKAGQFucTidJ
krNnz66rq8MwDAylrFZrZGTkFO7rPnsiiyWSSRA5NirqrhUrohThL3zyX3CEy+HMzsmlKAoniLqW
lr6hoYKMTF7I5m0cx/uGh4f0+sfeetPpds8vKFhYPDtMIrlp2WWrf/hh4+7d8wsLZWLJzkOHMhOT
NBGRv6FWjOH6hweGYZVKlZ2dTZLkrFmz2Gw26PotFss333yzbNkyDMNMZnNzSwuCIMnJyTKZbObM
mX/7298uuuiihQsXslis0JnaU2Eymbq6um699dZRx3/66Se/33/55Zer1epTnWswGL799tvQlc/w
8PCSkpJT9cVgRAVMvtTU1J9++ikQCICvKIqyWKyDg4NEyATPGNA0vW/vXhqC5s2bFxkZOYYtarVa
N2/ejOM4KKlQKMYo7Ha7v/766wsvvJDD4eA4Xl5ePjIykp6eDqpaXFyMYZjdbl+7du2tt946Kh5D
KLt3787KyoqMjPR6vSMjIwRBBL/yeLzt7e3+47vbT8vQ0FBjQ0NhUVFqamroL4LJhVHggYDP5wvt
ExEEkUqlwCOooKCAaVYMf0JgGOZw2BAEvfDau5t+/InNZhUX5EIQ1NHZQ1EUh8PJzkw7dLjGYrX9
9Y4bNOpfxmoikVAsEhUX5mEs1sHKIy1tnYWzcmblzQhXhNkdzihVBI4TW7ftfvm5x9//6PPGptaL
Llxw4aK5k7zniiCIl156admyy4qKinbv3g0OslgsMCeI4/gHH3xgMpmuu+660LPUajVN0zt37tRq
tc3NzU1NTenp6RAELV++HPisRkVFbd68GUyB3XvvvSwW6557702Ij5+SJY5AIEDTdPDGnjgWNxqN
27dvV6lUhYWFoRagXC6Xy+Xt7e3BIyRJrl27VqWKKisr27x58yRUHrxDQ98CPp+vpaWlv7//vPPO
E4lEb775JsZmL7v00tBQKJGRkZGRkd3d3aGXWrZsWUpKCgRB0dHRe/fu9Xq9QqHwoYceIknyzjvv
TEtLm/zlSoqiSIJEUVZQ8cAyUbAATdM4jgcfCovFIkmKouj4+HixWExRlFgsNplMNpstJiYGCDVz
5szIyMjpufRKkqTX6w26a3I4nEAgEGqoUxTlcrmC26C4XC5JkiRJzps3Lzo62u12x8TEWK3Wurq6
+++//9lnn9XpdCtXrjzvvPMmaheYPxAIKhIwTUN1D4Igv9+PYRhoyKAAjuNisTgnJ8ftdnO5XC6X
u3///jlz5jQ1NXV0dKjV6pycnAnp1sCKblBbwCr0aHUiyeAyLwvDcJygaTolJQVM0IhEIrAgiWHY
rl27CILIzc1VKBTTdqH+TEXGMMzr8Z5W5PDw8N/TFUfIFRFyRahiwDCMsVhur3fN1i3vf70mOlw5
IyWFHdIjBQi8a6CfoMi4qOgRs+l/G7/3+PwrL1xSlpcfKVf4/H6tSqUzGOrbWu9ecfWL//1w2Gi8
buklszIyx6/YjOH6hweGYYlEEhUVRVFUYmJisNfYvHnzwoULU1NTYRiOjY3d63R2d3cnJyfz+fyY
mJicnJwrrrgiNDTC2C3K6/WCzjf0+OrVq3k83iuvvBK6g/xEwsLCrr766tAjKIqO4X8PXmagf+Fw
OEEfIQiCeDzeHXfcHgjcOM6dVJs2bYqKilqxYkViYuIYHZZOp3vyySeXL19eWloqlUpPe09aWlpi
YmLA65+iKI1GA3qT9vb2iy++ODY2FoZhv98/ODjU1NSUd+ol06ysrB9//FEikcTFxc2YMSN02nLu
3LKdO3eOMxjDwMDAm2++uXz58jlz5gAFqKioKC8v9/l8lZWVzz77LJvDmT9//ozs7CNHjuzevVun
03k8nt27dwsEgrvuugv0ejweLyIiore3lzFcGf7k3Hj18oVzS1/617tP/PPVb754//JLLywuzI2L
0bBYrNSkhI8+/arxWFuo4frKG+8Xzcp54N5bYQhWR0du37m3MH9m7sys1JREUOD5V96eN7dEN6zf
V3742hXLDlXVhsmkc2ZPakP7+uuvdTrdv/71Bos12qnP5/P9+9//XrNmzRtvvJGWljaqj1qxYsUr
r7zy3nvvJScnp6eng+5CLBbPmjULgqDW1tbBwcGMjIwtW7bk5OQMDw9/vmrVE088MSWBc0AnH5yS
IwgitBpgknFgYODRRx897ZJdeXl5XV3dXXfdFbrrb/IhCOKCCy64/fbbgcfsl198ceEFF5w0sHAo
AoEAONr09va2tramp6fv3r07Li7O7/evXbv2oYcekkqlkywIDMMwAtPQz69ymqYRBAl91cIwDN6n
4F/q5wIQhmHgEfh8vr6+PpVKNTIyAsNwRERES2srn8+ffFnGKS8wzn8Wh6IwDAsdhMAwjGFYsABJ
kiwWC4RxAhG2fD7fxx9/XFxc3NzcbLfbi4uLd+zYER0dDaYkfj8oigZHVsDLdNQYKbQAKIOiKIqi
UqkU3POjR4+CKf4DBw4sX768vr6+paUFVH4CtAX+RVsoihrlivxzgWD9KQpFERiG2Ww2GEcBNxCF
QtHX18fj8WAYbmpqKigomLZRPM5UZGp8IpeUlJyNrpiDYReXlaXGxb63evUXP2zWRkWFy34erEqE
opf/7wGSolThSpIk3/7qywM11XNnzYqLVs9MTYUgyOf3f7J+fWH2jLrWZrvTVZg9Y8v+/WESaUps
7Dh/nTFcz1k8Ho9IJAIvBhaLhaJocN0SgiCJRDK2tRkK6NROLFxWVuZ0OvcfOLD04ovHOH1kZOT9
998P7QGjoqMvvOACEOr9pA2YIIhAIMBms00mk0wmC87EUBRlMpkQBBmnRTdnzhywVqzVasdovZGR
kU899dTq1av7+vpuv/32MdZIAV6vly8QBN3ngl0heDmBG4UgCJfLCb3nJzJjxoy0tLRAINDS0vLT
Tz8VFRVlZGSArywWi8ViUSqV4xFTqVTOnDmzpaUlKysLnDJr1qxg8JVHHnkEgiAMw1AULSwszMvL
O1pfbzGb8/LyJBJJUFgwbpjAnb0MDH9QoqNVUVGRD99/92XX3K7XG5VKRViYFLT3GG00hMB2hyO0
/J79FS8987iAz6dpWquJZqEsi8UW/NZksqz68ts9W7/esGl7ZnryrLwZTc1tnd29k2y4fv/997t2
7VKroyEI8vl8NE0PDQ19+umnHA7ntdde+/bbb59++umysrJRoyUOh3PZZZfNnTvXbrdLpdInnngi
1JALBAKNjY0gJCkEQRkZGRkZGa+88gqO41NiuPL5fBiGgw6ZZrM5NLGN3W4/cuTIl19+uW7dOhiG
PR7P9u3bjx49+t577504kVpZWfnDDz+sX78eQZBAIBAIBLRabU1NzSREaQoVJz4+PjY2FrzKZ8yY
sXnz5vHHlSAIorW11Ww2X3TRRY2NjRkZGRKJBISxnXxjD0VRjMUKHPch8vl8bDY7dFCBIAiHwwk6
Gfl9PgxjBU0pmqZtNpvRaExPT29pbVWEh0colYMVFVMiy3gAYTKDHk92u10gEIQOLVAUlcvlwUBc
DoeDzWaHLleCwGmrVq367rvvMjMzZ8+eXV9fr9frJ8pw5fN4I8c3tVIUFQgERq0H8Pl8r9cLRm4U
Rfl8vtBG7fP5Ojo6ioqK9Hp9uFKpVCojIyN1Ot2EGK4sFguB4VBtAZZYaAEWixUcX4G6hUaoNplM
drs9KSnJYDRGRUUJhcLKykq/3z9tDdczFtnrHY/IZ6krRlE0IkweLgszWqz/+eZrs80WNFxRBImJ
ioYgCNQtXqNp7en2+n5xHhw2GCrr6/796OPf7NiWkZhYPGNmVWOjwWIev+HKBGc6Z7nsssvef/99
4GwwMDAwoteHWkFn5DyAoiibzfb5fKOOR0dH/+Uvf2ltadnx009jnK5Wq1988cWXQrj3nntOZbVC
EBQTE4OiaFNTEwRB27Zty8zMDI4qhoeHFy9e/MUXX4zT3yMsLOzOO+/s6OioqanBT+1djCBIXFzc
k08+WVpaetddd323fv3YIZ0yMzN3/vQTuCEg/tuRI0cgCJJKpc3NzeC43W4/cODAzJkzx7jOK6+8
wuVyJRJJbm6uSqXS6/XBr5YtWwb2XI1HTA6HU1ZWlpWV9d1334EXIYZhPB6Px+OBHc7gA5ji5fF4
XA6Hw+GA48E76ff77Xb71C4vMDBMIYO64fsefuqD/35OURSCIHggQBCkSCT8+zOv3n3fk6CMyWxl
oahUIg49UREm7+jqgSAIhmGHw0mQpFj8y/DonQ//d+dt10ukEhqiMQxDUASGobMR1m5sXn/99crK
yn379u3YsePaa69dvnz5a6+9xufzV69evWHDhmeeeeaSSy45MbBfU1PT22+/PTQ0lJSUxOPxqqqq
Ql1IBgYG6urqzj//fC6XC1ZjQleZJh/wjuvv7wd1qK6uDt3hL5VK77333qqqqv379+/bt6+0tPSe
e+451eLwzTffvHfv3gMHDuzbt++BBx4A3jGTbCOBzZx6vR68j8B64/h9HfV6/b59+y688EI+n48g
CHg6oR5MkwmHwxEKhSCJKwRBRqNRLBaHOgey2WyJRGI2WyAIIgjCYrEIhcKgIUcQRGNjY2pqKjgy
arV2GiIQCDQaTVNTE3CzbG1tDQ8PD7UMuVxuamoqGOeAiLJSqTS0wAcffHDjjTeCnV+gcdE0PYH9
RmRk5MjICGgpIEHoqPWAyMhIvd4AFMbn8zns9tBtZZ2dnRERETKZDKzEgt5voqrH4/HAfitwQb1e
Hx4eHqr5PB6Pw+FYLFagG2azOSwsLKhOfr+/t7c3OTkZLCTACIIgyJSo/dkT2WQyTYnIerP5ibfe
fPurL2AYRhGEIAkuhqEIGlrgigf/75tt28C/Or2eg7H5IX3sh9+tu+rCC4VCAQTDKIqiKEJDZ9Yp
MSuuf3h8Pt+RI0e++eYbmqYPHDggFotvuOGG8PDwyMjIW2655Z///CebzRYKhWVlZeAVDl7GR48e
dTqdPB7v8ssvT05OPu2vhIWFxcbGdnd3x8fHQxA0MDCwbdu2/Px8GIYvuOCCu+++u6219aabbpqQ
kAmRkZFpaWk//vjjt99+m5iYmJ6eDjyjCIKoqamJj4//y1/+ctqLDA4OHigvj46KYrFYJbNnP/fs
s7NmzXrkkUfGXk2dOXPmZ599tm3b9jfeeOPee+891W4NmUx2yy23vPDCC+BdMmPGDDDLeN111333
3XevvfYaKHbPPffweDy73b5r1y6wCeTw4cNyufzSSy/NzMxEUdTpdILVCZIkQeBBcGJ9fb3L5dqw
YcN4bteOHTtABvOEhIRdu3Y9/vjj9957L9iHBkFQMHzoqKfJ5XJDpaNp2m639/X1XXPNNUybYvhz
EhGuSE1K2LJtj5AvEEtE/3rnv7fecCWfz5tXVvrwE8+//f5nWk3Udxu3xsVqZ2ZnQBD0xjsfZaan
LVow5+7br3vlzQ/V0SouG1u3cWtWZlpG+s+rIv0DQ9u279m9dS2GsRMT4j5f/W1tbaPH40uMj51k
6YLpNHw+X0REhMvlio+Pr66uXrt2bUJCgtFoXLNmDejcli5darFY3nrrrRUrVkgk0v7+gY8//njJ
kiWbN29OSkoKhtjFcfzo0aMmk6m0tNThcFAU1dzcbDAYsrOzJzwZ2ziJjo4uLi7+/vvvMQxzuVw1
NTVPPvkkBEGtra3r1q37y1/+olKpgnNzEokkOjr6VPFpQUQ98LmiokIkEmWFZAmatEdWWlr6zTff
gHwBq1ateuzxxzkcjtfrfe6551auXJl96qiKJEk2NTX19vY+/fTTbrcbw7Dm5mYcx8EExOQ/Gh6P
p9VqD1ZUVFZWstns/v7+2bNng3fQtm3bQKyH+Pj4qqoqNhtzOJ1ujydHowk6RZtMpuHh4blz51IU
xefxjAaD3+cTCoXTNpWrWCyeO3fu1q1bX3755YiIiB07dtx9991A9x5//PElS5YUFRUtXbr0qaee
UigUHo+nq6vr/vvvB2YqBEEdHR27du165plnaJpWqVTHjh0Dk84RERETVUO1Wh0eHr7h++9zZs5s
bW1FURR0EZ2dnR6PJzExMTMzs6mpqby8XKPR1NbVabXaoOHqdrv7+/szMjL4fH50dPTBgwdNJpNe
r5+oKE0CgUCtVjc0NrKPHAG+IUuWLAHm8a5du9LT0xUKRWRkZGtrC4uFmsxmgiC0Wi0oQFGU0Wh0
Op2JiYk4jqMIYjIaLWazVCqdzqlcgyLzamsJgjityCiKjkfkCe+KxUJhVlLKZxvXyyRSAY/32fcb
i2fMUMrDIAj6xztvXXReWUZSUmZS0icb1rMw1GC2bDl44LqLlkYd70s7+vr2Vh1++q67KZoOE0uO
dXWyUDRMLFGeSY5ixnD9wwPyFM+ZM+fEr4IGVShz586dO3fumf5KdHR0dnZ2dXV1bGwsgiAajeap
p54CX2VlZZWXl0+sUJmZmSfGKCZJcmho6L777htPdES1Wv34Y4+Bz/l5eRs3bhz/r19wweILLlg8
RgEEQbKysk4cx6AoetVVV406KJFIli9fvnz58hOv89JLL530+i0tLQ8++OAY8a5CWbFiBUhUqFar
n3322VHfjtpdDDgxIxyO44ODg/Hx8dPT7YqBYRLAMOyaFcu4PO6adZsIgrh0ycI7brkGgqDS4vyn
H79v1ervbHZnaXH+rTesVEUqIQiqPdosFokhCFpx5SUUTa/+5nuCIBefX3bDNZcLjjuJlFccufO2
60CMx4L8GdW19Z+sWrv80gsL8mdOlZggnh9IWGq1WlEU7ejoCEbNTUpKWrp0Kdgev3DhwvT09Ftv
veXdd999/vnns7KyXn755WD36/F4hoaGrrzySg6HEx4evmzZsvfeew/kUD3tbouzBIIgK1asIEly
3bp1XC73pZdeAlFbLRZLTU0NiNQQJC4ublTkEg6HExsbGzQegigUijFchCacjIwMYI+xWKzly5eD
MFF+v/+ee+659JJLMAzz+XwHDx48//zzg6eIxeKYmJhQixTH8dbW1uuuuw4E0bnooovee++9QCDw
8MMPnyjg5GidWq2eOWNGQ0MDRVF5eXlarRZMGfT398fHx6MoGhsb63A4mpqauFzurPx8lUoVfDp9
fX25ubnAjo2NjT1y5IjRaJw1a9aUyDJOebOzs//2t7+98847Xq/3hhtuWLRoETCcysvLZ86ciWFY
SUnJrbfdtvqrr3g83u233z5nzpygvD/88MMDDzwAfM3Kysrq6uq+/fbbW265JSEhYaJqiKLo0qVL
9+zZs3fvXpVKNW/ePKB1drvd4XCAhnDhhRdWVFT09vZqtdri4uJg9YxGo1KpDAsLQxBEoVDk5+fv
2LFDo9EEZ8x//90DCXiampoQBCkpKQk2VRCKGcOwtLQ0giCOHj0qEAiKi4slEkkwVY9Op8vIyMAw
DMOwpKSk2tpaHMeLioqmc3jhoMiNjY0oip5W5Dlz5oxH5AnpimEYzkhMBKumPA5nyZw5bq9n7dYt
BEleNOe8FRdcKBGKIAiqaGjIy8gszJ5x15UrOCzs/bVreRzOjRdfsnTe/GD0pq3l+++95lqQ9HVe
QcFH336zftfOO6+8Kl59BnGz4VOtzx48ePCkazUMf1q6u7t7enpmz549VXOcFEUZDIbw8PCpTYQ4
CRgMhkmeHXS5XD/99FNZWVnYmcx7MTD8Nt56663777+/v7+/vqZiUVkec0Pq2oxFxSXnpGh2u91g
MCQlJZ1jcvX3949KBvtHxOVyDQwMjIrI9QfF5/O1traOvT3nHGOUM/x0o6WlJSoqapyhNCdP5/d9
b/n0OfBZetV94otu/JNoi8vl6m5oTGFPUyeFIARNd/U3Sje9Df4Vnb9Cdv3fQgswK64M4yU+Pj5+
zNSpZxsEQUIjbZzDjDMm0wQiFAovu+wyRskZGBgYGBgYGBimJ0xwJgYGBgYGBgYGBgYGBoZpzSkN
19DoYQwMDAwMDAxnCZmIc66KhmHYhATtm27w+fwpiXI0sbBYrGm7TfRMASlGz9k+4mRM8609YrH4
tDmHGSazsUv+CA0EhiDhmLHTT+4q3NfX5/f7g9EaGBgYGBgYJhyXB+/ROZj74A+Q5+oLl6IogiCc
Tuc5JhdIc2Iymc6BpwMidf3RoWk6EAj8qQauIJnqtK1eIBBwuVzjT+A0OSB6fdCYNplM+j+NwlAU
hQf8Xtw//auK0GNtZD35VxKJZHBwMDo6+s/T/hkYGBgYJhk2hkjP3cXG8dMzZFfHnJtx0Twej91u
P/eivplMJgRB/uhy+Xw+k8l0bgSPALHx/1SpyLu6uqZzeLDBwUGxWMw/HmJ9uuiJQBA4/pnj8aIW
259EWwI07aIIBTrd18ApCDLR1BghpE5uuAJ3i/EkHWH4M0PjOOV0okwcWgYGht8EG0PPYS/Z8dML
w+fqC5fFYvl8vnNPOrfbzWKx/uhyuVwuh8Nxbjwdn883MjLypxq49vT0TGd5DQaDWCyedlGFhULL
8c88BBWgf5YgtR6KslGkbNrLS9D02H4sTHAmht+OY9s2y5o1zH1gYGBgYGBgYGBgYDirMIYrw2/H
vHq1adUq5j4wMDAwMDAwMDAwMJxVGMOV4TdC+3y277/3HDnia21l7kYoFEWRJMncBwaGPxz+QODb
9T8Uz1umSS689tb7dMP64FckSX67/ocrr7urqrruxBNpmu4f0D39/BtvvPMxONLc2nnV9Xen5857
6rl/kSRJ0/TAoO7xp1/Zu79yqqTbum0bi8USCoVCoTA6Ovqf//zn3r1758yZIzwOiqLh4eGj5Gpv
b7/tttuioqLy8vJ27NgRCAQgCNq+fXt6enpxcfGaNWsoiqJp+ttvv33llVeGhoam8PHRND0yMvL0
008nJCQkJyf/5z//8fv9owqsWrVKpVIJBAIg8rrvviMIoqu7G0GQ4H149NFHIQgym82PP/54XFyc
RqN5+OGHz2oEI5qmu7u7V6xYoVAoUlNTn3nmGbvdDg7+3//9X2xsbFxc3JNPPmk2m2maHnUuSZL7
9u274YYb6uvrwZH9+/dnZGTk5eV99tln4On88MMPL774Yk9PzxQ+Gp/Pd/jw4Q8++OCdd945ePCg
2+0OlYWmaZfLtWfPnnfeeefDDz+sq6vz+/00TQ8NDf3nP//54IMPKisraZqmaXpgYGDfvn16vX46
9yQ0TTudzi+++CIzMzMmJuaf//ynTqcbJa/D4Xj33XfT0tI0Gs1jjz3W399P03Rtbe15550XFxf3
8ssvg37j6NGjTz311JEjRya8ho2NjfPmzZPL5YsWLSovL6coKrQARVFbtmzJy8uTy+VXXnllV1cX
TdN6vf7RRx9NTk6+/vrru7u7aZqmKOovf/nLJ598MuHN4dFHH01ISIiLi3vkkUdGaT5N0xs2bIiO
jg425FWrVvl8PqD5WVlZoZr/3HPPTaHmQxBEUtTuw5UPv/5qTfMxcMTmcDz46itRC+amXXLR/zZ+
T5AETdNGq/W1/32WdunS9EuXvrP6S5fHM0rk3qGhx978V/yFi2ddvWLz3j0+v5+m6fLampwrludd
dcXnmzYCkbcc2P/Sxx/1/u6umKbpAf3Iw/96LfniJYlLFt/74gtWhz34LY7jb3/1xe1P/6Ott2fU
WRa7/f21a2ZcflnSxRf+/Z23+oeHaZqua2kpuf6a1KVLXvvsU1DPyob6Zz54P3hPxg9juDL8RvRr
1tA+HwRBA++/D4YyQdxut9lsdjgcofYbSZJOp9PtdoeW9Pv9FovFYDCceP1AIGCxWMxmMwjeGNpa
bDZb6C8SBGGz2Ua9FaYEHMetVmtPT09jY+OJ39rtdpPJNOptDSqP43hoSZ/Pd6rbEry3wXeM0+k0
GAwnyj7GRcao/6gHdKbdHAj1YTab7Xb7qAfn8XgMBoPdbg/qg8PhOLEYTdN+v99oNJ5qiKbT6axW
66ipAb/fH3opmqZJkjSbzWazedS9ZWAYQ4F/2nVg1Vfrbr/p6s3rPrNa7a/864PgV909/au/3WQy
W088kaLp4RHDp198/fma74IHP1+9rrgwf9eWtRs2bW1p7SQIoqW1Y0RvmF2cN1UCtre1zZ49e/v2
7du3b1+/fv3NN9+ck5Pz7rvvgiPffPNNbGzsHXfcEXqKxWL59NNPcRz/9ttvV65c+fjjjw8MDEAQ
9Nxzz73yyivPP//8unXrRkZGLBbLkSNHsrOzpzY0DkEQ//vf/44ePfr222//85//fP311xsaGkY9
YpPJVFJSsn79eiB1WVkZiqJtra1arXb7ce666y6apj/99NNjx46tWrVq3bp133zzzXvvvXf2ah4I
BO6//342m33o0KF///vf27Zvf//99+12+6effjo4OPj555+vWrVq8+bNqz7/fFSH5vf7q6urX3vt
taampuDBhx566Pnnn//Pf/6zdu1anU5ns9lqamoSExO1Wu0UNq6+vr6Ojo455523ePHitra27u7u
UEuJIIjOzs6hoaElS5bkz5rV2NjY398PQVB5efmcOXOuu+66xsZG8OrX6/VcLnfUDMt0g6Koqqqq
999//29/+9uHH364e/fuTZs2eb3eUHn37dv32WefPfPMM6tWraqtrd2wYYPf7//Xv/51/fXXNzY2
fvLJJx2dnV6vt6GhAcOwnJycia2hx+NZuXJlXl7ewYMH8/Pzn3jiiVFzAW1tbffee+/tt9++d+9e
Pp//wAMPBAKBqqoqn8+3fv16sVhcUVHh8/m6u7v37Nlz7bXXTmDdXC4XaH0fffTRqlWrDpSXj9J8
mqYtFkt2dva6detAm118wQVsNhto/rp169auXTswMAA0Pyoqaqo0n6bpAI4fbqh/66svW44bzxRF
vfzpx6293bv+++mL9z/w7trVe6qqCJL87qcdB2qq33jkb8/dc+//Nm6sbmoKbSB2l2vttq3tff2r
XnjxpksvffXTT9p6e2kIevSNfz39l3vWvPr6t9u3Der1NqeztqVZpQjX/O6IawRBvPLxfwd0w589
/8LXr79xuKnhpY//GxShsqF+0969zhOm8wiS3FFx8IvNm/9x593vP/mPutaWTXt3+wOBt778/K8r
r6n5et3/vt/QPTjo9fsb2tvYGGtGcsqZVuzPsimZYcLp/+gjFIIgCDJ/9ln/0qULFi4MfrV9+/bm
5ua0tLSFCxcGc8S5XK7t27eLRKILL7wwWLK7u3vfvn379+9fvXr1qOu3tLT8+OOPHA7npptuCg0/
MDQ09OOPP55//vkpKT+ru81m+/HHH1etWrVjxw4Wa1wqHQgEPB7PhOd8GxkZ2bFjh91u93q9M2fO
HPXtqlWrjEbjwoULi4qK2Gw2OGgwGL777rulS5fGxsYGS3Z2dpaXl+/Zs+frr78edZHt27e3tram
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
+veXFswrLSrInWTpwsPD33zzzddffx3sl7voootuuukmBEEcDofT6VQqlaGjOqvV+tJLL73++utz
58696qqr3n777VtuuUUqlT7yyCPBsanL5QIxWsLDw8HetnfeeYcgiIcffvisrkyOAZfLXbly5Ycf
fgiCGF133XUghl97e/ubb745a9ashISEG2+88bPPPltx1VV8Pv+6664rLS1ls9mvv/76q6++unLl
SjabvWjRoltuuSU8PPz+++9/77337rrrLgiCcnNzn3zyybMX2aWioqK1tdXv99fX14Mjs2bNuuGG
G/bv3z80NNTQ0AB+Oikpad26dSRJPvfcc2+88cYYhmsgEPjpp59mz54dERFBUVRJScnHH3/s9/vv
vffeCTR+xg+CIDExMWaz+cD+/RAEJSYmxsXFgWHA7t27Fy9enJ6eDtIs7dixg4Vh6WlpGo0m2KU3
NjZqtVqxWEzTtDo6uqqqqr29febMmVMiy/g6E1ZhYeFVV131yiuvkCS5aNGiJUuWgCHBM8888+ij
j6akpCxdunRgYODhhx8mSXL+/PmXX355cMzw3//+d968eSBJXmFh4WuvvbZnz54rr7xyAqekw8LC
3nnnneeff37NmjXx8fEPPvigWq2GIGjnzp29vb0xMTFZWVmPPPLIhx9++Prrr6elpT377LPBiZvK
ykoURTMzMzkcTk5OTllZ2UUXXZSamvrkk09OSN36+/v3798/MDDQ1tYWqvlCofC55557+eWXL7jg
gltuueWjjz66euVKHo+3dOnS+fPng2mOQCDw/fffz549OyoqCmj+Z5995vF47r333mmS+xdF0Ydu
uPHFjz+6/KEHRFzeVRdcuKComI1hl8ydb7LaHn3rTRaCLC0rK8qeAVZcX/zk4+f/eu+S88qWzZuv
N5n++sJzQr7g9suvTItPAA0kgAc2791TPGOGKjycoqii7Bmfb9ro9fvuumql+HeMqZq7Ohs72wf1
+vb+PvAUosLDf3znfeFxNeBwOBiG8Tgc8O0LH3/0xK23J2pjLp03z2K3PfbmGxRNleXlX7bg/GDQ
qc++X39eXr5GpaIhqDAr+4Ov1+w7cuTaiy9OOJPAnPCpfPkOHjw4gXusGc4ZdE89Nfzccyf9CouK
yh4chGB4z549+/bti46OvuKKK0KTy51IXV3dpk2b7Hb7G2+8Meqrjo6O9evXu1yue+65J3Q7IkVR
1dXVjY2NwZwoIyMjX3311aFDh9auXTuFq7in5fPPP29oaJg7d+7ChQvHHtgdOXJky5YtJ70te/bs
2bt3r1qtvvrqq8c288a4yJSwf//+tWvXZmRk/PWvfx2jGEVRdXV1X3zxRURExKOPPjpqpGi32++4
446cnJw77rgDJE4I8t577y1atAj4FNE0bTabX3/9daFQeMMNN4Tmgeju7lYoFNN2uPMn4a233rr/
/vv7+/vrayoWleVNn4rRNI3jhM/vpykKwzAejxs6G4LjBI7jbDYG+hmn04VhGJfLCaqu3x+AEZgb
0rr9fj9NQ6AMRVE+n58gSTYb47DZoVeuazMWFZecbelIkgRRghEEAfv8YRimKMrr9bJYLHZIlSiK
cjqdYFceSZI+vx8PBFAUBZvbQTEQGgBMukEQhOM48EMOLQParMFgSJqsWGigVoFAAMQgwDAMhmEc
x71eL3AmBNv5cBxHECRYANwEHMdBhDmwVzZ4KQiC2Gw2l/srZejv72exWGPEsTsjQLaY0PEYiqIg
1l2o3zWCIMDd1OFw8Hi84IIkjuOBQIDL5QZnhGma9vl8p306LpdrYGAgLS1tchoXcO6laRoERwDV
8Pl8GIaBlBsEQZAkCcMwi8UCMTWCAoKD4BED/9VRZXw+X2tr64kZ1Ke0M8F9Ph9N06C5gdeZ3W7n
crkcDoemaZC7FYKg0AIQBHm9XqDAwWZLUVRQXYM/UV1d/XvSK5Ak6fF4SJIEaXKB8vh8PjDvjKIo
aDjUz50hL1g9HMcJguAct1i8Xi/YtMzj8UKr19LSEhUV9Rtm5AmC8Hg8J2o+DMN2ux1svKcoyufz
gYYc7M3Go/mufd9bPv15ECssuUKQd8EkKANOEDiBszE2CCZM07TP7/fjOALDXA4HuNpSNB3AA/4A
DkMQh81mH3/WdpeLx+GwMYyiKH8gECBwBEa4HA7reAuiadoX8KMICq6DE4Q/EKBpmsfhhDZ2D0UN
EIEUNnf8dfb6/b96CjAsEgiCFwzgOEGSHDaGIigEQXaXk8vmcNhsiqZxHPcHAjQEcTCMHbKb3ev3
ITDCYbMhCCJI0u/3kzTNZbMxFit4WYKmu/obpZveBv+Kzl8hu/5voRVjDFeGM6NBo8EHB0/1bfLu
3aJ5887ST+/evXvTpk0URUVGRt54443R0dHM4/iT4/F4du3atWvXLhzHMzMzr7766rPtacwwIUxb
w3WqmBzDdUqYZMN10phYw3WqmEzD9Wwz3QzXSeB3Gq5nm99suJ5dnZ8Kw3U6cKaG61RxWsOVcRVm
OAPchw+faLXSIRG7zf/739kzXOfPnz9//nzmKTAE4fP5S5cuXbp0KXMrGBgYGBgYGBjObU5puE7J
9n2Gac6o9K2A0G2Flm++0b7/PiIQ/GluCQMDA8Pvhc06ZyP8Bz08zzFGxYD9gwKS0JwzmnbOyDJO
pvlAfZRj8zTEVbHOVbHuz6MwUgjS/0HqOQYnf504nc7w8PBgiicGBgiCIJo2r1lzmiI+39Dnn4uv
uYa5Wwxnplw4Dv/JxhwMEAThBOV0T4sUBVOLVMQ5V1+4YC/cuScdi8UCO+7+0FKQJMnj8c6Np0NR
lFgs/lMNXKVS6XSWl8fj4Tg+3WqIT4+kOAzj5YT5wZMbrhaLZWhoKJgJmoEBgiCiooI8RZKuUG9h
y6pVvvPPZ24Xw/ihR0bw3bvZzHzHnw9/gDTZfcx9sNh9JGo4J0ULBAI+n+/cC4fmdrthGP4Dpfs+
KTiOu93ucyM0AEmSdrsdROL5k2AymSYt//lvACTjnXbLwtJozvSqEMNYcJJmjjpycsM1JiZmcHDw
3IumwPB76H3pJc8pvgr1BSGqqmIFAuwPHrKCYTIZ/vpr+7ZtSU8/zdyKPxtCPhYXxUR4hmxO/7n6
wmWCM01nQHCmc+PpgOBMf6qBq91un87yTs/gTBCU5L71aUfldq/dKvgz7WsjSdLn801/kWmadrlc
IpEIZrG4mcW8maWjCjDBmRjGp0k4bv3223EqnemTT1T/+Adz0xjGifl///N3dQV6etgTlL6cgYGB
gYGBgeFEBOddQufON/X0xGdl/Xmkdrlc5j+CyARBDB49mnjqcNnnbEAIhonF/sMPlMsFPtOnK2xe
tYq5YwzjxFtf7+/qgiDI+N//MneDgYGBgYGBgYHhpDCGK8O4MH/1VfDzaYPE+bu6XOXlzE1jGJdq
HQ9VbV61CqLpP/fNYGBgYGBgYGBgODmM4cpweiin07Zx4xmdYvr0U+a+MZwemg7mWMJ1OseuXcwt
YWBgYGBgYGBgOBHGcP0FmqYtFsv+/fvdbjdzN0Kxrl8PEcQZnWJZuzboWszAcCpcFRX44GDwX8bJ
nIGBgYGB4f/bu5ffNq57gePnzIsjPkVKfIiyqIdtxMa1AzvXCNoaRQJ0kSwNZF8U/QfaP6H9A7Lo
okDbAEWBNAXcZtPVTRvARW9gFEmVay1uKzlypEiUZJmS+LBIcfiYmbuYG0aWKdmSIpscfj8LgyKH
1JzfOSb505zzOwC6ojjTE6Kx2PkLF9bW1l555RWi0dFYXo784AdSVaWmCVWVmiY1rTY721xe9g4Y
vnVLz2alqgpN6xzWevgwQGFqHKn4+9/v/7H04YeTv/qVMkiF/gAAAPA8SFy/IaVUpAwYRsW2icZ+
2Z/97Ok7v/rRj3a+TlxTP/lJ5M03CRSOx7aLt2/vv8O1rOLt26M//jGxAQAAwH5MFe6i3W47jkMc
gDNV+ctf7FLpwJ07v/sdkQEAAMABJK5PkFKqqlosFquszwTOWKcs037VTz7pTEEHAAAAPCSuB7mu
axiGpjGJ+hmkaRIEnPw/mmUdVqp6mxJNAAAAeBKJ6xNc13UcJxaLBYNBovGMoUPiilMo//nPh9Wd
3n7vPeIDAACA/UhcD3IcR0pJHI7FtSyCgGPZ+eCDwx5qbWxU//53QgQAAIAOEtdvuK5b29vLr60N
Dw8TjWNxSFxxHHap9Pijj444gNnCAAAA2I/E9Qm6pmXS6dHRUUIBnJ3Shx+6rdZRB/zxj1zGBwAA
QAeJ6zeklKZpjo+PG4ZBNICzs7+esNvtAKdWK/7pTwQKAAAAHhJXnHToUJwJJ9IuFHb3LWE9bEH5
DrOFAQAA8LVDE9eZmRmigyOwHQ5OZuf994XrPvOw3Tt3WhsbhAuDYCIV8mvTTNNMJpP+a1c8Ho/F
Yv3eikAgkMlk/NEjmqadO3fOv28SXeRyuV4+vUwmY/bqF8VAIJDNZgdqtPRLkxVFOXpgd9+t9N69
e3t7e0tLSwPVqTgWLZ/vjJ75+XnHj19NcBaM9957rpkervs/P/95+4c/JGI+tlOxZucLxEEI8dXm
XYIAnNL9+/cHqr2Li4t0OnwmEAikUqnDHu2euF6/fv3u3bs3b94kfDjMxscfP/z69ivT0wlGC55D
48sv//e5v1gEP/746q9/TdD8Z3Z21rsxEjNvXE4RkHv3t77z3e/5smmVSqVQKFy8eNFn7VpdXdU0
rd8v2lSr1Xw+f/nyZR/0iGVZCwsL165dG4i3DCGEELOzszdu3OjZ05ufn89ms705MaFarS4vL1+9
enVwRku/NLndbs/NzR1xAGtc8S2gACye08777z//wc3l5do//kHQAAAAQOIK4MUpfvDBsY7f/u1v
CRoAAABIXAG8IHuff9548OBYTynevs31fAAAAGiEACfDdjg4ruIf/iBUVaqq1DShqlLTpKo6e3vO
3p4QwhXCyGbVWGz/o0LTav/8Z/j73yd6AAAAg6z/Etdyuby7u5tMJnu2yvaAIHHFcZ17991z7757
4M78T39a+MUvhBBSiNwvfzl86xaBAgAAwAH9N1VY07RKpVIul+m83uEwmRMnxV9AAAAA8Ez9l7iG
w2HTNG3bpvN6B6sQcWKSxBUAAADPQnEmAAAAAEBP68vEVUq5s7NTq9XoP8BPmHMOAACArvr1imu7
3XZdl/57iZjhiW8dc84BAADQVV8mrq7rptPpcDhM/73MoUPiCgAAAOCFYI0rgJeJv4AAAADgmfov
cW02m61WS0pJ5/UOlibixEhcAQAA8Ez9l7iWy2VFUaLRKJ3XO0hcAQAAAJwdre/OOJVKpVIpeg7w
H/4CAgAAgK5Y44oToqowvnVUFQYAAEBXh15xHR0dJTo4gjExEXnzTe92YHqagADAycQjAb82Tdf1
SCTiv3YFg0FVVfu9FZqm+Wbhlaqqw8PDvn2P6CaRSPTy6UWjUV3Xe3bkD9po6ZcmSymPHtjdE9eV
lZVGo7G4uDhQnYrjSaXkb37j3SwKUWS04ESaW1ud21tbWxUG0iCp7rWWNx4Th0bT9usHruM47XZ7
d3fXZ+1qt9tCiO3tbR/0zt7eng96xHXdZrM5UF9cLcvq5fY2m81qtaoovTi103GcVqtlDdIkr35p
suu6juMccUD3xDWRSKytrU1OTg5OjwJ4KSqjo5330UgkEmMF+yAJGOpojEUHYjFfmTrvz5Ffq9VK
pZL/KlMUCgVFUfp9blq9Xi8UCv7onWazubq6OjExMRjvGUIIcf/+/Vwu17Ont7KyEo/HQ6FQb478
zc3NgRot/dJk27aXlpaOOKB74upN7InFYoPTowBeinY83rnkapombzsDRdeUSMggDlL6+QO3Vqv5
r3WVSkXTtH5vl6qqpVLJH71jWZaqqgP1CaIoSi+3V9f1UCjUm2eoquqgjZZ+abI3meWoYT84fQYA
AAAA6EckrgB6BdvhAAAAoCsSVwC9gsQVAAAAXWn+bl6r1XJdV9d1KeXZ/ZZ6va5pmqZpR/yWdrtd
r9dd1xVCGIZhfr0JaqPRcF03EAic6RkCAAAAQP/yeeJaKBRarVYulzu7tNC27fn5+Ww2m0qljvgt
lUplZWXFS6SHhoauXLnibQG3+ehRrVo9f/58IODbffyAI0iTorIAAAB4hn5KXF3X3dvbe/z4sWma
3oZdqqomEglVVRuNRqVS8Q4LBAKRSERRlHq9XiwWm82maZpSyqGhoWg02mq1yuWypmnxeNx7tWAw
GA6HFUXxftR1XVXVer1uGEYkEmm1Wo8fPxZCKIriOE40Gj1Q2rtYLDqOMzQ0pChKrVbb2toyDENR
VEWRtm0bhuFtwRwIBF599VUvWb1z545lWd7rxIeHizs7jx49OlDT3LbtYrFYq9UymYzJN3v4l8Lw
BgAAwLP0WeJqWdbigwetViuZTKqKYhjG8PCwEGJlZcVxHCml969t24lEwrKsarXaaDSKxWIn7bRt
e319XQgRj8cbjcZXX63E48Pnz59XFMWyrPX19Y2NjampKSFlcChomqZlWZ999lkqlY7ForbjrK+v
37hxY/9Z5fP5WCzmZaGWZf33J59cvXLFdUWpVEwmk67rZjKZdDodDoeFEBsbG48ePTJNU9d17+mR
SERKWS6Xx8fHvbTWY9v2F198sbS09NZbb5G4AgAAABhk/ZS4KooyMjIylslsbm7mJiZisZg3NXdr
a+vLpaWLFy4IIaSUpVJJShmPx+Px+Pj4eKvVmpqa6uSEpmmOjY3t7OwIIeLx+Ph41rZt76F4PO66
7sbGRjabTSQS3ouHQqFIJHLhwvnR0VEp5X999NH+U3Icp16vJxIJTdOEECMjI8PDw1evXq1Wq//6
196VK1dWV1fr9XrneG+lq2F8s2+hdynYS7CDwWDnflVVZ2ZmRkZGvD11gUHgUpwJAAAA3fTfGldN
09LptHeh1VOr1UzT9FJHIUQymTzxBruqqqZSqZGRkf13hkKhTvEkbd9FUSGEV2xp/9JW/esqTYFA
QFEOFm3O5XLZbPbBgwfr6+vT09P//xRdd123kz97pJTRWCwWi3G5FYODqsIAAADoqv+2w5FSHqiB
NDo6allWKpWampqanJxMp9OdJFbTtHa77d32lsV2nuW6ruu6lUpl/51CiKezzaPCpyhCCMdxjj7M
tu1qteqlpt4peRmvx1us25k87KnX6x//9a///vc8YxQAAADAgOunK66NRiOfzz948MC27VKpFIvF
pqenDcMIhUKXL12am5vzckJN16cmJ72nJBKJtbW1zz//XErpuu7U1FQqlQqFQpubm59++qkQslar
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
AABJRU5ErkJggg==

--lWGWlWdjNDUCCWce--
