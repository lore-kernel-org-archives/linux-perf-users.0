Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A5381C4;
	Fri,  5 Jun 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661728; cv=none; b=mJwtV9wJwazBX8KWXju2UtRZBB1jRzm3cmjYyuFv8rZTYjLmvDE9k5y4JJ1Y2s2yOKovSpsqmE/bLymQU2oDJsKw4Zv6bWnK9yrlSbMG7S9YYnewohDJ95WQZWV3ZVWChdtt514XXY8RJrtKb1XzQXZE5sQYqNsyEvqMwQOdb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661728; c=relaxed/simple;
	bh=vEBD1jbELEqqSb/mgcIL+ZnJi7V72wUcSnfSoYUfITY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDD19BT4YQB3vyolvaFUOZ2c4JsrhoZkQ4Y3PDcdigyEecFqFeAAR1XavbLad2TVjktc7g2phJSCEPBwXlVc6+a06LSnBewde5E7RdhJlKfl542XkaeCBjq3K1sokRPMFFwBr2c/l/gm3dColIdYTCVCuu619gUmlEC5gcR0C50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUFjY+F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUFjY+F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9899C1F00898;
	Fri,  5 Jun 2026 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661727;
	bh=ikACu+OjF6d5P4qqsGnHbJXISbP5rMCRHXN871BKNvk=;
	h=From:To:Cc:Subject:Date;
	b=SUFjY+F2K6mBIig/C0j9TxgkZdTZwa40fD1QRUJLFVKGpf7uUO+ugKt9vVPE5asfj
	 /nQED9A8KEeioi7j5WYDIPX3mADOLSntuiSdSXADtDCHCqoYgYH1AK0fa1UXiV8SsR
	 lC71eFple633Bl+RtLfkv5ojiekII7tCVAq18zeCFinNPKACo1Msm8MDZntjtwLWeW
	 IpU/UhgouwFCSbvp55XYylwCQMyAXecbSDZQImkVg1X8cWd1qnpDjj2AmBiH6ZELZJ
	 cf7tmlNroo9RmGjZkQSJMDkcGoRji+lvTKSFFf7RX8T4zc+ixtFt/Y5by/AbfGtV+f
	 tPLtfTgID4Z4g==
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
Subject: [PATCHES v1 0/5] perf tools: Fix OOB reads, reference leaks, and overflow in sched/script/auxtrace
Date: Fri,  5 Jun 2026 09:15:09 -0300
Message-ID: <20260605121515.1725549-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Five more pre-existing bugs found by sashiko-bot during AI-assisted
review of the perf-data-validation hardening series.  All are
independent of that series -- they are latent bugs in surrounding code
exposed during review.

  1. test_bit(cpu, cpu_bitmap) reads out of bounds in
     auxtrace.c:filter_cpu() and builtin-script.c:filter_cpu() when
     the CPU value is negative or >= MAX_NR_CPUS.  Same class of bug
     fixed in the previous series for annotate, diff, report, and
     sched.

  2. cpu__get_node() in cpumap.c indexes cpunode_map[] without bounds
     checking against max_cpu_num.  Callers like builtin-kmem pass
     untrusted sample->cpu from perf.data.

  3. Thread reference leaks in perf sched timehist_get_thread() --
     two error paths and the success path in the idle_hist block
     fail to release thread references acquired via
     machine__findnew_thread() and get_idle_thread().

  4. sched->max_cpu updated from sample->cpu without bounds checking
     in perf_timehist__process_sample().  Later code uses max_cpu + 1
     as iteration count over arrays allocated with MAX_CPUS entries.
     Also caps the env->nr_cpus_online initialization.

  5. register_pid() in perf sched replay has integer overflow on
     32-bit (pid * sizeof wraps), strcpy into fixed 20-byte buffer
     without length check, BUG_ON on allocation failure, and unsafe
     realloc pattern that leaks on failure.

All require crafted or unusual perf.data inputs to trigger.
Verified with gcc and clang builds, checkpatch, and perf test.

Arnaldo Carvalho de Melo (5):
  perf tools: Guard remaining test_bit calls from OOB sample CPU
  perf tools: Add bounds check to cpu__get_node()
  perf sched: Fix thread reference leaks in timehist_get_thread()
  perf sched: Cap max_cpu at MAX_CPUS in timehist sample processing
  perf sched: Fix register_pid() overflow, strcpy, and BUG_ON

 tools/perf/builtin-sched.c  | 56 +++++++++++++++++++++++++++++++++------------
 tools/perf/builtin-script.c |  2 +-
 tools/perf/util/auxtrace.c  |  3 ++-
 tools/perf/util/cpumap.c    |  4 ++++
 4 files changed, 49 insertions(+), 16 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
