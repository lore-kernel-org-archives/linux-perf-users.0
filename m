Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C342FC037
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155476; cv=none; b=ZhbUmz/dnf+KnQXu2GMmlzdpNTxuhp9J+ryMzlLXIHVcPOcJDzxU9YPxtL0sGY24pkPXVXYkHfbml1Q/QMQOgAENM3lLmI36HK9AfZwQLki7OgzFokQadQavBpZb6f4mKOeTVPkafbV2zuFwoZQkx4nBAG5fxo2clBiD1aHbFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155476; c=relaxed/simple;
	bh=Dm1dRXMcj8LHggSUomlhbdBytPSZTwFogeXZK3/CgVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/bQc79jSkNCpzqU+ZZ9m+SJOWa/RbwtR6l2m1rYqYB2qP5+99UnOHZ+t89RPzjRh4Xou6sJ14TDK2uaqd9FYAWxd9o3h4NwpuPWYDkGU3sJ+y3zM1HyMCuglmLiPYRBTCbtB/uyF4qV4kXgEBzpibzi0DI6WFf4ze7cTOHgPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFFZOLnV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFFZOLnV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so13602368eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779155474; x=1779760274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNAlzgW5SSa1ZsBC1HKHkIDD3KLaNZAgkWCJbzVU4w=;
        b=bFFZOLnVxizylZqufuCgIvFuHO28bcWCxDm9rKhNfDm3MqAF0OH1oSoFs6oPT4VtNw
         NnJNhYPY6tbQgnawkeEm5t7T8YLj5zsGxSBWWc4gfSMIprhy2mJ+UtIGvsre5TS0KDPJ
         jVZ5hHSjHRSNkEIqAEJcthzlej0Dp++2KDnkz6XXLv0VsvX+sP8jREp0T44lwyhkwo0U
         e+YBxSV15dTxvX9aV9C0IVoGIr6IHCJNeC1vYhfxSg1hCkEPCv4zeyeYx6P8IzD9DZk+
         KqKLfDzSkkG9TFSOiGRLKdCkwLN6Nj5NnbITD6lYBlKyOMO/gfgnKERYYd02FbHXpRGB
         9B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155474; x=1779760274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNAlzgW5SSa1ZsBC1HKHkIDD3KLaNZAgkWCJbzVU4w=;
        b=d+9Jp9xv10GeryIALq4mls8iOyqOfShUGOuPzo7bmobnKJjBYJdfwmxr+4K1o0JmjX
         DkSCIdfgDMO1z28wogxe8Uiz2Omlfgm8HXlZXqrTMFZyjh+0m8Py6t3SCCvG9PIhvpQp
         kOraYMZ0g7rc7dil9wLGIE1ZdiN72cQRbLW3HPK/XnYuuZm3ieSDgtVu3Os+W5PphpQ6
         BhARyY9ma/ON8NkhaBde7L+jDIgZ0+WfdLWPnWg9XFd2yn08F/yk+pF3yisBTqJvSQFN
         evW5WYHpDiaRhs7YH59Bc3Ch7cUYekfQWObe2x5zwAzCgK/e1RTuIDE/XZem3vCwXKC9
         0XFg==
X-Forwarded-Encrypted: i=1; AFNElJ8wFvuXsqnyigc2KxsORqopNoNpEsQk9bJeJ4mTLK1mrBGgFXaH8UkLdKI0RiNn4MyFnuSeWNqfhpLNoBFYaWbq@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5FsIszZYp3ao0l0WwIugaiP2Xr41lptE0Je+uaXPniHDZWDj
	65Po44G8azLuLm9R1/Goom5rnz0yS/7r1+6OS+qwaiTu9uUBBZ2GCdE12aJcB1Ms9TmOnVNZAcF
	2K9vMpyBtHw==
X-Received: from dybqf6.prod.google.com ([2002:a05:7301:6486:b0:2f2:3f95:c586])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6447:b0:2ed:6f94:9d9d
 with SMTP id 5a478bee46e88-3039816bacemr8358806eec.8.1779155474195; Mon, 18
 May 2026 18:51:14 -0700 (PDT)
Date: Mon, 18 May 2026 18:51:07 -0700
In-Reply-To: <20260519015108.3094513-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518222228.3027004-1-irogers@google.com> <20260519015108.3094513-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519015108.3094513-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf stat: Propagate supported flag to follower cgroup
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

Reported-by: Svilen Kanev <skanev@google.com>
Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter_cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 519fee3dc3d0..dd1851634087 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -186,6 +186,21 @@ static int bperf_load_program(struct evlist *evlist)
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

