Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8313546EF
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470949; cv=none; b=lCjQfVCq60JuVeKjbN7BQWl8qoDSMvAzmNOYIgGmr+Ush5107bGIAiDgNGjovRNtcEMVfZRDl/Rcgy1m183f/we2Oj6oBU2ZtE9Rc5l85Pu2QWhBYrouhFloLGhIbhBeJsaTc1f3aJdA3AYuE3D3ptFWKNn9MebrQcxCBe9JYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470949; c=relaxed/simple;
	bh=kEgo8S9Ge81UJ9aJ1PbrCptBL0vzS+bLzklN+9Czuyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gCu+ZiPqIwPgUXft0JsK9Dye0pDSB0svTboC2vZ8qntGQrNlGRKh4LkXNCYflzH9ZYzk8rYKg2WSb+XfEiLSrUIdCEt1la4u+V3qzJBR7ReLm4XV2Gw/fWakH+v5v2xs/WAzTLmICP9Zr32/s6g9fRkf9bivyUuq6H5cjwyvJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9Xflnfv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9Xflnfv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29085106b99so2978385ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470945; x=1763075745; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3rGOkAl3MPlqpsf8QRH0dYFKaDA5ODLJBs6nMJbY2w=;
        b=H9XflnfvHFc5rOAvlzfk1Q2wE3Cr/i0EClpHNuCdqxki0MJ/lDq7jMXLS1lOJnxFjI
         HHAIYPgoh9Xj6NnusPycXksnLbty9C2vBgcwrqzct0E7QDZsqvrKMCUuYmwGiMbB0nt7
         UvPL4Lwc11XHwzLWgog551Zsk8/tiHkqJGWkaPjCABljmk0wiQ/SFd90roQCXjHxcPYy
         Az2eYyJJxuzIMhjAnnvwVonIUC82z7hTRriPrNSZVjwVaxGWA5OS+iTHEQk/8huzR34O
         XoXSqByNuOt1KwrTaNiwwXzvyshEmItLk4faW7cBqqCZBd3EzAivLS4l+xKvBMRvPdHI
         l4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470945; x=1763075745;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3rGOkAl3MPlqpsf8QRH0dYFKaDA5ODLJBs6nMJbY2w=;
        b=ZBJbGUXb1h2dJwvaEuAn5e5ulg/VcyLaBudPqEROL54I7UwiGCPo4THDV/Q0JNK+LH
         PY3MGv3Qs7vGaONjI7RqZnUEiGRMfifQSP6VsekbqP18jUBZpevTRiapw3izihp6iAcE
         8dguvZavjgKhT28HsCrCxs1xNLE+XE3KKPSAmUlR9Ig8ydFPpIPEJxCKixRlAyOrBdUG
         Q9EghOAEI/Wr6cKJYSPvekl6WqT+oINoDGvFRKEBuKkvoebUXZ2MHBTLU0mogwT5oVaD
         PT6SnE713DbtQwtLKL5+2/iysQHa3ny5zCoTn5yDMwZOo8t42SaTqOH5y7hBgxa/DUlP
         S5kw==
X-Forwarded-Encrypted: i=1; AJvYcCVpLY0aLCpH1OzVN13Qt07vx25g1YXMe/+9aLjJk0DsiNrOQ9UbTl0NYZiuloiRyXUYNDlbUpGwE+GNN+t2+LOY@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyR/3DIp5cfrVAfVKxAdrvvNaNRzNWAyGgPvgNxBVaE6eM1e2
	dx9O+UdZOzkPJ0/Ze9B+PTfiCnPK3S3cIylMjZosP0GO+fnX8rTshx8F5sh8+RSpCEqRuFLiBS5
	m0JnNA8zgtw==
X-Google-Smtp-Source: AGHT+IHv9kUhNACHYCnkLQUtOLrtWHXfWlnfUK2xaata8w75Fdrxz44CHpHcZ5mebrbA05TxZA7MHjz8115a
X-Received: from dlbsn13.prod.google.com ([2002:a05:7022:b90d:b0:119:78ff:fe17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e788:b0:295:592e:7633
 with SMTP id d9443c01a7336-297c045f01amr15140615ad.29.1762470944793; Thu, 06
 Nov 2025 15:15:44 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:53 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-4-irogers@google.com>
Subject: [PATCH v2 03/18] perf jevents: Add set of common metrics based on
 default ones
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add support to getting a common set of metrics from a default
table. It simplifies the generation to add json metrics at the same
time. The metrics added are CPUs_utilized, cs_per_second,
migrations_per_second, page_faults_per_second, insn_per_cycle,
stalled_cycles_per_instruction, frontend_cycles_idle,
backend_cycles_idle, cycles_frequency, branch_frequency and
branch_miss_rate based on the shadow metric definitions.

Following this change the default perf stat output on an alderlake looks li=
ke:
```
$ perf stat -a -- sleep 1

 Performance counter stats for 'system wide':

    28,165,735,434      cpu-clock                        #   27.973 CPUs ut=
ilized
            23,220      context-switches                 #  824.406 /sec
               833      cpu-migrations                   #   29.575 /sec
            35,293      page-faults                      #    1.253 K/sec
       997,341,554      cpu_atom/instructions/           #    0.84  insn pe=
r cycle              (35.63%)
    11,197,053,736      cpu_core/instructions/           #    1.97  insn pe=
r cycle              (58.21%)
     1,184,871,493      cpu_atom/cycles/                 #    0.042 GHz    =
                     (35.64%)
     5,676,692,769      cpu_core/cycles/                 #    0.202 GHz    =
                     (58.22%)
       150,525,309      cpu_atom/branches/               #    5.344 M/sec  =
                     (42.80%)
     2,277,232,030      cpu_core/branches/               #   80.851 M/sec  =
                     (58.21%)
         5,248,575      cpu_atom/branch-misses/          #    3.49% of all =
branches             (42.82%)
        28,829,930      cpu_core/branch-misses/          #    1.27% of all =
branches             (58.22%)
                       (software)                 #    824.4 cs/sec  cs_per=
_second
             TopdownL1 (cpu_core)                 #     12.6 %  tma_bad_spe=
culation
                                                  #     28.8 %  tma_fronten=
d_bound       (66.57%)
             TopdownL1 (cpu_core)                 #     25.8 %  tma_backend=
_bound
                                                  #     32.8 %  tma_retirin=
g             (66.57%)
                       (software)                 #   1253.1 faults/sec  pa=
ge_faults_per_second
                                                  #      0.0 GHz  cycles_fr=
equency       (42.80%)
                                                  #      0.2 GHz  cycles_fr=
equency       (74.92%)
             TopdownL1 (cpu_atom)                 #     22.3 %  tma_bad_spe=
culation
                                                  #     17.2 %  tma_retirin=
g             (49.95%)
             TopdownL1 (cpu_atom)                 #     30.6 %  tma_backend=
_bound
                                                  #     29.8 %  tma_fronten=
d_bound       (49.94%)
                       (cpu_atom)                 #      6.9 K/sec  branch_=
frequency     (42.89%)
                                                  #     80.5 K/sec  branch_=
frequency     (74.93%)
                                                  #     29.6 migrations/sec=
  migrations_per_second
                                                  #     28.0 CPUs  CPUs_uti=
lized
                       (cpu_atom)                 #      0.8 instructions  =
insn_per_cycle  (42.91%)
                                                  #      2.0 instructions  =
insn_per_cycle  (75.14%)
                       (cpu_atom)                 #      3.8 %  branch_miss=
_rate         (35.75%)
                                                  #      1.2 %  branch_miss=
_rate         (66.86%)

       1.007063529 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/common/common/metrics.json           |  86 +++++++++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++-----
 tools/perf/pmu-events/jevents.py              |  21 +++-
 tools/perf/pmu-events/pmu-events.h            |   1 +
 tools/perf/util/metricgroup.c                 |  31 +++--
 5 files changed, 212 insertions(+), 42 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json

diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/=
perf/pmu-events/arch/common/common/metrics.json
new file mode 100644
index 000000000000..d1e37db18dc6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/common/common/metrics.json
@@ -0,0 +1,86 @@
+[
+    {
+        "BriefDescription": "Average CPU utilization",
+        "MetricExpr": "(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #t=
arget_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (duration_=
time * 1e9)",
+        "MetricGroup": "Default",
+        "MetricName": "CPUs_utilized",
+        "ScaleUnit": "1CPUs",
+        "MetricConstraint": "NO_GROUP_EVENTS"
+    },
+    {
+        "BriefDescription": "Context switches per CPU second",
+        "MetricExpr": "(software@context\\-switches\\,name\\=3Dcontext\\-s=
witches@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_=
cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
+        "MetricGroup": "Default",
+        "MetricName": "cs_per_second",
+        "ScaleUnit": "1cs/sec",
+        "MetricConstraint": "NO_GROUP_EVENTS"
+    },
+    {
+        "BriefDescription": "Process migrations to a new CPU per CPU secon=
d",
+        "MetricExpr": "(software@cpu\\-migrations\\,name\\=3Dcpu\\-migrati=
ons@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu =
else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
+        "MetricGroup": "Default",
+        "MetricName": "migrations_per_second",
+        "ScaleUnit": "1migrations/sec",
+        "MetricConstraint": "NO_GROUP_EVENTS"
+    },
+    {
+        "BriefDescription": "Page faults per CPU second",
+        "MetricExpr": "(software@page\\-faults\\,name\\=3Dpage\\-faults@ *=
 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else s=
oftware@task\\-clock\\,name\\=3Dtask\\-clock@)",
+        "MetricGroup": "Default",
+        "MetricName": "page_faults_per_second",
+        "ScaleUnit": "1faults/sec",
+        "MetricConstraint": "NO_GROUP_EVENTS"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "instructions / cpu\\-cycles",
+        "MetricGroup": "Default",
+        "MetricName": "insn_per_cycle",
+        "MetricThreshold": "insn_per_cycle < 1",
+        "ScaleUnit": "1instructions"
+    },
+    {
+        "BriefDescription": "Max front or backend stalls per instruction",
+        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\\=
-backend) / instructions",
+        "MetricGroup": "Default",
+        "MetricName": "stalled_cycles_per_instruction"
+    },
+    {
+        "BriefDescription": "Frontend stalls per cycle",
+        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
+        "MetricGroup": "Default",
+        "MetricName": "frontend_cycles_idle",
+        "MetricThreshold": "frontend_cycles_idle > 0.1"
+    },
+    {
+        "BriefDescription": "Backend stalls per cycle",
+        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
+        "MetricGroup": "Default",
+        "MetricName": "backend_cycles_idle",
+        "MetricThreshold": "backend_cycles_idle > 0.2"
+    },
+    {
+        "BriefDescription": "Cycles per CPU second",
+        "MetricExpr": "cpu\\-cycles / (software@cpu\\-clock\\,name\\=3Dcpu=
\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock=
@)",
+        "MetricGroup": "Default",
+        "MetricName": "cycles_frequency",
+        "ScaleUnit": "1GHz",
+        "MetricConstraint": "NO_GROUP_EVENTS"
+    },
+    {
+        "BriefDescription": "Branches per CPU second",
+        "MetricExpr": "branches / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
+        "MetricGroup": "Default",
+        "MetricName": "branch_frequency",
+        "ScaleUnit": "1000K/sec",
+        "MetricConstraint": "NO_GROUP_EVENTS"
+    },
+    {
+        "BriefDescription": "Branch miss rate",
+        "MetricExpr": "branch\\-misses / branches",
+        "MetricGroup": "Default",
+        "MetricName": "branch_miss_rate",
+        "MetricThreshold": "branch_miss_rate > 0.05",
+        "ScaleUnit": "100%"
+    }
+]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 5120fb93690e..83a01ecc625e 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1303,21 +1303,32 @@ static const char *const big_c_string =3D
 /* offset=3D127503 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
 /* offset=3D127580 */ "uncore_sys_cmn_pmu\000"
 /* offset=3D127599 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D127742 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D127764 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\00000"
-/* offset=3D127827 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
-/* offset=3D127993 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D128057 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\00000"
-/* offset=3D128124 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\00000"
-/* offset=3D128195 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
-/* offset=3D128289 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\00000"
-/* offset=3D128423 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\00000"
-/* offset=3D128487 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D128555 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
-/* offset=3D128625 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D128647 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
0"
-/* offset=3D128669 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
-/* offset=3D128689 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\00000"
+/* offset=3D127742 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\00001"
+/* offset=3D127927 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
00001"
+/* offset=3D128159 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\00001"
+/* offset=3D128418 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
0001"
+/* offset=3D128648 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\00000"
+/* offset=3D128760 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\00000"
+/* offset=3D128923 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\00000"
+/* offset=3D129052 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\00000"
+/* offset=3D129177 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\00001"
+/* offset=3D129352 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/s=
ec\000\000\000\00001"
+/* offset=3D129531 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\00000"
+/* offset=3D129634 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
0"
+/* offset=3D129656 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\00000"
+/* offset=3D129719 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
+/* offset=3D129885 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D129949 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\00000"
+/* offset=3D130016 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\00000"
+/* offset=3D130087 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000"
+/* offset=3D130181 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\00000"
+/* offset=3D130315 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\00000"
+/* offset=3D130379 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D130447 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
+/* offset=3D130517 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
0"
+/* offset=3D130539 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
0"
+/* offset=3D130561 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00000"
+/* offset=3D130581 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\00000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2603,6 +2614,29 @@ static const struct pmu_table_entry pmu_events__comm=
on[] =3D {
 },
 };
=20
+static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
+{ 127742 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\00001 */
+{ 129052 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\00000 */
+{ 129352 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000\0=
00\000\00001 */
+{ 129531 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
 */
+{ 127927 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 */
+{ 129177 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\00001 */
+{ 128923 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\00000 */
+{ 128648 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\00000 */
+{ 128159 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\00001 */
+{ 128418 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
+{ 128760 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\00000 */
+
+};
+
+static const struct pmu_table_entry pmu_metrics__common[] =3D {
+{
+     .entries =3D pmu_metrics__common_default_core,
+     .num_entries =3D ARRAY_SIZE(pmu_metrics__common_default_core),
+     .pmu_name =3D { 0 /* default_core\000 */ },
+},
+};
+
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
 { 126189 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
 { 126251 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
@@ -2664,21 +2698,21 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 127742 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
-{ 128423 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\00000 */
-{ 128195 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
-{ 128289 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\00000 */
-{ 128487 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
-{ 128555 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
-{ 127827 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
-{ 127764 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\00000 */
-{ 128689 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\00000 */
-{ 128625 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
-{ 128647 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
-{ 128669 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
-{ 128124 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
-{ 127993 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
-{ 128057 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
+{ 129634 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
+{ 130315 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\00000 */
+{ 130087 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
+{ 130181 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\00000 */
+{ 130379 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\00000 */
+{ 130447 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
+{ 129719 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
+{ 129656 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\00000 */
+{ 130581 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\00000 */
+{ 130517 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
+{ 130539 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
+{ 130561 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
+{ 130016 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\00000 */
+{ 129885 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\00000 */
+{ 129949 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\00000 */
=20
 };
=20
@@ -2759,7 +2793,10 @@ static const struct pmu_events_map pmu_events_map[] =
=3D {
 		.pmus =3D pmu_events__common,
 		.num_pmus =3D ARRAY_SIZE(pmu_events__common),
 	},
-	.metric_table =3D {},
+	.metric_table =3D {
+		.pmus =3D pmu_metrics__common,
+		.num_pmus =3D ARRAY_SIZE(pmu_metrics__common),
+	},
 },
 {
 	.arch =3D "testarch",
@@ -3208,6 +3245,22 @@ const struct pmu_metrics_table *pmu_metrics_table__f=
ind(void)
         return map ? &map->metric_table : NULL;
 }
=20
+const struct pmu_metrics_table *pmu_metrics_table__default(void)
+{
+        int i =3D 0;
+
+        for (;;) {
+                const struct pmu_events_map *map =3D &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->metric_table;
+        }
+        return NULL;
+}
+
 const struct pmu_events_table *find_core_events_table(const char *arch, co=
nst char *cpuid)
 {
         for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index 786a7049363f..5d3f4b44cfb7 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -755,7 +755,10 @@ static const struct pmu_events_map pmu_events_map[] =
=3D {
 \t\t.pmus =3D pmu_events__common,
 \t\t.num_pmus =3D ARRAY_SIZE(pmu_events__common),
 \t},
-\t.metric_table =3D {},
+\t.metric_table =3D {
+\t\t.pmus =3D pmu_metrics__common,
+\t\t.num_pmus =3D ARRAY_SIZE(pmu_metrics__common),
+\t},
 },
 """)
     else:
@@ -1237,6 +1240,22 @@ const struct pmu_metrics_table *pmu_metrics_table__f=
ind(void)
         return map ? &map->metric_table : NULL;
 }
=20
+const struct pmu_metrics_table *pmu_metrics_table__default(void)
+{
+        int i =3D 0;
+
+        for (;;) {
+                const struct pmu_events_map *map =3D &pmu_events_map[i++];
+
+                if (!map->arch)
+                        break;
+
+                if (!strcmp(map->cpuid, "common"))
+                        return &map->metric_table;
+        }
+        return NULL;
+}
+
 const struct pmu_events_table *find_core_events_table(const char *arch, co=
nst char *cpuid)
 {
         for (const struct pmu_events_map *tables =3D &pmu_events_map[0];
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu=
-events.h
index e0535380c0b2..559265a903c8 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -127,6 +127,7 @@ int pmu_metrics_table__find_metric(const struct pmu_met=
rics_table *table,
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu=
 *pmu);
 const struct pmu_events_table *perf_pmu__default_core_events_table(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
+const struct pmu_metrics_table *pmu_metrics_table__default(void);
 const struct pmu_events_table *find_core_events_table(const char *arch, co=
nst char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, =
const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 76092ee26761..e67e04ce01c9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -424,10 +424,18 @@ int metricgroup__for_each_metric(const struct pmu_met=
rics_table *table, pmu_metr
 		.fn =3D fn,
 		.data =3D data,
 	};
+	const struct pmu_metrics_table *tables[2] =3D {
+		table,
+		pmu_metrics_table__default(),
+	};
+
+	for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
+		int ret;
=20
-	if (table) {
-		int ret =3D pmu_metrics_table__for_each_metric(table, fn, data);
+		if (!tables[i])
+			continue;
=20
+		ret =3D pmu_metrics_table__for_each_metric(tables[i], fn, data);
 		if (ret)
 			return ret;
 	}
@@ -1581,19 +1589,22 @@ static int metricgroup__has_metric_or_groups_callba=
ck(const struct pmu_metric *p
=20
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric=
_or_groups)
 {
-	const struct pmu_metrics_table *table =3D pmu_metrics_table__find();
+	const struct pmu_metrics_table *tables[2] =3D {
+		pmu_metrics_table__find(),
+		pmu_metrics_table__default(),
+	};
 	struct metricgroup__has_metric_data data =3D {
 		.pmu =3D pmu,
 		.metric_or_groups =3D metric_or_groups,
 	};
=20
-	if (!table)
-		return false;
-
-	return pmu_metrics_table__for_each_metric(table,
-						  metricgroup__has_metric_or_groups_callback,
-						  &data)
-		? true : false;
+	for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
+		if (pmu_metrics_table__for_each_metric(tables[i],
+							metricgroup__has_metric_or_groups_callback,
+							&data))
+			return true;
+	}
+	return false;
 }
=20
 static int metricgroup__topdown_max_level_callback(const struct pmu_metric=
 *pm,
--=20
2.51.2.1041.gc1ab5b90ca-goog

