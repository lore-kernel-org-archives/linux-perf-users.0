Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC52DECB9
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798450; cv=none; b=f4RwW0PzYxMrAjzNTvHudRCCBMNIiq9E010Tl4Sv0mZ1X/FZaTW64yLXOiuOXoV7g0tyRCDbFHQXUhJtYFOZgD3I7G5WTogzT6X3UB0UuZYF+7EHgs5xukisX49zv8kIRj84gCmzcTheqUjerMpmeCyPE2PloCxPS72+/yNcOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798450; c=relaxed/simple;
	bh=NLjjJgqj44yOShiPvUtgrdHvboGVu5475ukXj0UL1WE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dBaRY82zVmOI9NBIDzlcPsUZXMH7BibXX/Y5V2Wr/XzWVsXMzFO7czwnHyKH0visVMhk02jVEk35E1TR7i3WxUANhdX1Mb7lGuTjWcW2AJpzamxJPUQl06JO9XggEm7rmzGS1r7HsCFUb/PPJyRxnSsz86zRj++afZDune7MytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgMJpgMz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgMJpgMz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f8a2ba9eso4486515ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798447; x=1765403247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ROp2gD1qsi5HFemrZlvE5vnoydq6n4iQlRkymTuUuc=;
        b=jgMJpgMz41ZkXX6Q7M80cfV/fcFXXUgwdzB3e7KCtrj3lmGNiEktxPohCGNGFdpyrG
         /RuAoUTxM0g8L2M4DSVjRL+OWdm/Lz7sexng8ebb6ZzjzN5mtom6ctVKB/2NDPQvSA5M
         Lg2msT9Jd0xV42sHdlLdTILBBY4K3uSjGrzMFH3mOld7fMFBByxPvqk93JpTE+JdTh5U
         8ln42cNUMb4m3MukkYAekF3aubgZ6xcuBD4FWSDrjCZByZTLXyONsgUgNkzDXHkWJthr
         9U00Sizuf/yDCPNI9RRZQauKar4mNwcGUGovGHM1ZRY5Yna5rOfoxuF69+eJFR9h+XSz
         18Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798447; x=1765403247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ROp2gD1qsi5HFemrZlvE5vnoydq6n4iQlRkymTuUuc=;
        b=rEedfbAXJgs+wuxdINKI5wgCpKpiB0c2wD5Ai7wHp+24HI+71pxHlOS6cbbkewDd68
         7NaXugDoUM8YkB3DCE16EmhzFHVR+6IYe2Jvo7WY44OXg/8GYY+po3g5sZEBPo1AhL0Q
         Z0Ea7nynAlU7ZO0l9pN6/sA2jO7d2jc2ICUeBgHVsDabTgusvDdFJa5P2aZvazzQiLN5
         lXUULiyAEipK9hmHjlB3n5rWoxecUcjd5FH2OdKS4cpVyU6vMWc07pVo1u0brRvIWIpF
         fa2XVLXUQT6ur5DfzBzyARyfxQ9+6EXoDObSSjOLS6RtE1pp/2ptxejXSSX+vzNa1b9T
         2dIA==
X-Forwarded-Encrypted: i=1; AJvYcCWgwl33oKqaWr0yRm7CjdB6MvWrNgrN5dM0fx7Y02bccraJMkdikG5B9QKG8cd53hDYEo/oQyKWQB6Upo/iLSQ5@vger.kernel.org
X-Gm-Message-State: AOJu0YzSezzhflOoj7mEHRX6KmMWLlTTE76aMHvRSe7/byPF9wwLTrRZ
	vd/N1AYdiH/3zIxAZuDmDcHytNV513KwJ6rsBp6pZEByE+73xlvt/bUvqNRpMRfoqgfjehL0Iqc
	0alRNadkA+A==
X-Google-Smtp-Source: AGHT+IHOGolbfyVik9GfL8FV0R1q7aR/DF1pW7wJKBvhtMirbEukdNxXMJ1WtmyaSH2UeJq4wnhjMPuIrobw
X-Received: from dyjh23.prod.google.com ([2002:a05:7300:5617:b0:2a4:7a56:1730])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4007:b0:2a4:3593:96a6
 with SMTP id 5a478bee46e88-2ab92e8105amr1977090eec.35.1764798447380; Wed, 03
 Dec 2025 13:47:27 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:06 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-8-irogers@google.com>
Subject: [PATCH v2 7/7] perf stat: Improve handling of termination by signal
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When interrupting perf stat in repeat mode with a signal the signal is
passed to the child process but the repeat doesn't terminate:
```
$ perf stat -v --null --repeat 10 sleep 1
Control descriptor is not initialized
[ perf stat: executing run #1 ... ]
[ perf stat: executing run #2 ... ]
^Csleep: Interrupt
[ perf stat: executing run #3 ... ]
[ perf stat: executing run #4 ... ]
[ perf stat: executing run #5 ... ]
[ perf stat: executing run #6 ... ]
[ perf stat: executing run #7 ... ]
[ perf stat: executing run #8 ... ]
[ perf stat: executing run #9 ... ]
[ perf stat: executing run #10 ... ]

 Performance counter stats for 'sleep 1' (10 runs):

            0.9500 +- 0.0512 seconds time elapsed  ( +-  5.39% )

0.01user 0.02system 0:09.53elapsed 0%CPU (0avgtext+0avgdata 18940maxresident)k
29944inputs+0outputs (0major+2629minor)pagefaults 0swaps
```

Terminate the repeated run and give a reasonable exit value:
```
$ perf stat -v --null --repeat 10 sleep 1
Control descriptor is not initialized
[ perf stat: executing run #1 ... ]
[ perf stat: executing run #2 ... ]
[ perf stat: executing run #3 ... ]
^Csleep: Interrupt

 Performance counter stats for 'sleep 1' (10 runs):

             0.680 +- 0.321 seconds time elapsed  ( +- 47.16% )

Command exited with non-zero status 130
0.00user 0.01system 0:02.05elapsed 0%CPU (0avgtext+0avgdata 70688maxresident)k
0inputs+0outputs (0major+5002minor)pagefaults 0swaps
```

Note, this also changes the exit value for non-repeat runs when
interrupted by a signal.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/lkml/aS5wjmbAM9ka3M2g@gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bd3c3de8d200..ab40d85fb125 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1007,10 +1007,20 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			goto err_out;
 		}
 
-		if (WIFSIGNALED(status))
+		if (WIFSIGNALED(status)) {
+			/*
+			 * We want to indicate failure to stop a repeat run,
+			 * hence negative. We want the value to be the exit code
+			 * of perf, which for termination by a signal is 128
+			 * plus the signal number.
+			 */
+			err = 0 - (128 + WTERMSIG(status));
 			psignal(WTERMSIG(status), argv[0]);
+		} else {
+			err = WEXITSTATUS(status);
+		}
 	} else {
-		status = dispatch_events(forks, timeout, interval, &times);
+		err = dispatch_events(forks, timeout, interval, &times);
 	}
 
 	disable_counters();
@@ -1050,7 +1060,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (!STAT_RECORD)
 		evlist__close(evsel_list);
 
-	return WEXITSTATUS(status);
+	return err;
 
 err_out:
 	if (forks)
@@ -2969,7 +2979,7 @@ int cmd_stat(int argc, const char **argv)
 			evlist__reset_prev_raw_counts(evsel_list);
 
 		status = run_perf_stat(argc, argv, run_idx);
-		if (status == -1)
+		if (status < 0)
 			break;
 
 		if (forever && !interval) {
@@ -3039,5 +3049,6 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
-	return status;
+	/* Only the low byte of status becomes the exit code. */
+	return abs(status);
 }
-- 
2.52.0.177.g9f829587af-goog

