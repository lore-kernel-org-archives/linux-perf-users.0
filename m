Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350379F5;
	Sat, 16 Nov 2024 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731787391; cv=none; b=OENEZERLVZd1bbD8rRfclzroGZy00ABA9Mqd0zbVqu/IP2y01LtONQ6u6lXCpHGei8X5rONF4mx2kuClgxv6+cnz8OrJ9oI2QktsrVxUYOtjJt2vAYvIzq5xXwmBj1QDrxMtfVRl764D1M4e3HwcocVAtTP0GTJwzzEJXJew8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731787391; c=relaxed/simple;
	bh=d/pgU208iem07JPd3dosqSeKl9Ew8V7zTta8vPEE0T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELrCeUHKO6sYeIVhJxD/Vx5CDL3sZM/RyzY444W8fkyDL3+xN3bCJZzrAXNAfBU+C+4OUHD4jiW2kJ1ZoQwZEZYC2pZbscMZNngYBoQIvWHdB1Rw61gx7kjcieuIUticjkFkssmpwQ2sR4uOJwuVI56Vz6SZODsB0eFz1q45NAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I826RTx7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I826RTx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294C2C4CEC3;
	Sat, 16 Nov 2024 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731787391;
	bh=d/pgU208iem07JPd3dosqSeKl9Ew8V7zTta8vPEE0T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I826RTx7OuU0PIokoTJE1/SC3TiaUbH1+Rt210WzWnvNGXB5cF8+5x8sHtZKJPZ6M
	 zwqgqMOKRA8Owd8XEWP/ggAd7QfXgMBe5s/RShydysueF4P48vPYp96j+pHPB9Yh7u
	 4I5e3c3gnJhrgYnm80sddZkNLAHOxcJ7/9/u4RYanPcskOZPNWjs33sI37MzPxhYEU
	 82EkRwVvw0JqtbE83As9yri1AY4F/cs8MYmZ6Q/ihEGEOhWT612papjRfT+TZfiAxx
	 FWinIJZBsGL4ErK4AOMxxLcxLBXJ3JnIIyOAlrzsIZJ1bFAiThI/hQI/sNuJLIFb36
	 it5f0BbVWMQ/w==
Date: Sat, 16 Nov 2024 17:03:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf test failures with tmp.perf-tools-next
Message-ID: <Zzj6eoDDQbvZ25jX@x1>
References: <Zzdtj0PEWEX3ATwL@x1>
 <CAP-5=fX7JZNmiaNDezExqGk9FMXdHihxvLNmnD8HHB3YCehemg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX7JZNmiaNDezExqGk9FMXdHihxvLNmnD8HHB3YCehemg@mail.gmail.com>

On Fri, Nov 15, 2024 at 09:54:56AM -0800, Ian Rogers wrote:
> On Fri, Nov 15, 2024 at 7:49 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Not a hwmon file 'name'
> > FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event1', err 1
> > event syntax error: 'temp_test_hwmon_event1'
> >                      \___ Bad event name
> >
> > Unable to find event on a PMU of 'temp_test_hwmon_event1'
> >
> > ---- unexpected signal (11) ----
> >  11.3: Parsing with PMU name                                         : FAILED!
> > root@x1:~#
 
> I'm trying to repro the hwmon issue on tmp.perf-tools-next, with asan
> root/non-root I get:
> ```
>  11: Hwmon PMU                                                       :
> 11.1: Basic parsing test                                            : Ok
> 11.2: Parsing without PMU name                                      : Ok
> 11.3: Parsing with PMU name                                         : Ok
> ```
> I'm trying more machines to try to get a reproduction.

So, I cleaned up everything, rebuilt and the problem persists on a
Fedora 40 lenovo x1 carbon, full verbose mode output at the end.

It also fails on a Raspberry Pi 3:

acme@raspberrypi:~ $ cat /etc/os-release 
PRETTY_NAME="Raspbian GNU/Linux 12 (bookworm)"
NAME="Raspbian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"
acme@raspberrypi:~ $
root@raspberrypi:~# tail -14 /proc/cpuinfo 
processor	: 3
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

Hardware	: BCM2835
Revision	: a020d3
Serial		: 00000000783939e0
Model		: Raspberry Pi 3 Model B Plus Rev 1.3
root@raspberrypi:~#

root@raspberrypi:~# ~acme/bin/perf -v
perf version 6.12.rc6.gdb26a8c9e3c2
root@raspberrypi:~# ~acme/bin/perf -vv
perf version 6.12.rc6.gdb26a8c9e3c2
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
              libaudit: [ on  ]  # HAVE_LIBAUDIT_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
         syscall_table: [ OFF ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
root@raspberrypi:~# ~acme/bin/perf test 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
root@raspberrypi:~# ~acme/bin/perf test -vv 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test:
--- start ---
test child forked, pid 6983
hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
---- end(0) ----
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name:
--- start ---
test child forked, pid 6984
Testing 'temp_test_hwmon_event1'
Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: removing event 'in0' that has no input file
Testing 'temp1'
Attempt to add: hwmon_a_test_hwmon_pmu/temp1/
..after resolving event: hwmon_a_test_hwmon_pmu/temp1/
temp1 -> hwmon_a_test_hwmon_pmu/temp1/
Attempt to add: hwmon_cpu_thermal/temp1/
..after resolving event: hwmon_cpu_thermal/temp1/
temp1 -> hwmon_cpu_thermal/temp1/
FAILED tests/hwmon_pmu.c:180 Unexpected config for 'temp1', 2114584577 != 655361
---- end(-1) ----
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name:
--- start ---
test child forked, pid 6985
Testing 'temp_test_hwmon_event1'
Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: removing event 'in0' that has no input file
Testing 'temp1'
Attempt to add: hwmon_a_test_hwmon_pmu/temp1/
..after resolving event: hwmon_a_test_hwmon_pmu/temp1/
temp1 -> hwmon_a_test_hwmon_pmu/temp1/
Attempt to add: hwmon_cpu_thermal/temp1/
..after resolving event: hwmon_cpu_thermal/temp1/
temp1 -> hwmon_cpu_thermal/temp1/
FAILED tests/hwmon_pmu.c:180 Unexpected config for 'temp1', 2114584577 != 655361
---- end(-1) ----
 11.3: Parsing with PMU name                                         : FAILED!
root@raspberrypi:~#

You asked this via chat:

(gdb) b hwmon_pmu__have_event
Breakpoint 1 at 0x661071: file util/hwmon_pmu.c, line 559.
(gdb) run test 11
Starting program: /root/bin/perf test 11

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.fedoraproject.org/>
Enable debuginfod for this session? (y or [n]) n
Debuginfod has been disabled.
To make this setting permanent, add 'set debuginfod enabled off' to .gdbinit.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 595037]
[Detaching after fork from child process 595039]
[Detaching after fork from child process 595040]
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
[Inferior 1 (process 594467) exited normally]
(gdb) bt
No stack.
(gdb)

Hope this helps, will go AFK now, happy to try more stuff and will also
try to figure this out myself if you don't do it first.

Since this doesn't seem to be something related to the patches processed
this week I'll just push what we have to perf-tools-next so that it gets
tested on linux-next.

- Arnaldo

On the Fedora 40 system:

root@x1:~# perf test hwmon
root@x1:~# perf test 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
root@x1:~# perf test -v 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
root@x1:~# perf test -vv 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test:
--- start ---
test child forked, pid 406656
hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
---- end(0) ----
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name:
--- start ---
test child forked, pid 406657
Testing 'temp_test_hwmon_event1'
Using CPUID GenuineIntel-6-BA-3
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'pwm1'
Not a hwmon file 'pwm1'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: removing event 'pwm1' that has no input file
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
free(): invalid pointer

---- unexpected signal (6) ----
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name:
--- start ---
test child forked, pid 406658
Testing 'temp_test_hwmon_event1'
Using CPUID GenuineIntel-6-BA-3
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'pwm1'
Not a hwmon file 'pwm1'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: removing event 'pwm1' that has no input file
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'

---- unexpected signal (11) ----
 11.3: Parsing with PMU name                                         : FAILED!
root@x1:~#
