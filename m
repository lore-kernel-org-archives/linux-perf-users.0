Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606608;
	b=IytCcdHDzyKMDart30O56y1BNLY2+nJbBjPbIRrP5vd01KXJwpcoCDxYBMyjHc6S+Yfs
	 fa1jxVIOVA7BIKUzzPS2R02etd7gqQAnNoC3gN1JZdU89iVmHHT/Jy6p+403cgj4V2zfV
	 Ykp2MjU4K+E/QAdQ6ukBGuCMI9i46ugoB2Iz8CyfeQWAUHtfWOoV+Ot9TLtMYGvolpo7J
	 BHc55IwEUm7XRi7rI2ma/7pGa1edhWUv9XOQlFcSiD9G20qGY9li4hI/btBOcPxhjGwLf
	 a5Nzd8ZpCblIN2kQ9BZejNxGJzq8vugUEWMQAQxPKu9rt+6ydZZ6dStsV6KljU7mDaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=M7M6ChNDEA0jcvgLZz8uppZnHneIa4DE6GM95tvdqNA=;
	b=YYcXTupIlsBDlVaYSn6ni4hqz3l4z7+EOp/P5R9i2iBZx18agYylRdjoQEMQFc/GjrMb
	 Mi2QwQS04HrkH+TYBejnturkpdDCWAgC0vusVkreYCPwuSuerMITIDmTNSdKk4rY4WNhE
	 4SbLgADwCo05qktnNt+WmqZPq9P6WwByF8GyoF5tugW0tYuK0PFJUxSu691bnW3Feo63+
	 84vPh94c030Yfawjby9eghqNGsMBPgaymspu90s1S7dwfGwhbCozpT8snW+yVObK+Xy9K
	 5DEhjxzRZgcusYWaBQ8hs8B3KABIi/hrKsx1TYKE4F42Y8gHzEsyvGUqxuvuT18cVLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XrbI0yZR;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37760A2631
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A37760A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XrbI0yZR
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so235822c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606607; x=1795211407; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7M6ChNDEA0jcvgLZz8uppZnHneIa4DE6GM95tvdqNA=;
        b=XrbI0yZRF4kyWXS5D4kXsAi+vemOdgh0xc8/jjvRnNOvohgfgjFRiDNU9N7JoytJVt
         imXLL5ncX9vPh2OCfo0j1QJG2hoIZJzDhrHusMfX1R64TjoM4IP8/JPa+vhLFHQuwl4r
         WDjvhdBMSx49mrTLpVIN0+h9qyG2FoP9yLGo2XNJD3cdYaxeMkAffvHLk0U4z33/6zzD
         0q8vJlipFXdtpAUImBwYz3GlbxFBrtbf7aDP1fbHM1skx9YY9OPP3nSnoENlA4YQTssz
         GEHpniWQZMVSYtg/+Q8yNXKSRorMjn0hbaEOFqo11kzGhZsXDraAGBUtbecKJ98n6rGl
         r2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606607; x=1795211407;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7M6ChNDEA0jcvgLZz8uppZnHneIa4DE6GM95tvdqNA=;
        b=kGrFqhL8biEmtZFMJaOVKGJUiktDyo7QGslEB4b0EB3cZsgeSECPfium0w7qh5zQ2l
         B4Uo9O65W/ONS08Vxr4OQmolMUmWGJaKJJuBSbnh+Q4mucAZnMqQ1gXoVZWX3qx+pvmp
         X4DID8UWxkFgaeGBfUMmMwt72teivql3oS4Qe35vh81IHy/6ZxcnhVtX81BWIPLuQBoD
         6Qy2XU8L3pGYIM1gFmhB2YdCc5l1qetxxmv1uQvSdad0LcXfDHxtwDQtP6CxokOB9hzx
         taB+BraYjUx0YAGHDOoatsg4cN0Fl2i6taQHqiM38+B+CNrH0EO7ntrpr8Hs6pBQU2la
         xBZg==
X-Forwarded-Encrypted: i=1; AL+hErE1id6RKq9J19fPUBUrgJnqNVpAecc2Jldbfr33j/i10vh/CuLOcZitaEdU/jrSlzyS1VgSUEMpi+jtCx4f1/Lx@vger.kernel.org
X-Gm-Message-State: APuU4Z+BBW1/b+e8CB2dmDrAwnMA0dSpgrml2wsrqkYZHu8EANYMNXzw
	qUzH32sEwt31x9H8SSHKlm+GkyuNZubsFjumkKpDZOf8kiUWSzQmVowg9BeYCvpqG56nXb9I5UB
	uxiy9FMQjHA==
X-Received: from dlai16.prod.google.com ([2002:a05:701b:2710:b0:1a3:c305:2584])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4248:10b0:1b3:b455:93db
 with SMTP id a92af1059eb24-1b503131b06mr3912773c88.24.1794606607179; Fri, 13
 Nov 2026 13:50:07 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:45 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-22-irogers@google.com>
Subject: [PATCH v1 21/26] perf annotate: Use generic hashmap for browser type_hash
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert annotate_browser::type_hash and annotation_print_data::type_hash
in util/annotate.{c,h} and ui/browsers/annotate.c to
DECLARE_HASHMAP(type_hash_map, long, struct type_hash_entry *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c | 18 +++++++++---------
 tools/perf/util/annotate.c        |  5 -----
 tools/perf/util/annotate.h        |  8 +++++++-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8b0c933caf2e..7899c3e2b07a 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -39,7 +39,7 @@ struct annotate_browser {
 	struct hist_entry	   *he;
 	struct debuginfo	   *dbg;
 	struct evsel		   *evsel;
-	struct hashmap		   *type_hash;
+	struct type_hash_map	   *type_hash;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -1131,8 +1131,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (browser->dbg == NULL)
 				browser->dbg = dso__debuginfo(map__dso(ms->map));
 			if (browser->type_hash == NULL) {
-				browser->type_hash = hashmap__new(type_hash, type_equal,
-								  /*ctx=*/NULL);
+				browser->type_hash = type_hash_map__new(type_hash, type_equal,
+									/*ctx=*/NULL);
 			}
 			annotate_browser__show(browser, title, help);
 			annotate_browser__debuginfo_warning(browser);
@@ -1233,7 +1233,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 
 	if (annotate_opts.code_with_type) {
 		browser.dbg = dso__debuginfo(dso);
-		browser.type_hash = hashmap__new(type_hash, type_equal, /*ctx=*/NULL);
+		browser.type_hash = type_hash_map__new(type_hash, type_equal, /*ctx=*/NULL);
 	}
 
 	browser.b.width = notes->src->widths.max_line_len +
@@ -1265,12 +1265,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	debuginfo__delete(browser.dbg);
 
 	if (browser.type_hash) {
-		struct hashmap_entry *cur;
-		size_t bkt;
+		long key;
+		struct type_hash_entry *val;
 
-		hashmap__for_each_entry(browser.type_hash, cur, bkt)
-			zfree(&cur->pvalue);
-		hashmap__free(browser.type_hash);
+		hashmap__for_each(browser.type_hash, key, val)
+			free(val);
+		type_hash_map__free(browser.type_hash);
 	}
 
 	if (not_annotated && !notes->src->tried_source)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c6325040452f..ee47dcdc1f18 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2075,11 +2075,6 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
 	return -ENOMEM;
 }
 
-struct type_hash_entry {
-	struct annotated_data_type *type;
-	int offset;
-};
-
 static int disasm_line__snprint_type_info(struct disasm_line *dl,
 					  char *buf, int len,
 					  struct annotation_print_data *apd)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 495c8602864c..2757fb07d4ec 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -202,13 +202,19 @@ struct annotation_write_ops {
 	void (*write_graph)(void *obj, int graph);
 };
 
+struct type_hash_entry {
+	struct annotated_data_type *type;
+	int offset;
+};
+DECLARE_HASHMAP(type_hash_map, long, struct type_hash_entry *);
+
 struct annotation_print_data {
 	struct hist_entry *he;
 	struct evsel *evsel;
 	const struct arch *arch;
 	struct debuginfo *dbg;
 	/* save data type info keyed by al->offset */
-	struct hashmap *type_hash;
+	struct type_hash_map *type_hash;
 	/* It'll be set in hist_entry__annotate_printf() */
 	int addr_fmt_width;
 };
-- 
2.56.1.703.gf848ed807c-goog

