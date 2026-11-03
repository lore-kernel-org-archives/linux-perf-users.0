Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749614;
	b=Evwl1tmAaJkR2AWKJGH9EWcslqC+9fZEiqvkoOyO7zAYvjEbeJNDmkAXbAFg+xVeeyTS
	 Pk2vdZvYKlhRqAOP9EGpL8i9XXm9QxsygHD9l9xKFlmVE3bHGq7zMZtYGE0irT7CZg3wE
	 EYJxZoLfyGA7lgQgQJOG1FpISZrWVnowJZK6HDRHr1SI32yUHDAg/x4AA64I3/f2YSPI9
	 kQ5IgxiKIXnMiRoZKVVGcEuXY0R+vaLA0aU04cZCUkjzq5zXKCWynFuQaBQ4y+RvbEboW
	 DR0CBklUPeExq4ahZJA4nci5x7WQA3ab1XFf0x0CLhjEhBWjskwyJYH2bNGGfljcxIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8PmWEqVL7wU33i6pGMrEamqHBW2E7WIcuhgNZRLyzik=;
	b=FFZLUXrTthyOr5p357bfj/GAAqg4Hd1ktPqvZJq25mjnPpCosEpTunBCFZKX+E6cqqHN
	 DLLZk5AfisBx9pVF1griuE89Yrx3FoK122yRV+kN8WP76OX4pTDhOSy1sglwt8lMcBPdB
	 2VFzazkmzDsGpx2SUjtbjlfSw0ieujyC6X2JNSiLrgMvU4/GUOSIeeniYxdnT+NE5hZt2
	 cEKQefGrI/Y8Q9t4Jt3cF9ABjChgd4A5IHIM92fxAa8+/fK95Nw980eC4Qx4DajlXdPKi
	 c9yLwTYbo/C1UTw4c7LcfPN2P4GU8B8i5TAasVMB6HDBDkXuAnQZVBr7laJPL1ECxsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="cjWo/Clq";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643160A5BC8
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E643160A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cjWo/Clq
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso323119a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749613; x=1794354413; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PmWEqVL7wU33i6pGMrEamqHBW2E7WIcuhgNZRLyzik=;
        b=cjWo/ClqgRvest9xlcRjSiiPHl038ofABMAB84OpqpVuGXUOVDaogMtI2EJC8mfRHm
         UwzJLBAqH5BW9HmLTZuY8UB3TRcGAl1eATZYq0eSGsBWlldmRi7G81Btwer7J8Fn61dm
         +iVZtliZy3s6bfPfMDmapB935auZAkL4F0snOhaqi9Pp/ZzYJN+0eJLCZM+UPhsy5OhA
         T8LchHAMI0fdsczTYNEtmYYlPgsKXmwhDknBR/k1gSoIEdddbDy67SkloovaVDYmuLeB
         Cly/vVEM/VLKairSqwfHMNM1t4tbHk3X/twhib5bgR4zNaNzDgAbspX9fBj9AXihDn34
         BEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749613; x=1794354413;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PmWEqVL7wU33i6pGMrEamqHBW2E7WIcuhgNZRLyzik=;
        b=jr7s5OgZdhgm4SVbfgugBFwOMw6DpRUYKZRqcgx6E7BKdrBegzvAQcYdLvnHQZzKe5
         p7ZMahyZNpFDS633frclM0pm5D6pKXZvpQAvMdXBDkaOUK+WmTkjBSLuWkM3fnzlLKJ4
         a4q2RHAzRUx+w1KpmER6ZsgJd1t6B70drRBjiUuL8n3uNvVBXDvXZ/xAOIMr4PRArmnM
         tkvekq1kVyW0DM/RmiH9oqKMbv1SSPOnUtqME8gumL4aSAt3KyubhP7WM4oXGc4jZNki
         kunLz5ME9GReCQs5ILGATQMtMlxRkoDXR3qL1iohA6/Hqjv3sNUfIX7TT/BkGCqsFijc
         f0Lw==
X-Gm-Message-State: APuU4Z+ELWJsVUaHIMERwwuAdCBuh8aBEeDWjb4ZX0b04WPDfLhNrqJ2
	cKucm9Rhqg2srv6nuHrJdshqkCRNEVZh4tjxWpdZPbt5BuGKmBos2Jlw7bIRcnVaZf1dyuk756e
	Lwzrw3zqde2LKe1dqdAewwL03VLZE0jMgRdiwO3qjcXHfrSbaHWNrQMAqbKBtJWpQOkmqG4ftmK
	+Fwne4+O6UxnPJtJ2WOaFBI9/DPKlLYKO3PtnDKRWgFFjLQu0bpm+mqzg=
X-Received: from pjbca10.prod.google.com ([2002:a17:90a:f30a:b0:3ab:1f17:8066])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2641:b0:3ac:8446:c1b5
 with SMTP id 98e67ed59e1d1-3ae8974b804mr11459578a91.31.1793749613054; Tue, 03
 Nov 2026 15:46:53 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:56 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-41-irogers@google.com>
Subject: [PATCH v1 40/41] perf docs: Add perf-sysinfo man page
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
2.56.0.385.gac671c819a-goog

