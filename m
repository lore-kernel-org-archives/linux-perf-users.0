Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A118A92F
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332219; cv=none; b=Nk/T5qepL+LtwxlN77WtBFvr/cb8zjF9jnPWM9GBwKt2q8uDM+2Nh1BPGmBbrp03V31aHlFXsdb480CDFyo2VjAYzk7S4BNmwlk2LV7qi7iGGLd1Glwvumhh4It8Wqs57ids3UerFkW+0HV0oKnHcaFxOtH2NHecuJPw4Nv+QG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332219; c=relaxed/simple;
	bh=UM1YTVWKCXjwkowt3WjEd184ybys8RxDPu1C31uIsnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fy6QeQSXN5HKiku92N/zmbD3HOTt2uejNqdVccPr+2cZAimzoQTcKfgu8hzY5Bx1SaTpek73mhLi71No8S0/lxzCNTDoLxp1yhdIKyviADsXMmgmyYzw9Vt6BgStzQ2dYvY92uw5WSqWWh2KhDcbsrgcTQmTu0Ke4D7aCCa9uNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dfWW4Is3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dfWW4Is3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso1439292b3a.0
        for <linux-perf-users@vger.kernel.org>; Sat, 09 May 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778332215; x=1778937015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3NyDBs4ghD74Azq1zzFPGUm5QlcBDwy4o68+WiOzU4=;
        b=dfWW4Is3N28283+If5USHbp2VAQF9w7mBCsSBT2Umff6F2aCHFvxGTDkSrZN1Pz+0M
         +tkOG0Ap86At5w3aAKNYPPCM9BqSkQEcQY9HYx3U1JfF/wFltcyztP/nq81r0kVWoeM6
         DRACsP1SUD95x1z7/YbmVn+a8eOPtQbuLUYy4NtNelFZ9LmakqKmFdLOKZuclayRpeRj
         99O+pFvwomt6JZcMfciVJiPVxuGq1GzX/Nlxz4zbI94/R92B7PHTk7HQN1SLnbjyQz1q
         mHLuWKL41I6AQ05XsA7SLX4Tf3hYNeNvFTk9TdBUh1cwo/3juSBeEAtUdye071nfOeww
         XfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778332215; x=1778937015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3NyDBs4ghD74Azq1zzFPGUm5QlcBDwy4o68+WiOzU4=;
        b=AXwR1vv5MATznlw9ijE8etSh2LyA5QQQShPkgVDz6j5pxV+TxdP2Os/gvtK0Em5M7/
         aKHW/WAtz1NLEnG7uoFjZxqgqHhV9OG8rFFNrPr/xmNRsJaS8sOvADxReqsIS3XWzlFa
         2MHrfdyKW5wglkFrCMe2MNd8Frsm1iux50ayepVmHZa7ROd3cP02njXoB1EtdKZTZNpq
         fNrfWBQvSZzE8MDD+XFGW9fuRhPB5bA1xiSsm1yJ4lyoWtaDfnEBGt3xuJZQhiESqjWD
         syuDSxtynHIhAkTMHPE3wV4khK+szkeDtaty6lHANE0Pm8V7XIP8Z06SQoe3x5zuICni
         RJxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OojSI1fW6qBn57XIVOt3yE+hTjoHhCwxf7D+IHYK1WHK0X51j6Za1YdK7PCWChNxA3g1BpxIJCpEtupGCTPFI@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5KVxjNTvP+lL9sA7diBfdeP+c2PAOc7K3hK/bJ4hTElAhp7X
	HXZFhPJLzkPtK5QdKP55toZd+8txEJT8/HtH9CgWzgdtYZyrYPm68yaXCKrXoq6+Qe8=
X-Gm-Gg: Acq92OFnz0MoRUOh+2yMpRpFnsK5t7XEDJIUGjXj2IcOKvm5GRueJzqqq4Zn3GIVyTl
	FUsFAbG6L5P2hGYYv+4/9VGs8FxfVQQbtYMHXPTbneZFS4HkVfUAyQf+RKrIF1H+JW6ffHIwFuG
	oX0FarnWeVO/OJhh5O3r5rPS/C7hNpvQV+WTLoGDDVza0QJUN1fITGKDkJuM1RGI0Vzvw0vKkRl
	rKNNqIvcgAh3j88WhS9OwrPavROXcwm5u1Eqlg3fpiS2b8C93tkXSKkORO5SVS6BTNMyORe0M5Q
	8Zfm/g6NlEaHL+HBJXoU0Bylh0NX9sB5h16ho7Qs+ia/iZ/qchr1kqVQWrYOS+oD4/+IwP9I6Ex
	c0Ck9rK0UuMrbhkQoOL1jZDL9uuxZrvdD/rF2PVD6sD3Mup+skTUWUebev5hLu+xWo0d3y48uDJ
	CkBHx70Y90lw//kBRg0hQ50H2dwuHAUgMAFoFveYJcXsei5HNqZQASkQQpSuaEs5EmOsQ=
X-Received: by 2002:a05:6a00:2d0c:b0:82f:4f67:1ff6 with SMTP id d2e1a72fcca58-83a5b6c460fmr15827882b3a.4.1778332215217;
        Sat, 09 May 2026 06:10:15 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([155.117.34.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c86b3sm18552855b3a.28.2026.05.09.06.10.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 06:10:14 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <himanshu@thechauhan.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Zhu Yuan <yuanzhu@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v9 0/5] riscv: add SBI Supervisor Software Events support
Date: Sat,  9 May 2026 21:09:57 +0800
Message-ID: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series continues Clément's SBI Supervisor Software Events (SSE)
Linux support. Most of the framework is still Clément's work; many
thanks to him for bringing the series this far. Clément reached out and
suggested that I could continue the upstream work, so I am picking up
the series from here.

SSE gives the SBI a firmware-to-S/HS-mode event delivery path that does
not depend on ordinary S-mode interrupt delivery. This is useful for
NMI-style platform events and for PMU overflow delivery through firmware.

This respin mainly fixes two issues:

  - KVM Context Corruption

    An SSE can interrupt HS-mode code around guest execution, run a
    synthetic SSE handler, and then complete back through firmware.  The
    handler episode must be transparent to Linux-owned trap and
    virtualization state.  This version folds the stvec and hstatus
    preservation into the Linux SSE entry wrapper, rather than relying on
    OpenSBI to keep extra hidden resume state. This follows the earlier
    discussion [1].

  - SSE Handler's SSTATUS Leakage

    With CONFIG_RISCV_PMU_SBI_SSE, perf can use the local PMU overflow
    SSE event instead of the ordinary PMU interrupt. This makes the PMU
    overflow handler a real hot path for SSE: workloads such as
    "perf top" can enter the SSE handler and completion paths at a high
    rate. The previous code did not preserve the interrupted
    sstatus.SIE/SPIE/SPP state separately from the synthetic handler
    trap-return state, so high-frequency PMU-SSE delivery could quickly
    expose the leakage. One observed failure mode was an "environment
    call from U-mode" panic. This series addresses that by making the
    SSE entry wrapper preserve the live sstatus state around the handler
    before completing the event.

The selftest has also been extended to cover the high-frequency PMU-SSE
patterns that exposed these bugs.  The new stress modes exercise repeated
handler entry and completion, SBI calls from a handler, PMU stop/start
activity, and re-injection.

How to test:

  Build a kernel with at least:

    CONFIG_RISCV_SBI_SSE=y
    CONFIG_RISCV_PMU_SBI=y
    CONFIG_RISCV_PMU_SBI_SSE=y

  Build the selftest module against that kernel and run the smoke test:

    ./run_sse_test.sh

  Then run the stress layers.  Use stress=1 to run them after the smoke
  test, or stress=2 to run only the stress layers:

    ./run_sse_test.sh stress={0,1,2}

Known limitations and follow-up work:

SSE is a relatively large extension which builds synthetic supervisor
contexts and then resumes the interrupted context through firmware. This
series fixes the issues found so far in that entry/completion path, but I
think it still needs more testing and review. There may still be corner
cases in the constructed handler context or in the state restored after
completion that this series does not cover yet.

The next planned area is virtualization support. Follow-up work is
expected to distinguish host and guest PMU-SSE samples, and to support
delivering SSE events to guests, i.e. the KVM-SSE work from earlier
revisions.

[1] https://lore.kernel.org/r/9290f53d-3545-4299-9781-c1c558f71158@rivosinc.com

---

Changes in v9:
  - Picked up Clément's v8 series and rebased it onto the current RISC-V
    for-next branch.
  - Fixed KVM Context Corruption by keeping stvec and hstatus stable across
    the synthetic SSE handler episode.
  - Fixed SSE Handler's SSTATUS Leakage, where interrupted
    sstatus.SIE/SPIE/SPP state could be confused with the handler
    trap-return state under high-frequency PMU-SSE delivery.
  - Extended the SSE selftest with stress={0,1,2} modes that cover repeated
    handler entry, SBI calls, PMU activity and re-injection, and fixed event
    registration and attribute-buffer lifetime corner cases.
  - Updated MAINTAINERS for the RISC-V SSE driver.

Previous versions:
  v8:
    https://lore.kernel.org/r/20251105082639.342973-1-cleger@rivosinc.com

Clément Léger (5):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  drivers: firmware: add riscv SSE support
  perf: RISC-V: add support for SSE event
  selftests/riscv: add SSE test module

 MAINTAINERS                                   |  17 +
 arch/riscv/include/asm/asm.h                  |  14 +-
 arch/riscv/include/asm/sbi.h                  |  61 ++
 arch/riscv/include/asm/scs.h                  |   7 +
 arch/riscv/include/asm/sse.h                  |  47 ++
 arch/riscv/include/asm/switch_to.h            |  14 +
 arch/riscv/include/asm/thread_info.h          |   1 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/asm-offsets.c               |  14 +
 arch/riscv/kernel/sbi_sse.c                   | 162 ++++
 arch/riscv/kernel/sbi_sse_entry.S             | 187 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv/Kconfig                |  15 +
 drivers/firmware/riscv/Makefile               |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c        | 694 ++++++++++++++++
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/riscv_pmu.c                      |  23 +
 drivers/perf/riscv_pmu_sbi.c                  |  71 +-
 include/linux/perf/riscv_pmu.h                |   5 +
 include/linux/riscv_sbi_sse.h                 |  57 ++
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 769 ++++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  48 ++
 26 files changed, 2231 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sbi_sse.c
 create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

-- 
2.50.1 (Apple Git-155)
