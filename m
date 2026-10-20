Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514225;
	b=v8+KQ2A8/pU6QOH+hADqU4Mw8qAy9fmYvzgWIqj49uSiKFe6pGnMvo5/uWBFd4fKYQx5
	 j4SkGONOCM2Eb/LLY9sGPp99BxFXE+gdIv+A0zLLr3PafqCYtcmol96CE7r42PH5/qQMt
	 HIugNyduTAHQ4fGktOFpuhIqcm92l3SwFeG+qkbn5wW2Y5+sekqODdgJ4knrUcF5/+KTx
	 7ylrYulPjUnf86u1V/zgOB54qHT7jf8JYoQq3j4UkquIrYCTXI7fKSNc6HgMUBOkm51mO
	 yzHOmbFIWj5rOxjKZs7tw/MK7KueSdOUBd5EgQ1+WCyZaZOOaf5+SHCCZI7OBa6w6mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0AxmQfbpaXJI1ahn+7h0PxdePVBkvh19toBGNbRn6vg=;
	b=rxD9nsnAdVKZshJf0McIMCunl2WzJBrk/hBodkzaLUiIaw85cL8ix1xNOcfRN1uX3DLM
	 0Nthoyjlln9fnA1VspsqrnKRrZrbJJCUkK6IyTq2hnvwS5QyFki+kY1njUYIDfdFXN5wO
	 iACc1e8mwl/p9cbr0XhOBj92GA5wyZ9w0PLCgryH1j+Ht7KIApJnfSyEetW+WMhysXhvD
	 LVJ0iqONGso7feKcPJlBzhrvWVWzP8nwdNVWK8W2IMvwKtkz/ta02WJN4U53sTM05wbUp
	 m+ShESh2FVU0ocq67NFqm2vYzZWC01/T3YjWRhgI+86mvT5AuVq1aCY2+zIGw/JuFJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lmqxFWvs;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99A60A2623
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B99A60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lmqxFWvs
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36637676140so1430805eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514224; x=1793119024; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AxmQfbpaXJI1ahn+7h0PxdePVBkvh19toBGNbRn6vg=;
        b=lmqxFWvsSp57HP2++rKI7yIL+dboJRu+LA702QljwoE4+cKIaeBSF+Ql3iaaDQ4sln
         DHk8EDK4p0gvKHGiO0jt6hZQc8DCToGNCAJx0OHdeqO2fE2sffeo89Eu0bnFCXAHHzPN
         Gla/N1l0fZJhl6Gn8fzaTftvcu6bx6DtX4fN4BY/K+yX+Xu+ZjFJ9o5WegDn30JHVXLq
         32XHuM5IpMbDKtCirwUK6722nSAhKEJ+oI2GxLcg1Xh2KrDj13gIeEp9hAOPVZbS406m
         H+jGMIw69dRLAlhtzKqS3wA9+gcrRWkNuacuy4RA7kqO5ufT5SucCxzb01ZpUTWc8rui
         9knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514224; x=1793119024;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AxmQfbpaXJI1ahn+7h0PxdePVBkvh19toBGNbRn6vg=;
        b=C1m1ktxL/ZOdj0Zsy7Cqr9BFejS2xVPgKdHmGAYy26D3lEBgUhkRqkNuQ/sGJbFItM
         EgS0dUxIzuJhXgzZXFKwzZbk85oM6lqGtLWXyyoF+k4iVKg1V6xuFoSYdRBkhuPienGZ
         nH5c5habnVvdP9/Hbj4YfaUASC7glodvcXG2+x4DDsFxRq3CYaFYGpS9Fz+wH+mjajAr
         2VTx19btnWaYnZVKDNvilRudBaYUkihSIqA5GGZopMzo2SImsWUPzRG5No8HSR7tC0+F
         9FddbZmoBhXzoMvWYyKdSmfbI12UznzKWdaFQp3EikI3JB7yiIOjU4kLshNlzQnA87XF
         +vYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9NgXdgO3deeC8A0YD/SqZ4WhkWGNsEbYVlwAspU4hMUpQJLWZNlvBrtKnnWuW8O5muLGtZGSw6njAX/PS3GNe@vger.kernel.org
X-Gm-Message-State: AFq9FYJGfMoNvQkfXHQ8aN14ZHNa2c62S/z7bHoGO8uaYlxM8trbFbqw
	Zs0aeTizEiMvTNTWpoDHKwO01eUeGMn2lzHK4kBlLFori4jikQt+KR4g+ChWeYEIbcpOeHbMSGD
	ErSaW9/PYgw==
X-Received: from dlbrl9.prod.google.com ([2002:a05:7022:f509:b0:166:1a44:a89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:901:b0:17c:393d:a0c8
 with SMTP id a92af1059eb24-1850c40d87bmr18319504c88.5.1792514223719; Tue, 20
 Oct 2026 09:37:03 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:29 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-7-irogers@google.com>
Subject: [PATCH v5 06/17] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 6343a3c9debe..9fc4e91a36e9 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
 
 static struct comm_strs {
 	struct rw_semaphore lock;
-	struct comm_str **strs;
-	int num_strs;
-	int capacity;
+	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
+	int num_strs __guarded_by(&lock);
+	int capacity __guarded_by(&lock);
 } _comm_strs;
 
 static void comm_strs__remove_if_last(struct comm_str *cs);
-- 
2.56.0.212.g129ede20d9-goog

