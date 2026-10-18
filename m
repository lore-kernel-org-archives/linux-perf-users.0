Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC3486B80;
	Sun, 18 Oct 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323142; cv=fail; b=UNi9i+lQfFk4UwuaXcViO9oRkbq3gNn/Mp73oAIpHNGHkY/SiaqSrfDdupvuVFidyEXU0EItOKHs7gImDdLhCCbmsOeqQ/t7x2IXQ6GqOBbZ7AyQEjZVj51zA3b1qkwgaDSu/PgeF2ogVSrOlcAoTWaE6cTLyi6uk3+jwLneN4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323142; c=relaxed/simple;
	bh=FDGq4t2dR0h0hQaG9zVfMki8AwKtoPszlXEMr2w3fRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A1MnNm83HQ2dLLNYmRE3c37uL+46O1biXghriIb4ow1joFtl+vIPX+NruIKWDrmp56j3Rk4NC/zlrPbQ8njjFNTeFFgKjKI26YeOYJp1m6dsIrx89YMh1xauRl9K5WwSibMjW38b5wy59V/WfudE1xiPhvbej4E+D/dJcfWEB94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UpaIW8tJ; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UpaIW8tJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOyhwG8blIwbOxv/R7161ridgH9pPMPokkxTvpnf39soeXrZqttsdHazEsZ51u/8sT+x5w50+vU/y/RmFpzIT547CYIj4AwsE2n6dE5NZT4XLLtouPOLxzYo+BRjxZ5mGjViape8gmy9SLLYUIG9sIWbKcOvoUfzwgm1FtQH/DxggDe11LNeSlURp6KRi5sdh56/UV7lGio7AKdTa59QnJ4Rk7Mh+uYGWWM8jHtH888e3iHcqKbU7nq9xJJW3Sa2ZpznXR7O+0Tme+l0ISUjNzU+n5/DsTk1FQCZ8ieJyPYSD2HyikDB5w/dhmoLmfw6YLieR0y/vAnfJ2vgyb/LLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Day0hymDiG5dr1uv67roBMwzP/6hkspVFG/LqT7Ocso=;
 b=ewiuOSf9/PABvPxI3O4mr0+Uv/Ud7g8ldYUse/m48HRtii1ONoWxWRudMXyRwCDDpFQ4LfpPmeinQMLRo1hKOYRRSiuKu1yscJu/ZaDB2OwipyD3ZbTJCL6oe2hj7fIJRLQXOo3R7vMKWIY1Tn7l7WGcRGNbJCTX8wGjYa05mLNUL4RlSLGqP6huRF4LDTe8AitgW+LLEPZtzfgwq1raxTJGK474fIpy5V9h000K1wtuEriRMss9rYlvNsl7qub2uqw6JKfyN5wXlaByly1BB11h4VY4Y/7aSuLxMSY7QaEz/JgzpqHRZdKHPkSAtE0QjpMGjMPt1QZQk56NNKXICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Day0hymDiG5dr1uv67roBMwzP/6hkspVFG/LqT7Ocso=;
 b=UpaIW8tJKlnh8y6nkpEGNofQfGbHIxD6MG4atPFEVbjY+z9cUj2UTdjMgyFt82ATpBtDE3HIomhqRbLkTU77fqGwiNc476e6WEmIXI+oYoaE0yxh4aEVtsYwWsX7xnSmBVKDLm/QqSVRWf3AUruiw3XdBRquM5dBfdaDP+ughD0=
Received: from CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::26)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 11:32:14 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::62) by CH0P223CA0011.outlook.office365.com
 (2603:10b6:610:116::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Sun,
 18 Oct 2026 11:32:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 18 Oct 2026 11:32:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 06:32:06 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 06:32:01 -0500
Message-ID: <09e61c95-97bd-46c7-9d96-c3926e324c26@amd.com>
Date: Sun, 18 Oct 2026 17:01:55 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/amd/ibs: Simplify event state handling with
 IBS_CAPS_DIS
To: Jim Mattson <jmattson@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Jayapal Ashwin Nair <janair@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Manali Shukla <manali.shukla@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
 <20261015060430.5877-4-ravi.bangoria@amd.com>
 <CALMp9eRTG=uLkAWohYW0HOoS1xvNc_0brovYsfbCUS_mf4H3Kw@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CALMp9eRTG=uLkAWohYW0HOoS1xvNc_0brovYsfbCUS_mf4H3Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: f88bd5d7-57ec-4b8c-89a1-08df2d0b74a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|10067099003|13003099007|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KnLdpAzNK6Xgx51gqPmFYVQ5gr0HxhrXhqknC+9HRPuz9N9kVuGxcDVh3tDIgKwMFmbOrGhm/0Y1i5InkGE5EA9EGcsQWla8uDmjBgv/O9hI1JhdaIgBagkA8qsKA1jynzMOmK30qGG140zcWzY2WHBkFLv6zfkiPM9XVm/H/GX9ow7VMtOFif1PUJ5QjQkSTl6oP0mMm7Fazgv2s6aZEWu9MG35s5/PQ5dCibKsWtWoEvpZrK8l16hOymXL0tqijKhw1/P82WeiH/NPBBWQe3VBQouMN0DP6eJpwgOaJ/QQ50Ipdsm6tuEC0usc5bf+AYhu6Y0h0SZVfIGH89bjxw+UyYzwuYVe389vCFbDiPNxj9HMLvGOF0ncyrSaPN/WRT4eFFw1ezLxB45XQdbyNGgYsDdk/rVQ5ynQnhfMfUOt7HMox7R8nethuMOsWI6t409ZEGzQOUL+1oyEDn4iqlaw9iW9PLgAVRmYvENGE5rqrr/Mj71URV0FDsG98oSpVH28BJqosEJHFB+5zdvAUxZyOZA2gSMYTr0JWZnq0tnOGVa+2W9BOz2EifDSD73ZNr1H/I+QfkRVSPuj0elolex5P6BuSjf89B5EgYz09/HBjj5zGNx/+EWOJiuSuLij5+UBaCp5QmK0U4VHISIaaQtfRqQe7RugOnqTyQVUuZM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(13003099007)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	35BY+ulZyBGMJAhbP2+B5qx3dex9npItPvltmYzfYkFc8qNbW6oLjFOnut6ZKAwW9Wb8kC5TeHBzgP2pfewPCnq5N5JzRilmYZEcdCEx6nZNWWJYhmqgvuRvhrnkObISIAxjKXIg3WelK/JOi4KrbgjDJK+HUxLs0EaxdPfPu4mV0LAs7fyHlE75lqcPN5UiA71mxR6/rNvkG+dXPoXtu4WRUAUw9OufIFBS63FKzu4PNCiC/Btp845Zui+L4BkSNPb2blWR/rNLa/QwAPgZ3WkUIW568oTG5ToLN4z8cNkxhQzfzEZrXifck7N8jdtw0TakT/4tX4uRw9j6QZJC84nirKBsNyaztfNiMfUSY+5+WgaFKONR0sKDkPMeCNHd3aQQmXd6Aa5Q/RyJ0ztZHvQzHfKJCkeECzJPgQn5AI3BI2oD/4OaMx5DCemg0Sku
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 11:32:13.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88bd5d7-57ec-4b8c-89a1-08df2d0b74a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

Jim,

Thanks for the detailed review.

>> The IBS_{FETCH|OP}_CTL2[Dis] bit allows IBS sampling to be stopped without
>> a RMW of IBS_{FETCH,OP}_CTL. Systems providing this bit therefore do not
>> require the IBS_STARTED and IBS_STOPPED states used to coordinate control
>> MSR updates with late NMIs.
> 
> CTL2[Dis] doesn't make late NMIs go away. Hence, this patch needs a
> 50us poll. With the two-line fix in my original patch, the existing
> scheme handles late NMIs indefinitely: IBS_STOPPED remains set until a
> late NMI consumes it, even if the event has been restarted in the
> meantime. This patch trades that for a 50us window, after which a late
> NMI is unknown (which *is* fatal with unknown_nmi_panic). Moreover,
> since we still have to handle hardware without IBS_CAPS_DIS, we now
> have two state machines instead of one.

IBS_STOPPED only records that "a late NMI might exist". It can't tell
whether the disable actually completed or whether that late NMI has
already arrived. Trying to infer from software state is fundamentally
broken, since the WRMSR and a software state transition can't be made
atomic.

Given that Zen6 provides a clear hardware state machine, I believe using
it, rather than a software state machine, is the right approach.

I ran a fuzzer for several hours with my patch (+Manali's patch [1]) and
saw no Unknown NMIs on Zen6.

However, With your patch[2] (+Manali's patch), the same fuzzer continued
to produce quite a few Unknown NMIs on Zen6. One race I was able to
identify (with your patch applied) is described below.

---
  o FETCH and OP both are enabled.

  perf_ibs_stop() /* For OP */
  {
       set IBS_STOPPED
       op state: ENABLED | STARTED |
                 STOPPING | STOPPED

       OpVal is 0 in hardware

                                               NMI due to FETCH
                                               {
                                                    FETCH: Val=1, sample handled,
                                                    fetch re-armed

                                                    OP: STARTED is set, OpVal is 0 so
                                                    test_and_clear(IBS_STOPPED)
                                                    clears the STOPPED state

                                                    OP continues to run, it overflows,
                                                    sets OpVal=1 and a new NMI is
                                                    latched by the OP hardware

                                                    return handled=2
                                               }

       op state: ENABLED | STARTED |
                 STOPPING

       WRMSR OpCtl2.Dis=1
       leaves the valid sample in OpCtl

       clear IBS_STARTED

       op state: ENABLED | STOPPING

                                               NMI (late) due to OP
                                               {
                                                    FETCH: Val=0 -> return 0

                                                    OP: STARTED is clear and
                                                    STOPPED is already clear.

                                                    return 0 without reading
                                                    IbsOpCtl

                                                    return handled=0

                                                    Unknown NMI
                                               }
---

[1]: https://lore.kernel.org/r/20260310060022.15120-2-manali.shukla@amd.com
[2]: https://lore.kernel.org/r/20261007234815.4026028-1-jmattson@google.com

[...]

>> +/* ->stop() for platforms with additional CTL2[Dis] bit. */
>> +static void perf_ibs_stop_dis(struct perf_event *event, int flags)
>> +{
>> +       struct hw_perf_event *hwc = &event->hw;
>> +       struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
>> +       struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
>> +       u64 config;
>> +       u64 ctl2;
>> +
>> +       WARN_ON_ONCE(test_bit(IBS_STOPPING, pcpu->state));
>> +
>> +       set_bit(IBS_STOPPING, pcpu->state);
> 
> This function needs to be reentrant. If an IBS event is a sibling in a
> group led by a core PMU event, and the leader is throttled,
> perf_event_throttle_group() will stop the IBS sibling from the core
> PMU's NMI handler:
> 
>     amd_pmu_v2_handle_irq() ->
>       perf_event_overflow() ->
>         __perf_event_overflow() ->
>           __perf_event_account_interrupt() ->
>             perf_event_throttle_group() ->
>               perf_event_throttle() ->
>                 perf_ibs_stop() ->
>                   perf_ibs_stop_dis()

Core and IBS, both are of hardware PMU type and thus can not be
grouped together.

[...]

>> +       if (in_nmi())
>> +               wrmsrq(hwc->config_base, config);
> 
> As we saw above, in_nmi() doesn't mean that we're in
> perf_ibs_handle_irq() for this sample. If IBS Val=1 and the IBS NMI is
> still pending, this clears Val. When the IBS NMI arrives,
> perf_ibs_handle_irq() finds CTL2[Dis]=1 and Val=0, and therefore
> returns 0, leading to an unknown NMI.

The back-to-back NMI handling logic in the x86 generic NMI code should
already handle this. No?

Thanks,
Ravi
