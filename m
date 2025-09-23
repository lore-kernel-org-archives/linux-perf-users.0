Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17728032D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649409; cv=none; b=XmprY2UwBAYSdQHYM0H64cenB1gywTdb8u5Ngys/vK2sp0/kPM6luYMF61TU0YfGNwX9++sGCmt+ceVV7+V9k4c2V3VybSxf0OXFXuEjy/QpFCnxhwpnsEbV4PAYpk/C4Gu/cQrYat/b+bUfuUAdOnjJ7bWB6CvAk40qhCD+f2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649409; c=relaxed/simple;
	bh=TBydUlaZwvjaoiWXQNjwVx4nHU3n7XPX1BEYGfUeY7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRqp8nwKamBMR3z6N13nPu63e3civ4UL8aZbbGN8LA3Xnw8kRcJWDWI0Ikx+t1sRURwAsBGpA0wswAKUaaYdn1TWcok6NzYhA1pKnDx3JK1NjIJY1cBhTgIoB9ShsvuCFcdNA3zeXer7z3hPtSdXohZaOwCQRKzpAHie2eh4iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgnwIqd5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgnwIqd5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so2611541a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649407; x=1759254207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12Psv0L7KGLemGCvbz5saQeHawW9GRBxiy9osVzP4Fc=;
        b=dgnwIqd5tQQFOwAxJIjv5aJUCnX3QDolOWplSTEitXAZF4l5ZQaAFezo80E9sslJms
         FGmZBDmxuGFAGJWUbTS1L4d0+eSushVx+6v2/puY1f1cRdmwFz9uruinD0vzv3uS5ind
         eRzzufSc0blTnnqGOyOeG8eclAKOvU4WSGm+QdAe2VHohX2Af9RpNI2I0NJ4sOm1x1nr
         ks9fDMG3U8YPZRn4gRYZbMfFJY8JMYpMIsT1khA6eEg+mE7PE6I8cVn8JL8jKBRYOdC+
         GmUnNvuuS0CnbUD1Yc/VDLOqBtBqsP1YO2z214BABOxWmO2JWLSHxDKpUiSFDZoqWqEO
         yYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649407; x=1759254207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12Psv0L7KGLemGCvbz5saQeHawW9GRBxiy9osVzP4Fc=;
        b=HudoBgO/3byfKs1H70DKePPV7jtQ6F7eO+pm/O4pjZUWBNhY+ERkLTF0EozcS+UolH
         YX1mvSTY4LoJ0BBsJk+qORvDn67EKlWv6JRH3TKDeuSHPUutvxtXcsWJnXerLJlspLCw
         oF/wAVeCOxUceWvhjweZSyzuJgpvJVf8Cu5kzYH2pknhymvp3ez8O4/FLfrvYgOII2dX
         Gu3R5zO1p2oYkdWu3rE8fmHDI1g8cha4Mxw1o5tBOTiCnGZrg+bpDhJ+Cu+OJ7/S74+t
         aqetkWe3E6xDTKWLvWVLLj4EJgIfuYPYo4BHyH3YXlbnBeaDw9qC4KekL4py4n9jQjHU
         OxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnRG4+ip+tdGkR9ztDqNo7Uh3jZK4U6D6vTAaHrO0UsXr/rJaI8NPFK74OWt3hKFcYW4RuJyYZpSCTKDzmiI1X@vger.kernel.org
X-Gm-Message-State: AOJu0YzaE9ozHIZc9Impmqg5YPl1QVg4ENstSrnfYj3tFUWgJ0f2a/gS
	Dl1jLCPJKmk3dItaAti0IvxF83yu+MStoSoBgrzW0SD2nY4lYuAc2npm
X-Gm-Gg: ASbGncuQUxA54oAYGzRI8TCzU6SG8vEDz574s3PL9wpYeTM7x18YYIqyx2I03jxNTVp
	hLAnjz3DU5frrGvPAJ+kQ7l/5N+l3r7VO5wSX7M0wMiIKCo/hfaf8lyGKNUVtEXTOKJlwsMydLf
	MXdDOOsX71fESwmAJOiiHJyYMnD7Pne06xOx8Us+vkAPdkpV65Ri6ORoYeRJduO3Z7vh8Sgrv64
	IrgKrTuRk11e6rsdFGh3QOp9TeSFvTPEgylq0Hgr3yHYHmti0AyHw+Yzos99jHsTyFvrTz3sMag
	M5FPRS9H6NdnsSUKQC/djn3PbFdwoJsLacF2wBlKdzqSzTFjWTXe9iPuuUb+dPhGY9lkZgJgAfx
	qQkpm4mWBdKcX7ilFwnkodgEzlNoqkc8=
X-Google-Smtp-Source: AGHT+IGHCtQSXDsLg+/XpjGWOyQYA66vNcWGwDZNAlzZTqpJwx4fxepOvpgiWPPekyfcQ3iavGr2cA==
X-Received: by 2002:a17:90b:4c02:b0:32e:59e7:c37f with SMTP id 98e67ed59e1d1-332a92da740mr4865746a91.12.1758649406858;
        Tue, 23 Sep 2025 10:43:26 -0700 (PDT)
Received: from archlinux ([205.254.163.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3303ffe611csm18562321a91.9.2025.09.23.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:43:26 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
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
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] perf/annotate: Use architecture-agnostic register limit
Date: Tue, 23 Sep 2025 23:12:36 +0530
Message-ID: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the arch-specific guard around TYPE_STATE_MAX_REGS and define it
as 32 for all architectures. The architecture that perf is built on may
not match the architecture that produced the perf.data file, so relying
on __powerpc__ or similar is fragile. Using 32 as a fixed upper bound is
safe since it is greater than the previous maximum of 16.
Add a comment to clarify that TYPE_STATE_MAX_REGS is an arch-independent
maximum rather than a build-time choice.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/annotate-data.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..1f76885facb0 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -189,12 +189,15 @@ struct type_state_stack {
 	u8 kind;
 };
 
-/* FIXME: This should be arch-dependent */
-#ifdef __powerpc__
+/*
+ * Maximum number of registers tracked in type_state.
+ *
+ * This limit must cover all supported architectures, since perf
+ * may analyze perf.data files generated on systems with a different
+ * register set. Use 32 as a safe upper bound instead of relying on
+ * build-arch specific values.
+ */
 #define TYPE_STATE_MAX_REGS  32
-#else
-#define TYPE_STATE_MAX_REGS  16
-#endif
 
 /*
  * State table to maintain type info in each register and stack location.
-- 
2.51.0

