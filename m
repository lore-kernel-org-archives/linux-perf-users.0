Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8843537EB;
	Tue, 19 May 2026 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217232; cv=none; b=qT3KCDtf7qQnHsADq7RTsl4uYDVgyChiYlLXjOP2iSrE8G+UDJKSZEHCR6hVB2przi1OD6fHrKESLER4sj8JnojaJK0QFLQHqfO2MY7q7o7VLk0G/i8yM2doA4nNjN8CLb23b3iBEOwqRNL5/OL+G0yR1Ey4tfoPYEgho6qZbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217232; c=relaxed/simple;
	bh=eoWZ8GDXHnGEtMUsiRmXpWhbGn9t1dj/10h//yaQVMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZApiX+0GuEIa93rkRBQdIWduqHrPmuEdAMvipu3uuyTN117tlb0Xd/MFsDqGOgd/JLr9DIu//1aEjCJ6VI4tlIdfc2clswfj3e/aMwMORlzSqSYjMopnh49SXOrFAZnhdkg9O+VUtVgFt0Gmka+oNWCY4Gs2dfm6hdEzDg/f3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bLqFqQfm; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bLqFqQfm"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 27864C0017ED;
	Tue, 19 May 2026 11:52:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 27864C0017ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1779216722;
	bh=eoWZ8GDXHnGEtMUsiRmXpWhbGn9t1dj/10h//yaQVMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLqFqQfmbpNtcnDRtPJKXSSOoFeJtTxrKw51L2g/DnfPdEeVc8gSXw8Z5WwR2KJ4H
	 KDK3Px5b2eP45L5ntfSPIUrHFvM18LG5h5VSbPlTZq8NCwVpmY22o9zypDUjSWLPXX
	 VzzNk6Y6xXbiGnk6hkcqMPb6uk+UbGWJKq6Mam/M=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 52BFFAEA3;
	Tue, 19 May 2026 14:52:00 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Tom Rix <trix@redhat.com>,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.1 3/3] perf build: Disable fewer bison warnings
Date: Tue, 19 May 2026 11:51:54 -0700
Message-Id: <20260519185154.2987285-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

commit ddc8e4c966923ad1137790817157c8a5f0301aec upstream

If bison is version 3.8.2, reduce the number of bison C warnings
disabled. Earlier bison versions have all C warnings disabled. Avoid
implicit declarations of yylex by adding the declaration in the C
file. A header can't be included as a circular dependency would occur
due to the lexer using the bison defined tokens.

Committer notes:

Some recent versions of gcc and clang (noticed on Alpine Linux 3.17,
edge, clearlinux, fedora 37, etc.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: bpf@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20230728064917.767761-6-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[florian: Remove non-existent tools/perf/util/bpf-filter.y in 6.1.y,
adjusted perf_pmu_lex() signature]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/util/Build          | 12 ++++++++----
 tools/perf/util/expr.y         |  4 +++-
 tools/perf/util/parse-events.y |  1 +
 tools/perf/util/pmu.y          |  3 +++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c364a9087a2..036f9780b398 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -269,10 +269,14 @@ CFLAGS_parse-events-flex.o  += $(flex_flags)
 CFLAGS_pmu-flex.o           += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
 
-bison_flags := -DYYENABLE_NLS=0
-BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
-ifeq ($(BISON_GE_35),1)
-  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable -Wno-unknown-warning-option
+# Some newer clang and gcc version complain about this
+# util/parse-events-bison.c:1317:9: error: variable 'parse_events_nerrs' set but not used [-Werror,-Wunused-but-set-variable]
+#  int yynerrs = 0;
+
+bison_flags := -DYYENABLE_NLS=0 -Wno-unused-but-set-variable
+BISON_GE_382 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 382)
+ifeq ($(BISON_GE_382),1)
+  bison_flags += -Wno-switch-enum
 else
   bison_flags += -w
 endif
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 635e562350c5..b8745d564b78 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -7,6 +7,8 @@
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
+#include "expr-bison.h"
+int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 %}
 
 %define api.pure full
@@ -56,7 +58,7 @@
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
 		       bool compute_ids __maybe_unused,
-		       void *scanner,
+		       void *scanner __maybe_unused,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index dbc350a2c382..42d4414760e3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -20,6 +20,7 @@
 #include "parse-events.h"
 #include "parse-events-bison.h"
 
+int parse_events_lex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , void *yyscanner);
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
 #define ABORT_ON(val) \
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index e675d79a0274..ae88d2d2dd6a 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -9,6 +9,9 @@
 #include <linux/bitmap.h>
 #include <string.h>
 #include "pmu.h"
+#include "pmu-bison.h"
+
+int perf_pmu_lex(void);
 
 #define ABORT_ON(val) \
 do { \
-- 
2.34.1

