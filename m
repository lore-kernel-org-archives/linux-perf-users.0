Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B8188A0D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774468; cv=none; b=SYDSloTOa//sGedJsNZhxe4BxkKBbMDvBnSwylKUFb8FTWGJA6pED7isvl31s6fiEEBKEaJfzIzNG0glh/c0mkxgskTSOZ2kW+RcTZY3YMVOVLTwZWxnwAXqabemKpnNU5PN8sHbh2qtrWq7KaRPcqIZzTKVqreAo4UuNMQO2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774468; c=relaxed/simple;
	bh=BaaZxujHgG2t7evwB5rcD5JUaUCQqf9yUP7/6Hi+Q3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jDbmOlCkDfuBrtGKBxs1oCLvCZS7VSBtMSMDfO6FI2/rMst+CMbPUrJkvR3qHbW52AZmY98qmj70p2OTeni8ZDgWYlCAtYOvylZfTciSJbEVzyWp49QNeOfGa/utouzfuw0GeNpL+S7s0hattEIVqvxvHdrtUTOk1+2vzcR2tjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUmIgnhg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUmIgnhg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso4992333a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733774466; x=1734379266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEctiwolqpRNFt6r2cG+m/ALbcflvyW8CFZ6ABOg1Hc=;
        b=HUmIgnhghp4kmaFPSasiq/JUt8mXXxSf353FdKLKkgyaxZI5rScVnfUxUZtohOp+B1
         6nuThtfedBxkA8kxOTa+8Eh2XP3AD0KwdVY7HdWFti/AaVcLAeRHFZ659oVSPs5fLwm/
         ZgaZlY1X/TTkFgOG2oi+aHqodeYnlknyZNFIBXBGpUfogRlkS2lti7qycGxIpWZ6ud0u
         03jtGg/Ql6X3myzLErPVxTYFbZSbJNpKPHwvTOCaortyy1OZMi3PPmzLimpCrEmbajyH
         7wbbjjzzgBsiR5CwToUHljjJCeLAdQAXy2JOEQD0PwnhHjqw42DWm/mPY9+FXQh7qzuC
         CXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774466; x=1734379266;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEctiwolqpRNFt6r2cG+m/ALbcflvyW8CFZ6ABOg1Hc=;
        b=szPH/fXi6XEUl2Ari5uyKxIavoZMmLP2BZzxnGeAJ+zAyVkNsZHle87e5v4gs2/Ynk
         Uy098yUqBREDc3djZPVdLznix09ggUIDZA9uk78bW/O8XXagSJ36WFAjfJsVPvJ5RJ0G
         WOF+H5oP+FRI4mWgSZMmDo/cVM3/RkRiAqri2ii6SZIpbFnbhPuj1r0mmK0WsmWme1UC
         njwsAIw6oG8hNiVHBAMuZyJ/jo3RWEQlcOwn8XfnYRQ51qyUtuzZZYjG4T+eVT/p9JPf
         pnE0YD3Ti3cuo78vv1CBkJVgOcAg/9vdw7GcG34RcaZr/5/1gJ+sa6cUbJVYPSrRd/nC
         ue8A==
X-Forwarded-Encrypted: i=1; AJvYcCWwIX5gpoNArlERD4SJU0lyn90EE9xQCuUBqGSkuci15Hy8LmEyg/bEhQzL/1Ky/fz6DM3E+KfLhKIhLjsWb0yl@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRH4sqSU6jJmrHDj+MKgpObRWkQ4rACppNw3N2GldPFk3P8FV
	gC7fGZo3efUKmPzo1gyAYqOI02PtjHgzJWFGpOjeqLbQlXeCD2fvPby78IprOqt3dO2Oqw3AjbN
	jaA==
X-Google-Smtp-Source: AGHT+IHdLQYoqadK/lg7+ZfEvWTFu8V3oOEk4LhVn6dqYlJPQRozBI0ERYxSxCUL0KIQA3czUkz5x4aHcYo=
X-Received: from pjbqo11.prod.google.com ([2002:a17:90b:3dcb:b0:2e2:8d64:6213])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d88e:b0:2ea:61de:38f7
 with SMTP id 98e67ed59e1d1-2ef6ab0cf78mr19092102a91.29.1733774466684; Mon, 09
 Dec 2024 12:01:06 -0800 (PST)
Date: Mon,  9 Dec 2024 12:01:00 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209200104.870531-1-ctshao@google.com>
Subject: [PATCH v4 1/3] perf lock: Fix parse_lock_type which only retrieve one
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
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 64 ++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..7e36bbe3cb80 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1591,8 +1591,6 @@ static const struct {
 	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
 	{ LCB_F_MUTEX,			"mutex",	"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
-	/* alias for get_type_flag() */
-	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
 };
 
 static const char *get_type_str(unsigned int flags)
@@ -1617,19 +1615,6 @@ static const char *get_type_name(unsigned int flags)
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
@@ -2350,29 +2335,58 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
2.47.0.338.g60cca15819-goog

