Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF1563FAB
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933285; cv=none; b=CFndNmEyIpZeaW67vvYZ2tneo/+j4u6TlGZZhAY6ANozkrI/ZMUqhBeFiV8kc+ix755URZo1YFH2RyRK9t46QL8ZV714Gr8EF5AVMPnLJJBg2jjvtdikmC19e3Nwgihv2nS9QxuIZ9ukry7/tUPBao+ipORO7M6wci2zeQR2wOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933285; c=relaxed/simple;
	bh=4A/ANomF4iGWg9aVggtR1rNe+S7/Bw8fq2TxzSqyx/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZnSVY+daug7DlFfXxdkNPs1rCIJLbrJ2P7daP61XBcpcUnp/tbE24VyCdtF06UohztD0zAqsUxBX799IXdI0e6Lm8tQUR7z9ZDDNEhcbTsyCXr12Cw4UjO35zumKh2xV8NnLzkxceyABDsaux/OVVV1/Kl/eXbt+jRZyXp+aXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMpEnGmp; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMpEnGmp"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so9501034eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791933283; x=1792538083; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hA27tTR2dWgZDMscmH9VhLIFtST18vRloUltjoMKrNs=;
        b=TMpEnGmppY9Ty7J1uYlvEH8aumSgjeJXFbf52cE/bdASWUQUwuoQlN1a1KcPoz2khR
         Y4EdkvqBZw8eSoeLP/i2BCGC2VU7DDLQN6FcPVl5/aT73Q9DM/IORMQUN+6q+O6hl7xP
         /b+EqTzNP2m5e7v0pSb0mC9suh6Fmq26oKPmtiX+KFvimhwV1Hl2wp8xAXesdQW5NN2H
         LAWKwdiAYf204JqE1ID3KamssypIGKUE/oYBk2f0G4nS7V8IzFiJY/jyDIJzpCgaj2RS
         45574oNjVq/lzwgMrWqlkzXcYCKYJN0UfZ+h9bAtv9wn8zrSXOwlzlKS37TNQFKOztCR
         0kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791933283; x=1792538083;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA27tTR2dWgZDMscmH9VhLIFtST18vRloUltjoMKrNs=;
        b=AFyHtSwvgg7P1iEiSx6PcK/t8a3G9XLYn3Wkw9rcvSaAP/KG2Cd3W3109IPq3WAs7u
         X4s1C/Y/6Y+MKkh76ZdivwHdTlqNFJCd2k62KLzZbaNesdM8NkwToVnzLk4+0p9n9Zu5
         aVjKaE/wUPjIQ4aI6ngDKyskgso8mWmyLLrgdCqPmegoP4afmVocNJYfanRVgolqA+ml
         LqtqKylh37LE/JQ8qHz5avbvibLbJQAXAU5qB/01FpB0t3fGyqju+iyL2lofP8iq2GFc
         eYrxPDVASlm+JLHgb7SxxKtZEN1sIP79nX2gonPpfLyzRykD2E1CNQB0nIl6xP1BMRjG
         mziA==
X-Forwarded-Encrypted: i=1; AKwUvBzb1XDKLGPcvwuos/7rUI0cmuBKVkQ9g9O778uF8gIDDuw4UrpO/sA45IImJTF8yDU7r9JuY4zuGS02LZJFc8aM@vger.kernel.org
X-Gm-Message-State: AFq9FYIum7XOoqtTuWNlR4HyNzGD8NJJQ9Z5CoYvJyKMSimBvCYdKFT0
	++nl1AsdcYxrxQnIwHMnUXrU4+5UIwIXAiUc4GGjf6lCrq28f1RG06y6J+kMW9qtj2BX4gO8GVY
	dWC59IkLqxQ==
X-Received: from dlbts25-n2.prod.google.com ([2002:a05:7022:b059:20b0:168:46d:d4f5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:454b:20b0:144:f096:4dda
 with SMTP id a92af1059eb24-16a6203de6dmr18429574c88.43.1791933282544; Tue, 13
 Oct 2026 16:14:42 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:14:30 -0700
In-Reply-To: <20261013231430.2163505-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013221643.1815686-1-irogers@google.com> <20261013231430.2163505-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013231430.2163505-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf test make: Add BPF skeleton build tests for clang
 and bpf-gcc
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, cupertino.miranda@oracle.com, 
	jose.marchesi@oracle.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
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

