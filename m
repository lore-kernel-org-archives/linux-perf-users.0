Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52048C47088
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Dec 2022 04:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiLBE6h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Dec 2022 23:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiLBE62 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE7ECCEC4
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Dec 2022 20:58:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3c44ac82606so37990857b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Dec 2022 20:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhcm838vqRbviJVINtawNn6TNcB3z9aWYltBLm5HIxk=;
        b=PxVUhm64KsR6Mi0JEzZpmyH+ESj3GpUqdRBullEc2TxUiMuvpELl5BPD4CkqSSATx1
         aL6QaAxPJ3htK3byYaO89DGkDpFn1KRa3HgX8lWZRHnSpFb4Eb4ZQlu1Bsc7xyTIEHsI
         NOQ5J2WyixET0VOdWUYOypZJWpIZu6Q2rBfTJbftC7WMaCjfbvjIt6BwSwWzoNKVXFT1
         iEFe4fokWc/5rSyeeF0LHkHUZaAr/CLM+4B7/Jsf4BLyWytkbkPraQCiZSTjYKK4ts5S
         lOpUyFOSGaKEaT+gnY6PBMdyeS0ijyebSTbrKj6NyIoNfnMC/OT3aQZf+IMcUZsDZj+5
         xiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhcm838vqRbviJVINtawNn6TNcB3z9aWYltBLm5HIxk=;
        b=Q3vdsyvAoJHOhEakFukOtIwurSudeDYGuyKYEzRuvkGVm1IpjocA//aWSQ+u/vdU/K
         n4YbIEAoNdwlNItAtJ3a7ZViWjbYhk+VHMG4TwNrwdBIHZXkNF/ik47vU6DVpEWTUV3q
         D59YMZ8peXIkR480SZgPf72rdnD71+Y6mZo5GFUwbZPH28vG8d/NiEpcsn3YCba/mxEt
         J3mMk9LmKL6n4X9ZsaWe1GTnTEry2MJzSknIBhJzLxUhew4I3kvdB2YNj9yspxy/8HC3
         alnnIlkw6H94GpHMtpnvUMS68Rv7MxwmtGjgg7wHYOFRYmICfFWr0VB3wn6d0QJefb6w
         SlkA==
X-Gm-Message-State: ANoB5plSb/QvYuhj4WuaMoYTSQPh1zHPrCco/RijnX5uwpyQpCBZR/Mw
        VrnZGiIIqD0or3d2ryO7Lbcma1Rb3kBq
X-Google-Smtp-Source: AA0mqf5CfUr1ni1ydhOijcrKDrUH6Q4Z/fxX0gKX0+scEkSznJvNYmEWVgOtlPAgSNKl/d+ltip8dBgQpasK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a25:3454:0:b0:6f9:41dd:faef with SMTP id
 b81-20020a253454000000b006f941ddfaefmr14632533yba.87.1669957101240; Thu, 01
 Dec 2022 20:58:21 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:41 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-4-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 3/5] tools lib subcmd: Add dependency test to install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Compute the headers to be installed from their source headers and make
each have its own build target to install it. Using dependencies
avoids headers being reinstalled and getting a new timestamp which
then causes files that depend on the header to be rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 9a316d8b89df..b87213263a5e 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -89,10 +89,10 @@ define do_install_mkdir
 endef
 
 define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	if [ ! -d '$2' ]; then             \
+		$(INSTALL) -d -m 755 '$2'; \
 	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	$(INSTALL) $1 $(if $3,-m $3,) '$2'
 endef
 
 install_lib: $(LIBFILE)
@@ -100,13 +100,16 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libsubcmd_headers) \
-		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
-		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
+HDRS := exec-cmd.h help.h pager.h parse-options.h run-command.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/subcmd
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS)
+	$(call QUIET_INSTALL, libsubcmd_headers)
 
 install: install_lib install_headers
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

