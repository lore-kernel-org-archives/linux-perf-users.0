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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D4C47E4B
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F9A613D7
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhGOBgu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhGOBgu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:50 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB8C06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:33:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i190-20020a3786c70000b02903b54f40b442so2629052qkd.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q4BHOu/wzrpYqkE7mCMBCj6/ZE93wztWfxyCm7cmFBc=;
        b=W70LOBXjGPw6qkIkmwPRBu9X/rO3vxDEUhYFmK3v7r9Giv42BOe3r6w8KP6RaUZmhU
         HDiV2CKSIKjVwY6QJduve0Hr6z65b2WegIiK6S5zx6seC6AdmyJx0C1yqrm8psZCMHZG
         hQDXqvzhdvmetv6zPO8zFXawoxAyFWVvxcqUrnaRL6Ls69bEYLoi0qffdliEJtKQYrP+
         oJiVzVgZRVLFppHjuz8ZNepjeZG29nQ1DlB1Js3nZbLDNabTEsbjHOSL/aUMKjTneGam
         taR+egNJn3lVJNPpsX+EMc3n7ZB89Ybb6CvKtGR58kGXjZb1weYiDnTzo2ZvoHsh1JNL
         slhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q4BHOu/wzrpYqkE7mCMBCj6/ZE93wztWfxyCm7cmFBc=;
        b=jjyYJfuNUTxHZo8KXC0QmGlI+QMQFQA1GiNV3WZnnTxDeehzT9xRzswJLVPlYVWze6
         V/GkQZ31DhApLWJUbDHoK97mdT9DxoPN6j+fAp16djrcYeS2RJwM8OCtFENlRt4C/UE1
         bCp2Z/zy6kc/OQQ0m2HbApbpcEa/dL4vgpfI/EYDpBUmrZiptmZmnQq5b5Tb30VaDLUM
         js1YDkw9a0orjLKi6S2IE1zKmxRU6KEJm0JTkdrOaVP3FH63xnSyVUispZMiSkc/0Olp
         /b1vzbHUSmVhn8E0GgNRkfqsX9UNE7YgWrASeKLr7+49SZj+BSA6/pF6OVTYtWQDiIrb
         aqdQ==
X-Gm-Message-State: AOAM533mQemSUdEMxavSWirheAcviJdYK+IAkAbQxeTk04Uh5lPCd5ss
        6nsgwnxXe+tqY1GG5mofCRt5YV+VfrcW
X-Google-Smtp-Source: ABdhPJyUmDFahCxgVA4ss9+o7IBSi9Md8e1si6j9kEE5+qw0mTEqSY8II6I+kFzgOOAxk7OhXz4KHrG3YN9t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:172:: with SMTP id
 y18mr1256939qvs.14.1626312836130; Wed, 14 Jul 2021 18:33:56 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:37 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-2-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 1/7] perf doc: Fix perfman.info build
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

Before this change 'make perfman.info' fails as cat-texi.perl is
missing. It also fails as the makeinfo output isn't written into the
appropriate file. Add cat-texi.perl from git. Add missing output file
flag for makeinfo.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile      |  2 +-
 tools/perf/Documentation/cat-texi.perl | 46 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/Documentation/cat-texi.perl

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6e54979c2124..859ec1496716 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -331,7 +331,7 @@ $(OUTPUT)perfman.texi: $(MAN_XML) cat-texi.perl
 	mv $@+ $@
 
 $(OUTPUT)perfman.info: $(OUTPUT)perfman.texi
-	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
+	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate -o $@ $*.texi
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
diff --git a/tools/perf/Documentation/cat-texi.perl b/tools/perf/Documentation/cat-texi.perl
new file mode 100755
index 000000000000..14d2f8341517
--- /dev/null
+++ b/tools/perf/Documentation/cat-texi.perl
@@ -0,0 +1,46 @@
+#!/usr/bin/perl -w
+
+use strict;
+use warnings;
+
+my @menu = ();
+my $output = $ARGV[0];
+
+open my $tmp, '>', "$output.tmp";
+
+while (<STDIN>) {
+	next if (/^\\input texinfo/../\@node Top/);
+	next if (/^\@bye/ || /^\.ft/);
+	if (s/^\@top (.*)/\@node $1,,,Top/) {
+		push @menu, $1;
+	}
+	s/\(\@pxref\{\[(URLS|REMOTES)\]}\)//;
+	s/\@anchor\{[^{}]*\}//g;
+	print $tmp $_;
+}
+close $tmp;
+
+print '\input texinfo
+@setfilename gitman.info
+@documentencoding UTF-8
+@dircategory Development
+@direntry
+* Git Man Pages: (gitman).  Manual pages for Git revision control system
+@end direntry
+@node Top,,, (dir)
+@top Git Manual Pages
+@documentlanguage en
+@menu
+';
+
+for (@menu) {
+	print "* ${_}::\n";
+}
+print "\@end menu\n";
+open $tmp, '<', "$output.tmp";
+while (<$tmp>) {
+	print;
+}
+close $tmp;
+print "\@bye\n";
+unlink "$output.tmp";
-- 
2.32.0.402.g57bb445576-goog

