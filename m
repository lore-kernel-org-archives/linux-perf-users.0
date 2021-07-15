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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A24C12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8157613D3
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhGOBgx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhGOBgw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66CC061764
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:33:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h1-20020a255f410000b02905585436b530so5363943ybm.21
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1xMjO4kgd9GThnwLrzWb6z2olJzN511MeRsxBTktrzk=;
        b=pRHGVkQD82aM2yJLyYhoIsWE+JyJ2wImCtJzcHe4/zJiRulZVfj42YGWY58XGlIXdV
         5LYqcPYKAL5K2+GrKgD0g9zb+LCgiC2+WD1efwrmxYxAl6xpJEO7qHTQnkMk2rSbOp2c
         kwivQbYIiyFTMMF8c5LxseFw2ku7iCZeEXz2yNFGLhmo/R1LHHDn7cEe+Nr4VbCCEQn7
         ZtY0VB/quv6SH8ELwa+HWCCudGga4JtSXzH0BXu0QIhcyKTi0DrM6F1DSnAyp2Zi2G0V
         36HW9ohU2uMy8l/Q3o/wFm5VZ+SI2DhIbcbteEf5P9yR3PUiTi6AjPx/3Jqi1KojtC9h
         P7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1xMjO4kgd9GThnwLrzWb6z2olJzN511MeRsxBTktrzk=;
        b=V6egoFT+qNjqOa42u387KfL3viZuLuDXuW+4jorZGn0aH1bVKOD+YFrNm/KfdpMufg
         nUW5Lw+QbVML31qPvFv0S7Mykp2nB9QbBEPZ3QIwWTGk5dwRs4fH3H/wMr/vul5lvFxh
         GdnoSHJnYh4pD0YdWOqJcbAZ6CtTHZiDfJBLiWjAEIYrbzUGxlHe+F0GBpXrj2dn86lz
         04ZcxK3og9z/eUCol163okoOdlmIltEJlT3VDHE3dEpg3cunzfDTR5I0H7OwusEx/UMx
         /2xXSdl7JpmlYWEQpVcq3egWYWO09S39gX3fUZIh7tIq3+t6fUR5dGbjEakog6AOg1Af
         u/Zg==
X-Gm-Message-State: AOAM5301d4eNOQeSoFEkiK4MXJEusIqhznc72bPyLlB+WLcaInbr5aMc
        mZI2kASOGGn68T6UOrxADBwHAOeJUVD5
X-Google-Smtp-Source: ABdhPJyOLYEmVqY779oa560cGqUl3Entvz5QJopYEhEmjtBsyZCK85zVwW3Pn4IcYC6QO5vVsWKtIP6J/5m+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a5b:4d2:: with SMTP id u18mr1321425ybp.158.1626312838591;
 Wed, 14 Jul 2021 18:33:58 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:38 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-3-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 2/7] perf doc: Fix doc.dep
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

The doc.dep dependencies for the Makefile fail to build as
build-docdep.perl is missing. Add this file from git.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/build-docdep.perl | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 tools/perf/Documentation/build-docdep.perl

diff --git a/tools/perf/Documentation/build-docdep.perl b/tools/perf/Documentation/build-docdep.perl
new file mode 100755
index 000000000000..ba4205e0302a
--- /dev/null
+++ b/tools/perf/Documentation/build-docdep.perl
@@ -0,0 +1,46 @@
+#!/usr/bin/perl
+
+my %include = ();
+my %included = ();
+
+for my $text (<*.txt>) {
+    open I, '<', $text || die "cannot read: $text";
+    while (<I>) {
+	if (/^include::/) {
+	    chomp;
+	    s/^include::\s*//;
+	    s/\[\]//;
+	    $include{$text}{$_} = 1;
+	    $included{$_} = 1;
+	}
+    }
+    close I;
+}
+
+# Do we care about chained includes???
+my $changed = 1;
+while ($changed) {
+    $changed = 0;
+    while (my ($text, $included) = each %include) {
+	for my $i (keys %$included) {
+	    # $text has include::$i; if $i includes $j
+	    # $text indirectly includes $j.
+	    if (exists $include{$i}) {
+		for my $j (keys %{$include{$i}}) {
+		    if (!exists $include{$text}{$j}) {
+			$include{$text}{$j} = 1;
+			$included{$j} = 1;
+			$changed = 1;
+		    }
+		}
+	    }
+	}
+    }
+}
+
+while (my ($text, $included) = each %include) {
+    if (! exists $included{$text} &&
+	(my $base = $text) =~ s/\.txt$//) {
+	print "$base.html $base.xml : ", join(" ", keys %$included), "\n";
+    }
+}
-- 
2.32.0.402.g57bb445576-goog

