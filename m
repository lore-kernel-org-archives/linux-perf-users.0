Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514223;
	b=fBrkmtEbOEZYqpTeOAjeaI/rP5ARWT5sKA2hJZ4Tqi04xl+oB1WwH1QlZML0l65Eu8qm
	 VMeqNCeRzxsFuA5qynX35yXmUNyMYJwAZlmrrTUGZhXu9JWDORuVipyNCqiehGEPfRRGe
	 Xu+1qvgPiBPZCvmLLXG5TB1KP7iyFXo9vobYk9k64UJnMwNvVz7Vuykb6GOcxf+sxcD4z
	 uzX/JNNuH0nQOYHEDq1szAfVhF3/gnsBSbSXyuBApjEK7jslswv2mm/FxlCiCokx0K6aO
	 XmKsfSY+WGCvCYiuPb39u4RLylz/0VafG2FVDUiS6f3/q2Z5ET8v28w5XryENmSUUtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
	b=rI0JVx59phPXk1IEdSysEhjPbUIFGWZHZrjPvlWVL0exme9dUnxJJxIh9cdJM3Y9d+ab
	 Z6u7ONlSD2eYSn/dY39I7juSssmTys+jqtbtBlyxbnymfGPUho5tqq4mBuIHMmSQnp++h
	 Gw0XSKT7PDK8IozYfdMAYm/2Wri/96I+VPfQpZpbLxZiW7+3dtH5bHNKFL7F2CsQ3Azpy
	 M3wfLWXb63F9hU0PQsG5eCHB1VE0tKP0dv8nv2l3umFMTKlrtaiJF4HHeY7QP+kqW+Ocs
	 yNJWl75ZYnzWJ8cYpPubaerB3PFyNcFNiwQBiar61OiWY9+DLt0lor4brdVeTKWILbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OTTMZc5e;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355560A2616
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C355560A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OTTMZc5e
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-17dc865c94cso1288733c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514222; x=1793119022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
        b=OTTMZc5eqUiYqhkIKYdRMRRzgncx6fapWEfD9VeVwzL00OcCJhLd9a1CqgHq1G1gA0
         5AKQBBddiXT5sxmHEfzHHBTWYHOBtimcYbBhtSvPxlY8A2izeViT/x+dcGNBCZV9G91t
         ZkeXBqvMXeDgvKo+62d8Tk365M6KcH+dPMXNz1spVjAKU0W5gbxPWR3y6hEEkoEfDmZ/
         O//s424YY+YaW4GLhaF7lEgm4r5u5svtaTozDO3sHsp8TT3OhIGJsC4bgWa7Rame3VdB
         MFc/IM1yMCDqIDCEPTSEvu98lMjPRB/V3VZ7ppSeSDdeN4ytCWuT/4l6x99IgmleOOaT
         qBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514222; x=1793119022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
        b=uMIS1x2KZD+7YmKKtFeT3AYomHLKmkpXOz3sYy4dPioF+nV0Q2sZ79dAzPWx0S1t8+
         vIxFIZEeTDWaCuHK6ABDGuh/b/p6Y0ByMAAoq0+9sd/j+Kj1xmORSwBZtUJy4XJ5WTTJ
         eZ51Tym+JVTZX5JKOMXeZs2gPXsFlX91QsNd9/FlhgNILUBBzI8fu7MMZYquziOPp6OY
         j2WH5xTil9lKWf71Vl5uj7IwALoXNRi7paLDlUWLpTZjVxrmu0PCI1pAj6Tr3ppuLH+l
         q37+zKAMLboov+a2qR9c3zqoLi+J7Co5FJaszMfy+Iz/ztFGoF4Y+FCXQfnR+CHuq9Zf
         uQ2w==
X-Forwarded-Encrypted: i=1; AKwUvBxS3NieWGdxNIZvLBkWAehk58xS5EbGKzeF49G3fXQNLBYf0wbyC0W2p48iAl9dnt6/Tr3IOKo8vMrxdUFFA01Y@vger.kernel.org
X-Gm-Message-State: AFq9FYIw1zmIRuqIjrH1rEwyhJS7elYfCHT6Ar+jQM2y5ZuL9zPgpbs0
	EfAeZvOlthT8O4YqiQzkKEeW5zeo4EoHXWjEMh1zsPitKnNNrV/WlOaXK2v0YauU7JUQTOrpvWD
	N/mh2sxQo/g==
X-Received: from dlec18-n1.prod.google.com ([2002:a05:701b:4292:10b0:15d:9efd:93a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2207:b0:136:c443:80e5
 with SMTP id a92af1059eb24-1876658f6c4mr12120611c88.6.1792514221602; Tue, 20
 Oct 2026 09:37:01 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:28 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-6-irogers@google.com>
Subject: [PATCH v5 05/17] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 39442577418e..ce746b12f901 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -Wthread-safety-pointer -Wthread-safety-beta
+  endif
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.0.212.g129ede20d9-goog

