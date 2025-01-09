Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A162054EB
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736466943; cv=none; b=rB3DhFkFOg3PJZP8HxYm3mypltSaIaBr+h8S1YivXklzJXOV3YB5ok5/S/kViwSrSLw3VY9s1pXRAdhR8BCv3eczg5KX3ZAsxwW/7wb+H1npqkbzq6vzZfhmrWGdl68sDOXwd7uykOo925j7HbnsljPoXEOSTGpx9upyqHweXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736466943; c=relaxed/simple;
	bh=rTsfY1Ca+3Wci18oA1YR1Rf7nR13zzGxhA8T4bfDLyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p/kpNBGIl97t3O64uX4Gri6SgqfI7kmVWL6iEsYJwZHoVBIPVdzES938wcLdhx94oxTDU+jM5VMitifgnH2qWDztR39Lu3/EhvP09FOlYQ1G/IDi1bUV1qB0YZgruKgxsWuaCP/qAAY8qtEieuEMBPfqZT2WNKkc/36qBgvCUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Sc+viRec; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Sc+viRec"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef748105deso1989841a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736466940; x=1737071740; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LN67CJbB8Mip8IR46/wKyKbILXZ1JjpjFgyAJ5CXYR8=;
        b=Sc+viRecXu/QT5eByAYHUKhURFhKkdf7005kCkT/rWMXzhG6uITwNRogJ5jZ9v87pL
         hok9Wp2iy8PEKhNWGQ7jtp+SmAn5xOxzf9FN6nFZlML4QOuKlFX8xf5ix5I90wiXaFFZ
         EuX/Iee27HY13DUgLxiUTIoO2gZbmJ1nRoVVbCkWVCE/6qWZu+XlCpqnBbSxOkM1fBmA
         7A7NVUsq5Ec+shruJFs9lXiUZomIN50o5I2SUSTzBeV9UzfWcDoTdR2LjYNkhWIyKZmZ
         NoykAi1R5ubEIny/iK7XO/V1Kw1XJRcljJ9Sj6dHlYq12Dpz90zLP6JAkFQOpvAR5VDY
         2lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736466940; x=1737071740;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN67CJbB8Mip8IR46/wKyKbILXZ1JjpjFgyAJ5CXYR8=;
        b=V6L8IQf4vNUE0tn4vrPKNSvlg5sW3MtFamGYfUZrg13F7w5OhwRpXWeDDySITZhwIn
         hP4qqV7ugwnPXpMQm0LLAs1ocuo+6QBezJTR0Z1naz9Dg0yY/pPvvMLgoLcIpIQgNdg/
         i6RJYb19NwnZUt8Wi+X0IzgDMbjfTMv/DnjgyA/EgkJl2AUp69PSKfaEr/kdwRY3VzdI
         6CSrv31rtF4dksroYgP1k18p4bw32NNRXhOE8slHbmfpmalRKSCiQe4rxN9hsCo+EW+q
         OAaD/48cSWH9BIsL024jDryvbnxfXTKvku360XAB/1UPpu/+Q9e22rhYsI7WCDjcfpJA
         gATA==
X-Forwarded-Encrypted: i=1; AJvYcCWwuSfxhjVyuysmPyofpi+Q5iz24kaC3qU20jtt/+93qnT9uMmPS6PvPzkFJC4E+6eOveqhdYQARoLlLZ3cJYIJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBiJy4S/EsIwkHYVhh4OfrUQnsymLqhGT3+dzRXcBT77ehc7kO
	aECXA/K5rwKw02Mr9O2WzKbvcH3kzy48p7caNOrfZFGbctCrZG/h/x2QYojW+A8=
X-Gm-Gg: ASbGncvUADh1V6Hv/lfF5vZx/8EyXiCkDzFlo1xbwmJ4plRqjTKIChVQHvhf8o5huqR
	Ha8Zl7mq4irqyqQmj6fZeBKCbCiCODUQ81Uggaet5hp8kuNKzc/eS1pE6JVuO4gcmgx34whGjlQ
	pp/JFPG7aAtySiXQnUaxjvqEc03ZjKZ+6Y4CdBYItMTcl7qshrU6AU6QbnBW1E1ftlsARy65B3f
	ikEUMJvd0d/oRUG+91E4ctf3/Qe3J019ruZ5JU3X+yPE3gZDa4g0iKL7H7cfrAmb9gfbFPg
X-Google-Smtp-Source: AGHT+IGUKWIjPtfJlvYCB4y2bpUp91TfD1RB6W1I7BilO6p5ty6uZxJYGCz6YQyEf8u7l30zl5qfpQ==
X-Received: by 2002:a17:90a:d004:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2f548e986abmr12437805a91.4.1736466940169;
        Thu, 09 Jan 2025 15:55:40 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5594218b4sm2092774a91.22.2025.01.09.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 15:55:39 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 09 Jan 2025 15:55:22 -0800
Subject: [PATCH FOR-NEXT] tools perf: powerpc: Remove spu abi
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-perf_powerpc_spu-v1-1-c097fc43737e@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOphgGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwNL3YLUorT4gvzy1KKC5PjiglJdS2OTlKRUQ+M0AyMLJaC2gqLUtMw
 KsJHRSm7+Qbp+rhEhSrG1tQAY5GDBbAAAAA==
X-Change-ID: 20250109-perf_powerpc_spu-934dbe13f028
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=rTsfY1Ca+3Wci18oA1YR1Rf7nR13zzGxhA8T4bfDLyw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3pD4i+dWfX+b+a0cjL8NzRLPj7tiVFE+5J1tXHHhcPZy
 i5d29XYUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwES0gEbVsS1Syt1bbaM6w25W
 hILYsds2H7y23JkrPMXa/0vh6r5eRoaLXY+ebMgImH3ii8fhS1Ps79VIHvtQ9a78n8MSpgf1B8s
 4AQ==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The spu syscalls conflict with the syscalls from 32-bit and 64-bit
powerpc. Don't expose the spu syscalls through perf to avoid this
conflict.

Fixes: 7eca67cf3dab ("perf tools powerpc: Use generic syscall table scripts")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Since this is a for-next failure, it would be ideal if this could be
squashed onto 7eca67cf3dab ("perf tools powerpc: Use generic syscall
table scripts").
---
 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
index f7e87a61401c14a1d3a8a04fe2c8ecc8bedcc1b0..e35afbc57c796cbe5bc765852daac5b3f5bf8433 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
+++ b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += spu nospu
-syscall_abis_64 += spu nospu
+syscall_abis_32 += nospu
+syscall_abis_64 += nospu
 
 syscalltbl = $(srctree)/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl

---
base-commit: cea42d1a85628348fb6081c2856a0ea73cb48f3d
change-id: 20250109-perf_powerpc_spu-934dbe13f028
-- 
- Charlie

