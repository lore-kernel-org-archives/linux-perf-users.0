Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B4126C02
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449494; cv=none; b=bBSuJKr41MsW/cSrCzOqi30hJHWBXX3EitfA2bSjwNwLeon2JgX9B/gb9C80Kl5/yU1f7SzYNqGySv3DUHGCoOX9FRlaAnpe6qL8kjIpBhnfPkf5LJWcglz2oFlwms6EQpTr4xmuq1zpyyxBwQJ+i8PCC9WQFgd27s9cP4PenYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449494; c=relaxed/simple;
	bh=2WGEjuS5MMsXErxnooi02x6KoBDEWMmlWw2VPFWwDPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tk4FMn+fsF4k+nIIpcMHGCmCoYyyA03mw5oilP9ln1afGwNdKVx+CNXk7W3ithxJzDECh99Kogds8jhYQYqwyc3zg0kUpwzpK2LzSK2b0ymt0iu+/ABOFZKonJlchliiM6d5FZE9n+4LVwWxjkqq2m8sZHEPsx0S8wkgb0pdMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwjiijEj; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwjiijEj"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso1436608f8f.2
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449491; x=1791054291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSSlt6s9BMdlJBukcaK5utAfNxxHbM/5fOK99H1p/Rc=;
        b=gwjiijEjgNNtGIWm21CpFaHZh+huTnQO6f+PCHpztWOmTURTKI0mmlj2YYBEEsyhzd
         NDUQvIzzQ1+7GOfSk9Tz4m/m9Gp0WnJgobaEu4zmrhfrCBca2baBcSyU8ndlvNAHdOFp
         IbbR7/loeKibGMZ+ACEDbwfxA4wWF+MNIVRdeiTEq7GuXd1fOs8DMWlXBmhlypmhzSco
         qsb1sHtrsPHeS0I80f6iIyg6JXHxItDujmaqGt6BRtT4soKO8RhSAaopFgY+Ud7A4I82
         5rguhZMXRGntUu+0Zlj+eqBIRwGSQWR22VgkioSRDRnWb3vZ1w+2zOB9DbiVyTVe2Ci8
         nr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449491; x=1791054291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSSlt6s9BMdlJBukcaK5utAfNxxHbM/5fOK99H1p/Rc=;
        b=InTHArI14WCQCSAh23VJpNfOZ99mGM7x4l4kP8NxggYpWYi4nWq2MTWmVGN1iucyrE
         AUSgIxTkbQ0pmmSc6jqqwrVESaZgbFKWW4jU3RnUEltw7oXb7Q1kenFE3KKZ+yKyOLrg
         PsYWACpVSj1bPDyO5c9SRBfBIa/XFAVOEnW/Gh2JiCUB95IhlKPy4KmdtAPuwmC1sxRo
         e9aUQyGK57lpoB/TWnwszNf1xesernnBuB07twYP1GR1HaKRQCTrjMC/GWEPW9Kb9wzx
         9VEpFlG7H8liaxBXrQmU+3CFEUcU/DOm3gA6MttHLwpj+Z2+cVwMUUjbW/+8ewFoSk5P
         Kw6w==
X-Forwarded-Encrypted: i=1; AKwUvBxspvzuSNpphTZQ002LP3dA8MJRDsYYwB9Kv0zOIrZO1OSCxIWvVlI0aeRz0U0wvAqS6z6QhKxIGi5vW2Qacs7R@vger.kernel.org
X-Gm-Message-State: AFq9FYJzEdqhlDmNBWfu3F5WWBJsfw7DzqhLhyctv5hr2p+itE7aYySw
	/fbvV/ZTc2LUi5aK1BP53PTtQOOsGb5wHoZaG+ZTwBynup7qHADAUrrp0uL4npIhiNQN4w==
X-Gm-Gg: AYBFou2xWESw5XHMWGR2Tl2AJ3aSSxy2z/zr+V2w4rbQveCLSDlysXnXVGDlx5Wif06
	vuwreTfKz2x2c2/p2BDP8k7x6wevtrn968PvZPKmEHrQnYZZrF3GeFkXth+hJTA5zwSmI70qD/C
	Ol5rQL3hXXm4K3Ge0ed/W5otLTiDfgjAGWnivxN9CnCoQ7HIZcH6f9aCDTrW0C7p+gl1GXeIK/S
	FD2LJUvA932TRfxwj5NNUBzksM0vOuyDWN6plxv5JtigXLx9/GB2sOUTdJLHK/GO07sd7+8/f9r
	8KFVw8HdEgSJDXHsjxdsOEjoRsKZWeRbmBO4j+KAm8uhuzOzhbwkaApDmxN3qmfgxnA0+/de4xZ
	EUcnANpdqDR39C3bLmeInZALV8OhhHj0e6Cy7J9YB9tODcBE1kMRj7dBrVuKxEeeNLyZvK+SLb4
	9KXrnv+FWYk8Q02fXuTJdKXtM38TLvalm0RK/xDjhpxzyUyCgURSWPRp4GAO2vtCYW+H/FUB6GS
	e4R1SFoCHPmw6f00/6RKcfm4EQs5r5J7lqSyWwVApJSLskYF/e4VJy71upuhI9Y+qN2pgLXMeEl
	KpkvqLRinI0ODA4HXBrKC+fODWCuY79tu8wXWefXpWNiPw+efxA=
X-Received: by 2002:a05:6000:386:b0:488:8c99:fbc8 with SMTP id ffacd0b85a97d-4888c99fcccmr560240f8f.50.1790449490989;
        Sat, 26 Sep 2026 12:04:50 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:50 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/8] perf bench futex: Fix several bugs and bad inputs
Date: Sat, 26 Sep 2026 20:03:59 +0100
Message-ID: <20260926190407.1106421-1-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several bugs in the futex benchmarks of 'perf bench'.
I found them by running the benchmarks and reading the code, and then
trying edge-case inputs. They include hangs, wrong timing and throughput
numbers, and inputs that were silently ignored.

I used an LLM to check whether what I suspected were actually bugs, and
later to look for more edge cases. I reproduced and reviewed each one
myself.

This is my first patch submission, so I am happy to reword, reorder or
split any of the patches.

How I checked each problem, before the patch:

1. futex_wait() never returns EINTR, so the signal check never worked.
   I confirmed the hang by sending SIGINT to one worker thread with
   tgkill(2) while 'perf bench futex wake -t 8' was waiting: it hung.
2. 'perf bench futex wake -b 128' fails with an error from
   futex_print_nbuckets().
3. Run 'perf bench futex hash -t 2 -r 30 -s' and send it SIGINT after
   about 3 s: the throughput is much higher than in a full '-r 3' run.
   The timing problem in the other benchmarks I confirmed by making
   gettimeofday() advance by 1.5 s per call with an LD_PRELOAD shim.
4. 'perf bench futex requeue -q 0' and 'perf bench futex hash -f 0'
   hang, and 'perf bench futex wake -b -128' silently ignores the -b.
5. I confirmed the hang by making FUTEX_WAKE fail with an LD_PRELOAD
   shim.
6. Only affects 32-bit builds, see below.

I can share the small test programs for items 1, 3 and 5 if they are
useful.

Not tested:
- Patch 6 (64-bit counter) was built and run only on x86-64, as I have
  no 32-bit setup.
- Patch 5 was tested with an injected failure, not with a real failing
  system call.
- Everything else was run on x86-64 with a 7.0 kernel.

Patches 7 and 8 are optional cleanups.

The series is based on perf-tools-next, commit 528b1475f9cf ("perf mem
record: Use the IBS swfilt filter when available").

Thank you!

Michal Pluta (8):
  perf bench futex: Retry futex_wait() when interrupted by a signal
  perf bench futex: Set the number of hash buckets in futex wake
  perf bench futex: Use the whole timeval for elapsed times
  perf bench futex: Reject invalid -q, -f and -b values
  perf bench futex: Stop when futex_wake() fails in futex wake
  perf bench futex: Use a 64-bit operation counter in hash and lock-pi
  perf bench futex: Clean up two nits in futex hash
  perf bench futex: Fix wording in futex bench messages

 tools/perf/bench/futex-hash.c          | 23 +++++++++++++-------
 tools/perf/bench/futex-lock-pi.c       | 16 ++++++++------
 tools/perf/bench/futex-requeue.c       | 12 ++++++++---
 tools/perf/bench/futex-wake-parallel.c | 15 +++++++------
 tools/perf/bench/futex-wake.c          | 30 ++++++++++++++++----------
 tools/perf/bench/futex.c               |  9 +++++---
 6 files changed, 68 insertions(+), 37 deletions(-)


base-commit: 528b1475f9cffbaffb37f490e86780662471ef3f
-- 
2.43.0

