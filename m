Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B252F28EA
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788703546; cv=none; b=ecl9AsMgPPZ6GfFhCPH5MMnFigLIDTjLGgMEYvdodTdmacCYGEGisqeevUibjHUDgiz2W+ySLho7RXlxk/mjfm5A2LqC/i2ifkRNCBTYScxFhULNWN5ZW9c7Eco4T1RXwxS924SCm0qnMMjVeRQ+5vBbnm57W6JjZbPt5HLCu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788703546; c=relaxed/simple;
	bh=AZLxDdgc4L+BUXQ56flddwm3zsAXeYF2x9ArO4UxeA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEwRsN1tvOG8c5JVPQZrxlr5eJ1tqBnDaF9h6zu8hZ3MUrcCic/EFpX4MIxxyMuUBx6Qcs7Dl2dOc8H4Hb6f2rxBctSDsVdGPsVFNH4/kO8Z0E0aD9ZcMDNy+hXc0pz1a2e3Q6Wo4CeuGYpsuKfMw5bWCrH0QfUzcRruHDjiiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3fIIsoY; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3fIIsoY"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c7127a73dso3338623d50.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788703544; x=1789308344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nI8mvodCx0EJH/4LpAhoZZh26bAX6GRc0T8Tfw8y37g=;
        b=m3fIIsoYb7GmfjzKB3wpsbLgP9bWRqRVk6axOQYhIsHJKgef4MFxVUuDjIHAAxsPPh
         hg39ViHpIzo1177EhNtlqzhJ+UBBY/9+er+QgtNPxlmwkggRCta2RENyZyyx4ZI/unYb
         GaIQRPKQIXhIQDJjc1ZwXkkSUjnXS6vtWGxR/9fO8TGy+tLNHxmlyrrsC4izlfvuBRs6
         FXzykPlNIR+3tXqrHvK7PttzrVaXKNe1j9V0Zvu0g4jlyKUOyjv7kjMTC2Se7sRhhKIc
         18RSVJ3R1neWeQUj2sHsPDRfl9NTif6cSkZ/6giuh4m+Y9u4z5/JUHCUDrA25jR3fCoO
         OVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788703544; x=1789308344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI8mvodCx0EJH/4LpAhoZZh26bAX6GRc0T8Tfw8y37g=;
        b=Rdi54ocW7P8Y3jp22T8UlePuxha0T09ZuPbdfCISkDjW7SHycamytbMvEiB9MHTTqX
         LMSKU/w7yQWMH7kSgYHqkeOJ5PDVkE/JfTaL7mU4/cb8psuzzFlGwS/ZObn5lNG19mVy
         PMWRMOoj+aeXIoirh89/ytiPTGcO+IpwzauX7dtrs9QSrzcWu2cQTQB0anCIWDaQaXyD
         yT3TETRSDLj4KHB0GT+sI1xl+b4izVjfFMRsWoiG32lGtPrbLPnpNoMQK0vbBihKBH4U
         9in99jR5HFJyy7C1tuIv1x+rs1imzpeZTu7m5C9TCa1I2JJG9hp2ZnGjGgemOZO2czk5
         zjSw==
X-Forwarded-Encrypted: i=1; AKwUvByX3+CPmemCBnXASO4dEZ/FqG7Tv8pH7muoCF96XUd03/TXHpbfWgXU+wia0WzON3yyJY+79onmFis2q0JtzOo5@vger.kernel.org
X-Gm-Message-State: AFuF++khPnPmeEm6b7xa68LoA3dR7PY4AggTE7/Dz9wi1X6tTrUCi2x8
	Ip1PfRM/6LFTkZb13H1FXjoDCOfYejWzBB3Qo0n9OEdVb5v5mpXAbwYy
X-Gm-Gg: AYBFou0KF5qatzttC4LH3KbgimHsF0y/0GhWEplBjiJLBw3YzQoGCuZe1YK+9+NtHhP
	QaP4G4SN5fShFPAJOBsgGPQHaGMZ5NmfVhxTI4gBqDaklQZ9Lv+wmNukVgmiP1K5m5I9LUtzbzr
	RFMqfCY02Y6ECikJXULk/9/L3gO0y1DDQp0qBa/Lpyvt3H0nao5W59ernVwjBObEkGRmlyqi5sW
	dcAZMlhvsC+yDqjsoZRO4v/qjkDokGgpAcWxly1D2iBh3Ht+AHRp9CkMJQS5uOe0P8cOxVgpBUw
	qzGgA2PZV8r7fmAbzjqGq8xPZLZ4BHEi7Y9ejsqiF3Ghd6Hwb0u8MtpV56gGjf7z+rzZQm6Y3sI
	fsnUxGnRTOTBnItQHxhoIGo3+zvjxNl8fgIBPKyjPlC9BLG1w75nYkrnNOWibhuGH5hcRygQJna
	uiuREiQOkBFcWxrkyCFW5kEE1om3rFt27E4TV8eB9sAIGOhzqHfYPWvjdthM87+nZTRABV1rY=
X-Received: by 2002:a05:690c:60c4:b0:80d:c9d9:e1a9 with SMTP id 00721157ae682-87127656943mr77152177b3.27.1788703544057;
        Sun, 06 Sep 2026 07:05:44 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714c1e1eacsm55861357b3.49.2026.09.06.07.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:05:41 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 10:05:28 -0400
Subject: [PATCH 2/2] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v1-2-7564bf8523a9@gmail.com>
References: <20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4104; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=AZLxDdgc4L+BUXQ56flddwm3zsAXeYF2x9ArO4UxeA4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmFqvbb9mes4GjJHDr/ic27gn/ZDyLpq/KU0/bsfDYg
 rITdv05HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNljcjw8KwaZI94U
 E5Rjv4GX4fMWT1yBa8fMOA8a3RihiLI0rftBkZHs6+vDr+qe4St0a+DVKzVRxL5jlGLbqxcPee+
 g4hDYb9rAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report --gtk dlopen()s libperf-gtk.so and expects it to resolve
symbols back against the running perf binary (callchain_param,
symbol_conf, evsel__name, and friends all live in perf itself, not in
the plugin). Two things stood in the way of that after the GTK 2 to
GTK 4 port:

perf never passed -rdynamic, so none of its own symbols were in its
dynamic symbol table for a dlopen()ed plugin to find at all. Add
-rdynamic to LDFLAGS when GTK4 support is enabled.

annotated_source__hist_entry() was a static inline in annotate.h, so
ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
hashmap_find(), directly into libperf-gtk.so as an undefined symbol.
The only hashmap_find perf links against in the common case is
libbpf's internal one (tools/lib/bpf/hashmap.c), which libbpf
compiles with -fvisibility=hidden; a hidden symbol can never be
exported to a dlopen()ed plugin no matter what LDFLAGS perf itself
gets. Move annotated_source__hist_entry() out of the header and into
annotate.c, as an ordinary exported function, so the plugin depends
on it the same way it already depends on evsel__group_desc() and
friends, instead of reaching for hashmap_find directly.

With both fixes, a default 'make GTK4=1' build (libbpf statically
linked, as usual) can dlopen() libperf-gtk.so and open the report
browser without needing NO_LIBBPF=1 or manual LDFLAGS. Verified with
perf report --gtk against a real perf.data on an actual GTK4 desktop
session.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Claude-Session: https://claude.ai/code/session_019moPUkPJjtTUWR8CBm1QdW
---
 tools/perf/Makefile.config |  5 +++++
 tools/perf/util/annotate.c | 11 +++++++++++
 tools/perf/util/annotate.h | 12 ++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3ac1826a0cbe..ef7419a5b013 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -789,6 +789,11 @@ ifdef GTK4
     GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk4 2>/dev/null)
     GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk4 2>/dev/null)
     EXTLIBS += -ldl
+    # libperf-gtk.so is dlopen()ed at runtime and calls back into
+    # symbols defined in the perf binary itself (callchain_param,
+    # symbol_conf, evsel__name, ...): perf needs to export those
+    # dynamically for the plugin to resolve them.
+    LDFLAGS += -rdynamic
   endif
 endif
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index df70e95a8470..123b6d5fcea7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -145,6 +145,17 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	return src->histograms ? 0 : -1;
 }
 
+struct sym_hist_entry *
+annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
+{
+	struct sym_hist_entry *entry;
+	long key = offset << 16 | evsel->core.idx;
+
+	if (!hashmap__find(src->samples, key, &entry))
+		return NULL;
+	return entry;
+}
+
 void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fa08d09b80f7..40038a3779d4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -406,16 +406,8 @@ static inline struct sym_hist *annotation__histogram(struct annotation *notes,
 	return annotated_source__histogram(notes->src, evsel);
 }
 
-static inline struct sym_hist_entry *
-annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
-{
-	struct sym_hist_entry *entry;
-	long key = offset << 16 | evsel->core.idx;
-
-	if (!hashmap__find(src->samples, key, &entry))
-		return NULL;
-	return entry;
-}
+struct sym_hist_entry *
+annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset);
 
 static inline struct annotation *symbol__annotation(struct symbol *sym)
 {

-- 
2.54.0

