Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711313EC805
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750374; cv=none; b=pNk1Yq2LhyFmv1c7+KG40M3Knv76+hngW13CuJ3K1OxGvPp5iff1Wlyv7QEcT04Yl0Hu9DRD4QyicZMFzqBAIW9ke87vzBtN6LCkv/lBs/RGBvvTSpvSEwIs1iqqa0oR2q1LJyY/tuj+JkO4x3cu6xlIg9cR5pfJXYFGLlm1nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750374; c=relaxed/simple;
	bh=0HFCi5ASXn5yNouLn/a1AgOJkQa9R6TzVROmyPIjvlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izyitT2kJS6NkgM5vWTfu5e8o0iRLBDp8lTB4zlwMoO60g1iOeHdQMxwKsRCjwq53bM/gIxXHFUsvkNPggOXRfknqlY2aPwCeZWNgvNp4I+TBkgsJZApB4KJ0g21UzaVmXXnvtdaPj8/maliMzvNBMpHGvErqBax7fDmInNpMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KwD/loRx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMQ7aA0p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KwD/loRx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMQ7aA0p"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U6NDvD2250226
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=P1d6kMS4BrSsV+WBzmEQwwGwhBFS1xtl4NE
	IYUH1ui4=; b=KwD/loRxaBjPCa39wHnGLTbrs31X/zSYtp56ZGmt+whfVSh2Tav
	zR5OG8HMZXup5LHih4Sn5wzeUI4OEvZ39MlcIa4dLYFz/1vUyBVJ5rBziObat+hZ
	ooFKavKFebj5EgrbX8n4Qmzj+XEmpfj9CvLgjBecyF4d8j0pi3CGBVdpsa6gI5SD
	uQHakXW0a+eJFJLSpJrpgJ8jdxvjFKWKpzjVmu007TWbatqu5MZ179xs0DhrMQzI
	JHqJmHbJmJIFi+2hcVhz49TidP9VH5ECkhPHYUCuHzGfPoVRKRQW7nPVZGc72tiQ
	Gt5aaya9DNo3Yv3eg3/mv+Ehutnx0yAQXnA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3hv6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:39:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-143826c4a13so4165495c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 23:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790750370; x=1791355170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1d6kMS4BrSsV+WBzmEQwwGwhBFS1xtl4NEIYUH1ui4=;
        b=hMQ7aA0p3sPXWTI8B4HBmcTHY8ZaEHQLoa/lebY9Be56KW+BUMs3PDqfd9QFRkrupe
         DfEXDnb66DnfLu6IDzioFqwNj42t82UKDANv2ZngfYCCMnDcekATbpBxyhviaEiqEOen
         xj+LeVuOb/qQh/rVszjMMHhAzeJBJK2oi+E08uvYSPh8OTfdE1HfUEaCOEhn+vTagTOG
         L0zP5jdjfzT9JlYsSEGKoLGy9U9SWM1SzpiulJg0JIsQL02Q+UXthNzQbDvqoB12xvJy
         CK/C9cdfiDkFnSP14Pftf4/jzt758GjCuLHC6Yb35MV+nIbu69aAOQKPfnoBPZoLmVX4
         A2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790750370; x=1791355170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1d6kMS4BrSsV+WBzmEQwwGwhBFS1xtl4NEIYUH1ui4=;
        b=YGF4PmWGElNVID5JeiF3TqRfgvDKXEl5TKsAruTOjffxoKs0GUH3VyO4N03c4cqgxx
         /EUoWDYW+xToMW0MfF66nz46FtBcQBR9W3cgcGxKi6t0kqGunj4ZoTr4HuKneYzWaPiJ
         m6BXYqKfMAT6GH/hFkdVl0aXdx4pCmFDlmnksst/CsC/CKwJ965POfL6sTLBNR03/x6+
         Ev5Vr3S20z5+2MiiTJMctvoosx6nQWh8pYwPP5zOxcojBWzhx3toiOadYq86u14H+iEt
         nyVc33adDFQ9jmd0bSVbqszCMDBDSMQ4haIP0b7WIAU6ndUAmQuoSflsK5q7sU++nIF9
         mpNw==
X-Forwarded-Encrypted: i=1; AKwUvBwLVgGJGt21q8nvRQEuW+yH3X9jBsDtS4suspN4o27esQuTq88Q02u5yQCTsh95Ks8ObbJear2VCRlDDFPz9lAK@vger.kernel.org
X-Gm-Message-State: AFuF++mh1tXDTDIY/eV8xVe2tVUMb7DyRap0yeNH3ZsuKxZTTj0lKlql
	yKXjDxSciR9fy58XhUm9ay2/f8xb2Yq5ieLGiELuBIr+y+n4haRn+z2cFMZRLm3kwwuNuB3+iz8
	ee9Fy1i/x344WDRdymmzE4o7liZHJVJRoHQd+cu+6t/Du/BL5yWGln9JROVn6RQfHYcO/jXKo
X-Gm-Gg: AYBFou0c2UlOTMVe3qP00hy7EQ+Qm8ESbBI//ZyUu4RxAWO0PeLAvn9089f34rlJ8uU
	PliEBRr0mnKKXgRfKfSxoagKzY4y1EK2CWMgh96v3BdtFGY/xl9C2G4WpTNcEZqZiWBGaoyOZ4q
	pFnKFfpYRANzYilHtFjeCUN85y5B0C3SczAdXEOZd/RMQ+vEoakiQjYgeb9503sguooFFgtDcAy
	LBR0oUhXmIC0JB8D4A/AqxJaSUe7Qy4BE/Iz8KC43pUusIDLnQgKay00VHmb5MZTDGN1Mgdr/Ik
	mSV3mdrYvsz02FsfBrv4sEFykMDNMRYOLROBqRgV2tariw9QTNbelXogUok76uk3AWoV+bniCNe
	C2MzAWlQHXVM/uGfZyeH7+447hdvlOzA38RyTZ7KqAhdXhwuPz+dLGgy+UOXElMFxrfm+u1h4+7
	cnqvX7K5oKPAz3h3e+kZX7yHEM
X-Received: by 2002:a05:7022:4595:b0:144:ff51:2d5f with SMTP id a92af1059eb24-14d332a3143mr486547c88.33.1790750370110;
        Tue, 29 Sep 2026 23:39:30 -0700 (PDT)
X-Received: by 2002:a05:7022:4595:b0:144:ff51:2d5f with SMTP id a92af1059eb24-14d332a3143mr486496c88.33.1790750369416;
        Tue, 29 Sep 2026 23:39:29 -0700 (PDT)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14d08fb50f1sm2711531c88.13.2026.09.29.23.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:39:28 -0700 (PDT)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alex@ghiti.fr,
        aou@eecs.berkeley.edu, jtaubepe@redhat.com, palmer@dabbelt.com,
        pjw@kernel.org, qingfang.deng@linux.dev, shuah@kernel.org,
        thecharlesjenkins@gmail.com, cp0613@linux.alibaba.com,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v7 0/8] riscv: Introduce support for hardware break/watchpoints
Date: Wed, 30 Sep 2026 12:09:11 +0530
Message-ID: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 911FjUtdyPY26OikiMtIe712AyfwIkHw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX0Y+4RAljKd4+
 jL6IbdjdZa71CVP5VXuUG3OPru1VSW0RMtkU7dj2LMwDVjkQK9UUb7AM15diy0/F9C+BkNQE8XW
 KKNrc/jHEBeJtAe2U6/uy1CupI3tWXvdLvmZCchbYPwr+ajbVl4oleuHRSlUeYWbimD8r08z6oP
 GcqAqeLsII9zuC3kDXBe0KZ7QFs6Hn8y+rD83q3ZiTGzQfJbzDUtiGLlD5Cf6xdpx9iKrZ3+RhZ
 N6XtE/wiOKw8mbIfYlsrOr9RPwxe/e16jHa4HubqfJDmdwN/NV71xmIbGFOtvxWP+zudRMq7vaI
 tVsT8vId+UVA2TBMD7EGGFd93Aj8Iu4fmIuFXamO06dNpWm6PRaQqiEZHX8YjW1vZuZiXJE6W6o
 zVE+wVasB7Pg673PZ6MpfK2KLarugVXBOpEtorOqWbFIZ8+0OBqAL/G+nYDrZLTyKSPTGd/ry3z
 7UfaNYTn8OaxAqA5g0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX76PQOT7CHDeh
 BxAjFppVtsewR9YMbWxAp3ZeJjo02NiddEF6kYjNMGUlJuOmLg1GYotkAqRxfJsBMua7hl0Fg99
 r7bOjW/zJXBQ/ZiP+bzMv3CMxJAE5P4=
X-Proofpoint-GUID: 911FjUtdyPY26OikiMtIe712AyfwIkHw
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abcaea3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=ClvrxCKNdzey32-IL00A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026

This patchset adds support for hardware breakpoints and watchpoints in the
RISC-V architecture. The framework is built on top of the perf/ptrace subsystem
and the SBI debug trigger extension (Sdtrig).

Single stepping is ready with software support and mc6. Once, icount is fixed, the software
supported single stepping will be put under a Kconfig option. Until then its default.

Virtualization of debug triggers are pending. Patch set is ready but needs testing.

Changes from v6:
  - Rebased to v7.3-rc5
  - Added HIT0/1 bit check/clear in breakpoint handler with EPC/Bp address check
  - Removed dbtr_shmem null check as pointed by Qinfang Deng
  - Fixed MEM_HI/MEM_LO macros to work both on rv64/32
  - Changed unsigned long to __u64 from hwdebug state struct and dropped packing
  - Gated HAVE_MIXED_BREAKPOINT_REGS with PERF_EVENTS
  - Software base single stepping with mcontrol6 trigger type.
  - icount is still under development.
  - Moved and and reworked instruction decoding code to a common file.
  - perf test suite now supported.
	- Breakpoint overflow signal handler
	- Breakpoint overflow sampling
	- Breakpoint accounting (needs sudo)
	- Watchpoint
	  - Read Only Watchpoint
	  - Write Only Watchpoint
	  - Read / Write Watchpoint
	  - Modify Watchpoint
  - __test_function in "Breakpoint overflow signal handler" is name noinline
  - Fixed warnings from checkpatch.pl --strict

Changes from v5:
  - Rebased to v7.2-rc6
  - Simplified Macros in hw_breakpoint.h
  - Took care of the review comments
  - Added ptrace support for hardware break/watchpoints (new patch)
    - PTRACE_GETREGSET/SETREGSET via NT_RISCV_HW_BREAK / NT_RISCV_HW_WATCH
    - PTRACE_GETHBPREGS / SETHBPREGS for direct single-trigger access
    - HAVE_MIXED_BREAKPOINTS_REGS selected (break/watch share trigger pool)
    - flush_ptrace_hw_breakpoint / ptrace_hw_copy_thread wired up
  - Extended selftest to cover ptrace-based hw break/watchpoint paths (new patch)

Changes from v4:
  - Rebased to v7.2-rc4
  - Fixed rv32 build error
  - Added pr_fmt to print KBUILD_MODNAME
  - Changed type of shmem_pa to phys_addr_t
  - Use per_cpu_ptr_to_phys instead of __pa for per-cpu allocated memory
  - Print successful registration/unregistration message when no error
  - Added RISC-V DEBUGGING section in MAINTAINERS and added myself as maintainer
  - Fixed warnings from checkpatch.pl --strict run

Changes from v3:
  - Rebased to v7.1-rc3
  - For watchpoints, check tdata1.hit via SBI_EXT_DBTR_TRIG_READ and keep
    STVAL-based matching as fallback
  - Improved watchpoint matching when STVAL reports the lowest accessed address
    for wider memory accesses
  - Program execute breakpoints with SIZE=0 (match any size) to avoid misses
    with 16-bit/compressed instruction addresses
  - Updated selftest to avoid deadlock by replacing unbounded sem_wait() with
    sem_timedwait() timeout handling
  - Updated selftest breakpoint function so it cannot be inlined or optimized away

Changes from v2:
  - Rebased to v7.0-rc1
  - Fixed warnings from checkpatch.pl --strict run

Changes from v1:
  - The patch adding the SBI extension and function IDs is already merged; this
    series builds on top of that
  - Added breakpoint selftest in tools/testing/selftests/breakpoints/

Specifications:
~~~~~~~~~~~~~~
The SBI debug trigger extension is specified in Chapter 19 of the SBI
specification:
  https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0/riscv-sbi.pdf

The Sdtrig ISA is part of the RISC-V debug specification:
  https://github.com/riscv/riscv-debug-spec

How to use:
~~~~~~~~~~~
OpenSBI:
  https://github.com/riscv-software-src/opensbi.git

QEMU:
  https://github.com/qemu/qemu.git

Linux Kernel:
  Apply these patches on top of v7.3-rc5

How to test:
~~~~~~~~~~~
From the Linux kernel directory, first install the UAPI headers (required on a
fresh tree so the compiler can locate <asm/ptrace.h> and the new
NT_RISCV_HW_BREAK/WATCH definitions via KHDR_INCLUDES):

  make headers

Then build the selftest:

  make -C tools/testing/selftests/breakpoints/

This produces breakpoint_test_riscv under the same directory. Load it on the
target and run. Sample output:

  # /apps/breakpoint_test_riscv
  # [perf_event]: Breakpoint test passed!
  # [perf_event]: Watchpoint test passed!
  # [ptrace]: Breakpoint test passed!
  # ptrace(PTRACE_GETREGSET): Number of watchpoints: 2
  # ptrace(PTRACE_GETREGSet): addr: 0x82888 control: 0x8080
  # [ptrace]: Watchpoint test passed!
  # [hbpregs] breakpoint readback: addr=0x10472 type=4 len=4 ctrl=0
  # [hbpregs]: Breakpoint test passed!
  # [hbpregs] watchpoint readback: addr=0x82888 type=2 len=8 ctrl=0
  # [hbpregs]: Watchpoint test passed!

Perf Test Suite:
~~~~~~~~~~~~~~~
~ # /apps/perf test -v 16 17 18 19
 16: Breakpoint overflow signal handler           : Ok
 17: Breakpoint overflow sampling                 : Ok
 18: Breakpoint accounting                        : Ok
 19: Watchpoint                                   :
 19.1: Read Only Watchpoint                       : Ok
 19.2: Write Only Watchpoint                      : Ok
 19.3: Read / Write Watchpoint                    : Ok
 19.4: Modify Watchpoint                          : Ok

=== Test Summary ===
Passed main tests : 3
Passed subtests   : 4
Skipped tests     : 0
Failed tests      : 0

Himanshu Chauhan (8):
  riscv: Introduce support for hardware break/watchpoints
  riscv: Add breakpoint and watchpoint test for riscv
  riscv: ptrace support for hardware break/watchpoints
  selftests/breakpoints: extend riscv test for ptrace hw
    break/watchpoints
  RISC-V: Add fetch and decode helpers to a common file
  riscv: Add software supported single stepping with mc/mc6 triggers
  perf tests: add noinline to __test_function
  MAINTAINERS: Add entry for RISC-V Debugging

 MAINTAINERS                                   |  11 +
 arch/riscv/Kconfig                            |   3 +
 arch/riscv/include/asm/hw_breakpoint.h        | 331 +++++++
 arch/riscv/include/asm/insn.h                 |  15 +
 arch/riscv/include/asm/kdebug.h               |   3 +-
 arch/riscv/include/asm/processor.h            |  18 +
 arch/riscv/include/uapi/asm/ptrace.h          |  50 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/hw_breakpoint.c             | 879 ++++++++++++++++++
 arch/riscv/kernel/process.c                   |   5 +
 arch/riscv/kernel/ptrace.c                    | 507 ++++++++++
 arch/riscv/kernel/traps.c                     |   6 +
 arch/riscv/kernel/traps_misaligned.c          |  52 +-
 arch/riscv/lib/Makefile                       |   1 +
 arch/riscv/lib/insn.c                         | 263 ++++++
 include/uapi/linux/elf.h                      |   4 +
 tools/include/uapi/linux/elf.h                |   2 +
 tools/perf/tests/bp_signal.c                  |   2 +-
 tools/testing/selftests/breakpoints/Makefile  |   5 +
 .../breakpoints/breakpoint_test_riscv.c       | 769 +++++++++++++++
 20 files changed, 2874 insertions(+), 53 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c
 create mode 100644 arch/riscv/lib/insn.c
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_riscv.c

-- 
2.43.0

