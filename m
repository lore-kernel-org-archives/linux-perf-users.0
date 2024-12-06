Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6F1D935A
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460055; cv=none; b=DFr8reS6AgJK0RfPZ3PXfbw4nelM0PGxQM8BUJOyt1GwBrbHSTvAuoWxWPy1VvBMzJ4nFOCAOWnlnt87pypMs7VY7umwz+x6Hsnjf/3FcVhfrOmY1BNz0Wqb09kJYUw0Jwdx4gR8BGvji37GXNQj+FD+tvc+0YML75acEPoUfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460055; c=relaxed/simple;
	bh=zAYbTToy7miM8tLMLMB1fAi9ERVwZv7WSJg6LoWxSwo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iVSo/DZVoRHIi5A2igomWWb1v/B6KZ/wxJ3eglaZpIoJyxKCSHCgyOqpbQ9ZpSpw7rx4n/sMCCPutwI1/kdzVeW8RItZdDJrIi3Wf+MzLAlijtazx432BKmESk+RS+vrvps4cIFWXgqJMUGYJkYxT5aejz+OCRB4R4xWYtVkY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xFSBuAS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xFSBuAS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6efebd97c64so307127b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460052; x=1734064852; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXXuS2o2j6xQTgeWYL+xQ1vIazksKTne/XbLVeScbI4=;
        b=0xFSBuAS59PoKkpftK1g3OnJdqM96MzP5i8UliVFoD/9WRAZFfTz2YJySTFKJgbfEZ
         w4E7pyWkF/sASTH1htbGOjXm7HlH353NgavyTfKoKQMszdi/JDg04Z4obSVugkTNw5RL
         0b6F4P5iJfN4gttFcyz6JfD5QdjUzddPWqyyQE5MZDAXerS0ABi0YvsRwRfUOXfetlTg
         3OFCDcP9A0aVnRVOvsZQ27HfdtjHbDOiB0m3XqmvpoTnOdtQq6pSq2kTqAIdJk0KE/gu
         IKJtJXQRG1KNNIn4hblkVhmwXSgnMe5ln73BFE+D81tsaJ52zEAGA2B/5W4htMymil7x
         oV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460052; x=1734064852;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXXuS2o2j6xQTgeWYL+xQ1vIazksKTne/XbLVeScbI4=;
        b=BtOEVw3UW6R95iITjQx4hatv8MNO2B6IciqVzejyE/7oHO3aFQFuJADnJSy5LR8cjO
         6B8478BiefoAfceQ23kR9y4CRhiyt7MdFq79gGbmXcUoLxA7SJ9rhZhnTSz3aRBL1ZuB
         GvVTxFQVVtad1vqpazozo6DCEh6mZfLGk/nFtspjYEob7s7jexoMNdNMD26EF/uEggsV
         4U6IRJR5Qs+hmOHGpxOkup28AkkpFU40xGki2D/pcIsQ2VVWWjEPYzY7fmXTHRMfSTSf
         JwSS1iFXOnfV5mHrcTd0V/sQRMWqdE5MhOOJUlzPtmTJbsGhOm9OOIN+PHrE2eGJ5p7B
         lsIA==
X-Forwarded-Encrypted: i=1; AJvYcCUuhw91y2dN8OOdtGCzlV3/dDH+t7l55zmgKbKWPhEGgmWOwqarBCRLB1JIMJ5rGR/qVFEf9TDKiXqLj7s9aFhw@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQNKiyTDrA0vkvOcBO+eJDDCrtTtR26rR41TIbU0VolCo91XH
	WKRsietrnxEajn1VSeNd5+w4/19f7vNuHdcmvb/hboXYxXdas66M1xRmiK63qUmcale8+VhNu4G
	xKZ6I5g==
X-Google-Smtp-Source: AGHT+IH6pJSsb1JmXS5B9BULKcXqWLb4MGTO9GRL3/aT9G9AWPq77Czm66g8jckJzv8epZvzw9L7H8e/LggM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a88:b0:6ef:7a23:afbd with SMTP
 id 00721157ae682-6efe3c83279mr17827b3.8.1733460051702; Thu, 05 Dec 2024
 20:40:51 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:33 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 6/8] libperf cpumap: Remove use of perf_cpu_map__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove use of a FILE and switch to reading a string that is then
passed to perf_cpu_map__new. Being able to remove perf_cpu_map__read
avoids duplicated parsing logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 20d9ee9308c6..60ef8eea42ee 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,6 +10,7 @@
 #include <ctype.h>
 #include <limits.h>
 #include "internal.h"
+#include <api/fs/fs.h>
 
 #define MAX_NR_CPUS 4096
 
@@ -102,12 +103,12 @@ static struct perf_cpu_map *cpu_map__new_sysconf(void)
 static struct perf_cpu_map *cpu_map__new_sysfs_online(void)
 {
 	struct perf_cpu_map *cpus = NULL;
-	FILE *onlnf;
+	char *buf = NULL;
+	size_t buf_len;
 
-	onlnf = fopen("/sys/devices/system/cpu/online", "r");
-	if (onlnf) {
-		cpus = perf_cpu_map__read(onlnf);
-		fclose(onlnf);
+	if (sysfs__read_str("devices/system/cpu/online", &buf, &buf_len) >= 0) {
+		cpus = perf_cpu_map__new(buf);
+		free(buf);
 	}
 	return cpus;
 }
-- 
2.47.0.338.g60cca15819-goog

