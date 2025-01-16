Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FCC25A626
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071925; cv=none; b=i0+KXxRgnLMhhOr8+/cPcXWry0S2fGnGFgDXZ2r6WM0UGrYSzmifEdxIykdX2Lho0lS83H9AWtd4aXN3SS/bGsZy8UEZeLsB26pMk8D45xRbTsaWDDN2/Vtry2Wrw/Pn987a60OLZvLmCSwX6/fSgTGyl/yD6Uel7f6Wno4Hn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071925; c=relaxed/simple;
	bh=i4C27Z0R8D7ABmRZn6zBqNMVwgAh8Vm8tMwfl1Q3OSI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RxyEKvOSgN+YBBHK81fn7rsoifJd1au9S76KInCK/i/wOLwJkdhR7HDzYL+L/+gzm+qWT5Y6lrGaWOeFql0K7fo8AdMttwxA48W1AeBBxQbhkmJ6jnK1mj/jVI2h21WeT2qfs6kSKme0hn4MJ0kyqxIYoDTLe4kLig2PsOZMiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXELsv4s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXELsv4s"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso3046865a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737071923; x=1737676723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ouUQ6Nhbo+/fod3mu05aAqFRUVTpjmXgPx7yu5ZFqT8=;
        b=sXELsv4szDjgCmQnLx1mxJmP28/VOc53EArlJ6xH0A7mXw1r+EEYaDGBkdNrd+gmIQ
         51/aZjZaeH8BcflZbg9BLt5Cn9hpO1KYReGWo6UPi8epdlIiRHWEeIcpQlBNyJw2T3Qt
         QY0t8qVAGy/sLYD3hGF2cm36iSIIpQSYeS0JaFhVGQ1JkoWs1vrB1oINLa0BBy4402f2
         gsQ/JGoGLzq3nm1CAibyxJu6U5JH3ON1HS4/FRNvpOLGv6R+WjAIHlB3MC+O1nlYW5+B
         V0TIiRqoRpEkIgyvfmABIN0zxJW1x+SgkmTmVZjMNnEASQnS362LWPHcN/qSPsaUjBx/
         obow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737071923; x=1737676723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouUQ6Nhbo+/fod3mu05aAqFRUVTpjmXgPx7yu5ZFqT8=;
        b=uZ57vjVMq/7XhEH6C8PNEhOeGM9+KXVBeYhtGSvDWTZoz38PAbatan0Qa1oNSQdpxh
         tscUy0z45SfkJfyDAf3vP5BFetLWnhiDxwAPtmkCXdFAUn92pHS0pCisZXz5ULVBd+Tc
         wb/69LL+KrL299hc+8NWpaVkYEGutGUp/w7sQPpEzf//presxDWcoPldHdh+TJ06f5gL
         KSdePeTbyyG5OFpb9M1B2nX5pIJf/BRowPhDgqBraJHUBWpkpNpyJSR+6qidNLjrLEL6
         OQDwc2ntuHbe3yDCgoM9XOLkb0N7ex6rXkJLvgnb7XfCoGwhr/7h+Bg8RxSB7Fkgi+/G
         tmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkwWmFfz5nSgK96NUFyxLpfWp9eTIB2OOxhJEMFol69Qgqc91k4M9RYzhrUUvKR2Z+GJAfE1m+h2IKh3jSOizc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1A7GGVJPBBxC+z33NrLm5i/ETzQPXf3IdwEm6wyRsXuqCfz0r
	a/NMZe0TwrLnaZMk4Fjarj30ergn5u+SO+Kldy7AGTGY+udFva9Mpq16K4e651OyOaJlNsrloAr
	SOA==
X-Google-Smtp-Source: AGHT+IESfYKOYKL7UmLmUryhr85lwHUaEO3UHwD3l0iV4hagmFJV176VoXm3snFJNo6QPuxlkqwTV7N/2wk=
X-Received: from pgbgb4.prod.google.com ([2002:a05:6a02:4b44:b0:9a1:7139:ff84])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f8e:b0:1ea:ddd1:2fcf
 with SMTP id adf61e73a8af0-1eb2145ea9bmr899678637.4.1737071923517; Thu, 16
 Jan 2025 15:58:43 -0800 (PST)
Date: Thu, 16 Jan 2025 15:58:14 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250116235838.2769691-1-ctshao@google.com>
Subject: [PATCH v6 1/3] perf lock: Fix parse_lock_type which only retrieve one
 lock flag
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
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

       Total time: 9.313 [sec]

         9.313976 usecs/op
           107365 ops/sec
   contended   total wait     max wait     avg wait         type   caller

         176      1.65 ms     19.43 us      9.38 us        mutex   pipe_read+0x57
          34    180.14 us     10.93 us      5.30 us        mutex   pipe_write+0x50
           7     77.48 us     16.09 us     11.07 us        mutex   do_epoll_wait+0x24d
           7     74.70 us     13.50 us     10.67 us        mutex   do_epoll_wait+0x24d
           3     35.97 us     14.44 us     11.99 us     rwlock:W   ep_done_scan+0x2d
           3     35.00 us     12.23 us     11.66 us     rwlock:W   do_epoll_wait+0x255
           2     15.88 us     11.96 us      7.94 us     rwlock:W   do_epoll_wait+0x47c
           1     15.23 us     15.23 us     15.23 us     rwlock:W   do_epoll_wait+0x4d0
           1     14.26 us     14.26 us     14.26 us     rwlock:W   ep_done_scan+0x2d
           2     14.00 us      7.99 us      7.00 us        mutex   pipe_read+0x282
           1     12.29 us     12.29 us     12.29 us     rwlock:R   ep_poll_callback+0x35
           1     12.02 us     12.02 us     12.02 us     rwlock:W   do_epoll_ctl+0xb65
           1     10.25 us     10.25 us     10.25 us     rwlock:R   ep_poll_callback+0x35
           1      7.86 us      7.86 us      7.86 us        mutex   do_epoll_ctl+0x6c1
           1      5.04 us      5.04 us      5.04 us        mutex   do_epoll_ctl+0x3d4

Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
Note:
  Rebased on tmp.perf-tools-next.
  Added `mutex-spin` based on Namhyung's comment after Reviewed-by tag.

 tools/perf/builtin-lock.c | 65 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 208c482daa56..a6203c622967 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1484,8 +1484,7 @@ static const struct {
 	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex-spin" },
 };

 static const char *get_type_str(unsigned int flags)
@@ -1510,19 +1509,6 @@ static const char *get_type_name(unsigned int flags)
 	return "unknown";
 }

-static unsigned int get_type_flag(const char *str)
-{
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].name, str))
-			return lock_type_table[i].flags;
-	}
-	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].str, str))
-			return lock_type_table[i].flags;
-	}
-	return UINT_MAX;
-}
-
 static void lock_filter_finish(void)
 {
 	zfree(&filters.types);
@@ -2249,29 +2235,58 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
+		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
+		if (strchr(tok, ':')) {
+			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+				if (!strcmp(lock_type_table[i].str, tok) &&
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
+		 * Otherwise `tok` is `name` in `lock_type_table`.
+		 * Single lock name could contain multiple flags.
+		 */
+		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+			if (!strcmp(lock_type_table[i].name, tok)) {
+				if (add_lock_type(lock_type_table[i].flags)) {
+					found = true;
+				} else {
+					free(s);
+					return -1;
+				}
+			}
 		}
+
+		if (!found) {
+			pr_err("Unknown lock name: %s\n", tok);
+			free(s);
+			return -1;
+		}
+
 	}

 	free(s);
-	return ret;
+	return 0;
 }

 static bool add_lock_addr(unsigned long addr)
--
2.48.0.rc2.279.g1de40edade-goog

