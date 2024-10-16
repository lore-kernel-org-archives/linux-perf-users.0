Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29E20E021
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094659; cv=none; b=aa78nek4vzIM9yEAq5tHqxRf5RtE4ODA9lCJW8cp86spJLOCQJl9K1EzoQq9RaHIJGdrrdYiv2lgxBzAtbX4hGm1Fc5GOubbteeHiCfcL35zQwpd+Pd+CffGUh8uu/Vi6P2gDgmCtI6F2A6x9AKx1Tuq8RGmrMFZXU3IxRYVqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094659; c=relaxed/simple;
	bh=rsrRjdXFsw1zqlE9yI9qOJKxcWh0+Zmduvrfpm+of48=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=I3lsGXkHK0d3Xq7cKLYnQKSprSyRtDkQ9U9CEhBQ4J54oLcRkhaUDwJWOpz+gXTuJmVhtOA7xDxzyzFI+GROwHf3H/iGu+ruT5H5u6RHwobSdt6bg7HH6D2nJXvUHQCTNwBm91876Ua1YS94PLKkntwh/F+lskmkTAByQNyVjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wY88EJA1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wY88EJA1"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso9288677276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729094657; x=1729699457; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSYeyjKcx92ZEc/VnHoFN/wUNlf5dg+yo+Qgoftk8gQ=;
        b=wY88EJA1Suyq8TlU6pzrs+waWa3PZD36t3bg3TZ1tisTaKhDAQ6fTBbi3X3ZiY+q88
         bd71D31QRH//zy193nfGJZUsxwtKPwZabzwjT1UJ7UhJtcRb240CdHP0pzoWD72VDU2o
         RaXpBslVz9uJEGSD6dRwfgMH+JZbHX9ZurJJ0u3EGvrw2wxGHzqqwTampc9pMc58eXhT
         LgzwKg6mPLeSv+RC+1i34u4QPJnWZrh1iOKRsyplYGXXC94iBDOAZDkvjQyKuIjLHBhS
         qASb5RIx3jfJjz75DKPcKLFoXBfgTs45fv/jAu1kNMNulvizRF0GSfznh6l8EoEcSGDp
         QK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094657; x=1729699457;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DSYeyjKcx92ZEc/VnHoFN/wUNlf5dg+yo+Qgoftk8gQ=;
        b=NOiOxdHPNNUcbPsUPV32lct17vRUheOJW1rUIxPvkuo9RMsZ5xMF45yBm1m8QKJt8a
         +MDiFu+FubClkV56EPUzDN+YwOV0jdF4yUc1MyLxe15pmE7+A98hMb9xo7fgEe6er3AF
         jrPtEEYergI/hO7UjrWpNL67XW9kAwFoVX2Mt3D+OE60QTbcnqkvF4LQjKNXxqUbFql4
         B8xJSo1lBQfFI/0OND4DOsh0QIyieFJHWLnkYA4ynblEdJ1EKrNImSa5QPtQEe7uYzd8
         yqlmwvJ1xjCcHjiKRtpm1VPvtQkLnmWe6yGFD6NmI1qxgZlxMhR+j2A4SCTnyjOYxwCP
         JuQA==
X-Forwarded-Encrypted: i=1; AJvYcCUP9xTjASqnJT0pc2hjgZdvpTbLOKg8JGkmPH0ybspvBojLKH6xyzhe/uXIB9TXMdGRunvzf6V4jGp5qxz16hWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhg932UIF5FO50OH34nCdWtb03i+vJ+vuXL1CSHmu5dCuI3XU9
	vnZwzVrxatt/+CLjg/zTS9jqM7H4jKVprUhPhZ7towZ2YtdCT2Mn0n6SG8D+Fdyg93BXcuN3l3B
	ORyQcjQ==
X-Google-Smtp-Source: AGHT+IFN9QIAUX+G7dHHxMOSStW0LKTyts98fvIunCBBIU8jmmsbmlo3lu+jhizVefZJsBO/7eo9xeApLYDE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:26c4:0:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e2978319b29mr2465276.5.1729094657082; Wed, 16 Oct 2024 09:04:17
 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:04:13 -0700
Message-Id: <20241016160413.51587-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1] perf tool_pmu: Remove duplicate io.h header
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove duplicate inclusion of api/io.h.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410131417.ynhvnEJb-lkp@intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index bd1cee643eb5..4fb097578479 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -11,7 +11,6 @@
 #include "tsc.h"
 #include <api/fs/fs.h>
 #include <api/io.h>
-#include <api/io.h>
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
-- 
2.47.0.rc1.288.g06298d1525-goog

