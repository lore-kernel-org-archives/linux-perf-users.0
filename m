Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785E23EAB0
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294506; cv=none; b=QEvn/eWtfrFARet3ZfedTzsCDiB2FkA47MDbq8IU8o5gfb77NUcpmSanszcwi3vwxtlbQ8EuiYUTw5XtueKEamFk1hqdNksuD0gzpReK8hG+ds6GAN3fRqJGyEqd07rLdKBzxqNexckua+CvztmGKDmcAr3aZABuqvbp7InFDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294506; c=relaxed/simple;
	bh=HSodX/sF6n0VhpVA1TDfybltp0Ysl3HzVr/qdTfYzos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fF8Le5lXMYB9RFuxiYCuvN6B0vWosGUEiXjQxdWIgCRQzk3VYbDciU9lzoYVyynMkEQXbn1zJQerMGchqcpdt+HN7Z6FqduzR5mehYppUg8U3LYdzQgjXBtKji9NU4FxxEZi+1vOweRpUUm16AK42EhKSej24nBZjf/r1lZW4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qFE+Bax; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qFE+Bax"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2be21f89332so831061eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 22:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773294504; x=1773899304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Ls+lYt4cje+TYvSjfO7ld7xgddXhunwVNzNtGPP1c=;
        b=2qFE+BaxQ40svsoAQhmcOvhgwpmleElcYtsUwbs8W29nsy/0m0dC/xa0wEgPQdmaCl
         agz8uXdGnMUZ7Jf/dLWTWS3HD93e0oBp88b0wG7j9iY4gowEq3LriWsW6jF/ZNIXCN6Q
         WR+Oem/jBBeuuNWQJlEgPdd0H0eOOJz4h5jRzzUBH+goFW2CWrQqGwEY6EtP1j9PatBk
         xVGGkWjAUEvax6D7fzwNgwjn/tLTccIQjpeT/18VFs5cTpdEXakun6qNAoBH4Y4TimN2
         LXt0Ilt/dGd6lSzZxRXHeOVq55wBQTkxri3ocfHzstmd9A2sEadqerRysAps76e/JyM3
         fK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773294504; x=1773899304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Ls+lYt4cje+TYvSjfO7ld7xgddXhunwVNzNtGPP1c=;
        b=PYI9plflj5bYKB2mTRweSRsOq6r4byjfc/lorPhg9Lg69zvgS+4nhtTcdZBqpEi7dH
         3FwVQWCJgiWF2uDld61FIuV4sAb/BOngFq6NXaEI7bMCnYaRZ9PXJdT6744XD6CvGu52
         vagbeDRb3xBZXRmOnBdVgnbK/a421YcKp9fSbJOUKqZEfEnl7jxRGTAudJo3Iy7PckBG
         Atgqw7ArWW+/PyPBPU7m8FkVw0frS+DY1y9ZtruX9CYRNciDn3lk/YYZ3C/c0nrgqtpm
         73TbQd7LxKmo+crcv12r+OBp3Ge7zxU6JfWmOMSKpIBSeuLNgcKnBsr76l38ELh7bwTn
         3+8A==
X-Forwarded-Encrypted: i=1; AJvYcCVfh6P10DXEASbKtktynkSBugu9w/TxXfU5XI/uWmqFaGSDDmJUjVgjv0wneczqzuwg+xDglAw19Bc/ODTFOau2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxq9/V+CjAD/S7ONqMtva1WPF6PKoQwnph34sErH9+klwSo1Bx
	fSh9EGq/FI98tbestlac7m/yg+veVi8dIuieP6rg1mQagF1rKln6b6PnwYFXe/WUa9xpEULJQhg
	lI6Xa0nC8Hw==
X-Received: from dlam6-n1.prod.google.com ([2002:a05:701b:2086:10b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60c:b0:123:330b:398
 with SMTP id a92af1059eb24-128e77c3bb6mr2425875c88.19.1773294503715; Wed, 11
 Mar 2026 22:48:23 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:48:09 -0700
In-Reply-To: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312054810.1571020-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf/x86: Avoid inadvertent casts to x86_hybrid_pmu
From: Ian Rogers <irogers@google.com>
To: dapeng1.mi@intel.com, dapeng1.mi@linux.intel.com
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, alexander.shishkin@linux.intel.com, eranian@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	thomas.falcon@intel.com, xudong.hao@intel.com, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

The patch:
https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
showed it was pretty easy to accidentally cast non-x86 PMUs to
x86_hybrid_pmus. Add a BUG_ON for that case. Restructure is_x86_event
and add an is_x86_pmu to facilitate this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Only build tested.
---
 arch/x86/events/core.c       | 16 ----------------
 arch/x86/events/perf_event.h | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2e..6c6567dc6c88 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -774,22 +774,6 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-int is_x86_event(struct perf_event *event)
-{
-	/*
-	 * For a non-hybrid platforms, the type of X86 pmu is
-	 * always PERF_TYPE_RAW.
-	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
-	 * is a unique capability for the X86 PMU.
-	 * Use them to detect a X86 event.
-	 */
-	if (event->pmu->type == PERF_TYPE_RAW ||
-	    event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
-		return true;
-
-	return false;
-}
-
 struct pmu *x86_get_pmu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..f1123c95d174 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,7 +115,23 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
-int is_x86_event(struct perf_event *event);
+static inline bool is_x86_pmu(struct pmu *pmu)
+{
+	/*
+	 * For a non-hybrid platforms, the type of X86 pmu is
+	 * always PERF_TYPE_RAW.
+	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
+	 * is a unique capability for the X86 PMU.
+	 * Use them to detect a X86 event.
+	 */
+	return pmu->type == PERF_TYPE_RAW ||
+	      (pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE);
+}
+
+static inline bool is_x86_event(struct perf_event *event)
+{
+	return is_x86_pmu(event->pmu);
+}
 
 static inline bool check_leader_group(struct perf_event *leader, int flags)
 {
@@ -779,6 +795,7 @@ struct x86_hybrid_pmu {
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
 {
+	BUG_ON(!is_x86_pmu(pmu));
 	return container_of(pmu, struct x86_hybrid_pmu, pmu);
 }
 
-- 
2.53.0.851.ga537e3e6e9-goog

