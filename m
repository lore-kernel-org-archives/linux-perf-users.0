Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A68331EBE
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922248; cv=none; b=bAMhXDZ8MSUWBygFPPz6mRY1Po370D4GywYRjUZlQ4TJ9dR51p4l2/FnGlyMVtT/pwRPdxgBKMM+kw5zUtb6eVMFKEJYIhxh31QnxH7gd9ICO+DXvo4Y7BwZPzqTgM2UXlSEIxNVJL7nHoMOnLYcFh2VXX/21hcqbkXdYwTFB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922248; c=relaxed/simple;
	bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqNInrEjwRHkHS10eTwfPHSvxBn7wSI//0d3t5Mu1/AkKJr0sTXejskI6IeQGrUnesQhG4o4CVms7wLS3qLzJ2QiZ7CL+o+W10a1mU6qIG9YS3zzngsCXuqjXnjpT+LryH9RHW7gPFZ6MxMiDS7dsJE3IAOS5Rl1mPmzg+LCUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1Z/dNLA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Z/dNLA"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-87f4e914a45so9172797b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922240; x=1789527040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=O1Z/dNLA2zxklihl00EBsZpeVaGo6fgPY41t350xMviFBYESvLSIYFXMKelyULO4/L
         w+fp9lPvJbv2455cknrzYfJqMonrW26nDMhJASFWLyiAkLuQjbOA0W/MrGwOkgIraC1E
         kvHsSqcj9499jVrry6nkGJWXgd184//xVoDAnpZ50E5/TNInbrEIdnweJAGWH/MNoCAp
         iDHWOtesVs72dCUTa6GGEHFs/fL2xrB+VwX1FXn1fSqg7lApuIK+6ApDu/+n24uCsolc
         jtdJ2nN6PylTz/mnw7QL3r+IAV5f6aw7eeUzRpoDP71NRv9kVxQG3x0v4kKEZIZrRHGN
         8aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922240; x=1789527040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=iF8FfmeCD+xqwvoiTvqXdL7sUoeTPXyAzAisLRwcxGCC4H+zn8wjJrYFI1lhZzBhSW
         XxIwUTqZglXWnCckl2Tebq7IontfcBEdNLRGdiFI7XoWJQmSGz4VG8IGQQmhG91eqyry
         rEKdpfKAX59bH02ZpV60l422di9rltdJH+BDJmR9+JuZN5eEwWu3CNBOfJShcHT8M5OF
         mLGmyuBbmun2qECx+BjDz6DGSwZBJSQyn57Le3VUBMP4fTLiJj2cyDF1UvA3NCskYt4n
         3wJvHAYgRiQIAkQ7e8i5OLC/xJuy8pu9PVgSRVXgKaeCPQ7aDBHi+pLXC35+fOrNswQQ
         iYCA==
X-Forwarded-Encrypted: i=1; AKwUvBx93tPS5sK333CzFSNQPucy75qhzHt8pXTKjyVYWI5SO9rVNs5il3QFnkiG7az23fuY08nUu9ZFOzUAk5t0WLdV@vger.kernel.org
X-Gm-Message-State: AFuF++nUKqkB4CQ8Jld3nK2mHYYWc+edVy5ti3GH3VlzeshnlGu7ltIl
	r7NH0TDA0PzhppcAQJjaiVyEKAjANeXc2U6B30MDZ9pyvo6MlpXnEBkJ
X-Gm-Gg: AYBFou379+v4o1h4/PTPcKH3HyhBsSH98CZ3ELqgcFNR0VOW0UDtUcEon69+MgJZuPL
	BU7ayfPsa0crRu9S2cO7eTPg6JLhODB1WhezEuaLY5lYh1t7wBr6hunMQcNd/Zwm46AQVufkQgn
	x4VzBF2O19ymc6haE7KF4gvWf7QrcPOSVC2huwnr05BBHebxP0d/IpKAH6IZ/ySyOmNyS+gSIBk
	Yw7D4MSzAC2WbUjU/QnVl7NwdT4qjqMEjWNm0XdfRB61rh75bi+ENP4aAFC5rAn4hu2zjl+vFCA
	XAFCeiLZciL/huQ68miYAp6JziRvwSJF5R2xlVdllYD/rIyRJ/Yg7BfH6qQl0o9NC+YTh8dEXOS
	M+WF0EgNiJZ8V8dshDnNwkyivTecUIvendFzoJ+RRRI6nLkyYHVyQjAzualOmjig3zxQGQRzqG/
	MJALdvWOzV/KtjcxgXBUIJKQjXtizYhSnUfsNOeT4gpE4T9rVmNIeg2jbX7R7KJXpjNa8X1Wg=
X-Received: by 2002:a05:690c:6d81:b0:87a:ea5c:c21e with SMTP id 00721157ae682-87aea5cc507mr53889867b3.21.1788922239624;
        Tue, 08 Sep 2026 19:50:39 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316356sm103354187b3.9.2026.09.08.19.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:50:38 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 08 Sep 2026 22:50:35 -0400
Subject: [PATCH v8 2/3] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-perf-gtk2-v8-2-e90d5d155f0d@gmail.com>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
In-Reply-To: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3810; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIWnKw0Tw9puPqzZmJTvEKyzNTcmV/mKz+aKCptcahRd
 9Li54GLOj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOYa1xxGhmO5Bffjb3
 yq/LaUNeil2E2Z8uSnRdXzTA705Lj+W6V+U46R4cblB2H+9+Xmd69a+j3cvu70sp/7DDkial0fR
 PN5Jz89wQAA
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

