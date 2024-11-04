Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073461C0DF3;
	Mon,  4 Nov 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737069; cv=none; b=tBoJSjs/WNff5UGKk0Qe1esMNYGQJTAzGMJzcdg6zCIX+SCDksILk9zrvLL6ecO6hejpuwYuyLG9hutRQGHKwFC9SwnTBLcqHiA0Aladejcs4XFoOr1jokyjDpPUhD5hHlY6lA5b4vpKG5JZDzl+uVT4B2/UF+lB4TqZYL+ySys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737069; c=relaxed/simple;
	bh=s0rFQsc8Fk5VmusC9Ynn6fQiZSmTBCPyClyZxGlMnzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tswkbrrHlznd0rTpVzU6v25fWNDOKp2i862BUuBX/vKLtMJ8yk/GNByOhLqWWlD54F4alYsrnl2pxrlbBIc+BCUp7CTHVbw5jgPYY0YPjh85k4+cQVgPTr3B0BbMUVrA2ZFB8SyEDBv3dsSndGqDXETtS77ofzWFOWfmU8RrVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEynCGUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEynCGUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06D1C4CED2;
	Mon,  4 Nov 2024 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737068;
	bh=s0rFQsc8Fk5VmusC9Ynn6fQiZSmTBCPyClyZxGlMnzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEynCGUnA4Y/vTns4NqC81E4gprYs/74nrDaG1zbUwn4nKGqhWFrpl35jg3IAs3pR
	 nLoVg0vSqWwo7utrDHrkwiTfkH1rwhvcVhTvk9+hD2QAxPxVKobpqUxA1PGRp5LZZL
	 oHzaNeIFy+4AeZfRLFYruSORzQhLWjuw23lsjBQSk5UrlB7C/FjsWK0Gmmna1qNQQC
	 GhLG8uQafukfasJ5nY+2mO0polTH4olOliT3Yg1apI2BoBOdLENcCcXzXLKLNZ26lR
	 w9qa7aC1NKoSIFzRANnHQIPsPpa4jsgbonChQiYJEbpVpKseH8brPkqLlJkdxliPzr
	 g0A3jv3ZgzVsg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf-probe: Replace unacceptable characters when generating event name
Date: Tue,  5 Nov 2024 01:17:44 +0900
Message-ID:  <173073706473.2098439.14379969075482451249.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To:  <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
References:  <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Replace unacceptable characters with '_' when generating event name from
the probing function name. This is not for C program. For the C program,
it will continue to remove suffixes.

For example.

$ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530

$ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |   37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index bcba8273204d..27698b9a8c95 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2729,7 +2729,7 @@ int show_perf_probe_events(struct strfilter *filter)
 
 static int get_new_event_name(char *buf, size_t len, const char *base,
 			      struct strlist *namelist, bool ret_event,
-			      bool allow_suffix)
+			      bool allow_suffix, bool is_C_symname)
 {
 	int i, ret;
 	char *p, *nbase;
@@ -2740,10 +2740,24 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	if (!nbase)
 		return -ENOMEM;
 
-	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
-	p = strpbrk(nbase, ".@");
-	if (p && p != nbase)
-		*p = '\0';
+	if (is_C_symname) {
+		/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
+		p = strpbrk(nbase, ".@");
+		if (p && p != nbase)
+			*p = '\0';
+	} else {
+		/* Replace non-alnum with '_' */
+		char *s, *d;
+
+		s = d = nbase;
+		do {
+			if (*s && !isalnum(*s)) {
+				if (d != nbase && *(d - 1) != '_')
+					*d++ = '_';
+			} else
+				*d++ = *s;
+		} while (*s++);
+	}
 
 	/* Try no suffix number */
 	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
@@ -2832,6 +2846,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       bool allow_suffix)
 {
 	const char *event, *group;
+	bool is_C_symname = false;
 	char buf[64];
 	int ret;
 
@@ -2846,8 +2861,16 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 			(strncmp(pev->point.function, "0x", 2) != 0) &&
 			!strisglob(pev->point.function))
 			event = pev->point.function;
-		else
+		else {
 			event = tev->point.realname;
+			/*
+			 * `realname` comes from real symbol, which can have a suffix.
+			 * However, if we see some glab-like wildcard in the symbol, it
+			 * might not be a C program.
+			 */
+			if (!strisglob(event))
+				is_C_symname = true;
+		}
 	}
 	if (pev->group && !pev->sdt)
 		group = pev->group;
@@ -2858,7 +2881,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 
 	/* Get an unused new event name */
 	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
-				 tev->point.retprobe, allow_suffix);
+				 tev->point.retprobe, allow_suffix, is_C_symname);
 	if (ret < 0)
 		return ret;
 

