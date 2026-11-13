Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613070;
	b=ufvneMMVUySZbPSfY77x6VdCApCPcpHxPdXL3bFeuQzGTPosNti9T+fl16S2CTqzEjGf
	 74gRN2u1skejxUKnBY3u7BeoLRfv+8VX/PEM8D1x8EfHSVHN+iDkxTHINy8BpvX5Rylgu
	 nH+tOynDoLates9B1W7zqb/im0Qp1uKVPJLvpgAeuIzRTQFnmWXJCF6m8BfZmFfiux7tf
	 BZsb3z8fzAJeHNdTSnrfEXzBa1wiGDotC2FeGziDZfCiLdUVVoX6g4HpD6qNFFDIYyYVJ
	 bg/0d/TirtRUNdc3P7KJPbc2SOL2upU4t8hx5PppXXhG9XRMwf/D8CmhhmKKC1x2Rxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bvYtgIwm0dIvAof3bYYExPnF0b+1e6DfTMpx/hgowV8=;
	b=cz+QFMdTFsmsYZM7fc5bXVsWJLFbJhsnVUtVEZCjp2Kkgp8ZpNdE2o6Vrz4EDE2RAkWC
	 ayGEt4bcwapsvoT9JQZBTluHzF2lHOZtSDuqKxL7drEPC4TQigiH4J1dx+UCuzRz81VkF
	 dYgZJ8awoqR2QzPElx00uewsggrGihxjOSRxHgoAAv5hz0ssfCcTxy4MH8gLrKzs6nRLj
	 Rkd3iyoxnVD3GIUZxGeliSvxB09hWR6AINY7H5042QgIiPfQRUAyADF8Q78p99qv+D36s
	 c3gvdxTTV4r9IsvztVhjLiAg1j/ZHaPtf4b79FT7Pdw6krcNAwIZVP2sm9MkGweMGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c2zzK9gb;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9D606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F9D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c2zzK9gb
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb8e8bccdeso775227a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794613068; x=1795217868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bvYtgIwm0dIvAof3bYYExPnF0b+1e6DfTMpx/hgowV8=;
        b=c2zzK9gbR/lRqXzdj+W4e+t5VA532hBCMGktqq2DW7Jgp9R8umO/sRz2PisShjDCcg
         sj+HZjmooLF83bfPUaCzL/ubZz26sXsmU8ODxCXMQgIEyuWzmv3aqNTldnrlle3g0Zsb
         KE141sJinzxXlgKNVK6mTcORA5crPlmFZfgfLwh7/FfEZBTYtaRn/cTzzR8QoYOF8lSw
         YCbXCvEo50S+kof2w3PdCLJEGxEGnVF28Yl+wh3pcxyI6I4ogdNx7sPrOmiJ8avA6p1b
         gms94XvId/TBgSV9cH4ajK9Jt2Pmiqv4FJhRuIeHig1Ex0kBpkYBdo7nVw98PYmRtPVS
         0/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613068; x=1795217868;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvYtgIwm0dIvAof3bYYExPnF0b+1e6DfTMpx/hgowV8=;
        b=Mv9VFOsWYFqzHBpYO1FkfwnEF2Yx/1krXKORtFjLJe3HT/7pF1DQWKWkUxdErof2cw
         X+yPd8UrBDOfZ+5rhbSkseXTP5Qqp/QZSqf7x50vDYHy1DkRaPcVqspAsJfgP4LCOLLC
         ji+xfT88cMqWNjyaCIki7nHfhUU3CJHiXMAZcJOr3xXGctX13sqTwNg5PZHWz9M6ngFI
         UcIcNYmNsF8LgDAQGvkDPQotdX5sGOBJ51lL/QQjmnBKfbAI6WJveL/YejxVdXXT1OPm
         niy3/Ayj6/EfHLpMstH+WDOPmVr7u7KYPHAfTvoBJyUM+0ouv6xuhItbKsgedoSPBScW
         m2lQ==
X-Forwarded-Encrypted: i=1; AL+hErFt4vCiZxcoddH7lLxyEjm1IVa01opq8+FDIP32jZhhz+0JKjaZIfvs7u67zQkeKsnhPG4LGgNpFvW2JoWvw57M@vger.kernel.org
X-Gm-Message-State: APuU4Z9pDc2RSfulZ+wbQPf5TggaVwlABnBG2LIKwq7EIlNvRo2wCmPl
	X5SIJrVDfLQgrSmsT6GKJpnmCbZ+dYFtrvl/NHJnbTKo4USvhI7zvFCSV3OnktJr0mOSMAKQZDz
	/OS1zcRbS2g==
X-Received: from pjbbp7.prod.google.com ([2002:a17:90b:c07:b0:3b1:2eb3:19c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e016:b0:3b1:b9ed:5dd0
 with SMTP id 98e67ed59e1d1-3b1b9ed5e3fmr1892655a91.35.1794613068188; Fri, 13
 Nov 2026 15:37:48 -0800 (PST)
Date: Fri, 13 Nov 2026 15:37:37 -0800
In-Reply-To: <20261113233739.3626499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113233739.3626499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113233739.3626499-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf tool_pmu: Add network events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add system-wide tool PMU events to report network statistics from
/proc/net/dev. Since /proc/pid/net/dev reports statistics for the entire
network namespace rather than an individual process, reject opening
these events in per-process or cgroup mode.

The following events are added for both RX (receive) and TX (transmit):
- bytes
- packets
- errors
- drop
- fifo
- frame (RX only) / colls (TX only)
- compressed
- multicast (RX only) / carrier (TX only)

Track initial and accumulated values across enable/disable transitions so
perf stat reports deltas over the measurement period rather than
cumulative totals since boot. Also honor the group leader's
attr.disabled state when opening grouped tool events and map CPU indices
safely in evsel__enable_cpu(), evsel__disable_cpu(), and tool_pmu xyarray
lookups when single-CPU tool events are grouped with per-CPU events.

Example output:

  $ perf stat -a -e net_rx_bytes,net_rx_packets,net_tx_bytes \
      -e net_tx_packets -- sleep 0.02

   Performance counter stats for 'system wide':

              16,971      net_rx_bytes
                  10      net_rx_packets
              17,214      net_tx_bytes
                  10      net_tx_packets

         0.017721776 seconds time elapsed

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/common/common/tool.json   |  96 ++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 286 +++++++++++-------
 tools/perf/util/evsel.c                       |  53 +++-
 tools/perf/util/tool_pmu.c                    | 263 ++++++++++++++--
 tools/perf/util/tool_pmu.h                    |  17 ++
 5 files changed, 571 insertions(+), 144 deletions(-)

diff --git a/tools/perf/pmu-events/arch/common/common/tool.json b/tools/per=
f/pmu-events/arch/common/common/tool.json
index 9e0e89553847..a332cbf842f7 100644
--- a/tools/perf/pmu-events/arch/common/common/tool.json
+++ b/tools/perf/pmu-events/arch/common/common/tool.json
@@ -238,5 +238,101 @@
     "EventName": "memory_uss",
     "BriefDescription": "Unique Set Size (USS) in bytes",
     "ConfigCode": "40"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_bytes",
+    "BriefDescription": "System-wide network received bytes",
+    "ConfigCode": "41"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_packets",
+    "BriefDescription": "System-wide network received packets",
+    "ConfigCode": "42"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_errors",
+    "BriefDescription": "System-wide network received errors",
+    "ConfigCode": "43"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_drop",
+    "BriefDescription": "System-wide network received dropped packets",
+    "ConfigCode": "44"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_fifo",
+    "BriefDescription": "System-wide network received fifo overruns",
+    "ConfigCode": "45"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_frame",
+    "BriefDescription": "System-wide network received framing errors",
+    "ConfigCode": "46"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_compressed",
+    "BriefDescription": "System-wide network received compressed packets",
+    "ConfigCode": "47"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_rx_multicast",
+    "BriefDescription": "System-wide network received multicast packets",
+    "ConfigCode": "48"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_bytes",
+    "BriefDescription": "System-wide network transmitted bytes",
+    "ConfigCode": "49"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_packets",
+    "BriefDescription": "System-wide network transmitted packets",
+    "ConfigCode": "50"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_errors",
+    "BriefDescription": "System-wide network transmitted errors",
+    "ConfigCode": "51"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_drop",
+    "BriefDescription": "System-wide network transmitted dropped packets",
+    "ConfigCode": "52"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_fifo",
+    "BriefDescription": "System-wide network transmitted fifo overruns",
+    "ConfigCode": "53"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_colls",
+    "BriefDescription": "System-wide network transmitted collisions",
+    "ConfigCode": "54"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_carrier",
+    "BriefDescription": "System-wide network transmitted carrier losses",
+    "ConfigCode": "55"
+  },
+  {
+    "Unit": "tool",
+    "EventName": "net_tx_compressed",
+    "BriefDescription": "System-wide network transmitted compressed packet=
s",
+    "ConfigCode": "56"
   }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c
index 8d1b9e9b4f58..8705f32563a6 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -2596,116 +2596,148 @@ static const char *const big_c_string =3D
 /* offset=3D128716 */
 "memory_uss\000tool\000Unique Set Size (USS) in bytes\000config=3D0x28\000=
\00000\000\000\000\000\000"
 /* offset=3D128783 */
+"net_rx_bytes\000tool\000System-wide network received bytes\000config=3D0x=
29\000\00000\000\000\000\000\000"
+/* offset=3D128856 */
+"net_rx_packets\000tool\000System-wide network received packets\000config=
=3D0x2a\000\00000\000\000\000\000\000"
+/* offset=3D128933 */
+"net_rx_errors\000tool\000System-wide network received errors\000config=3D=
0x2b\000\00000\000\000\000\000\000"
+/* offset=3D129008 */
+"net_rx_drop\000tool\000System-wide network received dropped packets\000co=
nfig=3D0x2c\000\00000\000\000\000\000\000"
+/* offset=3D129090 */
+"net_rx_fifo\000tool\000System-wide network received fifo overruns\000conf=
ig=3D0x2d\000\00000\000\000\000\000\000"
+/* offset=3D129170 */
+"net_rx_frame\000tool\000System-wide network received framing errors\000co=
nfig=3D0x2e\000\00000\000\000\000\000\000"
+/* offset=3D129252 */
+"net_rx_compressed\000tool\000System-wide network received compressed pack=
ets\000config=3D0x2f\000\00000\000\000\000\000\000"
+/* offset=3D129343 */
+"net_rx_multicast\000tool\000System-wide network received multicast packet=
s\000config=3D0x30\000\00000\000\000\000\000\000"
+/* offset=3D129432 */
+"net_tx_bytes\000tool\000System-wide network transmitted bytes\000config=
=3D0x31\000\00000\000\000\000\000\000"
+/* offset=3D129508 */
+"net_tx_packets\000tool\000System-wide network transmitted packets\000conf=
ig=3D0x32\000\00000\000\000\000\000\000"
+/* offset=3D129588 */
+"net_tx_errors\000tool\000System-wide network transmitted errors\000config=
=3D0x33\000\00000\000\000\000\000\000"
+/* offset=3D129666 */
+"net_tx_drop\000tool\000System-wide network transmitted dropped packets\00=
0config=3D0x34\000\00000\000\000\000\000\000"
+/* offset=3D129751 */
+"net_tx_fifo\000tool\000System-wide network transmitted fifo overruns\000c=
onfig=3D0x35\000\00000\000\000\000\000\000"
+/* offset=3D129834 */
+"net_tx_colls\000tool\000System-wide network transmitted collisions\000con=
fig=3D0x36\000\00000\000\000\000\000\000"
+/* offset=3D129915 */
+"net_tx_carrier\000tool\000System-wide network transmitted carrier losses\=
000config=3D0x37\000\00000\000\000\000\000\000"
+/* offset=3D130002 */
+"net_tx_compressed\000tool\000System-wide network transmitted compressed p=
ackets\000config=3D0x38\000\00000\000\000\000\000\000"
+/* offset=3D130096 */
 "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"
-/* offset=3D128845 */
+/* offset=3D130158 */
 "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"
-/* offset=3D128907 */
+/* offset=3D130220 */
 "l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"
-/* offset=3D129005 */
+/* offset=3D130318 */
 "segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"
-/* offset=3D129107 */
+/* offset=3D130420 */
 "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"
-/* offset=3D129240 */
+/* offset=3D130553 */
 "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"
-/* offset=3D129358 */
+/* offset=3D130671 */
 "hisi_sccl,ddrc\000"
-/* offset=3D129373 */
+/* offset=3D130686 */
 "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"
-/* offset=3D129443 */
+/* offset=3D130756 */
 "uncore_cbox\000"
-/* offset=3D129455 */
+/* offset=3D130768 */
 "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"
-/* offset=3D129609 */
+/* offset=3D130922 */
 "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"
-/* offset=3D129663 */
+/* offset=3D130976 */
 "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"
-/* offset=3D129721 */
+/* offset=3D131034 */
 "hisi_sccl,l3c\000"
-/* offset=3D129735 */
+/* offset=3D131048 */
 "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"
-/* offset=3D129803 */
+/* offset=3D131116 */
 "uncore_imc_free_running\000"
-/* offset=3D129827 */
+/* offset=3D131140 */
 "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"
-/* offset=3D129907 */
+/* offset=3D131220 */
 "uncore_imc\000"
-/* offset=3D129918 */
+/* offset=3D131231 */
 "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"
-/* offset=3D129983 */
+/* offset=3D131296 */
 "uncore_sys_ddr_pmu\000"
-/* offset=3D130002 */
+/* offset=3D131315 */
 "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"
-/* offset=3D130078 */
+/* offset=3D131391 */
 "uncore_sys_ccn_pmu\000"
-/* offset=3D130097 */
+/* offset=3D131410 */
 "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"
-/* offset=3D130174 */
+/* offset=3D131487 */
 "uncore_sys_cmn_pmu\000"
-/* offset=3D130193 */
+/* offset=3D131506 */
 "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"
-/* offset=3D130336 */
+/* offset=3D131649 */
 "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"
-/* offset=3D130522 */
+/* offset=3D131835 */
 "cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"
-/* offset=3D130755 */
+/* offset=3D132068 */
 "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"
-/* offset=3D131015 */
+/* offset=3D132328 */
 "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"
-/* offset=3D131246 */
+/* offset=3D132559 */
 "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"
-/* offset=3D131359 */
+/* offset=3D132672 */
 "stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"
-/* offset=3D131784 */
+/* offset=3D133097 */
 "frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D131963 */
+/* offset=3D133276 */
 "backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"
-/* offset=3D132137 */
+/* offset=3D133450 */
 "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"
-/* offset=3D132313 */
+/* offset=3D133626 */
 "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"
-/* offset=3D132493 */
+/* offset=3D133806 */
 "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"
-/* offset=3D132597 */
+/* offset=3D133910 */
 "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"
-/* offset=3D132713 */
+/* offset=3D134026 */
 "llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"
-/* offset=3D132814 */
+/* offset=3D134127 */
 "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"
-/* offset=3D132929 */
+/* offset=3D134242 */
 "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D133035 */
+/* offset=3D134348 */
 "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"
-/* offset=3D133141 */
+/* offset=3D134454 */
 "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"
-/* offset=3D133289 */
+/* offset=3D134602 */
 "CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"
-/* offset=3D133312 */
+/* offset=3D134625 */
 "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"
-/* offset=3D133376 */
+/* offset=3D134689 */
 "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"
-/* offset=3D133543 */
+/* offset=3D134856 */
 "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"
-/* offset=3D133608 */
+/* offset=3D134921 */
 "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"
-/* offset=3D133676 */
+/* offset=3D134989 */
 "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"
-/* offset=3D133748 */
+/* offset=3D135061 */
 "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"
-/* offset=3D133843 */
+/* offset=3D135156 */
 "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"
-/* offset=3D133978 */
+/* offset=3D135291 */
 "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"
-/* offset=3D134043 */
+/* offset=3D135356 */
 "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"
-/* offset=3D134112 */
+/* offset=3D135425 */
 "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"
-/* offset=3D134183 */
+/* offset=3D135496 */
 "M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"
-/* offset=3D134206 */
+/* offset=3D135519 */
 "M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"
-/* offset=3D134229 */
+/* offset=3D135542 */
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"
-/* offset=3D134250 */
+/* offset=3D135563 */
 "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"
 ;
=20
@@ -5262,6 +5294,38 @@ static const struct compact_pmu_event pmu_events__co=
mmon_tool[] =3D {
 	{ 128630 },
 	/* memory_uss\000tool\000Unique Set Size (USS) in bytes\000config=3D0x28\=
000\00000\00... */
 	{ 128716 },
+	/* net_rx_bytes\000tool\000System-wide network received bytes\000config=
=3D0x29\000\00... */
+	{ 128783 },
+	/* net_rx_compressed\000tool\000System-wide network received compressed p=
ackets\000... */
+	{ 129252 },
+	/* net_rx_drop\000tool\000System-wide network received dropped packets\00=
0config=3D0x... */
+	{ 129008 },
+	/* net_rx_errors\000tool\000System-wide network received errors\000config=
=3D0x2b\000\... */
+	{ 128933 },
+	/* net_rx_fifo\000tool\000System-wide network received fifo overruns\000c=
onfig=3D0x2d... */
+	{ 129090 },
+	/* net_rx_frame\000tool\000System-wide network received framing errors\00=
0config=3D0x... */
+	{ 129170 },
+	/* net_rx_multicast\000tool\000System-wide network received multicast pac=
kets\000co... */
+	{ 129343 },
+	/* net_rx_packets\000tool\000System-wide network received packets\000conf=
ig=3D0x2a\00... */
+	{ 128856 },
+	/* net_tx_bytes\000tool\000System-wide network transmitted bytes\000confi=
g=3D0x31\000... */
+	{ 129432 },
+	/* net_tx_carrier\000tool\000System-wide network transmitted carrier loss=
es\000conf... */
+	{ 129915 },
+	/* net_tx_colls\000tool\000System-wide network transmitted collisions\000=
config=3D0x3... */
+	{ 129834 },
+	/* net_tx_compressed\000tool\000System-wide network transmitted compresse=
d packets\... */
+	{ 130002 },
+	/* net_tx_drop\000tool\000System-wide network transmitted dropped packets=
\000config... */
+	{ 129666 },
+	/* net_tx_errors\000tool\000System-wide network transmitted errors\000con=
fig=3D0x33\0... */
+	{ 129588 },
+	/* net_tx_fifo\000tool\000System-wide network transmitted fifo overruns\0=
00config=3D0... */
+	{ 129751 },
+	/* net_tx_packets\000tool\000System-wide network transmitted packets\000c=
onfig=3D0x32... */
+	{ 129508 },
 	/* num_cores\000tool\000Number of cores. A core consists of 1 or more thr=
ead, with ... */
 	{ 125363 },
 	/* num_cpus\000tool\000Number of logical Linux CPUs. There may be multipl=
e such CPU... */
@@ -5307,39 +5371,39 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {
=20
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */
-	{ 130336 },
+	{ 131649 },
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */
-	{ 131963 },
+	{ 133276 },
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */
-	{ 132313 },
+	{ 133626 },
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */
-	{ 132493 },
+	{ 133806 },
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */
-	{ 130522 },
+	{ 131835 },
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */
-	{ 132137 },
+	{ 133450 },
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */
-	{ 132929 },
+	{ 134242 },
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */
-	{ 131784 },
+	{ 133097 },
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */
-	{ 131246 },
+	{ 132559 },
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */
-	{ 133035 },
+	{ 134348 },
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */
-	{ 133141 },
+	{ 134454 },
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */
-	{ 132597 },
+	{ 133910 },
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */
-	{ 132814 },
+	{ 134127 },
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */
-	{ 132713 },
+	{ 134026 },
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */
-	{ 130755 },
+	{ 132068 },
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */
-	{ 131015 },
+	{ 132328 },
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */
-	{ 131359 },
+	{ 132672 },
=20
 };
=20
@@ -5353,41 +5417,41 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {
=20
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {
 	/* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0=
0000\000\000... */
-	{ 128783 },
+	{ 130096 },
 	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */
-	{ 128845 },
+	{ 130158 },
 	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */
-	{ 129107 },
+	{ 130420 },
 	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */
-	{ 129240 },
+	{ 130553 },
 	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */
-	{ 128907 },
+	{ 130220 },
 	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */
-	{ 129005 },
+	{ 130318 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {
 	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */
-	{ 129373 },
+	{ 130686 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {
 	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */
-	{ 129735 },
+	{ 131048 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {
 	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */
-	{ 129609 },
+	{ 130922 },
 	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */
-	{ 129663 },
+	{ 130976 },
 	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */
-	{ 129455 },
+	{ 130768 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {
 	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */
-	{ 129918 },
+	{ 131231 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {
 	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */
-	{ 129827 },
+	{ 131140 },
=20
 };
=20
@@ -5400,61 +5464,61 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),
-		.pmu_name =3D { 129358 /* hisi_sccl,ddrc\000 */ },
+		.pmu_name =3D { 130671 /* hisi_sccl,ddrc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),
-		.pmu_name =3D { 129721 /* hisi_sccl,l3c\000 */ },
+		.pmu_name =3D { 131034 /* hisi_sccl,l3c\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
-		.pmu_name =3D { 129443 /* uncore_cbox\000 */ },
+		.pmu_name =3D { 130756 /* uncore_cbox\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
-		.pmu_name =3D { 129907 /* uncore_imc\000 */ },
+		.pmu_name =3D { 131220 /* uncore_imc\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),
-		.pmu_name =3D { 129803 /* uncore_imc_free_running\000 */ },
+		.pmu_name =3D { 131116 /* uncore_imc_free_running\000 */ },
 	},
 };
=20
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {
 	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
-	{ 133289 },
+	{ 134602 },
 	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */
-	{ 133978 },
+	{ 135291 },
 	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */
-	{ 133748 },
+	{ 135061 },
 	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */
-	{ 133843 },
+	{ 135156 },
 	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */
-	{ 134043 },
+	{ 135356 },
 	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */
-	{ 134112 },
+	{ 135425 },
 	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */
-	{ 133376 },
+	{ 134689 },
 	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */
-	{ 133312 },
+	{ 134625 },
 	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */
-	{ 134250 },
+	{ 135563 },
 	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
-	{ 134183 },
+	{ 135496 },
 	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
-	{ 134206 },
+	{ 135519 },
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
-	{ 134229 },
+	{ 135542 },
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */
-	{ 133676 },
+	{ 134989 },
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */
-	{ 133543 },
+	{ 134856 },
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */
-	{ 133608 },
+	{ 134921 },
=20
 };
=20
@@ -5468,15 +5532,15 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {
=20
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {
 	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */
-	{ 130097 },
+	{ 131410 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {
 	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */
-	{ 130193 },
+	{ 131506 },
 };
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {
 	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */
-	{ 130002 },
+	{ 131315 },
=20
 };
=20
@@ -5484,17 +5548,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,
-		.pmu_name =3D { 130078 /* uncore_sys_ccn_pmu\000 */ },
+		.pmu_name =3D { 131391 /* uncore_sys_ccn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,
-		.pmu_name =3D { 130174 /* uncore_sys_cmn_pmu\000 */ },
+		.pmu_name =3D { 131487 /* uncore_sys_cmn_pmu\000 */ },
 	},
 	{
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,
-		.pmu_name =3D { 129983 /* uncore_sys_ddr_pmu\000 */ },
+		.pmu_name =3D { 131296 /* uncore_sys_ddr_pmu\000 */ },
 	},
 };
=20
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d69f63b7fb1..a508e438bb03 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1899,6 +1899,46 @@ int evsel__append_addr_filter(struct evsel *evsel, c=
onst char *filter)
 	return evsel__append_filter(evsel, "%s,%s", filter);
 }
=20
+static int evsel__group_member_cpu_action(struct evsel *leader, struct evs=
el *member,
+					  int cpu_map_idx, bool enable)
+{
+	struct perf_cpu cpu;
+	int m_idx;
+
+	if (perf_cpu_map__equal(leader->core.cpus, member->core.cpus))
+		return enable ? evsel__enable_cpu(member, cpu_map_idx)
+			      : evsel__disable_cpu(member, cpu_map_idx);
+
+	if (member->core.reads_only_on_cpu_idx0) {
+		if (cpu_map_idx =3D=3D 0 && perf_cpu_map__nr(member->core.cpus) > 0)
+			return enable ? evsel__enable_cpu(member, 0)
+				      : evsel__disable_cpu(member, 0);
+		return 0;
+	}
+
+	if (leader->core.reads_only_on_cpu_idx0) {
+		if (cpu_map_idx =3D=3D 0) {
+			int nr =3D perf_cpu_map__nr(member->core.cpus);
+
+			for (m_idx =3D 0; m_idx < nr; m_idx++) {
+				int err =3D enable ? evsel__enable_cpu(member, m_idx)
+						 : evsel__disable_cpu(member, m_idx);
+
+				if (err)
+					return err;
+			}
+		}
+		return 0;
+	}
+
+	cpu =3D perf_cpu_map__cpu(leader->core.cpus, cpu_map_idx);
+	m_idx =3D perf_cpu_map__idx(member->core.cpus, cpu);
+	if (m_idx >=3D 0)
+		return enable ? evsel__enable_cpu(member, m_idx)
+			      : evsel__disable_cpu(member, m_idx);
+	return 0;
+}
+
 /* Caller has to clear disabled after going through all CPUs. */
 int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
@@ -1922,7 +1962,8 @@ int evsel__enable_cpu(struct evsel *evsel, int cpu_ma=
p_idx)
 				 * group leader. We must manually enable them in
 				 * userspace.
 				 */
-				int mem_err =3D evsel__enable_cpu(member, cpu_map_idx);
+				int mem_err =3D evsel__group_member_cpu_action(evsel, member,
+									     cpu_map_idx, true);
=20
 				if (mem_err)
 					return mem_err;
@@ -1991,7 +2032,8 @@ int evsel__disable_cpu(struct evsel *evsel, int cpu_m=
ap_idx)
 				 * kernel when disabling the group leader. We must
 				 * manually disable them in userspace.
 				 */
-				int mem_err =3D evsel__disable_cpu(member, cpu_map_idx);
+				int mem_err =3D evsel__group_member_cpu_action(evsel, member,
+									     cpu_map_idx, false);
=20
 				if (mem_err)
 					return mem_err;
@@ -2099,11 +2141,8 @@ static void evsel__exit(struct evsel *evsel)
 	if (evsel__priv_destructor)
 		evsel__priv_destructor(evsel->priv);
 	perf_evsel__object.fini(evsel);
-	if (evsel__tool_event(evsel) =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME ||
-	    evsel__tool_event(evsel) =3D=3D TOOL_PMU__EVENT_USER_TIME) {
-		xyarray__delete(evsel->process_time.start_times);
-		xyarray__delete(evsel->process_time.accumulated_times);
-	}
+	if (evsel__is_tool(evsel))
+		evsel__tool_pmu_exit(evsel);
 }
=20
 void evsel__put(struct evsel *evsel)
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 0ae08cd910bc..655b22104320 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -68,6 +68,22 @@ static const char *const tool_pmu__event_names[TOOL_PMU_=
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
@@ -271,6 +287,22 @@ static const char *tool_pmu__memory_event_to_key(enum =
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
@@ -435,13 +467,110 @@ static int read_statm(int fd, enum tool_pmu_event ev=
, u64 *val)
 	return -EINVAL;
 }
=20
+static bool tool_pmu__is_net_event(enum tool_pmu_event ev)
+{
+	return ev >=3D TOOL_PMU__EVENT_NET_RX_BYTES &&
+	       ev <=3D TOOL_PMU__EVENT_NET_TX_COMPRESSED;
+}
+
+static bool tool_pmu__has_start_times(enum tool_pmu_event ev)
+{
+	return ev =3D=3D TOOL_PMU__EVENT_USER_TIME ||
+	       ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME ||
+	       tool_pmu__is_net_event(ev);
+}
+
+static int read_net_dev_col(struct io *io, __u64 *val, int *term)
+{
+	int ch;
+
+	do {
+		ch =3D io__get_char(io);
+		if (ch =3D=3D -1 || ch =3D=3D '\n') {
+			*term =3D ch;
+			return -EINVAL;
+		}
+	} while (ch =3D=3D ' ' || ch =3D=3D '\t');
+
+	if (ch < '0' || ch > '9') {
+		*term =3D ch;
+		return -EINVAL;
+	}
+
+	*val =3D ch - '0';
+	while (true) {
+		ch =3D io__get_char(io);
+		if (ch >=3D '0' && ch <=3D '9') {
+			*val =3D (*val * 10) + (ch - '0');
+		} else {
+			*term =3D ch;
+			return 0;
+		}
+	}
+}
+
+static int read_net_dev(int fd, enum tool_pmu_event ev, __u64 *val)
+{
+	struct io io;
+	char buf[4096];
+	int index =3D ev - TOOL_PMU__EVENT_NET_RX_BYTES;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	lseek(fd, 0, SEEK_SET);
+
+	/*
+	 * Drop two header lines:
+	 * Inter-|   Receive                                                |  Tr=
ansmit
+	 *  face |bytes    packets errs drop fifo frame compressed multicast|byte=
s ...
+	 */
+	if (!read_until_char(&io, '\n'))
+		return -EINVAL;
+	if (!read_until_char(&io, '\n'))
+		return -EINVAL;
+
+	*val =3D 0;
+	while (true) {
+		int ch =3D io__get_char(&io);
+		int i, term =3D 0;
+		__u64 v;
+
+		if (ch =3D=3D -1)
+			break;
+		while (ch =3D=3D ' ' || ch =3D=3D '\t')
+			ch =3D io__get_char(&io);
+		if (ch =3D=3D -1)
+			break;
+		while (ch !=3D ':' && ch !=3D -1 && ch !=3D '\n')
+			ch =3D io__get_char(&io);
+		if (ch !=3D ':') {
+			if (ch =3D=3D '\n')
+				continue;
+			if (ch =3D=3D -1)
+				break;
+			read_until_char(&io, '\n');
+			continue;
+		}
+		for (i =3D 0; i < index; i++) {
+			if (read_net_dev_col(&io, &v, &term))
+				break;
+		}
+		if (i =3D=3D index && !read_net_dev_col(&io, &v, &term))
+			*val +=3D v;
+		if (term !=3D '\n' && term !=3D -1)
+			read_until_char(&io, '\n');
+		if (term =3D=3D -1)
+			break;
+	}
+	return 0;
+}
+
 int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
 				 int nthreads)
 {
 	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
=20
-	if (ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME || ev =3D=3D TOOL_PMU__EVENT_US=
ER_TIME) {
+	if (tool_pmu__has_start_times(ev)) {
 		if (!evsel->process_time.start_times) {
 			evsel->process_time.start_times =3D
 				xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
@@ -464,7 +593,8 @@ static int tool_pmu__read_stat(struct evsel *evsel, int=
 cpu_map_idx, int thread,
 {
 	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
 	bool system =3D ev =3D=3D TOOL_PMU__EVENT_SYSTEM_TIME;
-	int fd =3D FD(evsel, cpu_map_idx, thread);
+	int *fd_ptr =3D evsel->core.fd ? xyarray__entry(evsel->core.fd, cpu_map_i=
dx, thread) : NULL;
+	int fd =3D fd_ptr ? *fd_ptr : -1;
 	int err =3D 0;
=20
 	if (fd < 0) {
@@ -472,6 +602,13 @@ static int tool_pmu__read_stat(struct evsel *evsel, in=
t cpu_map_idx, int thread,
 		return 0;
 	}
=20
+	if (tool_pmu__is_net_event(ev)) {
+		if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
+			return read_net_dev(fd, ev, val);
+		*val =3D 0;
+		return 0;
+	}
+
 	lseek(fd, 0, SEEK_SET);
 	if (evsel->pid_stat) {
 		if (cpu_map_idx =3D=3D 0)
@@ -539,40 +676,58 @@ static int open_memory_pid_dir(enum tool_pmu_event ev=
, int pid,
 	return 0;
 }
=20
+static bool tool_pmu__is_initially_disabled(const struct evsel *evsel)
+{
+	const struct evsel *leader =3D evsel__leader(evsel);
+
+	return evsel->core.attr.disabled || (leader && leader->core.attr.disabled=
);
+}
+
 static int evsel__tool_pmu_open_one(struct evsel *evsel, enum tool_pmu_eve=
nt ev,
 				    int pid, int idx, int thread,
 				    int *seen_tgids, int *nr_seen_tgids)
 {
-	if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SYST=
EM_TIME) {
+	if (tool_pmu__has_start_times(ev)) {
 		__u64 *start_time =3D NULL;
 		__u64 *accumulated_time =3D NULL;
 		char buf[PATH_MAX];
-		int fd, err;
-
-		if (pid > -1) {
-			snprintf(buf, sizeof(buf), "%s/%d/stat", procfs__mountpoint(), pid);
-			evsel->pid_stat =3D true;
+		int fd =3D -1, err;
+
+		if (tool_pmu__is_net_event(ev)) {
+			if (pid > -1 || evsel->cgrp)
+				return -EINVAL;
+			if (idx =3D=3D 0 && thread =3D=3D 0) {
+				snprintf(buf, sizeof(buf), "%s/net/dev", procfs__mountpoint());
+				fd =3D open(buf, O_RDONLY);
+				if (fd < 0)
+					return -errno;
+			}
 		} else {
-			snprintf(buf, sizeof(buf), "%s/stat", procfs__mountpoint());
+			if (pid > -1) {
+				snprintf(buf, sizeof(buf), "%s/%d/stat", procfs__mountpoint(), pid);
+				evsel->pid_stat =3D true;
+			} else {
+				snprintf(buf, sizeof(buf), "%s/stat", procfs__mountpoint());
+			}
+			fd =3D open(buf, O_RDONLY);
+			if (fd < 0)
+				return -errno;
 		}
-		fd =3D open(buf, O_RDONLY);
 		FD(evsel, idx, thread) =3D fd;
-		if (fd < 0)
-			return -errno;
-
 		start_time =3D xyarray__entry(evsel->process_time.start_times, idx, thre=
ad);
 		accumulated_time =3D xyarray__entry(evsel->process_time.accumulated_time=
s,
 						  idx, thread);
 		*accumulated_time =3D 0;
=20
-		if (evsel->core.attr.disabled) {
+		if (tool_pmu__is_initially_disabled(evsel)) {
 			evsel->disabled =3D true;
 			*start_time =3D INVALID_START_TIME;
 		} else {
 			evsel->disabled =3D false;
 			err =3D tool_pmu__read_stat(evsel, idx, thread, start_time);
 			if (err) {
-				close(fd);
+				if (fd >=3D 0)
+					close(fd);
 				FD(evsel, idx, thread) =3D -1;
 				return err;
 			}
@@ -583,7 +738,7 @@ static int evsel__tool_pmu_open_one(struct evsel *evsel=
, enum tool_pmu_event ev,
 		if (evsel->cgrp)
 			return -EINVAL;
=20
-		evsel->disabled =3D evsel->core.attr.disabled;
+		evsel->disabled =3D tool_pmu__is_initially_disabled(evsel);
 		if (pid > -1) {
 			evsel->pid_stat =3D true;
 			if (idx =3D=3D 0) {
@@ -623,7 +778,7 @@ int evsel__tool_pmu_open(struct evsel *evsel,
=20
 	if (ev =3D=3D TOOL_PMU__EVENT_DURATION_TIME) {
 		evsel->duration_time.accumulated_time =3D 0;
-		if (evsel->core.attr.disabled) {
+		if (tool_pmu__is_initially_disabled(evsel)) {
 			evsel->disabled =3D true;
 			evsel->duration_time.start_time =3D INVALID_START_TIME;
 		} else {
@@ -834,6 +989,22 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
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
@@ -928,7 +1099,11 @@ int evsel__tool_pmu_enable_cpu(struct evsel *evsel, i=
nt cpu_map_idx)
 		return 0;
 	}
=20
-	if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SYST=
EM_TIME) {
+	if (tool_pmu__has_start_times(ev)) {
+		if (!evsel->process_time.start_times || cpu_map_idx < 0 ||
+		    cpu_map_idx >=3D xyarray__max_x(evsel->process_time.start_times))
+			return 0;
+
 		nthreads =3D xyarray__max_y(evsel->process_time.start_times);
 		for (thread =3D 0; thread < nthreads; thread++) {
 			__u64 *start_time =3D xyarray__entry(evsel->process_time.start_times,
@@ -979,7 +1154,12 @@ int evsel__tool_pmu_disable_cpu(struct evsel *evsel, =
int cpu_map_idx)
 		return 0;
 	}
=20
-	if (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__EVENT_SYST=
EM_TIME) {
+	if (tool_pmu__has_start_times(ev)) {
+		if (!evsel->process_time.start_times || !evsel->process_time.accumulated=
_times ||
+		    cpu_map_idx < 0 ||
+		    cpu_map_idx >=3D xyarray__max_x(evsel->process_time.start_times))
+			return 0;
+
 		nthreads =3D xyarray__max_y(evsel->process_time.start_times);
 		for (thread =3D 0; thread < nthreads; thread++) {
 			__u64 *start_time =3D xyarray__entry(evsel->process_time.start_times,
@@ -1065,11 +1245,29 @@ int evsel__tool_pmu_read(struct evsel *evsel, int c=
pu_map_idx, int thread)
 		}
 		break;
 	case TOOL_PMU__EVENT_USER_TIME:
-	case TOOL_PMU__EVENT_SYSTEM_TIME: {
-		__u64 accumulated =3D *(__u64 *)xyarray__entry(evsel->process_time.accum=
ulated_times,
-							     cpu_map_idx, thread);
-
-		if (evsel->disabled) {
+	case TOOL_PMU__EVENT_SYSTEM_TIME:
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
+		__u64 *accumulated_ptr =3D evsel->process_time.accumulated_times ?
+			xyarray__entry(evsel->process_time.accumulated_times, cpu_map_idx, thre=
ad) :
+			NULL;
+		__u64 accumulated =3D accumulated_ptr ? *accumulated_ptr : 0;
+
+		if (!accumulated_ptr || evsel->disabled) {
 			delta_start =3D accumulated;
 		} else {
 			__u64 *start_time =3D xyarray__entry(evsel->process_time.start_times,
@@ -1078,13 +1276,14 @@ int evsel__tool_pmu_read(struct evsel *evsel, int c=
pu_map_idx, int thread)
=20
 			err =3D tool_pmu__read_stat(evsel, cpu_map_idx, thread, &cur_time);
 			if (!err) {
-				if (*start_time !=3D INVALID_START_TIME && cur_time >=3D *start_time)
+				if (start_time && *start_time !=3D INVALID_START_TIME &&
+				    cur_time >=3D *start_time)
 					delta_start =3D accumulated + (cur_time - *start_time);
 				else
 					delta_start =3D accumulated;
 			}
 		}
-		adjust =3D true;
+		adjust =3D (ev =3D=3D TOOL_PMU__EVENT_USER_TIME || ev =3D=3D TOOL_PMU__E=
VENT_SYSTEM_TIME);
 		break;
 	}
 	case TOOL_PMU__EVENT_MEMORY_SIZE:
@@ -1163,6 +1362,18 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cp=
u_map_idx, int thread)
 	return 0;
 }
=20
+void evsel__tool_pmu_exit(struct evsel *evsel)
+{
+	enum tool_pmu_event ev =3D evsel__tool_event(evsel);
+
+	if (tool_pmu__has_start_times(ev)) {
+		xyarray__delete(evsel->process_time.start_times);
+		xyarray__delete(evsel->process_time.accumulated_times);
+		evsel->process_time.start_times =3D NULL;
+		evsel->process_time.accumulated_times =3D NULL;
+	}
+}
+
 struct perf_pmu *tool_pmu__new(void)
 {
 	struct perf_pmu *tool =3D zalloc(sizeof(struct perf_pmu));
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index 99a2ea1548f8..f972995bb8ed 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -50,6 +50,22 @@ enum tool_pmu_event {
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
@@ -87,6 +103,7 @@ int evsel__tool_pmu_enable(struct evsel *evsel);
 int evsel__tool_pmu_disable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__tool_pmu_disable(struct evsel *evsel);
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)=
;
+void evsel__tool_pmu_exit(struct evsel *evsel);
=20
 struct perf_pmu *tool_pmu__new(void);
=20
--=20
2.56.1.703.gf848ed807c-goog

