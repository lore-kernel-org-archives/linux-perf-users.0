Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9482362154
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707006; cv=none; b=fsk9P2AH0uKy8+CMUbFisqiCwwuFqfQdTumEFGx0jvkpQMg2dKfNrCwmXpadXn2H8xDL6LxOcseJkfrbS6kBFIKRSV+zvNwZIJ/2xzJ8T4XNCYYuEpNCvur7dygortKcmkWjjiCsj9/Box8bae1z3+xiTPWamY3NoBxGLRgcin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707006; c=relaxed/simple;
	bh=AtjIi/QZTnf1hHLWLicIpAQjJaCCIdq8cq3hjX7SlN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3q991dCBZSS+tq50C9Atb+sCzewtjRSBxHI7dZAT6SIt2bXQFqcQ6m8rKFeuEllqEkuZw0GBIZgRuys+OxiNVUJf++J7Gi8ql1zG4kiZyz3DvvfwjU8Y4x/vbSnQ+Iby5wYxiYs+l9EqxSyXji83D8cLJe9+3L2svMTcLxn9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwe5Uz5B; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwe5Uz5B"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8200b55dc47so30993857b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788707003; x=1789311803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GdZ76vBLFidffsN6N8xpDuSJHdSB1mCV3ORADvgs3Q=;
        b=Iwe5Uz5BM8fnFXLUMrNlO5ZZVf2SFdR/un78I0EVP8XERNlAWOES5fH/ibVMCagiLp
         kbXCw+YB/ezXEfIINNmsD9ticNc2MEMxQqw6DPQoZHTzXo/c3hZnYyNHvRbjRs5fPeOW
         iCxG2U1ymXRPTAXsBZ8PmzhQB2gC08vvFxjf4KBVEz0HcKcp7Q4avzO9D7GmSfqFbPTj
         YQW45PWKuwA0D/gKXzUO5X6ujb0KJhCzHffZ4lCuJqGWC7W5MWHz4aQvRQzC8PSrXRc9
         r2LffQD1AfOTqdlJ2RVsdR0eK256ajFy2/i5HkQ396NVxx1aA7OFaxDA46u8IQjpl9xI
         iIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788707003; x=1789311803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GdZ76vBLFidffsN6N8xpDuSJHdSB1mCV3ORADvgs3Q=;
        b=aR+0bt7UHR5ZhvPBztqxlI0CCUe6IXv9DeLY9bAkU5i+/qWUe2VlRs20LnCYhqiNPg
         Gw7zcw8oUpHjUFl2FNB6YZyO23xkWDimWMKaqVmSjNytO48Q+2jxLa5f6QbYAmb4FMCH
         6N5/sIyqUhBp0y39HQRY2djwTWKVMnjvBjAtVpN+/p2nrajj7ttcsmvER0g5iqoS0/e+
         PJwIg2LqqthgIPgLRGBjucaQdROBT2o70Q4wyT49mhh+7F+lhTYoXL8JG3YpqBetFsR3
         tKpTfLmXgvj0CDjDnMN1zrukLidCmfRKjMkn37KLiNfOLLch90Lx9gL7bxPIE+e1qtqI
         MygA==
X-Forwarded-Encrypted: i=1; AKwUvBzfA+p8auaXeYezcofhu3hvK4+y4QOGelY85dH5aOauEPBlgRZ3bGpelBgbKx93sR2R5KJFNpYjCO5qaVLZuMOp@vger.kernel.org
X-Gm-Message-State: AFuF++nkWVacbd5+g5K8zVNEHJyWoR4r/L0CvT6plqqYtyWulYQvVGOO
	MsalxpNp8DrOrGlXbgENWf1Koz1FKzyy2BsginMALh7qbnidmcqVwemZ
X-Gm-Gg: AYBFou0io61fXtdTmm+a/evXykk4Knu51GMe0Dg4hicH6JgLwhdEaWMU7ur32bxsj0l
	33KV1ReCpydAiYiIoc3vKy0OjhX45HGB208viurO6swwxH7snBp/TJif3eIJO0JWBllt0MSXbu7
	t89Skq07Bmoeg9PeHJrGASurwD2JKRWJyMvn0h0UkdPBn/wgNOiPYWt0XTMB8sbnO92Gcy5yO+0
	2Oilzs+CDtk3LCeaeMWWh2FVIhNt234pQ72IzsJyDKTvCMjwbfKjooyNPsnvw1h5MrYhduVuu4r
	zuHUpWGoYxeX61o1GnEtKVAreU3AaccEPicAyUlNep7SDdyDqktbBQyJ9ovr+FcxnwoLG6H1aE+
	pHY+kw0evfmygH5+K7D4g9Dd39celE6dfzJ/NwoUjAvQmpeFDQ0gzMkOsBpRhJ45dTycUDo4y5H
	qp6w4Iieojna7l7r4cJifGFUPMYlSmQAyrLlhZgng9pfwfXa37S0dS3fV4M48N
X-Received: by 2002:a05:690c:620f:b0:841:773e:8d86 with SMTP id 00721157ae682-871232363dfmr67600267b3.15.1788707002419;
        Sun, 06 Sep 2026 08:03:22 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c54e4sm56655697b3.6.2026.09.06.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:03:21 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 11:03:16 -0400
Subject: [PATCH v2 2/2] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v2-2-3eccff053cd1@gmail.com>
References: <20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com>
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
 h=from:subject:message-id; bh=AtjIi/QZTnf1hHLWLicIpAQjJaCCIdq8cq3hjX7SlN8=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmNmwOeGalsTZw6SeVTV6JCdzx0v/atneFh1xkDZrvX
 7pl16rdHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNEnlGhtVv8w7acf
 JoTnd7JHAjk2Xtj2tPnDd8C5yk1Cr/5k8k7yeG/9FmTr5zrq9pyA8RzHMKW9Px+E3ZXMvj55/yJ
 142PqYtxwkA
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

