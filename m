Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074286329
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Jan 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489471; cv=none; b=Jg2++5JGz+l+rT6QbaNPJDRfsQcH6U+SB/wIV50E4ot9GXdSZCVb7/wNsqNytrDkdjIjcTTXv22xS/9b+gkVMNeJWn0bK1Mbsm4K9eiVf4i/MtWDiahMHEpkavLN0od9JsJbOYSkbG1w8sn2/Tlkpeb0deXNsi89dEJ8iZFBfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489471; c=relaxed/simple;
	bh=Wzrs+gGZHU6SH8l2M1N9O70AEt6RWo7ZQs6WGps2BVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=caPElB0R+F1w/Kku2BdIw0w7RJrxs9TCcVpMYi8udCiSwork144yYgVMjyDJM1rSHRAdjlzjap7ZyllLy2OCPr2fD3KRfKJ7rImqqOdFg5uJUQSXECx8JbkfZnvHsoaNZ9P0ByYes6BuAiG519K9LqeUq1rfNjVZDtfuqbpe73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdOA5RyQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdOA5RyQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac34c4b41fso858871eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Jan 2026 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767489466; x=1768094266; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xI/sXCrDiEpaEykSTknANGvbpFRYaVe3dSYvtoLgkSk=;
        b=gdOA5RyQtHcoaLRaVWtMiAuqJaKDjctpw5Awm61JgUBdpEWjDLeuXMSzFKo4y6XWBc
         nbULhBbsNDVFL6fRn99wJpKXBieZ94BckGAbQIuWfhjdOC18RQr/hDhT1hJsfCAWugYg
         Q3/UuyaINakuo+6JTi8qVE2g1zTJwi4tdk494F4F7R+u34assln2K9es86KixT5hz+lr
         dVyWJLKHDIMcRoZJubRM50f9r9RDL6/WLrSg5t53zXqy7du9LM0WHbW9lnJFkM8n9Lb6
         Jhq2b+iEIgSyaENnu4zLT/1Agv15TwNCpjpw/Y1b1/U1xWzNQB53L/I089MHvDfT9xHB
         SrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489466; x=1768094266;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xI/sXCrDiEpaEykSTknANGvbpFRYaVe3dSYvtoLgkSk=;
        b=Xd8K4E8uNF4Ijo/wN/h3Q3vSOrH+1dJ0ozEXqy3BXToUrusaXZM1oACSFtdn0LQ/2Y
         sY2MCP3WLOrJ0ZM/1/3DOfNXe0g38hROo36Rc8Vlw9po2C2p/3lmrON+Jta7UuXAHrKm
         DOrlvSjvgCK2tgjrWj5nix0VkjcAwP7JArl0pmhY6Zuvve8uMveChiP98FDoNlpVBOx9
         xXnp/QTiAJLYm42iAckI2yJUIU8Ik942RfBXs1JLES4cllEb5plbma3kgzwbGchLiJy6
         4gyCw/hEoZNyOmHpT3ybymeHzevjevt6gOaYdRzqtQKM2P+bfe0VwfeAGKAnWBZ242oc
         RHgw==
X-Forwarded-Encrypted: i=1; AJvYcCXORtpgd10UTiulktrj4GR+tnAvzUbNDQw+9Iu1gI//pPiigms+RYHYSDfZOUJQFdBIwKr9qjHq4L/XD2HMosp4@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsDaQpNV3CmykL7SaCVse8K+R3/A349r+U5XhHMwXwV88ttje
	n1vfdH/OkjTtIRpUNV2gxCqptrG3FdbJWtV/gb7sdCc8uEmn3SQX9RiVHClqjdMB+aP7fH5EbYl
	gr9QdpR0iGQ==
X-Google-Smtp-Source: AGHT+IHCP/PIXPqI/M4mA5qmM7Fv+MFfry6Qq8x0l7IAMepHa5kNpyyEOBbq1tVT2PCXix34fHfNGKz61kvq
X-Received: from dlbtu23.prod.google.com ([2002:a05:7022:3c17:b0:121:79a7:ec2d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:ca8b:b0:11b:c1fb:894
 with SMTP id a92af1059eb24-121d80e0608mr1947822c88.19.1767489466539; Sat, 03
 Jan 2026 17:17:46 -0800 (PST)
Date: Sat,  3 Jan 2026 17:17:38 -0800
In-Reply-To: <20260104011738.475680-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260104011738.475680-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260104011738.475680-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf tool_pmu: Add network events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add tool PMU events to report network statistics from /proc/net/dev.
The events can be read system-wide (from /proc/net/dev) or per-process
(from /proc/pid/net/dev).

The following events are added for both RX (receive) and TX (transmit):
- bytes
- packets
- errors
- drop
- fifo
- frame (RX only) / colls (TX only)
- compressed
- multicast (RX only) / carrier (TX only)

Updates tool.json with the new events and descriptions. Updates
tool_pmu implementation to parse the net/dev format.

Below are examples of system-wide and per-process gathering respectively:
```
$ perf stat -e net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net=
_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_c=
arrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo=
,net_tx_packets -I 1000
     1.001154872                  0      net_rx_bytes
     1.001154872                  0      net_rx_compressed
     1.001154872            444,577      net_rx_drop
     1.001154872          4,824,888      net_rx_errors
     1.001154872                  0      net_rx_fifo
     1.001154872                  0      net_rx_frame
     1.001154872                  0      net_rx_multicast
     1.001154872      4,408,889,452      net_rx_packets
     1.001154872                  0      net_tx_bytes
     1.001154872                  0      net_tx_carrier
     1.001154872                  0      net_tx_colls
     1.001154872                  0      net_tx_compressed
     1.001154872                  0      net_tx_drop
     1.001154872                  0      net_tx_errors
     1.001154872                  0      net_tx_fifo
     1.001154872                  0      net_tx_packets
$ perf stat -e net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net=
_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_c=
arrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo=
,net_tx_packets -p $(pidof -d, chrome) -I 1000
     1.001023475                  0      net_rx_bytes
     1.001023475                  0      net_rx_compressed
     1.001023475         42,647,328      net_rx_drop
     1.001023475        463,069,152      net_rx_errors
     1.001023475                  0      net_rx_fifo
     1.001023475                  0      net_rx_frame
     1.001023475                  0      net_rx_multicast
     1.001023475    423,195,831,744      net_rx_packets
     1.001023475                  0      net_tx_bytes
     1.001023475                  0      net_tx_carrier
     1.001023475                  0      net_tx_colls
     1.001023475                  0      net_tx_compressed
     1.001023475                  0      net_tx_drop
     1.001023475                  0      net_tx_errors
     1.001023475                  0      net_tx_fifo
     1.001023475                  0      net_tx_packets
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/common/common/tool.json   |  98 ++++++-
 tools/perf/pmu-events/empty-pmu-events.c      | 256 ++++++++++--------
 tools/perf/util/tool_pmu.c                    | 155 ++++++++++-
 tools/perf/util/tool_pmu.h                    |  16 ++
 4 files changed, 404 insertions(+), 121 deletions(-)

diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
index 4b3fce655f8a..ebd3c5a6d15d 100644
--- a/tools/perf/pmu-events/arch/common/common/tool.json
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -250,5 +250,101 @@
     "EventName": "memory_uss",
     "BriefDescription": "Unique Set Size (USS) in bytes",
     "ConfigCode": "42"
-  }
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_bytes",
+    "BriefDescription": "Network received bytes",
+    "ConfigCode": "43"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_packets",
+    "BriefDescription": "Network received packets",
+    "ConfigCode": "44"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_errors",
+    "BriefDescription": "Network received errors",
+    "ConfigCode": "45"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_drop",
+    "BriefDescription": "Network received dropped packets",
+    "ConfigCode": "46"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_fifo",
+    "BriefDescription": "Network received fifo overruns",
+    "ConfigCode": "47"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_frame",
+    "BriefDescription": "Network received framing errors",
+    "ConfigCode": "48"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_compressed",
+    "BriefDescription": "Network received compressed packets",
+    "ConfigCode": "49"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_multicast",
+    "BriefDescription": "Network received multicast packets",
+    "ConfigCode": "50"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_bytes",
+    "BriefDescription": "Network transmitted bytes",
+    "ConfigCode": "51"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_packets",
+    "BriefDescription": "Network transmitted packets",
+    "ConfigCode": "52"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_errors",
+    "BriefDescription": "Network transmitted errors",
+    "ConfigCode": "53"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_drop",
+    "BriefDescription": "Network transmitted dropped packets",
+    "ConfigCode": "54"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_fifo",
+    "BriefDescription": "Network transmitted fifo overruns",
+    "ConfigCode": "55"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_colls",
+    "BriefDescription": "Network transmitted collisions",
+    "ConfigCode": "56"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_carrier",
+    "BriefDescription": "Network transmitted carrier losses",
+    "ConfigCode": "57"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_compressed",
+    "BriefDescription": "Network transmitted compressed packets",
+    "ConfigCode": "58"
+   }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 4b7c534f1801..0debd0003dbc 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -1309,62 +1309,78 @@ static const char *const big_c_string =3D
 /* offset=3D128860 */ "memory_swap_pss\000tool\000Proportional Share Size =
(PSS) for swap memory in bytes\000config=3D0x28\000\00000\000\000\000\000\0=
00"
 /* offset=3D128956 */ "memory_text\000tool\000Memory dedicated to code (te=
xt segment) in bytes\000config=3D0x29\000\00000\000\000\000\000\000"
 /* offset=3D129042 */ "memory_uss\000tool\000Unique Set Size (USS) in byte=
s\000config=3D0x2a\000\00000\000\000\000\000\000"
-/* offset=3D129109 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
-/* offset=3D129171 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
-/* offset=3D129233 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
-/* offset=3D129331 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
-/* offset=3D129433 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
-/* offset=3D129566 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
-/* offset=3D129684 */ "hisi_sccl,ddrc\000"
-/* offset=3D129699 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
-/* offset=3D129769 */ "uncore_cbox\000"
-/* offset=3D129781 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D129935 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
-/* offset=3D129989 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
-/* offset=3D130047 */ "hisi_sccl,l3c\000"
-/* offset=3D130061 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
-/* offset=3D130129 */ "uncore_imc_free_running\000"
-/* offset=3D130153 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D130233 */ "uncore_imc\000"
-/* offset=3D130244 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
-/* offset=3D130309 */ "uncore_sys_ddr_pmu\000"
-/* offset=3D130328 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D130404 */ "uncore_sys_ccn_pmu\000"
-/* offset=3D130423 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D130500 */ "uncore_sys_cmn_pmu\000"
-/* offset=3D130519 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
-/* offset=3D130662 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
-/* offset=3D130848 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
-/* offset=3D131081 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
-/* offset=3D131341 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
-/* offset=3D131572 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
-/* offset=3D131685 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
-/* offset=3D131849 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
-/* offset=3D131979 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
-/* offset=3D132105 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
-/* offset=3D132281 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
-/* offset=3D132461 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
-/* offset=3D132565 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
-/* offset=3D132681 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
-/* offset=3D132782 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
-/* offset=3D132897 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D133003 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
-/* offset=3D133109 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D133257 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D133280 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
-/* offset=3D133344 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D133511 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D133576 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
-/* offset=3D133644 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
-/* offset=3D133716 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D133811 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
-/* offset=3D133946 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
-/* offset=3D134011 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D134080 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
-/* offset=3D134151 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D134174 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
-/* offset=3D134197 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
-/* offset=3D134218 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
+/* offset=3D129109 */ "net_rx_bytes\000tool\000Network received bytes\000c=
onfig=3D0x2b\000\00000\000\000\000\000\000"
+/* offset=3D129170 */ "net_rx_packets\000tool\000Network received packets\=
000config=3D0x2c\000\00000\000\000\000\000\000"
+/* offset=3D129235 */ "net_rx_errors\000tool\000Network received errors\00=
0config=3D0x2d\000\00000\000\000\000\000\000"
+/* offset=3D129298 */ "net_rx_drop\000tool\000Network received dropped pac=
kets\000config=3D0x2e\000\00000\000\000\000\000\000"
+/* offset=3D129368 */ "net_rx_fifo\000tool\000Network received fifo overru=
ns\000config=3D0x2f\000\00000\000\000\000\000\000"
+/* offset=3D129436 */ "net_rx_frame\000tool\000Network received framing er=
rors\000config=3D0x30\000\00000\000\000\000\000\000"
+/* offset=3D129506 */ "net_rx_compressed\000tool\000Network received compr=
essed packets\000config=3D0x31\000\00000\000\000\000\000\000"
+/* offset=3D129585 */ "net_rx_multicast\000tool\000Network received multic=
ast packets\000config=3D0x32\000\00000\000\000\000\000\000"
+/* offset=3D129662 */ "net_tx_bytes\000tool\000Network transmitted bytes\0=
00config=3D0x33\000\00000\000\000\000\000\000"
+/* offset=3D129726 */ "net_tx_packets\000tool\000Network transmitted packe=
ts\000config=3D0x34\000\00000\000\000\000\000\000"
+/* offset=3D129794 */ "net_tx_errors\000tool\000Network transmitted errors=
\000config=3D0x35\000\00000\000\000\000\000\000"
+/* offset=3D129860 */ "net_tx_drop\000tool\000Network transmitted dropped =
packets\000config=3D0x36\000\00000\000\000\000\000\000"
+/* offset=3D129933 */ "net_tx_fifo\000tool\000Network transmitted fifo ove=
rruns\000config=3D0x37\000\00000\000\000\000\000\000"
+/* offset=3D130004 */ "net_tx_colls\000tool\000Network transmitted collisi=
ons\000config=3D0x38\000\00000\000\000\000\000\000"
+/* offset=3D130073 */ "net_tx_carrier\000tool\000Network transmitted carri=
er losses\000config=3D0x39\000\00000\000\000\000\000\000"
+/* offset=3D130148 */ "net_tx_compressed\000tool\000Network transmitted co=
mpressed packets\000config=3D0x3a\000\00000\000\000\000\000\000"
+/* offset=3D130230 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\00=
0event=3D0x8a\000\00000\000\000\000\000\000"
+/* offset=3D130292 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\00=
0event=3D0x8b\000\00000\000\000\000\000\000"
+/* offset=3D130354 */ "l3_cache_rd\000cache\000L3 cache access, read\000ev=
ent=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read=
\000"
+/* offset=3D130452 */ "segment_reg_loads.any\000other\000Number of segment=
 register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000=
\000\000\000"
+/* offset=3D130554 */ "dispatch_blocked.any\000other\000Memory cluster sig=
nals to block micro-op dispatch for any reason\000event=3D9,period=3D200000=
,umask=3D0x20\000\00000\000\000\000\000\000"
+/* offset=3D130687 */ "eist_trans\000other\000Number of Enhanced Intel Spe=
edStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000=
\00000\000\000\000\000\000"
+/* offset=3D130805 */ "hisi_sccl,ddrc\000"
+/* offset=3D130820 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write =
commands\000event=3D2\000\00000\000\000\000\000\000"
+/* offset=3D130890 */ "uncore_cbox\000"
+/* offset=3D130902 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000A =
cross-core snoop resulted from L3 Eviction which misses in some processor c=
ore\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
+/* offset=3D131056 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
+/* offset=3D131110 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000eve=
nt=3D0xc0\000\00000\000\000\000\000\000"
+/* offset=3D131168 */ "hisi_sccl,l3c\000"
+/* offset=3D131182 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total rea=
d hits\000event=3D7\000\00000\000\000\000\000\000"
+/* offset=3D131250 */ "uncore_imc_free_running\000"
+/* offset=3D131274 */ "uncore_imc_free_running.cache_miss\000uncore\000Tot=
al cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
+/* offset=3D131354 */ "uncore_imc\000"
+/* offset=3D131365 */ "uncore_imc.cache_hits\000uncore\000Total cache hits=
\000event=3D0x34\000\00000\000\000\000\000\000"
+/* offset=3D131430 */ "uncore_sys_ddr_pmu\000"
+/* offset=3D131449 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cyc=
les event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
+/* offset=3D131525 */ "uncore_sys_ccn_pmu\000"
+/* offset=3D131544 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycle=
s event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
+/* offset=3D131621 */ "uncore_sys_cmn_pmu\000"
+/* offset=3D131640 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts tota=
l cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
+/* offset=3D131783 */ "CPUs_utilized\000Default\000(software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\000011"
+/* offset=3D131969 */ "cs_per_second\000Default\000software@context\\-swit=
ches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\=
000011"
+/* offset=3D132202 */ "migrations_per_second\000Default\000software@cpu\\-=
migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001m=
igrations/sec\000\000\000\000011"
+/* offset=3D132462 */ "page_faults_per_second\000Default\000software@page\=
\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
+/* offset=3D132693 */ "insn_per_cycle\000Default\000instructions / cpu\\-c=
ycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\=
000\000\000\000001"
+/* offset=3D132806 */ "stalled_cycles_per_instruction\000Default\000max(st=
alled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\0=
00Max front or backend stalls per instruction\000\000\000\000\000\000001"
+/* offset=3D132970 */ "frontend_cycles_idle\000Default\000stalled\\-cycles=
\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls=
 per cycle\000\000\000\000\000\000001"
+/* offset=3D133100 */ "backend_cycles_idle\000Default\000stalled\\-cycles\=
\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per=
 cycle\000\000\000\000\000\000001"
+/* offset=3D133226 */ "cycles_frequency\000Default\000cpu\\-cycles / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\=
000\000\000\000011"
+/* offset=3D133402 */ "branch_frequency\000Default\000branches / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/s=
ec\000\000\000\000011"
+/* offset=3D133582 */ "branch_miss_rate\000Default\000branch\\-misses / br=
anches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\0=
00\000001"
+/* offset=3D133686 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-m=
isses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\0=
00100%\000\000\000\000001"
+/* offset=3D133802 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses / =
LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\00=
0\000001"
+/* offset=3D133903 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-m=
isses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\00=
0100%\000\000\000\000001"
+/* offset=3D134018 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses =
/ dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D134124 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses =
/ iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\0=
00\000\000001"
+/* offset=3D134230 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-=
prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.0=
5\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
+/* offset=3D134378 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D134401 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhalte=
d.thread\000\000\000\000\000\000\000\000000"
+/* offset=3D134465 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.co=
re / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_a=
ctive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
+/* offset=3D134632 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_=
retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D134697 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / in=
st_retired.any\000\000\000\000\000\000\000\000000"
+/* offset=3D134765 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + ic=
ache_miss_cycles\000\000\000\000\000\000\000\000000"
+/* offset=3D134837 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_h=
it + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
+/* offset=3D134932 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_d=
ata_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_=
miss\000\000\000\000\000\000\000\000000"
+/* offset=3D135067 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2=
_All_Miss\000\000\000\000\000\000\000\000000"
+/* offset=3D135132 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, D=
Cache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D135201 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
+/* offset=3D135272 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D135295 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\0000=
00"
+/* offset=3D135318 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\000000=
"
+/* offset=3D135339 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9=
 / duration_time\000\000\000\000\000\000\000\000000"
 ;
=20
 static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
@@ -2648,6 +2664,22 @@ static const struct compact_pmu_event pmu_events__co=
mmon_tool[] =3D {
 { 128860 }, /* memory_swap_pss\000tool\000Proportional Share Size (PSS) fo=
r swap memory in bytes\000config=3D0x28\000\00000\000\000\000\000\000 */
 { 128956 }, /* memory_text\000tool\000Memory dedicated to code (text segme=
nt) in bytes\000config=3D0x29\000\00000\000\000\000\000\000 */
 { 129042 }, /* memory_uss\000tool\000Unique Set Size (USS) in bytes\000con=
fig=3D0x2a\000\00000\000\000\000\000\000 */
+{ 129109 }, /* net_rx_bytes\000tool\000Network received bytes\000config=3D=
0x2b\000\00000\000\000\000\000\000 */
+{ 129506 }, /* net_rx_compressed\000tool\000Network received compressed pa=
ckets\000config=3D0x31\000\00000\000\000\000\000\000 */
+{ 129298 }, /* net_rx_drop\000tool\000Network received dropped packets\000=
config=3D0x2e\000\00000\000\000\000\000\000 */
+{ 129235 }, /* net_rx_errors\000tool\000Network received errors\000config=
=3D0x2d\000\00000\000\000\000\000\000 */
+{ 129368 }, /* net_rx_fifo\000tool\000Network received fifo overruns\000co=
nfig=3D0x2f\000\00000\000\000\000\000\000 */
+{ 129436 }, /* net_rx_frame\000tool\000Network received framing errors\000=
config=3D0x30\000\00000\000\000\000\000\000 */
+{ 129585 }, /* net_rx_multicast\000tool\000Network received multicast pack=
ets\000config=3D0x32\000\00000\000\000\000\000\000 */
+{ 129170 }, /* net_rx_packets\000tool\000Network received packets\000confi=
g=3D0x2c\000\00000\000\000\000\000\000 */
+{ 129662 }, /* net_tx_bytes\000tool\000Network transmitted bytes\000config=
=3D0x33\000\00000\000\000\000\000\000 */
+{ 130073 }, /* net_tx_carrier\000tool\000Network transmitted carrier losse=
s\000config=3D0x39\000\00000\000\000\000\000\000 */
+{ 130004 }, /* net_tx_colls\000tool\000Network transmitted collisions\000c=
onfig=3D0x38\000\00000\000\000\000\000\000 */
+{ 130148 }, /* net_tx_compressed\000tool\000Network transmitted compressed=
 packets\000config=3D0x3a\000\00000\000\000\000\000\000 */
+{ 129860 }, /* net_tx_drop\000tool\000Network transmitted dropped packets\=
000config=3D0x36\000\00000\000\000\000\000\000 */
+{ 129794 }, /* net_tx_errors\000tool\000Network transmitted errors\000conf=
ig=3D0x35\000\00000\000\000\000\000\000 */
+{ 129933 }, /* net_tx_fifo\000tool\000Network transmitted fifo overruns\00=
0config=3D0x37\000\00000\000\000\000\000\000 */
+{ 129726 }, /* net_tx_packets\000tool\000Network transmitted packets\000co=
nfig=3D0x34\000\00000\000\000\000\000\000 */
 { 125362 }, /* num_cores\000tool\000Number of cores. A core consists of 1 =
or more thread, with each thread being associated with a logical Linux CPU\=
000config=3D5\000\00000\000\000\000\000\000 */
 { 125507 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\00=
0 */
 { 125610 }, /* num_cpus_online\000tool\000Number of online logical Linux C=
PUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\000\=
000\000\000\000 */
@@ -2681,23 +2713,23 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
-{ 130662 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
-{ 131979 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
-{ 132281 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
-{ 132461 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
-{ 130848 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
-{ 132105 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
-{ 132897 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 131849 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
-{ 131572 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
-{ 133003 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
-{ 133109 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
-{ 132565 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
-{ 132782 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
-{ 132681 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
-{ 131081 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
-{ 131341 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
-{ 131685 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
+{ 131783 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CPU=
s\000\000\000\000011 */
+{ 133100 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-backen=
d / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle\0=
00\000\000\000\000\000001 */
+{ 133402 }, /* branch_frequency\000Default\000branches / (software@cpu\\-c=
lock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,na=
me\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\0=
00\000\000011 */
+{ 133582 }, /* branch_miss_rate\000Default\000branch\\-misses / branches\0=
00branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\00000=
1 */
+{ 131969 }, /* cs_per_second\000Default\000software@context\\-switches\\,n=
ame\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-=
clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\=
000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 */
+{ 133226 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\=
000\000011 */
+{ 134018 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\=
-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 132970 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-front=
end / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per cyc=
le\000\000\000\000\000\000001 */
+{ 132693 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\00=
0insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\000\=
000\000001 */
+{ 134124 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\=
-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\0=
00001 */
+{ 134230 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch=
\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 =
prefetch miss rate\000\000100%\000\000\000\000001 */
+{ 133686 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / =
L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\0=
00\000\000\000001 */
+{ 133903 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / =
L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\00=
0\000\000\000001 */
+{ 133802 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-lo=
ads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001=
 */
+{ 132202 }, /* migrations_per_second\000Default\000software@cpu\\-migratio=
ns\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Process migrations to a new CPU per CPU second\000\0001migration=
s/sec\000\000\000\000011 */
+{ 132462 }, /* page_faults_per_second\000Default\000software@page\\-faults=
\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-c=
lock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\0=
00\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
+{ 132806 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\\-=
cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max fr=
ont or backend stalls per instruction\000\000\000\000\000\000001 */
=20
 };
=20
@@ -2710,29 +2742,29 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
-{ 129109 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
-{ 129171 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
-{ 129433 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
-{ 129566 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
-{ 129233 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
-{ 129331 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
+{ 130230 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
+{ 130292 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
+{ 130554 }, /* dispatch_blocked.any\000other\000Memory cluster signals to =
block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
+{ 130687 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R=
) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\0=
00\000\000\000\000 */
+{ 130354 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x=
40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 */
+{ 130452 }, /* segment_reg_loads.any\000other\000Number of segment registe=
r loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000=
\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
-{ 129699 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
+{ 130820 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands=
\000event=3D2\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
-{ 130061 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
+{ 131182 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\0=
00event=3D7\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
-{ 129935 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
-{ 129989 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
-{ 129781 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
+{ 131056 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\00=
0\00000\000\000\000\000\000 */
+{ 131110 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc=
0\000\00000\000\000\000\000\000 */
+{ 130902 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-co=
re snoop resulted from L3 Eviction which misses in some processor core\000e=
vent=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
-{ 130244 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
+{ 131365 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000even=
t=3D0x34\000\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
-{ 130153 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
+{ 131274 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cache=
 misses\000event=3D0x12\000\00000\000\000\000\000\000 */
=20
 };
=20
@@ -2745,46 +2777,46 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-     .pmu_name =3D { 129684 /* hisi_sccl,ddrc\000 */ },
+     .pmu_name =3D { 130805 /* hisi_sccl,ddrc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-     .pmu_name =3D { 130047 /* hisi_sccl,l3c\000 */ },
+     .pmu_name =3D { 131168 /* hisi_sccl,l3c\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-     .pmu_name =3D { 129769 /* uncore_cbox\000 */ },
+     .pmu_name =3D { 130890 /* uncore_cbox\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-     .pmu_name =3D { 130233 /* uncore_imc\000 */ },
+     .pmu_name =3D { 131354 /* uncore_imc\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_=
running),
-     .pmu_name =3D { 130129 /* uncore_imc_free_running\000 */ },
+     .pmu_name =3D { 131250 /* uncore_imc_free_running\000 */ },
 },
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
-{ 133257 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-{ 133946 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
-{ 133716 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
-{ 133811 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
-{ 134011 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
-{ 134080 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
-{ 133344 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
-{ 133280 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
-{ 134218 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
-{ 134151 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-{ 134174 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-{ 134197 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-{ 133644 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
-{ 133511 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
-{ 133576 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
+{ 134378 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
+{ 135067 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Mis=
s\000\000\000\000\000\000\000\000000 */
+{ 134837 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_=
rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
+{ 134932 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd -=
 l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000=
\000\000\000\000\000\000\000000 */
+{ 135132 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2=
_All)\000\000\000\000\000\000\000\000000 */
+{ 135201 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
+{ 134465 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 =
* (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / =
cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
+{ 134401 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread=
\000\000\000\000\000\000\000\000000 */
+{ 135339 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / durat=
ion_time\000\000\000\000\000\000\000\000000 */
+{ 135272 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
+{ 135295 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
+{ 135318 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
+{ 134765 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_mis=
s_cycles\000\000\000\000\000\000\000\000000 */
+{ 134632 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.=
any\000\000\000\000\000\000\000\000000 */
+{ 134697 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retir=
ed.any\000\000\000\000\000\000\000\000000 */
=20
 };
=20
@@ -2797,13 +2829,13 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
 };
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
-{ 130423 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
+{ 131544 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\=
000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
-{ 130519 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
+{ 131640 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache =
misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000(4=
34|436|43c|43a).*\00000\000\000\000\000\000 */
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
-{ 130328 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
+{ 131449 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles even=
t\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
=20
 };
=20
@@ -2811,17 +2843,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_p=
mu),
-     .pmu_name =3D { 130404 /* uncore_sys_ccn_pmu\000 */ },
+     .pmu_name =3D { 131525 /* uncore_sys_ccn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_p=
mu),
-     .pmu_name =3D { 130500 /* uncore_sys_cmn_pmu\000 */ },
+     .pmu_name =3D { 131621 /* uncore_sys_cmn_pmu\000 */ },
 },
 {
      .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
      .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_p=
mu),
-     .pmu_name =3D { 130309 /* uncore_sys_ddr_pmu\000 */ },
+     .pmu_name =3D { 131430 /* uncore_sys_ddr_pmu\000 */ },
 },
 };
=20
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 2d1f244264dd..52d8188efc5e 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -66,6 +66,22 @@ static const char *const tool_pmu__event_names[TOOL_PMU_=
_EVENT_MAX] =3D {
 	"memory_swap_pss",
 	"memory_text",
 	"memory_uss",
+	"net_rx_bytes",
+	"net_rx_packets",
+	"net_rx_errors",
+	"net_rx_drop",
+	"net_rx_fifo",
+	"net_rx_frame",
+	"net_rx_compressed",
+	"net_rx_multicast",
+	"net_tx_bytes",
+	"net_tx_packets",
+	"net_tx_errors",
+	"net_tx_drop",
+	"net_tx_fifo",
+	"net_tx_colls",
+	"net_tx_carrier",
+	"net_tx_compressed",
 };
=20
 bool tool_pmu__skip_event(const char *name __maybe_unused)
@@ -297,6 +313,22 @@ static const char *tool_pmu__memory_event_to_key(enum =
tool_pmu_event ev)
 	case TOOL_PMU__EVENT_MEMORY_SIZE:
 	case TOOL_PMU__EVENT_MEMORY_TEXT:
 	case TOOL_PMU__EVENT_MEMORY_USS:
+	case TOOL_PMU__EVENT_NET_RX_BYTES:
+	case TOOL_PMU__EVENT_NET_RX_PACKETS:
+	case TOOL_PMU__EVENT_NET_RX_ERRORS:
+	case TOOL_PMU__EVENT_NET_RX_DROP:
+	case TOOL_PMU__EVENT_NET_RX_FIFO:
+	case TOOL_PMU__EVENT_NET_RX_FRAME:
+	case TOOL_PMU__EVENT_NET_RX_COMPRESSED:
+	case TOOL_PMU__EVENT_NET_RX_MULTICAST:
+	case TOOL_PMU__EVENT_NET_TX_BYTES:
+	case TOOL_PMU__EVENT_NET_TX_PACKETS:
+	case TOOL_PMU__EVENT_NET_TX_ERRORS:
+	case TOOL_PMU__EVENT_NET_TX_DROP:
+	case TOOL_PMU__EVENT_NET_TX_FIFO:
+	case TOOL_PMU__EVENT_NET_TX_COLLS:
+	case TOOL_PMU__EVENT_NET_TX_CARRIER:
+	case TOOL_PMU__EVENT_NET_TX_COMPRESSED:
 	case TOOL_PMU__EVENT_DURATION_TIME:
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME:
@@ -435,6 +467,68 @@ static int read_statm(int fd, enum tool_pmu_event ev, =
u64 *val)
 	return -EINVAL;
 }
=20
+static bool tool_pmu__is_net_event(enum tool_pmu_event ev)
+{
+	return ev >=3D TOOL_PMU__EVENT_NET_RX_BYTES &&
+	       ev <=3D TOOL_PMU__EVENT_NET_TX_COMPRESSED;
+}
+
+static int read_net_dev(int fd, enum tool_pmu_event ev, u64 *val)
+{
+	struct io io;
+	char buf[4096];
+	int i;
+	int index =3D ev - TOOL_PMU__EVENT_NET_RX_BYTES;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	lseek(fd, 0, SEEK_SET);
+
+	/*
+	 * Drop first two lines of:
+	 * Inter-|   Receive                                                |  Tr=
ansmit
+	 *  face |bytes    packets errs drop fifo frame compressed multicast|byte=
s    packets errs drop fifo colls carrier compressed
+	 */
+	if (!read_until_char(&io, '\n'))
+		return -EINVAL;
+	if (!read_until_char(&io, '\n'))
+		return -EINVAL;
+
+	*val =3D 0;
+	while (true) {
+		int ch =3D io__get_char(&io);
+		__u64 read_val;
+
+		/* First read interface name, such as "    lo:" */
+		if (ch =3D=3D -1)
+			break;
+		while (ch =3D=3D ' ')
+			ch =3D io__get_char(&io);
+		if (ch =3D=3D -1)
+			break;
+		while (ch !=3D ':' && ch !=3D -1 && ch !=3D '\n')
+			ch =3D io__get_char(&io);
+		if (ch !=3D ':') {
+			if (ch =3D=3D '\n')
+				continue;
+			if (ch =3D=3D -1)
+				return 0; /* Assume EOF. */
+			read_until_char(&io, '\n');
+			continue;
+		}
+		/* Ignore columns before one being read. */
+		for (i =3D 0; i < index; i++) {
+			if (io__get_dec(&io, &read_val) =3D=3D -1)
+				return 0; /* Assume EOF. */
+		}
+		/* Read actually value. */
+		if (io__get_dec(&io, &read_val) !=3D -1)
+			*val +=3D read_val;
+		/* Move to the next line. */
+		read_until_char(&io, '\n');
+	}
+	return 0;
+}
+
 int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
 				 int nthreads)
@@ -517,26 +611,36 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 				}
 				if (err)
 					goto out_close;
-			} else if (tool_pmu__is_memory_event(ev)) {
+			} else if (tool_pmu__is_memory_event(ev) ||
+				   tool_pmu__is_net_event(ev)) {
+				char buf[PATH_MAX];
 				int fd =3D -1;
=20
 				if (pid > -1) {
-					char buf[PATH_MAX];
-
 					if (tool_pmu__is_memory_statm_event(ev)) {
 						snprintf(buf, sizeof(buf), "%s/%d/statm",
 							 procfs__mountpoint(), pid);
+					} else if (tool_pmu__is_net_event(ev)) {
+						snprintf(buf, sizeof(buf), "%s/%d/net/dev",
+							 procfs__mountpoint(), pid);
 					} else {
 						snprintf(buf, sizeof(buf), "%s/%d/smaps_rollup",
 							 procfs__mountpoint(), pid);
 					}
 					fd =3D open(buf, O_RDONLY);
 				}
+				if (pid =3D=3D -1 && tool_pmu__is_net_event(ev)) {
+					/* Read /proc/net/dev that already aggregates the counts. */
+					snprintf(buf, sizeof(buf), "%s/net/dev",
+						 procfs__mountpoint());
+					fd =3D open(buf, O_RDONLY);
+				}
 				/*
-				 * For system-wide (pid =3D=3D -1), we don't open a file here.
-				 * We will aggregate in read().
+				 * For memory event system-wide (pid =3D=3D -1), we
+				 * don't open a file here.  We will aggregate in
+				 * read().
 				 */
-				if (pid > -1 && fd < 0) {
+				if ((pid > -1 || tool_pmu__is_net_event(ev)) && fd < 0) {
 					err =3D -errno;
 					goto out_close;
 				}
@@ -723,6 +827,22 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
 	case TOOL_PMU__EVENT_MEMORY_LOCKED:
 	case TOOL_PMU__EVENT_MEMORY_DATA:
 	case TOOL_PMU__EVENT_MEMORY_TEXT:
+	case TOOL_PMU__EVENT_NET_RX_BYTES:
+	case TOOL_PMU__EVENT_NET_RX_PACKETS:
+	case TOOL_PMU__EVENT_NET_RX_ERRORS:
+	case TOOL_PMU__EVENT_NET_RX_DROP:
+	case TOOL_PMU__EVENT_NET_RX_FIFO:
+	case TOOL_PMU__EVENT_NET_RX_FRAME:
+	case TOOL_PMU__EVENT_NET_RX_COMPRESSED:
+	case TOOL_PMU__EVENT_NET_RX_MULTICAST:
+	case TOOL_PMU__EVENT_NET_TX_BYTES:
+	case TOOL_PMU__EVENT_NET_TX_PACKETS:
+	case TOOL_PMU__EVENT_NET_TX_ERRORS:
+	case TOOL_PMU__EVENT_NET_TX_DROP:
+	case TOOL_PMU__EVENT_NET_TX_FIFO:
+	case TOOL_PMU__EVENT_NET_TX_COLLS:
+	case TOOL_PMU__EVENT_NET_TX_CARRIER:
+	case TOOL_PMU__EVENT_NET_TX_COMPRESSED:
 	case TOOL_PMU__EVENT_NONE:
 	case TOOL_PMU__EVENT_DURATION_TIME:
 	case TOOL_PMU__EVENT_USER_TIME:
@@ -905,16 +1025,34 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cp=
u_map_idx, int thread)
 	case TOOL_PMU__EVENT_MEMORY_PRIVATE_HUGETLB:
 	case TOOL_PMU__EVENT_MEMORY_LOCKED:
 	case TOOL_PMU__EVENT_MEMORY_DATA:
-	case TOOL_PMU__EVENT_MEMORY_TEXT: {
+	case TOOL_PMU__EVENT_MEMORY_TEXT:
+	case TOOL_PMU__EVENT_NET_RX_BYTES:
+	case TOOL_PMU__EVENT_NET_RX_PACKETS:
+	case TOOL_PMU__EVENT_NET_RX_ERRORS:
+	case TOOL_PMU__EVENT_NET_RX_DROP:
+	case TOOL_PMU__EVENT_NET_RX_FIFO:
+	case TOOL_PMU__EVENT_NET_RX_FRAME:
+	case TOOL_PMU__EVENT_NET_RX_COMPRESSED:
+	case TOOL_PMU__EVENT_NET_RX_MULTICAST:
+	case TOOL_PMU__EVENT_NET_TX_BYTES:
+	case TOOL_PMU__EVENT_NET_TX_PACKETS:
+	case TOOL_PMU__EVENT_NET_TX_ERRORS:
+	case TOOL_PMU__EVENT_NET_TX_DROP:
+	case TOOL_PMU__EVENT_NET_TX_FIFO:
+	case TOOL_PMU__EVENT_NET_TX_COLLS:
+	case TOOL_PMU__EVENT_NET_TX_CARRIER:
+	case TOOL_PMU__EVENT_NET_TX_COMPRESSED: {
 		int fd =3D FD(evsel, cpu_map_idx, thread);
 		u64 val =3D 0;
=20
 		if (fd >=3D 0) {
-			/* Per-process */
+			/* Per-process or system-wide net. */
 			int ret;
=20
 			if (tool_pmu__is_memory_statm_event(ev))
 				ret =3D read_statm(fd, ev, &val);
+			else if (tool_pmu__is_net_event(ev))
+				ret =3D read_net_dev(fd, ev, &val);
 			else
 				ret =3D read_smaps_rollup(fd, ev, &val);
=20
@@ -923,6 +1061,7 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_=
map_idx, int thread)
 		} else {
 			/* System-wide aggregation */
 			if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
+				assert(tool_pmu__is_memory_event(ev));
 				tool_pmu__aggregate_memory_event(ev, &val);
 			}
 		}
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index bf6bb196ad75..be8ebd9aacfb 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -52,6 +52,22 @@ enum tool_pmu_event {
 	TOOL_PMU__EVENT_MEMORY_SWAP_PSS,
 	TOOL_PMU__EVENT_MEMORY_TEXT,
 	TOOL_PMU__EVENT_MEMORY_USS,
+	TOOL_PMU__EVENT_NET_RX_BYTES,
+	TOOL_PMU__EVENT_NET_RX_PACKETS,
+	TOOL_PMU__EVENT_NET_RX_ERRORS,
+	TOOL_PMU__EVENT_NET_RX_DROP,
+	TOOL_PMU__EVENT_NET_RX_FIFO,
+	TOOL_PMU__EVENT_NET_RX_FRAME,
+	TOOL_PMU__EVENT_NET_RX_COMPRESSED,
+	TOOL_PMU__EVENT_NET_RX_MULTICAST,
+	TOOL_PMU__EVENT_NET_TX_BYTES,
+	TOOL_PMU__EVENT_NET_TX_PACKETS,
+	TOOL_PMU__EVENT_NET_TX_ERRORS,
+	TOOL_PMU__EVENT_NET_TX_DROP,
+	TOOL_PMU__EVENT_NET_TX_FIFO,
+	TOOL_PMU__EVENT_NET_TX_COLLS,
+	TOOL_PMU__EVENT_NET_TX_CARRIER,
+	TOOL_PMU__EVENT_NET_TX_COMPRESSED,
=20
 	TOOL_PMU__EVENT_MAX,
 };
--=20
2.52.0.351.gbe84eed79e-goog

