Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F25464D
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452083; cv=none; b=odOESE97c8VfbSS/ZBD5Ij3JP25gsZscQs9rhchp0k7eqvhS272HShXdPWmv5g6jj53+/B/8jtkp89xpUcpVZ4ZHQbaG4fsfKKA4Vx0lykEhy+nuTjCh8EQctjtzMFDZ4YuQOSZF+ReR2vHaAZtS5d54Y6MWI9Ww5eRjPhWaU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452083; c=relaxed/simple;
	bh=3mDe7fpgcruxbDrX0bc5+oJ9/rO2+0AXTXV6A3h/n+k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Kgz5AogWtyYGqjhUQmfeHQU/JhYoFf7naamagTeeLe4I7bIazpyB5PiSdktYipupl2HXy6K7DUmT8++rK8JPuSUzpWqxD+e5yA8jKJoyfTx1yJMyasqyaR/11dWFZHOhyHBjLLk3NRwgJ/PG8ZtqStobQv0rm37WwmExf4AJYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8xHhWC8; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8xHhWC8"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso1581236b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759452077; x=1760056877; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XlVgG+qUcqt1ti4IWrjfI9WXkl1dtzgX2VnAjDGGGKQ=;
        b=g8xHhWC8cEKyL4LnDYPCCu+BiMTD120cbHvrH3KqLnx40F67t01wY7YMbaHBtixl4o
         WcQj4jCD2JzBzoHzJtO+Y6xoUry3k61ywbyF5kj6Hv+Qv2z23YZvsq6C4s4Ziwn76qXj
         CpXUrY7WfLnejabVpOu/+174tTQGw+F1mcrs3vmS/7EGDZid+CSqJ+ry5nRPbcD/Jf0q
         FXh7ewHk23Y435/ya11+9TpK2KmhG0A4tdhLdDD/IDGrA5iB29KJduEkUCJ8X7LvCugH
         SlOhxQTcZDkncUChqo5adRhmtmx2pwcUFdhgulvcMU0KKMYF/WeXU9slt3m0UOAsJSi7
         b1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452077; x=1760056877;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlVgG+qUcqt1ti4IWrjfI9WXkl1dtzgX2VnAjDGGGKQ=;
        b=fxrgkf6wATCMpRcluRyJGkU65ozHTs8fVVWcgN6heCLgx+3i1Am9qZfnk+qqYbyDWJ
         4Wb7gCnMNflloqwTsKTFNZe2RhbVNfwN3swV+TBn6mVg70smoxhKTHoxTsMWZ+sEEtvP
         aknp0YlimXbhOyQqY1k1e4gakVeyCAST7GZD3FI+noO4XPId1aNj086cJIfTJKhJIDwN
         gyNpA8JZSczgK6ZfyNm729/YEAuewVlOM4fglV8WWwySqfe5k/3lWANLTD8mXigMB7XY
         4Nsqp6nOkSWQ+7ad3KZHvADvqGkSmL3mzuMb2Fb/ilBNl/T5zm+DqTsEm6nYMsx/YPYB
         P5cA==
X-Forwarded-Encrypted: i=1; AJvYcCVymTi/+iihlYimgssUxhTZEBVqXKq1cwf1l4vKZTUi/ouCTSuDqg7uGUf9mXwxoXevVOwdMAa6a5SuJBKUJfXp@vger.kernel.org
X-Gm-Message-State: AOJu0YwCu2l+U2oifmkLxs5PS18NgBH9lOZMfrF5GA+EIvazEgiz1I2w
	GFtY4ptqs9Dvmuzj96QlWVz9j11MSxI2Tzgu+xGiamafudhw3CEIGKfzMxwUpkzZjziPoOH4nEA
	aneto/9Gmcg==
X-Google-Smtp-Source: AGHT+IGP0IJMW4X14mDo3SaF2DPNVjoOEPADwz8Mfq/a+u3M5w2WZyZ+g37te5WSjbUe5DeFJ/v/n2gwtua5
X-Received: from pgct8.prod.google.com ([2002:a05:6a02:5288:b0:b55:117c:84a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2450:b0:2e2:3e68:6e45
 with SMTP id adf61e73a8af0-32b6211891dmr1662801637.51.1759452077454; Thu, 02
 Oct 2025 17:41:17 -0700 (PDT)
Date: Thu,  2 Oct 2025 17:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003004102.2369463-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf namespaces: Avoid get_current_dir_name dependency
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

get_current_dir_name is a GNU extension not supported on, for example,
Android. There is only one use of it so let's just switch to getcwd to
avoid build and other complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config             |  4 ----
 tools/perf/util/Build                  |  1 -
 tools/perf/util/get_current_dir_name.c | 18 ------------------
 tools/perf/util/get_current_dir_name.h |  8 --------
 tools/perf/util/namespaces.c           | 14 +++++---------
 5 files changed, 5 insertions(+), 40 deletions(-)
 delete mode 100644 tools/perf/util/get_current_dir_name.c
 delete mode 100644 tools/perf/util/get_current_dir_name.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f4b297fbacc..6cdb96576cb8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -417,10 +417,6 @@ ifeq ($(feature-eventfd), 1)
   CFLAGS += -DHAVE_EVENTFD_SUPPORT
 endif
 
-ifeq ($(feature-get_current_dir_name), 1)
-  CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
-endif
-
 ifeq ($(feature-gettid), 1)
   CFLAGS += -DHAVE_GETTID
 endif
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5ead46dc98e7..9464eceb764b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -23,7 +23,6 @@ perf-util-y += evsel_fprintf.o
 perf-util-y += perf_event_attr_fprintf.o
 perf-util-y += evswitch.o
 perf-util-y += find_bit.o
-perf-util-y += get_current_dir_name.o
 perf-util-y += levenshtein.o
 perf-util-y += mmap.o
 perf-util-y += memswap.o
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
deleted file mode 100644
index e68935e9ac8c..000000000000
--- a/tools/perf/util/get_current_dir_name.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
-//
-#ifndef HAVE_GET_CURRENT_DIR_NAME
-#include "get_current_dir_name.h"
-#include <limits.h>
-#include <string.h>
-#include <unistd.h>
-
-/* Android's 'bionic' library, for one, doesn't have this */
-
-char *get_current_dir_name(void)
-{
-	char pwd[PATH_MAX];
-
-	return getcwd(pwd, sizeof(pwd)) == NULL ? NULL : strdup(pwd);
-}
-#endif // HAVE_GET_CURRENT_DIR_NAME
diff --git a/tools/perf/util/get_current_dir_name.h b/tools/perf/util/get_current_dir_name.h
deleted file mode 100644
index 69f7d5537d32..000000000000
--- a/tools/perf/util/get_current_dir_name.h
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: LGPL-2.1
-// Copyright (C) 2018, 2019 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
-//
-#ifndef __PERF_GET_CURRENT_DIR_NAME_H
-#ifndef HAVE_GET_CURRENT_DIR_NAME
-char *get_current_dir_name(void);
-#endif // HAVE_GET_CURRENT_DIR_NAME
-#endif // __PERF_GET_CURRENT_DIR_NAME_H
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 68f5de2d79c7..d1475b79a4a7 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -6,7 +6,6 @@
 
 #include "namespaces.h"
 #include "event.h"
-#include "get_current_dir_name.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -279,10 +278,9 @@ void nsinfo__set_in_pidns(struct nsinfo *nsi)
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
-	char curpath[PATH_MAX];
+	char oldcwd[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
-	char *oldcwd = NULL;
 
 	if (nc == NULL)
 		return;
@@ -293,14 +291,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (!nsi || !nsinfo__need_setns(nsi))
 		return;
 
-	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
+	if (!getcwd(oldcwd, sizeof(oldcwd)))
 		return;
 
-	oldcwd = get_current_dir_name();
-	if (!oldcwd)
+	nc->oldcwd = strdup(oldcwd);
+	if (!nc->oldcwd)
 		return;
 
-	oldns = open(curpath, O_RDONLY);
+	oldns = open("/proc/self/ns/mnt", O_RDONLY);
 	if (oldns < 0)
 		goto errout;
 
@@ -311,13 +309,11 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
-	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
 	return;
 
 errout:
-	free(oldcwd);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
-- 
2.51.0.618.g983fd99d29-goog

