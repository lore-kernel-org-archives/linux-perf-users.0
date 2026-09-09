Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CE422E34
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992462; cv=none; b=ewRnYT5YWORS6YQ7O7xfCZoTqwHc12JxurnHQwangMk4g9iXcSmZndfCobyKsKTv0JUAIno46/6GgsOscuwm6RVeb9ZxHNg57pEDSE4NB2hQXZtGJoqsAug/td0s/9W+90iyRZok2moPjxm73NsTbzyia61iDj7MC3ax27ilJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992462; c=relaxed/simple;
	bh=VZ+QrtQv7xI7B3IQVjbQxMe+h2xaBR/0SDyIoRVpkXI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gwi0j+9Ieen+KHQcTrZNI+VFAC1MiR0wp2Ldgq+kxOSIMfMPyieGfxW0vGGqkkVdDT5gTc4CIxpo+dhpgPqFr68C57WSmcTc7KVJFaK+A/Qu8pCQmg/F4/7uP5wzBpyA9T0ilGmRJXKwviOKoabjbUjj4kl5wnDBljXlcv6Usqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Duea4WIS; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Duea4WIS"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so7902353a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788992460; x=1789597260; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/mH/R/7XHDTfSxv2g6sI7/hAPq1nkMVsTHrzOC/yfi4=;
        b=Duea4WISySCnIOFGZe4xAs47wZ07Pu3VhQGO1yxGKRK03wGHN16w1ZS0WjmLlVJcor
         UvuYZXWEoL26locoZUpaGDtf5JpMZVI6XG1qkSr7RhdXf5lHafbQVMlXJOqkDaj1dCJZ
         xvmHdF/0B9XXCU2uf21sUAp1V/bizc+wb7c/NbVbGXvM61kVSrBiChvVt8DQz///prVy
         TDWPAxaglICUgzJO7qVjmKPwLdc/APMS/69YyaRgrY6BHZa1/PoVj4k6bwnVcV/5ybMs
         0d/rtMrrQ7/LEizzuSV09nsCT0SdcInOq2gCXmVieKc7+ptoS1iofmVxQODNheHxTi6E
         iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992460; x=1789597260;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mH/R/7XHDTfSxv2g6sI7/hAPq1nkMVsTHrzOC/yfi4=;
        b=SNfnsn12GLZd6LJSidHOO2NAcAlGK4u7QWazzFMgRqQMMpqOin3epmM4WO6mBzajmG
         vlvLHXvZKNHntOxA6n7MB/53YhP0QyR5jGDDJnm+Q8U/dNylGpDWYxzou4ZmhVXYdnK8
         I5phO37aMk/Gr9cKegOy1uh7GFCsfvlStDPrAGUmocxWilAe+M5Aoy8nmD4KJCE1Hr8m
         UMMpczTcrdplvhJMKTidH78TsuucxhZ3HIVlr1S8N1nNGfWflyF1SS1ARWBOXEm/Ec2E
         2mzOLiAk4mGy8WxILZJlbAWMRSkdGZ+suH/QuZAfXAzfEo38McsJ2XI90vBXzh63i/Dx
         Mp1A==
X-Forwarded-Encrypted: i=1; AKwUvByAcX3jI6kOBcVf6qjtzrRFKhSORMq2P2H03NxZla8SGuurEQ673xyV5vS13NmpzQJ5oU6jLkzhcB7lRZ0k3n6e@vger.kernel.org
X-Gm-Message-State: AFuF++l9yoEgbCrshTNIEsBOv6wrLPZbQ0CvC31oluX8Z9qcUnvLA8jd
	NAoVuYN9JvWfpQcHJUNxhjxKX5bpDonqOdjGYRhofDcALtj3Eh+r+HpjdB+F6/8BRLaSqGvqL2i
	WkRxA+B/6XQ==
X-Received: from dlj39.prod.google.com ([2002:a05:7022:527:b0:143:355c:770e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264e:b0:398:9bd1:3215
 with SMTP id 98e67ed59e1d1-39b262e28cdmr59756112a91.22.1788992460252; Wed, 09
 Sep 2026 15:21:00 -0700 (PDT)
Date: Wed,  9 Sep 2026 15:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909222048.2138387-1-irogers@google.com>
Subject: [PATCH v1] perf test x86: Fix missing __msan_unpoison
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__msan_unpoison may need the sanitizer header including for its
definition.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 99d2b7ed016f..3c66dadcab75 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -8,6 +8,10 @@
 #include "debug.h"
 #include "tests/tests.h"
 
+#if defined(MEMORY_SANITIZER) && !defined(__msan_unpoison)
+# include <sanitizer/msan_interface.h>
+#endif
+
 #define STACK_SIZE 8192
 
 static int sample_ustack(struct perf_sample *sample,
-- 
2.55.0.1003.g10538fe699-goog

