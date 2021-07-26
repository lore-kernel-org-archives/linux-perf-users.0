Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E126C4320A
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2376860F11
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhGZIeJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:34:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60518 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhGZIeH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 04:34:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3393621D07;
        Mon, 26 Jul 2021 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627290875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mJL/LDUSwy4oHGXTaM6+iHFBN1M1pD20XNyDOqtl5tQ=;
        b=v5KHtyJsREwwlYYRnWABVGbcgwnzNhpWV4clFLWDrxpaY6nu2wd5R6/DMrBa8ebaLn7xRH
        luoSWwZ1ZuObYhTH+E/IoxP0rA8E9knEknEFX3deTBctRCMF4TSVKFhmCvMl+ESiYSZX/h
        sR/4JaQNfW2gscZiVhd3bz9roJEf/dI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627290875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mJL/LDUSwy4oHGXTaM6+iHFBN1M1pD20XNyDOqtl5tQ=;
        b=4sbrnlxfP2o8EDYz/0S8FkXAZcGNRwvuS+UJa4umkbsMzEA0UCUJBhESefUQBQid6y+u22
        DKRdz7ZeJ1zFytAQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9375A3B89;
        Mon, 26 Jul 2021 09:14:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     acme@redhat.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/2] perf: don't install headers with x permissions
Date:   Mon, 26 Jul 2021 11:14:33 +0200
Message-Id: <20210726091434.5000-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

install(1), by default, installs with rwxr-xr-x permissions. Modify
perf's Makefile to pass '-m 644' when installing:
* perf_dlfilter.h header
* trace/strace/groups/*
* scripts/perl/Perf-Trace-Util/lib/Perf/Trace/*
* scripts/perl/*.pl
* perf-completion.sh
* Documentation/tips.txt
* tests/attr.py
* tests/attr/*
* tests/shell/lib/*.sh

All those are supposed to be non-executable. Either they are not scripts
at all, or they don't have shebang.

The fixes line below is only for the perf_dlfilter.h header addition...

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: 0beb218315e0 (perf build: Install perf_dlfilter.h)
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
[v2] extend to more than perf_dlfilter.h.

 tools/perf/Makefile.perf | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 77e7f18c0bd0..01bd153c4f2a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -925,7 +925,7 @@ install-tools: all install-gtk
 		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
 		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
-		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
+		$(INSTALL) -m 644 util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
 ifndef NO_PERF_READ_VDSO32
 	$(call QUIET_INSTALL, perf-read-vdso32) \
 		$(INSTALL) $(OUTPUT)perf-read-vdso32 '$(DESTDIR_SQ)$(bindir_SQ)';
@@ -960,13 +960,13 @@ endif
 ifndef NO_LIBAUDIT
 	$(call QUIET_INSTALL, strace/groups) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
-		$(INSTALL) trace/strace/groups/* -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
+		$(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
 endif
 ifndef NO_LIBPERL
 	$(call QUIET_INSTALL, perl-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/perl/*.pl -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl'; \
+		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
+		$(INSTALL) scripts/perl/*.pl -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'; \
 		$(INSTALL) scripts/perl/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'
 endif
@@ -980,22 +980,22 @@ ifndef NO_LIBPYTHON
 endif
 	$(call QUIET_INSTALL, perf_completion-script) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d'; \
-		$(INSTALL) perf-completion.sh '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
+		$(INSTALL) perf-completion.sh -m 644 '$(DESTDIR_SQ)$(sysconfdir_SQ)/bash_completion.d/perf'
 	$(call QUIET_INSTALL, perf-tip) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(tip_instdir_SQ)'; \
-		$(INSTALL) Documentation/tips.txt -t '$(DESTDIR_SQ)$(tip_instdir_SQ)'
+		$(INSTALL) Documentation/tips.txt -m 644 -t '$(DESTDIR_SQ)$(tip_instdir_SQ)'
 
 install-tests: all install-gtk
 	$(call QUIET_INSTALL, tests) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
-		$(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
+		$(INSTALL) tests/attr.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
 		$(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
-		$(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
+		$(INSTALL) tests/attr/* -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+		$(INSTALL) tests/shell/lib/*.sh -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
 
 install-bin: install-tools install-tests install-traceevent-plugins
 
-- 
2.32.0

