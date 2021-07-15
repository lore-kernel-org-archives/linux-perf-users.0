Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC80C12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9802D613D0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhGOBhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbhGOBhC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:37:02 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689AC061762
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:08 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z6-20020a05622a0606b029025368c044d9so3164970qta.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DTdO0iYUr3tsZd3QdGCYNG4c6LNiO3CfWVyTLuAjf0U=;
        b=DLC6ZUlopRThS5wwEXziEwgZUsiQFr/WMkkDWPQan+kgcacxeTFTudfycoLOwM1Fqu
         qvuddKq/ztcWHP1ZRVJLPML+VKYNz3kMw8dGc1xsVQWKMAdhCoEGI3gsFcEk6VjNAv1R
         VyOaQx+xdK8YedJOwuFZADfPF0JTZ+ekFCu7HAuM5VbV6cBvORcdTZ9kCHdwmOGZVnwY
         xmK6IPW3C2JpGGPA2fjwyYNh/KT85GCwwJC56LLN24V7Dj+rW9BdOqciLuBe24Lbi/yD
         7lD4XmTBO/FgC2G2sEKxGqlvNrfTQet6tE8nUq+P1YaBteG3TglLwy1feODSA8BxCgAd
         ugbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DTdO0iYUr3tsZd3QdGCYNG4c6LNiO3CfWVyTLuAjf0U=;
        b=HK+DNUlKQHIAVTXnL0k7C6TCKsjPm20OYAwga49Bn8nm0L9kWhzIlZKQyYwejUtVP5
         r2O2y2OlTJL9IZFExDPUWN0GDyd2XMjo0MR8TNLM2N6EI6Q+NfVMw3dPCVU/qyZCcF6g
         UOOwmLFZnRRM5hdO/XUy5yZ31XmxJzgYGn7jh7CWTb954bHgBqtSgGcg2cqBkJBwDNZo
         ywS3fhDMxYmsZCqVraHoDDtSlTMNHntlSobuZeFRYSoVUgDC7+mM6BNbNV/7V0T8Ec6g
         47H0me4dWUpiHxCGDVS930moMP9XWnmQ8snQgr0I1v/C00hHVXNZyLz/n7sQxuW7C+Fo
         fkmQ==
X-Gm-Message-State: AOAM531G1maVWIVjVoLrIx2ipLfN2qjZCgGxK2VciFalojwG9DlhJBMx
        U3YDi7BUpVV8vrwROchk5JOf+eknPpLJ
X-Google-Smtp-Source: ABdhPJzDBG+wIjPM20CutNVzhPSyKssLfx3uW1s6fh/ZEz7S4KilDePRV36i72b4ODtJgGCPbSQ1zNvzOOPm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:2623:: with SMTP id
 gv3mr1057146qvb.46.1626312847812; Wed, 14 Jul 2021 18:34:07 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:42 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-7-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 6/7] perf doc: Remove howto-index.sh related references.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

howto-index.sh exists in git but not in perf, as such targets that
depend upon it fail. Remove such failing targets.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index c5ec17ee5bb0..9d991b14ac4b 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,8 +242,7 @@ CLEAN_FILES =									\
 	$(MAN_HTML) $(addsuffix +,$(MAN_HTML))					\
 	$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7)				\
 	$(OUTPUT)*.texi $(OUTPUT)*.texi+ $(OUTPUT)*.texi++			\
-	$(OUTPUT)perf.info $(OUTPUT)perfman.info				\
-	$(OUTPUT)howto-index.txt $(OUTPUT)howto/*.html $(OUTPUT)doc.dep		\
+	$(OUTPUT)perf.info $(OUTPUT)perfman.info $(OUTPUT)doc.dep		\
 	$(OUTPUT)technical/api-*.html $(OUTPUT)technical/api-index.txt
 clean:
 	$(call QUIET_CLEAN, Documentation) $(RM) $(CLEAN_FILES)
@@ -294,21 +293,11 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@+ && \
 	mv $@+ $@
 
-howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
-	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
-	mv $@+ $@
-
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b $(ASCIIDOC_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/tools/perf/docs
 
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
-	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	sed -e '1,/^$$/d' $< | $(ASCIIDOC) -b $(ASCIIDOC_HTML) - >$@+ && \
-	mv $@+ $@
-
 # UNIMPLEMENTED
 #install-webdoc : html
 #	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
-- 
2.32.0.402.g57bb445576-goog

