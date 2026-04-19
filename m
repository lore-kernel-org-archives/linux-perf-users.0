Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563331813A
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643172; cv=none; b=UknNhU0rbMwYaANzy+oj5ND21jwjkXnsIMNA7HF83uC26GPafjZyN3IZTFPmk2Y+AiS4ke5toJ3T2UFAId7RDAux0WGLmfES9dN2WjftKAXwXbCHcduMQTJbGvAP/drfQPwzOBw3UYNFQlka3cIMy1WK1pKqfFMkcBJR+gqppP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643172; c=relaxed/simple;
	bh=EOjWodN1ealXU4LSyylrNvfsI5MrA+gZSSCoXyy2fGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ql0SwPsXnicuvKfGc47mMorKZbOTzPu0+mWMYZfgL3mUB4sVpOK3aJpSd0lpiqFZ0MiSVT1CBw4vyvgHck0OUpts6PwrBy+/IxVSY0Vg/PZsrhHcBzQifyKpBxWonljZtk7Yu0b7hRxzf8L7Cu6sTA0h7JHRXfNnS3FvAGfWv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4sbwctL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4sbwctL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so2747666eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643170; x=1777247970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z57wphG6h3FTopmQlbsvx22PK3qfuqt9OgcgYj+0vNE=;
        b=n4sbwctLkAumDa2OFuV5JMsjJ8udv7ZNRO4ktrIiKpBax4T8z1dHhI+PzvoaIZDIJc
         fMLGbtJRhT+magiON1ViJIeChTmPt9s0WIakCt12Etx4VbUfGU0xrqd65jUBzi+xtkmP
         m7jAGXBvL8yVvTQqndwDSG/MMSu+8FXU4SPMoHkukY0mH7hv751fSitiM4+RzkwoyQlA
         9pNEvdlWVWlgQjvD7iyky4AgZ1ucpZP7XAJqItYSlyEdBUp17Og2f0i7JeSePZviLivK
         cj8lT3kXB5mK+RxUioYlxpHThz6g3Yh/dkdGXtEcJ3spS5sxIxq+UDbNQwR8FT2t4Bmi
         zVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643170; x=1777247970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z57wphG6h3FTopmQlbsvx22PK3qfuqt9OgcgYj+0vNE=;
        b=j7T8z7b8ryPGnsW4vMVyS4ozqdbpl+xiryTZh8+q+1ze0uynyPaJfqHj1bQGEJhusV
         A3rPhWZSw76ku3hNoHgH2WA352mBgln8oJ1bsu46cycLgOzcnAUxBNA599xL6QlHsoRk
         CVcPMRDNML1MtOQmPzof+2WjjsC7ingLPVY0pMc9rOKmpQFBXyudaEMJd1rf2jKRrwbZ
         k6fJSmQFCabm3nZbzNKYZxK8x2i6PPK20gJLbNtel4G1ZuEAZiET0lQIULZtH4borAfH
         9/a+XHM9lhDWpFkcqQyj3iAql2QBdInjNAG8Nd+gjUFI5xzfkNLBoIREdwZhDzwyQ7zZ
         BtOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZcbyoPQBE6B96MlbT3p0e7MlQ3KibvM44fjjCjEwfpwUlX7AYltYAMe0rG9MOazRgIzLR9/jfBxkn/7eD8yUf@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1xjX70epeLflcvcgzyAQTzEfqdsNjvq2xtYnhABDWAGukKUB
	ZvfMM1jqeJu37l+J45D0B5gqZsoIRRJ3sfIz0UyXzbVk1JCZCBDqxC8yqKUJ0epYlx4O3RLEtcW
	EMCAkaqnsbA==
X-Received: from dycnr13-n2.prod.google.com ([2002:a05:7300:e9cd:20b0:2df:46bf:2390])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6413:b0:2da:a813:a60c
 with SMTP id 5a478bee46e88-2e4786462fdmr5746415eec.20.1776643169663; Sun, 19
 Apr 2026 16:59:29 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:16 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-5-irogers@google.com>
Subject: [PATCH v1 04/58] perf tests: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c  | 14 +++++++++-----
 tools/perf/tests/mmap-basic.c | 18 +++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 4aa4aac94f09..ada6e445c4c4 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -1,15 +1,19 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#include "debug.h"
-#include "evlist.h"
 #include "hwmon_pmu.h"
-#include "parse-events.h"
-#include "tests.h"
+
 #include <errno.h>
+
 #include <fcntl.h>
-#include <sys/stat.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <sys/stat.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
 
 static const struct test_event {
 	const char *name;
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..8d04f6edb004 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -1,25 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include <fcntl.h>
 #include <inttypes.h>
 #include <stdlib.h>
+
+#include <fcntl.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include <perf/mmap.h>
 
 #include "cpumap.h"
 #include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "thread_map.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "tests.h"
+#include "thread_map.h"
 #include "util/affinity.h"
 #include "util/mmap.h"
 #include "util/sample.h"
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <perf/evlist.h>
-#include <perf/mmap.h>
 
 /*
  * This test will generate random numbers of calls to some getpid syscalls,
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

