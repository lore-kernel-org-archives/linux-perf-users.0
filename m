Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599805;
	b=T15ASYaGrxXNoXpEUFXkazTx6DGkJnlMYj9/rpPCmr5JP29Jriej10D16afjfSqOY9/a
	 20E2b5wMqdIOjaQhwzCLTjI1avHN8V7jcWW1N88LaGeAjQcXgFSwSHt1SMKPon7jeP3xZ
	 3hSGKbvmw6vCECVjgrIrem/NmBs47ArxHeJPcpEyCGtGbDzdKhVFBuVIJ491a9mg5m4bN
	 7UCu3U9tuv2hCI29EXLo8jxIxgYVL8uHzrsGK3yOkrwU63OuNK/piAXX+Sfji+mlIAUXv
	 /W9qR9B9+y1A0IMwwuZV2dp9a9QZi2TN/Cr5x3MydmdDpMJ0N7FZGgXAEQKxMgAAHjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=alUsT6tB8c3WBQ6I+4BYYZdSGxCj/aXdWbdqfV5rbso=;
	b=meiZlrJSmkyjVxNZ1SZ2S6N6jMpQoKtYPJ8cdXb4iLvftobjrZlwQHwwG1iHJ5n5ijSL
	 6JPPAJQckg+Y1yBd61zxkUyMB1xJuZTfBT4BtRBFQEK7IkJcO0iXxw+C3nUHYpj8Afn7v
	 8LVvaTwSIHm6S/zTOldzUz9hKOwsHzA7Mlr4h3L34yc/jG41fwfrzZ6a1gh2BXJO3AAQE
	 l6d7xLNlieCZIcgMXngYDzZxNZIkAj3tXAV599h/ynmEKAKpe+Mcb46lWoyHkP0RX1S3E
	 ikT1KZcfufJkOuZpJ6HBEr5ZACvtd2Cm8+f/u9Rpr4RbUn3bBHiweCMJGh2S5Cb/gWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kSnl+4Gr;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4336070457
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4336070457
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kSnl+4Gr
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b3b5b49cabso1248871c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599804; x=1795204604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alUsT6tB8c3WBQ6I+4BYYZdSGxCj/aXdWbdqfV5rbso=;
        b=kSnl+4Gr0OVvvjlzZ1esfhWB3IuSwrmcWnG5c/Sv9kbwm03WcrOiP1miikFRWwfn/v
         QXKpxyK8rwGsnBdt9kSGXMUso6WxpcTpCC7byJEzzRUqSMPLVT55EviymeRY5Ovt7DBD
         Zx6hPkpxwcHT/v1NK1+7LxdkOwgcLTGooeK4/d+hq16YZje5KGuJ0SK7APdXwKvXIyll
         NJduLVVgPFQTlaFXGLkFjsDBHdzBmHZzJ+4tG47MThmJ+nFCyKJcYns8jj59oEt4DBGO
         EqOMGlJzrTSaE4pK9H93u/V5ytQ2czAGdwe3/kS4naKBRa6TGTclim9pkTDQe7N4Flce
         UKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599804; x=1795204604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alUsT6tB8c3WBQ6I+4BYYZdSGxCj/aXdWbdqfV5rbso=;
        b=g3Nnm5iW1fU+a+2TzabTh+eQXCpEa2pZljQyo645XJiWeMgcDw8JALgZXewA4zNsCd
         Di6Rdh7mJwUoS+eAStF5BR1SvpvdHBJFbBCFhGtRuTW7mKNhge3jF1fcDQ/dq1/w9tm3
         YYpgunvMb93weYdTOqpuJVcd05BTmkj/PTy0QVB89L2dPiBEfzdhyEv+lpmFOHwuzPOM
         op5XMaapcaz7EBoJXTSesB5LLJB0BL4kTKUloSYbCaBLpU4XRQh4vIKGmRC4qdEvjE/x
         Af8N7Am3hiVmStELolW2JA9ij+HxI53qbyk0rDOekFHz5CKKeJpwniDnV3ktLeTB1Yvz
         jsrw==
X-Gm-Message-State: APuU4Z8zpLXx2QSRzVPVC55S43r6dkSuYmjUJP++hw4+rLB/ssmm31in
	bunt8MSssIvM1eCaxfTsEGKUDJmxSPhku6ACmhYoSFfHYmcPIW3pKNBLTR74eHSkPqQBGQFwmgL
	wP+8UsP9W0A==
X-Received: from dlbsn7.prod.google.com ([2002:a05:7022:b907:b0:197:f679:f62d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:205b:20b0:1b3:ad63:b9c2
 with SMTP id a92af1059eb24-1b5030f8819mr3223017c88.22.1794599803740; Fri, 13
 Nov 2026 11:56:43 -0800 (PST)
Date: Fri, 13 Nov 2026 11:56:00 -0800
In-Reply-To: <20261113195601.2872738-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195601.2872738-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-16-irogers@google.com>
Subject: [PATCH v2 15/16] perf docs: Add perf-sysinfo man page
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the 'perf sysinfo' subcommand and its options in
Documentation/perf-sysinfo.txt and link it from Documentation/perf.txt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-sysinfo.txt | 113 ++++++++++++++++++++++
 tools/perf/Documentation/perf.txt         |   2 +-
 2 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-sysinfo.txt

diff --git a/tools/perf/Documentation/perf-sysinfo.txt b/tools/perf/Documentation/perf-sysinfo.txt
new file mode 100644
index 000000000000..c72ac6d51551
--- /dev/null
+++ b/tools/perf/Documentation/perf-sysinfo.txt
@@ -0,0 +1,113 @@
+perf-sysinfo(1)
+===============
+
+NAME
+----
+perf-sysinfo - Display and probe PMU and system performance monitoring information
+
+SYNOPSIS
+--------
+[verse]
+'perf sysinfo' [<options>] [pmu_glob ...]
+
+DESCRIPTION
+-----------
+This command displays a summary of the performance monitoring capabilities of
+the current system or a perf.data file, including core PMU features (precise
+sampling, branch stack sampling, user-space counter reading, memory profiling,
+and hardware AUX trace PMUs), memory and PCIe/IO interconnect bus bandwidth
+monitoring support, total events and metrics, pipeline metric drill-down levels
+discovered via '<metric>_group' hierarchies, and an overall system rating.
+
+When '-p'/'--pmus' is specified (or when PMU filter globs, '-v'/'--verbose',
+'-a'/'--all', or '-j'/'--json' are given), it also displays detailed
+information for each PMU, including its perf_event_attr type, kind (core,
+uncore, software, auxtrace, tool, hwmon, drm), CPUs/cpumask, capabilities,
+sysfs format bitfields, event counts, and memory profiling events.
+
+When run on a live system (without '-i'/'--input' and with probing enabled),
+it also actively probes the kernel via 'perf_event_open' to determine:
+- Supported modes (counting, interrupt-based sampling, branch_stack sampling)
+- Supported precise sampling levels, skid semantics, and empirically measured
+  branch instruction skid (minimum, maximum, average instructions from the
+  branch and 'PERF_RECORD_MISC_EXACT_IP' ratio) at each supported precision
+  level:
+  0 ('SAMPLE_IP' can have arbitrary skid), ':p' / 1 ('SAMPLE_IP' must have
+  constant skid), ':pp' / 2 ('SAMPLE_IP' requested to have 0 skid), and
+  ':ppp' / 3 ('SAMPLE_IP' must have 0 skid, or uses randomization to avoid
+  sample shadowing effects)
+- Supported 'perf_event_sample_format' sample types ('ip', 'tid', 'time',
+  'addr', 'read', 'callchain', 'id', 'cpu', 'period', 'stream_id', 'raw',
+  'branch_stack', 'regs_user', 'stack_user', 'weight', 'data_src',
+  'identifier', 'transaction', 'regs_intr', 'phys_addr', 'aux', 'cgroup',
+  'data_page_size', 'code_page_size', 'weight_struct')
+- Supported user and interrupt registers for 'PERF_SAMPLE_REGS_USER' and
+  'PERF_SAMPLE_REGS_INTR', listing separately the interrupt registers that
+  can only be sampled with precise sampling (e.g. x86 XMM registers captured
+  by PEBS)
+- Supported memory profiling events ('ldlat-loads', 'ldlat-stores', 'mem-ldst')
+  and their supported memory sample types ('data_src', 'addr', 'weight', etc.)
+- Supported privilege/exclusion modifiers ('exclude_user', 'exclude_kernel',
+  'exclude_hv', 'exclude_idle', 'exclude_host', 'exclude_guest')
+- Supported execution features ('leader_sampling', 'sw_grouping', 'inherit',
+  'sample_freq', 'write_backward', 'callchain', 'data_src', 'weight',
+  'pinned', 'exclusive', 'format_lost', 'auto_counter_reload',
+  'aux_start_paused', 'aux_pause', 'aux_resume', 'aux_sample', 'user_rdpmc',
+  'user_time', 'user_time_zero', 'user_time_short') and hardware counter
+  bit-width ('pmc_width') when user-space counter reading is supported
+- Maximum number of events in a group counted simultaneously, without
+  multiplexing, and for core PMUs the maximum number of general-purpose
+  counter events. Groups larger than this may be accepted by
+  'perf_event_open' but can't be counted together
+
+At the end of the text output, a summary section reports overall core PMU
+capabilities (including hardware AUX trace PMUs), memory and PCIe/IO
+interconnect bus bandwidth monitoring support, total events and metrics, and
+pipeline metric drill-down levels discovered via '<metric>_group' hierarchies.
+
+By default, numbered uncore PMU instances sharing a common prefix are collapsed
+into a single entry showing the instance count, unless '-v'/'--verbose' is
+specified.
+
+OPTIONS
+-------
+-i::
+--input=::
+	Input file name to read PMU information from (e.g. perf.data).
+
+-f::
+--force::
+	Don't complain, do it (when reading input perf.data file).
+
+-o::
+--output=::
+	Output file name.
+
+-p::
+--pmus::
+	Display detailed information for each PMU in addition to the system
+	summary.
+
+-j::
+--json::
+	Encode PMU information as JSON.
+
+-a::
+--all::
+-v::
+--verbose::
+	Display all PMUs including all similar PMUs with alphanumeric suffixes
+	instead of collapsing numbered uncore PMU instances.
+
+--probe::
+--no-probe::
+	Enable or disable active kernel probing of PMU capabilities on the live
+	system (default: enabled).
+
+--debug::
+	Enable debugging output.
+
+SEE ALSO
+--------
+linkperf:perf-list[1], linkperf:perf-evlist[1], linkperf:perf-stat[1],
+linkperf:perf-record[1]
diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index cbcc2e4d557e..0890dd5a1794 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -92,5 +92,5 @@ linkperf:perf-help[1], linkperf:perf-inject[1],
 linkperf:perf-intel-pt[1], linkperf:perf-iostat[1], linkperf:perf-kallsyms[1],
 linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
 linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
-linkperf:perf-script[1], linkperf:perf-test[1],
+linkperf:perf-script[1], linkperf:perf-sysinfo[1], linkperf:perf-test[1],
 linkperf:perf-trace[1], linkperf:perf-version[1]
-- 
2.56.1.703.gf848ed807c-goog

