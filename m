Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA7EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbjFOOfQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbjFOOfE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 10:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE18C194
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 07:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4199560B24
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 14:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517E3C433C8;
        Thu, 15 Jun 2023 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686839700;
        bh=xTHdkw2doZMYeLjBXgo2gEDwBTEJD09FboyAxbHYgWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raJNrvwLbKnqAAM7BVTUljdanH/T1p6UmJvdbhguJLHa3l7ZxT6CMp6YGLAh4/vTE
         60P2Ufa8erXckZQqsDO9sL03LkBioO57wU2yTnb7ppVve20K01nRo1ztquMh+rwpBB
         nJQzzfQ9d1ok8R5uLPqTsHfYS5b90+nThRx42bq2AVnFTeGp3uD7VXwlnN+yHo6bHZ
         2Ln+lFaJqOibv1R3VMeVt1Fchey+8wJ8244WyjbL3odi4JBB3mcUURp44W3S0TRHB3
         XImHuzkQr2z1IaSt+BVHWdTx/dQprQZYKlmaAnGg4eazqhXeHHOMYI2W3muucthQW9
         LEPxYONqHfH6Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD29D40692; Thu, 15 Jun 2023 11:34:57 -0300 (-03)
Date:   Thu, 15 Jun 2023 11:34:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
Subject: Re: perf test failures in linux-next on s390
Message-ID: <ZIshkbmQR7oOFiHu@kernel.org>
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
 <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
 <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Ccing the ARM people too:

Em Thu, Jun 15, 2023 at 11:39:16AM +0200, Thomas Richter escreveu:
> On 6/14/23 16:57, Ian Rogers wrote:
> > On Wed, Jun 14, 2023 at 1:32 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
> ....
> 
> > 
> > Smaller list is okay. Could you send me a zip of the sysfs
> > (/sys/devices) ? At least one issue is that the code didn't find a
> > core PMU. On non-hybrid x86 this would be /sys/devices/cpu, I think we
> > spoke about this before for s390 and there are >1. The issue here is
> > that the test found 0, and we're trying to use PMUs in the code now as
> > a way to sort events. There's code/comment in util/pmu.c:
> > 
> > '''
> > /**
> >  * is_sysfs_pmu_core() - PMU CORE devices have different name other than cpu in
> >  *         sysfs on some platforms like ARM or Intel hybrid. Looking for
> >  *         possible the cpus file in sysfs files to identify whether this is a
> >  *         core device.
> >  * @name: The PMU name such as "cpu_atom".
> >  */
> > static int is_sysfs_pmu_core(const char *name)
> > {
> > char path[PATH_MAX];
> > 
> > if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "cpus"))
> > return 0;
> > return file_available(path);
> > }
> > ...
> > bool is_pmu_core(const char *name)
> > {
> > return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> > }
> > '''
> 
> Maybe we should scan the directory
> 
> [linux-next]# ll /sys/bus/event_source/devices
> total 0
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf -> ../../../devices/cpum_cf
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf_diag -> ../../../devices/cpum_cf_diag
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_sf -> ../../../devices/cpum_sf
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 kprobe -> ../../../devices/kprobe
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 software -> ../../../devices/software
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 tracepoint -> ../../../devices/tracepoint
> lrwxrwxrwx 1 root root 0 Jun  2 15:11 uprobe -> ../../../devices/uprobe
> [linux-next]#
> 
> This directory lists the PMUs available on s390, maybe this is true for
> other platform...

I noticed this on an arm64 board:

acme@roc-rk3399-pc:~/git/perf-tools-next$ perf stat -e cycles:u,instructions:u ls
COPYING  CREDITS  Documentation  Kbuild  Kconfig  LICENSES  MAINTAINERS  Makefile  README  arch  block	certs  crypto  drivers	fs  include  init  io_uring  ipc  kernel  lib  mm  net	perf.data  rust  samples  scripts  security  sound  tools  usr	virt

 Performance counter stats for 'ls':

   <not supported>      armv8_cortex_a72/cycles:u/
   <not supported>      armv8_cortex_a53/cycles:u/
   <not supported>      armv8_cortex_a72/instructions:u/
   <not supported>      armv8_cortex_a53/instructions:u/

       0.009192788 seconds time elapsed

       0.000000000 seconds user
       0.009411000 seconds sys


acme@roc-rk3399-pc:~/git/perf-tools-next$

root@roc-rk3399-pc:~# ls -la /sys/bus/event_source/devices
total 0
drwxr-xr-x 2 root root 0 Jan  1  1970 .
drwxr-xr-x 4 root root 0 Jan  1  1970 ..
lrwxrwxrwx 1 root root 0 Jan  1  1970 armv8_cortex_a53 -> ../../../devices/armv8_cortex_a53
lrwxrwxrwx 1 root root 0 Jan  1  1970 armv8_cortex_a72 -> ../../../devices/armv8_cortex_a72
lrwxrwxrwx 1 root root 0 Jan  1  1970 breakpoint -> ../../../devices/breakpoint
lrwxrwxrwx 1 root root 0 Jun 14 21:40 cs_etm -> ../../../devices/cs_etm
lrwxrwxrwx 1 root root 0 Jan  1  1970 software -> ../../../devices/software
lrwxrwxrwx 1 root root 0 Jan  1  1970 tracepoint -> ../../../devices/tracepoint
lrwxrwxrwx 1 root root 0 Jan  1  1970 uprobe -> ../../../devices/uprobe
root@roc-rk3399-pc:~#

running perf test now:

Linux roc-rk3399-pc 6.1.0-rc5-00123-g4dd7ff4a0311 #2 SMP PREEMPT Wed Nov 16 19:55:11 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux
root@roc-rk3399-pc:~# perf test
  1: vmlinux symtab matches kallsyms                                 : Ok
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Skip (permissions)
  4.3: User space counter reading of cycles                          : Skip (permissions)
  5: Test data source output                                         : Ok
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : FAILED!
  6.2: Parsing of all PMU events from sysfs                          : Ok
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
  7: Simple expression parser                                        : Ok
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
  9: Parse perf pmu format                                           : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
 11: DSO data read                                                   : Ok
 12: DSO data cache                                                  : Ok
 13: DSO data reopen                                                 : Ok
 14: Roundtrip evsel->name                                           : Ok
 15: Parse sched tracepoints fields                                  : Ok
  16: syscalls:sys_enter_openat event fields                          : Ok
 17: Setup struct perf_event_attr                                    : Skip
 18: Match and link multiple hists                                   : Ok
 19: 'import perf' in python                                         : FAILED!
 20: Breakpoint overflow signal handler                              : Skip
 21: Breakpoint overflow sampling                                    : Skip
 22: Breakpoint accounting                                           : Ok
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Ok
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             :
...





acme@roc-rk3399-pc:~/git/perf-tools-next$ cat /proc/cpuinfo
processor	: 0
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 1
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 2
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 3
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 4
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 2

processor	: 5
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 2

acme@roc-rk3399-pc:~/git/perf-tools-next$

root@roc-rk3399-pc:~# dmidecode
# dmidecode 3.3
Getting SMBIOS data from sysfs.
SMBIOS 3.0 present.
7 structures occupying 287 bytes.
Table at 0xF0E3C020.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: U-Boot
	Version: 2022.10-rc5+
	Release Date: 10/01/2022
	ROM Size: 64 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		Selectable boot is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 22.10

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: libre-computer
	Product Name: roc-rk3399-pc
	Version: Not Specified
	Serial Number: b03c01a7179278b7
	UUID: 63333062-3130-3761-3137-393237386237
	Wake-up Type: Reserved
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 14 bytes
Base Board Information
	Manufacturer: libre-computer
	Product Name: roc-rk3399-pc
	Version: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Features:
		Board is a hosting board
	Location In Chassis: Not Specified
	Chassis Handle: 0x0000
	Type: Motherboard

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: libre-computer
	Type: Desktop
	Lock: Not Present
	Version: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: Unspecified
	Contained Elements: 0

Handle 0x0004, DMI type 4, 48 bytes
Processor Information
	Socket Designation: Not Specified
	Type: Central Processor
	Family: Unknown
	Manufacturer: Unknown
	ID: 00 00 00 00 00 00 00 00
	Version: Unknown
	Voltage: Unknown
	External Clock: Unknown
	Max Speed: Unknown
	Current Speed: Unknown
	Status: Unpopulated
	Upgrade: None
	L1 Cache Handle: Not Provided
	L2 Cache Handle: Not Provided
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified
	Characteristics: None

Handle 0x0005, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0006, DMI type 127, 4 bytes
End Of Table

root@roc-rk3399-pc:~#


