Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3723909F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552933; cv=none; b=B3ZNUNqQbKVJ8wPDb7/2xovXQJy8ERpR6FJoMJGHWcx9vy+16wbE+TDtbtcD2phmcHdtslHzc9PIEM1nE+vvbakpVp7bxCDyunN5Lp8s6LJMw+YAJuoDxPQ5ufyKTJOpyKLAOt1LMejAVenFBOCH489XXJPEsZ65J3qpejgGu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552933; c=relaxed/simple;
	bh=4eWUqLwBnzO/oAAgJK7XoceNIi25ziducW/VGCAJXck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Q+vYVgm9ufmcO6hURt3mG18qS63uBeJqps47kVKeXd+KdkOB6lwpW8zYaVhfEm7oQYYvpB0dddBXgsRd9pRXhGOgCo1eRzF2FAttoCP4jeQG6T/AE/33pM2xG9yZa1VHEEz+9kYr7YacWSTGcfw0hxtVF5d4x8TO1bMfzBoM1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HC5FqISB; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HC5FqISB"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso2439695a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787552931; x=1788157731; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RJSinviL1rUCPbdWLEv3+LGdZL1Zd0kdSRn2umOLqM=;
        b=HC5FqISBVld/qjicU0puH9Qd6mae6KaSnrQ3ST9o+NdbX5oDmK0cFeSk2q3dvvPbVn
         s0MYyRN/efmrWM3XBQHB8lZ5R/J8WM3GVouKtqdkJZRTXh9w+dwDNvvPv5J1mJf15YKv
         UCbcQ7LaEFdMp2mzJoj8wWaCBnQgYTVUYW/h0i3+sIvNCHYjSuQlQGqcqGquzxu819gK
         cl15Y8pN/cxsfGDdM+z3zwPzqY/1cxG539ZjSfHejCY6mX30zKtG4zdDumWOI7UJjVrS
         vFx3IOFIgkrnzA8GhbxRHVlHxp77F6K1VLByFMkue26qH53bVx6cO3Ug9J+TwsCkl+4k
         f9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552931; x=1788157731;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RJSinviL1rUCPbdWLEv3+LGdZL1Zd0kdSRn2umOLqM=;
        b=RwuiY/DOYafYkMZQ8XrbqynOTf3EK3CXjCT4yZxivt4TIBp0wmwyBJ2ORLSEMmhjn6
         L5ZT3nedu6bRel3+FciK8OeiyOs7fSLmWE6y2Z/28QuqVAyUmCCmvp4UvtZkmBqJB7rb
         ldHiRnE0ZBw6xn24GDiaEtT7lAVmTtIVxIs13AmJhowKZv+jymy2eBXf2PLXwmPG+s3S
         +eUDX2Y/Ah1e7d57RyF8EAtZuklcZ6Oi/yRr8jfZVlQ4gP3ozUvLLdBDpRz9KeYUFrpe
         60Czf7fpMS7SgNtzWCT1kka5ue2ZiO61W4TVf7nYo8zv1wbm+xhaMqYE1nzi9vbnD8wF
         RHeg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1qRwlsAKCgCOvIV6AMyhkITnkCPhudwnfwq/d925M3/YR3WI951rPzfWwd1/mN9yd29XFS5WOyL8ZmcbClDif@vger.kernel.org
X-Gm-Message-State: AFuF++n0NtV232a8pe2h/ip7qXvDDxlIteSwRwkALxV10JR0JDsRvgY6
	YEwyYzD+7Qhm5O8rHXP+40cpJ/8xfh1NtYalkSqgkycRuHHr1mh5rl1AJPckhLw6ePdwnYIG+u9
	DP1wQkbAY6Q==
X-Received: from dlbrc13.prod.google.com ([2002:a05:7022:ea8d:b0:141:48ce:1002])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b42:b0:37f:fd1f:d30f
 with SMTP id 98e67ed59e1d1-395c3a06ffcmr40283068a91.12.1787552930721; Sun, 23
 Aug 2026 23:28:50 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:28:41 -0700
In-Reply-To: <20260824062841.1529489-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824062841.1529489-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824062841.1529489-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf libdw: Optimize fallback logic for missing DWARF
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tanushree Shah <tshah@linux.ibm.com>, 
	Michael Liang <mliang@purestorage.com>, Alessio Podda <aleph.pi.gh@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When libdw encounters a DWARF definition it cannot accurately
un-inline or an address block natively missing structural line maps,
dwfl_module_getsrc() falls back immediately with 0. This causes perf's
addr2line_style loop to fall back to launching the cmd__addr2line()
sub-process wrapper. In environments generating massive numbers of
unmapped traces, this forces thousands of redundant `addr2line -e`
fork/execs in a polling loop.

This patch intercepts failure scenarios:
1. Returns -1 when dwfl_module_getsrc() returns NULL (meaning the DWARF
   is parsed but the line mapping is natively missing).
2. Evaluates `ret < 0` in addr2line() to dynamically bypass the subprocess
   fallback and return 0. This precisely acts as a failure condition,
   incrementing the dso->a2l_fails counter and accurately triggering the
   A2L_FAIL_LIMIT throttling without shelling out.
3. Incorporates exact error string checking for "no DWARF" to safely
   abort alternative fallbacks directly within both libdw resolving and
   the unwinder logic (unwind-libdw).

This preserves fallbacks if unwinder or DWARF parsing genuinely
aborts, but avoids falling back when mappings are absent.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/libdw.c        | 11 +++++++++--
 tools/perf/util/srcline.c      |  2 ++
 tools/perf/util/unwind-libdw.c | 15 ++++++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index f53caee980b0..7c681b03c654 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -186,8 +186,15 @@ int libdw__addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 	 * between the regular ELF addr2line addresses and those to use with
 	 * libdw.
 	 */
-	if (!dwfl_module_getdwarf(mod, &bias))
-		return 0;
+	if (!dwfl_module_getdwarf(mod, &bias)) {
+		const char *err = dwfl_errmsg(-1);
+
+		/*
+		 * Abort fallbacks specifically when DWARF is completely missing,
+		 * but allow alternative backends to try if parsing failed.
+		 */
+		return (err && strstr(err, "no DWARF")) ? -1 : 0;
+	}
 
 	/* Find source line information for the address. */
 	dwline = dwfl_module_getsrc(mod, addr + bias);
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 8e954f0c860a..8283a741c018 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -176,6 +176,8 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 		}
 		if (ret > 0)
 			return ret;
+		if (ret < 0)
+			return 0;
 	}
 
 	return 0;
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 63a5c2253174..69d4585c870c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -441,8 +441,17 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 	}
 
  out:
-	if (err)
-		pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
+	if (err) {
+		const char *msg = dwfl_errmsg(-1);
+
+		pr_debug("unwind: failed with '%s'\n", msg);
+		/*
+		 * Abort fallbacks specifically when unwinding information is completely
+		 * missing, but allow fallback unwinders to try if parsing simply failed.
+		 */
+		if (msg && strstr(msg, "no DWARF"))
+			err = -EINVAL;
+	}
 
 	for (i = 0; i < ui->idx; i++)
 		map_symbol__exit(&ui->entries[i].ms);
@@ -460,6 +469,6 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 	 *  < 0 : fatal error (e.g. -ENOMEM). Aborts unwinding entirely.
 	 */
 	if (err)
-		return (err == -ENOMEM) ? -ENOMEM : (entries > 0 ? 1 : 0);
+		return (err == -ENOMEM || err == -EINVAL) ? err : (entries > 0 ? 1 : 0);
 	return entries;
 }
-- 
2.55.0.766.g2966f0265a-goog

