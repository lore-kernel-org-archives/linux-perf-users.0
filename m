Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D524B1B38
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602433; cv=none; b=YqD6YfBGmKBahJBxrKdrRm1vY2zplzIU5wSsy1z/A8r2lhzEL0zNIdlsYC2OyyGUqL7snyzWHUODMTz7KsceVMuIVa8vp8f4SbDnCC3qBt/0xwMh8HOy6d7oCwLhH8wreIaCkRdF8Di1YYU9pmkDDeiO4CpeojkZw2fxeWrpEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602433; c=relaxed/simple;
	bh=UZ55NGTcp97BQR+TmJuMr0u/pEczhXj6Is+NLhu2rm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XgwmCnJFhzCeAyIUCjjx/kAmzk6vZ11X120XLiL7Ki3ZafbS1I2W9dQl5R2cHBqf2mqqPtL3wGKq9eNQIliwh1QW21yMEL/tC3POq4z/b2oGKb/Jlm5/wYibqnEQI0rgmy+Kij6vjS0NRKbsf1nkp8i9NMpvMknOGRZZeIuWch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YoZcrexF; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoZcrexF"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so266131a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789602432; x=1790207232; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jy7sHSnm0H1+CuaVoqaaQjFfYmAbppjdfLuWkEu0T4E=;
        b=YoZcrexFOl/y88cZOd73HUSYtPLscDwO81ZslpDXKD5qojUZvA2+3DgQZcFrKpRil2
         V3Aqvr7XmUEuhgsbbQAr6ibxaex4Lbq8dbPj/mYxjDCRVhpqrKiPgHDij3C+WvYP9L9x
         zPw7JJH9LxPmmiVCIdKWNSnN0upD4Nh7OxR9l6QCk6Vp26a1V73MHCNgW0d+hrd8cRWN
         pq2IbG7XEwuBYN8PjfQtZs8PnPFQesGiTXwygtIiLvn0G8lvEI4bJj6BYSN40oHRk4+g
         tooL38ljhNG3CBdGOi1wttA24cbgA2kY9lGCyewjDR/YGiqeuRYf6FsBMsAj2dNsm/nb
         +twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602432; x=1790207232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy7sHSnm0H1+CuaVoqaaQjFfYmAbppjdfLuWkEu0T4E=;
        b=N1cHCQY4m+N1LbbxYTpQ1hD4gLIw2V4hbB9AufHHrbxQxpnLkbLfLfMXFySVGXlUXC
         UqxUCKAJ2XHyt6gBdabPbxnDpdxCRWc1IwSbIwPQaniMgqiV42OMPXDOVgrflVotQwTh
         AalxtS8F1rtDi0g/QoBqmU/PGRiCbxCY2q5fKNImRaSEbKWDnmADjX/Vx6APa047tkt4
         YbTO0CRAGufXdLQyE/nn1PjY24T5m33pL0wzP3GoIABFj64DNEharJcmVX3Mplc1mRu9
         x4zI2FS1R8YWJNreLWslJTmxu2xAdngTAZMtbQyQhd+lsuwmLuWTh95ytxVTBbGXaMfN
         q1DA==
X-Forwarded-Encrypted: i=1; AKwUvBzfWB9iXTkZctVhiJEZ/pvGzQtWXUog6xvZk+A0UJtWqwR9utdZLPfnaxMujh1Xe7RalhV8tNqQUhURCGDRWKoV@vger.kernel.org
X-Gm-Message-State: AFuF++nT1Gz+CVQm06GVK88z0X3XIX11UsDZx9xFbLHYgiqODJGpOJGB
	9QzXTPXCe5eh7aSsq7LTUANfqLhVr8NxMPgcqWcuxmbz059SX/HOH7j7zzM4AM3GQ3kc2HaOi1G
	eQ9OJHacssA==
X-Received: from dlam3-n1.prod.google.com ([2002:a05:701b:2083:10b0:144:bfc6:f999])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a4f:b0:398:e86b:ce14
 with SMTP id 98e67ed59e1d1-39e1e4d045cmr10116962a91.20.1789602430803; Wed, 16
 Sep 2026 16:47:10 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:46:47 -0700
In-Reply-To: <20260916234652.439778-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916065248.3153556-1-irogers@google.com> <20260916234652.439778-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916234652.439778-5-irogers@google.com>
Subject: [PATCH v3 4/9] perf Documentation: Add tip for hybrid event merging
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: ak@kernel.org, ak@linux.intel.com, andi@firstfloor.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add informative text outlining the IPC imbalances associated with
merging cross-hybrid core events like cycles.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/Documentation/tips.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index ebf12a8c5db5..1c7b309fe6e8 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -66,3 +66,4 @@ For latency profiling, try: perf record/report --latency
 For parallelism histogram, try: perf report --hierarchy --sort latency,parallelism,comm,symbol
 To analyze particular parallelism levels, try: perf report --latency --parallelism=32-64
 To see how parallelism changes over time, try: perf report -F time,latency,parallelism --time-quantum=1s
+When merging events like cycles, different core frequencies and instructions per cycle mean the counts may not fairly reflect time spent in a function.
-- 
2.55.0.1082.g2b9226bbc0-goog

