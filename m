Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0576D3C9EE6
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327039; cv=none; b=KAstMShtO0fpYVpjCGZwfeJRtCpGrp5f3hIO8C1FLlPLQ7Qj6G2AmuGxEl4QQFV1y3vcJixDIFfirecIYSDR7impH3rNPncHecFq3JaD+9qO9CZCZm1mzvKncd1hh6f4ehsrlPfzp/pw14P6jmDmQGi0tpAA1DPdA/QjyyI4rTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327039; c=relaxed/simple;
	bh=bpM2wqvx0LzGiObGM29Wi7+eYG6Oxh86/31s9YDTt28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qu1rmbIO99SzikXsku8spLr/i4/L7u8NaSQieEJC3aZoqiWDGhgR7fNyQau0PPaevOGUQdUGg6jatVN016zq7DneETWBnpgPSA7rhgwxc4EdIhyJSxdPwtlVIFTdLE9RVnUynAbwPz77DEbjDKogdFgg16DX4K9Avqt0b3EC81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=E59k7ExJ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="E59k7ExJ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8258ac98bc2so2690814a34.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791327038; x=1791931838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JA8912G4+SWFyMQVOIzEShc8JXcNIOJtWMHGSE0QCs4=;
        b=E59k7ExJI2cJwJQ6ixeRLZtYLcm+yv5EtpCPmnhxw/pNPB5yxyuxg+Pv3Ge9NfWgt3
         l+f/x+gIct4fngCzEta+x+T+mvgH0HIhbMr6D+egAlBLZ8Bh1dKOLMCWTJ9Fu6uumWkf
         HLT9HVm4j1MjaXjIafGmmVp47/PBbxXOVHz00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327038; x=1791931838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JA8912G4+SWFyMQVOIzEShc8JXcNIOJtWMHGSE0QCs4=;
        b=EIxWE88hVKB1meJE7UxYhbQjgOxne3lwGDfUoTvGgRbeesH+TLAhhWrNJ6FVhjKOgQ
         GYjiYZrqRrTUKatmBEEb9YuN8MMJYeenQcj9wTHjWhHyGmo+kWtCch/n7NjMoU5z5Ajk
         odIRxoLfQMBmewsfjep+ucPZr7r0T6dGvha7rI4SOJL8MGnyiU1Id0QL/46TpNSsF4IH
         G4XwgVTCtna8LrV+nGP16Lgtn3cFacLRAvYFBM9NvX4TajQQE03BDZ9hIKd29BZl9nw3
         EMJuQCIsZZ/u0bEkLCHEk19Io1ivWWtaIbDUtLg7Mmy1XaaYXk5yVzIxa5Bqv9iCcTxZ
         CgBg==
X-Gm-Message-State: AFuF++kvA2rwyMMraVcrfuPp3iG0Jzm1bfLGprozLTX1jkUnLbKWjrb8
	9g2GQ8qJtbe2qSIO46KmlvrW1tAu7AXeseFuBzXKq0e2dQkBlEkVdHEA6cJ7n2KNAXSohuVhh/e
	wlBiJwC8=
X-Gm-Gg: AYBFou1eVSUt9bbGH6R7YGVwJalnBBelpXL933B541OO4CuSkNY89rPwLLaIXjeo6Nj
	uvouwVwk5BtRqDehWueNtHJpFs8RRYkJi/9jUXFE7FzkhAYCpdCehp4VX1gvem92cgfOLHN0g6f
	NMPzY4GTj5tAoZk/hRckYuSnRsPFdWFdAoEMBYGFAVm+sMRx+tGJIbp9arwdzpYNBD1aKgMRU2a
	23eUclwyxShPdyy3mMGQegxtv23CZUU9HIeo0beWpRMHb6PqnjPQM2ANN8WpOEjfjEGzlY7Q2FT
	PVaqbW331VMOT766ipScAqFPdkWPpJ6/zbYDhNbFHQdZ1+S5+lDCo3sSDyMBqRaN8wnY09SzFyn
	49MgjGc1EPnroheBL0x9/Dvu43kXk0EdJmscBT6OUum5odE+/7XbeA+WkIyRDO4ADZqhElFb95g
	o9uxdgDAR0yFa6UZew5Td7AbiTy6N+Ft3mQ9qfc7c9Wt2LCBnQOovAUqmg6+fZCoW+IajaIgT9I
	huX5pujmuT6hwHqvsFcpksmJdz7Q2exeSpqajdcoueJBOoiry2qPYQrj7Qzdl9CUNbJa4R4WMg=
X-Received: by 2002:a05:6830:2583:b0:805:bf8b:9523 with SMTP id 46e09a7af769-82ace794239mr1277291a34.10.1791327037884;
        Tue, 06 Oct 2026 15:50:37 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adc3f12f0sm858457a34.13.2026.10.06.15.50.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:50:37 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] perf/core: Require kernel access for page-size samples
Date: Tue,  6 Oct 2026 15:50:33 -0700
Message-ID: <20261006225033.53296-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_SAMPLE_CODE_PAGE_SIZE and PERF_SAMPLE_DATA_PAGE_SIZE translate a
sampled virtual address using the current task's page tables, including
kernel mappings.  exclude_kernel only filters the execution mode of the
sample; it does not establish that the address being translated belongs
to userspace.

For example, an unprivileged tracer can put a kernel address in a
tracee's saved IP at a syscall-entry stop.  A following syscall perf
tracepoint still sees user-mode registers and reports the page size at
that address.  The distinction between unmapped and mapped addresses
can disclose the randomized kernel image base even at
perf_event_paranoid=2.

Require perf_allow_kernel() for both page-size sample types, as is
already done for PERF_SAMPLE_PHYS_ADDR.  This applies the existing perf
and LSM authorization policy before the event is created, independently
of the source or representation of the sampled address.  Authorized
page-size sampling and events that do not request these translation
fields are unchanged.

Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
Fixes: 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/events/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db7b76d6b68aa55dbe95e594d98a47230d12e979..97e5db887bd0a6e45437674670bc38efc6d7d9be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13967,8 +13967,13 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
-	/* Only privileged users can get physical addresses */
-	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
+	/*
+	 * Address translation can disclose kernel mappings even when the
+	 * sampled registers are from user mode.
+	 */
+	if (attr.sample_type & (PERF_SAMPLE_PHYS_ADDR |
+				PERF_SAMPLE_DATA_PAGE_SIZE |
+				PERF_SAMPLE_CODE_PAGE_SIZE)) {
 		err = perf_allow_kernel();
 		if (err)
 			return err;

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
