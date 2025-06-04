Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473481AC8
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749058597; cv=none; b=IQMUtElX7Hlt7/gMz5Zfc8OsDNcowo84839EHkNWt28ysJ02JZFMcTfr/kon52s9J93HpwY6DeTrzYQ52cn71HVITotO5eouOyfi2F6hKN6tkXK6JuUzzb/7kzSBCFEZjhhQ1++q7xvCYaC1c/Bxj5rdk5LeWdL3gjVHljAe/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749058597; c=relaxed/simple;
	bh=W+ra4HGapBDnhnWI6tSk/cIb8O9/vczqH+V+QKIW7Mk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=HpEpRhfpJTt518/19XVn9/kC1xLcLt8Ywo3XhX34frPLmzxNNj8wvPb94ZEcXv6WR1L7VMJUH4HqvykMWl/JVcbkyvZyjeUQJbSqgfB2Gf2r6fsgQXr6m5xZ8mGu4sTFRni+eqBaAfLxXN+JuZsqcg3kpdu/Czl5oluRR7uVXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zS3YHmwT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zS3YHmwT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso24338a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749058595; x=1749663395; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yH53vIajMohtaLTL0xy062uwD/Qg39kJdcRHJgRTCow=;
        b=zS3YHmwTSl39gZEbtZLEGx44T9duhe8EbNYzRS2QmZ5J8A9i4e3ahijrHtBwbvgngG
         VKoXGhHhMkERaVm0MiCMWas41IViecTtSF+T2wreKk/EhRXT8X4YmDawEE4ri9PLDFgf
         0AXU304N4giTjdQTzrZWoby1FQ40wEAdJTJWnWTx0xMd9Gf1nv6jw3os5rXei+a69p8D
         l1826G92v//b6u7CEkhpWio1fWzRVraN9UcxtQXWXkr6msf/PGYZV1nymi0Oiy6ehfbd
         btiE3R7RX6/dRoSZbAWx7YdrWnlgDX8w8oxosRbSGNpZVUCV5DF+NfO0xuxlYWxFZgA1
         Vdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749058595; x=1749663395;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH53vIajMohtaLTL0xy062uwD/Qg39kJdcRHJgRTCow=;
        b=RgvV8k00LuSHu3Q9I9iH6tV92FPjmPpKSj0lVjAcLrl8SRlqBrDtoQ0Yjdl/bEGsey
         seq4MbZimtNpyHe68kOVWuGl4F7b9MW5Jl9Lj+h873F9/M4L2mAN1fA01MBMK7ZxzEwZ
         ctEvZjukOc2Vlb+BUaqV5KvwXuy3mNRqd0IOBN0dLMU7aBBomySqyhwEvokIXUJXkQp2
         hszfByPfBnSxmOKcJV3PtooC7VJJgFKomHVaW5vuUSk/gdN0ka4BfQiBcv8wbmhtf6Qx
         JVw5CNb6enVtHjTCqiACktN+DGVVsGWEH4Ptb1Lhon/MAOODtHzDLVehEhjJueilQiwx
         6/JA==
X-Forwarded-Encrypted: i=1; AJvYcCUprAD1Okt302Ik6pXkmnestbAm80omIdVyp7Rvn6hgSuCqnYrMA8J9VKBGWUTJZVScCRXWO1GWzzmSc5mW396p@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOkAjVwM9neNX5KMCVBnocTWO4J41G9rqJQPwgdvR8dZLSVFv
	hUyvdibEhqW9fp/oRI8syjfqaPKkSl9cQzTrF38Znx2JBCH1bcg+tZiFWq/Je4VZgRBBH6WxJqY
	bXrtESw==
X-Google-Smtp-Source: AGHT+IGzuAdUDf81QyMjsbyBHOevok8TWD2sDKlL6MPGA6CJxWJGSBOSUL1PddzcyN3laNndUjrohax0x6E=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:312:14e5:174b])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274b:b0:312:daf3:bac9
 with SMTP id 98e67ed59e1d1-3130cea013emr5014860a91.34.1749058594837; Wed, 04
 Jun 2025 10:36:34 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:36:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250604173632.2362759-1-yuzhuo@google.com>
Subject: [PATCH v1] perf: Fix libjvmti.c sign compare error
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix the compile errors when compiling with -Werror=sign-compare.

This is a follow-up patch to a previous patch series for a separate
issue.  Link: https://lore.kernel.org/lkml/aC9lXhPFcs5fkHWH@x1/

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/jvmti/libjvmti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index fcca275e5bf9..82514e6532b8 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -141,11 +141,11 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 	* Assume path name is class hierarchy, this is a common practice with Java programs
 	*/
 	if (*class_sign == 'L') {
-		int j, i = 0;
+		size_t j, i = 0;
 		char *p = strrchr(class_sign, '/');
 		if (p) {
 			/* drop the 'L' prefix and copy up to the final '/' */
-			for (i = 0; i < (p - class_sign); i++)
+			for (i = 0; i < (size_t)(p - class_sign); i++)
 				result[i] = class_sign[i+1];
 		}
 		/*
-- 
2.50.0.rc1.591.g9c95f17f64-goog

