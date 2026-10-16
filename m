Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9666377A81
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189106; cv=none; b=t9lHxZ37eMP5+41ffF2VcYWPHzkhgajJSPbT+QZ5jncHAWmn1nhneMbf0uGiVgN+0AdnpHS7/pTSlrGQjWnWOnMh3mmqwAdjnYiZTJmYFmqh2fd6yO6snbYvqTFfDlKHIi+otAS0eBjT2zXSAXhAs5Mu2uZtwP46hM33wfTfAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189106; c=relaxed/simple;
	bh=XntgmLX4cYU/6Nf79NgEzitDFOVw7AFEttdr1X6z+5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npj9LlMYCKge0N6YGlImgc8RGMypwXsn0FjV4pa2yk8iXthAY3feZNTGZGXDs6BUcl/MHozJMVhmafrN0F+HMrb4zQtk5ye2AdjCMSlb9RiIBdibQ4Lp9lKXT4FfeNZ8WSjOP0uIkF6rF3YNbJCoSdqO4ga9XUVFXH5RrHnNX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwRGnOtz; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwRGnOtz"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35a04491c56so408412eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189103; x=1792793903; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
        b=IwRGnOtzc5H5aErQt9Hnu94T0HD1/N1BBn8mELko4yZFdKzTSWfx03Qr+B2udAvn+Y
         YBPlOd/yDp2eFeAl5a+5xeY0JcFoe0G66fw3o/AXA5ezSziDy636MONdaaoAV0AeVycB
         Xba4PezjrDHsMKseKPEvYhwAwi8qDhB6Nq8xzEPJgkkXjtMjD3A4Tmi0wJCMOhXoUrTa
         x75bb9k8eWGvIuxhuKlXLGYn6SQClJbvA5Ymcw0ma7lzWzgmH5BXSRrowotxmxUdV8+H
         g4nHcGJS8KhwSdEJ+rplYpIfXtRta7GsjqdBa20+H4VFDrXGBj6VR7yEca0WNLc0+/D3
         mxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189103; x=1792793903;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
        b=J9XzNwqKnDmoUTYtt9GXglB99CXDjsYsCVKx6jkGIs0+cx133nvjXWU2i/S1czjMJl
         IlBHlz29HZShESTphuSkkb19RWvVmAgVQJhSYBeDuCRNSkBpr2mc4HpXDmRy1fH96/5J
         P1WtMto/TAQwj/Bb7GK2+++N26dpThdXfb64bGLVgOAF/u860S4vP3ke2yWIkKCeVO5o
         C/soVG1J7IfcZja4N20DUcrpJIsg6uKdNtshvdw4vWJ3YjNPPh9m+FrQXCxgP2+qtC5L
         MjYa93kmEGckR/b98wocKA56/x9enCj0sH7FfE9Ovezsh+g8v1v4i0bshLItEvQD95BB
         xhmA==
X-Forwarded-Encrypted: i=1; AKwUvBw91sva2m3FiWCzjceOfhgkGqiO0OVKUCfMQi1ujNrVudD7tfLrNt09f2lDMmZhncG4TXiG2dcwRtmk9mJGl+Ij@vger.kernel.org
X-Gm-Message-State: AFq9FYLFEqz9qzIOxzFljNbjSwM/pXy43oUiYadIN+U7azU6T3jeKqoJ
	BnRPYdoRfsWeFTFCU7M8EVqp6cerz0mJLGxKccfpiHjDylfWhM3CKO1Z5k/RcDJMcC+8C/3V/7D
	+pHW2qV5yRA==
X-Received: from dycmb4-n1.prod.google.com ([2002:a05:693c:20c4:10b0:34c:9660:9612])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f0c3:b0:35f:ab1:4792
 with SMTP id 5a478bee46e88-3602d6e460dmr5379136eec.6.1792189102525; Fri, 16
 Oct 2026 15:18:22 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:48 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-6-irogers@google.com>
Subject: [PATCH v4 05/17] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
index 39442577418e..ce746b12f901 100644
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
2.56.0.212.g129ede20d9-goog

