Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E884D2B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898186; cv=none; b=kDHW6kSkRdNKwWKy2MvN9A2unFki3JdtMOO54MoQZ69MYdD3q/1j8JpzQPZJ9oDhGFarQOhamB/+OdfAwn0HNPxbBbC62OvuYwkEuc7+xYmlXr/RYgDXFYQzj76t0Z2yTlQMHDR8mEp9N39qbywrqerhBTOAxmwlS9Mc1JiRDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898186; c=relaxed/simple;
	bh=Ydu2Yz1E00sUEj4Ed1vxHc/PS8vtDZMI13MrnBy3FkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QapZsmT10JN7GEzPitSMxZUIXZ9ng6mjDyGGZgrsxSRunfMKQKwmuqosq4jtOWoJ9B+0Ob5E0EoY0p0LFLftz3J120IPwvYxAmyL/yfDkSUNp5ztN7CoLRAdiQpcXXFmVa6hSib42llpMs+AQGOFz5wkY7hUNfIEcbdVOGViKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jj+r7ZUF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jj+r7ZUF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so693254f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744898183; x=1745502983; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXhTINwLr6HznpVaOhVrq1yJFn88hVYRlRbvjn7+b/8=;
        b=Jj+r7ZUFc/oRUOsWcxKEogqu8RaJ4hg1u+cSOPdHnh7ys+6r5Tc0tmzrDa7zzowiMr
         UPPOFv8o+l8r7IuaCO5svItZTE3g1SL/W0gMPSzzgErIlsL6IzSKXmDCkwj354orjHgZ
         QctZk94zqOeqfgLwFgQiD/VIVZyUJaX5WmYbAX4ufy0oeQDTqcG2nQYKp+sikak9C3xJ
         86FklFUst49bNk752WR2Gn2OUwIkc/c9eueGLX9uWzMmy8KZWffarO8DYVS/KRFKXp4u
         b83B9sLqi39AGxEgcUxMfdFQKW9wzvb1ZRtxTtnRWXMDBhBJGlTZ5VflaUviIi2lR0Nt
         5LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744898183; x=1745502983;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXhTINwLr6HznpVaOhVrq1yJFn88hVYRlRbvjn7+b/8=;
        b=Oqa9PDGi7IwwLmsZKCw8S/1QLGo7K3TJEQ8wCkCCN3xnycA7Zt443ExIla81DpbujT
         Y1xsb23LrSjNUfbnkSD4p2M56EQGSpJf1KN0wJFAvty24PzLTiQ50ipjL4YSyYklvAyo
         F54WAwYB4VNc9Rx5p/I4LA0yxkXcz76/4zF4kdWV5Ir5vd7Gl6MoQ+ixTLSO7Xg31Y23
         NrBPC85GdQZt2Zl5gpe5ieblliRvDfURkCkyH96Mxt6C1bJR6tuCvE9ooQna8fey4Hh0
         eJcBWBszmz8rS9F4f33RsMgojoYa2tXdTOzpxx1/Kbyx3w0fpD5kCg2AWkZQDyrVm8Ri
         76GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXke1dKWhsS6pQXDfWnJlMY7A1j7V3nxLhitUarglpV29YAzdwIeOHbSHw6rgocFzWTjCdQ2FGq7q6FGLV4G5X6@vger.kernel.org
X-Gm-Message-State: AOJu0YyNO17wY8o2+S64sOeIqm0NJ1Q04Mhy1M5Yd/HsFVIu/h7j8E3s
	njCEKB/HN+5jKudCczQueL/1l9aXHn88XiFIk+0tPwtdBXXjsOXUrhmwdMIegxiVs0IdCYiAlwB
	Cqu0=
X-Gm-Gg: ASbGnctzMLuuCdeiS21X+Dhh96fs7ws7ANsyq4wW1bQS0BYbQhpg4ML16pkqnrBCHOR
	inxRZgRJkOTti99PgKKNtc1NrwJ+UdSRCdqezydUPv5kWaLMjtat+PrB3kW5AYxQcmNGPA6OkYy
	wfs+IN9CDRe4hCHPGwTHRnSncjwB7QvhzEoRQp1oE+JMt+tUoV2ZmawonCSO7UAYtGrRtiGkPsu
	/QM5XJ4O8ujmE4NJ1Lq5Epwb2fp5xuSeUrIzd0B4vU//pcKakGeXdYVcms9dPG9Q1sXVx4o1S2N
	9dogFg6K7NTbOSYOrGZHq78V3Y+wJA67z0BPAVa4z3xGJL8HioC11/yviw==
X-Google-Smtp-Source: AGHT+IFHL0movjLfsOFpDVRs40wjh4jDI7ScAxPxFeXZYxWlysH5Zq7LEdqbZk29hyWFx71sssI7CA==
X-Received: by 2002:a5d:47ac:0:b0:39d:8d54:5eac with SMTP id ffacd0b85a97d-39ee5b13493mr5487041f8f.11.1744898183050;
        Thu, 17 Apr 2025 06:56:23 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b50b897sm54879955e9.26.2025.04.17.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:56:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 17 Apr 2025 14:55:50 +0100
Subject: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGUIAWgC/x3M3QpAQBBA4VfRXJtarN9XkYtlByOWdkok725z+
 dXpPCDkmQSa6AFPJwvvLiCJIxhm4yZCtsGQqjRXOtG4mI0ED/IjjnzhRA7llsGsK5rK1r3OitK
 qEsLg8BSSf9527/sBlh7LN2wAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, arnd@linaro.org
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
headers: Update the syscall table with the kernel sources"), arm64 is
no longer using a generic syscall header and generates one from the
syscall table. Therefore we must also generate the syscall header for
arm64 before building Perf.

Add it as a dependency to libperf which uses one syscall number. Perf
uses more, but as libperf is a dependency of Perf it will be generated
for both.

Future platforms that need this will have to add their own syscall-y
targets in libperf manually. Unfortunately the arch specific files that
do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
into the Perf build. But Perf only needs a subset of the generated files
anyway, so redefining them is probably the correct thing to do.

Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/Makefile    | 12 +++++++++++-
 tools/perf/Makefile.config |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index ffcfd777c451..1a19b5013f45 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -42,6 +42,7 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 TEST_ARGS := $(if $(V),-v)
 
 INCLUDES = \
+-I$(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi \
 -I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -99,7 +100,16 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
 
-$(LIBPERF_IN): FORCE
+uapi-asm := $(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi/asm
+ifeq ($(SRCARCH),arm64)
+	syscall-y := $(uapi-asm)/unistd_64.h
+endif
+uapi-asm-generic:
+	$(if $(syscall-y),\
+		$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-headers obj=$(uapi-asm) \
+		generic=include/uapi/asm-generic $(syscall-y),)
+
+$(LIBPERF_IN): uapi-asm-generic FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
 $(LIBPERF_A): $(LIBPERF_IN)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eea95c6c0c71..a52482654d4b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -29,6 +29,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 $(call detected_var,SRCARCH)
 
 CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
+CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)

---
base-commit: 2b70702917337a8d6d07f03eed961e0119091647
change-id: 20250414-james-perf-fix-gen-syscall-a8d9b4367d07

Best regards,
-- 
James Clark <james.clark@linaro.org>

