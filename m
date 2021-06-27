Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C6BC48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF7C619CB
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhF0NUm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhF0NUl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137056"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137056"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589046"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/10] perf build: Install perf_dlfilter.h
Date:   Sun, 27 Jun 2021 16:18:13 +0300
Message-Id: <20210627131818.810-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Users of the --dlfilter option need to include perf_dlfilter.h
in their filters. Install it to the include path.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.config | 3 +++
 tools/perf/Makefile.perf   | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8dc7cef684dc..eb8e487ef90b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1117,6 +1117,8 @@ prefix ?= $(HOME)
 endif
 bindir_relative = bin
 bindir = $(abspath $(prefix)/$(bindir_relative))
+includedir_relative = include
+includedir = $(abspath $(prefix)/$(includedir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
@@ -1149,6 +1151,7 @@ ETC_PERFCONFIG_SQ = $(subst ','\'',$(ETC_PERFCONFIG))
 STRACE_GROUPS_DIR_SQ = $(subst ','\'',$(STRACE_GROUPS_DIR))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+includedir_SQ = $(subst ','\'',$(includedir))
 mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 perfexecdir_SQ = $(subst ','\'',$(perfexecdir))
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..c9e0de5b00c1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -923,7 +923,9 @@ install-tools: all install-gtk
 	$(call QUIET_INSTALL, binaries) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'; \
 		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
-		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'
+		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(dir_SQ)/trace'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
+		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
 ifndef NO_PERF_READ_VDSO32
 	$(call QUIET_INSTALL, perf-read-vdso32) \
 		$(INSTALL) $(OUTPUT)perf-read-vdso32 '$(DESTDIR_SQ)$(bindir_SQ)';
-- 
2.17.1

