Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293634DCD6
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259723; cv=none; b=VLnHNXkZgaLfK/F419XBDmCDNXQWDaoM5R0nBwf9pR/a2XBIJzU5aA3pq0NsxuD7I2mOQwWguvYycdqvKIDZNdrOYnBNa7scpZXWR+eMp/bkPbPZFpKyFtK+7beqwZXLXzdU8JxNaD/YEG7JqWHl/afZROhaQGxs7G38AcaaHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259723; c=relaxed/simple;
	bh=KnVz+ZQ4K53OzLPmC0m9B+YkQhU+ZZrrrYFWq9RuXVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGm/7hg1B2iObe2DfryPuSK2VH7jbpn8tJStg0Orm1EHxgshNt/BHFTVkZV2d3TPaken2e0K8LzSG20M8UklTs4YZpdTtbZdQCYHZ5r/KaT45eSvSz6wFRnvCaNNq/KIFJEDh3NZkAJeFqyTwBuhtY7zVTRAkRXrByKrdWeD0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4o1LYEL; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4o1LYEL"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb7049fa552so715542a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259719; x=1786864519; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MeV0ZSvBtVgD5Gp7MiruC3I46JSTwRM70B0672DhJlw=;
        b=d4o1LYELuFVEeovBVk5WJDntTAWWY9bbl2H6ZYCa15euaoS3ac3Q09k2hrRIKj/nfz
         fcDYpZ2jCTcvfQnOw304xnEHoHA00RI3Y1zXuCH+U2DqeD2iUHoB0nx00BnDAhPnVudX
         5kYpbUneXupki5uC80Rhq8eYQFB5bK5txuZT4Vkr1J9F25mWNZpLv0ZAzmm9KTd/PQi9
         ylo4j/2o2ebyhu34/RieyMO26Rrn5+5zfduIgXgWFVqR2NMUNfCkSG8Ku+2GdqABC1zQ
         9rKclFMuLaWLtDjlFydML1kXCGxrhftP1/DXIibkK1lP33SFJMFNf4fJD0ycKmc7EV0L
         mVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259719; x=1786864519;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MeV0ZSvBtVgD5Gp7MiruC3I46JSTwRM70B0672DhJlw=;
        b=G1CKCckwSowFEnLYRWc4VZsFzmaciOy19ww3lM9RGpZc4l6+OilKkaqBSNHR0N2Gr0
         M91D50xOU3mUwiFk/dk1v//MnrO6MdWTeFjcIqJj9Hh/GVc+s2eee/HTmzBGNWbpweh/
         JrLGEm66Q/yH/FYbV47MuwX6387EFkYpkoeVTkqMKNWsMMszJbjViKFzHjI4WYAUl/7Z
         w9JRcC8sAtsV9w+0KP1XMZem0sTZSasAWYLrQ9Iym/8x54Dpl1YFuKxDosvDoclVX82s
         0dmzmCb5nud4qwt17TgxXBBeeYY6KJZkG1DE3A1mffS6DBiXwwqSHqKkhhcTMgk3twWQ
         Q3Ug==
X-Forwarded-Encrypted: i=1; AHgh+RpifNmv6NVNaPQQcqBRIIQac7J9c9VwB1HWDca0i+A/cS3Jbj3CYVEUBzqNXTRBMR3QzBQA9UEb7YfV2Qlqa/hg@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ061pfTfz3szljfCByAFFfKtWxRAMMQ5Fu4Va5mbDiSJykaPg
	ZemLQ0ezIWLRJ18EuFFNqYBYR85o3zARkb6GitL3xSHVT4AMq/UjrvQRHZNGiYveitYGCzcjv9I
	paqfnIFvz2w==
X-Received: from dycmx4.prod.google.com ([2002:a05:693c:2884:b0:314:7337:26d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9c15:b0:3b3:2703:110
 with SMTP id adf61e73a8af0-3cbada680bfmr26775661637.4.1786259718604; Sun, 09
 Aug 2026 00:15:18 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:47 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-9-irogers@google.com>
Subject: [PATCH v3 08/15] perf python: Validate CPU and thread maps in pyrf_evsel__open
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add explicit Py_TYPE checks to ensure the arguments passed are
actually of the correct pyrf_thread_map and pyrf_cpu_map types.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f64d662bd3ee..a1334400874c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2113,11 +2113,21 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL && pthreads != Py_None)
+	if (pthreads != NULL && pthreads != Py_None) {
+		if (!PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
+			PyErr_SetString(PyExc_TypeError, "threads must be a thread_map");
+			return NULL;
+		}
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
+	}
 
-	if (pcpus != NULL && pcpus != Py_None)
+	if (pcpus != NULL && pcpus != Py_None) {
+		if (!PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
+			PyErr_SetString(PyExc_TypeError, "cpus must be a cpu_map");
+			return NULL;
+		}
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
+	}
 
 	evsel->core.attr.inherit = inherit;
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

