Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812475;
	b=id74a2+aEPEvK4/NSdObdSLb18iaw+Tur4xhshpfAl7tzEPKd02wNfGbOJcJcAYSbdnv
	 BFwYMGo2acUK4TZ6BZ94pKSBkcFIt8QhwBUxfPaKjpuO0X4XWOkT7jpc5UDJVjD3wyleu
	 QGC4iWmckXHodI4ynV2yN6mSvlQxyQBrRS/g6MW7nB9zkjR29ukWqTzsBz8BOB388hJbs
	 zzQFe4WkfgvX4dYt1d0kN1kGQ/UxBXbCxZJxc2QBYQb2Z+L9RWgjuhIoJiQ7nSQ7KwBIU
	 bYfIqdDKtTpCR1f7MvrXMS5qCQ539QlMDOdt1ZIIRjR6cc6ewCRbFxWb2cNj4RrU3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kGc6XFoV4U+ic8wXOwZwBg52C8R3+UBH6mMgxdFOdTM=;
	b=CWMNUKN0gPIrlinMKSqCeKcazrU4t/rB4xguMg5dbUmFkHoK0Pr3D99IV6ICKICyRH+v
	 f28gPfpAMD7scjGxukZXVxkHv7QVkRiZhI9ATFTxPD7kumWy1QI4GKtkayaR5bp44Tr1E
	 7/Ha8R+7uCl8f/6xfmB8+3vo8U9IV4vT6gKYk7PLwsW0bSpvHIQurU9wbR2wg7l+9zXkO
	 OTBpWL3hnaALJrAA6B7xuw6127uxWJZ87ztTAfvTEnVE8LqbpoF2ZhH3/RghcdQCWF6BD
	 caiStwIRI9LgB+Xh5FdQzO3yXJ68gA6d5eXq2rvjRpMINTszFtW8gau+hLeMPG1pTDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="k/mA1rMv";
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311560A2630
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D311560A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k/mA1rMv
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1aa0fb7f157so3758899c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794812474; x=1795417274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGc6XFoV4U+ic8wXOwZwBg52C8R3+UBH6mMgxdFOdTM=;
        b=k/mA1rMvmN7Cr5Fm/iCynEQzuJKl1U4Ddm4pMpuqzLM2OJwYmJxiSm38H3jPgNHGjM
         PqYp2pOSS97VgK+0T8TpCE5HnGxMcgfxv0eScNHR1Pb5x36AkNNWyStOjdJnE/gzVCc7
         PV3qMcvkLsQywKxvFuAa5W0xRzfIYnyEpPQFFNjrx7qsc7MEJLfMCggNF3ocxgCj8uSt
         foHd41kLx1TKh+1aoziGl4Zy7WcIWZajOi1th3ndIPy1bS3NeTZ/BWAEJJ972cplbiKO
         6o1xtS0Vmcq+eB3Wq8VzvW2CUHXOQkJRseYUBXJK7MoqHtvnUX1GeHDvKzZb/3GIX4J8
         TiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812474; x=1795417274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGc6XFoV4U+ic8wXOwZwBg52C8R3+UBH6mMgxdFOdTM=;
        b=MHF4/FTxD0rgXrtu30IRO+zgeGvqFeLYNnoI6GjUPqb9E7YdWm1ghf8tRsO02pN0FY
         22kvo+PunbBVlvjXTs4wWdiqCH91hYXmrvJScYe6uqqH/ZXNiN3x0f+aRXMkgiBK4q2u
         IkrzpRvB1h4hsirQ/oCJB5KhP2iADwbHkos+B7B4EmckKNPDXnQmOjxQLjGf8sBslQLX
         aj5NakikDEhqZa2jtv35o8Qk2JY3FK3UqDHCjAd0ZfF7awVRza5IRWbfFMbamZL0S9+/
         xLzwKPoN0OqLVnJBIuuwtXr+rx8mjkMXkeakgBm8vrsbyoJpV5WrQgu6y/Ae4pmi/a0F
         XXZQ==
X-Forwarded-Encrypted: i=1; AL+hErHZd8RjlI6mxeGWgNbOc0xqvOZ8q1bHOCxnNrmNYhNjTzzoYMosoI+uvk8q1IQ/d6MSEOESTSmruzit6E2WRmdQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+lgvHwbh65AlDuUidUxASgOg+iEy6YpY8XEG+lvkXhejy3O2Iz
	3nyQ3puKLMiCZXYlBFDHEqcy+oX3KwgXacbTZT3ygNmGlHMTOastQtole5YYZMSTeOnOuqioYDA
	spVK2/NmEog==
X-Received: from dlbec12.prod.google.com ([2002:a05:7022:d8c:b0:19d:e7f1:171c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4287:20b0:14a:5284:1bf5
 with SMTP id a92af1059eb24-1b5030a3438mr9987145c88.13.1794812473514; Sun, 15
 Nov 2026 23:01:13 -0800 (PST)
Date: Sun, 15 Nov 2026 23:00:37 -0800
In-Reply-To: <20261116070038.2968725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116070038.2968725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116070038.2968725-11-irogers@google.com>
Subject: [PATCH v2 10/10] perf build: Default JEVENTS_ARCH to all
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Because block-indexed string compression packs PMU event and metric
strings into independently compressed ~8 KiB blocks decompressed on
demand via (block_id << 16) | sub_offset, bundling non-host
architectures' compressed blocks in .rodata incurs zero runtime
decompression CPU or heap memory unless those architectures are queried.
With zstd enabled, bundling PMU event and metric tables for all
architectures (JEVENTS_ARCH=all) is 5.77 MiB smaller overall than an
uncompressed x86-only build (JEVENTS_ARCH=x86 JEVENTS_COMPRESS=none),
cutting the stripped perf binary nearly in half (-45.4%) while enabling
cross-architecture perf.data analysis out of the box:

  Component                   x86 + none      all + zstd      Delta
  -----------------------------------------------------------------
  pmu-events-string.o (dec)   6,901,987 B      794,032 B    -88.5%
  pmu-events.o (dec)            257,987 B      314,940 B    +22.1%
  pmu-events-in.o (dec)       7,160,005 B    1,109,002 B    -84.5%
  perf stripped (file size)  13,321,832 B    7,276,200 B    -45.4%
  perf unstripped (file)     24,526,816 B   18,494,088 B    -24.6%

Adding every non-x86 architecture (arm64, powerpc, riscv, s390, nds32)
only adds +55.6 KiB of compact tables in pmu-events.o and +194.6 KiB of
compressed string blocks in pmu-events-string.o (785,912 B .text for all
vs 586,654 B for x86).

Runtime decompression overhead is minimal. Measured on a hybrid Intel
Core i7-14700 (cpu_core + cpu_atom) across 100 interleaved rounds of
'perf stat true' (which parses default events and Default/TopdownL1
metrics across both core PMUs plus common):

  Build mode    Wall med   Delta wall   User med   Sys med   MinFlt
  -----------------------------------------------------------------
  none (x86)    27.10 ms           --   12.01 ms  16.52 ms    4,036
  zstd (x86)    29.93 ms     +2.83 ms   12.65 ms  17.92 ms    4,583
  zlib (x86)    31.13 ms     +4.03 ms   13.96 ms  17.65 ms    4,548
  lzma (x86)    35.05 ms     +7.95 ms   19.25 ms  17.87 ms    4,555
  all + zstd    30.25 ms     +3.15 ms   14.05 ms  18.04 ms    4,652

Where the ~2.8-3.1 ms in 'perf stat true' (zstd) goes:
1. Pure decompression CPU (+0.64 ms user time on x86, +2.04 ms on all):
   Digesting the 64 KiB ZSTD_DDict once and decompressing the touched
   8 KiB blocks takes ~640 us in user space on x86 (compared to +1.95 ms
   with zlib and +7.24 ms with lzma).
2. Anonymous heap page faults (~1.4 ms sys time, +547 to +616 minor
   faults): In a warm-cache benchmark, uncompressed mode faults
   pre-populated page-cache pages from .rodata, whereas compressed mode
   allocates malloc() buffers (~2.1 MiB across ~265 decompressed 8 KiB
   blocks), incurring kernel zero-page minor faults. On a cold-disk
   invocation, reading ~6 MB less .rodata from disk offsets this.
3. Why ~265 blocks are touched on 'perf stat true': Resolving Default
   metricgroups (TopdownL1, Default2, Default3, Default4) calls
   pmu_metrics_table__for_each_metric() across both cpu_core and
   cpu_atom (alderlake) plus common, linearly scanning every metric in
   those tables (~190 metric blocks) before binary-searching the ~30
   referenced events (~75 event blocks).

On 'perf list' (100 interleaved rounds), user CPU time only increases
from 32.10 ms (none) to 34.09 ms (zstd, +2.00 ms) and is unchanged at
32.08 ms for all+zstd, negligible next to the ~850 ms spent scanning
sysfs PMUs and tracepoints.

Default JEVENTS_ARCH to all in Makefile.config and pmu-events/Build,
allow single-architecture builds via JEVENTS_ARCH=<arch> (falling back
to NO_JEVENTS=1 if that architecture lacks mapfile.csv), and update
tools/perf/tests/make to exercise JEVENTS_ARCH=$(SRCARCH) alongside the
new default.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 9 +++++++--
 tools/perf/Makefile.perf    | 3 +++
 tools/perf/pmu-events/Build | 2 +-
 tools/perf/tests/make       | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 78423b0dcc73..472415c47f82 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -872,9 +872,14 @@ else
   endif
 endif
 
+ifeq ($(JEVENTS_ARCH),)
+  JEVENTS_ARCH := all
+endif
 ifneq ($(NO_JEVENTS),1)
-  ifeq ($(wildcard pmu-events/arch/$(SRCARCH)/mapfile.csv),)
-    NO_JEVENTS := 1
+  ifneq ($(JEVENTS_ARCH),all)
+    ifeq ($(wildcard pmu-events/arch/$(JEVENTS_ARCH)/mapfile.csv),)
+      NO_JEVENTS := 1
+    endif
   endif
 endif
 ifneq ($(NO_JEVENTS),1)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 53ab82681569..e9b8945b5622 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -130,6 +130,9 @@ include ../scripts/utilities.mak
 #
 # Define NO_PYLINT if you do not want to run pylint during build
 #
+# Define JEVENTS_ARCH=<arch|all> to select which architecture(s) PMU event and
+# metric tables are generated for (defaults to all).
+#
 # Define JEVENTS_COMPRESS=<zstd|zlib|lzma|none> to select or disable
 # block-indexed compression of generated PMU event and metric strings, where
 # strings are packed into ~8 KiB blocks compressed independently and
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 88b6b47951e0..32fc1378ef3a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -36,7 +36,7 @@ else
 
 # Setup the JEVENTS_ARCH, JEVENTS_MODEL and JEVENTS_COMPRESS
 ifeq ($(JEVENTS_ARCH),)
-JEVENTS_ARCH=$(SRCARCH)
+JEVENTS_ARCH=all
 endif
 ifeq ($(JEVENTS_MODEL),)
 JEVENTS_MODEL=all
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 5a04f67257ac..f4cd81adb009 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -76,7 +76,7 @@ make_clang          := CC=clang
 make_clang_nondistro := CC=clang BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
 make_no_jevents     := NO_JEVENTS=1
-make_jevents_all    := JEVENTS_ARCH=all
+make_jevents_arch   := JEVENTS_ARCH=$(SRCARCH)
 make_jevents_compress_none := JEVENTS_COMPRESS=none
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
@@ -172,7 +172,7 @@ endif
 endif
 run += make_extra_tests
 run += make_no_jevents
-run += make_jevents_all
+run += make_jevents_arch
 run += make_jevents_compress_none
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
-- 
2.56.1.703.gf848ed807c-goog

