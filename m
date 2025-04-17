Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8121D3EE
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931278; cv=none; b=e4hccWgfRL5kACNNpp4gLYn2TuRXNYWgFSL42VGa8UGJkZqr9crogZINPk6lLdVVgf/f/qG9kv1Z8L8nmY9w0DpBFyeuTUmq26gMEb4BsCEEmlsyMhiPdec1x/gs5V1oHXK0cWxgBzjN9jlmAuv6EVfkvtZejD85tu7jRzysgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931278; c=relaxed/simple;
	bh=DUhmjAhpzI4glFlJFVyHh6Dy0isdHfkiubMes37ZCtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SbC5l0TH+aT9yBPtKTRRZ5p9Txgr1h6RKsoXR8WXKghFmVOP5Ms375i4UB6SUjNiw+w6S1zuHeJ1UkPG5W+CReNM2KkbASx9EmFhxwx/Cr9+f28M8l3g+kt2gfJXU5iqgXi6IjrR0XeR4DbbbWrWDaT+Uh+gXCzy88rwMl6QknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tatps3Ue; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tatps3Ue"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ce15cc3so12538945ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931276; x=1745536076; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnICyJ2RGS0Y400AqNRs1KksXFmr5hh/vv3vYVQnBHQ=;
        b=Tatps3UeOf3aVg+3xmw+Ju+O8rdbwyVWbCD32mkYDDwu7ibuc/j4wotSFOrASJSFQZ
         eaNO+oRAD82RTlqH+Cxqe8w6QJCd8WJ/0uVVOhG2PCTrqbygl4immiLzgtzlTVvaFmP/
         +ET3q0RiWqjkj03aJ+uS0Rcory8jkt3EbXsrbzb+GjsSUoNDUfea8CGncx29InN3wJnN
         Wxj8GTNYkUG2/79z7HSHIprwC8NhBySAk1SS5rq3xO3b/5eWtHq42dSz3k/G8dcW6fTP
         64H4J0GBlewWDWE0+nBSik8eDIQK+4b/JUlE9AiSZUY2wa/wI3XrmcRKrx43UtauIjTO
         o7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931276; x=1745536076;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnICyJ2RGS0Y400AqNRs1KksXFmr5hh/vv3vYVQnBHQ=;
        b=Q0i23NaAq6P5Q5cD0mme4G8NNiZAvsveg2AoDtei+4r3JW8wC+GMwQtKm+XC8JJDSQ
         /N/zT/x63HEG7qoaKAlOEx9s3hM8J9KIFwkBtJgAck4IzdWJuqf3Z52dCAEix5f6KiP4
         /WxOWCwLRn+OswzeyhcAOXJpCEYrnY7D51G8DAjFlB9knCOm3q8sQX4uLeRzXcTKpg0l
         8NhHk0GUkNwxVFHLMRIbs/JXimKRXq6ZNmaj+0QqeAztwskadWuchmzkp9JkNrZyezz3
         km8p6N4RoSUJ4b9uvwiEyYxhukN8+C+iRGT5b0JL1HEkH3DNxZ0jlPrbQzTyFvoS3hXk
         S99g==
X-Forwarded-Encrypted: i=1; AJvYcCXdflA0QdexNJ0eNmd1sa/VMjveiq8MfJcXTzR/D7e64GOHK0ae52tyszOS6PutPsYOMuLZSI6bdlq3YeU1KtgR@vger.kernel.org
X-Gm-Message-State: AOJu0YxE98KdhAD9MEmLp2TWWNlSpAtVJJms5qxSr6KMzgAzy/WI688A
	rLV/yZNuAN9hg+n3Desf8rOq5jhCKJJd1ohu5eObIBhsIui6N3k6egDA+G2kH8eFlW9xBZWKEeB
	PZngtgw==
X-Google-Smtp-Source: AGHT+IEwa/KfQTqntEV82qp0baymPwWs4os7wo5Uctj1zdlTuJFxSq6S5ewEmLz+IORlKXcqOKBHo7BSNgld
X-Received: from plkj8.prod.google.com ([2002:a17:902:6908:b0:220:d79f:a9bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecd1:b0:226:5dbf:373f
 with SMTP id d9443c01a7336-22c53379f8amr10249835ad.10.1744931276358; Thu, 17
 Apr 2025 16:07:56 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:22 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-2-irogers@google.com>
Subject: [PATCH v4 01/19] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libtracefs isn't used by perf but not having it installed causes build
warnings. Given the library isn't used, there is no need for the
configuration or warnings so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9f08a6e96b35..f31b240cd23e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1176,20 +1176,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   else
     $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
-
-  ifeq ($(feature-libtracefs), 1)
-    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
-    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
-    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs).0.0
-    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
-    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
-  else
-    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
-  endif
 endif
 
 # Among the variables below, these:
-- 
2.49.0.805.g082f7c87e0-goog

