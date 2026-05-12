Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E424963DB
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608015; cv=none; b=AcT/9oUN2pAbEsXdkDYc7FaJIpV8sNbzuoO0lG2rZcoFn9FsTekyvMIIuJBXfWBjMplDSeIGkJLX/afpYzLqUOYqJ/5eiejka5+HUYUn8A0MYRiTYtw0Z9SB4Goj/4qWjDVcLm/fdqXo7KEfCP/7k8TxoZjVzcSuCAhVddt8l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608015; c=relaxed/simple;
	bh=wwRoZKbj654sz4VrwUcykwLsN4Mk4H6ny+P/lIWtoWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6RLaAHEOkNIjOIbQpUrSIsKllfPYoLmZ+0IC0zmDTJ+s23i2yGVQiampC0yqPsYV4h0JO89ea/djvt506458/SxO2H9YD4lpY13C9R4ldF2OsLMZX/qKl55azQ2He4JktHjBWhxt5a5o10ZJ5+ThGog9dXfhd4BYW02NPXlbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UWnz/L5C; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWnz/L5C"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132c3280e03so138892c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608013; x=1779212813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6lHdemblE/gP7H567PkD83N+A+98X3bUfvUWyr9JU=;
        b=UWnz/L5CHs56nuL4flzdXORm60vsxhec3WMPdsoOkZdqGq/7sbXmmtH2T7USAsWYmM
         YdG25Mx97Nfyef2jTpuZVk9MGHTDppxtEl2OIkmxc6jxnkgexNyR07Y8YsIEqKr8fGVH
         y+ZwO1m5rZY35yMw8a++Xt28T94D+MQGqhwhhyIc2ChbBEkv3ZnyAU/5TulV72llDmP0
         CEedv1UPNVnz0ylLySAYypRSSL200f7IWN2odcKG1hrEdz1Z8S3OP/qaWaZCG1eBZ2NU
         60+CtxPYnfR600xur0udksYXqIKiBQu9r7TAjTw/+5NXX1/2ZfMhi/9K0sFc6e1qJmlO
         5OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608013; x=1779212813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6lHdemblE/gP7H567PkD83N+A+98X3bUfvUWyr9JU=;
        b=RxnnJIRSewJ/Ehqy3QJU6avOOw+eZf4kmwF48qX/y+MxzyFCUkCu45t/evHGKX49GP
         hDwD5jndmNUMGBcfD9T9MmrvFjbNWUcPj37dDMFsmxl0x3pkGOUNq4y4crf00qbsMCsH
         ziWVHAwWrcYeIwM++LfpBiSl+aIEQ4/5e2O9NzvwaV774lj9Qd3eZ9jXyBb4lpb9mTr9
         fKFsIox62NbX9Onk8AFsYesOJPsmwByumYOfyL309w+3broAS9402E+Af7GCP+oMWSYI
         1ErYmfU1b3+m5jXNNmLtiSGr4RA3+0RZ2ibQgHVUy0kTYr4gOKeAxZefY22Fg80Fa2r2
         GSBA==
X-Forwarded-Encrypted: i=1; AFNElJ/WFNv9nCXnJpn5NsDa8ADpXwejTxrV3740HUeM1iRX1g7UXEwjS5hH/Fo2hGerGdMaQdTTGthpq+lMorIUK1qM@vger.kernel.org
X-Gm-Message-State: AOJu0YyOEN0bC9GKId8gwn1PElTmmusbj99YcbzidQ6ARWxf/PtjXpyF
	NGNfHcSgYJmDbK7GinFlEBrTF9ga+2fPelR32TN7I6fwkFTI9m7c4XpCQ5ojsLhsV2RvFN9uc3u
	OSKT0Jot2iQ==
X-Received: from dlzz19.prod.google.com ([2002:a05:7022:493:b0:12d:b27b:7405])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:45a9:b0:12c:6e75:bb1
 with SMTP id a92af1059eb24-132a7edc8a8mr7939294c88.4.1778608012963; Tue, 12
 May 2026 10:46:52 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:21 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-2-irogers@google.com>
Subject: [PATCH v2 01/18] bpftool build: Restrict feature tests during
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

