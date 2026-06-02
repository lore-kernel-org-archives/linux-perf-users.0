Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B0400DF0
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410444; cv=none; b=ebRLzWnXKHWQvXZkyWOA2fdyQScTypmEiIsXlTrphiXt6/iEkhOfIE7XbNKys2gvBvKh/f+kqWa3tRzYD2YUTTVLpLJ/VVn4dnYiX75lKU1iIFI0VIeQ3dgBazyoe6iZ9WQYbeV69r5xNrhmVSx09hdK0l4AWVTUVBsmwyoZ8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410444; c=relaxed/simple;
	bh=XbRp9KxgkXge2eA0Kob7iy3MYKUmZBqM3EYn8QhJdqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KFLVPhFVU4ATU782RPPdeGwpQhAWvqAx0mDzXeUxd9CXp5eLoZ+VEfvxcFR4Dhf7e4jxNI8LNbdMhpVqn+Ds7bu34pWFfi2r3b1x1gI/yGgp4fB1IlrIS1YJBEdUNukc64q5YEtcE3vPBH6QcgL5ihxyNXtbiUVrSho3dKtKUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVbw0o73; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVbw0o73"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso62213405e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410441; x=1781015241; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtrXGGGRkpK6Hrb07mUshzy+oVvwUJz5X1iOdpZ8KCk=;
        b=PVbw0o73puwXy8NRtxZIBity6SIg0geS48ZN9J+eh8IRHwt+sSxDDi2FvDM4iGF0Fc
         Y4GFJwaCJM0IIIETPYO7e3YkwkxDHxuShd7o+wzpSjvQY0m9FL6CFAK4rE1fNS7y/MaN
         vPLJ+r2EmytK7PMz3XRUWNYe8Uby61NUOjVuJ8iha9qOCNoZZyAMpS2Ncp+pD9H1yTLT
         h5aq6k7wzFyEoFJ2NX+N1iy46zLRnqTDrXBNBDcDODKddb2J2D/2C5Oc1W+vXj3XVr+i
         Lko2R7u3eegJRf0j+aeo7vPFHdhuz3WWMmUNMK70cFsz1zr24uFHv6F9YXHvDSn+1QFg
         6FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410441; x=1781015241;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtrXGGGRkpK6Hrb07mUshzy+oVvwUJz5X1iOdpZ8KCk=;
        b=WkQTzIZ+R4mF6VUGw6GqSYK+6aR9EtMGt/8q+kH8d5zzWq4VOvrOvFaQCao4gSKSE8
         h9w9IsMYxb7NqJXS1hlCRKD7T0Ia1AEgzJSzpZZmlJ2WOc9X7Djaa1aBfsPClVB9SFhY
         NinbEQBu2uH6wElNx9Q6zaFZbs9E3Eu3TyhDpwsI1SCHn9Hpvq7rcoJD3ahw0P1BRysj
         nal8+dS7dabugMBDcZi8AcLuOfFtZCfnhNV2P4Xhheo1qTdfI0zZacM7Xt07PDp8jMig
         8GE9fgtIxgu2ZhOLGJweXIFSEp73ZWfd6R2lYwAGiWDUnhAdcGbiOHLYzRxL3pwcfZnn
         43Aw==
X-Forwarded-Encrypted: i=1; AFNElJ9320kEfjKM0fZb4fcnctCpv6p6M1lR3ODF7dWtYbohD0KlWBbR0H9PivEfRFN1YXCZ9BvKN1g7aNX0E5x4dKC/@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZTxSB033kIl8vUomPshqo2czetki2srTA5pgvFLl9zcgkm0l
	LBmCUMIge1Hgq+x2dF/W711aDGLitX7pSThGNc2SBcekGvmcKUM5E578xJS+D6jD/EfritDEYEo
	HM1UNsM0=
X-Gm-Gg: Acq92OFC7OrLZsyVn3fuejfwuFp2iOkbCi9Rdo3hS5ttqsIFNu29qgpy+U6POhvwsVQ
	2E6GKPERNurjDh9dPwMRkh14moBFoo9fKkr1UN/+af9Y/+hh4ma+f/6fwY8kiAEpTfHaNrxSbcO
	8nAjMmTBd9VapRubpCc10titSHLEFbhNWaoE5eQ96ZGmzawX6tmb952R5LM1W4/JEnluhQ8IitO
	R4UMtG7ho5GxUENou3RtEKxW8zuZ810fTvu2HSTQF3VLglyHfgbwSWHEZ/vfY/vVkE3171nPIej
	A74UNuUaxDERv8u/cmZUQDYGVQ+1nrSsPmolmAKPOMa0nqzpOoTAdcpAmOBlp2aC7KoxYb1QsaZ
	2VJNqfvhEZglP0ZACEJObe5NJKKWzYS0IEkb/HWY8ZqhK4NR4wuy9g5Sy0P1StUIda+JfrYMCVZ
	LcUvtA/Kyt/R54jKSOLlP9Xc6pdd0W4IoC5dRkSNWRSEI=
X-Received: by 2002:a05:600d:8445:20b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-490a293a126mr212661445e9.19.1780410440964;
        Tue, 02 Jun 2026 07:27:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:20 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 00/18] perf cs-etm: Queue context packets for frontend
Date: Tue, 02 Jun 2026 15:26:42 +0100
Message-Id: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLoHmoC/4WNyw6CMBBFf4XM2jFtIy9X/IdhUWCE8dGaaUMwh
 H+3Evcmd3PO4twVAglTgHO2gtDMgb1LYA4Z9JN1IyEPicEoU6hc53izTwrYp3kXaYkYxfZ3diN
 eecEyP9V11VkqaYDUeAklvfcvbeKJQ/Ty3u9m/bW/sin+lGeNCqkbCmVIV6Yqmwc7K/7oZYR22
 7YPeNyja8sAAAA=
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
Changes in v2:
- Add --workload-ctl option to Perf test
- Re-write all the Coresight tests and speed them up
- Pass packet to memory access function so frontend can use either the
  previous or current packet's EL
- Link to v1: https://lore.kernel.org/r/20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org

---
James Clark (18):
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
 tools/perf/tests/builtin-test.c                    | 187 ++++++++++++++++-
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
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |  54 +++++
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
 tools/perf/tests/workloads/context_switch_loop.c   |  95 +++++++++
 tools/perf/tests/workloads/deterministic.c         |  39 ++++
 tools/perf/tests/workloads/named_threads.c         | 109 ++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  21 +-
 tools/perf/util/cs-etm.c                           | 233 +++++++++++++--------
 tools/perf/util/cs-etm.h                           |   8 +-
 40 files changed, 892 insertions(+), 934 deletions(-)
---
base-commit: 5f0ca6b80b12bab1ce06839cdffb6148bb650ff4
change-id: 20260515-james-cs-context-tracking-fix-754998bae7ed

Best regards,
-- 
James Clark <james.clark@linaro.org>

