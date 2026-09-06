Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CB3A9D8B
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725596; cv=none; b=nW2xdb175V8veg6SsEt3N9tAXzq8v/3MCw0CDQ+YNOdY4BBnVcx6TL/lROOiHFQZ4JrMN1BQ9f1jL/pEg8PHiejbdoXja7pquBf6J51gKTPAu9dHeuRz1FCw9dt0f9Wy29dNk1B2YsTpkqqlb2+teB1RjG1OCfVLT/nRNELLg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725596; c=relaxed/simple;
	bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJtqxGwtQLh1qq54nIexouwwv+JF70mo1cMa9B7CncskP7g2FPCiTiD24jgSvNBKJ+9QFBryoB672dHG7gasS9BTJKX4FyaPj4SNa89C0HvzWdA74U8X+Y2ReoUAJ522pxM5FmbXL5H2G28MncdlisyNYBpKYO9IStff/VADT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+Oux/VC; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Oux/VC"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66fdf2a9aacso94690d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725592; x=1789330392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=Q+Oux/VCRLBiFjHSPD9zk+ODhXkVu3xlGUOzwPZSg8cyCnuKlc5Pi17CgCkJ0PhzYh
         zNnrvnk5oZ4nIaQrn7kVJzMHS7LZCtTcBqbgKtphgdtAAAI2LhNksaMQsB+KI5Iv4yLU
         xstVsOIX6ssloYUwn/vOFcDNQEz5hcri/aJpvqVVvvPRo6KcW14O7wYNAfv6PBK1t67F
         UDlBjiNkCKWDCgLkjr7OasTTTnDTySgifVYzfOGFllBsCh/gCVO9MJy+Uro1tmv/3k4Z
         Tda7WmHfthD/vv7JRrVzLYOkCFrKcLuOp9tPSaVfffuLCSKelch6CQIPx7Rj6qfhzddH
         /DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725592; x=1789330392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=W+RWjW0F+fyWD1dbBdZ6aMHbX/zIzJH3n/ab30QSPFaZ5okQt/NdH3XYD7MCaJLsmy
         7N7uVzhccF3QCnb/Vn/OtBmABgCZCuagFhymvDQ+Vs3tG3xuUGPafUP9M+W0ezXyyZXH
         J6vE9gVsyH1rnJuIsk1GSZpTxH2cRTA81x9I6XTTQMFfGM0Qu3kKv8RcPLvA/7UvWqj3
         mG9k9MhWCfYauq6WTzNRh/gboLnSv3tMNHfwvzAuvwKXIXoayMkePoCXkOAVPQZsor8w
         ruA7qw8gpRoV+eEyWhfgNoSAyt8UPZlou66GABr2evfQ/2/I1JFgponbp0pAGmEf6js6
         Oghg==
X-Forwarded-Encrypted: i=1; AKwUvBxbrSpjRgUGm2U9EDzp4TlKmE2I4eAshOUqIE0yifn2CQJt+WvmMgohth2DAfhS5FL45tZrThxTcR/V62IsSK7/@vger.kernel.org
X-Gm-Message-State: AFuF++k5D7nMJzQx/yvWn8MnNivvnVlY3obNE2knE+qqrcWOv7kRTI/w
	XE0Pt9Y6OhTyn6aRXESV85wT+L0QkvPtGcAjQrCIteR8HsmxJUrazY1n
X-Gm-Gg: AYBFou1hbd0GWuP2VX+5YDkrIFM7yrWHKcmsryv/qINBfZvuNzs6GTqzb3djkuJjTje
	X4kw6YNQKhYHihGB9S3tOa32mS7AKV1Sb9dfSm4O+Q2VaqlZKOBOCjbgG15jkZhBlL2gk9DP8d7
	2XMKXzERW1EELKOi4HB5xXN82aty2u3beQcHTiT8XMFfKNZWHrYJJOecwAvh7BvBBjuVCBDiPWk
	/EAAnaIV8xGqBadBeH1zpOly/cBV9lfq43zWl0B+6Wzy/y8KZ+hLG2LAM2A2GaQOz/n1uAs8ldp
	mnbu0crGqEcbnFnImXVJ0cUWQd9lXULJDSNuiPu2I4Ul6Y0lC5fttPGjsiKyvAleK7EfSAVrmkL
	HA7dbKOx4Nho3Xj3v9sIZIlki24MrNdFo7j2w5Ce/xzHhHx0AW6T1E4nsc5no20FvqK1uDgvigb
	+hJpkjFCkRjFB4dyOJFVOpG0U4aNHrR1oBGZfiQh4XR9yMWcfL/GC0frMFB6NR
X-Received: by 2002:a05:690c:31a:b0:80d:964f:88fd with SMTP id 00721157ae682-871221a70cbmr81582507b3.5.1788725592445;
        Sun, 06 Sep 2026 13:13:12 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bb0efc1sm59661367b3.45.2026.09.06.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 13:13:11 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 16:13:07 -0400
Subject: [PATCH v7 2/3] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v7-2-1ece839fbca0@gmail.com>
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3810; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmngx8+f+Q6Pa3DOZ1dxaeNJeWfrzzeVrdCS3jJ7XHV
 yl1r/Vn6PjIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhr5t5lZDi1Tf6edG
 HQv5T9jf+mBbBsNJ+4+cO0abknNycy+LZ/7PvB8E9xyqLPD+/vdrfYHeNxYynXJ85k28/X2EXf/
 Tq75+nb/ZWsAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report --gtk dlopen()s libperf-gtk.so, which expects to resolve
symbols back against the running perf binary (callchain_param,
symbol_conf, evsel__name, and friends live in perf, not the plugin).
Two things broke that after the GTK 4 port:

perf never passed -rdynamic, so none of its symbols were in its
dynamic symbol table for a dlopen()ed plugin to find. Add -rdynamic to
LDFLAGS when GTK4 support is enabled.

annotated_source__hist_entry() was a static inline in annotate.h, so
ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
hashmap_find(), into libperf-gtk.so as an undefined symbol. The only
hashmap_find perf links against normally is libbpf's internal one
(tools/lib/bpf/hashmap.c), built with -fvisibility=hidden, so it can
never be exported to a dlopen()ed plugin regardless of LDFLAGS. Move
annotated_source__hist_entry() into annotate.c as an ordinary exported
function, so the plugin depends on it the same way it already depends
on evsel__group_desc() and friends.

With both fixes, a default 'make GTK4=1' build (libbpf statically
linked) can dlopen() libperf-gtk.so and open the report browser without
NO_LIBBPF=1 or manual LDFLAGS. Verified with perf report --gtk against
real perf.data on a GTK4 desktop.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/Makefile.config |  5 +++++
 tools/perf/util/annotate.c | 11 +++++++++++
 tools/perf/util/annotate.h | 12 ++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3e59e2b7eaec..4ee7393a39f9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -785,6 +785,11 @@ ifdef GTK4
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

