Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B055632BB
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171893; cv=none; b=gDo7ovtza7w62NKYLnhDKEma6vcYV4jkifXa1oYADTZty/ubeCfXkgfJaBn91W+X62inhkczut1Nd1D7Qnxc+IHQdtWJRHZWQSRXNn5niIzZT4TAcTdvfgRj1FHZGcxHrc14KcdsDnemtaBETwhwkcR9kSCSrdWvxqay+9KgkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171893; c=relaxed/simple;
	bh=XntgmLX4cYU/6Nf79NgEzitDFOVw7AFEttdr1X6z+5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jUWWbp5jQn13K51myusnUkNrt7BqvZmVquZyz/xvQIoFk7TQ6hG9BqL8wAXHmkAo9mlkWl9sm909eanqsfszuT/RyzB6Z57HgT12jkDb0LaCtl4mgZctTVR6b/xLbcGEzC9ct7I00PAqPjfUUVQnrwxSurRJpEq1f/m1TNb2uCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucQWQ7t5; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucQWQ7t5"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3580c07911eso265532eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792171892; x=1792776692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
        b=ucQWQ7t5iovHTz8e/QNNUXPZiC02o32b57CyIWkDAEPtqaIjdH1A/089QociNW9sjo
         t54d3p20DSbta1Xe1NiJ7Yr2wqjg74N83lpcO24mLaomX4nTV4qKasmZfK/ykSogCtlo
         D6VbPRqx8mYTfgKvsoicxIx3fYHUqIddhOHeYlr0rmLwDMC77VfqWFjr8xOfnaLU1sEz
         LIotUHEGQSqXbnIacyrrXffoy4CS4gS2EbAuJqiJMKqWrwrAB/1pr8jzCa4hSEC8MY6Q
         UnhbszeAQoY3iny7nymvpnB61DLz+etirGb1UOmKtWQSKE+lg69OfSy5H2BJA3RndPKN
         yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171892; x=1792776692;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkpTEfZaNFnhWMfcoXO62r+fEDph+U3x6hbZzfCOL3U=;
        b=cD+UNqz+AJLngTZYXGgpQ0xJfV+jdCM07zt4cVKXobX0bKO8J0ifDg60X4FOrFiO/+
         N8pvYibOgNIsWlgPXqUx98RO4jEN2aXex0fGenrSWPNo6n/0rq0zxMhL0kguvTxpvpql
         L0/ErkoU+gKDT16COnSK6YbnWFkorXngl5hAYpvRJN5sMGUINfPbQ4+dFurHTVWTiQIc
         S5JcKp+AGPXdMUo00OTTcYL7Jep4G5oylpduQxESwzQ+oar34RRGq7V1KD87mvOBN+1T
         rzWp3Hua/x9WPbXm2U8L6phPdAX3ow2EvBMjsmJ/RSTPRrPWaDTHD2WbtMwo5Jpiz6j9
         Pcmg==
X-Forwarded-Encrypted: i=1; AKwUvBxTzTUR8XzYjYq1ZHFZm7zPgoSPJt2vOdQg8uoPQUbV9GYu446ZBBmNeq39dTSO9Dri6jnWLa40j6ifSG7NfeBO@vger.kernel.org
X-Gm-Message-State: AFq9FYJdBZcT5TpeUbUANBIer/Y/wBIS6v5UEx21bC3du3AJxgo1Sdtm
	hDiSipEQfbRQhCLoeDk/P7fMwd8upDKB1aZ/5vH9/p+HxDoubh5CzsOTTNGOJLVZeWs3Eqz1IwA
	X/unwepgZuA==
X-Received: from dycmg18.prod.google.com ([2002:a05:693c:2512:b0:35f:390d:248a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2a18:b0:35c:8242:9e59
 with SMTP id 5a478bee46e88-361a1860b5amr556342eec.14.1792171889636; Fri, 16
 Oct 2026 10:31:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 10:30:54 -0700
In-Reply-To: <20261016173106.679725-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013222622.1822619-1-irogers@google.com> <20261016173106.679725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016173106.679725-6-irogers@google.com>
Subject: [PATCH v3 05/17] perf build: Enable additional Clang thread-safety flags
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

