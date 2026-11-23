Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452420;
	b=0ct+ujmYIXRh1l73yw0kNvfe8cqXeYkkFbv/9673P6ADIgteGRGOZ5Z9D9h+H2mk8MM5
	 zNvs19Pbztfiwc4GHzCO9hFQX50vy7R8lX3zDRn2eUV2LvYYvYJfqllwo/kK771AglCmV
	 665SgucFgMRvAvuiyeuktpCkW6aS/ygPzl8H6aiXKoPuuGVRLalDMNL4oOBFCaSmK044c
	 27AUO28lnKxX7ReOQ4XWIUtwD8YJS0W+p92efAvugp7UfwA4gOWLF/IkhptnTl7qB/nLF
	 6hBGwCWwcD97FjOrqEEE3cEBaxaMGJQTLMlQ1LVd1pqjWl0rHNW1nkgpXUxhf+TbKGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=38ThHGN7lYw60F8stffW8ELZ5EIKExZvYvBv6qCER8M=;
	b=xtp+oNfXhf2vHaV/qq7eQ9IGjipk38B+wJVP8wVoXGBRn3Kgsl8MgC3dz1cNGxfXCqXZ
	 QjzzmrJbqCJospoypcsLJ/jrIpYn1g6e+s0DALLHJebE4oG4inozSlbdjF1GwTJtTtB6X
	 34RQrGB1nAbz1JptSoM3P/BhIRFLSe7C8YVTqkYKu4Rg7V0qwaheN1vxuBwHmA6UDU6YJ
	 oVuBpIugGvK/bfDQ/iFmVx5ughZM7PRNu/I/8eUmonuT/4GApkLFoajzu6l5rKwMRr59e
	 o0glxGZv2Y3/2rcibQ9xGgU6Qfx83U7RHXTSau/WxNnLdtiDEQPdQeec++WQ6bMKukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jJC9oaSW;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD82606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 16:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jJC9oaSW
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so2706299f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795452417; x=1796057217; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=38ThHGN7lYw60F8stffW8ELZ5EIKExZvYvBv6qCER8M=;
        b=jJC9oaSW7CD6jpJ1jOiTOA3zsBPz/z2c/NP21tUzNtSOhbywSVGN7U6oA/koRxRuBd
         Ck0x5sEn5YhXWAXu+OnJ9cW2M4JPmm3yzQBr03X8bpeiwESMAbGZvgpqpX4tPlwpZa7I
         /BhrTxzbstx4+MlIdWMfirMVjwAa7vqt8RxH4A3kyB9cUP7JIxOgrK9arK2VQgpLMXyI
         AsY35X3pxCWybG8b0LzAFK+xv17C26vyYF4t0VY7AbofZ+ttMLh7zCHRzPWMGuWYZTuJ
         FcCjK2VUXDV5p2XjDe03bJ6U/J1Jx/lENHoDdI5PRatk7yCDBo5PxQgPpO7MQes7Cuuz
         MPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452417; x=1796057217;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=38ThHGN7lYw60F8stffW8ELZ5EIKExZvYvBv6qCER8M=;
        b=0H1fXoyDSEZ3RAWmtLx61QqrDVodY2yGQggIhEPF3mA41zNIT7Dm8sIiGWZz2cgcGN
         0K15mn8GqPC9c7KYSi4V4Kfw5H66xDilZ+XFrUIuoFHhbjzrKWkhAZTC4As13PoeDN46
         Ejq7ZnTinQJ3oSqFOagd+2H+hkvOYPwV1eMzss0hc53+8ivthXQEjmdclt4slbQ3Cy0G
         Bl7EcmOcvCvGjwYM/3VDVpEBsn+Vj8z7yClgUZSM/lerEMl2Vu4sSWNzXiWshrkyrCXh
         QHf9HWE+QlBEVjQU2rFqT752rILlv86Py183gdzO7e2UNzW/iTHjPpVxuqMqanORi/ky
         VchA==
X-Gm-Message-State: APuU4Z/Zkkn/xuClFO/aFiC/ryqrMSTPYFJ0ZJXg1al8NZyKFyIV5RCh
	HO01AfzGOOIaAzWym5UhH3JRH8BMo/x/xl9QUHine/oM7VKHFS3Y3SOzjzoVbXIP81A=
X-Gm-Gg: AZFdTZf7bU/lzhu22vNHOUMKpU1mBHMpNI140ugodEDcFq+QAZy+OQAWQzrezcV2B5+
	8nk+euftGARi+PWLD8Ukfmjp9svEQh8GkGYpvnJdI+qREIZBRSq2QocwnHAmqnDj0NMzBkyyLum
	N2GafwnMSRUmZZe2lEFPXiAqJ4MH8/ywnjI6T9J3R242ilwjBYadrQvL/Qnw1ueIOoAkNWnrZ0D
	N0x44ZyzctnibodbiZZU59ziSkntJraSx0S+wxuwV759OmrBXitkx36X6s8F/8wvhcZH2H1vnCn
	uqzFTlFp4S5KJpWQM6bSB4B/lqsn4SfZSaVNhbfmUfc3BsMSlmwIhzqKzwerGgLVbAzwRia6d6U
	e1MszF00mVqewQM34l8j302NehkcbrT9J5QEJGOPDscNA4xp0Mo1jrg/p7nLq/Tq6+pJh6NjDpt
	eAoijiQTQvlZ/17GqArcM0ZGOS5cWR1Hp4NaNWHccNJk+6rfZoOboL+qi1s7EJmKiyAslLKHIJU
	WvLre1uNOUkshtQV42Yj4qNqsLRMwXHPFP2pDwYaQKaTyU+ocezaQ+pNFA768l1Ord+0KB6m67o
	uk2NrNVORiKl7qs29qsgU47ndK4j/lIJ
X-Received: by 2002:a05:600c:a085:b0:4bb:7bee:5496 with SMTP id 5b1f17b1804b1-4bb8880f04dmr270221135e9.13.1795452417425;
        Mon, 23 Nov 2026 08:46:57 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9065744esm163707885e9.1.2026.11.23.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:46:56 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 23 Nov 2026 16:46:38 +0000
Subject: [PATCH] perf build: Only enable context analysis with Clang 23 or
 later
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO5tBGsC/yXMQQrCMBAF0KuUWTtgUi2NV5EuxvqjKVrDTBSh9
 O5GXb7NW8igCUaHZiHFK1l6zBVu09B4lfkCTudq8lvfOedbnuQO4wyNfJMCzqIGllKUdwiha3v
 X70OkGmRFTO9ffhz+tudpwli+I63rB2JKa89+AAAA
X-Change-ID: 20261123-james-perf-late-parse-attr-4e996381859f
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Context analysis requires Clang 23 or later (see
Documentation/dev-tools/context-analysis.rst), otherwise the build fails
on older versions, e.g. Clang 18:

  util/env.h:142:39: error: use of undeclared identifier 'lock'
    142 |    struct rb_root          infos __guarded_by(&lock);

Only enable it when the Clang version is supported. Leave the other
thread safety options enabled if they exist because they don't cause
build failures at the moment, and might provide benefits even without
-DWARN_CONTEXT_ANALYSIS.

Fixes: 321967859933 ("perf build: Enable context analysis and Clang thread-safety flags")
Signed-off-by: James Clark <james.clark@linaro.org>
---
Assisted by Claude Opus 5.5
---
 tools/perf/Makefile.config | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aed2e952c8f3..f5adceee5589 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -65,11 +65,15 @@ ifeq ($(CC_NO_CLANG), 0)
     CXX := $(CXX) $(CLANG_FLAGS) -fintegrated-as
   endif
 
-  # Enable context analysis (linux/compiler-context-analysis.h gates its Clang
-  # attributes behind WARN_CONTEXT_ANALYSIS) and Clang thread-safety checks.
-  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  CFLAGS += -Wthread-safety
   CFLAGS += $(call cc-option,-Wthread-safety-pointer -Wthread-safety-beta)
-  CFLAGS += $(call cc-option,-fexperimental-late-parse-attributes)
+
+  # Enable context analysis (linux/compiler-context-analysis.h gates its Clang
+  # attributes behind WARN_CONTEXT_ANALYSIS). Requires Clang 23 or later.
+  CLANG_MAJOR := $(shell echo __clang_major__ | $(CC) -E -P -x c - 2>/dev/null)
+  ifeq ($(shell test "$(CLANG_MAJOR)" -ge 23 2>/dev/null && echo y),y)
+    CFLAGS += -DWARN_CONTEXT_ANALYSIS -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch

---
base-commit: eb79d2fbc230d41b009e49f20671303c6efbd946
change-id: 20261123-james-perf-late-parse-attr-4e996381859f

Best regards,
--  
James Clark <james.clark@linaro.org>

