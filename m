Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB347408024
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204451; cv=none; b=Lh+I/63irHZxS+oD1U2giSR1PAJfMcqmgHEMbE3FK+95VVW6xw3EClJS6Yt+ns+tnP5YQBFMTTDqCjHVMAgBgSkyM2YagPy3UUyzCQwrOqQM2/H0xPEvRi048Sx6nd/aZhu4WJSy2pFu1KLX9KFD08/r2zPjW2JhkERHTqWxt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204451; c=relaxed/simple;
	bh=tZ6+tK1cele7SlSUkxxqDApfB/RID9mJwcFOhcOwAM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pYyypQGPh7Q7qGJ+MOVMU7qGPTG5WHsLFVcNdolBUOQYQKZDF97zZde+HFYhNLf057jIDIKgvxeJsS8qyGzBfP8I544zQ7Le0eTqaYC3fIFVP0gMwmESl8OB/0RdUHNXkOGgvJBGJT66LuomzuLRpVVYKqH2HvHy2+PH4sLxeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/5atBZU; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/5atBZU"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f2d983d109so15678943eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779204449; x=1779809249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fIflKPf+pFDRZswdcVI1JmNYXbeE5Y4CNZteMwLexA=;
        b=k/5atBZUtdj00pJqMbCy370idpIPN4ZndUKpRgzoQvp9tiqRt0/3kb5De7UtSt5x3p
         QKvD1d4LpkSLqhwsCqy1yOfDMbatTfFGmrIbpOznNnkbLs993Xj+QOb2jIQzo3fSdogQ
         SD98h3IExdsv1cPx8g99ljJlWej/yGDm7elbun/eFmEQG6yzXW/IMRT83uI6UgeDrfC+
         PmXx30Kq1bvH3t6Ee2lhIADck/fjpz/CA0KmG3hxaTNYYW6QuXvnTHqhLGqX8/qCJdkl
         yCcg9d5giLKZM6zyIsndR7px89pkqM/zIiofG2reMAaGh+jBeF4ie1cb285VL0LM54G2
         nv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204449; x=1779809249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fIflKPf+pFDRZswdcVI1JmNYXbeE5Y4CNZteMwLexA=;
        b=em2QB24p5eM8/npIPSl4sbhy+5bqaL9P9liIOeVpZbCJKCyLoD8jc1mypi0DB62Jgj
         OugMwwRtnjwkvEHVRvuTk92AgMtyGq3h9kfWy6TKNX23PyW354SfXrl/C2HsAfaqj9iv
         Br+LdSThXRgN6N9eJOIM6xY4zg2yd8IZEpE7JaXwex4GTS9yIIbJLeCK2R+DtRM2yDku
         LkkMMIHl0R2vIUS8/g5bUE6qFopxQaCOJmfuj2th3AV0QvHB95RrYHy9nt+sAPuepfH6
         adz4b057DS+LOtHGsqG9agYx4iNxqT/CJUCYGMPYqHMFDU/acms+rqqx8jKQusSaPK/W
         AQWA==
X-Forwarded-Encrypted: i=1; AFNElJ9ekZ6Cwa0gE5D7nqxM9ou0syJOIfOLdDveDkZUkMWEy5fPE6AJiOT+qOv3odpTxO6ILT/hVIAU+hbpilvHJ2xn@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ5j9j30W67JGWoi2f9PUeqNnFQRV9/nassF9bwTnwgMYFEsri
	mt9/N/WU0bxMsppGkRU9zPuubAxtsVqgQ4Nzrqy9LN8U3Dr5tKmYTl5XQF6tKpMpUuOV+TeA8Da
	7DbToOa1ILw==
X-Received: from dyr13.prod.google.com ([2002:a05:693c:400d:b0:2ee:4745:8c0a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:be17:b0:2d9:6373:ad1d
 with SMTP id 5a478bee46e88-30398625eb1mr8624350eec.20.1779204448744; Tue, 19
 May 2026 08:27:28 -0700 (PDT)
Date: Tue, 19 May 2026 08:27:15 -0700
In-Reply-To: <20260519152716.3464144-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519050150.3144907-1-irogers@google.com> <20260519152716.3464144-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519152716.3464144-2-irogers@google.com>
Subject: [PATCH v4 1/2] perf stat: Propagate supported flag to follower cgroup
 BPF events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, skanev@google.com
Content-Type: text/plain; charset="UTF-8"

When using BPF counters with cgroups, follower events (for cgroups
other than the first one) are not opened. Because they are not opened,
their `supported` flag was left as `false`.

During metric calculation, `prepare_metric` checks if the event is
supported. If it is not supported (like the follower events), it
explicitly sets the value to `NAN`, which eventually causes the metric
to be reported as `nan %`.

Fix this by propagating the `supported` flag from the "leader" events
(the ones opened for the first cgroup) to the "follower" events.

Also add a validation check to `bperf_load_program` to ensure `nr_cgroups`
is not zero and the number of events is a multiple of `nr_cgroups`,
preventing a potential division-by-zero (SIGFPE) exception when
`num_events` evaluates to 0 (e.g., with a trailing comma in cgroups list).

Reported-by: Svilen Kanev <skanev@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter_cgroup.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 519fee3dc3d0..e1ce5aa3b957 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -104,6 +104,11 @@ static int bperf_load_program(struct evlist *evlist)
 
 	set_max_rlimit();
 
+	if (nr_cgroups == 0 || evlist->core.nr_entries % nr_cgroups != 0) {
+		pr_err("Invalid cgroup or event count\n");
+		return -EINVAL;
+	}
+
 	test_max_events_program_load();
 
 	skel = bperf_cgroup_bpf__open();
@@ -186,6 +191,21 @@ static int bperf_load_program(struct evlist *evlist)
 		i++;
 	}
 
+	/*
+	 * Propagate supported flag from leaders to followers. Follower events
+	 * are not opened, so their supported flag remains false.
+	 */
+	{
+		struct evsel *leader;
+		int num_events = evlist->core.nr_entries / nr_cgroups;
+
+		evlist__for_each_entry(evlist, evsel) {
+			leader = evlist__find_evsel(evlist, evsel->core.idx % num_events);
+			if (leader)
+				evsel->supported = leader->supported;
+		}
+	}
+
 	/*
 	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
 	 * whether the kernel support it
-- 
2.54.0.631.ge1b05301d1-goog

