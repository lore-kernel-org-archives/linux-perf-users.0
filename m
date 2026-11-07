Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019175;
	b=Qb3znSFYUS/QUYNLqEBSzBLg41agDXREEgPgI9K8xFFaW1kq/w9Ai62pS4YpaSesj3ia
	 0FrQ0FPNisyLUUfrjWkh4ZKDjnkasJHIsbBvQTAaqJaSj/pjFcNVHUm1VLjXweQnYBwlj
	 TYN/A+YA95DjeGMZrc9M+B3CQ65aapMLTvdmmp/NNjxY5FfFQ1MyE+7+CdBThlJNNKZUK
	 MtWdmDqSwCeSAKIcnolLlydGMPM98KSR8dIo25mPW93muEEttoaGAjLgOKWgffLIbBDNl
	 MMIlALi6MLikJkzH8voDRCat3ST5UnC0HkMv6Na6CDuaJqCjgoRHI5ygJ5FhJf3TBmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yPqS9+jjib1sxM+lashj/lPQvrYKSiMhFD5RdhnO7D0=;
	b=AlmzfKz7d0gKsGVhW1uO3NGxVxnw8o0At2NedB/1AJInbS4qov9uH63ARPcdiuFiiiO7
	 OCrkDSZ/bZlS4c8YM/1vfSM4O0tm+OEVKNz811gJix2ePIHZCTHNUCFUHmHh7R1WoCAVy
	 MqNkS+uYi3MMzrhpEF0JLc8GW5G0HfQbidJwUgVYD5saKVIwnFg7E9ZU97+3UOh05cQ7/
	 UmQVR4NQVp232i/KLKHLMIzPWhg/aGuQBQki5THNFj4OcLqAwKe68sponOYTZsboHTAnL
	 5XMqHLn3Emu41TbhQwPUtwAb+8grXwa8F4XuLKhQS+LdVp6wt2hrGFO+ulDYtao/iHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="prQuEx/r";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AjhgDBdE;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF23606A32D
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 02:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF23606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=prQuEx/r;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AjhgDBdE
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A72Bpsj2138080
	for <linux-perf-users@vger.kernel.org>; Sat, 7 Nov 2026 02:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yPqS9+jjib1sxM+lashj/lPQvrYKSiMhFD5
	RdhnO7D0=; b=prQuEx/rq64IvGjKtB6ZhmV3sHxdSim4xZlwhchPEwZk9dCeAhW
	6wq4vss9cQEzzvbBiUFcavNg/55mtjMFdkL7yTnfk7DdRQU8ib40vIgMvtRSKel1
	du8vGjdJXtkdGXU3VLV8eJdvRU9c0mWi3bGd1xfAFhwnqAoW05/n+jIQcUWQwI59
	AP+oJfOH5JT5l2ag+lVDGj6FnaLUR0HQfX/DQ5Gc3cOkgQsegAcMsR98NR1KqcZL
	5qlz0xq31NJrMmWl9yXnpxGS/dBwApzyjkikODk4y0oHfnd+AfNSVQjDgjUFV2aS
	BgSMpAZj+6OTfvE/SIUj4h4NwH1P2HKsH5g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsu06r2hf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 02:39:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36cec75d8caso348969eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 18:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794019172; x=1794623972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yPqS9+jjib1sxM+lashj/lPQvrYKSiMhFD5RdhnO7D0=;
        b=AjhgDBdEfmc2RboHnVNwGLe0EiGS1ATu/FACap9wTc4vVMc5mUeGxLUXRergb/Stkt
         hcb9mcivtphPSmBk04AwXDjhx0OEQDUl+qqMbKXZrFkVB76Rfjo74LsYx8nlDPD+M7fO
         yH7A7JPdpc53gFSM2/bznCBkQ1vYQriMXQ0QHu00XJ+L+skKaeCGAtjkz2vhPPrXS5SD
         hzuCzubgJucWX2SlR5f3sW3uJr2Dx5HU9xj1/fBnpcBqV72MJYsN0+EHgEa+pR4SN7ca
         2JMGcmU7rLuVYM05qTcoKOPf3oD0o07GWuLXEWoBRQzh1Z1IN7X/HRz5P41nR6s5Vq8R
         afqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794019172; x=1794623972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPqS9+jjib1sxM+lashj/lPQvrYKSiMhFD5RdhnO7D0=;
        b=jufJnKK8KA3CuXIN1oS8WI/O4XF/3wCMn8bg/5xFFAA6zt+i0qhW61b0KFAToDGWm1
         UhjvoOH5El5G465Bb0UW6oksKLTVWVpc/8X/KiQrSyiI8CvzFSEZ7n70KXstmkq8ErRD
         vJ+apmCA3rBg4XALACXwqxaxN0KgZy9+qofX0wc8Dq5LR6IzQsahW6El69NiQ8hWXc/r
         ugn/vsxrCRMU84ISO1J9Ro8eVNvaZ+hGbVuQ00dmqooR4SCaiv6DXiiPJSFWDSSNZ0fx
         s6uRV0dGwV2NpNgZDRZlL/rxeC8nAob/hEGhz+Il7fFfnyyUo2Mg09myIwhSU2kn0oKk
         5TAA==
X-Forwarded-Encrypted: i=1; AL+hErH/wpxBbqzYlwyYYOE47V1Rv7cN7OtDexjzQMTsg2AUNu78x8/DXVNmFuceURlVW1/Gyk18CEgbbcvLp92IBPQh@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hoar4FmuHQOuUNw1P0Wzcy2mibzCKhygtqptMGBJw1mWaULyz
	r3SFu7bO9ownh98TG6+uGXT9q8BunDYnGsM/wKREEOVcTp5u/8s64IDyyLtSjCrFfL/q/7nAXY2
	Tf8/cXcde8KY4uOB20P7uO0Rpi8+aUGdetLtcK8gtancFtlE7/3pksfCx77n7Mzl0HbqIwEy/
X-Gm-Gg: AYBFou3ikFC6WQIYJUylq86UDLPCeJde44UWekSAVNeq3MUW4lA9RipldZMASrnCUQz
	GEKv8dL0zYDwa5hpnHvQnaiM2l44YiPe4KqQUpoPGQT8ZxjPDu8Eo+ZEFu6AoJscodEJ3tYf6LN
	SvER0ay8nrN5EFFNFDacL+2WBSeXphXDzdEoAEsXDZFhlGU44RM4mXgXV6Qhi5Qr3IRozlFjPFy
	MtgtTvkPx2j0HHYkPKC2zj13OrRS/qdOtRb70bf6WjDcQjJXyrFmVQVU0cYp3+aM3Xw9eLrNLRp
	drsLSwwCDspMZTaJnf9u2bmJhgosx+fcjk4GIe+jAGiXOJ98sPcIY6n7znqbIrB4thnlInAbOkK
	bXL8HakyO2iNLkNJOLejD1/3joQSdGTgJrJv/jycIKudwLL5Fy06J3TGRfJ6gH+z3LIic7owgNw
	30owqGoo+0tFNJudptwnXyrmpSZUzlgPsyVWqVC5DaM8YgEyESkKrSIrikPth5quZGETVGfeB5r
	w==
X-Received: by 2002:a05:693c:8819:20b0:36c:dbfc:ee6f with SMTP id 5a478bee46e88-370f6ec412cmr1169921eec.14.1794019172292;
        Fri, 06 Nov 2026 18:39:32 -0800 (PST)
X-Received: by 2002:a05:693c:8819:20b0:36c:dbfc:ee6f with SMTP id 5a478bee46e88-370f6ec412cmr1169834eec.14.1794019171274;
        Fri, 06 Nov 2026 18:39:31 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm11069040eec.29.2026.11.06.18.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:39:30 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jtaubepe@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v8 0/8] riscv: Introduce support for hardware break/watchpoints
Date: Sat,  7 Nov 2026 08:09:09 +0530
Message-ID: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX7PD+d9V8W3l0
 CVJcN2zNm8xqYI/IgJASX/uVcC9mfgO3TbfLWUDB7y6e3HkTp7GCXfIS1y46Vzbn6bVVs7WF957
 hrXBMPTcSEuY/FDngz1yTN2ACfIy6SUJrkbU3U9kkh7H2DcVCV8GORVIWS7jOQ1yCX2REPj5C0c
 UoSEdIKPRuHpKA3UozPOtJgOfUS1vF46AMfyYULe32grGpDFw/KL4bkyFWq1rEb8LWuJyvp6x07
 sdZpfLvyNk89E1kEWnwgHeiCip63PeMArR+w3ZvmzUtitWa4i1flQOwLEbyISDf1UjixCHU4CV2
 XqqHUZDcEmPAa5qslcGbXDa+ue8RWnRQXtgQcSOQLHlHCmKa8Fds3aoyEukiLkf8gSgmg2hzjEM
 VWCdCfegD/+f9dJHDbic4LHBMve3NQscbAo9kPXtaZ3tf/etiKkOvXRlUV8GS/PfBX3Nz/A0+vU
 zkbHTzl0HfxGJ5TK8Lg==
X-Proofpoint-GUID: e5DQBar2g2zuE-Opaz5MW-4ivPzRQQ5H
X-Authority-Analysis: v=2.4 cv=IJGXmQvG c=1 sm=1 tr=0 ts=6aee8f65 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=HwFc7jivAAAA:8 a=_NFv3PjsgsRmLWfyS6wA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-ORIG-GUID: e5DQBar2g2zuE-Opaz5MW-4ivPzRQQ5H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxMCBTYWx0ZWRfX/c5jlyn+Cl7J
 x2Aca5+NLe4WVOYgZuftuOPvHQl593fzgsONifQi3v1PLqEx23tkIpuT2ZNZlREd5HIyi4hvAhd
 07tjJKjb2QK87M8nmqzsWcAjZWwuTU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070010

This patchset adds support for hardware breakpoints and watchpoints in the
RISC-V architecture. The framework is built on top of the perf/ptrace subsystem
and the SBI debug trigger extension (Sdtrig).

Single stepping uses icount when it is available. The software stepping path is
kept as a fallback for systems where icount is not available.

The icount path depends on a QEMU fix so that, when an icount trigger fires,
the exception PC follows the Sdtrig action rule: "xepc must contain the virtual
address of the next instruction that must be executed to preserve the program
flow." For QEMU testing, please use:
  https://github.com/hschauhan/qemu/tree/hschauhan/sdtrig-icount-fix

Virtualization of debug triggers is pending. The patch set is ready but needs
testing.

Changes from v7:
  - Rebased to v7.4-rc1 and folded maintainer entries into the patches that
    add the maintained files.
  - Reworked the patch structure:
    - one patch for the direct single-slot ptrace requests
    - one patch for the register set interface
    - debug trigger encoding details kept internal from the introductory patch
  - Tightened breakpoint and watchpoint handling:
    - trigger setup, update, uninstall, cleanup, and error paths
    - debug trap races with trigger programming
    - hit state cleanup so stale hardware state is not reused
    - cleanup across program replacement and fork
    - bounds, overflow, and wider-access watchpoint matching
  - Improved ptrace support:
    - both ptrace interfaces now share the same breakpoint/watchpoint storage
    - 32-bit traced tasks are supported on 64-bit kernels
    - partial writes and bad indexes are rejected more carefully
  - Improved single stepping:
    - icount is used when available, so the hardware reports the next PC and
      the kernel does not have to decode the stepped instruction
    - software stepping remains as the fallback and now handles indirect
      branches, kernel-address instruction fetches, and mode-specific temporary
      triggers more carefully
    - unsafe software-step cases are rejected instead of looping on the same
      address, and the original breakpoint is restored if stepping lands
      somewhere unexpected
    - CPU-wide software stepping is rejected when icount is unavailable; there
      is no task to follow, and the fallback needs per-task state
    - unused saved trigger state was removed, and the QEMU icount fix needed for
      testing is documented
  - Improved selftests:
    - icount stepping over a taken branch
    - cleanup of failed child processes
    - failure propagation to the process exit status
    - bounded waits for expected signals
    - breakpoint/watchpoint readback validation
    - native riscv64 build handling and RISC-V-only test flags
  - Built and tested QEMU, OpenSBI, Linux, the breakpoint selftest, perf tests,
    RV32 compat ptrace tests, icount stepping, and software-step fallback

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
The SBI debug trigger extension is specified in the SBI specification:
  https://docs.riscv.org/reference/sbi/v3.0/ext-debug-triggers.html

The Sdtrig ISA is part of the RISC-V debug specification:
  https://github.com/riscv/riscv-debug-spec

How to use:
~~~~~~~~~~~
OpenSBI:
  https://github.com/riscv-software-src/opensbi.git

QEMU:
  https://github.com/hschauhan/qemu/tree/hschauhan/sdtrig-icount-fix

Linux Kernel:
  Apply these patches on top of v7.4-rc1

How to test:
~~~~~~~~~~~
>From the Linux kernel directory, first install the UAPI headers (required on a
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
  # ptrace(PTRACE_GETREGSET): addr: 0x82888 control: 0x8080
  # [ptrace]: Watchpoint test passed!
  # [hbpregs] breakpoint readback: addr=0x10472 type=4 len=4 ctrl=0
  # [hbpregs]: Breakpoint test passed!
  # [hbpregs] watchpoint readback: addr=0x82888 type=2 len=8 ctrl=0
  # [hbpregs]: Watchpoint test passed!
  # Icount taken branch PC test passed!

Perf Test Suite:
~~~~~~~~~~~~~~~
Run these perf tests sequentially. On this perf tree, the watchpoint tests share
one watched variable and the default parallel mode can make the subtests
interfere with each other.

~ # /apps/perf test -S -v 16 17 18 19 20
 16: Breakpoint overflow signal handler           : Ok
 17: Breakpoint overflow sampling                 : Ok
 18: Event re-armed with PERF_EVENT_IOC_REFRESH   :
 18.1: Software event                             : Ok
 18.2: Tracepoint event                           : Skip (permissions)
 19: Breakpoint accounting                        : Ok
 20: Watchpoint                                   :
 20.1: Read Only Watchpoint                       : Ok
 20.2: Write Only Watchpoint                      : Ok
 20.3: Read / Write Watchpoint                    : Ok
 20.4: Modify Watchpoint                          : Ok

=== Test Summary ===
Passed main tests : 3
Passed subtests   : 5
Skipped tests     : 1
Failed tests      : 0

Himanshu Chauhan (8):
  riscv: Introduce support for hardware break/watchpoints
  riscv: Add breakpoint and watchpoint test for riscv
  riscv: add ptrace requests for hardware breakpoints
  riscv: add regset access for hardware breakpoints
  selftests/breakpoints: extend riscv test for ptrace hw
    break/watchpoints
  riscv: Add shared instruction fetch and decode helpers
  riscv: Add software supported single stepping with mc/mc6 triggers
  perf tests: keep bp_signal memory accesses visible

 MAINTAINERS                                   |   12 +
 arch/riscv/Kconfig                            |    2 +
 arch/riscv/include/asm/hw_breakpoint.h        |   78 ++
 arch/riscv/include/asm/insn.h                 |   16 +
 arch/riscv/include/asm/kdebug.h               |    3 +-
 arch/riscv/include/asm/processor.h            |   15 +
 arch/riscv/include/uapi/asm/ptrace.h          |   50 +
 arch/riscv/kernel/Makefile                    |    1 +
 arch/riscv/kernel/hw_breakpoint.c             | 1182 +++++++++++++++++
 arch/riscv/kernel/process.c                   |    2 +
 arch/riscv/kernel/ptrace.c                    |  661 +++++++++
 arch/riscv/kernel/traps.c                     |    6 +
 arch/riscv/kernel/traps_misaligned.c          |   52 +-
 arch/riscv/lib/Makefile                       |    1 +
 arch/riscv/lib/insn.c                         |  279 ++++
 include/uapi/linux/elf.h                      |    4 +
 tools/include/uapi/linux/elf.h                |    2 +
 tools/perf/tests/bp_signal.c                  |   14 +-
 tools/testing/selftests/breakpoints/Makefile  |    8 +
 .../breakpoints/breakpoint_test_riscv.c       |  867 ++++++++++++
 20 files changed, 3197 insertions(+), 58 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c
 create mode 100644 arch/riscv/lib/insn.c
 create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test_riscv.c

-- 
2.43.0

