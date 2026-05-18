Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B32F7EF5
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142953; cv=none; b=k0QHGWsA2Itu+lwwqhaacAr3J5C74hYovfw3Htc0acodpMu22TObgWjgaTI4YedYcYJfKzS/Eumk8fT8OhDRF/BXNMvNB16K7/9Sx0hs8X6ozI4JhRj3L0Vbc/LNifvHL6Zp+HK694DcDx9s9bJ8ENKxWj9U0MaMJ96e9iDkhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142953; c=relaxed/simple;
	bh=TlJhgWkKhiqXDaZxRkMYQd6DC2vKjX1atE0tHNZtVZw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=EZeZzQZgiLgkY3m3DUvJfE+Knbp1bKfCOKOHO07BkWtlDyBwqyC8z6/sj18Go2pn9cxWw/CUk428hPkCQJh/cDZQE+fuKYXxHDA6ve2kjRJrVhSh2Lqw3RWwHvecs3p651VLA+XwAvy/gih6nO0M6UseIDCV4jrVtI7bQ57HugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDhLidd7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDhLidd7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1329791f18fso4993113c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779142952; x=1779747752; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=grlNvYptnUgZVyXoTDj3zK3P1b5S8xvbprevPloPEWg=;
        b=FDhLidd7gv8jSFUgjBcK/hPwF8EpL7+fATY3jmBTGlr4WGmA+m+e+YpdJYeDtdlSGN
         VsI5YyK4T2Zp6kVPsD8WyGZKLgIJD+qdAPB1stRavMXZf8SXHCX5QkRYKXZdT4tLwI+l
         vAIB/u6N0DQ2XIOB/G3y/BT+CCaWCSJ1Xrpjv8CSU7rRsasaBWvm5t3oBuLN1vuYIYaA
         BOW0nnX/7MHoirPjgVZzNjyeKzptr8wk2H1OrFrVf7Aup8epjm6owVnmYT6xvGIQhn2x
         wD6tgFkLsUPmzPHvM1OARer5eoO4VfIcIQ/VJsz4+ge/YNXVWyul4uKNswajuJd4q0nr
         AdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142952; x=1779747752;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grlNvYptnUgZVyXoTDj3zK3P1b5S8xvbprevPloPEWg=;
        b=sv9doDcOIHNKitSWsA/Nx5zc9be8ysdWNEiED+3gRapn0ENmr7yi+ZCbqHlcnN6i9S
         OEGEjlYPzTLGAuwUs0B1j/UD2zwbDH0qRpIC6eJxUlXeN2mboXixo9Hx7pieQpdqSGnH
         wCmUiEmcyX9MyLP77LIRkb+sZlFFA8POZXmV6t1rY2GokxQOCiA2maKVAgT2Oq+xl056
         kj6BWeU2WIep6ap9h+97CowChXHBw+hnZGVC4ozoj96Rp6AVpMxoolj8Qhs3I3fa4ELV
         O4madvpdc7Xlni8SM4QxNJyCBoPlzIrabZ/nC55TtB8yZzSr5wELYUbPNIc6MC1wYxBU
         epfw==
X-Forwarded-Encrypted: i=1; AFNElJ/fDDgpN6skIsKxzosoYykW3ELnmDzrRZCNmAdQAWBWCVgLd/tfdW8WkZmTY454Q7/zzO6/kcLQb2muqVCLK2T7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+et/yrPn8Bstk9he1wF38y9suEeaWuZfeDgOgzTCbtMGQ8Ji
	hDfl4YeoecIdZ97yjSwHt+6TZHMrUvVwhA3cN9LXHVxedSVs6gEqKwCz2CeisesDK6QIPyX3WTq
	+4cMaXyuJLQ==
X-Received: from dlbvt1.prod.google.com ([2002:a05:7022:3f81:b0:135:296f:c477])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea26:b0:12c:8b9:71d9
 with SMTP id a92af1059eb24-1350483ccf4mr7712564c88.27.1779142951553; Mon, 18
 May 2026 15:22:31 -0700 (PDT)
Date: Mon, 18 May 2026 15:22:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518222228.3027004-1-irogers@google.com>
Subject: [PATCH v1 0/2] Fix cgroup metric association with BPF counters
From: Ian Rogers <irogers@google.com>
To: skanev@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where cgroup metrics were not being correctly
associated and reported (showing `nan %`) when using BPF counters
(i.e., with `--bpf-counters`).

The root cause is that cgroup BPF counters only open the "leader" events
(for the first cgroup) and leave "follower" events unopened. Unopened
events have their `supported` flag set to `false` by default. During
metric calculation, `prepare_metric` checks `evsel->supported` and
discards the value (setting it to `NAN`) if it is `false`, leading to
`nan %` in the output.

The first patch fixes this by propagating the `supported` flag from the
leader events to the follower events in `bperf_load_program`.

The second patch adds a new shell test (`stat_metrics_cgrp.sh`) to
permanently cover this scenario (testing both with and without BPF
counters) and prevent regressions.

Reported-by: Svilen Kanev <skanev@google.com>

Ian Rogers (2):
  perf stat: Propagate supported flag to follower cgroup BPF events
  perf test: Add stat metrics --for-each-cgroup test

 tools/perf/tests/shell/stat_metrics_cgrp.sh | 123 ++++++++++++++++++++
 tools/perf/util/bpf_counter_cgroup.c        |  15 +++
 2 files changed, 138 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

-- 
2.54.0.631.ge1b05301d1-goog

