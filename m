Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417447D924;
	Tue, 13 Oct 2026 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864199; cv=fail; b=RfcGvHF0MOp9Cw8hrxx1MfgtrO9CMJ4I9BK/sEU0Ka/T5LrnsK+6oUJIMdOTNTTbBXJlUS/tc1GpaIZsSwcsZJNGN9Dvys9EAC+cUYzHs91SPfIac1pNBoB9HCK0ZuZkYZiRgHwtj1Wtf7bTB8TNcvYjt5zFFBJDiIZTiOiNH7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864199; c=relaxed/simple;
	bh=pdHz/ZQynx70AqUAmganVblX3K3BAGKxxtc5oo/96CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X5WSiq6Jr6UFV3pPd+XtFIcKWXFScPTCa9SsRhm7I2/xczMeWLzqEQ9rhzpR19KgoT3fUak6/IK7UAbtEDzTy4Q+u2i+J8sJxtl/T+u3nC+TBxpBUYYMC8aUCbGwQ8UoA9QQcaZYSCfWkK52NA9f86nkAiHnV0Vx9QkBTAuyWdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GRdTMER4; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GRdTMER4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9R+MHxbC+FLfcFAcfUi0aLLH8VSGKoT5n1AQBdKHmZ2wfx6/IDZE0kYeLaK7q36lYSaOZfIiQCZg8pXcQFTQObeyLzR0YKPCly82gurWSpiq++HK18V5zA8VBlTHAd7LWEs/4VWSorgc/cijkdnhQrv9o5kmkyJ77m2bZiGrGqDlpdhrO62rk2EAtbcnmM/99a6R72VFDOKmDQApvUMcpgQmubghCxsDp0YP/5tub7d6JE+/CYjPZ7b1kjZZjt/zoTQ0nJx/A7pMAZz3J63zCeRrc7bwASVGn8oYt3Nx5RHlE2Z9+vxDDhwQehwFE6SNeToD6QKxi1J/c/30DdeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAS9Kbxy3KT88pveY1vG6lGuo4o+tGkNhUv2ybdOrXQ=;
 b=n4Njcbc8WDwCmPXScUDGzr+Vh6+kvrqAp3xpUG3+uU09qpptXLDxk4C6Tc4kfKNvIdCc8UeACib0//5z9yVxgXb/DqmpNUrsBqAitXXVA77ImJY8u/Wa+xtaYOH4uWuVWyGJTIUTjLOXMOj2XlVuv4d4JwZJHH4FqUs1IfO9GDs9EigpM2T/jrDswBU0K50DYBt4ai1QgGsvqmuj+ueGlxsrr3eLDyw1kqkgwVasUXTbJjY2uQLX0NSIUdUPRJImlNvZ3yrDdxBI/8g1eWCXW+WK5R1AVVk43/iJ5Szp+gQjBvXwyVNq6OcCvJG9P5LNvVYWwheXO4I7HuQ4Pt8PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAS9Kbxy3KT88pveY1vG6lGuo4o+tGkNhUv2ybdOrXQ=;
 b=GRdTMER4aeBM+dQOiK3cbnIejfB/B2DbDWQDhBhyhhoHZmS0PUESbRu/+1fYat/Qm+6hVKCk6U1YYNw1vUkZx7svRxnGE/hCBf/QiiOWZM+TVlxB0xpNnkTb0uDX3e2LgZnvJN5mu7kjBmvMN9ykrHR+JVFqyC/urIBAcVRYwEM=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 04:03:12 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::7) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 04:03:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 04:03:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 23:03:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 23:03:05 -0500
Received: from [10.136.44.93] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 23:03:00 -0500
Message-ID: <3685289e-beae-42f1-a574-44c6a64a6b00@amd.com>
Date: Tue, 13 Oct 2026 09:32:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/amd/ibs: Clear stale IBS_{FETCH|OP}_CTL in
 perf_ibs_start() with CTL2[Dis]
To: Jim Mattson <jmattson@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Yosry Ahmed
	<yosry@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261007234815.4026028-1-jmattson@google.com>
 <cce3cc5b-7942-4833-8ff2-8dc544ba45a2@amd.com>
 <20261009202812.2149137-1-jmattson@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20261009202812.2149137-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 93954fc0-8edf-4b87-8ccf-08df28dee62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	11RC4S4fT9hiJhWd/1k5Hb7IrdNmLo7PGzqj85o4bwsHev4+Yu/aTPCJ6cpezG+EI6XSuB8TQMWIziXo3fACK+AqMbRzfOt+lCFtAk/D0i3vHwu13CItkyYMxYz2enYQZRiRCiglMGMAn9jQjlhyrSjSJ+ce/sSmzskyxyqcBsFd6gfkyng4MC2mzU77XWWaMk+os1JqwztmRyiMY3MdJHX9yYVYhzzeSgXRuW1HSjDlma2EukeH3n7AMENXGRU1DeLnyDCJoSxTMLfOswkFs/AIKHN4BKT/kEr9UlR/4lscFy2FRv6WAfnHd5cpnawvU1Sy7cg+WlZ/Vdvs9GFcGufu+k+q2NNM/BDFHYZtrZN2JoTqSjgkOy2NR0D4jV4lpqnjxj8k9Eyx2tc0gxgum8qqNwT1ZO5tS6umJQ4GvA8dNpFU92jSu4UPHs+yWAVCGagfLLPlux0wQqpdLLiaJ++d5GXQQ6x4EEgJv6s5SRfD0fPy2LxxlyCVN9EO3YQQDZA/MsX/n3ob/am+BYyp5kanGbOToe0gWLXTj6uqc8paCo6/Msn2pcrdGUHxXCkK8eS4zTGPACnDU+5Hx923V+HOxvOlr5ukmc348kfCSSqDxWEo9HPmvUHhDZr8jLSUhYq4uhEU+6O6Ry8Cdse9xX8ruasDJ9QOVB8igh9oIP05X5ufhlZ46czzmJsAQiTBOr3AOTC/Zj7kZ43jWQw3IA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jMmG0ruajyvbm93ov+jsfdR/bJB2brpu/AxrYQRZf1Sdznb9coLdgmhX0BNBRV9/DvVS8ZYu1H+mNnWwYLnzbztDWC6xsc582ja63GpCnethioUAbGTguAGfs8pY8YoC4ROvAgJDz1q39l0yqjtsf7oETRfQfgD7MmZNkMOAurixk6YREGjM87bIIJA9kVkdKsrw/gQ0zzaOdVi6SFJD0icX/b9lGuRADJgKEXgC7JpxEuRRWMA3em4/6s8GwbSYFuKD0He4lnbiuwnK1+dZ/mgHKXLKezWL4gG4VVN3+DBREq8FK9nJ9ZmHGh9uxXpHskEp5ntRerT4JZrICc7nWrd+fYSGF1oyLy8pm7kQfKFrRrrcXDHnqEidqApMriDsZ/UXQXeVr7GnqI9Tl87ru2oOSUc3eewTkk0m/pJgIVvy0qCGz2mcN8bEtdaVBq3r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 04:03:11.8318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93954fc0-8edf-4b87-8ccf-08df28dee62c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

>> +	if (config & perf_ibs->valid_mask) {
>> +		ctl = config;
>> +		while (delay-- && ctl & perf_ibs->valid_mask) {
>> +			udelay(1);
>> +			rdmsrq(hwc->config_base, ctl);
>> +		}
>> +	}
> 
> This loop will time out when running in NMI context:
> 
>     perf_ibs_handle_irq() ->
>       perf_event_overflow() ->
>         __perf_event_overflow() ->
>           __perf_event_account_interrupt() ->
>             perf_event_throttle_group() ->
>               perf_event_throttle() ->
>                 perf_ibs_stop() ->
>                   perf_ibs_stop_dis() 
> 
> Should the loop just be skipped when in_nmi()?

Right. However, I'm planning to move the polling to ->start() and
also fix ->stop() with:

---
@@ -980,6 +980,14 @@ static void perf_ibs_stop_dis(struct perf_event *event, int flags)
        rdmsrq(hwc->config_base, config);

        config &= ~perf_ibs->valid_mask;
+
+       /*
+        * Clear the Val bit otherwise ->start() will unnecessarily
+        * wait for 50us.
+        */
+       if (in_nmi())
+               wrmsrq(hwc->config_base, config);
+
        perf_ibs_event_update(perf_ibs, event, &config);
        hwc->state |= PERF_HES_UPTODATE;

---

>> +	/* Catch delayed NMIs which arrives after disabling IBS PMUs. */
>> +	if (ibs_caps & IBS_CAPS_DIS) {
>> +		rdmsrq(perf_ibs->msr2, ctl2);
>> +		if (ctl2 & perf_ibs->disable_mask) {
>> +			rdmsrq(perf_ibs->msr, ctl);
>> +			if (ctl & perf_ibs->valid_mask) {
>> +				ctl &= ~(perf_ibs->enable_mask &
>> +					 perf_ibs->valid_mask);
> 
> enable_mask and valid_mask are disjoint. Should '&' be '|'?

Yes, will fix this.

>> +				wrmsrq(perf_ibs->msr, ctl);
>> +				return 1;
>> +			}
>> +			return 0;
>> +		}
>> +
> 
> [...]
> 
>>       if (WARN_ON_ONCE(!event))
> 
> With IBS_CAPS_DIS, we are now treating CTL2[Dis] as authoritative on the
> question of "is IBS idle." However, on the BSP after S3 resume

Yes, the syscore->resume() path needs to be fixed as well.

> or on any
> LPU after an AE #VMEXIT from an SEV-ES/SNP guest with IBS virtualization
> enabled, CTL2[Dis] will be reset to 0 and may no longer be authoritative.

KVM should save/restore host IBS MSRs when vIBS is enabled.

>> I think the intention is, host IBS should be disabled (could be from
>> CTL2[Dis]) before running VMRUN. But I'll confirm with the HW team.

Hardware checks the effective IBS op and fetch enables in VMRUN to a
SEV-SE/SEV-SNP guest. Effective enable being CTL[En] && !CTL2[Dis].
(This will be documented in the upcoming APM)

> Another question for the HW team: can the hardware set CTL[Val], or change
> CTL in any other way, after CTL2[Dis] has been set? The answer may
> obviate the need for the 50us poll.

Once IBS is disabled via CTL2, the hardware will not capture any new
samples, so the CTL register should remain unchanged. However, the
50us polling window is still necessary to account for potential NMI
latency.

Thanks,
Ravi
