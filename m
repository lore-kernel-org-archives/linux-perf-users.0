Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628F1DF973
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656183; cv=none; b=HHB9K8VelwHQm8/RGsHj4jUmQQF8F3ny3f1nM7rNnC9QFbg30e44cYRWMGhfhFPVaU9aBhy7TJhch4sFd2VeaNPmUah7IUeABZMsMilbWWUlSpiT6yhj1o2FYwXtYRpn9f2CF5l/+y5CYvM19R1izbIb347TtgIAYx1YEZ0sc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656183; c=relaxed/simple;
	bh=uWfG3aFd9L7KcN8o/2ryZod93n0xGj+0UAobnfXWQok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tPEPRwUJmH/8fJx+el0xX+sdXr2TSoOSAQm6QCVyMLvNEArVz8BgDLz03v241PtNe/ovX4Rbf1Z5AuIzJ3Gbn8PV+H5ji3mkWLpMZV7vqkvwKsajXY4OJMMg8SlR90Cc/p02uodOQliRmPgzVbMAtqsMdWGUzgzRQz+eanmjvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/xqKQZd; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/xqKQZd"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-296bc214420so5120584fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732656180; x=1733260980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CyA4dAp81BoyY8Q+pL46oKmUutuArwSzQiAf9JnH7U=;
        b=X/xqKQZdBJzE47Ff4ohOXc6AdfR92ScaBDRcKJVXfT7ygHTZ714w4tu5CDLvDji1UF
         EAhhiIuzdlLOjre6w3/k1/6Bk/mlWZcYI9NPG2TRVXhpVd8j79/lzbXDgIV/DDvies9Y
         BnSnKRsINur3S61YHU+og4FdXfl0QWjzvhZ6FMZDq0DTehvWTzBO3YRS4WUMpKi2bZ9P
         pb0dJnb2jKG/3NG15m5Gc2yOzFsruTQ1pfPEyRz0aiAgpECaGarzh/c2tppgtyrSUhue
         O2fOhGrFYTDbCWJvenW0R5pe+yRiB6h+JBu6RXngk+zyLVZarxKyuUO4nLAdfCD/VHL8
         xmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656180; x=1733260980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CyA4dAp81BoyY8Q+pL46oKmUutuArwSzQiAf9JnH7U=;
        b=lD6Z3+FEhMpD84JuoUu85tFv5UUmz1r57I96jSSS86rBwek5B5QkC/rHM6noB7svpW
         f9tqXtKJ7vwYBBk8e/6D9x+T2I/jxbFGjj2r29d6FSDRJ95BZBuVKjagSdlz2E9W+6tf
         ltF/tTk4eT2CII9CQiioBf96AcvlPF4kc21WKsMQZkP9FGj5aJXitleUa4fqemVIdJh1
         zmWAN5yvztZWS3cOBYXbXRjz44yW2mbBcjdJE0zgCgf6LNN9mQcYvU9lOMXdeT1vKd4s
         Lfg2LIcqVNQFZMHGuoX2vu5QSrXodw4/aNq5ovh7mZLBO5YDEkmmhw7Qv80bOppOpunm
         R3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0a5MLdxwjNqmoM/KQuBlxoAssaUDNwDPLEZZjxWAD6SjdI/jX+ErOVKih5QoLdXyhjxl8dBGPYL+/bam/m2Ta@vger.kernel.org
X-Gm-Message-State: AOJu0YzukYymdaZ2p0wiSemt+RuvRkxDhzyXNDrT8IyEP+RJJkNXRrOy
	9EMq5b9QS2mKEsmq7Mp64QuM+/DWMzc6jX7VCUHtuDWCub0Ysd2Y23wz4pvEiy6BSvBvxVpF4GM
	zqw==
X-Google-Smtp-Source: AGHT+IEpSyqe3GdnLFU3135TtDqH0ZaMLDEV7pZ3XE/nL53nO8kfwk/awIzeHTAYxt60d4LnAGsOHkC+5n4=
X-Received: from oabwd3.prod.google.com ([2002:a05:6871:a583:b0:296:7f65:cd4f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:658b:b0:25e:d90:fe70
 with SMTP id 586e51a60fabf-29dc44d0c38mr391293fac.43.1732656180729; Tue, 26
 Nov 2024 13:23:00 -0800 (PST)
Date: Tue, 26 Nov 2024 13:22:54 -0800
In-Reply-To: <20241126212255.3793822-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241126212255.3793822-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126212255.3793822-2-ctshao@google.com>
Subject: [PATCH v3 2/2] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`parse_lock_type` can only add the first lock flag in `lock_type_table`
given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
into this perf session. Another example is for `-Y mutex`, it only adds
the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
so on.

Testing:
  $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 8.425 [sec]

         8.425402 usecs/op
           118688 ops/sec
   contended   total wait     max wait     avg wait         type   caller

         194      1.68 ms     44.16 us      8.66 us        mutex   pipe_read+0x57
          10    423.03 us     44.27 us     42.30 us     rwlock:W   do_exit+0x365
          54    254.67 us     58.87 us      4.72 us        mutex   pipe_write+0x50
          21    146.64 us     11.54 us      6.98 us        mutex   pipe_read+0x282
          10    141.27 us     20.62 us     14.13 us     rwlock:W   release_task+0x6f
           5     58.92 us     16.37 us     11.78 us        mutex   do_epoll_wait+0x24d
           3     29.81 us     17.66 us      9.94 us        mutex   do_epoll_ctl+0x6c1
           4     26.82 us     11.02 us      6.70 us        mutex   do_epoll_wait+0x24d
           2     18.32 us     12.49 us      9.16 us     rwlock:W   do_epoll_wait+0x255
           1     11.34 us     11.34 us     11.34 us     rwlock:W   ep_done_scan+0x2d
           1     11.02 us     11.02 us     11.02 us     rwlock:R   mm_update_next_owner+0x4e
           1     10.60 us     10.60 us     10.60 us     rwlock:W   do_epoll_ctl+0xb65
           1      9.90 us      9.90 us      9.90 us     rwlock:W   do_exit+0x365

Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 68 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c528aff1c9d5..c1870c287580 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1622,19 +1622,6 @@ static const char *get_type_lock_name(unsigned int flags)
 	return "unknown";
 }
 
-static unsigned int get_type_flag(const char *str)
-{
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].flags_name, str))
-			return lock_type_table[i].flags;
-	}
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].lock_name, str))
-			return lock_type_table[i].flags;
-	}
-	return UINT_MAX;
-}
-
 static void lock_filter_finish(void)
 {
 	zfree(&filters.types);
@@ -2356,29 +2343,64 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 			   int unset __maybe_unused)
 {
 	char *s, *tmp, *tok;
-	int ret = 0;
 
 	s = strdup(str);
 	if (s == NULL)
 		return -1;
 
 	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		unsigned int flags = get_type_flag(tok);
+		bool found = false;
 
-		if (flags == -1U) {
-			pr_err("Unknown lock flags: %s\n", tok);
-			ret = -1;
-			break;
+		/* `tok` is a flags name if it contains ':'. */
+		if (strchr(tok, ':')) {
+			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+				if (!strcmp(lock_type_table[i].flags_name, tok) &&
+				    add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+					break;
+				}
+			}
+
+			if (!found) {
+				pr_err("Unknown lock flags name: %s\n", tok);
+				free(s);
+				return -1;
+			}
+
+			continue;
 		}
 
-		if (!add_lock_type(flags)) {
-			ret = -1;
-			break;
+		/*
+		 * Otherwise `tok` is a lock name.
+		 * Single lock name could contain multiple flags.
+		 */
+		/*
+		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
+		 * For backward compatibility, we replace `pcpu-sem` with `percpu-rwmem`.
+		 */
+		if (!strcmp(tok, "pcpu-sem"))
+			tok = (char *)"percpu-rwsem";
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].lock_name, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+				} else {
+					free(s);
+					return -1;
+				}
+			}
+		}
+
+		if (!found) {
+			pr_err("Unknown lock name: %s\n", tok);
+			free(s);
+			return -1;
 		}
 	}
 
 	free(s);
-	return ret;
+	return 0;
 }
 
 static bool add_lock_addr(unsigned long addr)
-- 
2.47.0.338.g60cca15819-goog

