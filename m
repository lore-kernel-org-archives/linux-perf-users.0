Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2A3BCD10
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715095; cv=none; b=cZrHDrgeyoSxr8AYlqISh1NDfQppDLTwR1RJakvyiRL7Va8iib+WFo/2IIq+LSoTHexrmlmLdAmCMkAgK+2o64YmfQJG13hldOXRn1J75yzAbLNapF4D7x0rCM2JLRv2UegC0P3m7QV8JqeR7u5jU6dEIuhkVDHCK7u5uTAZRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715095; c=relaxed/simple;
	bh=8CvFHtfn4Ljqx5Fa6L2b6SNfX914djxML7DsfBsaOO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6u1rlOf/T2iAALmoy9U1AS2Jtj1CwY3pypf4zAW8u01gSNVo9qu+ljdJipAGjR0V+x49xJK/0C00fRpqCN3SDMxUwXhmlK5F7i5Bw8G06S3JqBeGTMVFEyZ/QrL7WX55k0rTJlTJnEdP41X1K0IUWa/5+ZZn7IrSMMw/g2b8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ8HSNUn; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ8HSNUn"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66fc2844f0eso2624837d50.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715091; x=1789319891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=FJ8HSNUnHyZwKW7jb7fiThMpJPU5z4rzBQTJPq2vKn1bbOlCRSWCinjLZ/7NfYLeyU
         Cks0iDQipNobaTfzx7xcsQ/g0I+B/3dvnTizzNVWthJzyegwNEz/ni3kRt0FPY7caIns
         vBceNda2B20QHFYmIROPFwxaBr5YwZOnIrSu3D/iyXjjyIagkvOP8jPSAF5o7067epCW
         d2aVqC2z0v1mkKLQKLRKVTk8pSLP4piFn55YrVP6uMf5s9yDSdPqOD59HVIq/i/Zy6Vr
         67UfmUElqsDCF9dwSvmTi2l42tX9KZz7Ta9OpTxD2Gyo7K4AyRLpG32z+d5laTQnDObf
         5Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715091; x=1789319891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9O0Uei0AmYGxnrMfKSWfJBNUDOym4vtr5Ws3/LSEZc=;
        b=QBHQxjltWRCPic/QBZZVnB6+fopRxQkiK77SUbdEPdrXrRVdoceQfRT5ClGxP0aKty
         cJe9rHJhGKkgX/DLYcIR30ooqxOwt1mNasYRyxPxQsOGsQnTdpAIA6QcndjwZD9qxexK
         nSiXhO3kUcUNTIBPLAp8Etxts3N4uNCbwLgPh6NDI8i1GQ0fgVQhsUIvqEQ6hDGr6UN5
         VrZQb0YXsUne5mk5MW8lpW3u+nF5x23XT8jMuVCY5DXbl0TRE1KJ+RMHTFf6zZDUykKs
         CTf5B2JoOn/px8oh685JsX0OkzrtfhMWIoDQgy22/6ElWwEjyyAKr1uvT2DsmbM+PnCc
         5oWw==
X-Forwarded-Encrypted: i=1; AKwUvBzOWt7K7qPZkB40iSRKg5Hbhwlwr09NrhhaoI981100Oy+4hy7xYczY6/o8no/noN/eLBeOFdrTXIDTuYBR3yVO@vger.kernel.org
X-Gm-Message-State: AFuF++kFrRrVcwkQi5EtRXTJVAr0zP7upV0XsHfiWohHopaiFyEI0jkU
	4GVeocqSYR/OHi9PXDAFqjfbZNDU/UBwz/ONiUsJWsovN3+j4g1jpNIJ
X-Gm-Gg: AYBFou3pAZiUaVUSf9ao0ow7l0lDtJC8WnOa3i1Cr7JuxsFCDFfSqbXuAVgrS0jIc6z
	gmRGplaqUkRcqHwJnZZDWGyYDvWsoanTo1xP2YImE1CPu5ZNQ3Yrl4Klcxx3+EseAw0wIr75Pvy
	7EVSLHzHwcp+AhayPoaNoqcqFWQFhrR4QE6bKR3+ccp5Mt/ozXLPCZm/gcNIRxrg6Fo0mAbSZzf
	XpL387JNzWWaCL3ritnB632lkQe1FyUzJyBBYG+O4+rwyZx91wdia6Qd2skRYHIcPa6OH9SAnGq
	tgk2gFjK/09k738NTdfNGIJC6A/I2g8H8uXYbtZSeKRQB7oIIh5PaQLiAlVy7vCXjELM0sgr6hN
	kmHRrrG3V/rILfvCPxfBJ/bbhBlk7ILLO6eISQ85FdrO+W01y0c30WP73CBX6yYzYnKUPsxvJfd
	b0nSdODGQ1AqZ4YeXc2fzYeHC0PqYvPW29LWYCsS6DfD4HVR4CTSPQ1hec85pWHLHund8O7DQ=
X-Received: by 2002:a05:690c:e3ec:b0:876:6206:512f with SMTP id 00721157ae682-876620652ffmr13759577b3.43.1788715091362;
        Sun, 06 Sep 2026 10:18:11 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714af5581bsm57889107b3.36.2026.09.06.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:18:10 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 13:18:05 -0400
Subject: [PATCH v4 2/3] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v4-2-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4031; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=8CvFHtfn4Ljqx5Fa6L2b6SNfX914djxML7DsfBsaOO4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmLvCZzJnAdcb9+Yu1on22p52udcRl5Pz9FffIcvsVu
 ZU7PsoZdnxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1kzoZGS6wF50pXb
 pduGe18uuyx5v7Hxx5YJO840my1U+DzTMUP59iZNi7nk06T06l83kze9/CCKOdUkvzRFkmap+xt
 vn99dfTFg4A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf report --gtk dlopen()s libperf-gtk.so and expects it to resolve
symbols back against the running perf binary (callchain_param,
symbol_conf, evsel__name, and friends all live in perf itself, not in
the plugin). Two things stood in the way of that after the GTK 2 to GTK
4 port:

perf never passed -rdynamic, so none of its own symbols were in its
dynamic symbol table for a dlopen()ed plugin to find at all. Add
-rdynamic to LDFLAGS when GTK4 support is enabled.

annotated_source__hist_entry() was a static inline in annotate.h, so
ui/gtk/annotate.c calling it pulled hashmap__find()'s expansion,
hashmap_find(), directly into libperf-gtk.so as an undefined symbol. The
only hashmap_find perf links against in the common case is libbpf's
internal one (tools/lib/bpf/hashmap.c), which libbpf compiles with
-fvisibility=hidden; a hidden symbol can never be exported to a
dlopen()ed plugin no matter what LDFLAGS perf itself gets. Move
annotated_source__hist_entry() out of the header and into annotate.c, as
an ordinary exported function, so the plugin depends on it the same way
it already depends on evsel__group_desc() and friends, instead of
reaching for hashmap_find directly.

With both fixes, a default 'make GTK4=1' build (libbpf statically
linked, as usual) can dlopen() libperf-gtk.so and open the report
browser without needing NO_LIBBPF=1 or manual LDFLAGS. Verified with
perf report --gtk against a real perf.data on an actual GTK4 desktop
session.

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

