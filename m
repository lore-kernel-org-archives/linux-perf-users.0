Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146223183F
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416714; cv=none; b=c+3e9Z0fC+DmGcpabMeH62PDUCaVRcmM8k/MVLLTxIOeeJTU+9ZWGsllQwLsrbLXYqSuI7QOxZNzD6lJQRdPHBZUuklkuNm60vLf9qVDI/x0kx9y1Oahxe4PihBhNgHoiDD3LxgRrVQiABFMy4AEnCjluYJpG2/f3VVIT0XcGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416714; c=relaxed/simple;
	bh=02KpldJD5haFVTNB0TQABOZsQw7r+voip+Fwr6m48yI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsC5z7qNzPd90HwvAtMcHoS4v9vtb49vcLH/rwqNtpPBvCuTncr35GhLkwZt+kJMZR6o+JSf8TxfOmxNeTMbT1eHaqe69rNE3KXCHdscIfqRkxyAUZU5MK3+XLN4pZX/SJbTvz+05XR4VvzVUubEVTnOjJekkCIx1d/LYS/BJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6fPv5q/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6fPv5q/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1247bb4db53so4147627c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770416714; x=1771021514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkzKkEX8uaJbAGd74kZwXgtLKTTud//VRxAomENJORE=;
        b=P6fPv5q/nDMWWxXIef5pdUP5bCh1g5msyyQ6HDicRObJVJY2Jlb/x+Eudj8XXmC3b9
         uaJ7BktIhwT9u1Gp6YYIpx/YfaSiExxDGyI/c1OLk6hB0A6QnYhgr0F0+BPOlRjDZ7YK
         A5Ask14OvKyiM1Fd1wqU7ZU4+NoGj5wS6lk9riKdQWdZUgBB33+DBWkqv7EDzwj1n4WA
         pPeGHF0fERwLvXod6Ejv6NgDJsAlRL6VhLqXD4/8qKzGIV/dGvIQobvFBlTYlJHHtoKb
         Z90JN4md0xazt3x9xBex7Ct7sKOUiMjz+Uyx4IpUHIMPRjPUiN6KjYQOFZwzaIJM7x4M
         DtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416714; x=1771021514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkzKkEX8uaJbAGd74kZwXgtLKTTud//VRxAomENJORE=;
        b=fSLJ2dbWPQtn9Y8nNOJRIgH7hFvhhZ2In3lSfdeFe6+6AM40yFCh7iys3PapzAFirh
         ES87whWjvY5YT4U/JZZV3OON+a/SUMg5XiUfRMJfPjuI8MHa777oYrcwqooY/KRlQKM3
         Q1GPgCRW7oceMWURkKd9MD/xgXqADWU8IcgfoaHENgIKpHa1lMBWuGnVpoOOX9YkcHdi
         tjBfS2guQiZ+9qcJ1Pt4Nghl5fsMVznyw9ghBdXNe2hgb6iD5Lm3z2ctdODv69j6JIfV
         pol3/w+35dtmttZxMZCF5szvAa21FusZoPSin3v/RjhGJRH16fFqAxRz1MNR5QZOjmxp
         NumQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWWmyv83q8bTSfLNk/BR0CZe9kU+ktg6cTAc6BqAkDgSxHR+ihdvDGwFC4QQdbxxghPLN7tx0Sv6sJxc/J95WG@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbCVBNAiJYLbR3/PxQNjpl5i1bmAFI+Evy31X5VK2oMv4MqUx
	CGTvpOpDcd1tolK9Mke5boK6FjPPKKT8hF2jj4OYcXa4gHHX3z2yz2wpgNuB29uuG6BafDkQo2e
	dI47W/uNKXg==
X-Received: from dlcip7.prod.google.com ([2002:a05:7023:c087:b0:124:9d31:3581])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e28:b0:123:2ee9:d1b3
 with SMTP id a92af1059eb24-12703ff272fmr1740130c88.2.1770416713707; Fri, 06
 Feb 2026 14:25:13 -0800 (PST)
Date: Fri,  6 Feb 2026 14:25:03 -0800
In-Reply-To: <aYZnkYqWXnKpHd3h@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206222509.982489-1-irogers@google.com>
Subject: [PATCH v8 0/6] perf stat affinity changes
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, thomas.falcon@intel.com, 
	tmricht@linux.ibm.com, yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v8: Rebase, due to minor conflict with:
https://lore.kernel.org/lkml/20260203230733.1474840-1-ctshao@google.com/

v7: Revert "perf tool_pmu: More accurately set the cpus for tool
    events" that caused issues with user specified CPUs (Andres Freund
    <andres@anarazel.de>). Fix a null test is prepare_metric so that
    missing events can't trigger segfaults (Andres Freund). Make the
    CPU map propagation improve the CPU maps for tool events that only
    read on index 0, this allows later setting when
    evlist__create_maps is called with the correct user CPUs. Rebase
    previous non-merged affinity changes that hadn't been picked up
    yet.
https://lore.kernel.org/lkml/20260203225129.4077140-1-irogers@google.com/

v6: Drop merged tool event change. Move TPEBS fix into its own patch
    1st.
https://lore.kernel.org/lkml/20260108212652.768875-1-irogers@google.com/

v5: Drop merged changes. Move tool event reading to first
    patch. Change --no-affinity flag to --affinity/--no-affinity flag.
https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.com/
    On v5 there was discussion with Andi Kleen who points out that
    affinities will work better with real time priorities but using
    this requires privileges.

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

Ian Rogers (6):
  Revert "perf tool_pmu: More accurately set the cpus for tool events"
  perf stat-shadow: In prepare_metric fix guard on reading NULL
    perf_stat_evsel
  perf evlist: Special map propagation for tool events that read on 1
    CPU
  perf evlist: Missing TPEBS close in evlist__close
  perf evlist: Reduce affinity use and move into iterator, fix no
    affinity
  perf stat: Add no-affinity flag

 tools/lib/perf/evlist.c                 |  36 +++++-
 tools/lib/perf/include/internal/evsel.h |   2 +
 tools/perf/Documentation/perf-stat.txt  |   4 +
 tools/perf/builtin-stat.c               | 114 ++++++++---------
 tools/perf/util/evlist.c                | 156 +++++++++++++++---------
 tools/perf/util/evlist.h                |  27 ++--
 tools/perf/util/parse-events.c          |  10 +-
 tools/perf/util/pmu.c                   |  23 ++++
 tools/perf/util/pmu.h                   |   3 +
 tools/perf/util/stat-shadow.c           |  24 ++--
 tools/perf/util/tool_pmu.c              |  19 ---
 tools/perf/util/tool_pmu.h              |   1 -
 12 files changed, 249 insertions(+), 170 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

