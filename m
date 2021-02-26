Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC3C433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908A064EE1
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBZHxR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:53:17 -0500
Received: from aegir.uberspace.de ([185.26.156.141]:39886 "EHLO
        aegir.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBZHxL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Feb 2021 02:53:11 -0500
Received: (qmail 10560 invoked from network); 26 Feb 2021 07:52:27 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by aegir.uberspace.de with SMTP; 26 Feb 2021 07:52:27 -0000
Date:   Fri, 26 Feb 2021 02:52:23 -0500
From:   Fabian Hemmer <copy@copy.sh>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf tools: Preserve identifier id in OCaml demangler
Message-ID: <20210226075223.p3s5oz4jbxwnqjtv@nyu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some OCaml developers reported that this bit of information is sometimes
useful for disambiguating functions for which the OCaml compiler assigns
the same name, e.g. nested or inlined functions.

Signed-off-by: Fabian Hemmer <copy@copy.sh>
---
 tools/perf/tests/demangle-ocaml-test.c |  6 +++---
 tools/perf/util/demangle-ocaml.c       | 12 ------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/demangle-ocaml-test.c b/tools/perf/tests/demangle-ocaml-test.c
index a273ed5163d7..1d232c2e2190 100644
--- a/tools/perf/tests/demangle-ocaml-test.c
+++ b/tools/perf/tests/demangle-ocaml-test.c
@@ -19,11 +19,11 @@ int test__demangle_ocaml(struct test *test __maybe_unused, int subtest __maybe_u
 		{ "main",
 		  NULL },
 		{ "camlStdlib__array__map_154",
-		  "Stdlib.array.map" },
+		  "Stdlib.array.map_154" },
 		{ "camlStdlib__anon_fn$5bstdlib$2eml$3a334$2c0$2d$2d54$5d_1453",
-		  "Stdlib.anon_fn[stdlib.ml:334,0--54]" },
+		  "Stdlib.anon_fn[stdlib.ml:334,0--54]_1453" },
 		{ "camlStdlib__bytes__$2b$2b_2205",
-		  "Stdlib.bytes.++" },
+		  "Stdlib.bytes.++_2205" },
 	};
 
 	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
diff --git a/tools/perf/util/demangle-ocaml.c b/tools/perf/util/demangle-ocaml.c
index 3df14e67c622..9d707bb60b4b 100644
--- a/tools/perf/util/demangle-ocaml.c
+++ b/tools/perf/util/demangle-ocaml.c
@@ -64,17 +64,5 @@ ocaml_demangle_sym(const char *sym)
 	}
 	result[j] = '\0';
 
-	/* scan backwards to remove an "_" followed by decimal digits */
-	if (j != 0 && isdigit(result[j - 1])) {
-		while (--j) {
-			if (!isdigit(result[j])) {
-				break;
-			}
-		}
-		if (result[j] == '_') {
-			result[j] = '\0';
-		}
-	}
-
 	return result;
 }
-- 
2.30.1

