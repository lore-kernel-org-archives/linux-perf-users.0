Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988A817A301
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069393; cv=none; b=XOOvER3U4uYi0623jOFMWWOTXXKa6Yz84iiADN/uY/FMdAw13w9zo1oXySsnEPdthc6gEWez6luEFCAd6FWAPQ6RDH1V0vgXiPfo+FoJ33uNyNlfVmFyPtuJEYO2VTJdeRt13qqIuaNjjCyPdYLj/loe9EsYwxwHjUERG8/Kiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069393; c=relaxed/simple;
	bh=psqE77Pyy5/uOhxmfA6RaQ6/oLsvoziIlr+loXFna34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mHaJZGXL8bfk1YSG2Z8peVperyNs7ikauU6SnN9TsT8sbbYRsOpv5F+SWkH5KPDVaS1UU2P3oDluY7/9t8kYK7wFcQvYjSwdjmyZ13oaLNHSkQWPZKTfyZp/DRD1vs56wI0jbFp8wWuYh6Q3N2apgOSO7sH38mjqicve4eZneec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fetIfbpO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fetIfbpO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so298761a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 17:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751069391; x=1751674191; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLizt+Z1CxDbBZc7tqUJi1TbDzEztgwF5seXSe0yNb0=;
        b=fetIfbpOXUSMrisBQBTV4IpSIHrBeJHsCVI9yD4H07ZnJfi6xmFFowl9Dv7MT8HVuV
         f925r+/Ia45tWIwB+C8noXzyk+Wi7xawt2P9tmKgAz0j3cFVSyxhDdMQbRsCXpZM99G+
         QRSnoCdd0cXJ0YH8ACHLkE5M1usgGHMIlUJtWdr1JpVRYcV8Zdaie4jS53eysvNWIKIP
         AdL8pZHNXqD4q/uS0xVKvododRwFj3n5SHWp5Z1CQsxwx+2XiGWRQB0zva4DVFDzO/on
         LHzVcD2K+B5M7sshQHf0wLJCVOoMSVwl+CQL8YvBWPm9BPWEA6GC8M2W1CSiQw/CYqIJ
         i8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751069391; x=1751674191;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VLizt+Z1CxDbBZc7tqUJi1TbDzEztgwF5seXSe0yNb0=;
        b=H3wYv8gYKm57o4IbWKSq5Sbup04kZuH9PcoMjRdZBl+Jfu/kpSaTH7O3g2/J15CfZR
         JVV6IZxXRgU2CIz/rj8fAEDgniecrTYzAfoELgbaqUi6stt1i/HGnlSqfKDdxQ2eMDdA
         r9c98/Jb/+bquvXxVe+IK0WZ6Z7UHZtzz7nuemMaW5KgdGvyDjvG1Tlz0mzLILlcmnby
         osuyCsBvFimirkVV81+DkFujSlEjW+gWt09H2umOYHeywMXWgmlKe9xPsNXJoKT4wm95
         SZWwb7fy4az4RwKFuxyqHm9la3E4beEsNG4nyP14wcr5/t8VOYRU7iHnPlz8WsPLmkh7
         PFlA==
X-Forwarded-Encrypted: i=1; AJvYcCWLDpg4abI6F7w4at7mkrsh6ougGLokz3X6TBh1hHc8ZklbfFklQhfLH8kca03DFFf4xn+0hnYurFPyCi6NPhUU@vger.kernel.org
X-Gm-Message-State: AOJu0YxfeUTbYFQT+LmGFCGouBDOHXDjN+7IqHlFAzN8nid0VtopWlE1
	8sYdietNgztv7MUlHYk0Z4Ua7QPCXLO/TzP92uplUFOm6MCCpftIW4ypDVL5jWaP3MA0GE1/BHl
	f1HcD+MHHEw==
X-Google-Smtp-Source: AGHT+IEHJ0y9DwerGn0cGfH2tl2/iQ9m+DbZw0s7ofuBgXsqIAUVCmJGmB0M6GM7f67Ii7UuVLd+XFVSuX63
X-Received: from pfkq22.prod.google.com ([2002:a05:6a00:856:b0:746:2862:2a2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4307:b0:220:78b9:f849
 with SMTP id adf61e73a8af0-220a16a3048mr8852574637.24.1751069390895; Fri, 27
 Jun 2025 17:09:50 -0700 (PDT)
Date: Fri, 27 Jun 2025 17:09:22 -0700
In-Reply-To: <20250628000929.230406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628000929.230406-9-irogers@google.com>
Subject: [PATCH v4 08/15] perf jevents: If the long_desc and desc are
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
index f795883c233f..687288991eb4 100644
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

