Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A25277C86
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620694; cv=none; b=KsnNKCYyKrF6MA535khO4f8weDo+bChavNgUw5oZnxD++icgT+GTZfMG9WKB6l4MFz6+T4nAJfwQrnr6deoQdMn/RuTp/Iv7QctEDcmKKeCrHbJI9hFILVFHmBo09L3mtiFjfMOUWhLCD04GnegVVPGOMDR23vBkLvxnymbImqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620694; c=relaxed/simple;
	bh=9VtX2NvFz0RoQVJ8SSqGMuTYPnLO3r9LWpqks/kmpMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pqZ2Qkyx2AK5GqU+Xa/JutOhxuCLujT3xwpzSAWfJ0UYj/O9fUtcmv2V9t6d0qisR3bSPJ22jvGifbC+Ir9zYFC3WzlWJABlnycyJdd46mtFiHW2NwZm9Wz5Oicp7h1IJEmeTCPn0WbD3n0rf4S/iSN+u8Gf7geNZwCzk39rw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkNbt3ou; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkNbt3ou"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297fbfb4e53so69662105ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764620691; x=1765225491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuYJ8a9yf5YfCIOX0vDCxkx5Zc9d0WA0EbWHTfFbCpI=;
        b=jkNbt3ouuc6NmxFq5apXPbnMYpm1+zjWpeLCHENUhZshBHu5HtyWtBRrtrgDl7yalQ
         OtXQasM1U+p8W2X/IYCa2cUExCHo0oVWoB8FJsSl1BeopyHbTrYz+9YzTGuqlAKYUaQI
         IJapEgCG+EizpaCFsG6l5ATwt5rzAJ4+tDTdFaxXAEItPwJu0MKHQ7YGAErlkZb1XXhU
         MWgjhSmcDoofFGwbkjtHo5nMbpLoUUNjN5loYr7jv9kC3Q+I/88Ak23hMapuj4HFYfBO
         son19Lz+dHz87y71srH8WwtEHospUet67m9ZKRWT2Iyh2vFf+e/JVNXH8Z5jFwFJqBQ3
         1TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764620691; x=1765225491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuYJ8a9yf5YfCIOX0vDCxkx5Zc9d0WA0EbWHTfFbCpI=;
        b=cvMP+GcnM9ID+CbqNo8MGu/u7ZBavi8nT/LLDa/KL6VP7xE2DMrIMRURnKwdM3CBfV
         T5vQ/3hsxqM9WgAl/zgqnwijZAib1qRm4vjGr6oW/MP+dkziL4jrgXj5b4TEI74YBOmM
         Jom7T1b1JOhDq2sVrh3dqUz0CXhFOtDQDE36tICP/p3/5Q3Ff/FSGfi2Z8TQvzOXNdDK
         OpAPrDKvJhcd6xg4zjypOL6TX780w9EXcya7kxcRM0pN0lhSpwY4aV+Acpq6vrvGr2V5
         58hInpsXm13VANV+xCRjcx2wz7GwVcxO6CmvJkrv4FlEkQwS/15V8e5njy5iNlmEnH0o
         zvwA==
X-Forwarded-Encrypted: i=1; AJvYcCUwOQk6bkmT2Jzbx4qa8q04mNCVsUd1h1kIRUHdFVY2j6vDubTzhebvYT+qaStTanSS+83RdYrG0vlAzVSneyi0@vger.kernel.org
X-Gm-Message-State: AOJu0YwmDAC142/6Q7/62//5VZHTDKWQyRpcm9hFntr9xyDZqh0wkY97
	MNAiIzp0986gwazvUFOi8fV4mk7zO9Y79obkzf2+M/oXRU0HFc61D1kppxyNhKShLyYfS/o70ge
	Eoo6gvAQNTAzdug==
X-Google-Smtp-Source: AGHT+IGsvk85QlzW667SyDst19B1vMCsdIZFkhsIWO+5Oz5JLmlMK/v87N6vvqpae9OjXI/Z5iDlf2o2nXomaQ==
X-Received: from dlbdd25.prod.google.com ([2002:a05:7022:a99:b0:11c:58e4:e325])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6726:b0:119:e56b:98ab with SMTP id a92af1059eb24-11cb3ede9dcmr19616669c88.18.1764620691371;
 Mon, 01 Dec 2025 12:24:51 -0800 (PST)
Date: Mon,  1 Dec 2025 12:24:35 -0800
In-Reply-To: <20251201202437.3750901-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251201202437.3750901-3-wusamuel@google.com>
Subject: [PATCH v3 2/2] cpufreq: Documentation update for trace_policy_frequency
From: Samuel Wu <wusamuel@google.com>
To: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Cc: christian.loehle@arm.com, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Documentation update corresponding to replace the cpu_frequency trace
event with the policy_frequency trace event.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst   | 10 +++++-----
 Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++++-------
 Documentation/trace/events-power.rst          |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5..e110854ece88 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -503,8 +503,8 @@ Trace Events
 --------------
 
 There are two static trace events that can be used for ``amd-pstate``
-diagnostics. One of them is the ``cpu_frequency`` trace event generally used
-by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
+diagnostics. One of them is the ``policy_frequency`` trace event generally
+used by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
 specific to ``amd-pstate``.  The following sequence of shell commands can
 be used to enable them and see their output (if the kernel is
 configured to support event tracing). ::
@@ -531,9 +531,9 @@ configured to support event tracing). ::
           <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=3 changed=false fast_switch=true
           <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=11 changed=false fast_switch=true
 
-The ``cpu_frequency`` trace event will be triggered either by the ``schedutil`` scaling
-governor (for the policies it is attached to), or by the ``CPUFreq`` core (for the
-policies with other scaling governors).
+The ``policy_frequency`` trace event will be triggered either by the
+``schedutil`` scaling governor (for the policies it is attached to), or by the
+``CPUFreq`` core (for the policies with other scaling governors).
 
 
 Tracer Tool
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index fde967b0c2e0..274c9208f342 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -822,23 +822,23 @@ Trace Events
 ------------
 
 There are two static trace events that can be used for ``intel_pstate``
-diagnostics.  One of them is the ``cpu_frequency`` trace event generally used
-by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event specific
-to ``intel_pstate``.  Both of them are triggered by ``intel_pstate`` only if
-it works in the :ref:`active mode <active_mode>`.
+diagnostics.  One of them is the ``policy_frequency`` trace event generally
+used by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event
+specific to ``intel_pstate``.  Both of them are triggered by ``intel_pstate``
+only if it works in the :ref:`active mode <active_mode>`.
 
 The following sequence of shell commands can be used to enable them and see
 their output (if the kernel is generally configured to support event tracing)::
 
  # cd /sys/kernel/tracing/
  # echo 1 > events/power/pstate_sample/enable
- # echo 1 > events/power/cpu_frequency/enable
+ # echo 1 > events/power/policy_frequency/enable
  # cat trace
  gnome-terminal--4510  [001] ..s.  1177.680733: pstate_sample: core_busy=107 scaled=94 from=26 to=26 mperf=1143818 aperf=1230607 tsc=29838618 freq=2474476
- cat-5235  [002] ..s.  1177.681723: cpu_frequency: state=2900000 cpu_id=2
+ cat-5235  [002] ..s.  1177.681723: policy_frequency: state=2900000 cpu_id=2 policy_cpus=04
 
 If ``intel_pstate`` works in the :ref:`passive mode <passive_mode>`, the
-``cpu_frequency`` trace event will be triggered either by the ``schedutil``
+``policy_frequency`` trace event will be triggered either by the ``schedutil``
 scaling governor (for the policies it is attached to), or by the ``CPUFreq``
 core (for the policies with other scaling governors).
 
diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index f45bf11fa88d..f013c74b932f 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -26,8 +26,8 @@ cpufreq.
 ::
 
   cpu_idle		"state=%lu cpu_id=%lu"
-  cpu_frequency		"state=%lu cpu_id=%lu"
   cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
+  policy_frequency	"state=%lu cpu_id=%lu policy_cpus=%*pb"
 
 A suspend event is used to indicate the system going in and out of the
 suspend mode:
-- 
2.52.0.107.ga0afd4fd5b-goog

