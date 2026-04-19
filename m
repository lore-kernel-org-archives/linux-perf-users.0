Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62065316189
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643167; cv=none; b=l088h7C2jq0piFIOwgcjF3jyVfo/ZwK2rFbFDVZaUuc2cTV3XWwM7k7U9Z6g9vS3ouk7FGZTx7JlkH2o39/iaUGiJYf+crjxksDzv/jckfQ7IlTVvXEUDgNTDSv48pNDOoq7nRn1m7RkX/oMRAfCkO1ypW7uzIKucTxv8qC65JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643167; c=relaxed/simple;
	bh=8YdsIi+S/FEDwD9WryhRWJVM6hAtcupOttD1zLCPceM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZfLtr739AHvrdES7DrmsYSifJClNUnjTTKKLDuc+qrr+VhCn67F8qjU1MxmKTsh41Xn3qxKnP9zJwIrVcAekIl+FsdpVT6eFwjSefd9Z17HtJTDiKsWQvdwvnAnar2nDPVf7CKYxQwN1U2Yd/Li9aJf2kjKiWwnVDuQH+VGJCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHzSiT7/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHzSiT7/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c66fdd4aeso3438297c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643165; x=1777247965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI5Gpu8lXaG0FZ/HphqCeNf8Wc6OME46zEQdV8lHLH4=;
        b=rHzSiT7/Tg9BO7LHDm9r6/y6kV216/Hi49JymLDzvGSA+E6W8SptRjLokxCLfYMIjK
         BdBcc9ShmyZT08JLkDtRa+DF6iTLteYNxtBNl2nV4hwCZ/qsku2hW7Xta94IitWGQ7rT
         J+WH0hk9nE7KAb3u/8jjKVx4H8xZ6Hu8yoCV68gz7HRMyhKqRbgM4jUThX1Rcc6BXTyf
         hChePK1Xa6oA7btjkbDSjW29a3qPL2ERnI8Rt/OUgYYK9ZQZOGaXvLUqQgW+Zv86IfbS
         7i+R9u0uQoiniC3iOpSG3VBUtmVDGso94OAMnbfIb8d8hdNUxYoRZI/KzWH71GIbFotz
         lq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643165; x=1777247965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rI5Gpu8lXaG0FZ/HphqCeNf8Wc6OME46zEQdV8lHLH4=;
        b=b5o2e7GkF/h2w6L99AusfJNCESPTMGbphVRFrd1LOSC2bJ6iyWbMVXZTlFHJzxwVya
         E9niGFAS4NPi/cCApiUww0zNizBQkUQkKl5AsUQa8ShTRDLkkTN3c12rrSMV1UZsPIHx
         L7XhnK4HLlg92TUJ+2FmZc/sg50+g3OfNkImS+aVDQkrhCnH91Zi5PC1JVZdm0I+VFdh
         IkyVXaddaDS/qM27+s+TF/zob7j7fn0R8g2AgibZrRUhU0vKOxCqX4dshGrBwB6qMoe6
         rOkgzngUtjWAa+cPCbpng+7WoTeuNpk1gExSWxQwNmcT9D9oLcyOWNQhSDUTSanp9jaI
         aZsg==
X-Forwarded-Encrypted: i=1; AFNElJ8iK/OCHqkYS5CI95uKWAqw9ApxbO6MUjS1WfMtHaa31Fs5GY3pCkExTWLvwBXzNvv8w5r/dWuxIwy3kSqxRAGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+l7PGaQPL3bTgWrwxjiS/g5OJY7RwbKieu0dpJJLSNHLgk/v
	fGFO/X5qXe64OT84QhM0LwGzeeQ88h+089Ul+cRB/nhC73Qb1bsDP6Jl/Oma0OW/EmRzXBu/Wns
	wPCuB2O+wYQ==
X-Received: from dlag4.prod.google.com ([2002:a05:701b:2504:b0:12b:e83a:8d31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac8:b0:128:d1c9:3633
 with SMTP id a92af1059eb24-12c73f7ce95mr5578894c88.13.1776643165143; Sun, 19
 Apr 2026 16:59:25 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:14 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-3-irogers@google.com>
Subject: [PATCH v1 02/58] perf arch arm: Sort includes and add missed explicit dependencies
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
 tools/perf/arch/arm/util/cs-etm.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b7a839de8707..cdf8e3e60606 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -3,10 +3,13 @@
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
+#include "../../../util/cs-etm.h"
+
+#include <errno.h>
+#include <stdlib.h>
 
-#include <api/fs/fs.h>
-#include <linux/bits.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
@@ -14,25 +17,24 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
+#include <sys/stat.h>
+
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
 
-#include "cs-etm.h"
-#include "../../../util/debug.h"
-#include "../../../util/record.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
-#include "../../../util/perf_api_probe.h"
 #include "../../../util/evsel_config.h"
+#include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/cs-etm.h"
-#include <internal/lib.h> // page_size
+#include "../../../util/record.h"
 #include "../../../util/session.h"
-
-#include <errno.h>
-#include <stdlib.h>
-#include <sys/stat.h>
+#include "cs-etm.h"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

