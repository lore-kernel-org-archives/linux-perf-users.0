Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA227E1A1
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189678; cv=none; b=UCYA7wiSgElgfmwEOaKlOHWw8fy0EAExJAbDhgWHmoCNL/Mmmj7g5v2n+L5vM/bP3Mxbaq0pp8V6PY9IZvBWdKLv7icY7ubGBOovPjraLWHnYdGlcJoEhde2K0yQjQjZ69pSVJT9H5OeSu5W8iOqhX5MM5ROnPFjPXnZUhZ8cdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189678; c=relaxed/simple;
	bh=l/IOAmzqAWxn3px4qTqpAPWLw3OXzvVmnFcKE59vi9U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C6m9b5Sr43aSgRx8NSV/IA/LE1gJFPUuHDNKq8PDKLVIBMy3H0njHXJdrDlc4zb4+C7ZLIIPtzStTZjeNtpX4y3YH5w2bZ1Fy4pZ/AywtrNPGQsgxUPn9KRjURpbngKkoPYN08z68k8gVWXn4B9edhmoTVcsjLfu88x4iO3hbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIoMilmh; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIoMilmh"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ee7d1368so1686387eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780189675; x=1780794475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kr1agsQxN7R+ckqIUhhb0WeLzMOoxPB09KTg0cF36Y=;
        b=PIoMilmhwPlDAjfufWhAR2h83+L+4XB9Z5yJ8zmbY/Ps0oP0bVl+UUc4pqzJm6eGdy
         m3pCUXwwhJLJDJdCviLBb0CjFaCjWS4Sg9JMU9vH7muKG265C7Tt5F9H5I0xAIaL6eyN
         592THnX+iE9+5V7PRM9fIsAWy9iF9LAay4y3gsTJAyjcXj2qJHwqoVLCkaRYS3/zQPE3
         oJG6jzuJt30Dq8gDgPpZImlpR/iRI+UVHnpdn6iVam6KUUZvxj1c/ju+aKOug7vLwV7p
         B6tk4+wb5rtSBIY03GEenrL5LhLn7cRWgxK41Yv1uTsZ75s3QGfX/LXaskn2UY+Y7Sat
         Nxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189675; x=1780794475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kr1agsQxN7R+ckqIUhhb0WeLzMOoxPB09KTg0cF36Y=;
        b=QtLLzdYs8uWlmd9OOA82Hrx9wkHANIMMxsA5X6cSYAiSDwpfZ9nA8OWbo4RgJ5a6s4
         5yf0vEQLD9/rzZ1gqCYNmO6+6BQrwU3oXzxGxp+qBpVZ+cqaaP3hwue/k9UKfNd+inrD
         5yjrrjCC+VeTV5qR7LOLBevJbsIzSRjo5fJX856MsnqVSZb7hAy0YujszPsIggjeYSW9
         VOjFd05/3/JccOnvWaQYA2Iadb3bsiZx30AcExwnSmdx9gPPNdRNJLkCX2kDvR034lIX
         blPVk9uH5hxsOcLtijqOxXyPOyfeVhGwjBtpeKs28MLuF47VFB/XSFYHXE1C49sNw07b
         ARiA==
X-Gm-Message-State: AOJu0YwUvbB1TuZ4WJUpIJ8vAijkvHJvO6UfUqmrrxp6ZTA4C21bVttS
	ir6XldZ3UISzzzQBrFZOWtaJLoraRFJfydktYbc/+2QfR3XjKoPrF0OmEK78vPcWym6EAqMuzvJ
	SgmB4Xs0maQ==
X-Received: from dybmi48.prod.google.com ([2002:a05:7301:fb0:b0:304:d272:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:578e:b0:2e2:4979:eb5
 with SMTP id 5a478bee46e88-304fa4d7a78mr2732026eec.10.1780189674615; Sat, 30
 May 2026 18:07:54 -0700 (PDT)
Date: Sat, 30 May 2026 18:07:50 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531010750.525160-1-irogers@google.com>
Subject: [PATCH v1] bpftool build: Restrict feature tests during bootstrap compilation
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"

When the perf build executes 'make -C ../bpf/bpftool bootstrap', bpftool's
Makefile unconditionally evaluated feature checks for llvm, libcap, libbfd,
and disassembler libraries because the bootstrap target was not exempted.

Since the bootstrap bpftool strictly compiles minimal AST parsing and C
code generation logic without linking LLVM or disassembler libraries, these
feature check sub-makes are completely redundant.

Exempt the bootstrap target from non-essential feature tests to eliminate
unneeded sub-make fork overhead during Kbuild startup.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
This patch originally appeared in the now merged perf patch series:
https://lore.kernel.org/linux-perf-users/20260514163409.927816-1-irogers@google.com/
---
 tools/bpf/bpftool/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64..8f50bc163bb2 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -106,6 +106,10 @@ ifneq ($(SKIP_CRYPTO),1)
   CRYPTO_LIBS := -lcrypto
 endif
 
+ifeq ($(MAKECMDGOALS),bootstrap)
+FEATURE_TESTS := libelf-zstd
+FEATURE_DISPLAY :=
+else
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -122,6 +126,7 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+endif
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.54.0.823.g6e5bcc1fc9-goog

