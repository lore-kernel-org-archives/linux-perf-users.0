Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7C287510
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278155; cv=none; b=hF9gYQKmOJm1dazgtM0D9o9fsF777QorX26fMTaifkjuIlSe0ItZW+FWxBU6Q9S0ByKQnFRjTUOCezJX1eKohBNO2hbG/lmYw/dmHcYT9p0IG+3ByXW3VARBJWBaCEot8fIfVnj6QAeXR5fGIEbUgCCW6QHfCb3jm97I+bQN4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278155; c=relaxed/simple;
	bh=PwoPa2Vs6Ae5eSUNGE0hqb+pLO/bfr5LvoIZnko5zj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ODHxxLzOpIQk6W4MQDqN6n1HEcxB9dqQgaKJOcsN2JD/kVns05zYxvpbq6xK6IA2EWez77Uk0VFLR22aBJcBdbXZ8gG7tnAZ7X4D+GvI3zF3xSkly5tbINnk3uIQjU8QLTiQP3sd6QQQZgcxFngeEjNdSIfoDaXUklw65Oj9IYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJuWBB1u; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJuWBB1u"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-138156c0492so2294050c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278154; x=1782882954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyiSZLY2RbswX9wp0q1UQkIHmRPJNqL0WhxzFKpROtU=;
        b=TJuWBB1uC0viuoVB78uatc2CxzOaRUxM8dz8rty27SVrZqWCNnDWa5gyWf3DeCkBh/
         qq9gEKiMnscQcg9v11pjVjs7pRK9f3a1mSbRl/cJ7xtKWnO10Ug08GYkQfrsm+jSBmEI
         mLWeyf3QTsFaPQ9mudzs67AocSzkeDcK9gKvCk07PM09XVh5ESzfXts1xxY6H0hI0MOf
         F8nMZeitQmW+AxkA5keDT9TF9JDgevkIcUdaWwpw7/gYkTn7lpI4jwVojrvvZrvh+O4k
         /rwiTmsjY84BMF/Fc/694vAce8+LQHA34E8I8vs0CN++2GHpHccxuJWrfjFuTltbQtEO
         XI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278154; x=1782882954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyiSZLY2RbswX9wp0q1UQkIHmRPJNqL0WhxzFKpROtU=;
        b=M0qiRbn+fr/TDdw3ltMTlhz+sjbEdadGUbPjq+CJDwFmO2ta9ckzoeBwUAeAp12Hlx
         4xoQlb1GT8EXq+vFOQ8VlXdCGy8ImWArf91jOuGDb9EZZrdA2ptAeELx/3pWEQOPwR6V
         s62zBIsHNCflpw5oFmTbfrqgz9Dldt42dePSbQGQIJz63wHrRJA69cqqSc3bJrkGJTs4
         WexWYeAOokDd7PGTm2zZk+5V5P1Bk5wKbHz0v/Tn1uLjyAKF3o7vijwXQxjuREHiGDlJ
         4dBt6CIomKDuT5c3dz6uBWZOx4PEPTDNduEeym3dMH5U0h01BJU3/umAPUyv1N1g1jRY
         dv5A==
X-Forwarded-Encrypted: i=1; AFNElJ/KoiRWFVVPmEXWnmh1Czu8JFwb+Lcb+5bnV1JsswgXUeDsScMB5306nM0O+HZW0/zR5HiOrOdEArK6RJ6thXDh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7KtBELfPlU0CDdNVCLKLmkA2KvZXIt79gDtqthV98uRimE7L
	MJQwV5gh+ZA9r2u86UkLGoGM0RdUYevXajRyJ0DV5ENBCyNGMWIqB59Zal0ZQMG1mdrHzyQA32I
	i4Vmus+Qq1A==
X-Received: from dldyq5-n1.prod.google.com ([2002:a05:701b:4545:10b0:138:106:9053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe0b:b0:138:576:fd
 with SMTP id a92af1059eb24-139c5ce0893mr5196881c88.2.1782278153359; Tue, 23
 Jun 2026 22:15:53 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:23 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-7-irogers@google.com>
Subject: [PATCH v2 05/16] perf synthetic-events: Fix uninitialized pthread_join
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In perf_event__synthesize_threads(), fix an uninitialized pthread_join()
call when thread creation fails by only joining the successfully
created threads.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 340b47f510bb ("perf top: Implement multithreading for perf_event__synthesize_threads")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b75f9dcf4dbf..35de41ad14d3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1104,8 +1104,8 @@ int perf_event__synthesize_threads(const struct perf_tool *tool,
 	}
 	err = 0;
 out_join:
-	for (i = 0; i < thread_nr; i++)
-		pthread_join(synthesize_threads[i], NULL);
+	for (j = 0; j < i; j++)
+		pthread_join(synthesize_threads[j], NULL);
 	free(args);
 free_threads:
 	free(synthesize_threads);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

