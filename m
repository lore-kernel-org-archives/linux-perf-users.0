Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F7125A9;
	Wed, 13 Nov 2024 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457285; cv=none; b=f3uflLzFrXEZ5Rj+kHd8KogpAcwiy2yTdqXVvyGFthbCOXFb3JlN6in2P73P/JArEjCS9dUWxHFos4oag50qVsefqA+04Dv3D+mCY/fIQ1VyyVP/zrorj/2r1pHmUJXSJTYHBK4/LSu7XuTdXRNbsng9EOA4I3Dfw3ngEkJ4j7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457285; c=relaxed/simple;
	bh=mH/IxzuTtQFxBdVO80XcOSZx+xNzchozOG+cyaXuE6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmHMT+aFNXZ6KLNEDfWnQPY4yqSI0m9EGXbLNPSbiQ5loNainET+sCHdmZ/yicVzBtmXXHTjYX0hUipqOlpZMfWEYoVuf7GBbqHyBhIm9fe5KdV1tCkafjmNsvgCFdQVDJpogt/yO9/3d1IvLGtK8IZ9xKox2uOoLzynzCCFrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPAd7qIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPAd7qIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A7DC4CECD;
	Wed, 13 Nov 2024 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731457285;
	bh=mH/IxzuTtQFxBdVO80XcOSZx+xNzchozOG+cyaXuE6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPAd7qIbOxkAyixj3DHzeWzu9loAuLa1bxMA/Z/UvCRmP95mAcYuAu+xnIXV3H0D9
	 Bb3ms6TeqwFNzG+QR7HcO3BBx1cq3vZC9laj9Hd/VvO0TFmOszAl9pwL3kx9J1lxnD
	 Ev3Nh0TyXNgRJRzQFzg0mmgOAAWPV5svzeVuVK9UXcsYdd8XAowN/T8c6R+zcEXvsi
	 +NFWZsjdWFiAsPsmqgHGlo9P46xyIyvnuZHDRilyyzMzwPac1M1ZG7hlcWk+xOc8p1
	 PjPDXICamQHa8Oj8fskhq4KRx/rxX2dq9XsVeCbDJ/Y90lwuaVV3T/alB0jhHA/Y6D
	 Icb8T4hUOBYkg==
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
Subject: [PATCH v3 1/2] perf-probe: Replace unacceptable characters when generating event name
Date: Wed, 13 Nov 2024 09:21:21 +0900
Message-ID:  <173145728160.2747044.18089011235495186810.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To:  <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>
References:  <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>
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
Note that this language checking depends on the debuginfo. So without the
debuginfo, perf probe will always replaces unacceptable characters with
'_'.

For example.

$ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530

$ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Update for the latest perf-tools.
 Changes in v2:
  - Check dwarf language instead of checking wildcards.
---
 tools/perf/util/probe-event.c  |   32 +++++++++++++++++++++++++-------
 tools/perf/util/probe-event.h  |    3 ++-
 tools/perf/util/probe-finder.c |   15 +++++++++++++++
 tools/perf/util/probe-finder.h |    5 +++++
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 1d5184697871..a5e42055a2f4 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2774,7 +2774,7 @@ int show_perf_probe_events(struct strfilter *filter)
 
 static int get_new_event_name(char *buf, size_t len, const char *base,
 			      struct strlist *namelist, bool ret_event,
-			      bool allow_suffix)
+			      bool allow_suffix, bool not_C_symname)
 {
 	int i, ret;
 	char *p, *nbase;
@@ -2785,10 +2785,24 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	if (!nbase)
 		return -ENOMEM;
 
-	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
-	p = strpbrk(nbase, ".@");
-	if (p && p != nbase)
-		*p = '\0';
+	if (not_C_symname) {
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
+	} else {
+		/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
+		p = strpbrk(nbase, ".@");
+		if (p && p != nbase)
+			*p = '\0';
+	}
 
 	/* Try no suffix number */
 	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
@@ -2883,6 +2897,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       bool allow_suffix)
 {
 	const char *event, *group;
+	bool not_C_symname = true;
 	char buf[MAX_EVENT_NAME_LEN];
 	int ret;
 
@@ -2897,8 +2912,10 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 			(strncmp(pev->point.function, "0x", 2) != 0) &&
 			!strisglob(pev->point.function))
 			event = pev->point.function;
-		else
+		else {
 			event = tev->point.realname;
+			not_C_symname = !is_known_C_lang(tev->lang);
+		}
 	}
 	if (pev->group && !pev->sdt)
 		group = pev->group;
@@ -2915,7 +2932,8 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 
 	/* Get an unused new event name */
 	ret = get_new_event_name(buf, sizeof(buf), event, namelist,
-				 tev->point.retprobe, allow_suffix);
+				 tev->point.retprobe, allow_suffix,
+				 not_C_symname);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 4850e52f274e..ab9d07034170 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -57,7 +57,8 @@ struct probe_trace_event {
 	char				*event;	/* Event name */
 	char				*group;	/* Group name */
 	struct probe_trace_point	point;	/* Trace point */
-	int				nargs;	/* Number of args */
+	int					nargs;	/* Number of args */
+	int					lang;	/* Dwarf language code */
 	bool				uprobes;	/* uprobes only */
 	struct probe_trace_arg		*args;	/* Arguments */
 };
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 7f2ee0cb43ca..863147c4b7d6 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -35,6 +35,19 @@
 /* Kprobe tracer basic type is up to u64 */
 #define MAX_BASIC_TYPE_BITS	64
 
+bool is_known_C_lang(int lang)
+{
+	switch (lang) {
+	case DW_LANG_C89:
+	case DW_LANG_C:
+	case DW_LANG_C99:
+	case DW_LANG_C11:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Probe finder related functions
  */
@@ -1269,6 +1282,8 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 		ret = -ENOMEM;
 		goto end;
 	}
+	tev->lang = dwarf_srclang(dwarf_diecu(sc_die, &pf->cu_die,
+										  NULL, NULL));
 
 	pr_debug("Probe point found: %s+%lu\n", tev->point.symbol,
 		 tev->point.offset);
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index be7b46ea2460..dcf6cc1e1cbe 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -26,6 +26,9 @@ static inline int is_c_varname(const char *name)
 #include "dwarf-aux.h"
 #include "debuginfo.h"
 
+/* Check the language code is known C */
+bool is_known_C_lang(int lang);
+
 /* Find probe_trace_events specified by perf_probe_event from debuginfo */
 int debuginfo__find_trace_events(struct debuginfo *dbg,
 				 struct perf_probe_event *pev,
@@ -103,6 +106,8 @@ struct line_finder {
 	int			found;
 };
 
+#else
+#define is_known_C_lang(lang) (false)
 #endif /* HAVE_LIBDW_SUPPORT */
 
 #endif /*_PROBE_FINDER_H */

