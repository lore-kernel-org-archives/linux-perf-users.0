Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545D1946BA
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977081; cv=none; b=H+0p0iURkFkfhznsngc3keKUD24HDvprc5kED2DMpYOuRzqpILHRx6ycdOgGPtJ7ZATMHnRzX8uEjTgyCYhPMsjjllHKIXklDUsVVHxBS6S5eV7jmga7uRM16+ww9gIP9P4ub8ZouS/xJWth8/Am97js1uC/nPTZh6vo7ZGShhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977081; c=relaxed/simple;
	bh=OjtweS1q3V27F5fK6RgxbRa8U+kYLJ/fvAGK90ksCB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cc6H3H/RcWYHFygs/u3d4hyJMmU82nFl6cDr4lu92bEO6eoLRzsDTUfbSflbsYgbdoEnTk8sGYtokyRn0tv/f2deXF9cOufm8cwbqd+f6g+OGpJBgfGD9xr/D/zOgNeb7DjbUNqnh6qOYhWyx1wWPbNlby1eQ+/qjbLZTdUDkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEsL2pKp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEsL2pKp"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53568ffc525so1041547e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725977078; x=1726581878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS/maFmCMzAAa4s+MCdvfSFRa4peuXy1wJykcXIHmPk=;
        b=gEsL2pKptFzYFzlk4/YRhDLOOvxj76WgXwcVA3ciYClXow4Iu0pAet1Ne3qMa1V3gk
         IKKfropaemR4cyesZMZEFDut3xktIQp4yVJOzEhi23kPVXdE0N7gqsJA5srNUgVNImmv
         ROEt0vtlYwKTQ8c5Y7JelFa3G2sOdZsr5pppKi0Es+spf07Hc/uLWgWPclfW7xBoQqiO
         jm4IbpqRE/uMOn7X8cQDeufcJ7+Lr0tyog2rWFMY71qP5TfX/VM9jrBTjexjSIwUfS63
         RapVY2rOOWdfS1u15MQNVWrtooc5Hb8NXl6fgtqY5quRQJjEudEEL0Sah5kIZAR3hLHU
         tOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977078; x=1726581878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS/maFmCMzAAa4s+MCdvfSFRa4peuXy1wJykcXIHmPk=;
        b=CnNQa5g0GpLmkZGGGGawqrmAfk1D5Flse57YLt7denEs/S/KdFS6CR0ASq5NMiglV/
         PRbGDkFp8RU8PfeW0crOln0ElVShrMYd1sLxiy5u2IZqp+MYvs+a7EnZ8OW5C1HW405C
         SOpRMg9N9J7J0pc9yKEyfzQvCK0msG+yMLItVsLRe+oP9nNWrp1jOAN/EsMeeOcSVoow
         zXMjiibNg5a1LFNhKjdsyy+A6Y+iRDZFQTj4BViFk54ITm3LaGQRJNlmU76OKrn30v4g
         2KZ+oqVLPbPIlEuyMDa9tcOynz/t3zn3+5YsdyYnkzcfTqd12EFICfOIgNGk7Yj2W6QE
         LU2Q==
X-Gm-Message-State: AOJu0Yw+25gTQX8XHsKFEzpWNFUkkxBqjPMRhzhhcebF31KpBqOIPSg4
	A+70Gy3cMwPcI1aj41ayaIP4/g9A1i6V1c2f4IWOTIw8DC9nwtP4007A2gaSIKAWZC3boY5v+LY
	u0d9wPA==
X-Google-Smtp-Source: AGHT+IHoK5woUUfrtzi8S8rwG8nObPbqRVcjsqfShnp3wADgkiTW2rnKUpQlo65zvgcisMPeXektZQ==
X-Received: by 2002:a05:6512:2523:b0:535:6795:301a with SMTP id 2adb3069b0e04-536587fce23mr9726515e87.47.1725977077413;
        Tue, 10 Sep 2024 07:04:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7f1sm114787075e9.48.2024.09.10.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:04:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	sesse@google.com,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	Leo Yan <leo.yan@arm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Manu Bretelle <chantr4@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] perf build: Remove unused feature test target
Date: Tue, 10 Sep 2024 15:04:01 +0100
Message-Id: <20240910140405.568791-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910140405.568791-1-james.clark@linaro.org>
References: <20240910140405.568791-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llvm-version was removed in commit 56b11a2126bf ("perf bpf: Remove
support for embedding clang for compiling BPF events (-e foo.c)") but
some parts were left in the Makefile so finish removing them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/build/feature/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d6a98b3854f8..5938cf799dc6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -74,7 +74,6 @@ FILES=                                          \
          test-clang.bin				\
          test-llvm.bin				\
          test-llvm-perf.bin   \
-         test-llvm-version.bin			\
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-co-re.bin		\
@@ -397,11 +396,6 @@ $(OUTPUT)test-llvm-perf.bin:
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
 
-$(OUTPUT)test-llvm-version.bin:
-	$(BUILDXX) -std=gnu++17					\
-		-I$(shell $(LLVM_CONFIG) --includedir)		\
-		> $(@:.bin=.make.output) 2>&1
-
 $(OUTPUT)test-clang.bin:
 	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
-- 
2.34.1

