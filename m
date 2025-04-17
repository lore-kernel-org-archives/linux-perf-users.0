Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2F21C9FD
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931065; cv=none; b=W0adOYMZWTzPxfXcmIoECHtF2jvK9WnFB7no9BuG0GxXhEOzQr0GqEsGMh3EyXz5rB/x2QYPhZ11r6t5UYbg9y1Ylsuf5fiK8quBJLaw+oyCv2QNRAbFm9sdig/3PsNK0ug6I1rr77m0+ztA9JdlCx53B0pj7SbXqaZmrcSjVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931065; c=relaxed/simple;
	bh=uN+5WpDdbkQDQBwue05xSgy4ppNVh7/N3Q24oRcGl5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p7pLGhy2Qhds/wBoGbNyJf68iyVeP1GGIruw+MZ50BA4UwpXleMyxnLPAKICxannlMSUP7mviCu5cW9PfpX2NTdtZfPskQQ+8pNZP8icqTy4xGOI65+ai679BRGpSw0a47byn16xmqU+CKAX/RgGco3Gpzb6NE5vQmVah82GdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AkRFlblE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AkRFlblE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2254e0b4b79so20477145ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744931062; x=1745535862; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWYtfNnXs+JX3LJ+csjR90IU9qz0LhJ+UWyysJK6Yms=;
        b=AkRFlblEaZvB3wLA+M3YvTAOBnE027R9wLH4RCZv0EXAdEEks9JomHq8ff/CTkbGmO
         hHU2dKdqaRBpeiSF7yoKnCRRvd1mkMEBmDCF/j5lGC5yabfnua3z2+PahuBi2lnTydWf
         ojLJ62IlP1pvKmou0HfG1LxeLEgHQbITO6MOSoiHqW6BLamVjjBXZbF00KJeMc1VHkTg
         jb2EhqBfCKm9iWNqo8KMc/IKfM/9+kE2Aba5CYaArZS24XAMMg1xbtjw0llXc47edYCd
         81gzkDlSYlFRaXeKYCLVcfLxNw5DNrlv6QSqrftRYRKFDgdRXhuiJ8k+E68YTwiiC2jb
         2rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931062; x=1745535862;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWYtfNnXs+JX3LJ+csjR90IU9qz0LhJ+UWyysJK6Yms=;
        b=gwPuU3umcbnpwKgYbj5WYsPbDAMrQg0uv0AjahjW+N0nMa8sepxuCwL9AT95GAZmuW
         eA0k0trMG5ZoVlNz0OroQbo77SRS8GqNw7KS47xJc9Xdmbr/F2VznZD2Mx8H2FCee7Ep
         rvPLs8jsmdiguvRPI23p5oYBHRkwUM9ymc0rM8hXZk1CP0z2lhzMKTQFoy9PZRXnAn9B
         xiuvwQS3gGA8HxVSOQWPyoPzPEvkbgBYcHsuoj2GF5dNsWR6oKloaC/E1t69TWC0b5VT
         9qi63V/AaYH0DSySYsejTz8jAXZqiFD8eNB0Uf/gBvHsq6RAoVascPY2N8HiIwFNTAjg
         kTmQ==
X-Gm-Message-State: AOJu0YygTpKUaipPbC5HrBzY/Tp1zwe1cU+RKmKti8bixqYT9o7eMeJn
	XfQZJVOY2FRz4BjTQVBTmSwoJIfDfwFPcergd0UvuGzTOn5tYPOytDQtUult0uE=
X-Gm-Gg: ASbGnct0jY1AKraQh2Cklf3/Ap19gXK7z6GotPxlBtFqJYae2RgbPHZkc67QZO11k6Z
	FwvSfmfMbdEkN8/xoW+sRj9fJgVNm8XEt3hzupZNEIKMS3XpsCnHFAT58W18qTzXPw+kmm+hbM2
	HjrqcLrPB415gVzTcgIKXUd3CxH+mbZHrRX7XxvksWxqybrhSZg2fWTiyEYgMRw9qg9hDyRQEXn
	gLJdIyUimx1RWu74FbdPfJa/nHdnY9xUUB4WtqO/deD5WPqUPZ6jDGRkPSiX5uxcA9CYnMwDUAG
	gnXh2nQT3jB8puFu6xhXCKHxcMXXq8/sSCPKki7Mgn7wEcEubTGRHSERpHEneP6YECY=
X-Google-Smtp-Source: AGHT+IGgjlV1nwuhUHZGGyPS/JCAjYmgdu+YsyfmbcSyyuu6FVkVOgvNv3loVYfehnCCQH5+mmaTLQ==
X-Received: by 2002:a17:902:d4ce:b0:21f:164d:93fe with SMTP id d9443c01a7336-22c53621ac3mr8430945ad.53.1744931062314;
        Thu, 17 Apr 2025 16:04:22 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed1301sm5486695ad.184.2025.04.17.16.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:04:21 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 17 Apr 2025 16:04:07 -0700
Subject: [PATCH] tools/perf: Allow skipping documentation when installing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-allow_skipping_docs_perf-v1-1-e7fd719c4eda@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOaIAWgC/x3MTQqAIBBA4avErBPK/qirRIjVWEOh4kAF0t2Tl
 t/ivQiMgZBhyCIEvIjJ2YQyz2DZtd1Q0JoMspBNUZed0OfpbsUHeU92U6tbWHkMRhgtq3mu26b
 XCCn3AQ09/3qc3vcDoilblmoAAAA=
X-Change-ID: 20250417-allow_skipping_docs_perf-fa23bb4659ae
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=uN+5WpDdbkQDQBwue05xSgy4ppNVh7/N3Q24oRcGl5I=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQwZjx/PPRiz9Tzmlxa//TsvZwsz5O2x64c2SnvlLwrZx3
 70Q/up+RykLgxgXg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABPZNYPhn9oB21MJwvXpsarf
 XVe8l4psEmJN/qTGLv4oVF/ko/HaDEaGLZxB0acT4yUE8mwu1L2p3Hpu2lbfTWx7mpbl8WzLPNr
 JBQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

If an enviornment variable NO_DOCS is set to 1, documentation will be
skipped when installing perf.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 4407b106d9772b32c5c4feed5a39442678679d62..d6ee0e06f0be19880d10e5a6faa8d0319d09c55f 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -203,6 +203,8 @@ install-man: check-man-tools man do-install-man
 
 ifdef missing_tools
   DO_INSTALL_MAN = $(warning Please install $(missing_tools) to have the man pages installed)
+else ifeq ($(NO_DOCS),1)
+  DO_INSTALL_MAN = $(warning man pages will not be installed because NO_DOCS is defined)
 else
   DO_INSTALL_MAN = do-install-man
 endif

---
base-commit: 1741189d843a1d5ef38538bc52a3760e2e46cb2e
change-id: 20250417-allow_skipping_docs_perf-fa23bb4659ae
-- 
- Charlie

