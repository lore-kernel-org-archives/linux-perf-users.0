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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33125C12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195FF613D0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhGOBg4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbhGOBgz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C8C061760
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:01 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q6-20020a05620a05a6b02903b8bd8b612eso1981063qkq.19
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9ulLD/fU9W0OzwZvZuuX6b1DWiP15Rr9ZcqPkR8f8k=;
        b=CkCzHjKN+XzIPI2Z5zYy3Yi3XPmd2TIinrVvFVKDdgrl54PJA5sH0dgxtyPE2HP9cI
         vGdd3rUu9rt/3q6Ruq9Ctp4SQ8IKLu6SJUbIjTWtk/+x4oI7ZtpIVyUsW8uJS6MYyaqg
         BXNifY1jn40WqPMglg65h+DZMQvLMfug1LaKOeF82/wsnF/odLT1t0LbwqYJxU95K2ax
         XjXH6rv+s/EnPO6Yhc30BVHg6pkqrJpo6utrc9R8atbw9MjLGff2NsfOsFaIsLmbFDQu
         KdPoWYqhJhaTjf44ssIjf1PfJk3ubGwkzKiJEMyM3J6475CYoTeenCUVFBQsow1c7sPV
         fcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9ulLD/fU9W0OzwZvZuuX6b1DWiP15Rr9ZcqPkR8f8k=;
        b=LjZjxvyx+2+Aa82iTKDYdq3GJnDJmqMKVUnG/nCtFU8XCDfiE4fQ8EzUhfO7C6Nx7+
         XSdtzjRvaS2bSrk2kIsrao7Q0jwZ5ta27m5ZUQEYVRhjw9nfZfJ0+esK3CQxax82k+oi
         3aGi/7uepuTV4Iolb4gJu180eR1YSVPyDtkHhFni06J5JvMuvn/kOY3An/UHw2qgicXC
         UHuWcS2WK/xFZel4L7bABsWAxeMIijoWUoK9IJOfipTWUMFMkdQmVQxMhAv89VrROiQy
         A24UwOXpQvXxbH+9PR4CWslD8odscQH+c0ShYsSNAa134p2rOVTirjUTiZ1G4LBYIcIg
         qdOg==
X-Gm-Message-State: AOAM530K6SKbl05cFjlnth2einRTPChqMESM5hD0o1cP/Fs92cbY5Jw2
        yjKmWNlnQKhdHKviya21t2Hx9SeRaWru
X-Google-Smtp-Source: ABdhPJwkeYsMicvviGQ328kdTa+3vamfieBa/crfDN2NpM25ZiGM1zK9Rz0mMWhNhBeIMraKrLaQFf3rF7vy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:d6d:: with SMTP id
 13mr1049593qvs.3.1626312840822; Wed, 14 Jul 2021 18:34:00 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:39 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-4-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 3/7] perf doc: Remove references to user-manual
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

Perf doesn't have a user-manual.txt, but git does and this explains why
there are references here. Having these references breaks 'make info' as
user-manual.info can't be created given the missing dependency. Remove
all references to user-manual so that 'make info' can succeed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 859ec1496716..03300c151858 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -186,8 +186,6 @@ man7: $(DOC_MAN7)
 
 info: $(OUTPUT)perf.info $(OUTPUT)perfman.info
 
-pdf: $(OUTPUT)user-manual.pdf
-
 install: install-man
 
 check-man-tools:
@@ -225,11 +223,6 @@ install-info: info
 	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
 	fi
 
-install-pdf: pdf
-	$(call QUIET_INSTALL, Documentation-pdf) \
-		$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir); \
-		$(INSTALL) -m 644 $(OUTPUT)user-manual.pdf $(DESTDIR)$(pdfdir)
-
 #install-html: html
 #	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
@@ -304,24 +297,6 @@ $(OUTPUT)%.xml : %.txt
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
-$(OUTPUT)user-manual.html: $(OUTPUT)user-manual.xml
-	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
-
-$(OUTPUT)perf.info: $(OUTPUT)user-manual.texi
-	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ $(OUTPUT)user-manual.texi
-
-$(OUTPUT)user-manual.texi: $(OUTPUT)user-manual.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) $(OUTPUT)user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
-	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
-
-$(OUTPUT)user-manual.pdf: $(OUTPUT)user-manual.xml
-	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $< && \
-	mv $@+ $@
-
 $(OUTPUT)perfman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-- 
2.32.0.402.g57bb445576-goog

