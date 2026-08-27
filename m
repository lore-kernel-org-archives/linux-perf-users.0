Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD508347500
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813747; cv=none; b=d2VtQ5071LD1/hhRZWn0ElA18B7GL9BpBk6BnQkl1K0xEomiJoFc/PdkrSC03Tn7hvgqYe+iXaK7HkjBcCKNf/jScvt3RWc6+fFFbL4JJMiZkzpmHzwecK1foQ2PH0exP8SUMFSfa30R+PmC9BAK1i597Ko8qcukGMvONuYqRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813747; c=relaxed/simple;
	bh=gOdxdAdgfT+lDwRxuvnqY6Qmt/W+UFC8uGlAIGjNFHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMnZyVUeWRDOYC1wbbf2QDy/7aXeI7JBKVpy1hHZwYjEF1GtwE88WQJwbyezMeOy/iAd4hK1e8wOf/268kMQl9oPTorLWKZa6tV2uAvyHVNb20Sxe+58aYSzYdnle7qOJNShUSCLc5x6wGrvPFDwL5tlPjCrb/fVQZXFCHRiJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=axG9gDAn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axG9gDAn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf452def93so5013095ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787813744; x=1788418544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/98K6HfAltFoLz2cK1JewwCkCtJGw16wbBrVm8XK8Q=;
        b=axG9gDAnFVygOqlS+tRc7W6FCha2PmPBG8AUYuvz/wN4sS/z4RbcCwnqq7mkw5UmF5
         1tMQCa4eVoRoMx3/ZheG2lr0Wtj6hGzLHhaLqPo/7NhNDQPBE7ceHtNmsNdwfAVmJnZL
         VhHuRPpeAMw8ToTHZS4yu3JU2saBwGRGDEaUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787813744; x=1788418544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/98K6HfAltFoLz2cK1JewwCkCtJGw16wbBrVm8XK8Q=;
        b=CEpddIywyZLvaMCYOy9DxrJ/xqtxX9qQyyoBlGnE8A3Ej0nPESUK42VYPcTAcB6pQe
         QI10iDMfGZl9YEgkWyIP0VS+r552I15PidHjZalJ7vKbpnZSwSfn7MTzqUsouvFGf1G9
         MuNhglSEXoHrExYLlGKlcbYv2O7RpIS5/4Endt/cPg0V39+wg3PVSxcKl1Hdugv7Sc0U
         3DBrjjvymZb6EB8sm0AuEbwSYQxGMouAzu86wzMKTYmrs66i1tAv2JoqZTYOjPl7o5rg
         XIFFNSjlxsAAS+WUj+RmEq8oRK49TeHNgy89zEyE+BOHtdpSptrr83box5OdzxzlXr4f
         JV0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoV6Z7UEYCzB54F5YI3NfID6c+oZDNPxxQ8h+ogbyaxysKwdZsNSYmBxiJD2p7OGAht71SpQHeUopicZXzlSwE1@vger.kernel.org
X-Gm-Message-State: AFuF++k9lRjcxF6gTKfF1UIgKmqjd2u0ZVnAlhTtGse2vkzliFafPs5I
	2XwuwNq4dHpqAaG6EACIf+u7jc4SGkgiMIlqZCWCYbZwgmbLG2nvZPd6xbJ6Gs9iyA==
X-Gm-Gg: AR+sD11eX6Y2h4qHW0Sne4aM65RDEKO0nOdVahuiGN7fKpvgiRkgQsoJ/qlExt33f6r
	ETXkycw0eLJ81Q6xiTX/b9tB+/YXUHJvoXeFNFJI9RERztsEiW1shb6YLh0NIxv89/TGPDiwRs/
	v3Hn1FLT8BcrWyHCMtRyPFQOmKG/Z4HSS/BsCgc+Ay1Lt7fE7U6D+pZV7901tyVSLeg++OoWIC4
	63I43meDlDAxfpK8U+EFzRrtoCiZFxFuI8ZNEH/Gw6yOj0nahE56sEcJumf+zHpY2vl7j28kZQF
	xuXS21jkHuisOZu8I9MyNZClGFHJLBwbAAFK8aOMR3otajk1dhx9RcISV60kMRpU48DxEU2+0LC
	e1Lty2B+1dgHG3UYTKHeDE6IGb2pmNbdGnZI3LA51oQw7/ryK7FU+d5x6rqj5snj/uADt8U/tpz
	zctfweheaZ29Nkg8tAmE5DERnvEcyg9cPKf8XfcXjiI8Z1JqIGqKmZ0YU3ABEOcN564qM1lgGT0
	Qo7l7TOrImj9AaPq6IGYzU4Q/XIL/1VGEiM93irdSCNMyt063Y=
X-Received: by 2002:a17:90b:2884:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-3969ba558eamr5421490a91.2.1787813744520;
        Wed, 26 Aug 2026 23:55:44 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ff0:ad84:24b0:9e52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d81682sm1501920a91.7.2026.08.26.23.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 23:55:43 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] perf/x86/intel: downgrade alloc_bts_buffer() WARN() to pr_err()
Date: Thu, 27 Aug 2026 15:55:10 +0900
Message-ID: <20260827065529.3835720-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We see alloc_bts_buffer() allocation failures under memory pressure,
while those allocation failures are non-fatal the WARN_ONCE() triggers
our fleet monitoring.  Given that alloc_bts_buffer() can be called from
various paths (e.g. syscall() or kvm_emulate_wrmsr()) and fail multiple
times, there seem to be little value in that one single backtrace (for
first allocation failure only).

Downgrade WARN_ONCE() to pr_err_once().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8940f0292229..29c24b2925a7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -918,7 +918,7 @@ static int alloc_bts_buffer(int cpu)
 
 	buffer = dsalloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL | __GFP_NOWARN, cpu);
 	if (unlikely(!buffer)) {
-		WARN_ONCE(1, "%s: BTS buffer allocation failure\n", __func__);
+		pr_err_once(1, "%s: BTS buffer allocation failure\n", __func__);
 		return -ENOMEM;
 	}
 	hwev->ds_bts_vaddr = buffer;
-- 
2.55.0.897.gb25b4bd76c-goog

