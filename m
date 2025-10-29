Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FA2F5A02
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716062; cv=none; b=t5PmohtNO//kmwwOLG+i4KJnG1SZYmp5KlOi/p4dTU6bEUqRVuKj2NHHgkP+td+saj+vRW8dxnFgoyt8ZqpAdfQ9zp4WYdu0JW8tLnLUTt4ghKtEp4x9kupzO1f8dTPORbn9F8r02aa4lI9O3WMiVSnaCE/QiEMzI51lLCSk+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716062; c=relaxed/simple;
	bh=542/UtxOs4wTeyeK/jKTiKMC3a0OqaamQ7WTLZorbXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=B+C/G/MywYJT15vkMtQvAJg32++mCHor380A91EAkaZk/JeMzlpSNCgj7qMLN1xa5D63uWH1oMjQhWV1CYyikir7hV94WQ7mKVuVcVJCnwx8JK4iHvF7N7pyxXOfFchQuMk693zMmonm06oppEbyBtuxOOznvFXR/4iIyL3C4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpCqOpLJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpCqOpLJ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so5258195a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716060; x=1762320860; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT/10oAHeoVqquR7dMAlDMAandjm5/1/h+dRRja64wk=;
        b=gpCqOpLJptVWtCUgVey71DcqCGHQWN7wb82UQ5cHe18jAMpRiMmX0of2pj9S/XmPza
         2TRouYgtzcytfbuatUNkPYvURB2dxEdAAtMCdqRGPXehjhTmUPTG86LdW0zcuw3x/uD0
         adWPdOWwCnK3TB6tkQ/JoV6DhJLTEtkuUClcLWPqBOgSZuUWg3n3xEu1pAyLiu7nbBk+
         QqXuZeiMY57zIPGXYPciNJ3QS+KAynH4vqlo0d8osltWPUQy4eW2jkoABQCFriox8yj3
         HIhhKaEJ8TLN7+IDAUMgrqM8tb2OAXO5M/8f0QiVSj4XDANoudlneSKrQGRlwQtDprzm
         8hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716060; x=1762320860;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT/10oAHeoVqquR7dMAlDMAandjm5/1/h+dRRja64wk=;
        b=bop2G+9KSDSiO8XQRTu9wQmuSKJBZStjRq3OytH4/qWUSw7jfGb7wjYny/MdI0wwB1
         oaY/VuZ/q3W7eBaF18MPr97bZ+uebDc0ldUDpewf4dQb5npHxEIC2KT2u3p6KmtlNs3J
         n0S5NP7HmqNuUXDKlBxCvZuMyD9L1v8kAHbdij1Yd602Sc48mRpbeUyKc+HMT4ZHLVft
         1O2Uu2u1Wbdv6+zrOLtvAV4AIMmakoMTlQ2bgl6Voiq6wVTvOYRcfH2Q4oSZ7yTPdzPy
         PfchWyDlvPdEA8HoGwcDzxfoJmi/ZeXGz/UDUYcS9yPUzsm8zP4yOC965KhUzUKmgE67
         SASw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4gXwkDZTn+GVgM+pK2dgybMjwYCxQhDcyzfn4Qo7+M3QO3qw5eVr61QRZ1o6NPJpk2LkrM/H8JCdNSsPGSGd@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhevbNNRfBfi5gIdtyLj/fHXTbACsGb6IvB3RLH9ioNrloCdc
	BBB739EESf0De1Nzao6H6SZiZZkcjadghOmB2nbEzHZS/kHjQm1gQHTQuOq+fu3mN5ZSuLpNdAy
	42TasobHjEg==
X-Google-Smtp-Source: AGHT+IGOe4Pb1dCo9z9D62bEWfA3YaPeeB5O76SErHIJqTUTT/xA1otwE4sp5XQBWkdyM57M1KRXD8ZAbEho
X-Received: from pjbbf19.prod.google.com ([2002:a17:90b:b13:b0:330:8c66:4984])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c4:b0:32e:59ef:f403
 with SMTP id 98e67ed59e1d1-3403a2973a4mr2030947a91.17.1761716060242; Tue, 28
 Oct 2025 22:34:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:33:59 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-2-irogers@google.com>
Subject: [RFC PATCH v1 01/15] perf arch arm: Sort includes and add missed
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

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f4..a0086ca8385b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -3,10 +3,14 @@
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/stat.h>
 
 #include <api/fs/fs.h>
-#include <linux/bits.h>
+#include <internal/lib.h> // page_size
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
@@ -15,24 +19,20 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
-#include "cs-etm.h"
-#include "../../../util/debug.h"
-#include "../../../util/record.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/cs-etm.h"
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
2.51.1.851.g4ebd6896fd-goog

