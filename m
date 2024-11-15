Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E53190471;
	Fri, 15 Nov 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711608; cv=none; b=lvRLfBTzaiHCvQJ20U03HahRluMpaUIlk41Nu/azS9kOZvzijXVhDtA4keeL6dDdXlqMhMOsWlVnWST75w03OcVSBAAQs+97rCE9NFyNH4YS6q/qjmkbSdiBc/k+CcMROnIZ9A7KWqCYXiIwBxDr8E0OeDaIQVN6h2+YLTTLV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711608; c=relaxed/simple;
	bh=h0nperqVqbHB5eqqjIn9F+8wj6Mb6ucj+/I59BTez6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lo9iBLS5ulXruogLFl0lyySK6nIAvnLjNz1a4ehm5JWRFCeHWQSxYCOhiJynp6vtIY5eJVbwmm0G4chXbJhoSUZXjzpPAeJoJpf+eBG3qasQ43xmi3o+mWK7cIvD/5BowNmcOtTx6nnkEXTcZa+NGjSTZWxvdiA3dCRhSYX83jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGLcYkgN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGLcYkgN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbcd71012so720055ad.3;
        Fri, 15 Nov 2024 15:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731711607; x=1732316407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya0Xzxf9sfPPzCc2BoY8o1v3FhPr9pgYNNyxWUxd1nI=;
        b=iGLcYkgNBeaa5YG5GMNESbmGIuxf19PM/59PEG3Az7QUbE6XPTBVtSeMU/mwHLG96T
         2aQDBoDADDUbs7LbU/bTMHdmyRmCfyOttHqSpVZw+DKJGG9iaMxHAd2bLzark9t4dQ8W
         Lbc/0JwyvdROUrXGu5p/+Pvwf8NEL9TdpEfGuLVwWYw+zMv13VIlosSs41CZwBJc1lGM
         qF/qCBketkQhL0z2UYqhB2YC5+mqDDzoXjEi/kzJB1VZL+KSepL3+eJkjMlrdIoViry6
         LeCxaE/sfpMhODMHfhY7lm3KZphTd+NJHU7ni8IV1Wjv/AAQEUc1lveqk3U4Fv8SP7O7
         lsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731711607; x=1732316407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ya0Xzxf9sfPPzCc2BoY8o1v3FhPr9pgYNNyxWUxd1nI=;
        b=KGsFc8mVHAVjLtr7nqjSBeheZH8GoSHM9cbf/ceLQNWrQ9bWaSIVK3n3JKBdpT33l9
         N2IunvEUM37tBk+Y+4uxOOB1TMWSRHERtFP3ulqA1COwOQzg0q9QNE39KPxE/0pigdn6
         qBI6VjM16wiyZ7fvEjqmfk/PM1fb979Y1MW2duaNGnKX4VW1CZEM3ihToz8LN4cFdtne
         ikCK5INfYmQOaFNXvniHzTzmSQpPoeGq5u8CrmDAXZomXdGVrieZiYa4tOnHLbGTkeKi
         /krcyvIyGpMEkOk3fcqhFBN9WJTE7LMOzfwqjxHgbfOtmzxhEflzRo38p7xvh7iau9wj
         8prw==
X-Forwarded-Encrypted: i=1; AJvYcCU9/jVJAJX9wiuottVjJgG5wEW3tWCvm8vCruMKTtwivFOtXpA23YLGxLb5VCJwaIw1Z1ErdjUj2Y+HsdM=@vger.kernel.org, AJvYcCXOB8NG/claP1m8Pxum6xMKmwwnMQKY38th6Bo4uoWUDVDbfNSgn1hFGCIyebnYWx1pljP3Zx1/7cADqud24Guvmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jdO28sj1yS3gKodRq5mLisfD5Lbtf7z5HzUkRI/ctG9+ilkc
	YF7z0zNVnf/6mrm5qBd9F+qEMdR76AaGHzCYyFoMcWyIlaIl/Ntk
X-Google-Smtp-Source: AGHT+IHlaGMSP3eqwTL20AdsmPEI86SsLw7MYOyx8/0xopEAlkmFnin4y5YG+JQCH0fMF5SxIQeQTQ==
X-Received: by 2002:a17:902:ce8b:b0:211:d00a:1974 with SMTP id d9443c01a7336-211d0d7f96bmr48350715ad.13.1731711606840;
        Fri, 15 Nov 2024 15:00:06 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ecafebsm17521015ad.105.2024.11.15.15.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:00:06 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] perf/x86/intel: Cast u64 variable
Date: Fri, 15 Nov 2024 14:58:30 -0800
Message-ID: <20241115225829.112361-2-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Casting (1 >> bit) to u64 before it is compared with pebs_status variable.

Fixes: 21509084f999 perf/x86/intel: Handle multiple records in the PEBS buffer
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fa5ea65de0d0..9ea147565dc2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2072,7 +2072,7 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 			/* clear non-PEBS bit and re-check */
 			pebs_status = status & cpuc->pebs_enabled;
 			pebs_status &= PEBS_COUNTER_MASK;
-			if (pebs_status == (1 << bit))
+			if (pebs_status == (u64) (1 << bit))
 				return at;
 		}
 	}
-- 
2.46.1

