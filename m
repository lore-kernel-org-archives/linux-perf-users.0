Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213652;
	b=UdX331TG8X25a8mf53Qm9FWcf7K3aGA/SMC8w6v/L6aT7ARt1QbAJU5+pmnFFMVCLp2W
	 aBO6eYWJsp3HWvoCN4mMgNMSCdQyIatfpx8Qvl8rpSjeQoYTvcV49Q5LWx4AQzSkIyeRx
	 XAPZeI7g0dJhmdBlIkGTi2HfmRfdcV86dBIJ/45d20gF5zRRHc6LaHQu/uzTsChCctEA1
	 +Sq2xTZJvUGmW1hqzWd5AAdpT3hgijaTznb+lVNwrBvYHj+Ep1cCHrYD0Q6nLF8cBnthg
	 gCmrWjT/9nIBNM6zNG5jqzjOzXVDrlqsU8ttqMQS1KsImq9pvga4gWOHtKSMOfh6QVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=osNQvC8QiSJ/mamOIrIcj3vuWvYLpacDjmXwlnwYJNM=;
	b=YVMtOcEuMdIBabd3dILJfLypjag3IdpVk0RuvftRodK9CF3sfDYHfIdtLDQs72uCNlWM
	 2d21IBB1s8KxVG3et2kzwJ29iXS92sgj8V/7CdXPf6UFlyfIuCwI9fIZC6NE8lpDOL+dX
	 n3sTcQO3p90zOhfmHCpqWBxx3Ty91ZIwZptuHN7wGJv+eAxuRO5z44/JDbdgUi3dG0/rt
	 s9KUyR9LkqpS5MOern1li8VN1mf6iD8Rl563H28CmhspJSdSjoUK/h/jgceOCYtAzmtbW
	 pWROLgDcQUgzK6TzzgWxL9lzQw3JOvNcHHzi5xVH0nzZQs8ICgGU12ekf54HU7U2O7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eVs0LVw2;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CB60A2610
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46CB60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eVs0LVw2
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383435e46f9so1169264eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213645; x=1795818445; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osNQvC8QiSJ/mamOIrIcj3vuWvYLpacDjmXwlnwYJNM=;
        b=eVs0LVw2n9/cuKe8WkdUryI7q4tOUDkwVsBI1GYUQvP8DSyMGWAK8B+wL3AEEHIXHS
         8DP5z3B3Hs0ocbBXhmMsULuzx0nz9IXEhjGyuuBMM4jG6alXKEnbi8fLnP0I5fvAL3UL
         TfTdas2Y88aXBzLWDWZcRAzwp4lXHJzmdTfXrm+1GrNIB6f0eBKnNoG1m0bgU/705QRP
         MiT6EJXHLcWswv34DFFjNCy/msvgBG6Xown9grMDW4GZ0QH9d6Zw1EfGh0HrgeUFpeCY
         fDjYrrhXFs6D6wk2OubMbmg3IOnRJioL7r+OV1EF0V88iJNO5IKzIoGm9a/92jFG5L4y
         AqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213645; x=1795818445;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=osNQvC8QiSJ/mamOIrIcj3vuWvYLpacDjmXwlnwYJNM=;
        b=U36D0VcjELXbR47JxY687S67NFwAS+JuiA75y0uwJ7LeZf/ytVd6L1F6c29+1+a61V
         zj3LXUu2kJ4d45W/rX7YPyLLhkrXryVwsrwmLdZK7i/7x/5d6xX3m/IOECqy9JwYjFed
         0IxYojHARDlJZ2Ey4Av55GKPpnTNvGjYtf4GHG2xbLZW5tuS1GQzjE9lkXtq2fOL4iR0
         wVkso7oNXeVOhvG7WgzkhU2BnkaAGnU4Jj2miLTEJ0/v15vMsCJOd3kDo5rQba9KAIF3
         EeUbnxOeeBaaPlYSUoFWSltPr+o7J9iWx89hVWNIyqFWX7oG/okyb9mjOppsSNWgqxfr
         V7Bw==
X-Gm-Message-State: APuU4Z/AnDAGpcwUMpk2hxk79UjvAbVDImAKdImgPnkFaWyEGcGQ1c1C
	VPcwkTJukWV5k1Nz19P8FiEn8sisLigLrxvoqDU9r9FVo13B9XZQn6Z4z4Uw5P3cOdRBNBfy9bj
	g78ASUyfsZQ==
X-Received: from dyp9.prod.google.com ([2002:a05:693c:65c9:b0:384:337f:4cb1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6aa1:b0:36a:1cbc:1093
 with SMTP id 5a478bee46e88-3857025b56bmr3894681eec.30.1795213644543; Fri, 20
 Nov 2026 14:27:24 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:14 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-16-irogers@google.com>
Subject: [PATCH v3 15/16] perf docs: Add perf-sysinfo man page
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
2.56.1.750.gf70dc682cf-goog

