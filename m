Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6516D9C3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 May 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106971; cv=none; b=L7NtiEzqph8GhNICxFVs+DjV7nJrjKaeqYk76qSqywIQzFXuv+fASZBodQx5hP6liPuJ0hTOiIBvo3rMTpIdJYOHoGF4bw1tjJibPJYkrEHeWhUi/xkQD2/fuZ/hEhJUXMyXncBUbARitHGNk2WnBaZIdTMINmSW8KuYN+c0QXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106971; c=relaxed/simple;
	bh=yi0IGqXPFHWkzbXpu9EOHF2YNWNnFamLHfIdbg0rgmA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=At56JUUWu8XdzKk4jQjHfhQd0/Z6bxfEhvPuF/HYc6bznAvHnfkAJMilX5uclCBBNXtLSIN5P9lSYbw4ENT5iyKK86E1LceZMs7Qk7SZt949hXWe09FKBpQuAZe/iZHbt8McnYyvg3RWVF9T3AjIgqpkfpL+4fZAE4/nVwdW2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvBeZ3Ig; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvBeZ3Ig"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c296333so458347b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106968; x=1715711768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAyKMenex+5IJfc1qyffLzQhoa2twNpQD9DTMrkElUs=;
        b=XvBeZ3IgMzbSraWpzC4SXqHxAJ+8KWOPUSLhnknV1nVdBYsyCthNUQlUwdQ25BJPDF
         8bvoCHNmJXQBhs7FLNygCaB4ENU4tVMDuNGYRj9xVycZxOQIwPReANoWhmXWadQhxCEZ
         TT+/qI2q/ok6RKmxHD9J585AhGFj29mlA4BkurJUTCNIVXybrcZtJDSFk1CC4snvZdEH
         hiVqJpX8pID1xdQquDLOfRKccKkc8uZbjEoEmM+qlCAjUHwgP6OiPQOZu0Hi9+NJ9IJe
         a32a3KtxqEjKv+rvPL06pkBZPpUJcpqL+TFCCvH0gz7mcLo0Y6xZm1mplWP1OqpNeyNv
         vLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106968; x=1715711768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAyKMenex+5IJfc1qyffLzQhoa2twNpQD9DTMrkElUs=;
        b=HtKM2f1bjLBNx5N9rveJf+JaNJchkSUSVNM+NkH53lpzT2GIaF6zboglg7GolqsYc4
         tYw/FiSVemvfj4WnyWAR0q2/bQbptQUsMlaRb5d89uNdSzDDWnNQ+3VEiXHJuPmAv5dT
         n/2wB5ZjvFcckjLR8icXgI/Pk6rZR87XCTffjM0r+Tq8lPSGvxwfioLKgeja9F7B18SY
         juVRlCswimvcYq02zIl0sPM9v24IxVcPVCaMvs7s+TVK65/xTnXu/YPVAzYHsQ+f6Js5
         bH97upe5dPrhCC1bxzyMcWpLklSMWll8yszpPfgZIoS4TyLwBdrLNuP26xaKtE78lHBY
         pb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLABF+xTACM847mTVfex5XTsLFd/Zz5I3OZKx3SDIKtE9ByZsY8SOUPTexKRTw3jx8YaZ86170f6rsGTiqFhftqkLR6GYFhfjJDTB66tp18w==
X-Gm-Message-State: AOJu0Yx5HtzAzFf9P7EDkNO243cdnVg7pb8YGRtiNudrCOcMDeGeaTqY
	WBMCJiJv0RwfzQBiodiMvUgaX1DX9kZbm6oVaFcbh42BGusc+rAOVq3tiMsrVh44duSL1TJFpvd
	i+nvvow==
X-Google-Smtp-Source: AGHT+IEFrS6qRkXP2QGeiHghu5TLySBp1SQLXJbuHHXRZt5Be0phxkIoQ4y4pZwWsNfw8wrjcT+hJQqVxhIh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8095:fd7:9773:b1df])
 (user=irogers job=sendgmr) by 2002:a81:a7c6:0:b0:618:9348:6b92 with SMTP id
 00721157ae682-6207652d8a9mr8590217b3.1.1715106968260; Tue, 07 May 2024
 11:36:08 -0700 (PDT)
Date: Tue,  7 May 2024 11:35:39 -0700
In-Reply-To: <20240507183545.1236093-1-irogers@google.com>
Message-Id: <20240507183545.1236093-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507183545.1236093-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/8] perf annotate: Fix memory leak in annotated_source
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	James Clark <james.clark@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Freeing hash map doesn't free the entries added to the hashmap, add
missing free.

Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d7d55263fc91..a83722f32d6b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -107,9 +107,15 @@ static struct annotated_source *annotated_source__new(void)
 
 static __maybe_unused void annotated_source__delete(struct annotated_source *src)
 {
+	struct hashmap_entry *cur;
+	size_t bkt;
+
 	if (src == NULL)
 		return;
 
+	hashmap__for_each_entry(src->samples, cur, bkt)
+		zfree(&cur->pvalue);
+
 	hashmap__free(src->samples);
 	zfree(&src->histograms);
 	free(src);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

