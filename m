Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68D18F2DF
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294667; cv=none; b=NOMZCHVbwvisdn5o6hDF9a0QswcVvQyd4lvxkeiL/L0GBFvFZBtafLLs3I2UijuEctczsvZCHGMl5cKrp1xlZT1B1V9QXJhBap1OssCnoOjlYO9U8WTYqa4e/uM0RtYk7NJSSVh8+QJwNFr8XKEfcoUA35nVdJDIXR3vD7eOoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294667; c=relaxed/simple;
	bh=5HHOtQIso9qtWjfwf6FJh2CMKju6bDNni/rw1/SKRoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q9iebRP/0CGZ217nbfdQnUlEB8tJyhOVCLqPrVq2ueSnF+NsdA40gaTfsKj4IelGeLUx+TK/i5dq2RU85m8dYPmqaEQuzEKEAOriQAcSyRCz9f7FLnixLV9UFPj+8vfQqYrhlUmvvmfBXftRWQV3H0uK2F5OPxSD/wX1jjuG6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cIQmsoZk; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cIQmsoZk"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260e12aac26so2858144fac.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722294665; x=1722899465; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kq2aqigLfOIOLKw3DvfLTvrf9ebVnlwFLXvqIP00zA=;
        b=cIQmsoZkwJazUnmph2u99p27cOkIrrIiOY658NaLjfAhZ/xIsN4Fg6I8wLPk9gwC0F
         Rs7ohIuWujRHPZM8vUSJWbRJtBK7ixaHNeTLjh8A+IHbrN5aE6+QbOdyEmzUKZKeNPeT
         xPBIDXQGaDaPpHc1mzkDo4lCzJpj1Uj6Fyx5Zdlo7Li4D1swGO75JJW0MGVm2CoQGXNl
         si90HDUgjCy4uSzqE4TwOSqe6JqxAVuMDi7L2wd4DsJ+PMPb5fgPTf7bjJu+88+G17mG
         1o1zf9oCEF7YjcYRY4tfuT47eaJIzTDCiZVKoBUfwtnn30DdlYkGmYN5yQBKmLte+LTP
         UaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722294665; x=1722899465;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Kq2aqigLfOIOLKw3DvfLTvrf9ebVnlwFLXvqIP00zA=;
        b=MDwTijcda7A8x5uHMxSDX8Sj6aG73Es9C30scHLAIv5R2RG59ouoxmoPqZITbH45HJ
         DsVthbIkMncpdUAUaEi4MlAHU8Uc4jxrth7guUWiOG0JBhBhnToGZEMrqtN2v+ui/Mz/
         BAwlutOcm5mwdEVmK2p4BM6CbsL388tCDt7K10iD9lOKJEhmJZvGb/wSxbUpa5liyg5w
         umdrqNYKm56fEwmw6i5YxCTHS8SJT+yBj+XXIOtrlBpr968a8/s4y/r8xV0gPuMek8by
         h+4P08iBLgLcssGqxKhW5CIpDM+k2a1uYnrmbNby6FrxjGnvFD+CTuldSX1GfEVfEljc
         R/dg==
X-Forwarded-Encrypted: i=1; AJvYcCVPmwzzRgNm1KOq1XQUuCLyZuqXiOu5ICkZC3T+yuUw1TnaHivz/gdKn4daILWNv0le9FPus6CMcrKBrHbFuPfFc6j9JChyXsSVRVYzce/9kQ==
X-Gm-Message-State: AOJu0YzNZH7AWBha6Cu6AQDgvKjvMJcAXubrim8s0S9KzNQzI3h5xUdg
	gB1z9ulw3sLtrCeJtQDzyYKAgnVb+7e20Gyt2LP6yENP7sRONxQreH/XmYAZPwM=
X-Google-Smtp-Source: AGHT+IGVjl/yM957QxIvLIkxsZNfZeWQKhKMrBsGgDcXMwFFnSfipbM0NLq25wywYQ45nmmiDSP+JQ==
X-Received: by 2002:a05:6871:3384:b0:261:1eb4:dd7e with SMTP id 586e51a60fabf-267d4d16846mr10827646fac.2.1722294664783;
        Mon, 29 Jul 2024 16:11:04 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ba2csm7558919b3a.93.2024.07.29.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 16:11:04 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 16:11:02 -0700
Subject: [PATCH] libperf: Add gitignore
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-libperf_gitignore-v1-1-1c70dd98edf9@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAIUhqGYC/x3MTQqAIBBA4avIrBNKin6uEhGZow2EyRgRiHdPW
 n6L9xJEZMIIk0jA+FCkyxc0lYD92LxDSaYYVK3aulejPEkHZLs6usn5i1FiN5hR91Z3jYHSBUZ
 L7/+cl5w/u5juM2MAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722294663; l=618;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=5HHOtQIso9qtWjfwf6FJh2CMKju6bDNni/rw1/SKRoc=;
 b=DwvByIRDgyAFj0qhuwRS8O42MNVSIXMojZdsJN8l/DW3DXVf2LxIaBK449Pbd22gHagOoMFT9
 h3/IZuCdnw3DXsFXDcaBmeuJIgZgHsqj+hyzie3TUpc8kms/HWzQlk7
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Ignore files that are generated by libperf and libperf tests.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/.gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/perf/.gitignore b/tools/lib/perf/.gitignore
new file mode 100644
index 000000000000..0f5b4af63f62
--- /dev/null
+++ b/tools/lib/perf/.gitignore
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+libperf.pc
+libperf.so.*
+tests-shared
+tests-static

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-libperf_gitignore-e58d9b7fb51d
-- 
- Charlie

