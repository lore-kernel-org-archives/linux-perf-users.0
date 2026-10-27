Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142929;
	b=UqlE8tlQdRxxSPhKNYoZfzqOnufz2ZpHQN42rPls7qP9OGu3g6EeMxnF5gGKgH5tYXmO
	 fmqF7qYEXkRM/h1bSnPfPXPJhhy2zxal5BmND3Qzw3QkglfwSrKCkiRHbNEqsZ8Xs6fdc
	 NJsv3kvVHli75VKhvttJHUEGh/2QMcor6qxdYVsTXVJHZtGjGsXDszKDAYM9w0m4HbO6Z
	 eJJrEQcxhxMK0BQe2/If1X9oGr/nKzD57a6PrrKwsKvIW58GVS43rPMj8vUu5akmak+Im
	 Pg8aalO0DKPdqfe1ImPMzgETEgzorcfLNfwL9+yZzyXH5NYjdexV0UNu3WGexGZG6oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=1BbjDV/G8k9/BbDXqFFKYGtAlZFq/V/hDkVkSx9koiQ=;
	b=BYWNXUEjEoIFMxmvOO7TtGhycykPCoP+bb/QzC02BFNR/1flFqrAHn1BGPVGPsycS5SS
	 cWOGaagRac9jMu3VLrYPejS9Q+NuFWWDOaNzMYYh0BJcSzYUB7glo7IMGMJ+nnfg+eOP5
	 vMch7gS+rxhDizz/am8dpd3etwOjGbUwpj4V0ycWZG4uWKw6Egih6p/wwsqXDbrX8xz8M
	 yPhrWNiAN0yIygj8DZHYNEKL/blus13nx67dtMhUzKi2OZU3FfklWl76K++dDj/2CuE4d
	 QoqInRhKxiPDZDLtS99C1Wj9Ymj5hUVoqMU/veR1sBhrvSC2vZwXrhe5d+wJGZ8hZ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lC7ht2zi;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C902606A329
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 23:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C902606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lC7ht2zi
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35cbea41088so486823eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793142929; x=1793747729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BbjDV/G8k9/BbDXqFFKYGtAlZFq/V/hDkVkSx9koiQ=;
        b=lC7ht2zitFbWDWJjCgRSeMDOVHtA5KBklisnbl1W7fZx9PQouXKLOoQGEWY+D8ZyPv
         huDs92vqUbZz2ulPpRpYs2k0mOaeLK6ZUG2Kcw0w/fNUMyJBSj7SfKdGoTU343iI81Vn
         m0MBA41V6VcFr1HHJuCLmQGGZeGuMduiLxuj600igntTNttoclDcaECaAOsdWqUBnUfI
         BB4DPH+J4eA4kJPq+oPdwQJgIBT+XFAHKtzYZt65T/PHMpWaNsKbWYPpucHkbLfleUMi
         45h58F3CaTM5hy0VmKvTINvft9TD4QexK5576UWpFfA9poPPoyl0ggpMrSX4WmUen5GT
         czTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142929; x=1793747729;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BbjDV/G8k9/BbDXqFFKYGtAlZFq/V/hDkVkSx9koiQ=;
        b=0GJKOMVivgYvyBh7pjQKQlYhTGT0NBzomobMryTRREfp+6Dy0uRt+puiAfTkYcY/Kt
         1OSXPa1CpHpCa104a8pd+uTjGnI0ZkjHL4o/ilPJZsjoQ4duZ9M+PW3RBQWagM8JboI7
         0E8+WxdTHXS7QpG8aYOonZUunx6Kd9o/RbgElLzh2bPsfP7/d/ofnjZi1EC5vU65npoa
         hxBXZN2WmSwCWnMqks5K6At5/sMF6izIJ75ik7ucNxKIuAjvuxGLNoKekO3BDAl5um0r
         BSmY8eOgtDW+JXRRUyPtyohTKQ29073Ad9KPLGzM3jdTUtPRyu29qCWio8Wz+q3xWlpL
         JjmA==
X-Forwarded-Encrypted: i=1; AKwUvBwJs5fllz3c8wqbE+v7V0CTQWSCa7ouMTFaQs1X25Ht/Flii3o+fozP7epil2ZxgjXWAatJwnJfskKg8J62kZ06@vger.kernel.org
X-Gm-Message-State: AFq9FYJYaFFRMGVC9AYMX6PwFlw3Ggx5SRdNhBeeLXh7XBxsUmx2iBoI
	BG+tomEVRAeGbdXV1iZq3ufPSH1P0ay31p/QjOZn01UQyeoqp4lOZaivPQiqyp2XUfjTW58/GqF
	9XNZs88/XxQ==
X-Received: from dycoi9.prod.google.com ([2002:a05:7301:da89:b0:36a:1653:611c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a230:b0:369:a113:7578
 with SMTP id 5a478bee46e88-36a1ff4734emr1028923eec.1.1793142928189; Tue, 27
 Oct 2026 16:15:28 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:14:58 -0700
In-Reply-To: <20261027231513.816148-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027231513.816148-5-irogers@google.com>
Subject: [PATCH v2 04/18] perf map_browser: Compute symbol browser index on demand
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, haghdoost@uber.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

To wrap struct symbol in DECLARE_RC_STRUCT(symbol) and reduce per-symbol
memory overhead, negative-offset allocations ahead of struct symbol via
symbol_conf.priv_size and symbol__priv() need to be eliminated.

Remove symbol__browser_index() in ui/browsers/map.c and compute the TUI
map browser index on demand in map_browser__search() by walking the map
browser's symbol entries when the user searches with '/'.

While this changes finding a symbol's display row index in
map_browser__search() from O(1) to O(N) in the number of symbols in that
single map, map_browser__search() is only invoked interactively when a
user opens the TUI "Browse map details" view for a map, presses '/',
types a query, and hits ENTER. Even for a large DSO such as vmlinux
(~100k symbols), scanning the map's symbols once per interactive search
takes well under a millisecond (and becomes a flat pointer array scan
once symbols are stored in struct symbols).

Previously, '/' search in the TUI map browser was gated behind
'verbose > 0' (-v) in builtin-c2c.c, builtin-report.c, and
ui/browsers/map.c solely to avoid adding sizeof(u32) to
symbol_conf.priv_size for every struct symbol across all DSOs in normal
runs. With on-demand index computation there is no per-symbol memory
overhead, so remove the verbose > 0 restriction and allow '/' search in
the map browser unconditionally.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c     | 14 --------------
 tools/perf/builtin-report.c  | 14 --------------
 tools/perf/ui/browsers/map.c | 37 ++++++++++++++++++------------------
 3 files changed, 18 insertions(+), 47 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f51fa23f3bf1..719f47dac2dc 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3412,20 +3412,6 @@ static int perf_c2c__report(int argc, const char **argv)
 
 		if (ret < 0)
 			goto out_mem2node;
-		/*
-		 * For searching by name on the "Browse map details".
-		 * providing it only in verbose mode not to bloat too
-		 * much struct symbol.
-		 */
-		if (verbose > 0) {
-			/*
-			 * XXX: Need to provide a less kludgy way to ask for
-			 * more space per symbol, the u32 is for the index on
-			 * the ui browser.
-			 * See symbol__browser_index.
-			 */
-			symbol_conf.priv_size += sizeof(u32);
-		}
 		annotation_config__init();
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 29085fdc91e5..6672a4d16529 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1885,20 +1885,6 @@ int cmd_report(int argc, const char **argv)
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
-		/*
- 		 * For searching by name on the "Browse map details".
- 		 * providing it only in verbose mode not to bloat too
- 		 * much struct symbol.
- 		 */
-		if (verbose > 0) {
-			/*
-			 * XXX: Need to provide a less kludgy way to ask for
-			 * more space per symbol, the u32 is for the index on
-			 * the ui browser.
-			 * See symbol__browser_index.
-			 */
-			symbol_conf.priv_size += sizeof(u32);
-		}
 		annotation_config__init();
 	}
 
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 47f2743cae26..2f070a53b5cb 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -39,12 +39,6 @@ static void map_browser__write(struct ui_browser *browser, void *nd, int row)
 		ui_browser__write_nstring(browser, symbol__name(sym), width);
 }
 
-/* FIXME uber-kludgy, see comment on cmd_report... */
-static u32 *symbol__browser_index(struct symbol *browser)
-{
-	return ((void *)browser) - sizeof(struct rb_node) - sizeof(u32);
-}
-
 static int map_browser__search(struct map_browser *browser)
 {
 	char target[512];
@@ -62,10 +56,21 @@ static int map_browser__search(struct map_browser *browser)
 		sym = map__find_symbol_by_name(browser->map, target);
 
 	if (sym != NULL) {
-		u32 *idx = symbol__browser_index(sym);
-
-		browser->b.top = &sym->rb_node;
-		browser->b.index = browser->b.top_idx = *idx;
+		struct rb_node *nd;
+		u32 idx = 0;
+
+		/*
+		 * Walk the map browser's symbol entries to find the matching
+		 * symbol node and its display row index, then position the
+		 * browser cursor at that entry.
+		 */
+		for (nd = rb_first(browser->b.entries); nd; nd = rb_next(nd), ++idx) {
+			if (&sym->rb_node == nd) {
+				browser->b.top = nd;
+				browser->b.index = browser->b.top_idx = idx;
+				break;
+			}
+		}
 	} else
 		ui_helpline__fpush("%s not found!", target);
 
@@ -77,8 +82,7 @@ static int map_browser__run(struct map_browser *browser)
 	int key;
 
 	if (ui_browser__show(&browser->b, dso__long_name(map__dso(browser->map)),
-			     "Press ESC to exit, %s / to search",
-			     verbose > 0 ? "" : "restart with -v to use") < 0)
+			     "Press ESC to exit, / to search") < 0)
 		return -1;
 
 	while (1) {
@@ -86,9 +90,8 @@ static int map_browser__run(struct map_browser *browser)
 
 		switch (key) {
 		case '/':
-			if (verbose > 0)
-				map_browser__search(browser);
-			/* fall thru */
+			map_browser__search(browser);
+			continue;
 		default:
 			ui_browser__warn_unhandled_hotkey(&browser->b, key, 0, NULL);
 			continue;
@@ -124,10 +127,6 @@ int map__browse(struct map *map)
 
 		if (maxaddr < symbol__end(pos))
 			maxaddr = symbol__end(pos);
-		if (verbose > 0) {
-			u32 *idx = symbol__browser_index(pos);
-			*idx = mb.b.nr_entries;
-		}
 		++mb.b.nr_entries;
 	}
 
-- 
2.56.0.313.g2479322e68-goog

