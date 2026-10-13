Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB55625F4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929819; cv=none; b=q7Qpe44NKEWy0vebxcQlNhIWmA6AEf1PQujvfRxhPxM2cnBKRdEURd1Ml5doA4DxLBYqLb4f1GnWZAWtwFiLZh+j1n3zDWVNaS7zZ7raccwplS8ahchkNFMQ6A9h0KAe/yvzMBPPj6gbtCl8vzyutfsMcTh1BoUM8rA9ZbEf/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929819; c=relaxed/simple;
	bh=4A/ANomF4iGWg9aVggtR1rNe+S7/Bw8fq2TxzSqyx/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ajnqp4s+VZ0X2M5cHsaJzCUtvYX7m415ckEOU/IhfpILBOr27gckPH/VbcHgWiU7LmPoVh2f5n/vIM5IDoOpIDu0MCZ70O8ZPCnkdFegGlQwpdqxedV2O8luF3JdXo3dFV43AhUO5lg3upJA6Cy8wFAq5TJAk0aFsZS/LkEI6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZr0KG0V; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZr0KG0V"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so9371635eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791929816; x=1792534616; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hA27tTR2dWgZDMscmH9VhLIFtST18vRloUltjoMKrNs=;
        b=XZr0KG0V26Rr+9h/uEAuU6YAkBnkBfSGtvZcDik1XNVy+26gFyOoFq08ifRG42vRSB
         XtMgGr1rv1YyYpcpBaYhMQyyxay03fCWM6oplG99L/pyByBJWDcPPDcuQuZwH2CQHxmf
         jGl9QGxyEQ0pZix1YBSPdkWgAnsx2u7aIk9EMZJio9zk6wojnSx3/WWB3Rorm+EUrnf7
         pdNIWrygMKTptkTrHqCNBOHyL8CeVVDACUHXzuyvS090MNqopQo1NX1QCYUKTqE71lix
         mM8b4nfT2iOyZMtrjCyTUyOmOy89MYqSgkQAKo1DN15iTMx/aF9GiDJY6NVQRM5WUrkk
         7ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929816; x=1792534616;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA27tTR2dWgZDMscmH9VhLIFtST18vRloUltjoMKrNs=;
        b=HezfW3yogYwhA3w6+ZPJkg4GQFAHKEAb5RX8Ps61iMMzmX8s3RhocKDe6r5PqPXCU7
         IeaxdOjw4PYTo0u1d1Anw6JH21IBmIXuX3bfuyn53SYLrmxnu9b16H+upbG1MHiDavcr
         rYam281IzmC7lHaqftYlT1Tq/07cEnLmxTSY4nanODXctFu2d3z9cP22gP1boWvxR2Sg
         /1YgWUPY2lTBVIrK5mbFzbO8RNjCdEImLP+55TfhI87B+kCO7EFPy+N+loQWarOOUrKf
         rLwtcI0iZkPFDy5Lr+Pxhd4SIKnZg/IZO4Ltyj2mKMh5srUn/wm5XaFN6ZiJaSGJlqRl
         4JwA==
X-Forwarded-Encrypted: i=1; AKwUvByatT26t//x1kilds9mugPfpLnz0Jnhi446MBZlFR2RVASZGGupUoNMbUMIIroW0YLpKznfVVJNWSo/jjG71cPh@vger.kernel.org
X-Gm-Message-State: AFq9FYLXGStZZ0uJDt6RP7dGPWf08fXbLsxceMa4kv+Ub8WovVZvmhaa
	iXtFjik7niSLCujxbd2zsGrvKIMAaQBT6ELpUXheLMiTT2I7uaLVVOLgMTAf8geHhatZFFeiZy8
	vWmZ4swXfkA==
X-Received: from dlep8-n1.prod.google.com ([2002:a05:701b:4588:10b0:17c:109c:db31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:454b:20b0:144:fa79:174
 with SMTP id a92af1059eb24-16a61f45109mr18552114c88.44.1791929816120; Tue, 13
 Oct 2026 15:16:56 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:16:43 -0700
In-Reply-To: <20261013221643.1815686-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013221643.1815686-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013221643.1815686-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf test make: Add BPF skeleton build tests for clang
 and bpf-gcc
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add make_bpf_skel_clang (CLANG=clang BPF_GCC=) and make_bpf_skel_bpf_gcc
(BPF_GCC=bpf-gcc CLANG=) targets to tools/perf/tests/make when the
corresponding compiler and BPF skeleton dependencies are available on
the host. Verify with 'perf check -q feature bpf_skeletons' that BPF
skeleton support is enabled for both targets and disabled for
make_no_bpf_skel.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de522802..4e66b93cf12c 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -78,6 +78,8 @@ make_extra_tests    := EXTRA_TESTS=1
 make_no_jevents     := NO_JEVENTS=1
 make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
+make_bpf_skel_clang := CLANG=clang BPF_GCC=
+make_bpf_skel_bpf_gcc := BPF_GCC=bpf-gcc CLANG=
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 make_no_python_module := NO_PYTHON_MODULE=1
 make_no_scripts     := NO_PYTHON_MODULE=1
@@ -142,6 +144,20 @@ have_libllvm := $(shell printf '#include <llvm/Support/ManagedStatic.h>\n#includ
 		$(shell $(LLVM_CONFIG) --system-libs 2>/dev/null) >/dev/null 2>&1 && echo y)
 endif
 
+have_bpf_skel_deps := $(shell printf '#include <libelf.h>\n#include <zlib.h>\n#include <linux/bpf.h>\n#include <openssl/opensslv.h>\nint main(){return 0;}\n' | \
+	$(CC) -x c -I$(srctree)/tools/include/uapi - -o /dev/null -lelf -lz -lcrypto >/dev/null 2>&1 && echo y)
+
+ifneq ($(have_bpf_skel_deps),)
+ifneq ($(call has,clang),)
+have_clang_bpf := $(shell printf '#if (__clang_major__ < 12) || (__clang_major__ == 12 && __clang_minor__ == 0 && __clang_patchlevel__ < 1)\n#error "old"\n#endif\n' | \
+	clang -S -g --target=bpf -x c - -o /dev/null >/dev/null 2>&1 && echo y)
+endif
+ifneq ($(call has,bpf-gcc),)
+have_bpf_gcc := $(shell printf '#if __GNUC__ < 14\n#error "old"\n#endif\n' | \
+	bpf-gcc -E -x c - >/dev/null 2>&1 && echo y)
+endif
+endif
+
 # $(run) contains all available tests
 run := make_pure
 # Targets 'clean all' can be run together only through top level
@@ -173,6 +189,12 @@ run += make_extra_tests
 run += make_no_jevents
 run += make_jevents_all
 run += make_no_bpf_skel
+ifneq ($(have_clang_bpf),)
+run += make_bpf_skel_clang
+endif
+ifneq ($(have_bpf_gcc),)
+run += make_bpf_skel_bpf_gcc
+endif
 run += make_gen_vmlinux_h
 run += make_no_python_module
 run += make_no_scripts
@@ -313,6 +335,13 @@ test_make_clang_nondistro     := $(test_make_clang)
 test_make_clang_nondistro_O   := $(test_make_clang_O)
 endif
 
+test_make_no_bpf_skel         := test -x $(PERF_O)/perf && ! $(PERF_O)/perf check -q feature bpf_skeletons
+test_make_no_bpf_skel_O       := test -x $$TMP_O/perf && ! $$TMP_O/perf check -q feature bpf_skeletons
+test_make_bpf_skel_clang      := test -x $(PERF_O)/perf && $(PERF_O)/perf check -q feature bpf_skeletons
+test_make_bpf_skel_clang_O    := test -x $$TMP_O/perf && $$TMP_O/perf check -q feature bpf_skeletons
+test_make_bpf_skel_bpf_gcc    := test -x $(PERF_O)/perf && $(PERF_O)/perf check -q feature bpf_skeletons
+test_make_bpf_skel_bpf_gcc_O  := test -x $$TMP_O/perf && $$TMP_O/perf check -q feature bpf_skeletons
+
 test_make_python_perf_so_O    := test -f $$TMP_O/python/perf.so
 test_make_perf_o_O            := test -f $$TMP_O/perf.o
 test_make_util_map_o_O        := test -f $$TMP_O/util/map.o
-- 
2.56.0.385.gd3acb90ef8-goog

