Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012D3EE1EA
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539205; cv=none; b=TQpTCG2L7bqwzZHqkRn5Wi+KTEEVn/5teDURLuTw6Y9Ik44aRkfdG2upiGpdPfz+A3OXr11K1l8bHrinW7fxTRJLAJQ6Y40vNBYGGnDq5vbLTz45ShrvLSKbCjH1tyyRmrg3FAy15BJZ6hrroa6IFJCbHlK1o9WU64Vjd2ps0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539205; c=relaxed/simple;
	bh=BzLrWrhofRN6OPfyQk81Dwa6JQsFLbb5DwXqPENoCWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GqRPK2TxtCBbzEBe3w8EDWgRc8iNVprOGEfO1tCiw4JTw+zJslGU27MmKpF8Yyd7mjC2gRdumgg4BBMUsbmB976g1p11yvocNOVVtkyq8MyYoHOiDjuE2ATdVdFciOF85ORl+Ya2cyuTt199DUNN37r8JJk/jhifX6JFmeR/Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6X9gAap; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6X9gAap"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e087a17dfso2261616a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789539203; x=1790144003; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WC+4bBJmOMaCFD9dsEEm3t/QrUZlzEYn1326Syti9Po=;
        b=S6X9gAapJSzXaUO+arbY6BSkcJysOnofMt4+X31HkL1ZCtOMd8Ahy38BoKX5LM9Uzq
         BtW4pohJGZLAatiWBP0ITc88nF46WpLRjsVbKu5bQZJ+CqoMfZ+P3o+QuIhcxf8dE3WF
         Am5MGWKpMqY4HMmDOQ5IrGevxiE9LdlAQ8ykaTdcXDXrV9G2OScCZVPdC5doT5Iqmhpw
         CLXZbab+NF3PZoVqcvkmAw49sjvSKbbD6CnLPSAaH2KrW171XlQpfeRdN6Fc0lUo30Aq
         5RpjgNZvxBan+T38ZD3taS77p6EqL8w1L+QD/dT5irhovPAI+SLrmK/ZdjnS2qv6W4Xo
         fnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539203; x=1790144003;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WC+4bBJmOMaCFD9dsEEm3t/QrUZlzEYn1326Syti9Po=;
        b=tS+lFFJNulc/UeuSd4CWhCIXdiCgWNC032eYNLeMkG44933tvCGl4wB3CIx97RgSqD
         IdpwyKCSwWFDn3TBUpD5UefyCszXNid6wWQ6gCVXLEVYoZoJdoqTiJIWIKltw2j73miP
         5p/tbFGoSzo4YdC32TArGfsoIeCAAJ8mXb+g4GxJQgjIh4K9yQJXHfDttYmbH1EMATn4
         tVymuohSd+pZAM/EivfWKloumvzm2al1otEauC4o+MN1KHTslIoJ05f7PeyCLzT7nqt4
         2b0iMc6xm/UloHWbZHesxD8/tqCmkWx+dhhpPA2ADYrZe219WtEJCOvqtuyBwaUp8Kqi
         Xn1Q==
X-Forwarded-Encrypted: i=1; AKwUvBx4IsVzcKqqYgsHhVx8JB9aklXLDHMTs3ctyeMATAafH0kJXmcSND8yHqkE3QSQTCm2AV5XkKPuhmavfIUWmirv@vger.kernel.org
X-Gm-Message-State: AFuF++ktJgMfB5J2AEqqJhFFQ7kYKEllP+heagOouZkurowntPePjgA3
	9wxF3ZttzSmC7umNDYHucsiQkZOsqL0jYKPmxO8ORRpS4117nMYFf/opcRpE2aLzxugMQpPpsPn
	/FFZ62fS5MA==
X-Received: from dlbvg14.prod.google.com ([2002:a05:7022:7f0e:b0:143:7cf0:d45a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2744:b0:39d:efa9:cd20
 with SMTP id 98e67ed59e1d1-39e1e28501bmr3351234a91.7.1789539202967; Tue, 15
 Sep 2026 23:13:22 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:12:15 -0700
In-Reply-To: <20260916061218.3061216-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916061218.3061216-7-irogers@google.com>
Subject: [PATCH 6/9] perf build: Use the given CC rather than clang in clang builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang block is entered when CC_NO_CLANG has determined that CC is
clang, but it then ignores CC and hard codes $(CLANG), which defaults to
plain "clang". Building with a versioned compiler silently switches
compiler:

  $ make CC=clang-19		# actually builds with "clang"

Worse, the target triple is probed with $(CLANG) too, so on a machine
that only has versioned binaries installed the probe produces nothing
and the build stops:

  $ make CC=clang-19
  *** Specify CROSS_COMPILE or add CLANG_TARGET_FLAGS for x86_64

Use $(CC) in both places. Within the block CC is known to be clang, and
for "make LLVM=1" CC is already $(CLANG), so nothing changes there.

$(CLANG) is left as it is for BPF skeletons, as bpf_skel.mak builds
those with "$(CLANG) --target=bpf" whatever CC happens to be.

Fixes: 4772e66cb45e ("perf build: Support build with clang")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 31e4cbe192b9..dca62e155fb5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -38,7 +38,7 @@ ifeq ($(CC_NO_CLANG), 0)
 
   # Default to host architecture if ARCH is not explicitly given.
   ifeq ($(ARCH), $(HOSTARCH))
-    CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
+    CLANG_TARGET_FLAGS := $(shell $(CC) -print-target-triple)
   else
     CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
   endif
@@ -53,7 +53,7 @@ ifeq ($(CC_NO_CLANG), 0)
     CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
   endif # CROSS_COMPILE
 
-  CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
+  CC := $(CC) $(CLANG_FLAGS) -fintegrated-as
 
   # CC being clang says nothing about CXX: "make LLVM=1" overrides both, but
   # "make CC=clang" leaves CXX as g++. Probe CXX the way Makefile.include
-- 
2.55.0.1032.g73a4cd73de-goog

