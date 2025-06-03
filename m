Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96B4A1E;
	Tue,  3 Jun 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932823; cv=fail; b=K7qs38CVwdfaDgU+Vg81auB3ocB02D8EdYhvYC+OQGthsJf2e3xSnAKzy+PgIqS0k8UW0AQGqWVMfGzvwOOfSaZPQFX0UAI81Ov5mnl+4y0zBQv9g/JXddPSduSu96Oq+UinY57oTR/DTk+0d9aKK1XIyWRjwwtJweZU81XIWAI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932823; c=relaxed/simple;
	bh=tLibMmG0qRBB4f9lh+R1qGRsWyFY/DhSJZSBWlOy4Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mgy2tn6N4xxJqLrb8nivq5r1w21r2m4pnqP56ZZyNxuACrAAn8TvxHwGCUXl76Sp+cYfmXjvY2GVyQUBQv+fJRiHyTkmzNhUvFBRII/rYjt0uL3pMnqPeZwhqQgeYY5NqVmTa7QssMy383JgrOKc26hM3COAycR/scKQEKyBAgw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FmhXU3UA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FmhXU3UA; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FmhXU3UA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FmhXU3UA"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yGNs0+URQ4+ThO+vIKicmGtd9gQLrJepJs7fNlmMmMyL1b6uV7vGE07FYcxMDzdjgfCJYDrQEg2t6MGDNBJYfW72LXIRnSGqr7TUX1nv0pL6a6DTANyxytGFNZ2o1jIGf5yTrnB0e5rKAXt1VV+m4UVkryf8dvNXdhqVkt6KG4rtBJ9PDYWqpcI9LAl7r2B9HeuqbDZ1vZ2nSSlIqinwJl0dERLPpioMmWSPIsqQefbLskMR+ECrQFF9F1+uY6QlI04ielyIFikXKCx2IS2NkAzBBaEv1iAxP3GFOHbljnb8P/uL2z3bJ/95AqUMM5ubDfqiklJfdg362rymyAUvlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvf8S9FbVKiQfyEnYsijns0dZlrBgJtSJPHY4z3uQxc=;
 b=BE0XTg2ByvJZZw383X91J+BIFUrXVwFuXTV25coti3P7rVxfU6v5rx7Pzb7N/UAOjzY/7YdmWzmRpOQjm2WQycW9yJTx7RokbzyK9V2vl6Lg6YATNO2DX7mmrGbdvsKKZQyBBg/aPkLVnDlHEe1QY6MrsdwyVOIlZ1URtrEmvwOud+DFyePgKlGsxgMEdYQeeohivVU6JfEJFuhOXfjCrPfmAs+wgrl7CEJDozkAD8cfVLtaq5YLLJNV7kzNt/M9qAG1Lj/ESByZRzYEDIziZDFgBMU6XcNWgtCiKSn/W+PL1fwdltoJnAfNtj6pO7yqMmVnUpjtWtyoIlpdg/OudA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvf8S9FbVKiQfyEnYsijns0dZlrBgJtSJPHY4z3uQxc=;
 b=FmhXU3UAaJSwkgKSpqTOwZB9SBpXYvNFQi9xUG7iMuECeOEJU2e9I4b4FHqxxTxI1vJe8hWwLpkpsclaXu1GuoxgmIQLOipzNkwk69rTPN7XvSYBlCjiRvxDZhRMOfnez4c33+ABI9AeL2VQEwD10a1I2vtD0N54zIKGhlwU2S0=
Received: from DUZPR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::8) by AS8PR08MB9093.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 06:40:11 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::fe) by DUZPR01CA0143.outlook.office365.com
 (2603:10a6:10:4bd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 06:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via
 Frontend Transport; Tue, 3 Jun 2025 06:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7OMKTLPZB6l6aFkWhYxFXLF01Z4TkcSYPutmhYbMZn79w8Ql+7Rg0skv81J0YH+d6ibvm+E53ckMhT6xE1tGBwjjMVtisu//3zFeGtLw15S3sxdb8RVARl1wnIZFcbDtmDu3CC4Km6/aHVq1lFx9lphKHtLrBKxs0Gm7uP9n0jKq5mV99eXYQ5UiTFKKo5AYJxgTIPGcl+O5KYpfb07HII09w/1bmw3nk6+jUJJylFCCNJsb0dpdsbF5kuR+GJGP0Gm9TZTdPP0/0amNpBUVw0vu2nPwkm8z/alSVPn068VqVXHRaLA2ugLQeDV/GLnu1KwGfKeJ+xuCqMNhQyD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvf8S9FbVKiQfyEnYsijns0dZlrBgJtSJPHY4z3uQxc=;
 b=CAPtPZjx/ajdkO1N4TZ094MhuoYJyvkMlrFGQs9WLZ+Gt76rgQpaZ0Cm52qolkDH1cFs7tSfEHw1K+cqs8shBWtIVdZPDA7X2t+DlAuSfkoCxicq5JznjeSYXZkT0wIHG62prRbOntAYz8I2I2g/3QTA78lpJQznGhkEowC0jf6O1zHkwyPHcsGnMeKvcWTNYeYjB7TGUSOLQP7JFsS+FUTu33rY8Ne1MjM9mjZlLph9VL8kco1bYsRzZqhka8XCPHxJjrnZ5tW7MtRs56kUKQtVsFxCUbmeXURsekf5WZtmoyHhJgrLBJp/AkGUk32TFjkSJfSj3Y4ByChrMI3FYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvf8S9FbVKiQfyEnYsijns0dZlrBgJtSJPHY4z3uQxc=;
 b=FmhXU3UAaJSwkgKSpqTOwZB9SBpXYvNFQi9xUG7iMuECeOEJU2e9I4b4FHqxxTxI1vJe8hWwLpkpsclaXu1GuoxgmIQLOipzNkwk69rTPN7XvSYBlCjiRvxDZhRMOfnez4c33+ABI9AeL2VQEwD10a1I2vtD0N54zIKGhlwU2S0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM7PR08MB5478.eurprd08.prod.outlook.com
 (2603:10a6:20b:107::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 06:39:36 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 06:39:36 +0000
Date: Tue, 3 Jun 2025 07:39:33 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD6YpfGz3MUfedHC@e129823.arm.com>
References: <19514ed5.5692.19734522326.Coremail.00107082@163.com>
 <aD6Xk2rdBjnVy6DA@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD6Xk2rdBjnVy6DA@e129823.arm.com>
X-ClientProxiedBy: LO4P123CA0544.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM7PR08MB5478:EE_|DU2PEPF0001E9C6:EE_|AS8PR08MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 246e8023-5848-4f8e-26d0-08dda2697cb4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?GueiHntKxmp7wVjJSKoOy2LTlanirrdIkSBX6O5NFDNcPT0jd5NChxoodhBz?=
 =?us-ascii?Q?4GLd1Dav5f1bKTyIgAeyHCimnfDShAccBnC8VyP9uASamiD7wXuzonwTEZtP?=
 =?us-ascii?Q?lklJ+j7xSbLQYDjjLzz6L5qGCf/RKopYs80GXcJicPOh8Zo2zdE18E8GZOV8?=
 =?us-ascii?Q?hmSuH/uGfIO56xo+9n0jbfeTzPy3lAk+aQsNt9HYP1e98gfcbfCV5T4UVKl9?=
 =?us-ascii?Q?0ZqTuvjXNxUM9fF8hR9T/OjASob8XYSuqkVJpbj3NEzS5o+suSgEeW6jMu9Q?=
 =?us-ascii?Q?Qs3m9ZubdpGNPhqwkfs6yEFa4s9L8FTQkNPTpPP2gWueOg8+4HTG9RHW37F7?=
 =?us-ascii?Q?No99ilLh8SBu8cU7PuFgA88KDc7zxqk5GC67jfkVYFGFwZN6ZhKTdiotQsKL?=
 =?us-ascii?Q?nHkOAP9CMr3ZkCbHG5fnQAuHNJ6YuWV86FgTvVECyTXLj0SlAu5130lwdCN/?=
 =?us-ascii?Q?xYiLhFJ6WvWI4sIsxTXQKeD49Un1yQS8bKDvgVYaqgOzjUBVM2XPaMsDclo5?=
 =?us-ascii?Q?57SJ2y0xnaAdv9MX0Sy2NywjuvZRQtvge2BhIw58CI4qcB0JDKN9nfDdz/Rv?=
 =?us-ascii?Q?LsP/Zt3geDzyd4gBeYzEfl8CWPnA8oWGNcC5pvkUGQzHkxGa+BEPT4mRvIyn?=
 =?us-ascii?Q?585vrRV8E4rjAMxY8ecyXlEr1Wt9eNtrdGvdPdkoeHruB/lMoNYlYH0FZKOQ?=
 =?us-ascii?Q?p/kIq4XxQnWM8V2NVIRYnUeJxFjdaOL1CLYS9SMx4RpooaT9ekPy53gUtbph?=
 =?us-ascii?Q?G8Wc/l5d7VZQFXAlKOJO66BDeDzfzyLT3xxXkjcnVVhybxUl2S2nEnnhJkn9?=
 =?us-ascii?Q?qyMQtV/45cd+rra95o0BTn1tJFdwPz/+quyLOas7kTmay8YU995TflYrHGTM?=
 =?us-ascii?Q?vGDEj/PqQybmvsVyIFP1FeZltcH46AA2snt5t6J4QqUCCaND7fXGMgdN4+ru?=
 =?us-ascii?Q?fu+lFHp3GiHOq32OcTLB5rMX5CQzQxed/kjMw2A0ZdWHD8AcXfUieYTTn49s?=
 =?us-ascii?Q?uEq6yf3YTKcD1TIFnm5LSF0xmYOMNGuDBsBFwBeXSNOl8NY0E1xvAbR1GbE2?=
 =?us-ascii?Q?9mbZLlgk51EiPu2Ij4X7rCFA95d1yUmT/S5HL/NO+JkpIO7G+ToLeKwZ6Jt7?=
 =?us-ascii?Q?epAphd5J1Jnb3jptojGpLN87n8k5VjTbQbv8WSIeGVfAJrSKUi5zrbLQHjA+?=
 =?us-ascii?Q?HhtWOgqicHFWsp5zeoHIRQE41hoH+b6ZtjeFAcpPlaxAPbu/Hts5o4rl7POx?=
 =?us-ascii?Q?9hDNVWKk8xddR4MOvFjjcFJ4IxRcyxxJUwy28VhOY6AT3/95RR5v3QBjT4pl?=
 =?us-ascii?Q?D+HmuxJEbNL2as44L/SH6//gZlumic1G6bJsp4mlKbIXAi3SjD/1sYbPwaf5?=
 =?us-ascii?Q?daDPTtl4lf3FzGFtimFvifS+WY0laB9q7DgyNBQuNBKQQCna61h13LqbT4Ke?=
 =?us-ascii?Q?dL0zZ3m306r2oCQj0zIPWZQfkk70XpFDl/x47pTr1HY8eILb8XslUQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	13f59943-50d2-4edd-9de7-08dda2696856
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|7416014|82310400026|1800799024|14060799003|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kn96HB2r+oTQHnoq8ge8AiwFb5Lctzsl+scuSQw7GtVTtbf/6RQSWo8l2huL?=
 =?us-ascii?Q?4+58O0ymuj9ntDkWaSyIAivA3VhYfi9kVX9fF8RO70xi8GcXyXjL7rM61P6n?=
 =?us-ascii?Q?/nv23aCD+Uv7mtF+2dPs8tsq4YmCB4fCOf2XRua8Sg/Ruw6rjjF16ZvN9JOl?=
 =?us-ascii?Q?LCNN4ufa4wagda+fIDYoPa7bRWV9Sj7uP2tQ3yzf320o24OP7MQ4MUnPFmcc?=
 =?us-ascii?Q?RM+u7nKM8fOH+cHFb221/7wFaH7O9QCJh5+UWNLBOZJ8o19EIKEUVofyhxHP?=
 =?us-ascii?Q?xIExU3zPVJ7tg1bT4ie/K9BEmpqGqR6p2v1L4HSYP4m8W0yKSfEnR48e8aQq?=
 =?us-ascii?Q?lEyNTSMRb7jKn37RowVf5LqWtwYC6MkhztCNpJ1DuPFLest9/u98fsCaW5wW?=
 =?us-ascii?Q?PUzZ01XMFli7nLil2jNORtyDVSmku6/ZDAq02E4cSTUrY3wiIuSavVZVFtVF?=
 =?us-ascii?Q?6a+SOh3aOy3RVS1jtSx8A3RE9bhepJAiUQYgkSE59KVM4qUTk2I0M9HwQHAl?=
 =?us-ascii?Q?A7R0aZHg/JZwjt0YwIZMxEFdgmVPKoSDEzcT/F6Zyb+PBJ7D1tUu3gW3onSw?=
 =?us-ascii?Q?wgRIZxRHeMEfolo+EYZReO1vIBLSUTG0xWRueGpFgrMMh5mzzBNKi1u5QIcP?=
 =?us-ascii?Q?fpqwBXVmDzXB1E+eg/SzzmLj51F8H5H8bpB/mHMnicgPsCrTN9w+R333iUrc?=
 =?us-ascii?Q?QTDuWS4nMFhewlMu00T7w9qeo8NjEVM76cuprjNkucPGd1mUcPZNpjnwtSIb?=
 =?us-ascii?Q?Hk2GlHPjam745mLt3MGHTYUG5vPYBcwN2eEfSHDnaH/e81C2maE+g/b+Ytih?=
 =?us-ascii?Q?O+O4bCOHcWMl7Bl4P7aESYR+ctOw+QogzkK18aGOW45pIPlUz9IxaRiZdZeT?=
 =?us-ascii?Q?6cQg+9uerogSa3sjnBzIa9EWl8+9Rc9z15dPH4pdZFTwHseIItPx1lpRL6qj?=
 =?us-ascii?Q?lDifwkw38RtQIGAIO0hggC0qMZHLKSPT26vBj7Ie4LV4cEeYgR6KKGmN0Bot?=
 =?us-ascii?Q?x27gpKbZM91LK2iBhQgglo/p1it2ZhBGyzK2khYRcPXVq7TJTiQ2zrvrWDlw?=
 =?us-ascii?Q?t8SQp73l2ZjSEfadE13ED3sd1LgYwRlmr/wUo/8tnOwTeGc5miGf90+d8NWg?=
 =?us-ascii?Q?ZotbPGpVYMdTP0xskuPgPaIjik0dk1aWfHpzaYHC/YEuKrwSdY0HQJjObHBf?=
 =?us-ascii?Q?gKETguxLO+He5MeXo5pqoDuxywnUc0GjFpCIpZPqDREJudjryR2l+Jawrd3F?=
 =?us-ascii?Q?GGcLfTG2VzBZ0FkIUASdtkj3oI/0/mYHYAl4I0h/zGxZMDTsg2C9aKafCBSr?=
 =?us-ascii?Q?5pemqof9aApKajk1V6/nEWRITElO1A79NIjTYrBq1/FjxwQevDzxjwElueYI?=
 =?us-ascii?Q?l7FyyznOgBbvFpcE7l+7NTIdCPKEr7nTZGGzr1HJ1gJvw8P7RoT2QSXpX7Gk?=
 =?us-ascii?Q?jkDrn/ALSjm7zj7Nlfhj/7kWEWCfpnXf9OKkROJJojdjxaluVcWnOe3hUTda?=
 =?us-ascii?Q?19MdzOd3B/f4PNc09R7qmsx/uRf28E1fFiOoMUTlKYtabZTKeWByxO98w8qo?=
 =?us-ascii?Q?fsFNg3IeRdEnOZHV6w0=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(7416014)(82310400026)(1800799024)(14060799003)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 06:40:10.2865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246e8023-5848-4f8e-26d0-08dda2697cb4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9093

> > > attach_state doesn't related for event->state change.
> > > if one event already cleared PERF_ATTACH_CONTEXT, that event is called
> > > via list_del_event()
> >
> > Maybe this concern could be clarified, what about other subtle impacts.
> > The change should be thorough reviewed, if you want to push it further.
> >
> > It takes me more than a month to figure out a procedure to reproduce the kernel panic bug,
> > It is  just very hard to capture a bug happens in rare situation.
> >
> > And your patch has a global impact, it changes behavior unnecessarily.
>
> TBH, this patch just change of time of "event->state" while doing,
> As my bad miss the disable cgorup perf.
> I think there seems no other side effect for chaning state while in
> removing event.
> But, Let's wait for other people's review.
>
> > >
> > > Also, your patch couldn't solve a problem describe in
> > > commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> > > for INCATIVE event's total_enable_time.
> >
> > I do not think so.
> > Correct me if I am making silly  mistakes,
> > The patch, https://lore.kernel.org/lkml/20250603032651.3988-1-00107082@163.com/
> > calls perf_event_set_state() based on DETACH_EXIT flag, which cover the INACTIVE state, right?
> > If DETACH_EXIT is not used for this purpose? Then why should it exist at the first place?
> > I think I does not revert the purpose of commit a3c3c6667.....But I could be wrong
> > Would you show a call path where DETACH_EXIT is not set, but the changes in commit a3c3c6667 is still needed?
>
> Sorry for my bad explaination without detail.
> Think about cpu specific event and closed by task.
> If there is specific child cpu event specified in cpu 0.
>   1. cpu 0 -> active
>   2. scheulded to cpu1 -> inactive
>   3. close the cpu event from parent -> inactive close
>
> Can be failed to count total_enable_time.
>
> Thanks.

And also, considering the your patch, for DETACH_EXIT case,
If it changes the state before list_del_event() that wouldn't disable
related to the cgroup. So it would make cpuctx->cgrp pointer could be dangled
as patch describe...

> --
> Sincerely,
> Yeoreum Yun

--
Sincerely,
Yeoreum Yun
