Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CEF3C0634;
	Thu,  4 Jun 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603894; cv=none; b=BJg/GhUuc05IR+jk3isS0PiYT9ViGBAtb4WZ8RmmI29lhsa+Awdfka5cOe5B4qxxklTftysLoTvZu+z5Cj8H41jMoO7WruVyEQEi64zPZKFxIJBa042IJok2mHZpdviV09OYvcEOiP68spYG6qKb7SamnZh5JCjjplcYP2pPgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603894; c=relaxed/simple;
	bh=efSK97NbQzv3dhedEowCEupWxCU5ZVP4Jh6EjUK5oLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACM/Z4e4GBonq4Yc59ErdyvxtNqsubLfdZmCUGmHlNxKpw1aA7eu8zsfoZiZB74uRTbKmcJOMKKKFpmobzwfmel7+fZVDMGuWe/C/hisZTbDBr7Gz4tvq+nW4ee5aw4udJ6kagmiAPRBoArYia1WBEDg6RpjGEAaSPpoMRmEbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwOhhuad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwOhhuad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE09F1F00893;
	Thu,  4 Jun 2026 20:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780603890;
	bh=SbSyMZXT1+F/GE62Y2glcEyjNvpgM+9BDPpFvUhMIxQ=;
	h=From:To:Cc:Subject:Date;
	b=kwOhhuadee2/7jHvCgp8vZoRD9MtY2xvaPXzy4rqGsr6vSyDGqNObTerIGpy+C8Hs
	 q3Ym+HQfs2O6UBER+csh4M13qvg0vvo2lHo2EGNpZEQK8BQ7bRRUzs0236VRdO638A
	 /KMxSZiY9e/8MlTw1i40f+T6aZy9Gz1GNxurmHKkX2ZbDtbWspgwmBRR/fwKqhrXVB
	 TKjXTgm+/4mU0vn9pdzaAXvFDPYIw7lswa1AozHlUKN5iSydUyIxBXvgclKJldQgho
	 NW1xbU8kRxVc/h2OU6FvaPNwFQogYo9FPlyXBZoRyr83C3q1DYvDX4CQ4InSkM6c1z
	 xOAAOzE1XC++w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v1 0/4] perf tools: Fix OOB reads, NULL deref, and resource leaks
Date: Thu,  4 Jun 2026 17:11:12 -0300
Message-ID: <20260604201119.1702338-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Four pre-existing bugs found by sashiko-bot during AI-assisted review
of the perf-data-validation hardening series.  All are independent of
that series -- they are latent bugs in surrounding code exposed during
review.

  1. test_bit(sample->cpu, cpu_bitmap) reads out of bounds when
     PERF_SAMPLE_CPU is absent (sample->cpu == (u32)-1) in annotate,
     diff, report, and sched timehist.

  2. Thread reference leak in perf sched latency_switch_event() -- one
     error path does 'return -1' instead of 'goto out_put'.

  3. NULL pointer dereference in perf sched latency_runtime_event() --
     thread_atoms_search() called before the NULL check on the thread
     returned by machine__findnew_thread().

  4. Heap buffer overflow in perf sched map --compact mode --
     comp_cpus allocated based on host CPU count but indexed using a
     MAX_CPUS-sized bitmap, overflowing when analyzing recordings from
     machines with more CPUs than the host.  Also removes the now-dead
     sysconf(_SC_NPROCESSORS_CONF) initialization whose sole consumer
     was the replaced allocation, since max_cpu is dynamically updated
     from the recording's events during processing.

All four require crafted or unusual perf.data inputs to trigger.
Verified with gcc and clang builds, checkpatch, and perf test.

Arnaldo Carvalho de Melo (4):
  perf tools: Guard test_bit from out-of-bounds sample CPU
  perf sched: Fix thread reference leak in latency_switch_event
  perf sched: Fix NULL dereference in latency_runtime_event
  perf sched: Fix comp_cpus heap overflow with cross-machine recordings

 tools/perf/builtin-annotate.c |  3 ++-
 tools/perf/builtin-diff.c     |  3 ++-
 tools/perf/builtin-report.c   |  3 ++-
 tools/perf/builtin-sched.c    | 16 +++++++++-------
 4 files changed, 15 insertions(+), 10 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks a lot,

- Arnaldo
