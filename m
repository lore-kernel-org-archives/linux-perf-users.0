Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B63ABD82
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259729; cv=none; b=rrsOZYTQHiILHiwE3aOmhF5WBop17UqltQX/0jb2hD9d7f/ossDlMK9iTADFH+2anRASG2EJHJQXMFfhwz7D1W/k6sUrMnAwZjC1IoAfE/NU4W28ga+YLdzwwwNHtZgwpxNZx4mu/DuOfFJoNwWGtDccj6kRsuJzjRJCJnzDX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259729; c=relaxed/simple;
	bh=8HU33RKfiVs/du4nYMpaPSdKEfzU2ZUkgOw7ye5QfTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pDCLw/Dq9LRYfZNSqVoBFgOorYMfrIBf67IpYeBNFv2yGG5LBKaBLMcJ5uVh4jsjIF1x3hb19Ve1FqALrT3hc9KwBa+gJlO2c0V7Jz9VfEy2Vr4+aTXFm6eEPR3TLhnpPeTCgXrqh00tMpz3M+SQgPNKEEOGe/+hHHMTTKKc8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPvGmydc; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPvGmydc"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38827cee19eso1345585a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259722; x=1786864522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foLiohl07cPKDmG5J/n9MrGxXXJ6d32JUXR7ooRzHEE=;
        b=UPvGmydcNI/f5h89hb3RxFJZkfu0QG2b/wjOfaSoyLew2+xJ5FuK68SykhaXhvfM/C
         m/JTKO8jZmIH9hSXZgB7tVTSvC7N+136KWi66gPXgv1563WB42eJsbZWS0TNROpsU2Ho
         +JjZmgc5nBzMJ7KLUozNaDsOOQMdiD3T0L9HNGsWUCgb2+ZE5r0RXBrB/Oe1BeVNJi3P
         38AgU46vAD6FVZRSZLMwV1dXTMpiSQ+ZaeSWTQmaggG0fpfLGGPc2/AIZF4eVDVpnSjI
         aMHgdEdunUOpW2MmhDUv85UluUQDw+q4WkOd2F7w3zFQmX/KFqDW+hqhSm/hPYcbsX/f
         H8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259722; x=1786864522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foLiohl07cPKDmG5J/n9MrGxXXJ6d32JUXR7ooRzHEE=;
        b=L+CArDjtK3vV+IjJYd5rv1tJEY9GsPN8ZJz0PszIXIXpDksAZm8xCfuIZC7cQNBXhZ
         pKhF6eI2IBXgF4YSq7Bg6x1OoNNyaki05I6md6nUO+1Sh3NDe32UWvdEgmL807KzCS7+
         AppxTkxGkximjkkIEwV3204aQbl6i7b/EOMtWvgIwexpizunDRFrAJ1HwaMygjeTBPfB
         8xEI/UBubNSPzRaoSVcGrElP9Uc/KRvABUMwry5rq7ZYQRRfsxhgeMU4Orl0MYWXDiH+
         jreYVSOxgEPlaOONtmvlWLXkWPxkOT7eigNofj7fR8BKc2jDWWCzLqPSGJ2VKmSDtb9O
         zk3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCGL6nvQLoZDI92cpJ2/0kLVdh+qEUImIHZsUSnjXuYnhbQE6QSrOR4o+HtrOaArZVXJz51C942B6djPhMoQO8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Bh06iYTZzUNPuCLHB9M+79zeeZzHDBucLdPyMZjZcqmstDoS
	auds18qLvmoxyi/9eJVpbvWZ+BI5HzY7afo0R6gYp7K+E+LaXFrNl+LdotYhHyP8Xk6FARnlyNn
	QDKdzLbU3hw==
X-Received: from dldyr5-n2.prod.google.com ([2002:a05:701b:4505:20b0:13b:8a4e:e3b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288b:b0:38e:8300:af51
 with SMTP id 98e67ed59e1d1-3903c54d040mr37091686a91.8.1786259722249; Sun, 09
 Aug 2026 00:15:22 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:49 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-11-irogers@google.com>
Subject: [PATCH v3 10/15] perf python: Zero initialize perf_data in pyrf_data__init
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace path clearing with memset so the entire struct is zeroed,
preventing uninitialized fields from causing errors later.

Fixes: 4cd0142f7dec ("perf python: Add wrapper for perf_data file abstraction")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 848912401c4f..c70b151428f7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3,6 +3,7 @@
 #include <Python.h>
 
 #include <inttypes.h>
+#include <string.h>
 
 #include <linux/err.h>
 #include <poll.h>
@@ -3627,7 +3628,7 @@ static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyObject *kw
 	if (pdata->data.open)
 		perf_data__close(&pdata->data);
 	free((char *)pdata->data.path);
-	pdata->data.path = NULL;
+	memset(&pdata->data, 0, sizeof(pdata->data));
 
 	if (fd != -1) {
 		struct stat st;
-- 
2.55.0.679.g6767b8d81c-goog

