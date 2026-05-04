Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B85239562
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777866699; cv=none; b=gahK7BIxCLGJlD/D73ppArds7oGfFMsI7snIXDtzvu3DT7fRGW99EMdQLC42bCtgWTqSqjSNIw5EJeFgS+SwO9q8eqnthIBIHYKvpOcoRNhyVT0QhGeT4guB+dkYZhB3cfMqDTTQlNVSIenwm0sgg28FGg6SZHhjDE8TyENFOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777866699; c=relaxed/simple;
	bh=c9ejlYjPiFjsPhz/yehQpWJw1IyWFFw1CL0F74SsqP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GLc3ImvjKtFNDfryNsN7zGLpuKFhJg2DHF0GCxKFOeI8L+2oYBNAcctmA+8HrFZ7unRfXlCDAAEM51wMxvJ5zpOZbKTyeDlZZqJ/eIX5CQVVucyMXCRPV7IuUzUf4dc486pirD/me+i4JD+ZCu/UVvRhZNi9Q1AnmgmqT5wy8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PADPgoBz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PADPgoBz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4055so6101254c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 20:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777866697; x=1778471497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkt4oU+hEVEUN5xjbaGhASHDDjx1y3R0jVDB1yo0F0U=;
        b=PADPgoBz0VfMrNkC4imxyS0dIXQd8JvFiysJtmCV0bnkEsPSlbdYUkLGHoNgEJ5dRB
         7QiCJrAL/oqZ3YiTX+RjagrC3XliaWG7w/3qbMF2eXNy+TrHVjf3ft8UKPtZfZwJ28SF
         wZCwkMUk6mXzPYL9nIHsElw0c18KgdexgiIpZbdHXwNZ3T7tSo/JJXkbWH66d9Lw5uAn
         yEm7a/fB2vzLHhUt4QoCmDdHuJscdef02ZDC7eiDBszenJ7KL518ApmKG3uitLLX/Ut0
         RdiFIiAzWCiZ9slNaf7lL0qYLBA6zuDSpUWrZwv8LrIrV42KBhAiDeLIUnmQTd5C8BGu
         buFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777866697; x=1778471497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkt4oU+hEVEUN5xjbaGhASHDDjx1y3R0jVDB1yo0F0U=;
        b=IFzM11U+RLsCjAdHekbNK/uCsI9eVbY6O81SzyxzmOXADYkCuQm6XdLFRnYi1iM2xM
         eJKqRnx+u8l3+lBSyOFecZaMNtyam+l3SyGtG8oM+wTxJokHSEUq0YMikR2D2tmsn+mG
         sLVXZT0e+mfLMbtbP+cm2b+llBl38Bk0vqdFA/Hkq3nPng52ESMNIEdmpZRi9CYlK6k6
         NpUc3RZ0HC8G2XANERm3Njhe6S8ISldiUgWbwu9RGIQ8cT5m+1KM0mvktk3qK52lespK
         yGryUQ8ee59Qv3i7Ry6fiZb4H2o+1DK7oUFbr7h63zO3IvXlnsXs7VUVpWOGZTE7/Ku8
         pruw==
X-Forwarded-Encrypted: i=1; AFNElJ/KtdH8p88HWGkz5bcgy0twI4LWvAMS8vOx/xze1O9lAVZoZIDtRKXjdNG2PQ2VvfKy8uiZqDu58EjmihiPc4kH@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyPFVtvfrVbkf1KSTAD0lezjJfQx72G1vGPdAgPDM6H53FejT
	e0r4uf0V1ReVjVvQyY02F13JvTGuXI8D1bGiexysIdCAOqpP9x+6ug34eLzuwlq6es9t22iJK+Z
	99Jc6yFu2Sg==
X-Received: from dlec12-n2.prod.google.com ([2002:a05:701b:428c:20b0:12b:fba9:5eb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6628:b0:122:33e:6d41
 with SMTP id a92af1059eb24-12dfd84327fmr3550268c88.23.1777866697027; Sun, 03
 May 2026 20:51:37 -0700 (PDT)
Date: Sun,  3 May 2026 20:51:22 -0700
In-Reply-To: <20260504035125.1851720-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425020529.3246331-1-irogers@google.com> <20260504035125.1851720-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504035125.1851720-2-irogers@google.com>
Subject: [PATCH v3 1/4] perf sched: Add missing mmap2 handler in timehist
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

perf_sched__timehist() registers event handlers for options using the
sched->tool struct. It registers handlers for MMAP, COMM, EXIT, FORK, etc.
but completely omits registering a handler for MMAP2 events.

Failing to register both MMAP and MMAP2 handlers causes modern systems
(which primarily output MMAP2 records) to silently drop VMA map mappings.
This results in uninitialized machine/thread mapping structures, making it
impossible to resolve shared library instruction pointers (IPs) to dynamic
symbols/DSOs during timehist callchain analysis.

Fix this by correctly registering perf_event__process_mmap2 in
sched->tool inside perf_sched__timehist().

Assisted-by: Gemini-CLI:Google Gemini 3
Fixes: 5bbfec0ad93c ("perf sched: Implement timehist option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..241c2f808f7b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3299,6 +3299,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	 */
 	sched->tool.sample	 = perf_timehist__process_sample;
 	sched->tool.mmap	 = perf_event__process_mmap;
+	sched->tool.mmap2	 = perf_event__process_mmap2;
 	sched->tool.comm	 = perf_event__process_comm;
 	sched->tool.exit	 = perf_event__process_exit;
 	sched->tool.fork	 = perf_event__process_fork;
-- 
2.54.0.545.g6539524ca2-goog

