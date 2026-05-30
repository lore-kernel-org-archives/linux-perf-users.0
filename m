Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A011D63E4
	for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170930; cv=none; b=CwIupVjvSzA7256ge9LEgWg44mVsr/4wqHjIylN2KBZpsC+BVzTlqPHt9pGYKIQSVT0Ny8UBO4q9Nbnlsj9tNHt3rE2OphcOZhRSpGj4At4RCrrYsylJUmXOsLMF/8Xb29ags0r/ogbcXQG7C9UyzAwbhoWLexziRSj8bcygeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170930; c=relaxed/simple;
	bh=TBa3sRrVaMH48tnP8EWiWrMR/ZSgogjl84sEm6HnC8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtmxJbpjPWYd9B++F4Ehbdaq8GNbNGGJWUHBmHmNDClnxzNpElr5llHfbWSZwxjVE3RI5Yo6Z6jMQVJrJiO+1ZfztwH4zKmtnsx+coUwa6AljIix27udJKXr5YyhBQP9dOu9xjLhnA8Jp+H6e67icVXHL8e5b3cPTxnRylv6JKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPRlhPFc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPRlhPFc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso16389545ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780170927; x=1780775727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0UeJUJcVQbZfzNj+MXjc9tXVaSkrDc9lM0pPOG0N5k=;
        b=MPRlhPFcgCtacB9XEH3adbHqKNWHMPka1uTO3ReYBhnHxC0D/3csnGJEN6Jq69Eq3S
         +dhBzHmEVbMxpJordNfJ/jsU1dp/tKAoPrXtx+ypM21YPkM83tfaRuPlWJsrsGKCERMh
         iyRexzn1R78Ol4lXIUVyCvdHqeY+TwMq8UH/ijk/MFeGvATuCY7eD2IHcZcrw0wGAgf8
         T3kinjRVbJJUloh+uiBTgoJhP42ZIF4I2Ls0J9sUT3cGPkNSv/CqqJY/b4DS7G1kORWh
         +ebjsurdult6vFyesW7sA/QqdmKZLBUGvQdH+Fvw/s1b+TbX2AbUHJJ2GCFDV7a9i9dA
         syfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170927; x=1780775727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0UeJUJcVQbZfzNj+MXjc9tXVaSkrDc9lM0pPOG0N5k=;
        b=mKfY2LhDVnCDSlDBF4cfInJDsk8L1oQTKTWkESoT3jtCk1BJS00VwflBJlhqgIGEY5
         m/f0WNSsik+obC2DH5ZwKONk2LpIYmRc6pjSbhHmBSsJUriQwyEGhYBq0ky4GVF5FQSV
         kgJYhJHuRtAQG3NhvntzANDu85jhW0GWOrTPo0M9Wtf+D50ZdT+bGLpKHrMSqF0ePfww
         HYKmQxJsjjodsBWu7RlJZmqkrKLirrUOtHYoH9xVucSeHNZ9/bfli4mukfIdlEZmXIGu
         7y6arvFFbgUWtBffVTr+nHQ4CbC2/BnVn0dj7OixcIDQXRorwSqKhGkRa8wDE0M2tMsZ
         kEgQ==
X-Gm-Message-State: AOJu0YzDt60RMwFYUaRURQkqboXTyaT/6a6ZUd0Jdxw5fWbjk2d8GFjW
	Ge5D93CB63vMrfh7vjoDUGL3s+fHyYFIvcCU3vgkIZT6f/0xD7Fy9/0v
X-Gm-Gg: Acq92OGpZxz+w0pqxthzL/g+LVRhNbE7ltCQ8NaVPJKb/c0wu10OW/PS04F7DQruOQ5
	/ZRk6p6gIF3XIK4NRi1Hv5spnCQyJ7pd6E/pXFHt40Qw6h5Pbf7WH2x3miwMP5gQJWTbIzlIKno
	PeGWxr5grGzHdpSkDdDRiTzJ+KQT/DfJ4jee7icOuA02LzYo62IHlD5vrWpPwlJt0yOxVG8oZjs
	iHrAy9L5B0T38uvgqp9YKZLW8jUdjwzpsSsy7KGm0FprWsiSXn5mcBiMZngXmlz18nRNZc/L0DJ
	Y4uwt1NSWSsi2PcdhHf1+6FO6aBVbEEx6ZQlrWtWJuYfPlIdLAn5WhnflxR3m+amMd6tRCf8Ghw
	+V+4BmLLqxa5x1uAwuia0D+fSlou/pXlcerJmQs7SuwnuDAQdkJNQ253ASMBfgzJM6T4EO3OZRt
	0U2ioV1HfTuXUsYSLJ7MLCCPy0n77DVNdlT2Z8CQdNtis=
X-Received: by 2002:a05:6a21:3a47:b0:39f:1f92:28e with SMTP id adf61e73a8af0-3b42823a98bmr5703739637.27.1780170927280;
        Sat, 30 May 2026 12:55:27 -0700 (PDT)
Received: from archlinux ([205.254.163.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214ce54b8sm5304674b3a.48.2026.05.30.12.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:55:26 -0700 (PDT)
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
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH v2 2/2] perf build: compile BPF skeletons with -mcpu=v3
Date: Sun, 31 May 2026 01:25:10 +0530
Message-ID: <20260530195511.71452-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock_contention BPF program uses __sync_val_compare_and_swap()
to atomically update the max_time and min_time fields in
contention_data. This builtin lowers to the BPF_CMPXCHG instruction,
which is only available in BPF ISA v3. Without an explicit -mcpu flag,
Clang targets BPF v1/v2 by default on older toolchains (Clang < 18),
causing build errors when v3 instructions are emitted.

Add -mcpu=v3 to CLANG_OPTIONS, which is used exclusively in the BPF
skeleton compilation rule.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Changes since v1:
- Moved the -mcpu=v3 addition from tools/perf/Makefile.perf to
  tools/perf/bpf_skel.mak, following the refactoring of BPF skeleton
  build logic into that file.
---
 tools/perf/bpf_skel.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index 7704e7e635d8..f2559de39f96 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -29,7 +29,7 @@ ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
-CLANG_OPTIONS = -Wall
+CLANG_OPTIONS = -Wall -mcpu=v3
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 LIBBPF_INCLUDE := $(abspath $(or $(OUTPUT),.))/libbpf/include
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(SKEL_TOOL_OUT) -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
-- 
2.54.0

