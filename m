Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369753EB0FB
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263310; cv=none; b=i8OJuIFSSqMub3IYdAjb4ybDE7xsE3y8CKgF9DksRiJKRLJ4JPzRKf7oI2TldtF4ZZCn6GZDy4QqsT4DDjqZsC//CDUzf4uuVVmrEiG64dYPTlrp0uuAoiUWOfUgx0V0olQB3/zZcdPKEWaKu+amngb0x4tCPmSCPqdloRsK7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263310; c=relaxed/simple;
	bh=L15DZwS8vJf+vutDVWBhGT/BxHD9zNiMsSgFztErphM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVrfF2AC+EiaefKfm9mH3sHm5d7pjwE3TPcmzRlVdutSgr9MlGLbBY8BOqM0+brecKRDkHPbyXNnzd9JnIafAkfzSZ0l7lplzMqyFl4Q8cgJaGt6hG1tHf+DRxugitd6aYZzfuZ0IVuo0JvOJpiabz8LQucjymKMe8kDD2hsypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8HXT3Ua; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8HXT3Ua"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2791220eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263308; x=1792868108; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eIo93ly80GTuyS4D52+NfsbWDHHAw9rD4/wLisRqkRc=;
        b=Q8HXT3UaWlnmUGfwwGOReH9ygQ/9sdBxTPABxRs5T3U2X6EFWOtoZOdGsFQMnwQ/7i
         +ruczD2zF/U2mME+Jr0sNYYsfs6lPbp8330BS7auJ+dnGVmX8sGSFq2l41TdTwRn1c3N
         oCptiIBofYlYWDa9SECdNVAtkmkoOWltpd+Qh1RxKSOWXxrJIpImJYSbUuuhZcldAgUL
         Uyjr5Hgwc2wLg8hM9iiQELIAkQB4mHnncLfYbj8QIQc34nio+r2lEbN0IsjW2qReYoOS
         jNwqpDVmkmk5fq0lKChBvUVXKnBn85V84GX4KqI+kCmOXWT80Or52EUTukH275i703mW
         /5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263308; x=1792868108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIo93ly80GTuyS4D52+NfsbWDHHAw9rD4/wLisRqkRc=;
        b=QMzzVWKggK3S7Kp8NIAdQnf33+FzranajKgW0TkCn1zVNRYrxS/uttv7daLSgW0kn1
         14EkHGjBF664FM4RvRZk5qJdg9yNgdZU6fvLQGXhot2OpDdSCo0smwMcThJ5kXbMgECq
         MPVcD7/PDpBpgIwkMgGT1I37kwrUKSBF/TKNzo9o6W2jOAHri+cVrTF8JoQDyVfSdiiS
         ZTg3xF2gJObiHaP2uNe7e7nZ6YUuHCvOU/baJ9c9EjMmpieqBAyFYNvdQMZjJVbY/FyL
         3YKcDGkkFXd72X8sbt4QvtWVR9ywRroGRoApWwSeXc2CzE2GDip6pUCX4KgN9bWVEHa5
         H9Aw==
X-Forwarded-Encrypted: i=1; AKwUvBy1DEaDgVGY4cnF8T14+8koRWnAIdfoS4GXBRexGEnwa4g2H5i5syjxlYL81ncyR/QlBr0DpBW9DWnEXU7Fm4tc@vger.kernel.org
X-Gm-Message-State: AFq9FYInl+A87aeMdqFg0AC33zyNw94djFVCKKdF0fYFQiolm4TkZP3I
	XeiE3V+cn86xvhsFeRJy/LjFyHxLGtLUSIsP2J3lig3Wk965ajwaEAhlvCXHZSggnvlZkHlv5d+
	Z/pB5lArNxw==
X-Received: from dycmp24.prod.google.com ([2002:a05:7301:718:b0:35c:794:f74])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:da84:b0:359:3460:bc1c
 with SMTP id 5a478bee46e88-361a1370570mr4898151eec.12.1792263307953; Sat, 17
 Oct 2026 11:55:07 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:41 -0700
In-Reply-To: <20261017185442.2137623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com> <20261017185442.2137623-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-9-irogers@google.com>
Subject: [RFC PATCH v2 8/9] perf docs: Add perf-sysinfo man page
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Document the 'perf sysinfo' subcommand and its options in
Documentation/perf-sysinfo.txt and link it from Documentation/perf.txt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-sysinfo.txt | 109 ++++++++++++++++++++++
 tools/perf/Documentation/perf.txt         |   2 +-
 2 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-sysinfo.txt

diff --git a/tools/perf/Documentation/perf-sysinfo.txt b/tools/perf/Documentation/perf-sysinfo.txt
new file mode 100644
index 000000000000..4fc5fe229060
--- /dev/null
+++ b/tools/perf/Documentation/perf-sysinfo.txt
@@ -0,0 +1,109 @@
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
+  'PERF_SAMPLE_REGS_INTR'
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
+- Maximum event group size accepted by 'perf_event_open' and maximum
+  simultaneously active counters in a group without multiplexing
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
2.56.0.212.g129ede20d9-goog

