From: Yogesh Tillu <yogesh.tillu@linaro.org>
Subject: [RFC] ARM64: Accessing perf counters from userspace
Date: Mon,  3 Nov 2014 20:34:00 +0530
Message-ID: <1415027045-6573-1-git-send-email-yogesh.tillu@linaro.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51756 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbaKCPIV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Nov 2014 10:08:21 -0500
Received: by mail-pa0-f47.google.com with SMTP id kx10so12298982pab.20
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2014 07:08:21 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: tillu.yogesh@gmail.com, linux-perf-users@vger.kernel.org, linaro-networking@linaro.org, jean.pihet@linaro.org, arnd@linaro.org, Andrew.Pinski@caviumnetworks.com, mike.holmes@linaro.org, ola.liljedahl@linaro.org, magnus.karlsson@avagotech.com, Prasun.Kapoor@caviumnetworks.com, Yogesh Tillu <yogesh.tillu@linaro.org>

We have tried to implement some changes to allow perf counters to be accessed
from user space. Benchmarking so far has show that these are 100s of times 
faster than using syscall(perf_event_open). This would be useful for many use
cases like networking(critical to fast path code), benchmark executionpath with
low budget of cpu cycles etc.

Benchmark figures on ArmV8, "reading perf cycle counter" with below approaches
1) Reading perf cycle counter through perf_event_open syscall 
Result[cpu cycles]: 2000 (For Armv7[Arndale] 5407)
2) Direct access of perf counters from userspace through asm
Result[cpu cycles]: 2 (For Armv7[Arndale] 16)
3) Reading perf cycle counter through vDSO path
Result[cpu cycles]: ~20


Could you please let me know your comments/review. Below are the details about
setup and patchset. 

** Setup details **
Architecture: ArmV8
Board       : Juno Board
Linux kernel: 3.16.0+
Kernel Repo : git://git.linaro.org/kernel/linux-linaro-tracking.git
(Branch:linux-linaro)
Rootfs      : Linaro Ubuntu rootfs
Toolchain   : gcc version 4.9.1 20140529 (prerelease)
(crosstool-NG linaro-1.13.1-4.9-2014.06-02 - Linaro GCC 4.9-2014.06)

1) Reading perf cycle counter through perf_event_open syscall 
*Application to read counter using perf_event_open syscall.
[PATCH] Application reads perf cycle counter using perf_event_open
syscall, and prints Benchmark results.

Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
---
 app_readcounter.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 app_readcounter.c


2) Direct access of perf counters from userspace using asm
This setup contains kernel module + header file with implemented asm to access
perf counters + Application uses api provided in header file to access counter.

* Kernel Module: To enable access of counters from userspace
Yogesh Tillu (1):
  Kernel module to Enable userspace access to PMU counters for
    ArmV8

 ARMv8_Module/Makefile         |    8 ++++
 ARMv8_Module/README           |    1 +
 ARMv8_Module/enable_arm_pmu.c |   96 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 ARMv8_Module/Makefile
 create mode 100644 ARMv8_Module/README
 create mode 100644 ARMv8_Module/enable_arm_pmu.c

* Application:
[PATCH] Added test for Direct access of perf counter from userspace
 using asm.

Signed-off-by: Yogesh Tillu <yogesh.tillu@linaro.org>
---
 README.directaccess |    8 ++++
 direct_access.c     |   65 ++++++++++++++++++++++++++++
 direct_access.h     |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 README.directaccess
 create mode 100644 direct_access.c
 create mode 100644 direct_access.h

3) Reading perf cycle counter through vDSO path
* Kernel Module: To enable access of counters from userspace ( Same as setup (2) )
* Kernel vDSO implementation: vDSO implementation for reading of perf cycle counter
[PATCH] provide open/read function through vDSO for PMU counters
Yogesh Tillu (1):
  To read PMU cycle counter through vDSO Path

 arch/arm64/kernel/vdso/Makefile     |    6 +++---
 arch/arm64/kernel/vdso/vdso.lds.S   |    5 +++++
 arch/arm64/kernel/vdso/vdso_perfc.c |   20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kernel/vdso/vdso_perfc.c

* application  : To read perf counter through api(implemented through vDSO)
[PATCH] Test Application: access PMU counter through vDSO
Yogesh Tillu (1):
  Test application to read PMU counter through vdso     

 vdso_userspace_perf.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 vdso_userspace_perf.c

NOTE: This codebase mainly for POC of "Access perf counters from userspace",
not much concentration towards api standard forms.

-- 
1.7.9.5
