Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87C1714A0;
	Tue,  5 Nov 2024 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790765; cv=none; b=MVVDF+9fykgsAlZsqDz79VFIKXxzZMszaBwxRHqEbobTbjWhpA8WgH/UAG0+RGRXlkdmH3uF1nPyS4pev1z97SpQMP9VfR5i6TmseF9hj1vGZHyVs6+5OfWCbCK92xoz8N2wjw3ku2GXiz2Vn+ITVZNHe4I5XvDGZ8ngc10UL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790765; c=relaxed/simple;
	bh=Am9DuFLIQ8q6t0Z1voFR/LuoOaI8ULbaSie2XZfVRCs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jc+rwtJtizETBtIGSayxivCrT8LiN5PXbZOFcbSnaxVym7ZReHP/4NLrQNBxdwWvvzlX04iTy/pAU4C3kZcDpQH50rzilUj0BP3hgLd6ek7926iXfgFlgG2C02C1ARCB4CVrFkvXC2bTpkwhXw0V99ZmbwTNEbVsTBGMq8E3MoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HasltKeE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HasltKeE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c70abba48so44672635ad.0;
        Mon, 04 Nov 2024 23:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730790763; x=1731395563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0elyKWEqP5z36EVcbg27VLxcmv4ERvItDYyKU6ApbM=;
        b=HasltKeESY8wTG0VF6ejWcguDPp7MzrQxvXhw270IevA642Snlrz5Xo9XlPKTiy9IA
         79O09WD4lQ5vxHSyabXLJKJjpypeuSXQ/5EBLNlTNmlqsAT5b+75ZE4qo3tq9FmSCpof
         XOkSGFNWfStVEjl+WR894IuiGQyE1a9AIO5oQgr+SdSDsmT6Cpnij8E2v2mzVzsPHawq
         6plEwroHhnwHyvXi1k7b33bV7f8VjxRXXl0WFvo4DnynQm1Jv0cFYAp6lgEIHpX64YPj
         ZgEDzYAv9NeU87c5SVL4515SHBV0RKJHsLWzw/TTCvJsnsmK1UL7EbvHoxE+k8XKCLMm
         UjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790763; x=1731395563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0elyKWEqP5z36EVcbg27VLxcmv4ERvItDYyKU6ApbM=;
        b=mpGwfIeC1aEEwmGp+52+KKJ7A2b/DS3g7EXTQsUFrT+zSE8JyDqT1QYiH7hlBQk324
         IkmuY5ECpT+kW9e6nJo6mGw99O3Hh5UEn79MkrWBiNpq0K/VHrQC/I8fclQnTzXyZM1L
         bUQwOodxCCNYl3MRYDQQAPcAFNFwuVGTo4gMLkCQ8DxBT6M2RDO7B0mVr7vgmV2LbuDQ
         uoTcof2HFkxNU0or2qAtteI2nVwGPA3CwbLW187vgqht3ea5RVXNSKY2ylfz6bx/9y5z
         iuNeBNCX0WK/5PYCzlYDC2DYiQ/h2BMSFUxyooE/C8z0T66u9WoTCi9jOo5r64pNLQ3R
         U1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJrpyq5Lh1rpx5PHG0LBpLIPSU4JUH9Wn2kJjgNZ3n7ax8DM2InSHb5J63+1/KofsEmpeP50pvY1WoNEg=@vger.kernel.org, AJvYcCUn9l+vOsJg3inCWJpnsd+mFqpzPAL5PmlgYW2fXUFN2mnDrag4WRltKP6PqtEthulXtlrWT3iUL6tJ+baIWoC2mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcbZSls8FWHzsLJNL98ZpC5fYQ6fi5C1bJntLDFw8LyxXTCZ3
	IL9GriLWOCQHeYZq/lVE+P4sn+yUuMBeSj1b9d9/lMpgLTkWQMcm
X-Google-Smtp-Source: AGHT+IGdMwzeq06bcx0qMU4I7tl6169FIxEcxgjtCekRFGruKHS22TfEDvbVcH3nRs/YHBVKt5zBPw==
X-Received: by 2002:a17:902:f543:b0:20c:e875:12c2 with SMTP id d9443c01a7336-2111b0028edmr193382055ad.51.1730790763438;
        Mon, 04 Nov 2024 23:12:43 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211057c0ec7sm71930185ad.202.2024.11.04.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 23:12:43 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] copy_class_filename: replace deprecated strlcpy with strscpy
Date: Mon,  4 Nov 2024 23:12:25 -0800
Message-Id: <20241105071225.426026-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latest kernel docs:
https://www.kernel.org/doc/html/latest/process/deprecated.html
recommends replacing strlcpy with strscpy as the safer alternative. The
value of strlcpy is not used so there shouldn't be issues with replacing
the deprecated call.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 tools/perf/jvmti/libjvmti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index fcca275e5..04d6825d2 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -158,7 +158,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 		result[i] = '\0';
 	} else {
 		/* fallback case */
-		strlcpy(result, file_name, max_length);
+		strscpy(result, file_name, max_length);
 	}
 }
 
-- 
2.39.2

