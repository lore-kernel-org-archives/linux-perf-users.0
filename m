Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F496322520
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479450; cv=none; b=kcfXur3oQjH+AqlsQPRwkdyqFQh4XYdLesVhbgvLJe+MVBjRbZ9ZKxy7oe6NEjpPG8WUKS8jBYgGXcZULy13MP23ZxSGP6kEeT0vt4nwiKmLKzkKXIigms2kWmwclUocgAuEnoTfMGCoz4jwTrVu9h1JcS76HBB3GrmlEq3x+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479450; c=relaxed/simple;
	bh=m43rCnWF6W4flnZfWPAFH2zPZg0lP1fMO8rg5+/cqio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCX0c5hEEeN30XzY9j3pMs+f7MJZT4CE6LU9KZw1khizl1LapGwfNLx7osIwvXSliSIoOam99Aagj4y7VlvEw5rdubRnocvr4/4f47VwiLEs1nFf1X7epM9KVq1ke8FLvSSIPJLl1bxRuOirSWcqTC63CCvgfpYPSbrccPKWgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+jbnGCY; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+jbnGCY"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c1e7cdf0905so3126502a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766479448; x=1767084248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYARJPf4DCJHMSVJhsQ64ZrdejW7DqNqW01daFc7LNc=;
        b=i+jbnGCY+Tjw5cMI9Wya7LlBzHZpJpTT0InGTrCdtlkgr1/HMKdNnTXyvt+nzSgpZh
         wCWTVR2GxwUnZntnH5uFrsp80V/RFDHLxhxgUuTmQ3Dv9wzyQzi8/Ij/XGERrr0FM2hV
         AldNj1O7vw76ruMbdDHMxMtBTmXtQV6eWSVBACD6s3XJez5wxZFyy2exnh3rq+rckZDb
         mIPof01F+UE6pc5c52mJteg90cxNKgBtTnGCxjiDazy+Q+Fc5ykkxa7qTezEA9cHQPf1
         fOccBGZvnW29c2+sFzYEB8pEvlDfmE/sUj9o5wbWo51Hy2myUPMlVfpPEl0GW6uNLvxg
         DWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766479448; x=1767084248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYARJPf4DCJHMSVJhsQ64ZrdejW7DqNqW01daFc7LNc=;
        b=bkv1xDFpqZQOuDKr8yJQm3WRnlS5NLR7080c5D4Fdi9YDkmgZIpC6pM02Wm2xR7Evb
         7n2g9wRotU50lSz2dDaf2EBhzpIFwLqLNaeqrzGcyXU+bFsnwWavpqmin5drOqUOP9tH
         aspCbI9GL6uXueS0BakAeI7jNtA4bnmDIFSZvpX6vr/eHeHR919pa9u8FVo78QZ/bIq1
         IJ4iqmeUrCuSNs4PmN7OCUehCx9buZl1YDDMNwViNors/XwdQcUQ0gmAK/ZQEcCQRH7P
         ExL2Em/HaYnsLclc0Y2C/CjjzUWasQyOmD/An1o+hAc9IG6BawExjvsjJW2Z1SPqkvOM
         h1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpTDms2EiGm6dws4Hyco2MXPNdRkQlymshfHQT2INCj/PVICKTT3gF7U4BXtnrSHaeqOQ0US7wGuPl5DS5/jeD@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1X8eIDhLsAmstT2lsfmhoOHGMjQiaC46olfYKLcwXkzWH1yV
	x7jQSOLlOoE8g/q5yChiBASIamE+z87XV+2oPwNxuRxmiF77NAnjhdF/
X-Gm-Gg: AY/fxX4KbbBgoFyTkKcmEzkqFEkeye+opYGwzG0IPIhpJfnXq//tXFswUKqkieTF7lT
	lsDjVmRe6gfGqnVPVjEfM/BKcmcvZ9Yti9RD+zh/0iwMCNcbPSgA/vhank3gzXP1vsn5vrShMTT
	+t0bZ0m9bexqLeYiC39u/0GDb1o5g+ovGpa7sAflG32Ht4rxF8r4ZVWTAZgzpAOmHKCq/RiLrU0
	GAD8KwuyvzAr6YL05vZ44zrc1vx07qXJzINiObApdfiyS+yvJCn7g2/jXBl0z1ORRMqK7Vi5g2c
	bJwwMvcT9Ag8STY/hBFyN/GFn6WyvyvaA066LpnvKC3A4sfLupYXorXKdr10qXzKoYsxH0PnBd2
	RTuCZ6Ia2GCjLkKQIvHvDuCiVuIkuPx48X9Vi9kQYARykKpgkQX7+n4FpNWYR3tXADwJvPw7snC
	BTOlMVb+IpO1VuWqRjJwsoSbEykA82JIYvCK18
X-Google-Smtp-Source: AGHT+IEPBzpa+JSlltoi2sicjexlhwpONg+WQbBsfL7i+rkHPN4HgKra3RHsx7N07jEuGnZtt+CPGw==
X-Received: by 2002:a05:701b:250f:b0:11b:9386:a3cb with SMTP id a92af1059eb24-12172310ff9mr8272832c88.44.1766479447624;
        Tue, 23 Dec 2025 00:44:07 -0800 (PST)
Received: from HUC.. ([149.34.251.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm56720887c88.13.2025.12.23.00.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 00:44:07 -0800 (PST)
From: hupu <hupu.gm@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	hupu.gm@gmail.com
Subject: [RFC 2/2] perf build: Prefer kernel source headers for BPF skeletons
Date: Tue, 23 Dec 2025 16:43:35 +0800
Message-ID: <20251223084337.3789-3-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223084337.3789-1-hupu.gm@gmail.com>
References: <20251223084337.3789-1-hupu.gm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building eBPF skeletons with Clang, prefer header files provided by
the kernel source tree over headers installed on the host system.

While host-installed UAPI headers can be sufficient today, they are
tightly coupled to the host environment and may diverge from the target
kernel version over time as the kernel evolves. Relying on kernel source
headers helps ensure that the headers used during the build remain
consistent with the target kernel version and reduces dependence on the
host build environment.

This change adds the kernel source UAPI and generated header paths to
the BPF include list and places them before the system include paths,
while still keeping host headers (CLANG_SYS_INCLUDES) as a fallback.

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8b8647fd4f41..57c73ab98703 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1203,7 +1203,13 @@ endif
 
 CLANG_OPTIONS = -Wall
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
+
+KHDR_INCLUDES := -I$(abspath $(OUTPUT)../../usr/include) \
+-I$(abspath $(OUTPUT)../../arch/$(SRCARCH)/include/generated/uapi) \
+-I$(abspath $(OUTPUT)../../arch/$(SRCARCH)/include/uapi)
+
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) \
+		$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
 
 ifneq ($(WERROR),0)
-- 
2.43.0

