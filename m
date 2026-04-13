Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869A1F0E29
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043355; cv=none; b=Texl6TPI/NDBuzYjyxOpiBIipjSDt/2KGdzsKtIufoiuUppYursCeowDxxJx8TcnqUGB0nMGsJir8SKa5GLXTmGSUbNKLCsTfoRiUQ8FPL9U3AsD0LqPkw7aNx+l2PZOGQut20lKJvnKv0ZMylPiKSjR2Bs2W6bQx3XdWIiPvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043355; c=relaxed/simple;
	bh=n2JtyMg3dnFRI+CN9oMKk3aLsRiKCNqRLI02Htuc8WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1UDfNLKR3c9EXXEnP41eV+pS1f2cdGYO7L1FsY5nCT51H1A1/nte39NPLYc5fnLR5laIJIwoBLn8nN298tptKLlAzS40zZ//1URVbZmZRth2COXSYZ1m/EwsVtnQ9PysmcsZWkVSGMU96dCyDWgTVFcDywckqhMISD9aIDawjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaXdTP2d; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaXdTP2d"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0be75dfd4so39306455ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043353; x=1776648153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=PaXdTP2dFfpFkcqKDc4e0fEBlEEOwAn63rD/OaCM2ClfQ8ow8/ghM+OhBFRfT+WJsv
         4PMLZMebrSIbELxKkbnBnoHy/muho5uISqm2lIYJiGstZNXn8KIAgdgWpEIEtkmg7xa1
         aK0iH0cc7kfZA9NSyA4OEJcy7ceCyJNp7lPkGKHEoXYwoe/ondlRQiy5Q9lglcacr3N9
         BzxFHu/LO8B4ubrBwDcU70SXW6haVkIc8Qb5VUgK7G1B0oAto3TWlNqaXDuVJyrTsHxJ
         c/5IIgd4eVjPifVoTQJln0U+ckFWjsZZqcsSpjxoz7i22G9bzST7BECQlXZ5SeOPyrvr
         iUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043353; x=1776648153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s1x6GuiQBbflIgwRlrovSdwQa1IJTr9Kbd8z5gwHns=;
        b=CHjcfu1eTXB9VQzVb0f9sQLkjcscFbzpFdqDON/zFH6yGZcfonELI3yjuSYxe1mvNm
         TVCzo+PCZiJUaCEcf5l4pGEA7SokBwqX560cNNxprkaHybrWCjhbgQfI0rU6XXZrxI4B
         saqO05+CdQytkJpMXdA6wfEJqcBOaBSCN4Xpvgv2rXkYBuZPHs/vSVr64sk+WXcMJeR6
         ysS20V4YnHf1t+hisNGdgBAxfipWQqGr+sCAd2Y89BRPO24e2R1JmkZJi7JIyFEG6kyw
         TmjEL5Y5jElHrhnf4n4GVVxACOaJwzwIa06W9rp/I65nMcI4jBeTje0k8rOYV8tAeIIw
         YaRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8oatNQE1wIga9J8LBJWUZ12nq62+kDeWJoHCURT1I65mGgRI1luqghgpHt6xys2/sN6NadvGeKyes8WbTb2DV@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9NT27tlEmdJoYWOzjExkhLadhUT0sESTvrXOa0Yd5kJszLkU
	4Vhb9lfmK+sEPUGLZTJXhjaEwuK0mJjfBEyQGVkNWWzU/ndHWFvwaLB+c+9SXpq8iiZ/u8ESk8K
	/D5/ws5gr7Q==
X-Received: from plbml3.prod.google.com ([2002:a17:903:34c3:b0:2b2:4fcd:ced2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa7:b0:2b2:680c:2193
 with SMTP id d9443c01a7336-2b2d5a52b4bmr112820495ad.31.1776043352315; Sun, 12
 Apr 2026 18:22:32 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:21:55 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-2-irogers@google.com>
Subject: [PATCH v11 01/33] perf sample: Fix documentation typo
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

s/PEF/PERF/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index ca0c407c4423..e556c9b656ea 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -126,7 +126,7 @@ struct perf_sample {
 	u64 time;
 	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
 	u64 addr;
-	/** @id: The sample event PERF_SAMPLE_ID or PEF_SAMPLE_IDENTIFIER value. */
+	/** @id: The sample event PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER value. */
 	u64 id;
 	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
 	u64 stream_id;
-- 
2.53.0.1213.gd9a14994de-goog

