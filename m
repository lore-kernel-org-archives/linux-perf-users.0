Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C03909A2
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721068; cv=none; b=N7Ta0+Hxg0xkfjhNeRhl/u/++54a3ImSkPIvcTJpkcyoS282/4Mo2/kxac0kl0aJ81Y93GTYkgdsiD5bYrVJODAUqTdavgHU2G6DYjvFEyw+Q2BeNRE98LUnAtpdwpkKMdGvdlXSupq44VfzfdN4ZAvm3a+op9I0eJtaA34txNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721068; c=relaxed/simple;
	bh=V13NjxcZ8Y+EH56zGxBFcHbqNp/dD0O+9buYDXRen/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0ouuQ9wGAQa+UJRczx4Tq5Cy170RXBbESuG15HHhF42Evx6FWtgXtY3lxS6fLUgpKMSQqKwOX7orqCjGIo38S7erHb8MmKaT0ujmqJlEgz7S/NUbnUQNV9ZvjRf7Ub5aRFVLuXMz8T/nl6G5Xkhnv2PtkLGl+KcRLKXjS+HRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGVBfIw+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGVBfIw+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-86b03b75fecso43214867b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788721064; x=1789325864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=jGVBfIw+Bj/qsM5aZvLeRvSZw4FHFGyHh5s+c7mn5VI4bCPIcD2XHFHWRROnjuVeWv
         n7OmMyzjqRpUV+zHrLb33rjE+lYyS0Q3WNZhxHcV6S6nCPcy8xvghgjY4I6MB97St8Rl
         QEmKWyEp0XAYEFuddSv0r0RENmliz4ZpFN1D6ZJ7VkJCVUU1lB7eEHycsc2HAnZLZiov
         gk1oqgFvQbL3ClCQbaI+LN6logCTTVOvm9DNxCU959gc9DF7IpVi23TGSzirFBqkr9fC
         Y97ASjEb783RXSp5mOgQ8F79ikymBtVdS2Ze+qrSz2dCPNUNeQOd8rMw289NTKq5Ybrh
         udNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788721064; x=1789325864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8uHZ58VC3qmxtEe8gO2hHAyHIZcWIh7nanbyJ3N2VQ=;
        b=VRdfLZTAM7YMzq9l9v77Kpzp9gxbp9YDvT/kk/Ds3DA3Gryc+MVw6k1vZ2Ys0ecvgz
         O2WSqObbW5GWhV4BQWL5tyArxjGRdLa3xzeBBoQeWXC1yVJQFsMGF50CuV1fbDDs5GK6
         NfDXbBtqNKDh0o5KOLqKVVUoITO/L6vLBu8dnM9G93VWmd61vRMaT0w718F2zPYYXHun
         rdZAPCdDJNFgZsrNY4g6T3JiKWmGetis83nYmqfiOlbKwe4kzmU4jV/kkmwTGq1m6njK
         psDJPYaiPEzuZvLV0b4Lyo3ktXlsJIjBiSJX6vtlJ7rTbJRdyK4DropANzsaaCrY3bPh
         DDtg==
X-Forwarded-Encrypted: i=1; AKwUvBwmFoykpQCD3DtHvRwjNA+zXnLVv14oFBEucIKgFpE3cpJh3TZXUpvcJ1JdzfyxPpq7Snw4iITyTHqujiEDw3Jt@vger.kernel.org
X-Gm-Message-State: AFuF++nq+LwXtRWBHVzjsW9UXFisjh9tmIYpAXET/RjG6DNxdvnz1UTL
	WglY3ONw3kOCaTcH90lsX7DJk0gG8N9c71o5Dhfdx2pf1Cx4rZwGWEds
X-Gm-Gg: AYBFou2EzcEum6Y3NeucPq2Eu3Zt83MCS7ns85sWJT+LSoNNSMUvhg9oDSfMbOH+KE/
	1HvjSJrYP9/LnNL7ceLLYowkOWGCgPQdKwdKj41ixHFKHSLyJUc64mPapEedjmZXcra65ZJwVL2
	2YcaYWU7ia9ip534qycPdu2EMN0d77kGpCjdaPQ0gMpV7NBUpjOtmu6mN3+jp7qV/3NrG3LtTKr
	CX/ta1ZpUcEGR0Ofw/4MxZ43oiTF//4MeVM0PjGBCZ94K6JPZsZcWBNf0BQy4BLVIl1dd82xbHx
	YlWaMz3FR4Tbtp/zewAruGA3sCwhal7yecnSlSrIxDxSFXkHzJD683rF4oxX4ioEge0R7XEx+GP
	d8Eq0V/mqcGlO4pf6PDpFTkzFr4+nGpVv6MQN2BJEa2Mhir0m1MR/3MHp6bP5JIJPD6FJQwE2tL
	W65yMxoBim5o+hZO91L4uw4T2arug6b5Ykmzum5m6qwVJU1eX75Y2jknoqy9NT
X-Received: by 2002:a05:690c:6603:b0:873:5bd1:98c5 with SMTP id 00721157ae682-8735bd1a2f2mr42026087b3.55.1788721063272;
        Sun, 06 Sep 2026 11:57:43 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439bcb5bsm59389357b3.3.2026.09.06.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:57:41 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 14:57:34 -0400
Subject: [PATCH v6 2/2] perf tools: make the GTK4 report browser actually
 loadable at runtime
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v6-2-695d1c01aaa1@gmail.com>
References: <20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v6-0-695d1c01aaa1@gmail.com>
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
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmbp/rXMiRmt17fpKQeUxWyUo+v6Ul24XeKfjseSQ9P
 ePJthlnOz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaekdGhj16F+v2Sz
 Ytqdqy88xk8+YdzRp/dK+9PfvH+GWv6SnfFYYM/3TvVa69fUnk0MQ7/L9PVbz4lvWfkdFg6hYuh
 byOF8aSa/gB
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

