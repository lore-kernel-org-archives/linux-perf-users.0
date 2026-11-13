Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590286;
	b=Bhhp9caMAMM5guz7dNWhwWPKLVxsWCcIrHNsYhlpKfG8Q63HMuzzJTdF5Y7cBdCNCiGV
	 uGx0sk+Chn+LMz9QRPhXYPw7NhIWfAcuMjUR1F5BwPV3Uy8hDwjT/gqFTCh4HVnpe1orc
	 L1FnaUovA1vCmL8djSbpSu4vSGVh6i8oIz786lApiYXwuEr8yZm3qZvo79r7CkuosBt5X
	 NKxq68dQIXtu78frMaRv4GBv3cvQdIuQzIUGRTdhTY7JgjQsvwbIU7jsVoeMOPkgnv0T0
	 NMewzOrWflkCCmcQ6Pac7ny7ReCoGR+krG+sxbf2wIxAQlkKSYJMF4F1rGSG9pESEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=D+50i/RwKyjC8lGzq/TDrxDr0x774kWBd4toZ69sxr4=;
	b=PDW5AvctaxloPUvaSaLESEZkhGbHydVcR8i60e9Uez4D90aLcw9Glvj+mtFeXCPVit+W
	 gePr/Ps/rOja2PxOR74b1hVsLvmJGVrDTmWksuLRv1cza2Y9n+ciyb9zvWvPfhgpwrj+2
	 NsRQVadaQEM14biQSjOHsxxvFXbsXL1vbpmzzoqoUNY0pxhxKxTsZ1gq6bUg8rnbH15Ck
	 h0KW2ScIw4jwiU5cUQC8PrxyxmGIhbjacpZ+Q7drKTYcmet9en9lfAzJSv715Vht8aZIT
	 7/gLI6OK5ZT/CUWPpvHk/QhdtGJyLhhnuYsu7MTLXg1MPQ1ET6ewl1JRnM0GPLKHwRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MmtTU4MG;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82C607A5D6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA82C607A5D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MmtTU4MG
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b25d977b91so980193c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590285; x=1795195085; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+50i/RwKyjC8lGzq/TDrxDr0x774kWBd4toZ69sxr4=;
        b=MmtTU4MGYIhTN07LHbNbimSW4N04Plfll3aDNlZx6Wc86BiX2338bLBx/s3pphDZ3N
         zQaKwFQY+sTqoacrEkdMord9pGWYpr34rqpYq9Zv5Murtjqq7kqMfTSnS7pYbwCPsJU5
         dT6Y9OjSo1ND63yEMSdkT9qXiJ4eOoHxFoDeasmRc06+/RDued5m34znQtLOO4Mqdsmc
         uGhUd056HYfc12bkfmBXk48R8HVbJ2bheTHVpXcs9pj7qTTAVP7smJpwOK2Hi+pcWLWD
         HAOj3aqV3TgvYWh9UsPQf2t34OYCzxCqc2pe4SepWdz1h8xBfI4e4uDsmNZiZYK/jePR
         H+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590285; x=1795195085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+50i/RwKyjC8lGzq/TDrxDr0x774kWBd4toZ69sxr4=;
        b=DSXtZLNCgz+8nvp8c4VKo33yVsDzyu789UZukD8h9hZY9mdTGMJvvj/5XhmdFqhD7y
         H71/kZ+6JCriIEOmJFpuin0uw2rxwebbgsBhbv5SlEuIrXd7KuvSHvA7MJu+QmXV0gIg
         +47Dnbvz5oFvq+Oseh9HzPzea9zihRRHwmkZoiyPmNBiXAJNIpeLGtzAAwu2era8DUTS
         rz11yKeUBUXGLSAIb1tNGvGVMx+Ow5thMVYWx2dxbcrm1Q4treBmRtgBPPvvbfop+KpC
         bHCb8JkIAaluxCfVE+abSHrI2s0pbXwRX+WJ167wjWeSDtlFPMFSHhsYnQ0PGwRotfK4
         Mxyw==
X-Forwarded-Encrypted: i=1; AL+hErHbwT3ZHrh6Qvjgdv6YuviSMzZNdt6HOTV2p6xhv6nWpzmTriiCiWqzND2YPwbnVLu+8unHuEXVE1cYi1uxJHDD@vger.kernel.org
X-Gm-Message-State: APuU4Z8T81oxQNucUN28pOC1YmDcsJeYjSjlNwd+inD8kdtCRhYT82Nf
	8Wu7xjrdmIhVdNv4azZpTI9kQyouxhUhF9MTCsCYmuv0zLsId1QEXkDQ5zGBkUgU9Z49xkr0U/K
	XP3us4QtMMg==
X-Received: from dlbts26.prod.google.com ([2002:a05:7022:b05a:b0:189:f88f:f17c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:418c:10b0:1a8:ff0b:a4e1
 with SMTP id a92af1059eb24-1b5030fc737mr3077760c88.18.1794590284542; Fri, 13
 Nov 2026 09:18:04 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:15 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-5-irogers@google.com>
Subject: [PATCH v4 04/23] perf map_browser: Fix browser index heap corruption
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
2.56.1.703.gf848ed807c-goog

