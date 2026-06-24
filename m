Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FB32B126
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278180; cv=none; b=IZ+AjvZUFtfBLPSFKAXYNiqHKwnEUQpkD98Hty5laZXEzmkEdsl4GletNiKSaDZXpFoy0j5nruEbgHqWtPigZQHsvUo4z9t3xr9CmbPa4prj5KYBlr5RdwlfjPLqfq8O0WUCGUhXjMU32w0wVAj5qmtWBvw6hRAEjbsiZ8E3S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278180; c=relaxed/simple;
	bh=ntfUbjerjoiwZYnmLDvdmJfc3i00I0KJggwMyX+cjvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YCieWsye7n9jowln696s42y09FSA6Xpy7SaclyBLT2NQUKJmuaDl6zsmD5oh4y5CJFNFv7G+TVyMFPOuEu8YHbCZKvsB4obciPN+y1JHRSwigoMLBccr04td2kpFUegCPZbff1i9Ir+jt8WJiLpvijNlufaRoA0DmJvAmdjulkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUJxLl3a; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUJxLl3a"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fc6f8e9fso1238232c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278179; x=1782882979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOvgfK/YXBnBbR1lk38E5LQPe20hVZUh4Fxj/vXJics=;
        b=PUJxLl3aw1KMHRhcDey/7E/64p5A08ScFDA0cmUOJLqzGOwaBSbMxql8GI1e9t1+3N
         j+Pesm2EZAbrQgdorlyXxURxh/Z+Pl9Pz10Z8TWL6NOwy0bKIAtwfwxLs5X+39GCMs3z
         VxyOftgdUgjyP/tcJsFNtPYf7TH9F8+5ymIjG8qV3tmtuskr2MlMPnTsaojpZQ0bwJVf
         rc9dDp1fzN9fVWokzRrYUwOgyonvczJQU4nIYf7AWrBy2TktCOwPSMpg9YZjnxVBIPIc
         g8EIs+hwNna18r0z5oC52uf4szv2lT9Yj7AY3wRxtAlVsENbpKRfMXe2SJYayTF0fJbt
         IUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278179; x=1782882979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOvgfK/YXBnBbR1lk38E5LQPe20hVZUh4Fxj/vXJics=;
        b=MULG6eL/S2RXGtFzFzJge7ozfrE4wnM/ImjGU8AqBOdce/JS6MpaiBRUy314pL7flm
         /0zPcEdAk2x8UWbfVGANhTaJEm4fy/K9hLgvx6EsHp6Y1c29QM8AvmDdERq2FT1M0Dpf
         msaPfH88C4LDjYXmHbpyUBSxcU80EeUUaiQhBlBTEWRgG9SEo/80kHuYFlCalY3fClbL
         s1Rzo3CSV097wXW2hPINQwC9hm56Nb5Xr63FAr7gd0zfuY+9NlY9yxxRSpb8kCyyz3yE
         hJPIfKKTCzkdn99kjeBZAp+k+YK9ddfGu+dNX5xRIo2Hv3TJb8CKhEgLhN02cqZoGvls
         DZeg==
X-Forwarded-Encrypted: i=1; AFNElJ/CqbV2eWVK9h/N6SgGfcc7XCxESuSG+QJnp3Rb0pr/CkKDYBivqjDSPbenEYo5IHFa8jJk5tgg7/AgclM23zKM@vger.kernel.org
X-Gm-Message-State: AOJu0YzznhTeOTE7q92yPA+zYWngFLziV9aKR5qmpQ0MbkHbeD9/euVg
	6SPezqhBiohx4c5y5Fsr+iBF6Peu1x2NbMCtlTAD8wxV0LX5mXliStgBfL07vefEFfdMgBUBqGZ
	f3fMuqbkddA==
X-Received: from dlbtd2.prod.google.com ([2002:a05:7022:1a82:b0:138:17ae:de57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef12:b0:137:fad9:3a30
 with SMTP id a92af1059eb24-139d0c89276mr1391954c88.19.1782278178417; Tue, 23
 Jun 2026 22:16:18 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:34 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-18-irogers@google.com>
Subject: [PATCH v2 16/16] perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

If scandir() finds no matching tasks in /proc, n is 0. If thread_nr is > 1,
we bypass the single-thread fast path and then clamp thread_nr to n, making
it 0. This results in a divide by zero when calculating num_per_thread.

Handle n <= 1 early to use the single-thread fast path and prevent the
crash.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 35de41ad14d3..19c1f3eaf58d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1058,7 +1058,7 @@ int perf_event__synthesize_threads(const struct perf_tool *tool,
 	else
 		thread_nr = nr_threads_synthesize;
 
-	if (thread_nr <= 1) {
+	if (thread_nr <= 1 || n <= 1) {
 		err = __perf_event__synthesize_threads(tool, process,
 						       machine,
 						       needs_mmap, mmap_data,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

