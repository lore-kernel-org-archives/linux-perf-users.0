Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52920C48A
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500434; cv=none; b=cepf8wgDLfpmOqzDGOlX5c3uXqiTttH1fiC9xrBqHvSQYdgwiHGaggK1wRK/yKG30TV2mu2aoPVJfhf2WAo7bAp4zCRPWt2XWHSc6vWw59Q90XAr61gqb3DeLefLz5Isg4VoZEo3i4XleKj2K8jpwugOa1ETOIMMCrYfBdj2174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500434; c=relaxed/simple;
	bh=hlSfsa/tOevvA5hMzSWStS7nnWQy5iRlXi6rOAcZr14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jyjZlo0MKyJ4cFuWut7tCC0k5OPq3SYYh9JNXuXTwcahGnP8DPMkQRVvAZXEpTWyHrxRm7k4t9s4DCKvK7YorJ9AHqyoUgwoLxvDU+E5yFumGl3HNFiB4S5Ie72nmzOxMjfuJkIPvbJY6IaDRKeinvfi68lgT+qPtUhKAha4rJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukenp3VB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukenp3VB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55735710f0so10741687a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 13:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763500432; x=1764105232; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UvhAqv6SeUijjxk0hkcR4/ai/hO70N40/Ki8qgJXPU=;
        b=ukenp3VBcCdE9iJV0uOdFySyf9eBgN9V/kEGThD7OqcvVD/nR6WmrMxQ74zAIxKdSz
         tZbp4lYQXRQYzUPNx41kfFK0XtvpmD4x+oxv+fqsrtHv4T7q7pR5GUNeBB72AfxAQKiA
         R0jmRUn74mNclKL2ayKxFeKBtEduRk55dAZtRk1JFQlQ2BkUjjTpU+kvPuwDhjVS5CDt
         0TA1AddU2Cy0RIVNQAyr+kN52DeZxk/CBS/O0JvBxkczijMq10i2PMUipjgxcwJOSKjt
         CZk27+tUNRZvXZoZV6hB+kM3eCWUHEIqZOTqAUhVWWs2WaTas8V9BJuK68fykHCA+zFU
         mwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500432; x=1764105232;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UvhAqv6SeUijjxk0hkcR4/ai/hO70N40/Ki8qgJXPU=;
        b=CVAt62M/lmUkhmRhTZplXozlX8HtigweTuxbUc07j9p7cFklS3t18OyvAYokSfJgX0
         vWWPSDBtBWjP90X5cFiPacYdeOWiSDTPb7t1gMkPh7shO8vpypt1UkU8x2mR89FAxgdI
         /OCN7r0H3czLJUTW1vuxdwuFAsHpo7usXXHaoWeUOt9vRNnjcVpk1nor6NCLh5MMqV3y
         yIu6eu7007/4qwycGTEiyIdfPaC8kMPe5C/yKC5N9Soafa8JryjfIMfkieYawWoeuU9L
         kfBQ9ekw9HH98qO8J2td8n7UXkMKwh6Hc05QhAZyLuvNHNklvKWWmIciuNrmbHoKNYcj
         Gu5w==
X-Forwarded-Encrypted: i=1; AJvYcCWxfTS2mJj4v53GRcb0Es+/NLQfvIwvPaKC+ULqpSd1/xq6O9UCXoIYELtCViQDfZ1zpx8veFDnysQOnEyTa1Mr@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhByOJvBXZO1RscjXQIiQd8rTJ46C6L636qascsswZ6yjGrR4
	L4pgO+Aq+MCH8yxCfyu0709mNC1kkw6kGVtSRgDAQ8TwGGgZNXtC4bCJZL9pdpQWgXiqEB4faZT
	2rP22BPB+PQ==
X-Google-Smtp-Source: AGHT+IHQSZQd/THE8WOoCX6uKoXlWiBH/GQF2t0yujqxl/1SqlYkLZvtsUudFdX1tXyItk5AtszUMyPZYGJ7
X-Received: from dlbcm21.prod.google.com ([2002:a05:7022:6895:b0:119:78ff:fe10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:604:b0:11b:9386:826a
 with SMTP id a92af1059eb24-11b93868475mr5733402c88.47.1763500431993; Tue, 18
 Nov 2025 13:13:51 -0800 (PST)
Date: Tue, 18 Nov 2025 13:13:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251118211326.1840989-1-irogers@google.com>
Subject: [PATCH v5 0/3] perf stat affinity changes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

The remnants of:
https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/

Read tool events last so that counts shouldn't exceed theoretic
maximums.

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v5: Drop merged changes. Move tool event reading to first
    patch. Change --no-affinity flag to --affinity/--no-affinity flag.

v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
    the legacy metric code is no more. Minor tweak to the ru_stats
    clean up.
https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/

v3: Add affinity clean ups and read tool events last.
https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/

v2: Fixed an aggregation index issue:
https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/

v1:
https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/

Ian Rogers (3):
  perf stat: Read tool events last
  perf evlist: Reduce affinity use and move into iterator, fix no
    affinity
  perf stat: Add no-affinity flag

 tools/perf/Documentation/perf-stat.txt |   4 +
 tools/perf/builtin-stat.c              | 159 ++++++++++++++-----------
 tools/perf/util/evlist.c               | 156 ++++++++++++++----------
 tools/perf/util/evlist.h               |  27 +++--
 tools/perf/util/pmu.c                  |  12 ++
 tools/perf/util/pmu.h                  |   1 +
 6 files changed, 222 insertions(+), 137 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog

