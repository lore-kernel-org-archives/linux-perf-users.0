Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC12FB602
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716067; cv=none; b=Sj4w/HwwBx0YaYNVwL57WcxVKE6iUUeLGxya3y5H/GpScDUjY5v2OSDJkQT38OW9YtlzEjq8XGLe9NCKFEO8eyly0unSUekGCQ7J8ISyGlXr2hXVNhAQq4S8e/+0EI5AZUFKea0gFNzuRyrLXa3wKnLTmdo7nZkiTGPE9h2R3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716067; c=relaxed/simple;
	bh=ranWxnwVVnhb7a4sJ4cWUIXkpo3ejNkKQLJIyPpZgxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=avBYhdd/KDoX/eVWa8649AzwM3gM8Xz8EV5wFJJAp66AGCDCAcPlRs7g7hM7yNQxGAFYfunih+nHBYMM5zNRG0ja1Jklsr0o1RkjczUztgki6ncNrTwlF5pGh/eCRzBlYtNM+lswncrCIj4KF4PdRThFbzoq1jViA4Ju12gfxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3WL2ZOq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3WL2ZOq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ceba8968dso4934646a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716065; x=1762320865; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUkEiwNTcxutgH1681ccYZp/nzKyRF3IgBfM6aUXBnU=;
        b=b3WL2ZOqjnIqbPIbb5GAc+4oxjmIdlgyZ2ry0Hd2nNRlZZQL+7buYAJiwC8MfTI/bZ
         rFgIJKNU49GgGZfxEYFEogyhDEkLRpR+WmrzoN6ktlS75up0kaokpOfoVL2nPY7MeNT+
         UPRwvG1IadFmKAmjxzClcXmsfw3uloKh3KnWwaPICyM5OkcVtx3Kam3Au+pojGCWOLiB
         +dRyL81sMb1Yoo8BnhMtlBRmBWtdItnpOW66Ad4NSYm5+q6aS3H8Tg0CT10oF8ZrL9uw
         lq564lcR/SL8PisvS6ZmZAKXoDOJo1JiypaKS+d8qx8ckEPpA1jDN28qNUCeraxHZZMM
         oIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716065; x=1762320865;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUkEiwNTcxutgH1681ccYZp/nzKyRF3IgBfM6aUXBnU=;
        b=buRVETbjcRgYpddARyOEstaAbm7aaFhbsKjuSq7GuJeXoCs2TEICk58jIXK42sx4or
         rUANpovK8ylfok2TsaSwZcS2DwDrUVyiTmlVy94tzR8Wp2vMb8hsGZ3Fwqp3PYzXaBk/
         rMSbU1TVzY0ZtZidUAC0dptNCsiYqhIf0ORSue4/Y3atVfin22Hz5H2Xyve/wN1qB4Wc
         5BZok7aHi/AlIZT/vbCTzo6b3AbukqLaw4C86uDFGcVGTfjRUSntlvByNnU1oCvw3mT+
         vrntJhsBKqtdFdm1cK+RzjiVIVutcCfrZSvj9TxXUtBrWZlRL/qrO50IZS2KOMo5b21q
         Z8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvVnwhuKTBW882uL18WefRYs39sR1eG8Z3i4QIUco0LUHOeOib7KXAcFEvSjZT6p3/fO27C5hPDfcF4ZU5SN7y@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0QWyIrQs4hl6MogFtvmSZdk6Wo0FTGuB/rIl6MjnhRmsCZ+r
	1BJHQjrmWyApe65zozBTj9nHErkXu0x3CopmHZwjx2VSrmg3KqGnBkDFvoW6jSG2413s6Y+y/EP
	1eMCQUGMgtQ==
X-Google-Smtp-Source: AGHT+IF+BjckzF5VoiR/5cRXQMEHOdLbE4JXF2/bLj6EoYEqR1C0axI+NHBNSllDjqjUD87IOW62ah6aEKNq
X-Received: from pjn8.prod.google.com ([2002:a17:90b:5708:b0:31f:2a78:943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d84:b0:342:bf0d:a791
 with SMTP id adf61e73a8af0-34652f52eeamr2110253637.27.1761716065291; Tue, 28
 Oct 2025 22:34:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:02 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-5-irogers@google.com>
Subject: [RFC PATCH v1 04/15] perf script: Sort includes and add missed
 explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #include of pmu.h found while cleaning the evsel/evlist
header files. Sort the remaining header files for consistency with the
rest of the code. Doing this exposed a missing forward declaration of
addr_location in print_insn.h, add this and sort the forward
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c  | 109 ++++++++++++++++++-----------------
 tools/perf/util/print_insn.h |   5 +-
 2 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8124fcb51da9..6c3d98b51ee7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,74 +1,77 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <stdio.h>
+#include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/utsname.h>
+#include <unistd.h>
+
+#include <linux/bitmap.h>
+#include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/stringify.h>
+#include <linux/time64.h>
+#include <linux/unaligned.h>
+#include <linux/zalloc.h>
+#include <perf/evlist.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+
+#include "archinsn.h"
+#include "asm/bug.h"
+#include "perf.h"
+#include "print_binary.h"
+#include "print_insn.h"
+#include "ui/ui.h"
+#include "util/annotate.h"
+#include "util/auxtrace.h"
+#include "util/cgroup.h"
+#include "util/color.h"
 #include "util/counts.h"
+#include "util/cpumap.h"
+#include "util/data.h"
 #include "util/debug.h"
+#include "util/dlfilter.h"
 #include "util/dso.h"
-#include <subcmd/exec-cmd.h>
-#include "util/header.h"
-#include <subcmd/parse-options.h>
-#include "util/perf_regs.h"
-#include "util/session.h"
-#include "util/tool.h"
-#include "util/map.h"
-#include "util/srcline.h"
-#include "util/symbol.h"
-#include "util/thread.h"
-#include "util/trace-event.h"
+#include "util/dump-insn.h"
 #include "util/env.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/evswitch.h"
+#include "util/header.h"
+#include "util/map.h"
+#include "util/mem-events.h"
+#include "util/mem-info.h"
+#include "util/path.h"
+#include "util/perf_regs.h"
+#include "util/pmu.h"
+#include "util/record.h"
+#include "util/session.h"
 #include "util/sort.h"
-#include "util/data.h"
-#include "util/auxtrace.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
+#include "util/srcline.h"
 #include "util/stat.h"
-#include "util/color.h"
 #include "util/string2.h"
+#include "util/symbol.h"
 #include "util/thread-stack.h"
+#include "util/thread.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
-#include "util/path.h"
-#include "util/event.h"
-#include "util/mem-info.h"
-#include "ui/ui.h"
-#include "print_binary.h"
-#include "print_insn.h"
-#include "archinsn.h"
-#include <linux/bitmap.h>
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/stringify.h>
-#include <linux/time64.h>
-#include <linux/zalloc.h>
-#include <linux/unaligned.h>
-#include <sys/utsname.h>
-#include "asm/bug.h"
-#include "util/mem-events.h"
-#include "util/dump-insn.h"
-#include <dirent.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <signal.h>
-#include <stdio.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <subcmd/pager.h>
-#include <perf/evlist.h>
-#include <linux/err.h>
-#include "util/dlfilter.h"
-#include "util/record.h"
+#include "util/tool.h"
+#include "util/trace-event.h"
 #include "util/util.h"
-#include "util/cgroup.h"
-#include "util/annotate.h"
-#include "perf.h"
 
-#include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
 #endif
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 07d11af3fc1c..a54f7e858e49 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -5,10 +5,11 @@
 #include <stddef.h>
 #include <stdio.h>
 
-struct perf_sample;
-struct thread;
+struct addr_location;
 struct machine;
 struct perf_insn;
+struct perf_sample;
+struct thread;
 
 #define PRINT_INSN_IMM_HEX		(1<<0)
 
-- 
2.51.1.851.g4ebd6896fd-goog

