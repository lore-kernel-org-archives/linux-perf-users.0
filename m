Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07646477E41
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060023; cv=none; b=dYnez7Or9kv56ZG3MU05ysAyxZWTN1ynosUHOO4TeNo4BkMecDn9wg9nrmK3nOqIxcxcWvTPZKffa9stMvBe8jpMerrJ6nYYvnFWwY1VKVf6yCxHEZAgriSjXmBliJO3g4v7Fp7gISR2e5401n4lCMjvi3QYxUYhYFdAdaZLKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060023; c=relaxed/simple;
	bh=YXtKPFZbWWZBopwp0wtvWhgawI8Cv5FypUVRsO7wl+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rDKs6L5Rb6RMUaF5OOxyrz1aHrE1+O+fuRBx79kmOBGmn0z8SDMIL0o7IQkqgbr04+i9OIxy63iTY0IQdnsZ13EZ+BfkC/Gkt8Va9PeZdUCpt/PxcmBd4WCU1/d5UGiE5M16X0OBBljRWIKJL1T2bhRnQe6/UrB8NG8OqZxpzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6OIrRi4; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6OIrRi4"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127337c8e52so15020632c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060021; x=1775664821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXhmCfoDGbEzRy0vkOhlRcCB2RW/wzuPXoAXA+lWSZE=;
        b=U6OIrRi4qROE3ukRboDnhOaAC15PiPc8NPMazpoWSrCn04eOXdEWiNs7UR4FwMPyiW
         lnoP6tTH2xbZN6miScS2bi5Ou9enzcLaZh2tRAqzTJjJviazPJCLIEiJ8KYqFqWmcVYr
         /gwu87cl6Ktt4cBCas8vKT8Dzctq4gX9JwNVDOuUUKt5X0AbtM3o3BNzsOs12NLHr9eM
         vLpSfVl/+lXM4RN8OWPuohRoSt5aucU9+N0WulyuWbNY+sFcKMDsUvJUEkOfaUuZubQq
         8fFA2V5fSwxoCyCZ1j2LQuwf0K+oaFqwC6HwvRZ3KHZYLE7b6GMs8F+LB1DNCjv5N3q0
         SLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060021; x=1775664821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXhmCfoDGbEzRy0vkOhlRcCB2RW/wzuPXoAXA+lWSZE=;
        b=jCfCjXLM8HEUMkuXrQpx6B5eUupfSZpr4VAdSlLWHojvZ/A+Otdz8r+zS84PquPTm6
         gBTbplUP9fkv+tbJmGqNzm5pc8YLUkaHHAyQd/INlfrN8ZFIXKMJngRYtoYmeQ1H0OYU
         sZBlfG7D9TbDcaf0QvSTHLwLg8solNe2V2yLxJmgbndDaL04XtT9DzBQ3xBtaqYWy7uW
         TWfT+QJ8zWMzF71n5xZOvCNIYEW8wcDCIlj2MbnfOgCfsIqkW5xxwhp/rlaNB+BIXpLy
         AEAxuXXF1slsrLr928hS5RfNp8bPUMN0kBfcpTswTzDcE3wzy/VKEez3rO71spn8Ai/7
         ADkg==
X-Forwarded-Encrypted: i=1; AJvYcCWKg1I0yLHaWEtXYuwMNfxYii3bz9viVpMAU7B9gDnJPOoqekSRdV/XGRzqMQQlHtfi1fUS52JgDvd9QKtxIa+g@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUTiAnpjroi+7YHtjt30SjDPmqS746TLN6m8xUg980O9U0PHt
	VM3nhuTKUEMUqad1nE3t55Thpv/xiinNg+pTBC7HzaOIqX2Kl1S5CEe/Pi4Fq3rf5VHETDtYLwq
	3cLZ824hw/g==
X-Received: from dlag5.prod.google.com ([2002:a05:701b:2505:b0:12a:7b92:3d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7a3:b0:11b:9b9f:426b
 with SMTP id a92af1059eb24-12be6557586mr2641472c88.20.1775060020875; Wed, 01
 Apr 2026 09:13:40 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:22 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-7-irogers@google.com>
Subject: [PATCH v4 6/8] perf ordered-events: Event processing consistency with
 the regular reader
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

Some event processing functions like perf_event__process_tracing_data
return a zero or positive value on success. Ordered event processing
handles any non-zero value as an error, which is inconsistent with
reader__process_events and reader__read_event that only treat negative
values as errors. Make the ordered events error handling consistent
with that of the events reader.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/ordered-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 8c62611f10aa..a5857f9f5af2 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -243,7 +243,7 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
 		if (iter->timestamp > limit)
 			break;
 		ret = oe->deliver(oe, iter);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ordered_events__delete(oe, iter);
-- 
2.53.0.1118.gaef5881109-goog

