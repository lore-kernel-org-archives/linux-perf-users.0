Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AB33F399
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776463; cv=none; b=atlKu+w/AEaNADJru791WweRo0hm82a/89Ik8aHmCo+5jpTSnXJrAOYCeoXoPzCtJy8FDvKGfhmDA+NY3GzlX0bTS+opKVZDOfkgW5JJLP7jtIBE4HxW47qWsIQw1o1rXls0dHRk6cQHe5tUl8uqhHjBtFlXYgukUdRbh9U0mso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776463; c=relaxed/simple;
	bh=wwRoZKbj654sz4VrwUcykwLsN4Mk4H6ny+P/lIWtoWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJY/MpKAKYDiR4fMHVf77gNLBVMsGH1cS6GJl1k8kERWg5y7eQN7LYX7LPygtTA6r9mQvrpVqy2W00HJOq1ZCFpD/9y1zmV9yvwrAdIHs62V+RQqtOtJciB5fm23tk/IHaf0ZIVRMnmz8eoyGTU139MqRKSLiutznloCvMpriV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXFTiR9m; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXFTiR9m"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso13286c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776461; x=1779381261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6lHdemblE/gP7H567PkD83N+A+98X3bUfvUWyr9JU=;
        b=tXFTiR9m96uUxkBDTjW10KGSeIfFKznWj/LiSih1z7kd6r61pXWiI+U/8LrfeN85OO
         ZSrlH/YZ7nwpD0rHZx9BPOGBG4cIZOvtsRAE+lZzzFbIPMYaBnG35Sq+YflUdQJDsOIs
         gWlvI2XnVLLprxt/KEjiDyVG9duzOvhpgto9oA7X/smCReO/X2bUwUyheWndLRXcpUfY
         S2HLoPc+UDJdSggaCH0rlRy53cGlLUBU+NRDV2qNvlGNhTwiftJAs+hSK06kbmvG51+d
         fBZQECDT8/M6UuwiXeMI0Ba7nILiycFUbIbk6td6EYcb86Dl86sRT1ciJHCXGHIM6UCM
         /oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776461; x=1779381261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6lHdemblE/gP7H567PkD83N+A+98X3bUfvUWyr9JU=;
        b=KZDdkyT1QFCcreDrDwdgkNUFCO80ey5y+91iQJladS5Wnmg1sI9YNOiG5tmsttcPEz
         A9T75SRgxC1Tvh/NCOeRbwxANeAP0XOOle9K4YARekOP83T7cHk38z3S+HpnBhjd1c+U
         13mUKtkGh7r++ee3IoriPyn9EmTiWVQAKmm80db0BRTVhjwS+CD/fzHJMsagDRWKECd4
         IQ5UHpvF7KtJQA3xmFG3XWMYoybr7yTd1xwxmNDRcGBvXLCWPMvCcncGhZRNj8il3b8E
         JF0g6OejJGwPkQ2CInQt5NoMiWfu5vyNX/BdxA2JcTskBILbxTLRi9q7EI+w4CAiRXZr
         pisg==
X-Forwarded-Encrypted: i=1; AFNElJ87lwUTs9NkvaYvoJObFjpyl9Clp5xoHyUe+fNVlqbEfCRTtw5Ya5X2jujuZgM5WEgEh5w/MTl1NYJhCQzUSImd@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZf5ddhfSrLpGAFVq5R3adhy4ByzyGWezoRWPPgW/uCaAkAHT
	T4PsOcq1Qi7WXixNatWTLLFGh/ZoxDNvv9A5+upgbsHzQ/78+vYCu2zbWz3ZS1CdroGhUXj+vd1
	0HtgK/TOueQ==
X-Received: from dlbvg5.prod.google.com ([2002:a05:7022:7f05:b0:134:74a7:dae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:439b:b0:12d:de3e:86b1
 with SMTP id a92af1059eb24-135000aa985mr153729c88.20.1778776461049; Thu, 14
 May 2026 09:34:21 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:53 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-2-irogers@google.com>
Subject: [PATCH v3 01/17] bpftool build: Restrict feature tests during
 bootstrap compilation
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

When bpf_skel.mak executes 'make -C ../bpf/bpftool bootstrap', bpftool's
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
2.54.0.563.g4f69b47b94-goog

