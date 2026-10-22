Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700120;
	b=4uPMzFCVUzFBGn46Tip+Ocy6ts0aGzR6kVEGPOTu29rKATsfURrgFLZrOsGoN+7B2dSV
	 syAxB41os7POKau2gxi0YGJHFMhYXJz4lTZ+BHdmvwSxsOy8TE/Zo3UnhEQl34S4+hHrD
	 6jHbpSBHUyuc6xZ1aPHCZXrU9Bv2pYC2z10m6uz4jkc8lT2HOn5Uje/mXAo04gfUBFcPN
	 4qLlK6qdIT+DJREjzLh738u0tf0rGluaZKIiOpzZZvlnLAxokPR6QY7BA7d/A9kkhZw2M
	 xw1QBt7jZlyiMlQ/DP0giBsCp7wUln4Nw9oHIGhlANJ3YE3XFMBYO2KsaWixjN+9CTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6JUxMMI/25kOrfypmhpeOOpRGxtyrkB4sVFmB/HCDt8=;
	b=hAcSNjKjOKgo0QN8gP4Y+uqVVycivzVk43AItcLZYDCW56KYRDaLPDUACCQmSbluPeLN
	 QcO7J87kSbFyvt9321UTW6aa2LaRBUHBs5Ed3JOcUH1AG2Pt9nHvm301ltD+CiS2TcgLh
	 Jofr4xYY8ibJ6ItjFXL82VHEy4CSayTEjSVKH3WzU4N9U9spoUg7XRr4E1amu9j7y4GNv
	 jDjMht4aANOQnLeZzKNPZO77nTXQ8qZxLpeMP+0eGstwASzNj4fAqNL2YNAnltj6bkUJ5
	 oFV/1jQBlJqx75oP4nSyjBsX+P/UbSk82cDr+wSNvfJ/aV2GxKBHPVoAVU9o3F506DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="OqeT0/xU";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC48606A33C
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC48606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OqeT0/xU
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36998507c13so228513eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700119; x=1793304919; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JUxMMI/25kOrfypmhpeOOpRGxtyrkB4sVFmB/HCDt8=;
        b=OqeT0/xUz8q+HIdEsUYuCV9zwwR65DHjwqMal9iuCvL4XHwN6yWKcg4Y+JVt6M9ElT
         IVEYUQnjvUI5j81FpNDyqwaqzuXI7iwCZCU+9IBnHL5AwOvu/sZhxyyTTRdYiqh92ddT
         1j2rH6zU2oSxdndOCpKW9nn23viv5/LPqjzekCdgNaVGJpjGEcQzZVdNn9SQLAP6Zip0
         ms7ZHOOLEDwtyY7it3+z7hCrKub7jRZ+ytWud26voR04JuodkglPMwv/mCSDhsCcXCT3
         kEPfnt6yONP6SucSrzCm/OYCpx5AJGLkx8gBWUoyrhumb+AwSr/EfpLI0fkFv5V9OC3P
         07SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700119; x=1793304919;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6JUxMMI/25kOrfypmhpeOOpRGxtyrkB4sVFmB/HCDt8=;
        b=hWWYbA/4rObeAhb6jQJMFzOu+wYoyxYffa+upKmEVXz0V0Qxmsn5JDz78qhDjPUWpI
         QDYvZUaiuOC4UessE8XhZ+TwiY6G8YOKHz4uY9+v+MyzZ5Pc2Jwn71GaqdDIOqz0VCRc
         UY7qg6aawrOXLECZ/skIGIEam9wYAJJbNROmU/JIhFHuvY+QrOezPbvclsSVckFfom4f
         vjim7F0MHj/YL6gfFQqywpQsALYuuqURc3XbyajGcLxE8moQRC5zhTiY8MVfEzCACeCR
         3U6viIWBhbd69MGHWFU2cfebvroxwp7wsN8yBdbiUP7w8nZd7ThXkj0FHdFj1MY5omk+
         wRPw==
X-Forwarded-Encrypted: i=1; AKwUvByVy3F4I4RC4ndBBv+QMNAo/4BG8ika3QX3ugz1Dhw5pC+zqqEKgTx3WCYHwoXAB6E3AJ/mWSXb7GWxBa8pKkn0@vger.kernel.org
X-Gm-Message-State: AFq9FYI5+BQYHTdKulxH1h01ICrSJIqz36ZA0BhS4AFKPTSklu87Os8k
	I5u0PaHPmU18O/IjrQTF9HkHe73pH4dThAygofJZgpMCOhOMHIAvzmkR4EqpIxnxQqV9WwsK/Zi
	jJzoaWfWbcQ==
X-Received: from dyev8.prod.google.com ([2002:a05:7300:4308:b0:368:d484:7709])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6505:b0:366:fbdb:2070
 with SMTP id 5a478bee46e88-369d989eb57mr380050eec.34.1792700119173; Thu, 22
 Oct 2026 13:15:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:38 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-6-irogers@google.com>
Subject: [PATCH v8 05/19] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3eb8d095cda0..b50702bac53c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -Wthread-safety-pointer -Wthread-safety-beta
+  endif
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.0.307.g5fe7bd680c-goog

