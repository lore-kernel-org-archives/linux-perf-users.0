Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA58348C6C
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016026; cv=none; b=EEA63JACCKES+v9xUzpPpjtzDYlF59XJNGKgS+CsqsiJKSHYNGKI8q4mXIiGTF9/SUKsVPYXnXW853ADvoK9TR0/GlvGPQxeWqidG1BrtB6P/k7xgGZthGSKYqA25V73yH8TAVvZpD6YLfZgNPsexRkot5j2QNsioh5glXnFK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016026; c=relaxed/simple;
	bh=XAUqwTyfXdagoohNg6g6mspmXuu3VQtpiIjvZqp9D6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K4z8hJkiF/R+f8IF0Qhl8303RczzFbA68uJh/U6BaRp4bfMK5VoT6npnTIhwGYCDEK5U55fNz3lPbO3ZyZXiZW65tjWFSoObxz6MQHeac0lOjnlf2OYLTNIs7nxNqcioyxq+AOGdpLoB7XZ+T0pf2MMLXa/8OcHqhPjXa2k5Kkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BemsntLT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BemsntLT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so60870395e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781016023; x=1781620823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AI896RH1bsZHe07+MtHvvxz+fZfi0ck+NxVGoURYhpk=;
        b=BemsntLTPFGuyLoyjidoUcKkxEsWvIpLIUmP7zDKxSbRaHbge4+ie62AatPY6z1r/s
         kOecfJTdmm8JbBKwuNhPVHYfzIQxM1VhNNyPzrmtXPt/f25jgB6M9VsasjIJB/D5h+hZ
         ssNsKqpQJTxMPRqKpg/VfD3hKqQPg0QvClp7aqCTtFs4DtNx7v2D6nucltIQbPUii4v2
         uyVGikayOUKltIsz0bmfmZVLeaU5UplEuPmNo6UWF2KAaAOU0moDe0skmKu2H7PkAJPS
         j4phP2CuWl5P+wnW+ZIZs3AdACvhLSGsIjJ5ZUQZmi+6+FmlCxOelvEHUq0k3ZYgXz1Y
         wTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016023; x=1781620823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI896RH1bsZHe07+MtHvvxz+fZfi0ck+NxVGoURYhpk=;
        b=EtkkUYUvA6I8JSj49c3pqyEpWwETabD2iKkDItxCAiMI3QUgFJif8HPbFifCzmb2+D
         EGTWcpd64Zs7iSFRltiIHrhJ0aemVYZqXH2jbwlZP07hIPjAPk815FzqmDJLNBX0u260
         aAMQXd3TGf9iqQCcadgpFsVBBlWyxSdPUlN54vF8amiX43vJpBciTBxddEWJhJ8GK3+u
         NJ50g55O3XkFN3pK6J719c/0fwgzhyuc3+qE+qtV07RKIb14ObYczl19l/5wY8BXpfef
         c4MsYhQQsds1KL1Fa6ioc+pm9ObdS9UU1TYAHUf7YOmwWu6RJMhEh05nDK62g9G9tRoV
         KeNA==
X-Forwarded-Encrypted: i=1; AFNElJ/rWksdRTlWpvtSUBftQUGFGasSuSXhicrpma0Ya8CSpLe57O2PrixK3+MGbsAt4B+xQgfGP6AOy/yqsxZjSKtQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvO5zRGE8GbSaSSKEU3V30Yj1wx1G11xoE3Lmcon6jZmxJPc5
	+2pPDOUT/cWPqiDz3rA1rMV5OpvzN3LJdXt6CDJrG5Gbj3zeUrEUSR0mCH1/WprPUQs=
X-Gm-Gg: Acq92OGKFSRNKGsFCgLuqITIi3GsVjtGxf9WvnIxR92z7ZxEx+BjkObhrUZq/8hpiBX
	+f4RZrEDBA18qJsXsEUmQYAX6ELU3LF2jexUecPXUoTBieOn7A72apWO39wCApSlmj+w6fJHMCL
	3Ej2kJJ/o+XdmW+eEO8xvHIbJciO8NCkpN5Qd+WL+Uj0gJnQpirgCHovXlt0MFt9QjgA9giWT0M
	3tQxvOjkhmVQiVvjCrRyqeBf5UMzWxi+uy+zOTaqEothJAjedCBm+W2zQVw2s3sRxQyDQgG7pxf
	cXNxLEXSjMp4NCU3p4+8K3Z6dMtFThNTig12yyD7Fg18Fd/72kQIB/ilf4hvf1E1vCsNLuClsYw
	H0yE1olCNjjCubsJYI6zm3YzcxPq70phDImkzBFZXbuKtxbgEuB3hJXQ3hY1yZ+KhqJO5o8dh2L
	M9hJaSNadpm7Ew54GeCWJgWmpuwZgypuW/d4s8a5TxbkM=
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-490c2604735mr326850665e9.20.1781016022979;
        Tue, 09 Jun 2026 07:40:22 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm428411935e9.4.2026.06.09.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:40:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v5 00/19] perf cs-etm: Queue context packets for frontend
Date: Tue, 09 Jun 2026 15:40:05 +0100
Message-Id: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUlKGoC/4XNwYrCMBAG4FeRnM3STjNps6d9D/GQJtOaXTdZk
 lIU6bs7yoKKh8Jc/p+fby6iUA5UxOfmIjLNoYQUOeB2I9zBxpFk8JwFVKArrFF+218q0vGlONF
 pklO27ifEUQ7hJFtUxnS9pZa8YOMvE9d3f7fnfAhlSvl8fzfXt/ZfBr0iz7WsJPVeV0B1B137d
 QzR5vSR8ihu9AwPjkdrHDDXYY+O9IDo9BvXPHPNGtcw5xoDRqE35PGNU8+cWeMUc0oNZugNoVP
 wwi3LcgUVw3+5uAEAAA==
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Fix thread tracking when decoding Coresight trace and add a new test for
it.

The new test is added as a Perf test workload instead of a custom binary
with its own build system, but this requires a new feature in Perf test
to pass in control pipes which can enable and disable events. This
scopes the recording to just the workload and helps to reduce the amount
of data recorded in tracing tests.

With this new feature we can re-write all of the Coresight tests to make
use of it and remove the remaining binaries which fixes the following
issues:

 * They didn't work in out of source builds
 * A lot of the tests unnecessarily required root and didn't skip
   without it
 * They were mainly qualitative tests which didn't look for specific
   behavior

Most importantly, the long build and runtime has been reduced. On a
Radxa Orion O6, unroll_loop_thread.c took 37s to compile which is longer
than the entire Perf build. Now the build time is negligible and the
before and after test runtimes for all the Coresight tests are:

          |   N1SDP   |   Orion O6
  -----------------------------------
  Before  |   4m  0s  |    14m 49s
  After   |      26s  |        56s
  -----------------------------------

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v5:
- Forgot to include this change:
  - Test for actual length of expected raw dump (Leo)
- Link to v4: https://lore.kernel.org/r/20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org

Changes in v4:
- Rename workload-ctl to record-ctl and improve docs (Leo)
- Use new packet argument everywhere in
  cs_etm__synth_instruction_sample() (Sashiko)
- Test for actual length of expected raw dump (Leo)
- Use -fno-inline instead of keyword (Leo)
- Don't test any brace or call lines in deterministic test
- Make sure context switch loop test does cleanup on failure (Sashiko)
- Remove undef int overflows in workloads (Sashiko)
- Link to v3: https://lore.kernel.org/r/20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org

Changes in v3:
- Minor sashiko comments
  - Close some more pipes
  - Fix warning messages
  - Error handling improvements
- Pass packet into cs_etm__synth_instruction_sample()
- Fixup stale comment (Leo)
- Link to v2: https://lore.kernel.org/r/20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org

Changes in v2:
- Add --workload-ctl option to Perf test
- Re-write all the Coresight tests and speed them up
- Pass packet to memory access function so frontend can use either the
  previous or current packet's EL
- Link to v1: https://lore.kernel.org/r/20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org

---
James Clark (19):
      perf cs-etm: Queue context packets for frontend
      perf test: Add workload-ctl option
      perf test: Add a workload that forces context switches
      perf test cs-etm: Test process attribution
      perf test: Add deterministic workload
      perf test cs-etm: Replace unroll loop thread with deterministic decode test
      perf test cs-etm: Remove asm_pure_loop test
      perf test cs-etm: Replace memcpy test with raw dump stress test
      perf test: Add named_threads workload
      perf test cs-etm: Test decoding for concurrent threads test
      perf test cs-etm: Remove duplicate branch tests
      perf test cs-etm: Skip if not root
      perf test cs-etm: Reduce snapshot size
      perf test cs-etm: Speed up basic test
      perf test cs-etm: Remove unused Coresight workloads
      perf test cs-etm: Make disassembly test use kcore
      perf test cs-etm: Add all branch instructions to test
      perf test cs-etm: Speed up disassembly test
      perf test cs-etm: Move existing tests to coresight folder

 Documentation/trace/coresight/coresight-perf.rst   |  78 +------
 MAINTAINERS                                        |   2 -
 tools/perf/Documentation/perf-test.txt             |  24 ++-
 tools/perf/Makefile.perf                           |  14 +-
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |  20 +-
 tools/perf/tests/builtin-test.c                    | 187 +++++++++++++++-
 tools/perf/tests/shell/coresight/Makefile          |  29 ---
 .../perf/tests/shell/coresight/Makefile.miniconfig |  14 --
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |  22 --
 .../tests/shell/coresight/asm_pure_loop/.gitignore |   1 -
 .../tests/shell/coresight/asm_pure_loop/Makefile   |  34 ---
 .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |  30 ---
 .../tests/shell/coresight/concurrent_threads.sh    |  45 ++++
 .../tests/shell/coresight/context_switch_thread.sh |  69 ++++++
 tools/perf/tests/shell/coresight/deterministic.sh  |  72 +++++++
 .../tests/shell/coresight/memcpy_thread/.gitignore |   1 -
 .../tests/shell/coresight/memcpy_thread/Makefile   |  33 ---
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |  80 -------
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |  22 --
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |  65 ++++++
 .../shell/{ => coresight}/test_arm_coresight.sh    |  43 ++--
 .../{ => coresight}/test_arm_coresight_disasm.sh   |  23 +-
 .../tests/shell/coresight/thread_loop/.gitignore   |   1 -
 .../tests/shell/coresight/thread_loop/Makefile     |  33 ---
 .../shell/coresight/thread_loop/thread_loop.c      |  85 --------
 .../shell/coresight/thread_loop_check_tid_10.sh    |  23 --
 .../shell/coresight/thread_loop_check_tid_2.sh     |  23 --
 .../shell/coresight/unroll_loop_thread/.gitignore  |   1 -
 .../shell/coresight/unroll_loop_thread/Makefile    |  33 ---
 .../unroll_loop_thread/unroll_loop_thread.c        |  75 -------
 .../tests/shell/coresight/unroll_loop_thread_10.sh |  22 --
 tools/perf/tests/shell/lib/coresight.sh            | 134 ------------
 tools/perf/tests/tests.h                           |   3 +
 tools/perf/tests/workloads/Build                   |   4 +
 tools/perf/tests/workloads/context_switch_loop.c   | 110 ++++++++++
 tools/perf/tests/workloads/deterministic.c         |  39 ++++
 tools/perf/tests/workloads/named_threads.c         | 109 ++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  21 +-
 tools/perf/util/cs-etm.c                           | 236 ++++++++++++---------
 tools/perf/util/cs-etm.h                           |   8 +-
 40 files changed, 926 insertions(+), 942 deletions(-)
---
base-commit: 351a37f2fda4db668cff8ba12f2992d73dccdaea
change-id: 20260515-james-cs-context-tracking-fix-754998bae7ed

Best regards,
-- 
James Clark <james.clark@linaro.org>

