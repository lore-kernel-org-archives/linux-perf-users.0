Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC518A6DB
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527036; cv=none; b=aCi+P8jjR6N7V+h9NeaA6q9iVuE6IGmBoz7RJRlAzVO9igI00/Rlo4JHi4WResf7CSqQ1JP5Yo3EuiewulZqo8McEQsbGw4Iz9J6oYZ0akRKYc11BYJrrCFAKV+LfAEIqLUT5gzT1i4G1Rb9XfbrKrYidnXseGLgv1M9vQ5ZnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527036; c=relaxed/simple;
	bh=HLjYxhTE0ZJA3vcrfmMm7AEqm0+HanoGfKT1dIg80hQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pmdClUIEj3X1fKuyrEXIIld0+nLRjUrVM/z4MNMemjZYkSMBp8ZtAkgspzHebBy7V3dOC53G+dZvU6hgd3ahn3ZCd9qH/nnhaVosIdvAw2g4uIyuFY3XuMnYcbMzAwdJjua/Q/xdZ9TzsraAxP1rwa5pFIsfkVfjG8jZ8ZoL858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THCiXvsO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THCiXvsO"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a1bc0c875so14133898276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527034; x=1738131834; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWOFr+hD7k+GjJj0c2HJd4uR6zLfGwFEDOqmlnPBFno=;
        b=THCiXvsO6VNOFTe2tb9Jbg2o+FFHAwnWXdkEh8LvfKjwd/Tsf73eVWQ+kBLkfI4zAt
         n89OpXlLMhn+7DPnI0qx1KDGxj7wqRhsCu1qFCvuRNwN4xlqAYWbSuT47O11+tsytcSt
         Abf2cVov/UQ4vCUNIARTMOEREwfTXd8a0e6PQU+jau6LU/2GysctuOWgylbrmprHzrtx
         EtB8HFP1w3F98vF2TjEhcXpZn1NodGAU4PBLa1UiNmw9+lBuuPWBcLI83MIFqf64OCRA
         0Lw1hQgfCElu8Z2fb5zAfeBGY2QTNKeo70B53Rnqh0kThQ7R+q+eYeRXtsUonqFSD0tx
         wIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527034; x=1738131834;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWOFr+hD7k+GjJj0c2HJd4uR6zLfGwFEDOqmlnPBFno=;
        b=t7n8HsHjvfSzfSn+UH+hNsaAUAICD6NQjUEl04pUJuZ4QUsglTiFYWPu/z8YnEo1ZV
         TIdYBaKCI/iZdp+s9Qt4s0y9r+9xeCmy2VmNXxiQPK91CYO8HtyuQxkjBIpUd5jC+xjA
         Rjbl/cjITYw7nYiuLdgdyXUzXCi895cAz316VNZNLtdNFEVbuYKfzdLiOQTmcDvlc5bm
         e43TIQZsepXWmfS0Y8fHy9bEXjudkQ89YU7Hk2XOQyiy/D7fhEXxzYQmtL4duB2ow+gz
         DKIgoPnnxPBwExmrjjFxxo9uUp4SabGQlmZKOxYU818OymAG0SfHSucsvLP0OEmWeIoZ
         ZEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoU8giinxqpMidvXHCcRxXHf84LNX+TVg+w/4cG5EEhaUoAXBBRMneqUtYFlZSIRO3+9D4xPea0c4vpF4TlKN1@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZ1W4I0lI2CGDzMuoyc0f5p8N9DiipCrIzctYDMZ2EccAiX9Q
	wUIT+XYN8fSzJkfPKVug5/ZtSPFd+4tA4PBVru+9KOkwJJRlM/+WtyI5/J8b9s/x8vtB/kak25s
	HVpRx4Q==
X-Google-Smtp-Source: AGHT+IG+2fKJSD9bXucwytV4V3StKpytOSpv10FBbeatTPAofS0m6i9zzGrQqG9RlCLEOmJ8JZYJVNhsnJ3b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:881:0:b0:e57:fb93:606 with SMTP id
 3f1490d57ef6-e57fb9309f5mr14706276.0.1737527033629; Tue, 21 Jan 2025 22:23:53
 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:16 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 01/17] perf build: Remove libtracefs configuration
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
2.48.0.rc2.279.g1de40edade-goog

