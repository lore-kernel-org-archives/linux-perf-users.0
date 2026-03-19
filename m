Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6591A9B46
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882070; cv=none; b=DuJUsdY7woM8OmitvMtAQNmUPITDYzpA3Ag+l7Ak4/aR1F7MWS67iyFq2jwVz5lfaGgRVnHs9OV3KGkbrWc7UkISeK9PrESmHs2tCuiMbFPQraeO4zGPwmUeqSDbZ+Tz2zrY7OeMzvT/UalkkH6o/2EpA8n4vzakhhecyn7qb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882070; c=relaxed/simple;
	bh=nBpQQmln3h68mueEStlNAP9MLGkLWGd920aNDOCUdV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJOlaHRKYrfrMQWFpfd/Z4QtSOSWK4TnfOuEVYmRy4biSOt0I1DMqYu+P5PBx+OppLK4suAxKIQjOuoEw9OBZXXlVZVgnhVH0pJWohjHe0iDBlHOPudRWUFIeyeSMVog5xvHGlzZytMECfvOGzvbDRvuEz0zfyj6l2c58Bd0IEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZ2EFhZK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZ2EFhZK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128edc72e5bso2072344c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773882066; x=1774486866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHyu10m31rt4yID0dgVUsXszWZbquQZGf7tMDuZJnvw=;
        b=dZ2EFhZKKaZVIa2N70ChEH6dG0Uu6MjWHdDSw4hz8rIeYw8zSgney0eLHb0edkVUGb
         Di0KZeir1WpHiB5/fqcvjp+M4GOCBAMxks8CWuc+ACj5AEvrxUHElf8bDqGuyvoig5wb
         oSevdBBTOvBPwGDiT7d0lrSN2I+on/D+4K1fYBPkYK9WFGLhqyaIsTIhro7x6nvWz2S8
         zvrrKDwj3LJUNG5iEBvqINMb/W9HmaLTD1p1tb85PJEcsUPylBrh8rQnYkCP7w/5mEKa
         iIN/ULfnMCJXnwPbhDMfDyxasx+2ktWFZ5DhfVIXY6jLbXdOgyXQabL5DahGIiA5lP/N
         c7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773882066; x=1774486866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHyu10m31rt4yID0dgVUsXszWZbquQZGf7tMDuZJnvw=;
        b=lBhzt7dtPEalWwbhdsbUa281bLsxg9NmL4yyHT1n4CAfNTvkWg9j5o95lzusXRJdCN
         QHKN31HYgsQoag8XkzSb0juX6sE/0n6146emDZr7JP68usBviL7CRIM743Oywtyz5Ecf
         iLbZdyvP+XKeGxyLRWMjFUepmLOKY3Gm2jIByxdkevfQYMxrpYxOxaiB3CBDCWnwQnsu
         XZ5HeYbFeQJzAPDoBaNmwAzfwQIh+PwiX0WLpXNnRgN6l45ffregrlgtWkrMokP6XtDD
         +AzCDdgzwJxrFbl5oRff4KIGTloSfRa3Ndu4jMPLY0XbQcZq39hvsT6eD+lShuhV20Ph
         QVKA==
X-Forwarded-Encrypted: i=1; AJvYcCX8FArWQAoLb5D4RRkBBt+Ai0TssDIdic8fzbEi0kgc1WgwhU39IeD6vwzlH6VO6+/vc9VxipTEjsqKdtTd6bb+@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtV0uQA1XLejle5W4StPwqyAVdwwoRy4aP+NWA+YhEjMlu1XS
	sJn7MZnlYBcxfcc05ysmnF5sxVUMpq5NtAcGBvAFPv5haodjrgfPBI9D5Z/v8/+wz4imENtQqFe
	vF3lnA0aFXQ==
X-Received: from dlbrn2.prod.google.com ([2002:a05:7022:1502:b0:128:ed1b:481d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:438a:b0:128:d174:6382
 with SMTP id a92af1059eb24-129a70f91d9mr3186903c88.9.1773882066163; Wed, 18
 Mar 2026 18:01:06 -0700 (PDT)
Date: Wed, 18 Mar 2026 18:01:03 -0700
In-Reply-To: <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260319010103.834106-1-irogers@google.com>
Subject: [PATCH v1] perf metrics: Make common stalled metrics conditional on
 having the event
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: irogers@google.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The metric code uses the event parsing code but it generally assumes
all events are supported. Arnaldo reported AMD supporting
stalled-cycles-frontend but not stalled-cycles-backend [1]. An issue
with this is that before parsing happens the metric code tries to
share events within groups to reduce the number of events and
multiplexing. If the group has some supported and not supported
events, the whole group will become broken. To avoid this situation
add has_event tests to the metrics for stalled-cycles-frontend and
stalled-cycles-backend. has_events is evaluated when parsing the
metric and its result constant propagated (with if-elses) to reduce
the number of events. This means when the metric code considers
sharing the events, only supported events will be shared.

Note for backporting. This change updates
tools/perf/pmu-events/empty-pmu-events.c a convenience file for builds
on systems without python present. While the metrics.json code should
backport easily there can be conflicts on empty-pmu-events.c. In this
case the build will have left a file test-empty-pmu-events.c that can
be copied over empty-pmu-events.c to resolve issues and make an
appropriate empty-pmu-events.c for the json in the source tree at the
time of the build.

[1] https://lore.kernel.org/lkml/abm1nR-2xjOUBroD@x1/

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/abm1nR-2xjOUBroD@x1/
Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on defa=
ult ones")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/common/common/metrics.json           |   6 +-
 tools/perf/pmu-events/empty-pmu-events.c      | 108 +++++++++---------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tools/=
perf/pmu-events/arch/common/common/metrics.json
index 0d010b3ebc6d..cefc8bfe7830 100644
--- a/tools/perf/pmu-events/arch/common/common/metrics.json
+++ b/tools/perf/pmu-events/arch/common/common/metrics.json
@@ -46,14 +46,14 @@
     },
     {
         "BriefDescription": "Max front or backend stalls per instruction",
-        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\\=
-backend) / instructions",
+        "MetricExpr": "(max(stalled\\-cycles\\-frontend, stalled\\-cycles\=
\-backend) / instructions) if (has_event(stalled\\-cycles\\-frontend) & has=
_event(stalled\\-cycles\\-backend)) else ((stalled\\-cycles\\-frontend / in=
structions) if has_event(stalled\\-cycles\\-frontend) else ((stalled\\-cycl=
es\\-backend / instructions) if has_event(stalled\\-cycles\\-backend) else =
0))",
         "MetricGroup": "Default",
         "MetricName": "stalled_cycles_per_instruction",
         "DefaultShowEvents": "1"
     },
     {
         "BriefDescription": "Frontend stalls per cycle",
-        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
+        "MetricExpr": "(stalled\\-cycles\\-frontend / cpu\\-cycles) if has=
_event(stalled\\-cycles\\-frontend) else 0",
         "MetricGroup": "Default",
         "MetricName": "frontend_cycles_idle",
         "MetricThreshold": "frontend_cycles_idle > 0.1",
@@ -61,7 +61,7 @@
     },
     {
         "BriefDescription": "Backend stalls per cycle",
-        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
+        "MetricExpr": "(stalled\\-cycles\\-backend / cpu\\-cycles) if has_=
event(stalled\\-cycles\\-backend) else 0",
         "MetricGroup": "Default",
         "MetricName": "backend_cycles_idle",
         "MetricThreshold": "backend_cycles_idle > 0.2",
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 76c395cf513c..a92dd0424f79 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1310,33 +1310,33 @@ static const char *const big_c_string =3D
 /* offset=3D128375 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
 /* offset=3D128635 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
 /* offset=3D128866 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
-/* offset=3D128979 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
-/* offset=3D129143 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
-/* offset=3D129273 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
-/* offset=3D129399 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
-/* offset=3D129575 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
-/* offset=3D129755 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D129859 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
-/* offset=3D129975 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
-/* offset=3D130076 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
-/* offset=3D130191 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130297 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D130403 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D130551 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D130574 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D130638 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D130805 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130870 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D130938 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D131010 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D131105 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131240 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D131305 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131374 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D131445 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131468 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D131491 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D131512 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D128979 */ "stalled_cycles_per_instruction\000Default\000(max(s=
talled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions if h=
as_event(stalled\\-cycles\\-frontend) & has_event(stalled\\-cycles\\-backen=
d) else (stalled\\-cycles\\-frontend / instructions if has_event(stalled\\-=
cycles\\-frontend) else (stalled\\-cycles\\-backend / instructions if has_e=
vent(stalled\\-cycles\\-backend) else 0)))\000\000Max front or backend stal=
ls per instruction\000\000\000\000\000\000001"
+/* offset=3D129404 */ "frontend_cycles_idle\000Default\000(stalled\\-cycle=
s\\-frontend / cpu\\-cycles if has_event(stalled\\-cycles\\-frontend) else =
0)\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\0=
00\000\000001"
+/* offset=3D129583 */ "backend_cycles_idle\000Default\000(stalled\\-cycles=
\\-backend / cpu\\-cycles if has_event(stalled\\-cycles\\-backend) else 0)\=
000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\00=
0\000001"
+/* offset=3D129757 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
+/* offset=3D129933 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
+/* offset=3D130113 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
+/* offset=3D130217 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
+/* offset=3D130333 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
+/* offset=3D130434 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
+/* offset=3D130549 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130655 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D130761 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D130909 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D130932 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D130996 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D131163 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D131228 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D131296 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D131368 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D131463 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131598 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D131663 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131732 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D131803 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131826 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D131849 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D131870 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2626,22 +2626,22 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
 { 127956 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
-{ 129273 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
-{ 129575 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
-{ 129755 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
+{ 129583 }, /* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backe=
nd / cpu\\-cycles if has_event(stalled\\-cycles\\-backend) else 0)\000backe=
nd_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001=
 */
+{ 129933 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
+{ 130113 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
 { 128142 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
-{ 129399 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
-{ 130191 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 129143 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
+{ 129757 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 130549 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 129404 }, /* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-fron=
tend / cpu\\-cycles if has_event(stalled\\-cycles\\-frontend) else 0)\000fr=
ontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\0=
00001 */
 { 128866 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
-{ 130297 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 130403 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
-{ 129859 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
-{ 130076 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
-{ 129975 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
+{ 130655 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 130761 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
+{ 130217 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
+{ 130434 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
+{ 130333 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
 { 128375 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
 { 128635 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
-{ 128979 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
+{ 128979 }, /* stalled_cycles_per_instruction\000Default\000(max(stalled\\=
-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions if has_event=
(stalled\\-cycles\\-frontend) & has_event(stalled\\-cycles\\-backend) else =
(stalled\\-cycles\\-frontend / instructions if has_event(stalled\\-cycles\\=
-frontend) else (stalled\\-cycles\\-backend / instructions if has_event(sta=
lled\\-cycles\\-backend) else 0)))\000\000Max front or backend stalls per i=
nstruction\000\000\000\000\000\000001 */
=20
 };
=20
@@ -2714,21 +2714,21 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 130551 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 131240 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 131010 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 131105 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 131305 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 131374 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 130638 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 130574 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 131512 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 131445 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 131468 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 131491 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 130938 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 130805 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 130870 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+{ 130909 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 131598 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 131368 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 131463 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 131663 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 131732 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 130996 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 130932 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 131870 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 131803 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 131826 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 131849 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 131296 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 131163 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 131228 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
--=20
2.53.0.851.ga537e3e6e9-goog

