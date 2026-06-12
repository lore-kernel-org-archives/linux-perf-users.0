Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E603AEF34
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292562; cv=none; b=ggURanS7niflmsobi2csmGorV4xzvmjYN9o8UwbjV9ilQr19SwxnAXyI3WtoS88uTNAHsYKAlCMxSLWIp88QjXaEybkpbjyIIFHP2fcuGUmpYUCKtSaEVpYI0SNTZc8QBwwVZcrKU2VIwK3aBsZm9CC6Rq8XtWrk11HMlz4eF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292562; c=relaxed/simple;
	bh=lsvew6Pa1zH160wbrvXpJuTmj03ydii6m96IOxqlLDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SSaFzOlMArp9cjPUe1ARYt1BS/X3aM/wLozR0uzi3fqf/3aP85VLwkqCEz2vSsbxi9QqcrZU5korqdlPlHc978RBnu8g7Nat5/cdsbW6049OVyX9K4nexFZM/sH5jrHet3fA7+ejzr/pQcMcf4CTHzsG6p3UVwFeTgnn1JugQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQIMTSxO; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQIMTSxO"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-48638069322so1755758b6e.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292556; x=1781897356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVFHxuaku3ZzfsFio1NduM8zq/i0jn84Pu2i1DJARd0=;
        b=MQIMTSxOEPAXR1b693hD51AE+fLk9BzCgNbno/XYEgZJt2gHSChCAoSUX3+jfGNzBg
         ohW0s7076TzVo4OgYP4Fizg/ijnQRJZdwcNie14xB3BjIbLbvkUaowkd5jtgDb7RBwDm
         YDOwrxC5LosPAYGA/t9SM+IyC/hoPGH6WGEbdBaOUYnR9Zch9vN/PTl6PmBWBjHTs0c8
         WjEWuB3UBgr2PQCA73KbquBkMZQYG8cqOG0wkVPsSPj96ie0E/+CLbyvzYy4KFDn7Xne
         a9ZhC1Y34GAz0j7y9qs9p28wxgtEHfYLKmPdXN7cLfpdHCh/xnFmouLvijvdT2vjHDGB
         XFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292556; x=1781897356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVFHxuaku3ZzfsFio1NduM8zq/i0jn84Pu2i1DJARd0=;
        b=SM1U+HjMXU8BymTQCpEw2nVzPamadjpNazEQ1vCyTFMBTv2KpaI8s9+vxpvGf0HTkQ
         Hmo+nvu7bOQwI2GJbCON2Vde9d9+Y6WCWRy5BPd6VmL/HFOGBNQKNOHSD8IhhrieHvGn
         QnlOrVq/3MILTHdVdbuVqjYCyBgzKgZloEkwLrW570nRRbuDzWxuYDR8WYip/MZjktt7
         UYf226ATIF7ZEdVqnOBMST1Ks1sVqv2qGES7ur4DE1Ut+kdGZ6HMGgsyvUSs5mnP9W1P
         xttdSOTr98ujEGuzJ8kSWOK11/RH2pMtfco+bp4OhPSN2Wek/frRgdnyj3pnXkIN6viJ
         bRlg==
X-Forwarded-Encrypted: i=1; AFNElJ/RkxkTwIPYihCQ/cAwcFXWbiSOosBCp8b+cUVtetleCkM2P83sB8Xk+r+qePTfoFUevnBxn7t9uq1ZdbqwBtyc@vger.kernel.org
X-Gm-Message-State: AOJu0YybIbc7lUYA1tkmcXbZ2uXjCzNTrPpvJ288f1OdPRXiPpXL+Lao
	i0y5tl2PK9Vi6zNL2g8pF+IT059XbILTF8x4ejHc8Xkm42EYoTG0a19CVPhSIolBDOMfIVuisda
	7WTk+wYGSJxIEMpdYjgZVjNnZtA==
X-Received: from ilnc8.prod.google.com ([2002:a92:dc88:0:b0:500:1d31:d513])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1250:b0:479:d779:3544 with SMTP id 5614622812f47-4872f2e1d0fmr2673319b6e.5.1781292555927;
 Fri, 12 Jun 2026 12:29:15 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:54 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-7-coltonlewis@google.com>
Subject: [PATCH 06/21] perf: arm_pmuv3: Allocate counter indices from high to low
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

To minimize collisions between host and guest counters, allocate host
counters from high to low. How the pivot HPMN is defined to partition the counters gives the guest the low index counters.

Doing this with index math instead of defining a
for_each_set_bit_reverse macro is safe because cntr_mask is always a
dense range while the host is running.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 17bb1cfdc271c..d7a49dc0b0be6 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -953,10 +953,12 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 {
 	int idx;
 
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
+	for (idx = ARMV8_PMU_MAX_GENERAL_COUNTERS - 1; idx >= 0; idx--) {
+		if (test_bit(idx, cpu_pmu->cntr_mask) &&
+		    !test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
+
 	return -EAGAIN;
 }
 
@@ -969,17 +971,22 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
 	 * Chaining requires two consecutive event counters, where
 	 * the lower idx must be even.
 	 */
-	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+	for (idx = ARMV8_PMU_MAX_GENERAL_COUNTERS - 1; idx >= 0; idx--) {
 		if (!(idx & 0x1))
 			continue;
-		if (!test_and_set_bit(idx, cpuc->used_mask)) {
-			/* Check if the preceding even counter is available */
-			if (!test_and_set_bit(idx - 1, cpuc->used_mask))
-				return idx;
-			/* Release the Odd counter */
-			clear_bit(idx, cpuc->used_mask);
+
+		if (test_bit(idx, cpu_pmu->cntr_mask) &&
+		    test_bit(idx - 1, cpu_pmu->cntr_mask)) {
+			if (!test_and_set_bit(idx, cpuc->used_mask)) {
+				/* Check if the preceding even counter is available */
+				if (!test_and_set_bit(idx - 1, cpuc->used_mask))
+					return idx;
+				/* Release the Odd counter */
+				clear_bit(idx, cpuc->used_mask);
+			}
 		}
 	}
+
 	return -EAGAIN;
 }
 
-- 
2.54.0.1136.gdb2ca164c4-goog

