Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE339A7F2
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449498; cv=none; b=qzoWEZaKwPXnUZeXMBe0oHSbBoYKIdmy/nbHngBTuob3q0K6RSOlDih2Bdm0xodklEvDxflMzsgUiCozVlfcK7W3yK6fwsRaeOMczk3O45RooXi3Y/sfDkcLdC/TncXgEkXLKUfRzDxpUpdVWlOjw+Jjq9B87U/qdwR2sb1Ufr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449498; c=relaxed/simple;
	bh=JsjWOn/Ig6TvpTUnWlM9GCCVCkgc+Omf00J9318U2AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulmuU/Pzp0WGWBdFm87Wqs66EztY/vVY0++ymxmhcQZ3GWuJwZixE2gqdO8zPLR4ocq7Mz5nSuabXUiy9D9BAGAmgLm6RBCvfexUdgaQi/Jq1Ssdeaknp/QHxJGHX4p86F6wjdy0WQZI2mmGsofXBBO/DntS4SzNEwdmh0LDWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE9l3z7j; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE9l3z7j"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488780459e2so1847712f8f.2
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449495; x=1791054295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=moYt9xjLjCCJeOMnvr2pWP4tP6d9gyEqKgc2feoMj+E=;
        b=lE9l3z7jw2gRqKXDBmXQp4OBNZO/UQGkM2fNv5u6WYY7JH60+dfjP1zI/JMEO4kTm0
         8XuPPEqIF16az2AJ1/GUXRw4YR7qAXLXy25Xblg7GrXohT9DrHb+ZRLIgTIJH4QOC3N1
         8MaA25RL1JqP7Xx9gKPzgLGGWfMojQmIve5LbFiCgr6Jwn9AJ1TV3XbMfGjEZSVNLZDJ
         pGtekaDB6Ywu2ylJEtosm5kCWFxLha0LLzbLKkFMa4vbA4a5YcqtqmWo2AeSKnHEQXDd
         xZ71du9JVh0YL1PNMQF+uelJ7a0Sl7c2P1WbWBga8ReqUFeR4DFxKSN1JjMe3PrkmzKY
         8x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449495; x=1791054295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=moYt9xjLjCCJeOMnvr2pWP4tP6d9gyEqKgc2feoMj+E=;
        b=gr4c75vbV7WFxizRJd9p1Qg0xtQ5+ACY/fRGQPBQtkaZhhwgy1TF25WFmoIXKEUuxZ
         mbpFfOjb8/xklysbbdR/lUFgadtw444B+z7NvFbEYiZIpKOfgNlOEeC9e+doaCmz71xr
         nyMAy04b6PPtbgLR0t738mOTCHnpqUoT8CsuYvxBhwc9AXYJiqA059sFUNC0aQ/+GmLh
         /R/3Iae5bCWO/+S86ilf2WyXNrhylOxoq18hOxIexkTrOwuXKBqXKTZo9O9u/HMFNlNx
         aS4VZMO2N/9U6jrAgTyZ+LMRhhvX5myznTjDYMPtELrUfdcSvHrlUVR3YMn0Pf9A5XLE
         B3RQ==
X-Forwarded-Encrypted: i=1; AKwUvByO2prWovpCiWk227Oo9bH12LOAEj70R42KLWvxSdkrbSw3YiLpNp5W/zjlZVPi/fs5lJ+At4iG+IxtM8Ffs5VN@vger.kernel.org
X-Gm-Message-State: AFq9FYJU/yh9wOH5m3cJCvbvkQOi4YINa/m9IclsBy2eUjfozMByurz6
	Leq5SEIM3MXZvBR76qXwfSFBD8mS/X6jUAWxYia3pfSaI3Gd/opkxDgC
X-Gm-Gg: AYBFou0RoMuTtYwP5UoUwm52exhwgqM0FYJRtQNIrZW6+D3wHmm1wTNxBFtAcgbiUjL
	q4nHXpAzRGkUenNn1vkO7DgRD6Zud+XpjSpe2xcjfNL8/lRPC/TOY24/Gz81evfHFAAiEyOuga+
	FJZB2zoYsRXckTGzivcB+TT532NsiWleWfUz5YQRLg/mM6sTQsXLoNgKg1ozmyDlgwdKT3NjBrL
	4q0SnNYWeb9F8wwM1W+AaAniyiMmHugny1ZM/3HmLb8gGs0wtFUpO85SoYf586xHQiCLlmWGPBY
	L5XY+pznw8pMjtcoDzfRXa0o4UYoC68LVDyoLhTUrCm5IdHel9bityq3lncpRz0eQi8iHMEyIXY
	SuouY+vW4HkZpKI8uqkV5AJ0oLL9FyWX5gbtSj9RQlt63FYziv2CNY9zRBJQBUpoutuo/SvZGZ3
	c4dmEO5DwVvCZ48TDZX5gWXrEWFj5oRGadoPqePZ6oHWSgWzCW2TDhTt3tz8htf1m0TvLTNe/Zm
	ISfslN4OwgsItrSajiYJmzFV+AWMndugklR+P5ITPpZU9zlSqkJcMUpVy5HvYx5JkzLkIRmGJvs
	Q8XNbe9ZJWlT59B6DAQE79vFafa5U67n90TJdirSEZ1hYqTz9K0=
X-Received: by 2002:a05:6000:384:b0:488:63f2:8766 with SMTP id ffacd0b85a97d-48871728c55mr16484789f8f.21.1790449494691;
        Sat, 26 Sep 2026 12:04:54 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:54 -0700 (PDT)
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
Subject: [PATCH 4/8] perf bench futex: Reject invalid -q, -f and -b values
Date: Sat, 26 Sep 2026 20:04:03 +0100
Message-ID: <20260926190407.1106421-5-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926190407.1106421-1-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some values make a futex benchmark hang or are silently ignored.

'futex requeue -q 0' never finishes, because no thread is requeued.
'futex hash -f 0' never finishes either, because with no futexes the
workers never notice that the run is over. A negative -b is treated as
if it had not been given, and the kernel simply auto-sizes the hash.

Print an error for these values, except for -b -1, which still means
automatic sizing.

Fixes: 0fb298cf95c0 ("perf bench: Add futex-requeue microbenchmark")
Fixes: a043971141f1 ("perf bench: Add futex-hash microbenchmark")
Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buckets")
Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-hash.c    | 3 +++
 tools/perf/bench/futex-requeue.c | 4 ++++
 tools/perf/bench/futex.c         | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 32b88df8ee6d..710c253cfe17 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -161,6 +161,9 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!params.nthreads) /* default to the number of CPUs */
 		params.nthreads = perf_cpu_map__nr(cpu);
 
+	if (!params.nfutexes)
+		errx(EXIT_FAILURE, "-f/--futexes must be at least 1");
+
 	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
 		goto errmem;
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 5d4708f40c60..bc6efc2ecadb 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -207,6 +207,10 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (params.broadcast)
 		params.nrequeue = params.nthreads;
 
+	/* A regular requeue that moves no threads would never finish. */
+	if (!params.pi && !params.nrequeue)
+		errx(EXIT_FAILURE, "-q/--nrequeue must be at least 1");
+
 	futex_set_nbuckets_param(&params);
 
 	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %s%p), "
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 1968c9d00b5b..5757d47f8f7c 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -17,6 +17,9 @@ void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 {
 	int ret;
 
+	if (params->nbuckets < -1)
+		errx(EXIT_FAILURE, "-b/--buckets must be -1 (auto), 0 or more");
+
 	if (params->nbuckets < 0)
 		return;
 
-- 
2.43.0

