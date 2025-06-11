Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903121421D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657750; cv=none; b=qMQbYLAn5V932ypry3e0jp+41rlMzEQK4s48w91Ir+8T5mVosA/1BXjnSjFu0VM9+uTrrMBSoQuPVL/km2UeCd7HnOGdfVnWtuch3yIUijqtZppHNcYRTeNb/Mhc4kl36mxnrOaevBsNdYuwmsX+VHfD2i2I1v3E3rKTAHCxkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657750; c=relaxed/simple;
	bh=UzhI2lOr5WrK1GALVK5Z4SxUrla0a7D1VvqvELZAbMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L+5lIpR0lTeGCa/ULolbz0Tc5vKwbMUas0AlszgO77yS25oQEG5sYy1aag0IZg+qnGa3vquzov880fsO+8ecHwIs5IafckWnpQGSYaoVNzFNhlKHXXpC895TdAIh9GsZmZmayoCTwTK3fJp2urDVvNQcgyervcnm00fRXsbyNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tER37P8M; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tER37P8M"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6049acdc5c5so44790eaf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749657746; x=1750262546; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cIghrdogQeuhGnSkR7d/eWckeeVukj3QOlnhxStIYM=;
        b=tER37P8MsvOlqgV0VVLAUa5+zKj04XJGuUMrMUUOa7d/5ME/wG0K3ZaZyixA/REL3X
         5R8mgVhFpwNLR8925Gq7szNqmuz5O9le9sMZiTIJ4je9cPxjiKTdxGlwzaRPgilIkgrc
         5IF2hInCF2K4hRFSP2owRE+p9p0i5HpkwdJY+srkPbOrGEQLYKDId6I+kTkH1yAdOF4l
         3ll1ByJQjCVcxdULC9aEY4ZhbMlXQSaIAqPuOp49LtsoHhCi7bg3e/ppgC4MqHT7LB1P
         A+hzAd+0Gme+kGRRLjq6U3kOGo0TLsc3wGtMvYJXAzzPuSbpZav+MBR4naI+v9HnHKVs
         y39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657746; x=1750262546;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9cIghrdogQeuhGnSkR7d/eWckeeVukj3QOlnhxStIYM=;
        b=lIIo5lW+EVur0sDawxR+xDwo3+EVVkzBIUthhx7NuQIyogNHfUYg6CCjLfPJ6qKZ2f
         /pZoRItHfwYiLOgmqgvWW+qOKQtJUDtBQYQAO7VPZGIaadsZsRG/Q2DfCTxpc52Bwomc
         Jjk3tiDnBRmJYtJUXE1FIkbhmBEn5Whken7ELJg9wCEl1guDyZva/PW52d8mjfSoo6DX
         0chlRaGZVujXdKQmsIYI9NBxavgoxHRhFqjX5HdSuI2DzYufF3Z81AeFT2rwOo6aLWHM
         /5FceUB44mRiWHRkBN17sByFhMWckchpnBatimPurp1+wnRmUhEb8nFiwuEQdqig7VLI
         YHEA==
X-Forwarded-Encrypted: i=1; AJvYcCUbo1cX+3Ji15KJ5yfdtAntPiDJAwdS9h7OKogx1hpdXkdBq/2l5ImJptdmlHl5s6xeqoRltxi9aTAtVcE4jhxt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlp/qyGrmlp8q5NgFXC3N6VwK3uIC9gcqwxXCXA9cwWWXwE1bG
	LKrYJb858hG6+b4f495lAjwKIwisclxMX/S/BXIDPx79ZCpH7SetkHd70TCwf6NwmROzQdB5ro/
	q1kHdk3XNlQ==
X-Google-Smtp-Source: AGHT+IHkNZKc+fx5YEYtMEWjH7Wb1ach/6a4Cue5NRuqJKKLjpJg3aCpwLmfJ2gt3kzcCuotNznBNkQl8l56
X-Received: from oabop11.prod.google.com ([2002:a05:6870:2dcb:b0:2bc:757d:e145])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:d38d:b0:2e9:a15f:6c3b
 with SMTP id 586e51a60fabf-2ea96c4f2cfmr2315772fac.10.1749657746069; Wed, 11
 Jun 2025 09:02:26 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:01:59 -0700
In-Reply-To: <20250611160206.552030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611160206.552030-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611160206.552030-9-irogers@google.com>
Subject: [PATCH v2 08/15] perf jevents: If the long_desc and desc are
 identical then drop the long_desc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If the short and long descriptions are the same then save space and
don't store both of them. When storing the desc in the perf_pmu_alias,
don't duplicate the desc into the long_desc.

By avoiding storing the duplicate the size of the events string in the
binary on x86 is reduced by 29,840 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 128 +++++++++++------------
 tools/perf/pmu-events/jevents.py         |   3 +
 tools/perf/util/pmu.c                    |   3 +-
 3 files changed, 68 insertions(+), 66 deletions(-)

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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 609828513f6c..76b7ded7fbf4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -622,8 +622,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, co=
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
2.50.0.rc0.642.g800a2b2222-goog

