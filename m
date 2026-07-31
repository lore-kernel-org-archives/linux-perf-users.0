Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CA427F94
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jul 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499445; cv=none; b=ixe8twdao41qfCJ6lx+lkkoZKlsMSCek4hSaFl/0TYTP+kvBJunpRR9wQcBD42oyts5UINtn+sYPP+Mqa3bLLCWwBI7p1GtSoaEiDrxWoZD7TPx2PNMBRX5dFgH/R+vxB579PxavkP4REpanMzwY0tmKmW31c23WQ3Jsh462wxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499445; c=relaxed/simple;
	bh=Fgg8L4dQDWa8oN7Wne9HCI2H4XFsQy2TGSLzDwWfVjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rp9a0XIUCfx+odMe0VHqYntNuFcC257JAiAfzsr6h/qz+1N0i9j7KMJ7ooZwckpTfmii8Agp7FBZcqt7YjE3Dza6UJ/+b3Y42/Tk4OuP97+H7N/UOblZmLc/LdLMP3gchLsNB/hkO7lhvikUxkxVshaH0NbsJKLpW5LLTcS7bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gHV2riPz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="gHV2riPz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2149571dso7591301cf.3
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jul 2026 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785499442; x=1786104242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uo79vog2GV8rTnOYOZ60atjBxSb7dltR6Y3nOhEe8mk=;
        b=gHV2riPz4S+HoxqXtpASXf7jsTfb0+ntod9CP1ZAsWfW66LMyByrv2G32NwXbqRTNb
         fosmWGq/FnJGAR97kG87UF7uKFK35Dg3n9Utc/rDMjA6u+3oBIv+kOfj/M8lXMHzcTG1
         ENIxWXLxBJEiiCKf2xoga8Q7AcMYziVn2dYjA5iw0AohR22kDBrIsIUCQfpHoI88F2iw
         cdxA1Wg4M8BeoNBgrZAC74Uz8ZmF9ziK714XquFemgS6vHewsVpUiRbTsxUo/6HAvw0q
         z4JZL2iciMYX+EMkD9YW7NrqOcr5s5Qyps0dQXsX8nPbqqhwPLlVuPpikfqUD69gl9Zs
         789A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499442; x=1786104242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uo79vog2GV8rTnOYOZ60atjBxSb7dltR6Y3nOhEe8mk=;
        b=YtcVSmdSayZCXla1HcfWIr1G9AgtqAdi9UemHmWarLQ1lI9uvuR0AgsbTdkuVB+hVB
         3tfCMoqWxVIjiaHjLT8OwcfldeJzYRoySTLqXqgaBcTVHUZe/O8IXRVJdhQdCmBI9Dhn
         xozIp9rL0e0U8iT7CMmOEpNZOSaWw0WSs4iVWC5snOVsLsk+PuptW2GGa/H1uvUPdo9+
         gLMR06jGQLcDqCC7Lzif23quSkVCyJJ57EWwJOJWCwQNhexSHmBLATQFcxN70l29ppbt
         ZktT2mHdv/lHGmGJ+cjNM9TlrD0I70+R+Lubf4KreXBhU3UFAJ9I7Vj5WMAkmzMFZ7fH
         QKvg==
X-Forwarded-Encrypted: i=1; AHgh+RpcHNdMdNbKUgl9sTdtne0aO/ODBob5XoBU74XeKw22780ppUmR8R+rtzdkZg/xCTSiF3EVeFdHP6k4MCq9c1PW@vger.kernel.org
X-Gm-Message-State: AOJu0YyPb7nSMj6eGsO/r5kHPuhg+nZaOr/kcC4PpVz0lbbep7kXteUL
	feb9IR6Qh3Nw6K9hlvRGGNa3xHFVM4h297GWtQZtptFYG+AfJoSprw4YwdLpz86Eyl0=
X-Gm-Gg: AR+sD12ZUmcq2xepHRIx5IY7ts6L/KpdD+ypWzGKgHv4FHMIosX0Y2CRh3FhgbRl8hb
	2TWM9kXCjnTBAQRbJletpvVklzxYvBDOulsk8XfMmqPADWhKONS5Yvd7/8XUfUz4ci2weT9hQeg
	O9uOedXVB3HC8SUZfAkjQdvNm2DFq6k72Wy/BCdg9ECsZIThPO5P8sNBd7Di0fJnu3OTOiuCxUI
	4D6RSuRWHGU2EYUEKoj1J0M9HI/phkphob7zRfd3ceeFq/5L37XqdE4jYtn5nCvVKOR3onwZ0Ut
	wAjF9aI3S0ihUR7cFgDHEXzMffohx6WkC3gbv3YSoqPMwpOzzSph1tf8OXJApbXP91RdqJWuZi1
	nU2Yo/sTTCbiclDIB9YfamHl29Ee8kBoYDjgOpIrf+pAy3wuqI57N12UH+EKvoRNaYLe5fUXi1+
	RXVlw4Jyb1f1kbM4mCDWUWU8E/7K23gn2zUtj5SgdbdC1d+hulxiaesDRbAvguSdb+pw==
X-Received: by 2002:a05:622a:5814:b0:519:5680:1b5 with SMTP id d75a77b69052e-52b4af96409mr24025201cf.21.1785499442561;
        Fri, 31 Jul 2026 05:04:02 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52b4eb6b5b5sm6353351cf.19.2026.07.31.05.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:04:02 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Fix mmap replacement ring lifetime race
Date: Fri, 31 Jul 2026 12:04:01 +0000
Message-ID: <20260731120401.558858-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Bug found and triaged by OpenAI Security Research and 
validated by Trail of Bits.

Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
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
