Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518555644E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Oct 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839244; cv=none; b=oePpyhZMscp2h2fkV8jqzioKeDlH/8sjIFNrMkXT+O7nnNYKZTfCItpOiyGQjdpZf0CzmHvn+PKVYLJUJ9wX4mZNX+kzsC9/XUMZP8QszSF0K11xdu8gsOU+//+O9m+6w/I1HRmoG872D2xuXUeFkWzLT2S56hk2dPogCKJU/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839244; c=relaxed/simple;
	bh=/bk2X1mEjBnO/58ncGztLNXEHUh2XE6RXX7qE9l/E+w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jdLfmMFfCq94ro9pB/Nej0WYf1fLNVfEiMCMQ0A4Vq0KQ0lILPmWC0YISkTJARgFkEo4DPTVoNZa0lNyfq7oG0ROOYtse4OA6m7PNvhx54KcMWUOQFErdXBQypRPktzoYa9+d3A6ZeV8eFriD7lLpWMqbPRxhE/ovcYjlSP23uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J295WeYs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J295WeYs"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25b39871fso62901707b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 20:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839241; x=1728444041; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2j+PdhSRd6WvrLriDoC1695XR9/14hLFVY0i3VO90/s=;
        b=J295WeYswUEC1CvJ6RgUQHFZ1wR1GUhS5V3LX2Y110YHVW1RFMpUsYgbzRnGgWCoKO
         ZsuhXjKcYMYmj5V4SOBDgrCZKpgb5fc6zB0eKLhTyndimwSxXIpQQMC6pdD9EZxlh8vo
         bRgms0MVCWa0v6wnrhF2UkI5wLuU7NxQh0yI/fkDunmZ21/hiZFxrL3OxgV2vCCZTlU5
         LYz6BF39L9xuPnwTDZPt9qfTgQLqKXHyJGe5ypmMxpoWA1Uya0NPs730JGC/+Idlhe1l
         AuxSH6yVT4b1o7xRqyOz5YbqpOApfmD7JVn8qTzngQruK0g4YEDZ/64LtsnMg5QbZ4Os
         evcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839241; x=1728444041;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2j+PdhSRd6WvrLriDoC1695XR9/14hLFVY0i3VO90/s=;
        b=XdsD9M1fZN3WnHUFXQ6+0EC5Qzjl5xtpCU8dzHq1qJ2Ju4ZD2wWYnShdFFm9rJAzdl
         BrfXbHpyAgY0uwbZfJd5xvVQVHHwJqh0bEEKSviLGfkhiZPH9faDiyjFMIqwMLY7581+
         PZUc+r0lcg/JN2zfHSw2UEECcOtcXfDaVRI4dULqY+1Nt1pYm3EXjeF5HiPBhV8/w2mY
         yGskNcslfXOcKvsH0ptPPOPa3jPcJeYNKwEvvGZnshmAgPdjtReioOHVbU6CMyaN0emC
         K9q3JEplL8sQPimUmBT0mxkbiKKsd7D3cJADJ1NujFj2Zax4vEEzSjaUnuwVIlh2mXYo
         NtHA==
X-Forwarded-Encrypted: i=1; AJvYcCVyr2+WwlUccEbmdjslRxbPtyXxyz2QVdENKClaJ4tOtA86mHvnILmRyVNnVBz6hzIaeer58pYfmlo61caGhO6l@vger.kernel.org
X-Gm-Message-State: AOJu0YxJV9YSW2XZUusDIznVTDDYJUmwPooaOYG1uyU93zgxxAPGk5UI
	StDMdzQCctYbK34G9BcRwyMesSfG0Hk1yZ0PFnfCuVCdwAXDtTXtMhdwFULo/sczJPjrIhWMaIA
	4p0P/ZQ==
X-Google-Smtp-Source: AGHT+IGCLpcpjQp7WooQYlBENclXT9yRcpl0p3hmwAHF0WuRZvIV5EBWryWkmtprfb9wcow1BqHDtqSYPKIM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcb:b0:6e2:120b:be57 with SMTP id
 00721157ae682-6e2a2e05268mr512997b3.5.1727839241194; Tue, 01 Oct 2024
 20:20:41 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:11 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 08/13] perf jevents: Add tool event json under a common architecture
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduce the notion of a common architecture/model that can be used
to find event tables for common PMUs like the tool PMU. By having tool
events be json standard PMU attribute configuration, descriptions,
etc. can be used and these routines are already optimized for things
like binary searching.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 .../pmu-events/arch/common/common/tool.json   |  74 +++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 208 +++++++++++-------
 tools/perf/pmu-events/jevents.py              |  16 +-
 3 files changed, 215 insertions(+), 83 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json

diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
new file mode 100644
index 000000000000..12f2ef1813a6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -0,0 +1,74 @@
+[
+  {
+    "Unit": "tool",
+    "EventName": "duration_time",
+    "BriefDescription": "Wall clock interval time in nanoseconds",
+    "ConfigCode": "1"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "user_time",
+    "BriefDescription": "User (non-kernel) time in nanoseconds",
+    "ConfigCode": "2"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "system_time",
+    "BriefDescription": "System/kernel time in nanoseconds",
+    "ConfigCode": "3"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "has_pmem",
+    "BriefDescription": "1 if persistent memory installed otherwise 0",
+    "ConfigCode": "4"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "num_cores",
+    "BriefDescription": "Number of cores. A core consists of 1 or more thr=
ead, with each thread being associated with a logical Linux CPU",
+    "ConfigCode": "5"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "num_cpus",
+    "BriefDescription": "Number of logical Linux CPUs. There may be multip=
le such CPUs on a core",
+    "ConfigCode": "6"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "num_cpus_online",
+    "BriefDescription": "Number of online logical Linux CPUs. There may be=
 multiple such CPUs on a core",
+    "ConfigCode": "7"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "num_dies",
+    "BriefDescription": "Number of dies. Each die has 1 or more cores",
+    "ConfigCode": "8"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "num_packages",
+    "BriefDescription": "Number of packages. Each package has 1 or more di=
e",
+    "ConfigCode": "9"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "slots",
+    "BriefDescription": "Number of functional units that in parallel can e=
xecute parts of an instruction",
+    "ConfigCode": "10"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "smt_on",
+    "BriefDescription": "1 if simultaneous multithreading (aka hyperthread=
ing) is enable otherwise 0",
+    "ConfigCode": "11"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "system_tsc_freq",
+    "BriefDescription": "The amount a Time Stamp Counter (TSC) increases p=
er second",
+    "ConfigCode": "12"
+  }
+]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index c592079982fb..47ed8b03e445 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -19,72 +19,109 @@ struct pmu_table_entry {
 };
=20
 static const char *const big_c_string =3D
-/* offset=3D0 */ "default_core\000"
-/* offset=3D13 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000eve=
nt=3D0x8a\000\00000\000\000"
-/* offset=3D72 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000eve=
nt=3D0x8b\000\00000\000\000"
-/* offset=3D131 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=
=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"
-/* offset=3D226 */ "segment_reg_loads.any\000other\000Number of segment re=
gister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000"
-/* offset=3D325 */ "dispatch_blocked.any\000other\000Memory cluster signal=
s to block micro-op dispatch for any reason\000event=3D9,period=3D200000,um=
ask=3D0x20\000\00000\000\000"
-/* offset=3D455 */ "eist_trans\000other\000Number of Enhanced Intel SpeedS=
tep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00=
000\000\000"
-/* offset=3D570 */ "hisi_sccl,ddrc\000"
-/* offset=3D585 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write com=
mands\000event=3D2\000\00000\000DDRC write commands\000"
-/* offset=3D671 */ "uncore_cbox\000"
-/* offset=3D683 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cro=
ss-core snoop resulted from L3 Eviction which misses in some processor core=
\000event=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from=
 L3 Eviction which misses in some processor core\000"
-/* offset=3D914 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0x=
e0\000\00000\000UNC_CBO_HYPHEN\000"
-/* offset=3D979 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000UNC_CBO_TWO_HYPH\000"
-/* offset=3D1050 */ "hisi_sccl,l3c\000"
-/* offset=3D1064 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000Total read hits\000"
-/* offset=3D1144 */ "uncore_imc_free_running\000"
-/* offset=3D1168 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000Total cache misses\000"
-/* offset=3D1263 */ "uncore_imc\000"
-/* offset=3D1274 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000Total cache hits\000"
-/* offset=3D1352 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D1371 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000"
-/* offset=3D1444 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D1463 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000"
-/* offset=3D1537 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D1556 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000"
-/* offset=3D1696 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
-/* offset=3D1718 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
-/* offset=3D1781 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=3D1947 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D2011 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D2078 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3D2149 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3D2243 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
-/* offset=3D2377 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3D2441 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D2509 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D2579 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
-/* offset=3D2601 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
-/* offset=3D2623 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3D2643 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
+/* offset=3D0 */ "tool\000"
+/* offset=3D5 */ "duration_time\000tool\000Wall clock interval time in nan=
oseconds\000config=3D1\000\00000\000\000"
+/* offset=3D78 */ "user_time\000tool\000User (non-kernel) time in nanoseco=
nds\000config=3D2\000\00000\000\000"
+/* offset=3D145 */ "system_time\000tool\000System/kernel time in nanosecon=
ds\000config=3D3\000\00000\000\000"
+/* offset=3D210 */ "has_pmem\000tool\0001 if persistent memory installed o=
therwise 0\000config=3D4\000\00000\000\000"
+/* offset=3D283 */ "num_cores\000tool\000Number of cores. A core consists =
of 1 or more thread, with each thread being associated with a logical Linux=
 CPU\000config=3D5\000\00000\000\000"
+/* offset=3D425 */ "num_cpus\000tool\000Number of logical Linux CPUs. Ther=
e may be multiple such CPUs on a core\000config=3D6\000\00000\000\000"
+/* offset=3D525 */ "num_cpus_online\000tool\000Number of online logical Li=
nux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000=
\000\000"
+/* offset=3D639 */ "num_dies\000tool\000Number of dies. Each die has 1 or =
more cores\000config=3D8\000\00000\000\000"
+/* offset=3D712 */ "num_packages\000tool\000Number of packages. Each packa=
ge has 1 or more die\000config=3D9\000\00000\000\000"
+/* offset=3D795 */ "slots\000tool\000Number of functional units that in pa=
rallel can execute parts of an instruction\000config=3D0xa\000\00000\000\00=
0"
+/* offset=3D902 */ "smt_on\000tool\0001 if simultaneous multithreading (ak=
a hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000"
+/* offset=3D1006 */ "system_tsc_freq\000tool\000The amount a Time Stamp Co=
unter (TSC) increases per second\000config=3D0xc\000\00000\000\000"
+/* offset=3D1102 */ "default_core\000"
+/* offset=3D1115 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000e=
vent=3D0x8a\000\00000\000\000"
+/* offset=3D1174 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000e=
vent=3D0x8b\000\00000\000\000"
+/* offset=3D1233 */ "l3_cache_rd\000cache\000L3 cache access, read\000even=
t=3D0x40\000\00000\000Attributable Level 3 cache access, read\000"
+/* offset=3D1328 */ "segment_reg_loads.any\000other\000Number of segment r=
egister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000"
+/* offset=3D1427 */ "dispatch_blocked.any\000other\000Memory cluster signa=
ls to block micro-op dispatch for any reason\000event=3D9,period=3D200000,u=
mask=3D0x20\000\00000\000\000"
+/* offset=3D1557 */ "eist_trans\000other\000Number of Enhanced Intel Speed=
Step(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\0=
0000\000\000"
+/* offset=3D1672 */ "hisi_sccl,ddrc\000"
+/* offset=3D1687 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000DDRC write commands\000"
+/* offset=3D1773 */ "uncore_cbox\000"
+/* offset=3D1785 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted fro=
m L3 Eviction which misses in some processor core\000"
+/* offset=3D2016 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000UNC_CBO_HYPHEN\000"
+/* offset=3D2081 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000UNC_CBO_TWO_HYPH\000"
+/* offset=3D2152 */ "hisi_sccl,l3c\000"
+/* offset=3D2166 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000Total read hits\000"
+/* offset=3D2246 */ "uncore_imc_free_running\000"
+/* offset=3D2270 */ "uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000Total cache misses\000"
+/* offset=3D2365 */ "uncore_imc\000"
+/* offset=3D2376 */ "uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000Total cache hits\000"
+/* offset=3D2454 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D2473 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000"
+/* offset=3D2546 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D2565 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000"
+/* offset=3D2639 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D2658 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000"
+/* offset=3D2798 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000"
+/* offset=3D2820 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000"
+/* offset=3D2883 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=3D3049 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D3113 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D3180 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=3D3251 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=3D3345 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000"
+/* offset=3D3479 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000"
+/* offset=3D3543 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D3611 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D3681 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00000"
+/* offset=3D3703 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00000"
+/* offset=3D3725 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=3D3745 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000"
 ;
=20
+static const struct compact_pmu_event pmu_events__common_tool[] =3D {
+{ 5 }, /* duration_time\000tool\000Wall clock interval time in nanoseconds=
\000config=3D1\000\00000\000\000 */
+{ 210 }, /* has_pmem\000tool\0001 if persistent memory installed otherwise=
 0\000config=3D4\000\00000\000\000 */
+{ 283 }, /* num_cores\000tool\000Number of cores. A core consists of 1 or =
more thread, with each thread being associated with a logical Linux CPU\000=
config=3D5\000\00000\000\000 */
+{ 425 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may be=
 multiple such CPUs on a core\000config=3D6\000\00000\000\000 */
+{ 525 }, /* num_cpus_online\000tool\000Number of online logical Linux CPUs=
. There may be multiple such CPUs on a core\000config=3D7\000\00000\000\000=
 */
+{ 639 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more cor=
es\000config=3D8\000\00000\000\000 */
+{ 712 }, /* num_packages\000tool\000Number of packages. Each package has 1=
 or more die\000config=3D9\000\00000\000\000 */
+{ 795 }, /* slots\000tool\000Number of functional units that in parallel c=
an execute parts of an instruction\000config=3D0xa\000\00000\000\000 */
+{ 902 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hypert=
hreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000 */
+{ 145 }, /* system_time\000tool\000System/kernel time in nanoseconds\000co=
nfig=3D3\000\00000\000\000 */
+{ 1006 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counter (T=
SC) increases per second\000config=3D0xc\000\00000\000\000 */
+{ 78 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\000c=
onfig=3D2\000\00000\000\000 */
+
+};
+
+const struct pmu_table_entry pmu_events__common[] =3D {
+{
+     .entries =3D pmu_events__common_tool,
+     .num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
+     .pmu_name =3D { 0 /* tool\000 */ },
+},
+};
+
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
-{ 13 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8=
a\000\00000\000\000 */
-{ 72 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8=
b\000\00000\000\000 */
-{ 325 }, /* dispatch_blocked.any\000other\000Memory cluster signals to blo=
ck micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x=
20\000\00000\000\000 */
-{ 455 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) T=
echnology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\=
000 */
-{ 131 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\=
000\00000\000Attributable Level 3 cache access, read\000 */
-{ 226 }, /* segment_reg_loads.any\000other\000Number of segment register l=
oads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000 */
+{ 1115 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0=
x8a\000\00000\000\000 */
+{ 1174 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0=
x8b\000\00000\000\000 */
+{ 1427 }, /* dispatch_blocked.any\000other\000Memory cluster signals to bl=
ock micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=3D0=
x20\000\00000\000\000 */
+{ 1557 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) =
Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000=
\000 */
+{ 1233 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40=
\000\00000\000Attributable Level 3 cache access, read\000 */
+{ 1328 }, /* segment_reg_loads.any\000other\000Number of segment register =
loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 585 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\00=
0event=3D2\000\00000\000DDRC write commands\000 */
+{ 1687 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\0=
00event=3D2\000\00000\000DDRC write commands\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 1064 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000Total read hits\000 */
+{ 2166 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000=
event=3D7\000\00000\000Total read hits\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 914 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\0=
0000\000UNC_CBO_HYPHEN\000 */
-{ 979 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\0=
00\00000\000UNC_CBO_TWO_HYPH\000 */
-{ 683 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core =
snoop resulted from L3 Eviction which misses in some processor core\000even=
t=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from L3 Evic=
tion which misses in some processor core\000 */
+{ 2016 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\=
00000\000UNC_CBO_HYPHEN\000 */
+{ 2081 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\=
000\00000\000UNC_CBO_TWO_HYPH\000 */
+{ 1785 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core=
 snoop resulted from L3 Eviction which misses in some processor core\000eve=
nt=3D0x22,umask=3D0x81\000\00000\000A cross-core snoop resulted from L3 Evi=
ction which misses in some processor core\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 1274 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000Total cache hits\000 */
+{ 2376 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=
=3D0x34\000\00000\000Total cache hits\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 1168 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000Total cache misses\000 */
+{ 2270 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache m=
isses\000event=3D0x12\000\00000\000Total cache misses\000 */
=20
 };
=20
@@ -92,51 +129,51 @@ const struct pmu_table_entry pmu_events__test_soc_cpu[=
] =3D {
 {
      .entries =3D pmu_events__test_soc_cpu_default_core,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core),
-     .pmu_name =3D { 0 /* default_core\000 */ },
+     .pmu_name =3D { 1102 /* default_core\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name =3D { 570 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name =3D { 1672 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 1050 /* hisi_sccl,l3c\000 */ },
+     .pmu_name =3D { 2152 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 671 /* uncore_cbox\000 */ },
+     .pmu_name =3D { 1773 /* uncore_cbox\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 1263 /* uncore_imc\000 */ },
+     .pmu_name =3D { 2365 /* uncore_imc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 1144 /* uncore_imc_free_running\000 */ },
+     .pmu_name =3D { 2246 /* uncore_imc_free_running\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 1696 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 2377 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
-{ 2149 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 2243 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
-{ 2441 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
-{ 2509 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
-{ 1781 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 1718 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
-{ 2643 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
-{ 2579 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 2601 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
-{ 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
-{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
+{ 2798 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 3479 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\=
000\000\000\000\000\000\000\00000 */
+{ 3251 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rq=
sts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 3345 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l=
2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\0=
00\000\000\000\000\000\00000 */
+{ 3543 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_A=
ll)\000\000\000\000\000\000\000\00000 */
+{ 3611 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
+{ 2883 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * =
(cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cp=
u_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 2820 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\0=
00\000\000\000\000\000\000\00000 */
+{ 3745 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duratio=
n_time\000\000\000\000\000\000\000\00000 */
+{ 3681 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 3703 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 3725 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 3180 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
+{ 3049 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
+{ 3113 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
=20
 };
=20
@@ -144,18 +181,18 @@ const struct pmu_table_entry pmu_metrics__test_soc_cp=
u[] =3D {
 {
      .entries =3D pmu_metrics__test_soc_cpu_default_core,
      .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_core),
-     .pmu_name =3D { 0 /* default_core\000 */ },
+     .pmu_name =3D { 1102 /* default_core\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 1463 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000 */
+{ 2565 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\00=
0config=3D0x2c\0000x01\00000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 1556 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000 */
+{ 2658 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache mi=
sses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(434=
|436|43c|43a).*\00000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 1371 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000 */
+{ 2473 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\=
000event=3D0x2b\000v8\00000\000\000 */
=20
 };
=20
@@ -163,17 +200,17 @@ const struct pmu_table_entry pmu_events__test_soc_sys=
[] =3D {
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 1444 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name =3D { 2546 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 1537 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name =3D { 2639 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 1352 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name =3D { 2454 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
=20
@@ -210,6 +247,15 @@ struct pmu_events_map {
  * table of PMU events.
  */
 const struct pmu_events_map pmu_events_map[] =3D {
+{
+	.arch =3D "common",
+	.cpuid =3D "common",
+	.event_table =3D {
+		.pmus =3D pmu_events__common,
+		.num_pmus =3D ARRAY_SIZE(pmu_events__common),
+	},
+	.metric_table =3D {},
+},
 {
 	.arch =3D "testarch",
 	.cpuid =3D "testcpu",
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index bb0a5d92df4a..3d2c4e6efeb4 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -292,6 +292,7 @@ class JsonEvent:
           'cpu_atom': 'cpu_atom',
           'ali_drw': 'ali_drw',
           'arm_cmn': 'arm_cmn',
+          'tool': 'tool',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
=20
@@ -721,6 +722,17 @@ const struct pmu_events_map pmu_events_map[] =3D {
 \t\t.num_pmus =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu),
 \t}
 },
+""")
+    elif arch =3D=3D 'common':
+      _args.output_file.write("""{
+\t.arch =3D "common",
+\t.cpuid =3D "common",
+\t.event_table =3D {
+\t\t.pmus =3D pmu_events__common,
+\t\t.num_pmus =3D ARRAY_SIZE(pmu_events__common),
+\t},
+\t.metric_table =3D {},
+},
 """)
     else:
       with open(f'{_args.starting_dir}/{arch}/mapfile.csv') as csvfile:
@@ -1241,7 +1253,7 @@ def main() -> None:
         if len(parents) =3D=3D _args.model.split(',')[0].count('/'):
           # We're testing the correct directory.
           item_path =3D '/'.join(parents) + ('/' if len(parents) > 0 else =
'') + item.name
-          if 'test' not in item_path and item_path not in _args.model.spli=
t(','):
+          if 'test' not in item_path and 'common' not in item_path and ite=
m_path not in _args.model.split(','):
             continue
       action(parents, item)
       if item.is_dir():
@@ -1289,7 +1301,7 @@ struct pmu_table_entry {
   for item in os.scandir(_args.starting_dir):
     if not item.is_dir():
       continue
-    if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.name=
 =3D=3D 'test':
+    if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.name=
 =3D=3D 'test' or item.name =3D=3D 'common':
       archs.append(item.name)
=20
   if len(archs) < 2 and _args.arch !=3D 'none':
--=20
2.46.1.824.gd892dcdcdd-goog

