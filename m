Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793078859;
	b=YaqTrXS6Lu384en+w0L3U6wW5pn0w31f42I5VtvUOt70o5ZoPuBYtvvIJ7MiCOU3SK4u
	 vxKvgcQPypd6y8qmbNMwAteF2YuspkhgX6dmjQl1XArIiKRBDAGOGuMW4i8H2R4f11BWQ
	 YYCoDsHakFJWlfi/e6IrZH4xoRkTH4w7BgYsBQVQAQf3j9aj792ShQghbEUn/gh/f92Eo
	 EjQg8EpfWkbm7YJyPSac3BtoMkSNpZQdT2LKCOVGcBdh+qXQvpS4qIK8K4VtDG1vlQsHl
	 uCLkOUsCAy6Wqrc+1Fw1qvehZpmrkWiHaAUvZttdAY+EsmAWDEm1L/LQh65L3oB8RGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078859;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Tf2PWZY1fKwgg5B7a9yjZqdkktnSO5wV2PBaYvFNA9A=;
	b=Spd9OfsN0NeC4U1AjHWAK6u6dz5H0zAg5FBaIb5SsdvoVBJzqmq2fgnoAEQPlgMFAQ6a
	 E1glaARm+xFS8tlc89hN9Z/Hv0CPy2ie2LJ2RPgCJwUv6gTlGqDKPKDbbgxkgLa2QHQkU
	 aDfCgJe21P+0e/LzLxMRu2AfoOz/jw0G/01uc8ZlXfbU2v5RGkjN/HlQvThkGDPsh+VXE
	 3WOTbOBYWvcfyigrZ9PbrK0HIoNJBWEnZlp6nQjnepX229SFW/Eoys0Dh9Qs5oqVt6OK6
	 Ck/xL3+v+slPHTKlqyE4pbsFOdkGMgYhqdUSiZjRscelzUI8F+gUu41SPT62p+6mnWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mhun5C5p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.13
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACA606A31A;
	Tue, 27 Oct 2026 05:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90ACA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mhun5C5p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSvyM0mJXk90RMr5x/O4O+hWFPvtOkgteQUfH/qqGvCESqVBUoU77ZLMmcSLHLeKa5klWkdOAYjk+QQq0//+hRwzdbfPlqDuGe+J/tuKnYsoDtV4V51fPCW34lOvgc5jdlrPNSBhpSkPibgM6CVbIsHscC0MVqr8i7y+yQwcTAwrnVv3Xqge/wiLAJyrFxNyo2IcEAzcS5qckb05jDr35wCrHYSR+Y93auc8sJmUaiMY1r8NqKpvdsYhHylLWBxJcRGMH4zoLTLn3+MGi2yJ3MEdQIkfs0bV3dhlOZnAb6dxHQyItJ0KJr/FUk/wKpNFA37V8F8Ix2Rhh20EygHOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf2PWZY1fKwgg5B7a9yjZqdkktnSO5wV2PBaYvFNA9A=;
 b=oCz9hkPWtV24/VfdL2KfC3nyoiV/weFSrgPXNE4b9voNwC3DFCYNEtxrWkxbFjVPoHzFpvKv9XGqNbeptu3M8dQ+5+ConTmtgCN2InELaZPCCO6D8AppK/koB8mcClg1cpI+IjlvXa+fNowDzshrUr1G1AI3OemTs0dNBhA9N3K9fstr/vYbKbfwVYKhWj2YB/fuXplbKM7OIYRdPok8fA4FLqaZt/nH9r9rCZhdVriYQJDSPvsWKCQn0xNVbXGl/i81wYnySXJ6ijCZwLHvekm8YRGT9JSDBTPFXe91FsZ45RNsWblkyC++JJjhqCGBFkBkNc8HbkfnylvfRSe07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf2PWZY1fKwgg5B7a9yjZqdkktnSO5wV2PBaYvFNA9A=;
 b=mhun5C5pHV89iQdnxX7yXQn3w6hzq8zGs6p1uigmFsmbJeah+GoD7l1yG252DA6gH9XF0WtBdYSrrJPOC+NANeXOPmdwWNs0VcBqLtb5HMCdprqmi+ONFSwE6PziShp4VT61YOa8FOS5Q/8mMsZKtFUdtDt1QfqvqMvVR9/YBC8=
Received: from DS0PR17CA0016.namprd17.prod.outlook.com (2603:10b6:8:191::7) by
 PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 05:23:30 +0000
Received: from CY7PEPF000000ED.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::2d) by DS0PR17CA0016.outlook.office365.com
 (2603:10b6:8:191::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 27 Oct 2026 05:23:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY7PEPF000000ED.mail.protection.outlook.com (10.167.247.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 05:23:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 00:23:28 -0500
Received: from [10.136.37.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 00:23:23 -0500
Message-ID: <ded8ef5a-8919-4063-815e-27fc38e4c204@amd.com>
Date: Tue, 27 Oct 2026 10:53:22 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf/amd/ibs: [BUG?] ibs_op sampling silently stops on Zen3:
 MSR_AMD64_IBSOPCTL latched, no NMI delivered
To: Liew Rui Yan <aethernet65535@gmail.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Manali Shukla
	<manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261019212028.119312-1-aethernet65535@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261019212028.119312-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000ED:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 76aad62b-c112-49c4-2fe4-08df33ea6f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|261022105027099003|261021121427099003|261022075727099003|3023799007|10067099003|56012099006|22082099003|18002099003|13003099007|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	OH0ij9HPFKsF0eK2lQuwSfiqQ/oPAfYy3JRdCeUF6CxNwUAi2O0XWJR6aBSA3sCCBjUnvsO5oG/BVU1hqOMyRrHJEGV5fs6AjkLz8JnuzIbKXJm2amAUb3qVwRJsIjipIW5Hc89wfSq0e8bl3tdNiHQ5UazDL7k47MuvSJGzMS+hBTIlfs3UcuU6bj4V6Z67hQc4LSd6a3C1dnl+rjENw7arikIrTT30Y6RQvhCpzjmH89ArVYPOotNV7/6bzwg4qidBVoR5p6hDx+JUzcjnFLMVotpNOmJp8ARfzCCXhvbYtk3HPjGS7r1AtMGWK6Rb8Nfw9oVRkulcB8Hv9U53z32Qol0hG1w55iNJ2XIDfT5CLsXmLHX04ZTnqv6YF9aG2zrmFJXwoRcpP6545mMlhMc6VTAHk1757FJDLE1LzqRczD7qAj6EHd/jjcO63dp/QCNKGlKpxbjtOjkiShC43ne2ri/E0msIGVHIKQS88d76lxv79OLsC1yz/3V8Ro2rWYXxdkqBOmqxK9KX3LYAQsDyytwphyab3xWxq/mQBDJgSMpO2Aow3TLGXVEM2wkCcZlDB5M2QP7bzGFTv45BDx3Jh2bOEwVwIJSx8y4kJaHTjZ5LVkyZjgo/IvK3I1Ph4dNYSU6xC2ZZHf/9ZNFWPWHJ714XPXZWM33bUB8K7OE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(261022105027099003)(261021121427099003)(261022075727099003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(13003099007)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xhr+VhoT710W9a6zFAymbjs+ClVI1GC+OPyyhKLjZpx519xJCOaFilZctDk30jH3D1Q5UWzszzQHZFBqg0SMhbtDur5oe8fIcfFsJ8sWEr4Ry++Bg9RRXY/RBtrVjr32HBzs5Mw6ns34hdXSMXxRnBW4xe7dXasH3d9DSzQYZ4/jV27Fp4bFQrBp2UWMW0+Wbp9u9z0gPq4hAj312eWS2lm7pkIHkaVn7Hierz53DAGCoGXqZZYaw2+Z1jlNbDxnWKf76/uFylwVeSjvVDK3keqccHn6FPDtwuxgpAzuYcLSPXZGL26erfNBid9s0hj0Ye2O2K80MZwB+/kGOyKP0gdBLwlv8lE2Li+Ta+90SqUZ/J07hq8vG4iSHeGO5GMCHVXYVK7BpUZLgXj9IbSQKe2MX0LfTfPpQhYluHAcvP+gwFHrDZx1Wg4cUHYgLOqX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 05:23:29.4783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aad62b-c112-49c4-2fe4-08df33ea6f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000ED.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

> I found an issue with ibs_op sampling that I can reproduce on my AMD
> Zen3 laptop.  Under full CPU load, sampling PMIs stop arriving on each
> CPU, one after another.  Reading MSR_AMD64_IBSOPCTL (0xc0011033) while
> perf is still running shows the hardware has latched a completed sample
> (IBS_OP_ENABLE=1, IBS_OP_VAL=1, IBS_OP_CUR_CNT frozen) and is waiting
> for an NMI that never arrives.  The CPU never recovers on its own.
> 
> I am really not very familiar with CPU, so I would appreciate any
> guidance on whether this is known and what to test next.

This is a known Zen3 hardware bug. The workaround involves opening a
PMC event alongside the IBS event so that the IBS sample is acknowledged
during the PMC NMI, thereby resuming the stalled IBS instance.

More details in The Revision guide:

  https://bugzilla.kernel.org/attachment.cgi?id=311307
  Erratum 1285 Processor May Fail to Report IBS (Instruction Based
               Sampling) Performance Sample

Thanks,
Ravi
