Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA5632B115
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481845; cv=none; b=BdAqWaYqnoHZfqV8U78jcQcMurwbPhrQsJJbzPTJb3dnrDoIQiGMLX1CCoL3QJLroDT/mXDkTHtPdF9Wei9f2rp16a1qf4NnhtC/dgKYvZ9noI8N0ktmg/NeII2OVizRmdpYe+sIScOCFdJY2dn0lFmL0uoU6DomXpKs2ID4pMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481845; c=relaxed/simple;
	bh=zsB6b2mSax8ijZe6CEgFqKmviDOUVPzm4axnSMhYsEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iVRaYDx7fwwwDbAL0OTgTLVWAcrFR1jNJMkK6+ptC/5ewSuOaqZ34q2/UuhrPDahuxLxtjQTId1bfZPoJf4to3vuyRTI089lwZbFpP6YqKBHrxcfY1izIFJ81lxXBZVpzEe0T85VFp5jG7K19Lw7RHTnwiAoAJUjrT+mUo7/CIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=THk3eZJd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THk3eZJd"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49041e84237so4721285e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481842; x=1781086642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7B6wlqSPvHP4/6Eu04K7r/NtlTz65B+jmw25he2xI0=;
        b=THk3eZJdWo5qRIXNqAra4V3rLfUC5FA3stNJoe0/oULgaYqUEgVocsgsxae3SbJmM9
         Y/Fbgqr9QbMB3zQzSdhewnvexi3Aux6iPgaASmdTIunBD716eHl0CgBnWqWFFKVsX5+V
         cJa6vndrU/ECOwQ6hbaj63P7P7GLrxMWBpssi0s1R8wYPW1y7bBDGQBNhHgv9JscmXcp
         aCygPYzTrxHsEyHJIaUqfzRfqSoz29Xh/33g/Mk/E98Zm3skaOp2efVVOcaf9Mq5dyr9
         d9Nv+yckNVpSl/HL79j636PmBCyw+RikzozXPA9KzkfzAKQg4Vb3cFC58LkAZskicjJQ
         BRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481842; x=1781086642;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7B6wlqSPvHP4/6Eu04K7r/NtlTz65B+jmw25he2xI0=;
        b=HhTn8cRqJhYIKQuYEbSKED3CAbzojsAVb4lrRwzcsrM7z4YyjVFx469exBskNLzGi8
         spcm+4JqWzWf/L5LjcSSRmTw32t65pfDK7vh+LkcMx3Fsp01/ohK9djjgqoYOXiQo0zK
         2QDdJiXmC9AUU2bTBVu6XrFFHn5eJVplg3twm/LNo8iyTOvAGRda8EyjaEbAZTp1XDFY
         aw5HrGWTS0rbjyvIttR785/q9JywEloNcfFop4tkpKb0OpSiOymIgA0P2++Fj3dCgNCW
         eCESKjOEMgfVB5jusIHtlnEKpkVaJzhRe1F9MLozS+jq4M/G3mCjQ8MaUqjN9ZI4AmWe
         iA8g==
X-Forwarded-Encrypted: i=1; AFNElJ8ok9/urEc/AXy36raNRgZnvKcjwJy6+tvfy5gITHd8JdMTW5LbzZ2nAq1YwKSKFC6jkPcP1ov9s0WU5gw+/G9z@vger.kernel.org
X-Gm-Message-State: AOJu0YzcR5HHSy3z07a1ZSW3beD4GA7GsrsvlLcEK2LnjxHrjg3pbGjB
	MpJc2Qeqq+JSgEgYnRd+Sp52lJ+pIIlvUNbthU96MAvxNrVaRGxOgfvB9J/1ki7z+d6c+mVOFEw
	44HoaE1Y=
X-Gm-Gg: Acq92OGgiB25P6zB3BZppIF09Mw/9RhAa0mrY17fsIMtSErVB7Cfu3fHnXmKjk3iRUE
	MI4/CrmYziLTbi5uGZrGyKL8DYCbyO9g/F0Ereplb23f3bZbevTXe3uQQ/Rf4HrPVuISfUp86lx
	W2AHpJdeNtbag6noZQT2RhJNDgFNikHZKZvFRLF6VxQnUlk5rR83cBSU+xvntBH4NAhMyp3aFSI
	PSeVKBhriam+2AteTfG/OKpg8F3v8YffjzJisjA5POso/oKNORPSXpI+UOf8dsKCQe/zBLc16SF
	wAH5zDsGrAJFS2HDjD+KQ2511ONNJu6srIlgb4+09kA2M5GU86JKKLu7OmlmPF6bSbs4Wo3GMWc
	Z0TTNyEh1FeAkj1qkRrhZfFbgW6i99WsdrxlcnCJDmn/vAKyupnFQ8zGKA+VZsEWkGegSrVhD3I
	2OFmH/q5Ggnrwzx6NONVzCHFNsObYEr5sBB/PeCM4ssj8=
X-Received: by 2002:a05:600c:8b2a:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-490b614df8dmr33957045e9.13.1780481841724;
        Wed, 03 Jun 2026 03:17:21 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 00/19] perf cs-etm: Queue context packets for frontend
Date: Wed, 03 Jun 2026 11:17:04 +0100
Message-Id: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACD/H2oC/4XNTQrDIBAF4KsE152ithrTVe9RujBmktgfLRokJ
 eTuNaFQugrM5j0e30wkYrAYyamYSMBko/Uuh8OuIKbXrkOwTc6EUy6pYAJu+okRTD7vBhwHGII
 2d+s6aO0IpThWlao1ltiQbLwC5nr1L9ecexsHH97ru8SW9itzuSEnBhSwbiTlyBRX5flhnQ5+7
 0NHFjrxH5dHWxzPnBK1MChbIYz84+Z5/gBQaP5BGgEAAA==
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
 tools/perf/Documentation/perf-test.txt             |  18 +-
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
 tools/perf/tests/shell/coresight/deterministic.sh  |  71 +++++++
 .../tests/shell/coresight/memcpy_thread/.gitignore |   1 -
 .../tests/shell/coresight/memcpy_thread/Makefile   |  33 ---
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |  80 -------
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |  22 --
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |  48 +++++
 .../shell/{ => coresight}/test_arm_coresight.sh    |  43 ++--
 .../{ => coresight}/test_arm_coresight_disasm.sh   |  17 +-
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
 tools/perf/tests/workloads/context_switch_loop.c   | 101 +++++++++
 tools/perf/tests/workloads/deterministic.c         |  39 ++++
 tools/perf/tests/workloads/named_threads.c         | 109 ++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  21 +-
 tools/perf/util/cs-etm.c                           | 234 ++++++++++++---------
 tools/perf/util/cs-etm.h                           |   8 +-
 40 files changed, 889 insertions(+), 938 deletions(-)
---
base-commit: 5f0ca6b80b12bab1ce06839cdffb6148bb650ff4
change-id: 20260515-james-cs-context-tracking-fix-754998bae7ed

Best regards,
-- 
James Clark <james.clark@linaro.org>

