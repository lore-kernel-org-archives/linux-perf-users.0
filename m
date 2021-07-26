Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374C4C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AC360F02
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 09:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhGZIeI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 04:34:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhGZIeH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 04:34:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7F85C1FE5A;
        Mon, 26 Jul 2021 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627290875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pl9BIMcRreWpSXrBQ0aeLR51QxWiKTLVlNTci/lUwXk=;
        b=CPHAeh7/YvIZnDwX0clHAqEat7tRXelPvLgfHbHMBRoThTmtBtYCTuMYdPJov1vsolEzWx
        elwFH/gS73IdOviQo2c16ZIocqc/jvoudEP9dveQZlE7tkeQZl11HMc6E9tTDDTOuAIqUw
        BjkoGeBf0fW++rw3/7SIBmB/SeqHwyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627290875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pl9BIMcRreWpSXrBQ0aeLR51QxWiKTLVlNTci/lUwXk=;
        b=PLpvvNHpVHWohJdVaDh5RC4ZMfYBIGhXbbi4VUsvatkaS9v39XIZ8NhvGCj7taTq6ojPOu
        6FYJwTWjH+uc+CAQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3AC66A3B94;
        Mon, 26 Jul 2021 09:14:35 +0000 (UTC)
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
Subject: [PATCH 2/2] perf: remove shebang from scripts/{perl,python}/*.{pl,py}
Date:   Mon, 26 Jul 2021 11:14:34 +0200
Message-Id: <20210726091434.5000-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726091434.5000-1-jslaby@suse.cz>
References: <20210726091434.5000-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The scripts cannot be executed on their own. The python ones were always
installed without x permissions, the perl ones fail anyway:
  BEGIN failed--compilation aborted at /usr/lib/perf-core/scripts/perl/rw-by-pid.pl line 18.
so there is no point to have a shebang in them. This causes rpmlint to
complain too:
  W: non-executable-script /usr/lib/perf-core/scripts/perl/rw-by-file.pl 644 /usr/bin/perl -w

Hence drop shebangs in them all and remove x permissions in the
repository. If anyone wants some of them executable, they need to fix
the install scripts first.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
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
 tools/perf/scripts/perl/rw-by-file.pl            | 1 -
 tools/perf/scripts/perl/rw-by-pid.pl             | 1 -
 tools/perf/scripts/perl/rwtop.pl                 | 1 -
 tools/perf/scripts/perl/wakeup-latency.pl        | 1 -
 tools/perf/scripts/python/exported-sql-viewer.py | 1 -
 tools/perf/scripts/python/flamegraph.py          | 0
 tools/perf/scripts/python/libxed.py              | 1 -
 tools/perf/scripts/python/net_dropmonitor.py     | 0
 tools/perf/scripts/python/stackcollapse.py       | 0
 9 files changed, 6 deletions(-)
 mode change 100755 => 100644 tools/perf/scripts/python/exported-sql-viewer.py
 mode change 100755 => 100644 tools/perf/scripts/python/flamegraph.py
 mode change 100755 => 100644 tools/perf/scripts/python/net_dropmonitor.py
 mode change 100755 => 100644 tools/perf/scripts/python/stackcollapse.py

diff --git a/tools/perf/scripts/perl/rw-by-file.pl b/tools/perf/scripts/perl/rw-by-file.pl
index 92a750b8552b..e0e4e23d5597 100644
--- a/tools/perf/scripts/perl/rw-by-file.pl
+++ b/tools/perf/scripts/perl/rw-by-file.pl
@@ -1,4 +1,3 @@
-#!/usr/bin/perl -w
 # SPDX-License-Identifier: GPL-2.0-only
 # (c) 2009, Tom Zanussi <tzanussi@gmail.com>
 
diff --git a/tools/perf/scripts/perl/rw-by-pid.pl b/tools/perf/scripts/perl/rw-by-pid.pl
index d789fe39caab..43fcd4823f21 100644
--- a/tools/perf/scripts/perl/rw-by-pid.pl
+++ b/tools/perf/scripts/perl/rw-by-pid.pl
@@ -1,4 +1,3 @@
-#!/usr/bin/perl -w
 # SPDX-License-Identifier: GPL-2.0-only
 # (c) 2009, Tom Zanussi <tzanussi@gmail.com>
 
diff --git a/tools/perf/scripts/perl/rwtop.pl b/tools/perf/scripts/perl/rwtop.pl
index eba4df67af6b..96ce72e53f8e 100644
--- a/tools/perf/scripts/perl/rwtop.pl
+++ b/tools/perf/scripts/perl/rwtop.pl
@@ -1,4 +1,3 @@
-#!/usr/bin/perl -w
 # SPDX-License-Identifier: GPL-2.0-only
 # (c) 2010, Tom Zanussi <tzanussi@gmail.com>
 
diff --git a/tools/perf/scripts/perl/wakeup-latency.pl b/tools/perf/scripts/perl/wakeup-latency.pl
index 53444ff4ec7f..f8b59f0bd949 100644
--- a/tools/perf/scripts/perl/wakeup-latency.pl
+++ b/tools/perf/scripts/perl/wakeup-latency.pl
@@ -1,4 +1,3 @@
-#!/usr/bin/perl -w
 # SPDX-License-Identifier: GPL-2.0-only
 # (c) 2009, Tom Zanussi <tzanussi@gmail.com>
 
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
old mode 100755
new mode 100644
index 13f2d8a81610..358438a648a9
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/libxed.py b/tools/perf/scripts/python/libxed.py
index 2c70a5a7eb9c..3ea5bb8195c4 100644
--- a/tools/perf/scripts/python/libxed.py
+++ b/tools/perf/scripts/python/libxed.py
@@ -1,4 +1,3 @@
-#!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 # libxed.py: Python wrapper for libxed.so
 # Copyright (c) 2014-2021, Intel Corporation.
diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
old mode 100755
new mode 100644
diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
old mode 100755
new mode 100644
-- 
2.32.0

