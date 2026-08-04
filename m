Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766333438F
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823775; cv=none; b=VCYp/zKpdyrBIEiIqveeIR0VF1DK0rHHfZE3w6t/tnADMk3kt8ZqpvPNmaWSoozfUZa+GJwDtFheY0WLFMG26aHpmFEH1Hg2y7T5U1WW8C2AdlBSksVjivwDmh67mmhe5mgWtxzoQrsDjwUGJfahT3QM7Z7DUuir6qcd1QoLc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823775; c=relaxed/simple;
	bh=J6q0pS0ZHgIt0bOHO7n/AKRNFJTdJLz1C+iJBQigho4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFBcJUWgTHLqjFPeRz1Seqf3ds8Mayephzbma1HVhZWW7t+AZkR0Amuj3nETkbHHal9fT90iREKNYwd6wWatbw1IwDeromyCNpJosslEFMXxc1c0XTMFFEYFJ2JKxiT6E1z8l4Rzis228s9/wVo40APb/MB1IcM1Bu6/hHz7N0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=A+yJ9kjE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="A+yJ9kjE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f032b47e3cso29469326d6.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823773; x=1786428573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZeQYfulcZPao/HkrhMXcXboAkZ9BIkvTi4//J1bcNs=;
        b=A+yJ9kjE5TVu0PEVNPIt47xqSUlQGYtGa1a9pVQz5S11gGxSrDLQY5Zy7kUGnierrx
         wo1CFhhNOk7mUKjfmyceZjYlprjcCVMu7Ui3mw+rLFCMnvnTthBugrZlki3THuBK6J6y
         xwbb0vg4220dNUz2MKnM8fbGeICwblp5wilzxfImgfO+/wfc9LlSvqGW5izUI46cD8oC
         8wzrM+9cw/ySZXdhJTy5P8VWa685EQUTwrUQA1GOsXa4wGj2gXQaHJAPmuo6NHeBbH5c
         ALJyUqFbx3ixSIlF0c69dH4sT/0aByIxLOgF377AY/PsUnfZecxFYiASIYTglZhPEXxV
         RGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823773; x=1786428573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZeQYfulcZPao/HkrhMXcXboAkZ9BIkvTi4//J1bcNs=;
        b=JnGRaTWNqM0ybSxxIjBQHRyT4rojGSbBi5WZqmDbSygTcXd7pkpiSu6eMwLIyjeLlh
         1jbGbBVHhpVVvCpwOb0AaUabMdQU5pYX8SGbL42fW6iLrF6GvMT1jxCdqtHa0pVdcWuT
         Lq3GXmS3Su9+QxirTGMhiDIyk7dqDFB+RTSyrw7ZqVQroUh5sv9Qz0MrvVG6D6aoqCOe
         bC/Pl45fOrQIyJ5BF1GzmNlxjNo8biG05o2IeBg6Y9f2w1CLJdkTVf3YOleECLy1GqWd
         lElZFXSZxW3CXL3kZU0tEqe7yvcX7thJZbmNw0H3UT438ty2dZq42I9MVdv6fkHHhSG3
         CZig==
X-Forwarded-Encrypted: i=1; AHgh+RobqbIohRi6a0WXogUhZ4S4dXG69ySqBcZ6y2LxFTjGGYE/oa3I2VayrMoUy6bvuCfprMQkH8Z8PxLi0iVlFJo3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4084Ut4+lBRNR5PFP76M8cQrj15vSGAjaPMxWXgyVfTJUUjkF
	+jcmsPJo1RM4u8n8qYYfrIsaiiKPTAlWqzH2jYIhvweI/L9Y4fLBZBK2o80tBIo0p7Y=
X-Gm-Gg: AR+sD11hvyTFtf6qpZa5e20RFT80iQFLGoN2U2hwyUFBPCZaHSsuEuc7nmfrydyFldh
	UxziAvSyTnbpQJajMI58g0aeO2D27SePwZB+9y0hC1kQt2duFv7f1dGkdIQDibFgMnL1TXNUy7X
	Is4M9PEp5t6oP27zZG3UABjhO4Mr4kI63XKV6I0FRsaNcu2SJLBU+V3uwI+8JgkOoV65q0wP8qO
	Iuw3Vbdz6WQTjNFBg6X4uhp4WXkJSj+4sdHW9H6kkmxMh0Nsr3Jdr3zMjhd2hCHV1uUMb0PwCv9
	yBkb1LSqyqvgYc/xWBrnoOOk/zbL8RZ6oVwD2btv8nEkGFb0VpI9BsdEABFcVrtdUV0hG9uQVHP
	HZ0ACRP/7orPTL8ri80jHSsFm0B3gTPiG8+XLrWVfWvMcSy/gWKEl5gcpFRjykANIHH/oCyK8Cm
	CqyENNeiOUzMNxs1XSyAwGInNzWoYlAYGWet0Gc6/YrxIgXNj8oWJqcjQfnpJTZhXVvw==
X-Received: by 2002:a05:6214:ac6:b0:907:812c:af53 with SMTP id 6a1803df08f44-90849563256mr277505386d6.6.1785823773060;
        Mon, 03 Aug 2026 23:09:33 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908435b6086sm92855926d6.29.2026.08.03.23.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:09:32 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH v2] perf: Fix mmap replacement ring lifetime race
Date: Tue,  4 Aug 2026 06:09:31 +0000
Message-ID: <20260804060931.711308-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

perf_mmap_close() drops the ring-local mmap_count before serializing
with perf_mmap() through event->mmap_mutex.  When the last mapping is
being closed, a concurrent mmap can therefore observe a nonzero
event->mmap_count and a zero rb->mmap_count.

In that case perf_mmap_rb() detaches the old ring, installs a replacement,
and resets event->mmap_count to one.  The old close then consumes that
replacement count and detaches the new ring.  Its pages can consequently
be freed while the replacement VMA still maps their PFNs.

Take event->mmap_mutex before updating either count.  This makes the
ring-local and event-global count transitions atomic with respect to
perf_mmap(), so a replacement cannot be installed until the old close has
detached its ring.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_count")
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/all/20260731120401.558858-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
kernel panic and can share if needed.

 kernel/events/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78..f93327c76 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7053,11 +7053,19 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		mutex_unlock(&rb->aux_mutex);
 	}
 
+	/*
+	 * Serialize both count updates with perf_mmap() so they cannot
+	 * refer to different ring buffer generations.
+	 */
+	mutex_lock(&event->mmap_mutex);
+
 	if (refcount_dec_and_test(&rb->mmap_count))
 		detach_rest = true;
 
-	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
+	if (!refcount_dec_and_test(&event->mmap_count)) {
+		mutex_unlock(&event->mmap_mutex);
 		goto out_put;
+	}
 
 	ring_buffer_attach(event, NULL);
 	mutex_unlock(&event->mmap_mutex);
-- 
2.53.0
