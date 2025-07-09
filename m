Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EC25B1DA
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097253; cv=none; b=d7D5pqVtTU86NPbAJzNL5LpQyjTOjTup5e+JlxYwKQqh0MdmjReGvUay9D1GqMbuwB+H1ifv2LXM4EP13k+8Fa1V1d2Y/yrvGu4/OE6TchaaEe1h8V3q58P0kbPmZTKcKEWHnkfbD7LtfxDu2pxxxfwYxAsKlbaWxEBQa9LK6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097253; c=relaxed/simple;
	bh=SlQ4yQiCxha6D90EaERBK4fPSe2+4PNG3jcD2ckQ+FY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=koGgd3ZWT4xwrSo0egdUOHDzA2PnCD5EYb/X0QFwsVsMrRuk03OMfMYtLPEROtfxJAct+f7B9KPaZs7Z1sselAUzNNKujpXQihGKC5Uj4D5IHxOLBDixqsk2GaQqKqwB6dh2Klunc8Zg6tQbZesrOmCQQLuWP63A8GItvRzDZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIxTo2SK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIxTo2SK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2349fe994a9so2539655ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097250; x=1752702050; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNRFcAbNZdrNDSocF3ZCTE7cXmpBNdhTgAmXtSDNfiQ=;
        b=zIxTo2SKCLcFCXhKfjvuuwaaI67AiLSGsz3EdYvyNYxjXZqTAOailbjT1Hsw7LrBET
         bjsIlEq/X66wWgqseTpVXoxzd+do+5AW8A5FTjvJ5Z4PlWRlrO2eGCiJBfGCrL9dr/qQ
         vkIqk7rUnRcIkxtct6CS0pBoMptDLV+qIfgaC9cBhrkA2Kq5W3KwNqgyx2OR2G8hBJKq
         IW5gDztVZ7G3+L/nETIgL7BYcFqB+vPHPjZ9FQUiSm2DF0BpFzcFf2Qg6ig09K9kvV5Q
         Bef8zDrbZExVIIuD7q3zrUeuGRcFZBerc85xE8OQ4ZylnO18SRuljXZFrSp8T4HMZyRz
         H3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097250; x=1752702050;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KNRFcAbNZdrNDSocF3ZCTE7cXmpBNdhTgAmXtSDNfiQ=;
        b=IREyJpdJBMq/OZyJCF5C0VZSdpFl0A+abwmUDm1vt/yozwMU4aSQPH/7qIK/Ye1RhC
         GbZrI6sV3zGC4u+7XFU9HrTUcVICcm69MqG18kKIt45EnCw0pGh85RKSYmfih/LM0EAt
         fZH2zNGchCwoKCBNo0HPUrO8UQ3YiJ/RR0yD1bGml5s98DEkX3OCHLffZjf3jfUbKTrD
         bh8teFXFKp+PvGaApPotAtOucjAExbPnL8KVYkjngo90tTdg86EpwNQerzrCNjlQDiFG
         ErWUdsohDidZTM85P5H3wX5c5L3RYcanji23CrkjADfPjEplho/dwN9aT5w9jZJVvJPD
         E+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFcHHtl2ca0ojphrw/U5r3j5p48+h1cOhVt3CNKtEhCEvb0jI53+AKKK83LrF2mSLeytjllGQH0AVzzGDJzNWY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9E4+v2kn+rhsCRlYcd2HUGkfUMgrev9XUls/tyNykeoif2iO
	3tnaia4zcg3oQYyTXiDrnc0H58v5S6erWgPzEG2Nr2Plz1+rKNe0K5I3QPAvfm3LAAM6p0GhdDE
	IJ+5sgz+k+A==
X-Google-Smtp-Source: AGHT+IHoonnPuhcOJMDMsyRRUK62Ej8e2hIEwTvQIb3Ec6/wgya7AQKQ7nEQp2Qy/LfmBXoUamXc98uezfRP
X-Received: from plbld14.prod.google.com ([2002:a17:902:face:b0:236:6f45:7ec1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70e:b0:235:ef67:b5a0
 with SMTP id d9443c01a7336-23de48a0664mr199065ad.36.1752097250379; Wed, 09
 Jul 2025 14:40:50 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:25 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-9-irogers@google.com>
Subject: [PATCH v1 08/12] perf jevents: If the long_desc and desc are
 identical then drop the long_desc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If the short and long descriptions are the same then save space and
don't store both of them. When storing the desc in the perf_pmu_alias,
don't duplicate the desc into the long_desc.

By avoiding storing the duplicate the size of the events string in the
binary on x86 is reduced by 29,840 bytes.

Fix tests that expect a duplicated description.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 128 +++++++++++------------
 tools/perf/pmu-events/jevents.py         |   3 +
 tools/perf/tests/pmu-events.c            |  22 ----
 tools/perf/util/pmu.c                    |   3 +-
 4 files changed, 68 insertions(+), 88 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index d4017007a991..a4569a74db07 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -40,38 +40,38 @@ static const char *const big_c_string =3D
 /* offset=3D1475 */ "dispatch_blocked.any\000other\000Memory cluster signa=
ls to block micro-op dispatch for any reason\000event=3D9,period=3D200000,u=
mask=3D0x20\000\00000\000\000\000\000\000"
 /* offset=3D1608 */ "eist_trans\000other\000Number of Enhanced Intel Speed=
Step(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\0=
0000\000\000\000\000\000"
 /* offset=3D1726 */ "hisi_sccl,ddrc\000"
-/* offset=3D1741 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000\000\000\000DDRC write commands\000"
-/* offset=3D1830 */ "uncore_cbox\000"
-/* offset=3D1842 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000A cross-core snoop =
resulted from L3 Eviction which misses in some processor core\000"
-/* offset=3D2076 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000\000\000\000UNC_CBO_HYPHEN\000"
-/* offset=3D2144 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000\000\000\000UNC_CBO_TWO_HYPH\000"
-/* offset=3D2218 */ "hisi_sccl,l3c\000"
-/* offset=3D2232 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000\000\000\000Total read hits\000"
-/* offset=3D2315 */ "uncore_imc_free_running\000"
-/* offset=3D2339 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000\000\000\000Total cache misses\0=
00"
-/* offset=3D2437 */ "uncore_imc\000"
-/* offset=3D2448 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000\000\000\000Total cache hits\000"
-/* offset=3D2529 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D2548 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D2624 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D2643 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D2720 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D2739 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D2882 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
-/* offset=3D2904 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
-/* offset=3D2967 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=3D3133 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D3197 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D3264 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3D3335 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3D3429 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
-/* offset=3D3563 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3D3627 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D3695 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D3765 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
-/* offset=3D3787 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
-/* offset=3D3809 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3D3829 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
+/* offset=3D1741 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000\000\000\000\000"
+/* offset=3D1811 */ "uncore_cbox\000"
+/* offset=3D1823 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
+/* offset=3D1977 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000\000\000\000\000"
+/* offset=3D2031 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000\000\000\000\000"
+/* offset=3D2089 */ "hisi_sccl,l3c\000"
+/* offset=3D2103 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000\000\000\000\000"
+/* offset=3D2171 */ "uncore_imc_free_running\000"
+/* offset=3D2195 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
+/* offset=3D2275 */ "uncore_imc\000"
+/* offset=3D2286 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000\000\000\000\000"
+/* offset=3D2351 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D2370 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D2446 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D2465 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D2542 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D2561 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=3D2704 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
+/* offset=3D2726 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
+/* offset=3D2789 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=3D2955 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D3019 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D3086 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=3D3157 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=3D3251 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
+/* offset=3D3385 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
+/* offset=3D3449 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D3517 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D3587 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
+/* offset=3D3609 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
+/* offset=3D3631 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=3D3651 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {
@@ -107,21 +107,21 @@ static const struct compact_pmu_event pmu_events__tes=
t_soc_cpu_default_core[] =3D
 { 1373 }, /* segment_reg_loads.any\000other\000Number of segment register =
loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\0=
00 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 1741 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\0=
00event=3D2\000\00000\000\000\000\000DDRC write commands\000 */
+{ 1741 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\0=
00event=3D2\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 2232 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000\000\000\000Total read hits\000 */
+{ 2103 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 2076 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\=
00000\000\000\000\000UNC_CBO_HYPHEN\000 */
-{ 2144 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\=
000\00000\000\000\000\000UNC_CBO_TWO_HYPH\000 */
-{ 1842 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core=
 snoop resulted from L3 Eviction which misses in some processor core\000eve=
nt=3D0x22,umask=3D0x81\000\00000\000\000\000\000A cross-core snoop resulted=
 from L3 Eviction which misses in some processor core\000 */
+{ 1977 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\=
00000\000\000\000\000\000 */
+{ 2031 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\=
000\00000\000\000\000\000\000 */
+{ 1823 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core=
 snoop resulted from L3 Eviction which misses in some processor core\000eve=
nt=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 2448 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000\000\000\000Total cache hits\000 */
+{ 2286 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 2339 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000\000\000\000Total cache misses\000 */
+{ 2195 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000\000\000\000\000 */
=20
 };
=20
@@ -139,41 +139,41 @@ const struct pmu_table_entry pmu_events__test_soc_cpu=
[] =3D {
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 2218 /* hisi_sccl,l3c\000 */ },
+     .pmu_name =3D { 2089 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 1830 /* uncore_cbox\000 */ },
+     .pmu_name =3D { 1811 /* uncore_cbox\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 2437 /* uncore_imc\000 */ },
+     .pmu_name =3D { 2275 /* uncore_imc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 2315 /* uncore_imc_free_running\000 */ },
+     .pmu_name =3D { 2171 /* uncore_imc_free_running\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 2882 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 3563 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
-{ 3335 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 3429 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
-{ 3627 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
-{ 3695 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
-{ 2967 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 2904 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
-{ 3829 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
-{ 3765 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 3787 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 3809 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 3264 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
-{ 3133 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
-{ 3197 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
+{ 2704 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 3385 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
+{ 3157 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 3251 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
+{ 3449 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
+{ 3517 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
+{ 2789 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 2726 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
+{ 3651 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
+{ 3587 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 3609 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 3631 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 3086 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
+{ 2955 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
+{ 3019 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
=20
 };
=20
@@ -186,13 +186,13 @@ const struct pmu_table_entry pmu_metrics__test_soc_cp=
u[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 2643 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000\000\000\000 */
+{ 2465 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 2739 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000\000\000\000 */
+{ 2561 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 2548 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000\000\000\000 */
+{ 2370 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000\000\000\000 */
=20
 };
=20
@@ -200,17 +200,17 @@ const struct pmu_table_entry pmu_events__test_soc_sys=
[] =3D {
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 2624 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name =3D { 2446 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 2720 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name =3D { 2542 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 2529 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name =3D { 2351 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
=20
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index a1899f35ec74..e821155151ec 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -397,6 +397,9 @@ class JsonEvent:
       self.desc +=3D extra_desc
     if self.long_desc and extra_desc:
       self.long_desc +=3D extra_desc
+    if self.desc and self.long_desc and self.desc =3D=3D self.long_desc:
+        # Avoid duplicated descriptions.
+        self.long_desc =3D None
     if arch_std:
       if arch_std.lower() in _arch_std_events:
         event =3D _arch_std_events[arch_std.lower()].event
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 8bbe0516ecc0..95fd9f671a22 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -53,7 +53,6 @@ static const struct perf_pmu_test_event bp_l1_btb_correct=
 =3D {
 		.topic =3D "branch",
 	},
 	.alias_str =3D "event=3D0x8a",
-	.alias_long_desc =3D "L1 BTB Correction",
 };
=20
 static const struct perf_pmu_test_event bp_l2_btb_correct =3D {
@@ -65,7 +64,6 @@ static const struct perf_pmu_test_event bp_l2_btb_correct=
 =3D {
 		.topic =3D "branch",
 	},
 	.alias_str =3D "event=3D0x8b",
-	.alias_long_desc =3D "L2 BTB Correction",
 };
=20
 static const struct perf_pmu_test_event segment_reg_loads_any =3D {
@@ -77,7 +75,6 @@ static const struct perf_pmu_test_event segment_reg_loads=
_any =3D {
 		.topic =3D "other",
 	},
 	.alias_str =3D "event=3D0x6,period=3D0x30d40,umask=3D0x80",
-	.alias_long_desc =3D "Number of segment register loads",
 };
=20
 static const struct perf_pmu_test_event dispatch_blocked_any =3D {
@@ -89,7 +86,6 @@ static const struct perf_pmu_test_event dispatch_blocked_=
any =3D {
 		.topic =3D "other",
 	},
 	.alias_str =3D "event=3D0x9,period=3D0x30d40,umask=3D0x20",
-	.alias_long_desc =3D "Memory cluster signals to block micro-op dispatch f=
or any reason",
 };
=20
 static const struct perf_pmu_test_event eist_trans =3D {
@@ -101,7 +97,6 @@ static const struct perf_pmu_test_event eist_trans =3D {
 		.topic =3D "other",
 	},
 	.alias_str =3D "event=3D0x3a,period=3D0x30d40",
-	.alias_long_desc =3D "Number of Enhanced Intel SpeedStep(R) Technology (E=
IST) transitions",
 };
=20
 static const struct perf_pmu_test_event l3_cache_rd =3D {
@@ -133,11 +128,9 @@ static const struct perf_pmu_test_event uncore_hisi_dd=
rc_flux_wcmd =3D {
 		.event =3D "event=3D2",
 		.desc =3D "DDRC write commands",
 		.topic =3D "uncore",
-		.long_desc =3D "DDRC write commands",
 		.pmu =3D "hisi_sccl,ddrc",
 	},
 	.alias_str =3D "event=3D0x2",
-	.alias_long_desc =3D "DDRC write commands",
 	.matching_pmu =3D "hisi_sccl1_ddrc2",
 };
=20
@@ -147,11 +140,9 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_r=
esponse_miss_eviction =3D {
 		.event =3D "event=3D0x22,umask=3D0x81",
 		.desc =3D "A cross-core snoop resulted from L3 Eviction which misses in =
some processor core",
 		.topic =3D "uncore",
-		.long_desc =3D "A cross-core snoop resulted from L3 Eviction which misse=
s in some processor core",
 		.pmu =3D "uncore_cbox",
 	},
 	.alias_str =3D "event=3D0x22,umask=3D0x81",
-	.alias_long_desc =3D "A cross-core snoop resulted from L3 Eviction which =
misses in some processor core",
 	.matching_pmu =3D "uncore_cbox_0",
 };
=20
@@ -161,11 +152,9 @@ static const struct perf_pmu_test_event uncore_hyphen =
=3D {
 		.event =3D "event=3D0xe0",
 		.desc =3D "UNC_CBO_HYPHEN",
 		.topic =3D "uncore",
-		.long_desc =3D "UNC_CBO_HYPHEN",
 		.pmu =3D "uncore_cbox",
 	},
 	.alias_str =3D "event=3D0xe0",
-	.alias_long_desc =3D "UNC_CBO_HYPHEN",
 	.matching_pmu =3D "uncore_cbox_0",
 };
=20
@@ -175,11 +164,9 @@ static const struct perf_pmu_test_event uncore_two_hyp=
h =3D {
 		.event =3D "event=3D0xc0",
 		.desc =3D "UNC_CBO_TWO_HYPH",
 		.topic =3D "uncore",
-		.long_desc =3D "UNC_CBO_TWO_HYPH",
 		.pmu =3D "uncore_cbox",
 	},
 	.alias_str =3D "event=3D0xc0",
-	.alias_long_desc =3D "UNC_CBO_TWO_HYPH",
 	.matching_pmu =3D "uncore_cbox_0",
 };
=20
@@ -189,11 +176,9 @@ static const struct perf_pmu_test_event uncore_hisi_l3=
c_rd_hit_cpipe =3D {
 		.event =3D "event=3D7",
 		.desc =3D "Total read hits",
 		.topic =3D "uncore",
-		.long_desc =3D "Total read hits",
 		.pmu =3D "hisi_sccl,l3c",
 	},
 	.alias_str =3D "event=3D0x7",
-	.alias_long_desc =3D "Total read hits",
 	.matching_pmu =3D "hisi_sccl3_l3c7",
 };
=20
@@ -203,11 +188,9 @@ static const struct perf_pmu_test_event uncore_imc_fre=
e_running_cache_miss =3D {
 		.event =3D "event=3D0x12",
 		.desc =3D "Total cache misses",
 		.topic =3D "uncore",
-		.long_desc =3D "Total cache misses",
 		.pmu =3D "uncore_imc_free_running",
 	},
 	.alias_str =3D "event=3D0x12",
-	.alias_long_desc =3D "Total cache misses",
 	.matching_pmu =3D "uncore_imc_free_running_0",
 };
=20
@@ -217,11 +200,9 @@ static const struct perf_pmu_test_event uncore_imc_cac=
he_hits =3D {
 		.event =3D "event=3D0x34",
 		.desc =3D "Total cache hits",
 		.topic =3D "uncore",
-		.long_desc =3D "Total cache hits",
 		.pmu =3D "uncore_imc",
 	},
 	.alias_str =3D "event=3D0x34",
-	.alias_long_desc =3D "Total cache hits",
 	.matching_pmu =3D "uncore_imc_0",
 };
=20
@@ -246,7 +227,6 @@ static const struct perf_pmu_test_event sys_ddr_pmu_wri=
te_cycles =3D {
 		.compat =3D "v8",
 	},
 	.alias_str =3D "event=3D0x2b",
-	.alias_long_desc =3D "ddr write-cycles event",
 	.matching_pmu =3D "uncore_sys_ddr_pmu0",
 };
=20
@@ -260,7 +240,6 @@ static const struct perf_pmu_test_event sys_ccn_pmu_rea=
d_cycles =3D {
 		.compat =3D "0x01",
 	},
 	.alias_str =3D "config=3D0x2c",
-	.alias_long_desc =3D "ccn read-cycles event",
 	.matching_pmu =3D "uncore_sys_ccn_pmu4",
 };
=20
@@ -274,7 +253,6 @@ static const struct perf_pmu_test_event sys_cmn_pmu_hnf=
_cache_miss =3D {
 		.compat =3D "(434|436|43c|43a).*",
 	},
 	.alias_str =3D "eventid=3D0x1,type=3D0x5",
-	.alias_long_desc =3D "Counts total cache misses in first lookup result (h=
igh priority)",
 	.matching_pmu =3D "uncore_sys_cmn_pmu0",
 };
=20
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23666883049d..b09b2ea2407a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -623,8 +623,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, co=
nst char *name,
=20
 	alias->name =3D strdup(name);
 	alias->desc =3D desc ? strdup(desc) : NULL;
-	alias->long_desc =3D long_desc ? strdup(long_desc) :
-				desc ? strdup(desc) : NULL;
+	alias->long_desc =3D long_desc ? strdup(long_desc) : NULL;
 	alias->topic =3D topic ? strdup(topic) : NULL;
 	alias->pmu_name =3D pmu_name ? strdup(pmu_name) : NULL;
 	if (unit) {
--=20
2.50.0.727.gbf7dc18ff4-goog

