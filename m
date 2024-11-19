Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B5158553
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979103; cv=none; b=E92TZk5U7m7g8E9q3po6yCyNSfRZJ+h1Y61qOMFfDSRUAoSUgz+6gaUbCslXa9ZA+bl5AeCA+QZhaLPVq0iARGZR5asgpV5DirbsLfozbuQQEv+CyZESGV7qI8p4myYiFq4LklIdZg9OiPgtadWNUKSA49s8VEdiTHNGYFl5Wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979103; c=relaxed/simple;
	bh=ccbfQ/FCxM0ajSqCRBtrUPwSJY3+AGZURkp9AUtPPf0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=tXaA8jdOp5NJOigNJ7eMqganAlPNE7jjL8r+HJ43bFX00yx0DHVTPkbSes6qY/+pp2N6KtNbmZeJV9SOKjaOJDVegawr1LcRWa0MhDQw3sE7eWAzAlO4k+uWshW3063cQWKdBHSe8GGetLMM+MMv02wP2JiFFyVj1A743TAkfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HE7JfFF6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HE7JfFF6"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeab4be015so7930077b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979101; x=1732583901; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=frFU6vDMiuKwKS8oNBs9ivnCPNnXTA0sYwftgRN+B6Y=;
        b=HE7JfFF6eNF6eOmOwIZ6dAB4bQ6JSc5dKLDXox9CNchlsr3dzNGIUSfyXD3Wrs4/KY
         ZvcE7HY05DMPYMRjG9OzB8VVIXoecp/5mlzaV4pgu0ooeDJGwTvl81GKBz+9X2rEFRh9
         QieFT8cbq7cRU7/b57hvwAgcr0JuiqLQWwgfYLY5bk4xa/UJwILuXl7pezXa0qqv1zsL
         LFONE4ljye9Wsilr9iZV9Wv1pk657f4GA0rHKnwTUyzIFVk7eHDcLkqWsDgtf/0OCtTP
         bdhP2cMn2ED/Z45PGZjIf6wujAuXaWR1lP8BccFc3V8b+WwIqmMTyVIF3wZFLqsvzjAf
         QL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979101; x=1732583901;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frFU6vDMiuKwKS8oNBs9ivnCPNnXTA0sYwftgRN+B6Y=;
        b=MdxIVYdgUdF5R0t6mj2ATOa8kycnDyc+nLLzzhXu04chZ/+31kdG/CPk3qXrr34QK0
         t28OiG2L3JTvi1CwWnwG4sDUt8njph/29jX5sjMHmn/G5C37kgwyPjAqIskatIrMcHnQ
         u7MGNd40xm720n0GsF3OicOBYHybOG2B506xHmanJDjVeuHqKls7ZeEAFB+td9U4kqN4
         X25ITZ7+3ar+XhPEVSQnuDpvpelyUF2FcaMo/1KUsOcwXIEw8a1ODRcoffORmW4cyTjc
         AV1IXPf/ffHY4rLhouoamdMTMCXAMjmc6QYaRZIwuvWuA47C6WBFOVBIxM4F+GMGgyPz
         7gOA==
X-Forwarded-Encrypted: i=1; AJvYcCXpTrQGuZ5ZANnzMlw01u0s4w8Jc4Eg3G3dzyolx6S4E0rXYAh5FzQXQr7boeh7q4g/6D9udP2nzO8cNvSRQlHO@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKudV2esFJ6hQXIOX+G8eoJxNcS+0BnLf7A3ffw48nrt7dq70
	fJS0/KQIqeS9FH5CsXeRSA5f3XsBY6HMN8uzXUYONChsiZG1ayO7G1SMVdG5RcDGOEIz3CHrHhU
	Em0lNEA==
X-Google-Smtp-Source: AGHT+IEH6bm8HluA7jd0r6+9Cueqt8y2KXSiPCe2m7BpnNOtq6aGwuTd2RlX5z6Bdg0V8iHN7DjhyAg0Oq7b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:296:b0:6ee:aedd:bfaf with SMTP id
 00721157ae682-6eeaeddbfe8mr7587b3.2.1731979101174; Mon, 18 Nov 2024 17:18:21
 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:40 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 18/22] perf build: Remove test library from python shared object
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cbcb698cea38..adbc7ab325c7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.338.g60cca15819-goog

