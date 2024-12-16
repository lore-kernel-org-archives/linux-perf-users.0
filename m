Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A41D90A7
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390807; cv=none; b=rkIMHf9r3sXi79TULwQ1kKGgO12elOzrCdUeYkx9SpRP+rSL3+48/dMfcINcUKhnCb3Q5X223XWYapYyrm/XzlqMlvFnMRqw/GvGUw8HdaG0NOSyLrkKeBE+IotOoJYPSq5CHcXsxAi4ocj0dj+bTuYHXEcJjTTMaqQw7qBzti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390807; c=relaxed/simple;
	bh=IOgGM2w7pk3oigV1gqLUmR9Qqpa9O/Il6zfGw3fe3jI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L3E+b8t/XitxhvfkTrzIHZzG6XhNRrAMC+WgDqVTIDigEduy93lZCLDljgtxm9vv6LcYQYmYvsRuLsQU7RnRCfzKSCxl6nn8m7d5f6BivPJH8kYF5/OtVjXT0RAfN+tS6M+Pu6H2WtGUCOuzx+uxR5J820eQhIG6+EYFSnA1cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Eytt7KwO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Eytt7KwO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2162c0f6a39so50346155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734390804; x=1734995604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cbp0zEgt8sYGgGttOagenj605vUWFx5sipZ2Yl2U3s=;
        b=Eytt7KwO0WU2hyUIdW/6GWYKKe++eJXTFSyWcq8AVT9BM8fYi87jMhv+4jfU4DW/SM
         hyLHneNQV0xzTXpk3yPCrpVdUrEIFzxcnMLVAN8Seik2D5kEC5bk9Qp4NYt2kqf1VUOs
         AztXLshVs0dm5EEM+UKBfE25F8xJF5lP6qP9kmtIg8d83NTQRbWfK2O4Ky0A1mdIva3s
         FbBBy/+qT1gBazRFleWvObp37aF/olvT93vmxU41bjTaTJ1m/YG5UY89kW8JloxQB4sv
         q4Aik/spGo3H7zJuXsuJTNyQjRm4ZabM4mdtwH7f74EH68eGaQzuJCQ1L3bNQpnOX0lH
         kd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390804; x=1734995604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cbp0zEgt8sYGgGttOagenj605vUWFx5sipZ2Yl2U3s=;
        b=ccTCqH9NUV1wsakHifJ3ClxUyGnW016OR8xm3/XJrH2N4GUwEDLuyaHFzvpiu0fqlj
         ePCnV98CZIbRpKkdOLwe9KD/ct6q6FPfYhHh7SQJezQWsXzfKYwpKPAF13QkW1MSO82M
         EYiIow2XdVlLic82xcG3v8lR51sdoxu7akVclTjyiEJYjI8mc6/73/FF73pV+cgLEPfG
         +SDYJhCQWj76+y3niq0Lt18yoUguzeldIwmNncpfPtC6K0SYo7pFEERhl9l2B/ud8AX5
         uJFvStLgpe/PSckBzVFSA0JFOHjYAOhGc9rxCUgmevRqsQ7yH2u0iN4knBHBDj8w+PAI
         /YWw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZpWIiHpe9kL3aXDHLMo755n60wFu1+ewSnyAsKos6jXS4IrIqmrS5MOFU8ljR8U+rXZ0loMUwOGpwQ7Aim5V@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0GFA2lTMPoSV4OBsIDKL5utqVYmvABnG1qrPeGOfsNtbYyUr
	egG+F9PzWuutEFqsBNG97fMyuFi5SX1w2WxW0E0ZR0Hh/QKtQ3H1FYirJ2yV428=
X-Gm-Gg: ASbGncuVEn2bRgTb7kD+ZBSMJPcFdfst4FS66195OoYwJcxt7iuLwLML7Obcse8Q0jn
	VR+x8v3LGLau6qfNm1mXWTs9JoER+xm8jaEXXUoDOFMqKzWsFThF27ZfRTKHD5+KtppLK9nCJaY
	ProqUWl57UUppJSZeEUGchynMyVvK5gfoOk90UhquEY1CZcF6Nsl7q2ZRpivnHrN5quZPYVYDvM
	d8cedIZXHz94kaFdGQkZhfIAmmgiboIVTO0+xBAaZd7zkjUSloPqwqzEhvY35qcIxWbneeh
X-Google-Smtp-Source: AGHT+IFjshciKlmIzBIB1jw3LAR8ZYMAQPyyhOAHw8JXPxmnDCkeL3I1RpqctkebF7xjVj+9QrljiQ==
X-Received: by 2002:a17:902:e94d:b0:215:b18d:ca with SMTP id d9443c01a7336-218c9262d3fmr19286865ad.18.1734390804203;
        Mon, 16 Dec 2024 15:13:24 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc47bsm48333255ad.63.2024.12.16.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:13:23 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] perf: tests: Fix object code reading test for riscv
Date: Mon, 16 Dec 2024 15:12:50 -0800
Message-Id: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKzYGcC/x3MQQqAIBBA0avErBNyLIiuEiFqY00LixEikO6et
 Hzw+QUyCVOGqSkgdHPmM1XotoGwu7SR4rUasMNeozbqIok28mOFc7jt6Q8r5FZOmwrOxw49mTA
 OUAeXUA3/+by87wdZlscZbAAAAA==
X-Change-ID: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Nelson Chu <nelson@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev, 
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=IOgGM2w7pk3oigV1gqLUmR9Qqpa9O/Il6zfGw3fe3jI=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rCFo5+3e1tQisqpS6cac/wyM1MmJaWySK9PGtBBvOv0
 6Xbun91lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBG+LEaGb7e2ZHT+jXg/4T8D
 c2X1sxcK2mW1O46Jy13fG73kPPv5XEaGxZM1Cxg2/bUOU7Tlnu+i9MlYSu3ZjWSraXInZx/vuze
 VAwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

There was a breaking change to binutils objdump that causes partial
instructions to no longer be dumped. This behavior is different from
what the "Object code reading" test expects. Add a Kconfig variable that
checks the version of objdump and conditionally enables the perf test
fix for riscv objdump versions effected by this issue.

A binutils patch has been sent as well to fix this in objdump [1].

Link:
https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]

To: 

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      kbuild: Check version of objdump
      tools: perf: tests: Fix code reading for riscv

 arch/riscv/Kconfig              |  5 +++
 init/Kconfig                    | 10 ++++++
 scripts/Kconfig.include         |  6 ++++
 scripts/objdump-version.sh      | 69 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/code-reading.c | 17 +++++++++-
 5 files changed, 106 insertions(+), 1 deletion(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
-- 
- Charlie

