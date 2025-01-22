Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D53216E14
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567797; cv=none; b=YFEvaq0xIWil2IB7OG2EH98G+/3G4rhY6RYMgnpZtaNQFdHTL9c/tBobCvVS4Oq4kbwboU6le6a1J84zf/pPnFJ6ZXS08KdRsqcy7BjJCZ+f+K14lwjMBvdWj1w93mtcC5tFkpint6LBiHwHCExcaK4CauyjM5YnLmhhJlpcREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567797; c=relaxed/simple;
	bh=+SiSH7CLHUUhlFjrtfw/RdUrBE2m3hzevec1yCiEXZI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=azh2HPDnqoYUCAHHArCGf1GOn0tRflhnUrvnX2iDHUk8OhBSB+jHxRNXhJri3rMamoNA0MFtA1UU7F3UYFpYnbB09cEkPv0tnOSGHCcdMQLC8LnBowvb4xixejfxX12E4IYdTlxeyQRXaR2DFvl5QcZ5BIH6xT9Kl8kehrIQCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYjEqGWW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYjEqGWW"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so10426276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567795; x=1738172595; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvK3AGwJ0K5BrCR508+h+usqMhR+kgkezdw0g6O+CCA=;
        b=jYjEqGWWV1J/hLzVUzlV9+ZBQwpAe4p8WMiYX33qSBcvQTs3ZJK58FrlnyGAHMc2N/
         EAj9IqxlruMEdq6pHsDVfHkAFdHolDGi+SYQDfddniCgULmaYnUlEivoJKILtUVIAw8P
         VB9YW3XkyQSagXzoAoSIaHoQGPw751qDXqaRcndWKqCfJ8hC9YJftdS+lybTkboxTFOF
         dQnSrCfU76uYElGfgezn1Ozu2GkWzjqPDJ66wfQ0UH8+rMKtBH/bYTug4f0+34CZL3yA
         r4v3sPIHn2+7g1bju2gEXp/Xn0s09hW7wfb0i8qXRhYl92zwbTvBiSDEUlscNG/sKQHD
         VW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567795; x=1738172595;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvK3AGwJ0K5BrCR508+h+usqMhR+kgkezdw0g6O+CCA=;
        b=RrR3A2tWA6e8aos8iC5Fc/87QT90jH3kQaGGm6I6MIl+ftwZWU8iX+0Xpn0Yt1G7/y
         5Gtg4MVXTzCwTx4jFKCnPPJH4zmz5ZRIRX0ifsoVcxjZ6qhKDHtYAfXcXbxAm0wr/Uiz
         UfgDwQI1oLY7+bl6oPTigvOeqiyLYR0FFY+TQPlPmBr5eZNsHaRJqnxUNHwLWTQ4hid0
         c0hMeOjPca8pBFe3pDkgAF6/ZMWNBIIXmZN54Fh0w/vX0SBSnOCmHMdJZ/jVESvR5pat
         hL1j+ZT7eS9UJ2y7FZIuVAwGzVcQTZO8A8gm0Ii/NPVjpdS6/GuXk0fJqkcFLnRCHLOq
         7vag==
X-Forwarded-Encrypted: i=1; AJvYcCU9IwsDi7mnd/ejHeRjrEamALc0JdlwGgJmnxW7TMwVYtwsJzpaHBG3rpg4x3wJfomjqc1FebOWAWl8T0B2pM9C@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFCPioAe4nsY31FLPuaNkQ/MR4/rKKwjyIPCeopSt1JgUurQx
	CLI6AA9baCfCefzuddtpaDnVwILF0W4cl5Vw1LpOH42Aq0W9flCpC3LfEADqNe/s97WTjpXp/SZ
	aJWnR3Q==
X-Google-Smtp-Source: AGHT+IGuNDiz5m/eNmZM5imjDkd6RlEJTMH/eiVjLZsAwq564mKsb5O7VD1tI51H48iqKvALbnZ2UuQm44KK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6101:b0:6f6:d314:49c9 with SMTP
 id 00721157ae682-6f6eb949eefmr553907b3.8.1737567794993; Wed, 22 Jan 2025
 09:43:14 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:51 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 01/18] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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
index a148ca9efca9..cd773fbbc176 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1174,20 +1174,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
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
2.48.1.262.g85cc9f2d1e-goog

