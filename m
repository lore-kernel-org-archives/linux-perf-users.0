Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174523803F8;
	Thu,  4 Jun 2026 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606173; cv=none; b=uPkFl274ZGJs9hknkLEydJRTbDMQegTe+HiQy5GXyMqArookohhrKn2B7moZnXxCyyoXx+no8VAqe8+EtjJsq9aT84BVB2rIaS7uEHKN6SSq5QCEE10fZIaXna3mL272E328/JqoteiyozqEa4SlLcbubOyZPaFETIVo7cJcq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606173; c=relaxed/simple;
	bh=InBO/BhliE6cW6dyy8tOkI4fv9OpxCl4krYCBe5jk4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pcBDTx701ikYQL8TGPytA6rGxxuU5yZd8BGwUj3PavhlCtZWpEys+tRf7l6Qv5ysPX7K2FPVE3dLU1sr+++p1EBBw6Elu4qMOE+JbGstxmsAj9HBMzaLpYRx428Eok5HSvGw+ymolAWuPBup22HBuREtIOauir4bEBpkpjYZyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewIio4CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewIio4CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3E01F00898;
	Thu,  4 Jun 2026 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780606171;
	bh=AnewxEoY5wJdqk5CTuO16simE89sC48lSXoAWmuZYIg=;
	h=From:To:Cc:Subject:Date;
	b=ewIio4CGUuE0z1U/JPudmuLGLSz9coIahSzGtawnSJibmxN/hGUD9wlT3hCNN5z+h
	 o9WSJB0/Z+hifY8B/5cmH4/Tgq2SWfc/V5f+6DKWXd+tthmlqP1pjgBJ/fJsDYhWiT
	 CSJPRcQXgTxlznElK31zNu8PxwMTOHo2k5NIExT21ZIo3PQg1BiWZtIgHUs9aCUqWy
	 4XY/pNoQ+Bq7qNiiJHNffvZ8lxZ15X0ZZctdENKQWwKlRQ1PR9C0BgKuoKm4mK0Fgm
	 r+JMq+eQrD68WizHURFveJkXNG4mZg2g+w9ueryNmYRE0Wa0hgaUjTzJkDPNhIExv8
	 snsQV9wQn/8vQ==
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
Subject: [PATCHES v2 0/4] perf tools: Fix OOB reads, NULL deref, and resource leaks
Date: Thu,  4 Jun 2026 17:49:15 -0300
Message-ID: <20260604204921.1707333-1-acme@kernel.org>
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
     machines with more CPUs than the host.  Also fixes the sizeof
     mismatch from the int-to-struct perf_cpu type change, removes the
     now-dead sysconf(_SC_NPROCESSORS_CONF) initialization, and fixes
     an off-by-one in the non-compact path where max_cpu (0-based
     index) was used as cpus_nr (count) without adding 1.

All four require crafted or unusual perf.data inputs to trigger.
Verified with gcc and clang builds, checkpatch, and perf test.

Changes in v2:
  - Patch 4: fix off-by-one in non-compact path — max_cpu.cpu is a
    0-based index, needs + 1 when used as cpus_nr (count).
    Reported by sashiko-bot.

Arnaldo Carvalho de Melo (4):
  perf tools: Guard test_bit from out-of-bounds sample CPU
  perf sched: Fix thread reference leak in latency_switch_event
  perf sched: Fix NULL dereference in latency_runtime_event
  perf sched: Fix comp_cpus heap overflow with cross-machine recordings

 tools/perf/builtin-annotate.c |  3 ++-
 tools/perf/builtin-diff.c     |  3 ++-
 tools/perf/builtin-report.c   |  3 ++-
 tools/perf/builtin-sched.c    | 18 ++++++++++--------
 4 files changed, 16 insertions(+), 11 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks a lot,

- Arnaldo
