Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912F3FBB3;
	Wed, 28 May 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459514; cv=none; b=IMzMvVIBjDEno3TRxeOvMSmV4H2eaTCH8mUkSbBroWkAHr+rxFOX/533sepI/vPr3MQkVyD9Xiqa1tOob4duq/lvONXGDeK9Xawdtw0Kw1vl4sZJ/UBrVIuXdyninHTvN+m4caoyJft181XIoyHYMOqThwdVu9nt8u0jlQhpj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459514; c=relaxed/simple;
	bh=8TFIlL+9Nqb7USj2bx1x7nSvC+emH7rIhEN9SdoxRiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StCkCEveJbBleoG0DS7j3i4XdjV6MYgCBg12wFLy0OY/hOO8XgPawH9NBsH00SMEJcvLQGoqLLtwTeR908nVWKWY73Ndt+s7UZI0i21GbC4mOXZ569jE5i/zO+1JuOskzwEg8YyIu1pOg0eSVmMNtBB0WTk6qPUThP5CTFczJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enhU+Hlg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enhU+Hlg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234488c2ea6so2083445ad.3;
        Wed, 28 May 2025 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459513; x=1749064313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ujzt0Z1mlstm8/GkFppvnEuth0oQ41DBzEMpZiCaoQ=;
        b=enhU+HlgkxxbfDvV+aM6elNHOOzte6S3aNFJ3uHh7LMG0SINPHDLyeegv4uV2Hc4Oo
         mfh/rGQbITOnSvt+mQ3kRsjDZO8r0yy97vNkosJzLDbwgAV86RH2RR5T6p3DVwNvLdGl
         ETrFjdo9Xa1aBeuBaBJlVGQzLIC7tL/na6NFMgqVLHAIrWmojQxxaIa6H7WbBKj4R2P5
         H8lMq+imqABjVSQG0Us6WKjWgOZbqPVyZsv1ADunP57mbcclm2lijnvxgMBCQQm/Ku5p
         FVGrKbdyLjrLqFue4my5tCj498H+Prc1O5LVoxnW3CBnSbdy7FXbeeCinihHFM0QuHAS
         dHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459513; x=1749064313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ujzt0Z1mlstm8/GkFppvnEuth0oQ41DBzEMpZiCaoQ=;
        b=ikDni09GrnQZYkYOSWaezf9uSiJHbJ9r5KxSr0tz6pTvNgXk1On2/Y1BXIFh3l3mBa
         jBJOWuo5N25avfWf3ha1ZDEplbQ1YLQmChXOlltcqp53RqEv7aavhauDVrAQcIGzd2eQ
         dkCxO9mkJ/+QWkCWQxjkhmVPkbsypI4fhgRp8JIyEQeoo+70AAcH4wuxOVJ67JK8d5Cw
         A1VL2qP/+O6cSLpeoMnWNg+YCVp1vphEpSqlVyrm6Ht+SNpzejpKllKE4Y1S9XatLv7B
         NXVAwy9b6JMMiumJo6imYF5XAbV8mFsPkY9dGD4hVfsRnOlJ8i04dI8ukMfLbHyvsUKj
         T49g==
X-Forwarded-Encrypted: i=1; AJvYcCVPxPvfmlcn7kZap7GEa1ihF6Sr+1crlG20ZahQftX9OMvbDNvCZHYNTMdSVhTPoe4kxBNc/tBlVdrWllc=@vger.kernel.org, AJvYcCXXAWpabTVxjo2r/t9HqlKq0XP4iU59DOw4NGPKua7pYH77uhIBIk5TcHPogxGFBXoiGZPKUCmJI8t8Im+o4zdcXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5VmZ7iOqe+I1VHn+aejKLAOwzSZ0OvxbBtZIjPJsc2cxx3RmO
	679ODrlZ4Zc9PK4n16PtTIStx825yzPOX/Euo1nn5xABgnFitcAVRM3b
X-Gm-Gg: ASbGncv/T4FvYqIEdpzn9nWoeUYzgfUeHta3vaPEM/1Q9XvfBOfT5gVVRsyVS7Ua22W
	AwBw5C6XjiaMtiGe3AuDbLYf9KzpyedsGRyMa57dvoSmn7j0SY5qc6l6F0P6xZ2eAcmMXEIbn45
	5bCZOqtxbp7s2vdYvlGPvxe0kdyMMql0sguUw8V9X2e6H3VvJ2pS1FQi7GhK1AHsX4iRJP756h0
	gN43ZbVmHnx1fwxgVZBpteuZzqwyaYTjyrbsEVlVMDV8DxluArnFFAqTRqWlFdz97FzT/zJn3l4
	l4wzBy+CsohDBzOL4wx71wzGk3tvKH3EROE4pEgndH/qrQsy85+lVr3CXeamGmZR9lN4JVYqHqV
	T3UgNPy0j3ESFvkvncEDl9g==
X-Google-Smtp-Source: AGHT+IHHENbUvE1xyQR0GWXCL/LYwifJL9esyMdBjg8U22FGiu/zP5RTwtpJjvh3OeKLcWK9mbvoIg==
X-Received: by 2002:a17:903:2449:b0:234:b12b:a2e3 with SMTP id d9443c01a7336-234b12ba39amr101995595ad.29.1748459512627;
        Wed, 28 May 2025 12:11:52 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:52 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v3 1/6] perf test trace: Use shell's -f flag to check if vmlinux exists
Date: Wed, 28 May 2025 12:11:43 -0700
Message-ID: <20250528191148.89118-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250528191148.89118-1-howardchu95@gmail.com>
References: <20250528191148.89118-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To match the style of the existing codebase, no functional changes
were applied.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index f0b49f7fb57d..b3775209a0b1 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -17,7 +17,7 @@ skip_if_no_perf_trace || exit 2
 
 check_vmlinux() {
   echo "Checking if vmlinux exists"
-  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
+  if [ ! -f /sys/kernel/btf/vmlinux ]
   then
     echo "trace+enum test [Skipped missing vmlinux BTF support]"
     err=2
-- 
2.45.2

