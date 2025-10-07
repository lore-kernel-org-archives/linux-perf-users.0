Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66121638D
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Oct 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863512; cv=none; b=Rh1YJkxjObO4pNDwnK3lKqCWfY+vAW16mufeCMD5SMS2IaLcDdPPfac/6M9ULacCdHijNPBKx1b8oW1TPIK/3Ja2HX9/gEF03mbsy3nweRXi3PF3RCtB2M/QIc4RfXNlab9xreCKAX3eLX09U9OVv4bbFeid81ecSqk4eahPXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863512; c=relaxed/simple;
	bh=4Mi7uRK7A1S38mqbmd/1UsnjkPnCPmWXsk+4pk4VVTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VUbNVcHSr+RhuBswM8GRKbVpJPyR35D0aQD+rsrM/lS0QcbFxo7C6OnBi0hJTrkmkCj5yybVKFj0h+9jq0i1gmlGBrAMQLKBbAs9bq/ihOEwOGpSPXHW2/jRw/b+3yk/YQxTffGELdhQ8p9GorrcXpdipl0PsOy36zMGK7S9uuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGn/01XP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGn/01XP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5535902495so4618304a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Oct 2025 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759863510; x=1760468310; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9l2SyKdGNaaltnxA95zYj9HNyU/24ObaiyQuMAUtumQ=;
        b=mGn/01XP1fVvds0BtY9Rg+uIfFXjFrpxgDsTi1Fx8Jy8KAlJ7rLZbN6tFK3STowmEi
         U4x5R4CgdD7okkp7HC9R1Y4kct7XRe42sj623K4uDBxW9dlhRP6TsGn/Y8MOPylf1SPQ
         evHuRKFHG2eMJvA5RDGv9OSzamg1fbBiqByl3ZfgYKKvqWKL6vsKEz4gyfkiLKcSmn6t
         pvlXHjXi6R39/8+Bd+TwT5Ek7n/9XvaAkPkh3jNWuQrnEcJnz/ihYGjdqNdiA3/avDa6
         DiwugApt8EKVdN+4MtCS1IRtMBmhKJ/CZB6nsOjRNBvdyFDdC8b8jlPl8jssLi9kU7+t
         qw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863510; x=1760468310;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l2SyKdGNaaltnxA95zYj9HNyU/24ObaiyQuMAUtumQ=;
        b=binReBfSQ1xrjJUq8tcP2SokPN3ZPc2n30M3dGvZ84rXoaXthuEvom/hPpp+vTgUeS
         85js8mKgAqoSMt6Ab3SMHJyrN5qJqzoppVPz90XaTlSskoYf1STjD8m12sledEybGhpE
         f8v6saiNJl1lUe9VsbBCBi9TjKu50DRK66J5ykg0uRSO4ad/Hh/lybk9y2+oi0DOuOoi
         8NTp9a9QP3kYJm34/W04w0MhUS7wZPYFD1FMSM5UZzoT5Pnv7gHMU0Br3V9Xb0bwjegM
         Ifw9RjAdGwZJpixkwOE50IcfioxyrWfqENaxPZnxDyGXDI4DU29BESib9nde/j4g9mx2
         uw8g==
X-Forwarded-Encrypted: i=1; AJvYcCW0IKfLgTOTLCvgdvZvxb57pXN6an9EO1qqK8VhkJjr8Z2pHCnhmyx0uiF3I3VcKM5FTZ9gL2BrxibyiZ/Eaiiu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80bPMGAl0xmZPQgQ8Xfi0ilGMFhe+EyXOAVcwk8NcxuJ644oq
	KCDVX/2Wi5qSPhLuTOica0fB8rpJ/+2rmhVbeSx2w081PX5uo2tLsz+MM9fgNnMfGOpoQ1Cwikn
	IKRv1IXupFQ==
X-Google-Smtp-Source: AGHT+IHZy0Sj/O8eRFg4d0/zb0YyjfprMYz78i+5iwxXo621yPeZXXsoeFbTafZQjs7ObLXeCVfQc1QmDIGE
X-Received: from pgau5.prod.google.com ([2002:a05:6a02:2d85:b0:b62:c5e4:3f80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1590:b0:2e6:a01e:f212
 with SMTP id adf61e73a8af0-32da839f8c6mr638859637.35.1759863510661; Tue, 07
 Oct 2025 11:58:30 -0700 (PDT)
Date: Tue,  7 Oct 2025 11:58:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007185826.3674908-1-irogers@google.com>
Subject: [PATCH v1] perf bpf_counter: Fix opening of "any"(-1) CPU events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
wanting to aggregate a count against a CPU, which avoids the need for
atomics. Force evsels used for BPF counters to require a CPU when not
in system-wide mode so that the "any"(-1) value isn't used during map
propagation and evsel's CPU map matches that of the PMU.

Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 12 ++++++++++++
 tools/perf/util/bpf_counter.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..7fdc7f273a48 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2797,6 +2797,18 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
+	if (target.use_bpf && !target.system_wide) {
+		/*
+		 * Setup BPF counters to require CPUs as any(-1) isn't
+		 * supported. evlist__create_maps below will propagate this
+		 * information to the evsels.
+		 */
+		struct evsel *counter;
+
+		evlist__for_each_entry(evsel_list, counter)
+			counter->core.requires_cpu = true;
+	}
+
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ca5d01b9017d..d3e5933b171b 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
+	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
 	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 
 out:
-- 
2.51.0.710.ga91ca5db03-goog

