Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F202248AC
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968415; cv=none; b=G8Tzb9g4z0FxhsRtqIdtN8tSb9Fr64uINUmmpUW0FClIBmWcoDG/8f6Bjl5QoEmfpsAOB8u/OMtaKS+Sgpw008UgK/uQhyFbc9/tgKdbqsG5DeOKUue3HRvsS0Wj2U/27tAMjF0avXGCFmf2tG8T+TY3P9BN0kYbFXq9NCDHReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968415; c=relaxed/simple;
	bh=s5K60HuqKi/KQbAabFyUuU+SYNPEWKz7ZtckeT8XJU0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kpWaZDBdQku9ZzFyGYDVgsuIGQnmReVI9DoLlXV0/GsSEj4YS8ZbFSbyW79tnWY5TAJomaDh5HVCFict5ZqLSWFkeXpAGpT+MOHTWALaLB4F9XA8U18OMj6skYNe7vebhvw4GfA2+EOtWmKr6u4qKFt8zHJheaRYmG1OAHlFobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UHhW/3q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UHhW/3q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400a0ad246so8738045ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968413; x=1754573213; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZ1BBbI1GI1D/xuoVq0pA5HecVEJHni+Sx/JIlmlZeo=;
        b=2UHhW/3qo+XvNklpx2Zf1cfUe9FQqfhaMUfmHQxTDwO3sf90WFgsZmSNcqd1/T0MZQ
         fLdVeEbDlzhh/gG2sq6RSARPcr5cKL4hgh6jrIuqAJG0ERhcql+PIOjN3iHGcFTE+sWR
         lTF8nfsWL5HdFUwLk4rjKP+VcYNyqu8pfC8dEBXypVaf/5GQiX31vc0ZQJU71zw7IRKw
         9dQwvemEsVf4Qy3m9YUb6E8kh7zto0h9cuRi7bAnkTv6W0bYLdj6/Ylnzj6eVn2nAcyb
         eomdToUfwI+LQzNCyU4rx1Ots75Yllo0YvbUDakVlNC797EB6PN42vJjLpY6dScSS5Yj
         eZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968413; x=1754573213;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZ1BBbI1GI1D/xuoVq0pA5HecVEJHni+Sx/JIlmlZeo=;
        b=qAKIV5nc3kEUz8SWYLus+6iwu7p2xljXBo7rchMR719y1X9c5fb07EJ5ze5wIP1jL4
         k0ijYFMUcYt6VGTXbTxOGCoIwPEQEr4YwNKlxWylf5MwqpUzBqr9anZkIW/qFeQGIfOH
         LOyzu3jaZTp/1J7Bz1FLj4t1yF1CHjVf/Rnpqk94uE+HDicbJWNcCu/KDN6dv2DpXYcV
         O6GV2rr9ePJYOne0EmGqJBzPorAS8OaQ4A64NxhnpP47ZbITCQHGOL55mfmgNaPZDsDs
         SyhRC4Bi5k00ntwl3p4W38FWiura1B9M9wow9aCsr5EW7BZKjOz0qS75yQ4QRYMES/40
         /nxw==
X-Forwarded-Encrypted: i=1; AJvYcCUsyZhUoMEfAY0K0b5hq0FJs41Wn5EDt/Omu0GTApD+J4V8thaNA849oyep6QT85gboDIveR2HehvL0L2YfWqd+@vger.kernel.org
X-Gm-Message-State: AOJu0YwQM2LOK1T27Kb46Q5FOuE1YJuqarAIwtUaCorml1QJsZ5GsDTr
	A3Fs6d+nsRmyiFIt0UzUSp2e7IA2eMDNtcPQWmoEJ4uUhKwSKN1ZmYKP/7CPExnyxy+WQpfEJ+/
	zok0RgQ==
X-Google-Smtp-Source: AGHT+IF4XYHD6g0RpVLaPA/Z9xhsLWnh9zkljcdbfUmKINOz5fbgty3pEv0DxmPz+MtPY4xGE8tILDoyq3E=
X-Received: from plsk22.prod.google.com ([2002:a17:902:ba96:b0:23f:ecf6:4649])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eb8b:b0:240:6fd0:25b7
 with SMTP id d9443c01a7336-24096b1fed8mr105313315ad.38.1753968413449; Thu, 31
 Jul 2025 06:26:53 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-1-yuzhuo@google.com>
Subject: [PATCH v1 0/5] perf bench: Add rcu to the 'bench sync' collection
From: Yuzhuo Jing <yuzhuo@google.com>
To: Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an 'bench sync rcu' benchmark, using the kernel's rcuscale module.

This patch series adds the following features:
  * Automatic rcuscale module load/unload and grace-period statistics.
    (The statistics feature was derived from
    tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh.)
    (patch 1)
  * Simple benchmark specifying a list of parameters supported by
    rcuscale. (patch 1)
  * A feature to execute child process, and automatically replace
    reader/writer threads ID placeholder strings.  This allows child
    process to attach to kernel threads to collect performance
    statistics. (patch 2)
  * Range-based benchmark that enumerates all combinations of parameter
    ranges (patch 3).
  * Ratio-based benchmark that scales between two parameters. (patch 4)
Example usages have been added to each patch commit message.

This patch series depends on the new features of an ongoing patch series
that exposes rcuscale module internal states and experiment results
through debugfs.  That patch series is also required for programmatic
experiment start/finish controls.
Link: https://lore.kernel.org/lkml/20250730022347.71722-1-yuzhuo@google.com/T/

RFCs:
  * This patch series depends on the behavior of rcuscale kernel module.
    In case of interface changes, especially aforementioned
    "experiment results" format changes, this benchmark may break.
  * The tools/testing/selftests/rcutorture suite provides a set of
    scripts to run rcuscale, rcutorture, refscale in KVM, but left out
    bare-metal testing.  This patch series provides direct benchmarking
    without KVM indirection.  However, they reside in different folders.
    Is there a better way to integrate both suites?
  * (Patch 3) What would be a better range format?  The current format
    is defined as start[:end:step], and is only for integers.
    Potentially we may want ranges for non-integers, or relationships
    from expressions.

The patches are based on an ongoing series.  Specifically, the minor
changes in builtin-bench.c may prevent applying change cleanly to
master/HEAD.  Though the sync-rcu.c itself is independent of the lock
benchmarks from previous series.
Link: https://lore.kernel.org/lkml/20250729022640.3134066-1-yuzhuo@google.com/T/
Link: https://lore.kernel.org/lkml/20250729081256.3433892-1-yuzhuo@google.com/T/

Yuzhuo Jing (5):
  perf bench: Add RCU benchmark using rcuscale kernel module
  perf bench: Implement subprocess execution for 'sync rcu'
  perf bench: Add 'range' mode to 'sync rcu'
  perf bench: Add 'ratio' mode to 'sync rcu'
  perf bench: Add documentation for 'sync rcu' suite

 tools/perf/Documentation/perf-bench.txt |  131 +++
 tools/perf/bench/Build                  |    1 +
 tools/perf/bench/bench.h                |    1 +
 tools/perf/bench/sync-rcu.c             | 1319 +++++++++++++++++++++++
 tools/perf/builtin-bench.c              |    1 +
 5 files changed, 1453 insertions(+)
 create mode 100644 tools/perf/bench/sync-rcu.c

-- 
2.50.1.565.gc32cd1483b-goog

