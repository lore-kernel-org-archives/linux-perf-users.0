Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CA189F30
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052683; cv=none; b=oKzow3adS5QLeT0pBrO/E1bbDVrfO4F5LgN/1XvdVJIjcx96PyKUGYBcLe4z1WJ269RqkfzOR2ew/CNYrVr198LdIoEL4UAdwmy1KDVplRPs+W/XRKlsT5Psmn8uSrr1raxwzEn1tE6jdMfweQuxEyL1IQDlw63nN92k1lTwiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052683; c=relaxed/simple;
	bh=bhHQDJnTJ4bocwSVO6+nzPhKgwvVlYSgBM/QGoZ266E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FDEN4Wi0rRlZmK1Iglf0guHMnQL+V90uTnqKtytOKMxtGRvAPKe3JMqakw5s/ZtMKH3PiZT5KiZdlspCEv6Sa5eBShJ8Tr4YWkjuAhu9S4WHFUuy3c0UExp3wdd6iQm3MMAz0Td95AaV7bnGbI1Oh5qGsmvyaRaZ8MrVtY8F18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvRHk3HW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvRHk3HW"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35d1d8c82so53835377b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052681; x=1729657481; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzM1nmvTrqtIbytQymy654+4zTDkQaKxO+Kef60mREc=;
        b=NvRHk3HWU3mKE3/g82sTr9qoxDJLo5p/km4krRReTHWNLSHm5GolMAVjasphZs1PkA
         X4OenCk0113XMBh2N1fKY/DZB1ijv8lVkFnaZ7KifSMrgwKuGv2KzyvfJozoeNPzQhnv
         xnXWe+UZwUGUV8SuqjXc4pCBXHc4unpXYmQJABJAUj0UPdy7yTOP8Dz0Gac7keTg7NjJ
         q/c2EryYcbds6qQhKs1xF+5CAL5vD3C2v/JGuPT2jv+DaGIvWeIZ5j6AI7x0rHZ2Mq2t
         wOv8UiqVd9VgdqX6+6GKS1PTjd+WHtk2RkIX+f7NXwcfGsW8kce6U/A2L+Av+tVQdVpP
         NyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052681; x=1729657481;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzM1nmvTrqtIbytQymy654+4zTDkQaKxO+Kef60mREc=;
        b=nkzE1iqleYkQ3oXa1mFGNn+esikryR+v2Go7GKvFZlDyPuG/hmwJ8PcTr2ttejMH92
         Eqpt98bwEKJPYT5iAQbpVIpZSQ+jDC7OtcvV97q65SOginWl6z/1FGEPtarT40FOsGls
         zKW5YpzMBNP9iwZbsNgxqQv0njvoFsRJc+hWAPFLY12e3PkUQtHBJ07WCTftqeAmuorW
         /8R/IljDWBkrZnFqkNT10arIUubR8EqrOsiRtq2LJpgjWmHCegAESCZR29o7+ij/Xknt
         CCdd7/TBfSd2Fdubqkj9NcjG66ZhB5JuFmQSBbUSm7er51O7AgYY1rg8ETu0Y6XOPBaQ
         Meyg==
X-Forwarded-Encrypted: i=1; AJvYcCUgnwyulUpcT+Ky2B57fJ8V6vfS11aSjYgaUVCISCTctISa/HRp2/uZ4bIcX16V5H9/XA+t0Gs2RhLFpCxBxAm1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HYHQlmnLR+Yw4ncxSE2n4+xKjvdKv6tW1BlfFe+E/nXdcdj5
	+AhTIB5Z6x2QWcG6Kl8bBgZyUtqfCA1sj3pQgHbM4NMLwZsyeChMAGEwvkkO41lbVbcts7Q29eq
	OdJKLow==
X-Google-Smtp-Source: AGHT+IHj/KEQGpPTZ4ugd9O5Z+R4HSHPtTwcD6Do2ajnxTnL5lk3DXKs7OIutPqYknLJgG/exImnYAY0f88/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:acce:0:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e297859d818mr2423276.10.1729052681221; Tue, 15 Oct 2024 21:24:41
 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:02 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 03/16] perf python: Remove unused #include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 13dad27169a0..974578a04099 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
-- 
2.47.0.rc1.288.g06298d1525-goog

