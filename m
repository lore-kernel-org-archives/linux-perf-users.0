Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567C2DA76B
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514179; cv=none; b=mib+2ParHBPbhpPbgYadtZscwdfTpMw8wse3/772ZN6km1WR+VDmnkwtWxNbXxaRGzrjas7rN9LnfHMZlndh91VyNAoHiSdFIk2+7ArVhkkPawdqywyreZNHtoMY8WNSB99+y4Z2D+CxyDDwTKsS66nHXidgQ7A0Duw94VT92sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514179; c=relaxed/simple;
	bh=mczsFEopVF9Nf3Eh6gcn/ks9momGug0VWCsPbGNJHcs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=u/R+WEvGplakhNccuZEaGKuwIH9j/4BfpZXFe0qRooPprAcP/viWLeodg/cyMXa/QWlV8kzp9HSnnjcUIsLq7Afpt/3MXPofG3qfq2GvP3tR3R1UcFS2mxFYWM1cFO/TFGPqfOqtBGAJ6eZmAae7amXYSIDwPpQRAViaNqd6QLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bje+rQlC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bje+rQlC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-781253de15aso4499169b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Oct 2025 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759514177; x=1760118977; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9kHANUA1oW98B2rv+eoU9hlrfnQq0vAOP1H1ZwrBOU=;
        b=bje+rQlCjBB4a9G6WYN/vSg3MsAUMI6fsR9ocO63uhr3saayDots9f837/J8V+BnZe
         PlvUNn5x8hscR6YpQLoKm3adf9Y65B6Rm9MBaP46inRfVnimCJE3/SNSshBxmVcKtZSM
         iVizM4ee7/TXBHS92xSDMEZv8cDkMEZYnHUu1ULqjYC9bSJqWK9YwevVBKzcU20p0LoC
         sMWmlaXAWfq67leIzO8RmP0kmVzlMqb5RVskd180E9OQEbuRbSokB8DD4cceN8UbAiFc
         cThzY3HyP7Wx84tiLqf+9tFnyximd0w6NzG5OPPcQ1MPplRrVk9xY2vZmuj40H+fL1Rm
         KDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759514177; x=1760118977;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9kHANUA1oW98B2rv+eoU9hlrfnQq0vAOP1H1ZwrBOU=;
        b=Mi6Bj/RaiKlGRz8wU4DDflJ97VLh3qF+M0rodAJALIKBUJsQm/xaWFZ/lt3zoOYe94
         6/uhuW8d8iAp3/zD84HcB56gPJhR1hW+aMgT/jBdDGWl2JETIy/kzu+j2U4oUnzIFWaD
         1vH8v+IMgJt5H6e/y+/cFg7zv8cyRqeoyFh0MNBhqhYWyGclDXUTMNZAGryJmkO1dx78
         wdrzC5i2GK9ILIGGLi7iH/7/dMKoKZwMIfRNtVxgRZGNopQVISgJGTw+4MW54FyIc6i2
         CSZyaosmvFghA040U3k6OIIbk65De9RY1RRZmBTdsb3ybHWHeN6GPfW1pccqOBqXnIpX
         7CZg==
X-Forwarded-Encrypted: i=1; AJvYcCVpmS345JjYKZrY+Fhx179jD+O1AIU45mTosJkLdyOTF34d7Fg1+TJC271jAyuPtTAkddxp+YixrIEkRpgPVZGJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bRSjLCTvKEB404zAtNjZtEyC9fbhpnYwKs6kWugSLk9XVduQ
	bFBanVcQMPAgmSzWhYsfAVLkh1p0i+cuj8Dod2lnsEt2V6h52Z1p/68zB3TRU4aYYe9mISyJ77S
	ozsZtVPWgow==
X-Google-Smtp-Source: AGHT+IGK5DjimV2qy9GjxAU8ZDs57rl0GR5hN/1Bai3xrKPzFU+iuKgrRk60P0+uZ9MVi9V+s3neLlpTMpri
X-Received: from pgac10.prod.google.com ([2002:a05:6a02:294a:b0:b55:794f:64bb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94ca:b0:2fb:8392:5469
 with SMTP id adf61e73a8af0-32b62100051mr5227315637.54.1759514176762; Fri, 03
 Oct 2025 10:56:16 -0700 (PDT)
Date: Fri,  3 Oct 2025 10:56:12 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003175613.2512296-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf namespaces: Avoid get_current_dir_name dependency
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
v2: Fix free of oldcwd on errout.
---
 tools/perf/Makefile.config             |  4 ----
 tools/perf/util/Build                  |  1 -
 tools/perf/util/get_current_dir_name.c | 18 ------------------
 tools/perf/util/get_current_dir_name.h |  8 --------
 tools/perf/util/namespaces.c           |  7 +++----
 5 files changed, 3 insertions(+), 35 deletions(-)
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
index 68f5de2d79c7..01502570b32d 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -6,7 +6,6 @@
 
 #include "namespaces.h"
 #include "event.h"
-#include "get_current_dir_name.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -293,14 +292,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (!nsi || !nsinfo__need_setns(nsi))
 		return;
 
-	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
+	if (!getcwd(curpath, sizeof(curpath)))
 		return;
 
-	oldcwd = get_current_dir_name();
+	oldcwd = strdup(curpath);
 	if (!oldcwd)
 		return;
 
-	oldns = open(curpath, O_RDONLY);
+	oldns = open("/proc/self/ns/mnt", O_RDONLY);
 	if (oldns < 0)
 		goto errout;
 
-- 
2.51.0.618.g983fd99d29-goog

