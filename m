Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDB0EB64D8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jun 2023 14:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbjFPOgk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jun 2023 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjFPOgi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jun 2023 10:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B830E3
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 07:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E98B63CE2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jun 2023 14:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D0FC433C8;
        Fri, 16 Jun 2023 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686926190;
        bh=r+7fKwvzdWXBMYUENhGrxj2fWxKFrDYQrJmjzPMq6W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dq1bX8oj0CAn1vHVndcy6cxLfDQZQ0SaDOYeHoj9BZF4oA7C9/FAzwUihfes1W6qz
         V7W4x9mRue51BjhhbLVR4NBYoJnZQIxbkmVgZx/PftMLqO58wyjwennA9w7n8/TW+D
         K5m5XRVP55zwpcn7ZlRulnJc7Ce6S9t4FI/gVvP4rOoOAjhxo7RSSAM4+Wd8Kvme8U
         4zbkxMTKEL6bCcP7IkW8BCAwnxoXnA0/dotwvVSoVg6P2S97o2YuqDbyzhLqb4g+6D
         tW4nNrMK/GOHXqGYrivx5oR9n+wJ5+GQi3GIcLHUChDMC1aYOYmTEzt3XVo6svygio
         2N2CIdc5BIJrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 193A140692; Fri, 16 Jun 2023 11:36:27 -0300 (-03)
Date:   Fri, 16 Jun 2023 11:36:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>
Subject: Hybrid PMU issues on aarch64. was: Re: perf test failures in
 linux-next on s390
Message-ID: <ZIxza13x+AwApbQb@kernel.org>
References: <d5319870-7569-c353-1777-31ee090f8da8@linux.ibm.com>
 <CAP-5=fU+0VXckQiq3E8yqaySNZ+-DDZahEd1OY0uKPWnfFsafg@mail.gmail.com>
 <e7f0930a-a9fc-d768-a472-bd9af6fafdf5@linux.ibm.com>
 <CAP-5=fWjqJH0h607cVb1T7pRxDeq4cZBz5TECMajpnkvVNWHEQ@mail.gmail.com>
 <a19a30b0-8f16-5871-6856-503eadf56e3c@linux.ibm.com>
 <ZIshkbmQR7oOFiHu@kernel.org>
 <CAP-5=fVYy6jMd9Nw7iqqsm_G-qW__Lo8kFeCocJ0W2no4XTbpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVYy6jMd9Nw7iqqsm_G-qW__Lo8kFeCocJ0W2no4XTbpg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 16, 2023 at 07:23:30AM -0700, Ian Rogers escreveu:
> On Thu, Jun 15, 2023 at 7:35 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Ccing the ARM people too:
> > Em Thu, Jun 15, 2023 at 11:39:16AM +0200, Thomas Richter escreveu:
> > > On 6/14/23 16:57, Ian Rogers wrote:
> > > > On Wed, Jun 14, 2023 at 1:32 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> > > > bool is_pmu_core(const char *name)
> > > > {
> > > > return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> > > > }

> > > Maybe we should scan the directory

> > > [linux-next]# ll /sys/bus/event_source/devices
> > > total 0
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf -> ../../../devices/cpum_cf
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_cf_diag -> ../../../devices/cpum_cf_diag
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 cpum_sf -> ../../../devices/cpum_sf
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 kprobe -> ../../../devices/kprobe
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 software -> ../../../devices/software
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 tracepoint -> ../../../devices/tracepoint
> > > lrwxrwxrwx 1 root root 0 Jun  2 15:11 uprobe -> ../../../devices/uprobe
> > > [linux-next]#

> > > This directory lists the PMUs available on s390, maybe this is true for
> > > other platform...

> > I noticed this on an arm64 board:

> > acme@roc-rk3399-pc:~/git/perf-tools-next$ perf stat -e cycles:u,instructions:u ls
> > COPYING  CREDITS  Documentation  Kbuild  Kconfig  LICENSES  MAINTAINERS  Makefile  README  arch  block  certs  crypto  drivers  fs  include  init  io_uring  ipc  kernel  lib  mm  net  perf.data  rust  samples  scripts  security  sound  tools  usr  virt

> >  Performance counter stats for 'ls':

> >    <not supported>      armv8_cortex_a72/cycles:u/
> >    <not supported>      armv8_cortex_a53/cycles:u/
> >    <not supported>      armv8_cortex_a72/instructions:u/
> >    <not supported>      armv8_cortex_a53/instructions:u/

> I tested on a raspberry pi and perf-tools-next is working there. I
> suspect the issue here is the heterogeneous PMU. The cycles event is
> converted into a perf_event_attr with type 0 and config 0. When there
> are heterogeneous PMUs then we try to use the extended type to say we
> want armv8_cortex_a72 and armv8_cortex_a53 cycles events. Let's say
> the type number of armv8_cortex_a72 and armv8_cortex_a53 PMUs are 9
> and 10 respectively. With heterogeneous encodings the type in the

The numbers are 8 and 7, PERF_TYPE_HW (thus zero, thus not printed):

root@roc-rk3399-pc:~# perf stat -vv -e cycles sleep 1
Using CPUID 0x00000000410fd080
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  size                             136
  config                           0x800000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 13885  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
cycles event is not supported by the kernel.
------------------------------------------------------------
perf_event_attr:
  size                             136
  config                           0x700000000
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 13885  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
cycles event is not supported by the kernel.
failed to read counter cycles
failed to read counter cycles

 Performance counter stats for 'sleep 1':

   <not supported>      armv8_cortex_a72/cycles/
   <not supported>      armv8_cortex_a53/cycles/

       1.011406938 seconds time elapsed

       0.000000000 seconds user
       0.010886000 seconds sys


root@roc-rk3399-pc:~#

> perf_event_attr remains as 0 and the config becomes 9 << 32 and 10 <<
> 32. I suspect your kernel is seeing the extended type information and
> not handling it, hence the error.

looks this is the case indeed
 
> We add in the extended type for hardware and legacy cache events in
> the parse events code:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n435
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n1239
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n1478
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n1511
> 
> The addition of the extended type happens if
> perf_pmus__supports_extended_type() returns true, its implementation
> is:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n480
> bool perf_pmus__supports_extended_type(void)
> {
>   return perf_pmus__num_core_pmus() > 1;
> }
> 
> Previously on heterogeneous ARM the extended type wouldn't be encoded
> and I believe the event was opened on the PMU of the current CPU only.

I think that is the case, haven't checked so far tho.

> This is a bug because you will not count events on all PMUs. We can
> make perf_pmus__supports_extended_type return false on ARM which
> should bring back the previous behavior - or do some kind of dynamic

simplest first step, trying it.

> detection using perf_event_open. We could do some kind of ARM quirk
> workaround behavior, for example, I suspect
> /sys/bus/event_source/devices/armv8_cortex_a53/events and
> /sys/bus/event_source/devices/armv8_cortex_a72/events both contain a
> cycles event. If we used a raw rather than hardware type encoding then
> the wildcarding should work. Unfortunately there are many encodings
> with extended type and sysfs won't have them all.
> 
> Thanks,
> Ian
> 
> >        0.009192788 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.009411000 seconds sys
> >
> >
> > acme@roc-rk3399-pc:~/git/perf-tools-next$
> >
> > root@roc-rk3399-pc:~# ls -la /sys/bus/event_source/devices
> > total 0
> > drwxr-xr-x 2 root root 0 Jan  1  1970 .
> > drwxr-xr-x 4 root root 0 Jan  1  1970 ..
> > lrwxrwxrwx 1 root root 0 Jan  1  1970 armv8_cortex_a53 -> ../../../devices/armv8_cortex_a53
> > lrwxrwxrwx 1 root root 0 Jan  1  1970 armv8_cortex_a72 -> ../../../devices/armv8_cortex_a72
> > lrwxrwxrwx 1 root root 0 Jan  1  1970 breakpoint -> ../../../devices/breakpoint
> > lrwxrwxrwx 1 root root 0 Jun 14 21:40 cs_etm -> ../../../devices/cs_etm
> > lrwxrwxrwx 1 root root 0 Jan  1  1970 software -> ../../../devices/software
> > lrwxrwxrwx 1 root root 0 Jan  1  1970 tracepoint -> ../../../devices/tracepoint
> > lrwxrwxrwx 1 root root 0 Jan  1  1970 uprobe -> ../../../devices/uprobe
> > root@roc-rk3399-pc:~#
> >
> > running perf test now:
> >
> > Linux roc-rk3399-pc 6.1.0-rc5-00123-g4dd7ff4a0311 #2 SMP PREEMPT Wed Nov 16 19:55:11 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux
> > root@roc-rk3399-pc:~# perf test
> >   1: vmlinux symtab matches kallsyms                                 : Ok
> >   2: Detect openat syscall event                                     : Ok
> >   3: Detect openat syscall event on all cpus                         : Ok
> >   4: mmap interface tests                                            :
> >   4.1: Read samples using the mmap interface                         : Ok
> >   4.2: User space counter reading of instructions                    : Skip (permissions)
> >   4.3: User space counter reading of cycles                          : Skip (permissions)
> >   5: Test data source output                                         : Ok
> >   6: Parse event definition strings                                  :
> >   6.1: Test event parsing                                            : FAILED!
> >   6.2: Parsing of all PMU events from sysfs                          : Ok
> >   6.3: Parsing of given PMU events from sysfs                        : Ok
> >   6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
> >   6.5: Parsing of aliased events                                     : Ok
> >   6.6: Parsing of terms (event modifiers)                            : Ok
> >   7: Simple expression parser                                        : Ok
> >   8: PERF_RECORD_* events & perf_sample fields                       : Ok
> >   9: Parse perf pmu format                                           : Ok
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : Ok
> >  10.2: PMU event map aliases                                         : Ok
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >  10.5: Parsing of metric thresholds with fake PMUs                   : Ok
> >  11: DSO data read                                                   : Ok
> >  12: DSO data cache                                                  : Ok
> >  13: DSO data reopen                                                 : Ok
> >  14: Roundtrip evsel->name                                           : Ok
> >  15: Parse sched tracepoints fields                                  : Ok
> >   16: syscalls:sys_enter_openat event fields                          : Ok
> >  17: Setup struct perf_event_attr                                    : Skip
> >  18: Match and link multiple hists                                   : Ok
> >  19: 'import perf' in python                                         : FAILED!
> >  20: Breakpoint overflow signal handler                              : Skip
> >  21: Breakpoint overflow sampling                                    : Skip
> >  22: Breakpoint accounting                                           : Ok
> >  23: Watchpoint                                                      :
> >  23.1: Read Only Watchpoint                                          : Ok
> >  23.2: Write Only Watchpoint                                         : Ok
> >  23.3: Read / Write Watchpoint                                       : Ok
> >  23.4: Modify Watchpoint                                             :
> > ...
> >
> >
> >
> >
> >
> > acme@roc-rk3399-pc:~/git/perf-tools-next$ cat /proc/cpuinfo
> > processor       : 0
> > BogoMIPS        : 48.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> > CPU implementer : 0x41
> > CPU architecture: 8
> > CPU variant     : 0x0
> > CPU part        : 0xd03
> > CPU revision    : 4
> >
> > processor       : 1
> > BogoMIPS        : 48.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> > CPU implementer : 0x41
> > CPU architecture: 8
> > CPU variant     : 0x0
> > CPU part        : 0xd03
> > CPU revision    : 4
> >
> > processor       : 2
> > BogoMIPS        : 48.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> > CPU implementer : 0x41
> > CPU architecture: 8
> > CPU variant     : 0x0
> > CPU part        : 0xd03
> > CPU revision    : 4
> >
> > processor       : 3
> > BogoMIPS        : 48.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> > CPU implementer : 0x41
> > CPU architecture: 8
> > CPU variant     : 0x0
> > CPU part        : 0xd03
> > CPU revision    : 4
> >
> > processor       : 4
> > BogoMIPS        : 48.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> > CPU implementer : 0x41
> > CPU architecture: 8
> > CPU variant     : 0x0
> > CPU part        : 0xd08
> > CPU revision    : 2
> >
> > processor       : 5
> > BogoMIPS        : 48.00
> > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
> > CPU implementer : 0x41
> > CPU architecture: 8
> > CPU variant     : 0x0
> > CPU part        : 0xd08
> > CPU revision    : 2
> >
> > acme@roc-rk3399-pc:~/git/perf-tools-next$
> >
> > root@roc-rk3399-pc:~# dmidecode
> > # dmidecode 3.3
> > Getting SMBIOS data from sysfs.
> > SMBIOS 3.0 present.
> > 7 structures occupying 287 bytes.
> > Table at 0xF0E3C020.
> >
> > Handle 0x0000, DMI type 0, 24 bytes
> > BIOS Information
> >         Vendor: U-Boot
> >         Version: 2022.10-rc5+
> >         Release Date: 10/01/2022
> >         ROM Size: 64 kB
> >         Characteristics:
> >                 PCI is supported
> >                 BIOS is upgradeable
> >                 Selectable boot is supported
> >                 Targeted content distribution is supported
> >                 UEFI is supported
> >         BIOS Revision: 22.10
> >
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: libre-computer
> >         Product Name: roc-rk3399-pc
> >         Version: Not Specified
> >         Serial Number: b03c01a7179278b7
> >         UUID: 63333062-3130-3761-3137-393237386237
> >         Wake-up Type: Reserved
> >         SKU Number: Not Specified
> >         Family: Not Specified
> >
> > Handle 0x0002, DMI type 2, 14 bytes
> > Base Board Information
> >         Manufacturer: libre-computer
> >         Product Name: roc-rk3399-pc
> >         Version: Not Specified
> >         Serial Number: Not Specified
> >         Asset Tag: Not Specified
> >         Features:
> >                 Board is a hosting board
> >         Location In Chassis: Not Specified
> >         Chassis Handle: 0x0000
> >         Type: Motherboard
> >
> > Handle 0x0003, DMI type 3, 21 bytes
> > Chassis Information
> >         Manufacturer: libre-computer
> >         Type: Desktop
> >         Lock: Not Present
> >         Version: Not Specified
> >         Serial Number: Not Specified
> >         Asset Tag: Not Specified
> >         Boot-up State: Safe
> >         Power Supply State: Safe
> >         Thermal State: Safe
> >         Security Status: None
> >         OEM Information: 0x00000000
> >         Height: Unspecified
> >         Number Of Power Cords: Unspecified
> >         Contained Elements: 0
> >
> > Handle 0x0004, DMI type 4, 48 bytes
> > Processor Information
> >         Socket Designation: Not Specified
> >         Type: Central Processor
> >         Family: Unknown
> >         Manufacturer: Unknown
> >         ID: 00 00 00 00 00 00 00 00
> >         Version: Unknown
> >         Voltage: Unknown
> >         External Clock: Unknown
> >         Max Speed: Unknown
> >         Current Speed: Unknown
> >         Status: Unpopulated
> >         Upgrade: None
> >         L1 Cache Handle: Not Provided
> >         L2 Cache Handle: Not Provided
> >         L3 Cache Handle: Not Provided
> >         Serial Number: Not Specified
> >         Asset Tag: Not Specified
> >         Part Number: Not Specified
> >         Characteristics: None
> >
> > Handle 0x0005, DMI type 32, 11 bytes
> > System Boot Information
> >         Status: No errors detected
> >
> > Handle 0x0006, DMI type 127, 4 bytes
> > End Of Table
> >
> > root@roc-rk3399-pc:~#
> >
> >

-- 

- Arnaldo
