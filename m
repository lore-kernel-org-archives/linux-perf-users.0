Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F413B1BD;
	Wed, 24 Dec 2025 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766555147; cv=fail; b=aNZDeTIg9s1vDmjKqptfreQa8DHQC7mZ/rHEl90yVKU3fZgTejKNgfRKwIc0ow3MD5Fjmtv+0Kav8zE3Oh+9F+8GJI55wV8Ug6CTs0ylgmFG8s36rr5cYZzCN4sSH6PFzJajAdVKF+RAYqrTeQdNd7onTpkecxvm7nXiU7nPKBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766555147; c=relaxed/simple;
	bh=nMMuCA4knJAwrZvwWFnSH78TpFFuqVOwfkrmmnKWf+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nt/+YaVX55MQzYWLtzSP4neXDlY2cEh+bFaF4C7TGcub/PD5i4UI6/JG2b9Sp/cuWcdnediCdlOHw3fdfebQnWlqk4qioG2E+WFHuIWY9blgfXS3L7AadHJjDIykCk5xEyvjNmLq+lo2TTwK25oI1sf6QNWX2AomCpqCwmkS3zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P9GWDQrz; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P9GWDQrz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa/4aE3OQYzxtCT8F9aMyMHr6XXMapvUcUZ9ibdP1UYmsfiEH3kjIwAulAgabl1AhsElFVwVaE4b47O7GSgnRm1NFBPyZTWco3EqrvMqSEsTsJYDCkWOpckYRplPfqkZqldhAM7YY2kMibc1im6k3iQPDWcxk9lnslA6VHtQ42M6T1arLufE5hiF/Qpm3+FRwiRSnWcTB9mFouEaKdEjGDXHacYztlH7Tf+xuk+/e+XSeTNyDAigJZxKMv+IbrjrPsoG55HZZD2vCk5RcO8Pd3fyykv2eNg3EoN+Cr/M/tTLAEe6YUk1zjq+7mAYUPXQBheOoiFhjBtev23jvPkc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TesKnCBxWPzWdK9VJqYMzjWSEdc+8F/zrhrrXlklr8=;
 b=p8jsIKtjeQ5Tl6bpCGMT+VeZtjLHU8o91EHMMeMwcwzfvI+U2JoEzKKYKyuoRf9IgGTie3XGd4jRZRiz1/pc4f0hBhHwX7em9JOi3mzhYO5ahmKDZuKmpAoKxauPJx4eHjffSsqTF9sg1fdV4UEoA/hNRNo+Jhopz4DnjyBZDM9BOSteYWmcKMXyho1HefdGFUVviC7wBxBEK6swtsg2aR94oK1qxIQlmJ9amumS1ld+3FPAl/GQHfYLugDngf/PHzjSrqLvaKRGXqQYwErJ1a6Ee+KgH06J2jmRe+/nuCRq6on1LfRS9PZsUvYV+8EuUvXmgF0ngxlO8HJ1WSiO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TesKnCBxWPzWdK9VJqYMzjWSEdc+8F/zrhrrXlklr8=;
 b=P9GWDQrzJwdsz/XAbR4VLC0M3DPvHncYS6w4ugm9TCZUhdEC6d8ca5/u/Nho7dxB6oJcGINZIkGn0F2xztD5fWoz5unwK/S0TlmZW1tUssfZ1zmYGgzmrazYO7uEZvNget80RGokLaP3OTZ+gjQ6UZHtXa5bRQMWtIWmYiH86nM=
Received: from BYAPR06CA0011.namprd06.prod.outlook.com (2603:10b6:a03:d4::24)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 05:45:42 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::c) by BYAPR06CA0011.outlook.office365.com
 (2603:10b6:a03:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Wed,
 24 Dec 2025 05:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Wed, 24 Dec 2025 05:45:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Dec
 2025 23:45:41 -0600
Received: from [10.85.35.110] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Dec 2025 23:45:36 -0600
Message-ID: <3e56e2f1-42bd-45e6-90a7-4105386d63ed@amd.com>
Date: Wed, 24 Dec 2025 11:15:30 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 13/19] perf/x86: Enable SSP sampling using
 sample_regs_* fields
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Zide Chen <zide.chen@intel.com>, "Falcon
 Thomas" <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, "Xudong
 Hao" <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fda748-1c67-4474-5837-08de42afacf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVZOdURVb21JSVhmTHdvaTVaUURTRlY1bDFxMWxPTzJyekk3cW9VWUVXSE5C?=
 =?utf-8?B?bXdjbEEvVkZJbEJKK0t0SXBDYUt1Z2h0dVplNTQ3Uk80dTJ5Z2JPZVhYaEdp?=
 =?utf-8?B?OExZekdCQXZMRmhoZFBOQjY4TytwK2Eybm9IdjBSNm9BbGhMdWJjb3NpMjl0?=
 =?utf-8?B?TWdQR21icmRKRFRJRHk3K2tsZHNPTFlnTVZneVUvUjNyazNDOGZGZjUwRlM5?=
 =?utf-8?B?QUdTZ21OdmFWK1BhbERkNlZoZlBwNkl4WldKWkIzKzhVeUxXZy9ibzM3WlBO?=
 =?utf-8?B?MDlJeHA1VUFhUU9zZUo5TTZuOFNYblJIQVN1Z1lSUVBjUXlRNnJ5QjNvakNY?=
 =?utf-8?B?L1k5M0VIeStZajljM25JV0hkQ3piMjQ5U1BScHJKK2JhSlI3d2pEQ1BvVWRB?=
 =?utf-8?B?aWloNXBodXo0a2Z6UmxCaHJ5ZXh6eTlyUEZMU2JaYUZEWk5qMnFwUDhmWVpD?=
 =?utf-8?B?TXVDcElzREtiRGt1K0FVbngybVh4OHpJcm9TbUxJajJZa3NDSHNVeG1kMHln?=
 =?utf-8?B?RGtyVFhJNVRsRkhkZVJjcmN1Z05LWThJK0ErQkg5L29tektiWWFFQzhqNDMw?=
 =?utf-8?B?OEIxK0NWazA2VXFGZzBhMFIybWRObDdnK29tdU9BWVlEaUpLR1lsdExaTVE4?=
 =?utf-8?B?amFEZUN5VWE0bmZUZ2l4bW5kZnlaS3c4eVg0TmV3endFQ1N5dzZ5N0w5WlJ0?=
 =?utf-8?B?OHB5SmNMUExHMzNVNEtiZGNjR0xHWmZoZVM4ME1oSTQwK081NmJ2TENMVld2?=
 =?utf-8?B?V292aEhmSVVrbjJLT2dWWUN1ZWJtTExOKzF1SEZzeDltbjlqN3RFK0lIMU5l?=
 =?utf-8?B?bjA5RzFtaC9OM0RNWW1pOTdLNEdSWnJFZ2szMkJ5bmxrVzd2c2hTaG1VTGFT?=
 =?utf-8?B?UmhGOGwyWTRzQVpMTHFwTkl4ZWpkK2Z2R2cvUjZibTJ0c2NRSlVBMjROUnNT?=
 =?utf-8?B?UnB6Y0VCWU44TGNxTWNWeHdoUzJNeTlvVlNyVmthOTVOeGhWdFJheWs2WnZy?=
 =?utf-8?B?UmI1TW5FeERZa0cxdEljRWgweWc2MlFIUEFFUDhTNnNnYmhDTnF3NW1BdnRP?=
 =?utf-8?B?N3hoS2hCTXhMc1FrcWVkcHVjOTFIL3YzN2dHMjFQeHAwVkcxQ2orYi9NR2xW?=
 =?utf-8?B?UUd2TnpyQ1U4aVRCNDNGZVVNMkoyUFAxdE9WSzFua1JUa0pjZ1RqQ2RhbjAr?=
 =?utf-8?B?cUZLdVBsWmYxdzBHM0ZGQWJKelJHcThQdlFOTkhPVFg2djZUWWN6aTExdmNJ?=
 =?utf-8?B?aFlKWnBzOGpsRnc5TE84WDdMaVVrcTMwY2dPOXhGcWdVODdncldsa0g4dm5q?=
 =?utf-8?B?UHJsUnkyMlhVdnMvOElIT00xSERVRTYzMFQzUmo5YkdHV05BeHBnRm1EYm9t?=
 =?utf-8?B?bDNkS3pTRmtueWl0QlkzZUZmaXFvMHFaelVjbCszUHVqamhaRDZFY3QxTWRi?=
 =?utf-8?B?Wkh4bW9Hb1FwaGNaWXFjTGlwZndFVktQZVB0K3krTkpDY0llRXAzdkRmUnpU?=
 =?utf-8?B?RXd1YlFmTkdJbDFRWkFLeHNuZ2xLNXNFY1dTYXBVTmhqNW9PS1BsUDNNZExX?=
 =?utf-8?B?OVp1NmlsWUJOTzVNNXQ0OFJZbEdHeWpNZHNZeUxhNDdPdmI4TzJSdGRJVE55?=
 =?utf-8?B?QUJTZlJqK2lOdVMybTZkUml3c3ZWWGFnUHJiMGo4SGhYcytJNWIzb2VUb29o?=
 =?utf-8?B?bFdxZE5uQ3BqVmQ4M09BZThrQmpIeEdPMTN6cjAxdmlPNkxMOSsvdURBRmNQ?=
 =?utf-8?B?MDYvbkh5MkZUY3FGT1ZXeUZCb0lzcjMvaDlhc2Vzc3BoSmc5eWVUampEbHdY?=
 =?utf-8?B?SEUwc2taeFNacERBVzc1Sk9ycHcxVnZYaDlBZVJMWm5OL054eWY5bGxqWkVT?=
 =?utf-8?B?V29BRHAwdWxvSVRza0VULzVoUWxmMFc0WWNZRHlUQVo4WXFiK3VicVRiOUdC?=
 =?utf-8?B?YTNJWnNmSlVsRHNzYk5EQkVybmM3TXpqQnpDMndZejBRaTBjdG5JU3lBVlE5?=
 =?utf-8?B?QlJrL1pyNTUrR3YyaHFRVHoxQVZXdWc1N1Q2TXhEcFpkK2pHVXlyWjdGcVdF?=
 =?utf-8?B?MS9vWUcwcDFnVTRQY2JqRGdXdHluSENwVXBRTGcvZjhvYnptM1lZUXV6Nmxj?=
 =?utf-8?Q?yUmc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 05:45:42.0129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fda748-1c67-4474-5837-08de42afacf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575

Hi Dapeng,

> This patch enables sampling of CET SSP register via the sample_regs_*
> fields.
> 
> To sample SSP, the sample_simd_regs_enabled field must be set. This
> allows the spare space (reclaimed from the original XMM space) in the
> sample_regs_* fields to be used for representing SSP.
> 
> Similar with eGPRs sampling, the perf_reg_value() function needs to
> check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then
> determine whether to output SSP or legacy XMM registers to userspace.

1. The userspace SSP is saved in REGS_INTR even though interrupt regs
   are of kernel context. Would it be better to pass 0 instead (see the
   _untested_ patch below).

--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -71,7 +71,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
 			}
 			if (idx == PERF_REG_X86_SSP) {
-				if (!perf_regs->cet)
+				if (!perf_regs->cet || !user_mode(regs))
 					return 0;
 				return perf_regs->cet->user_ssp;
 			}

2. Could a simple "--user-regs=ssp / --intr-regs=ssp" (without SIMD/eGPR
   regs) fallback to an RDMSR instead of XSAVE? Possibly as a future
   enhancement if the current patches are already upstream ready.

Thanks,
Ravi
