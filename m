Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348498;
	b=wv5OXLjQbJ/JOBFyShVwLjJBlMbW5dm+SGGl5xQy8dovvrej4IT/vQsESEg9sglj9Hp5
	 3P0tMcMmAf0DdDCSdKgvllQmbs8MkzB/odpvjnl9g97e0v3dfTgBIf2Skxa2Ldk83hqpN
	 QP518iU0jLjqCfPNLlWrWdPQYTfFXZ2kh39zCIoSicQIymRUNMuP3ILVFrXBNCmUEcN2p
	 XDn4b16UPucquyD4g+CsqMM+zIe3kwMRyhlsUITRQ9CWkl9kBQhrJXaIptEknZ30iN7zn
	 WPy0/Nw8OkZI7KEG43eEklAnoh0F6OaczSn/s1vznxThSoOd0vArYb86IoUe6ItXqPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SyMqV/30htEqQEVdMLPecLIiK5ufIIlJskPk4K/f/+M=;
	b=1FWl9CZ7nBCioU7KkfvNKDLCve55gsgH5qGt85AMujMOuLVLGAA+He1SNO3SAgTjLMq7
	 V+SRvBiqGmoWvGlEi2xKxyYWNhiapz7uYfk0UD6PaWPhKt0hlu6JyKC9QNzlRbeZE5Xyh
	 OH3WEG1rSJ+FCeQaXw+IOMbAjq2KOsB6IR4cWrvmHzUOGnkZNgZgxLZZ42APo62UcVyOs
	 Eg0DqbffaBp+olRm9/SuzbzbgZPrpBG0mu7r61fx/rsnK31tnVT5Efkf7FDEZhdQQPoWY
	 SQ7VzKk+9Wfd1V2qLPujAuiQ80jPjrmAWm/sP5ZU89dmxFSGctNsalQ4DkhikdmmbsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rin+dwtg;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339060A3826
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5339060A3826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rin+dwtg
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3ae17c536so2769178c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348497; x=1794953297; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyMqV/30htEqQEVdMLPecLIiK5ufIIlJskPk4K/f/+M=;
        b=Rin+dwtgbR4vxpd0sBse2gZv9GAayYVJ0LHxJ8HYSJ2Fm4ql50+1of7c2xxNgY1oRf
         ladkpW8RWOlghH6Y6/o+OElfgnHeX51A4RM8ugVWk//61yuBDGLvnW2mZNYmeWxtZ9DN
         Fw4Bp+NfffcvqY/BJoQxXBB+MbWT5mk34x3apyNq5byH0s1Db/sJ23vO+2QL5Stu9xzq
         Bp0RbTFP00BRaBJE00KKN/BZRj+VdXhjlaot6gJftsfEyYzWBAE7z9vbsS9zEOgvaniI
         2yLKYMKR2PQ+EuOOxKHGVFRl3hRE9F86x27AAHLL+s41x1hMH5M5Tq3FqcGBqgC85//a
         1yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348497; x=1794953297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SyMqV/30htEqQEVdMLPecLIiK5ufIIlJskPk4K/f/+M=;
        b=IvATy2flvTktXroqZmPJ5xAgqvKsgJvxFNF8nnO54FEI5e8sayo3vSnEwPltIpKoJn
         GTOTnieVvARNgsHgjU/tjcZjpedYGgJCRmqePZFdytCGE+KpupA/rYPKJvORImwVgPDL
         PiWS0YJuHGN0OI8kfjQUxoHRjOUiojBCr+xSJ+pmtVxK6mBtP6YQ3IFdVqNL+0AiABrp
         4c/uIpX9sSLChSN7x7zvX9UQ3FABHPptEgb471rhtRWi/Nygsufr3XZQO3apxMuIL6zW
         ZWY9jVaLVudqjD4z16yS/fWWWhv5MQ4gqLeoBiClM0yrhwHJ6oIBxKFkJd3kWyXWa1Kl
         +oDQ==
X-Forwarded-Encrypted: i=1; AL+hErFlwUy8UwKuEnN/zui3xVXj2UuK6ejB9zA3/JwBaXzXTGBQf9isNh577YGQudHi3cshnXOug2Y+DOg1Uwkn/Q8N@vger.kernel.org
X-Gm-Message-State: APuU4Z8cY4wRF5deI83bKfg3oTkP33o14rq6ryEl5pj7bSAqshOKVgky
	APyzypbkvr6iseC43ciecwb7KIhZmOopTZdxOXmHaoDJ+/3qMdIklDpTzzv712cdgqUJJn69JJM
	2DfMdnTgzKg==
X-Received: from dlah8.prod.google.com ([2002:a05:701b:2608:b0:1b3:befc:72bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:290:b0:1b3:af3a:e78f
 with SMTP id a92af1059eb24-1b3c036b086mr292172c88.27.1794348496994; Tue, 10
 Nov 2026 14:08:16 -0800 (PST)
Date: Tue, 10 Nov 2026 14:07:44 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-2-irogers@google.com>
Subject: [PATCH v3 01/20] perf map_browser: Fix browser index heap corruption
 by computing on demand
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Commit 259dce914e93 ("perf symbol: Remove symbol_name_rb_node") removed
the 24-byte symbol_name_rb_node reservation from symbol_conf.priv_size,
but left symbol__browser_index() in ui/browsers/map.c subtracting
sizeof(struct rb_node) + sizeof(u32) (28 bytes on 64-bit) ahead of
struct symbol. In 'perf report -v' and 'perf c2c report -v',
symbol_conf.priv_size is sizeof(struct annotation) + sizeof(u32)
(20 bytes on 64-bit), so opening the TUI map browser writes a u32 index
8 bytes before each symbol's calloc() buffer, corrupting heap metadata.

Remove symbol__browser_index() in ui/browsers/map.c and compute the TUI
map browser index on demand in map_browser__search() by walking the map
browser's symbol entries when the user searches with '/'.

While this changes finding a symbol's display row index in
map_browser__search() from O(1) to O(N) in the number of symbols in that
single map, map_browser__search() is only invoked interactively when a
user opens the TUI "Browse map details" view for a map, presses '/',
types a query, and hits ENTER. Even for a large DSO such as vmlinux
(~100k symbols), scanning the map's symbols once per interactive search
takes well under a millisecond.

Previously, '/' search in the TUI map browser was gated behind
'verbose > 0' (-v) in builtin-c2c.c, builtin-report.c, and
ui/browsers/map.c solely to avoid adding sizeof(u32) to
symbol_conf.priv_size for every struct symbol across all DSOs in normal
runs. With on-demand index computation there is no per-symbol memory
overhead, so remove the verbose > 0 restriction and allow '/' search in
the map browser unconditionally.

Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
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
index 075a575cdc5d..be7390156edd 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -39,12 +39,6 @@ static void map_browser__write(struct ui_browser *browser, void *nd, int row)
 		ui_browser__write_nstring(browser, sym->name, width);
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
 
 		if (maxaddr < pos->end)
 			maxaddr = pos->end;
-		if (verbose > 0) {
-			u32 *idx = symbol__browser_index(pos);
-			*idx = mb.b.nr_entries;
-		}
 		++mb.b.nr_entries;
 	}
 
-- 
2.56.0.542.g3ef89b7020-goog

