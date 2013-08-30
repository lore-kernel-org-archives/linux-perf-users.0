From: Mikhail Kulemin <mihkulemin@gmail.com>
Subject: Re: What should I do if I want to get Perf samples and Read
 Performance Counter at the same time?
Date: Fri, 30 Aug 2013 08:28:51 +0400
Message-ID: <CAKnzfP995a6UrpKDJ4akOMDBX-j9vkwhtp-i0S=WM3v3pWzQvg@mail.gmail.com>
References: <CAEuYUerYx9w=LdJsGG0PV0BKteMcoTL4ro=3+nfm8hBdXtuZ2w@mail.gmail.com>
	<521E57D4.7090105@gmail.com>
	<CAKnzfP9VxYry9v+tSyTrs_9m6GFoCGzAuKXY0_yv99LqumeZEg@mail.gmail.com>
	<CAEuYUeoj9YmHmD9SPv1OMdqaNV+C3e1UoMxTKW4kvQbmJxq2=A@mail.gmail.com>
	<CAKnzfP85J+AD9A4E2OD9ZzHfCoE_0srPdFRJp2SXmwFc6Dh_Jg@mail.gmail.com>
	<CAEuYUep-n=Pts8sFSusgOvKG8xTY8=aQqjb8mqtEpfUzz6ihCw@mail.gmail.com>
	<CAEuYUepG4p2+ET81MdrrajgUvfgG4=WnNwSDKpPS8YSQ8EO+6w@mail.gmail.com>
	<CAKnzfP99WV-p=WP0zgs-68+dy7pTxkfMPcDEmL_P6KL4jh2Umw@mail.gmail.com>
	<CAEuYUepPNNpUQ8ysgyR6DK85_kUqiZyz=hdfnfwzFQtCG=mhuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:50687 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab3H3E2v (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 30 Aug 2013 00:28:51 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so1343903pdj.32
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2013 21:28:51 -0700 (PDT)
In-Reply-To: <CAEuYUepPNNpUQ8ysgyR6DK85_kUqiZyz=hdfnfwzFQtCG=mhuQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>, David Ahern <dsahern@gmail.com>, perf group <linux-perf-users@vger.kernel.org>

You can ignote message about Android. As far as I understand form
output you should see compiled executable of perf in tools/perf
directory. Please check it.

2013/8/30 Peipei Wang <wangpeipei.90@gmail.com>:
> Hi Mikhail,
>
> After installing all these dependency libraries, still get the following
> error. I have no idea about the whole thing of "Android/api-level.h".
>
> peipei@sif:~/linux-perf$ sudo make -C tools/perf -s V=1 WERROR=0
> NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1
>     CHK -fstack-protector-all
>     CHK -Wstack-protector
>     CHK -Wvolatile-register-var
>     CHK -D_FORTIFY_SOURCE=2
>     CHK bionic
> <stdin>:1:31: fatal error: android/api-level.h: No such file or directory
> compilation terminated.
>     CHK libelf
>     CHK libdw
>     CHK -DLIBELF_MMAP
>     CHK libaudit
>     CHK libslang
>     CHK perl
>     CHK python
>     CHK python version
>     CHK -DHAVE_ON_EXIT
>     CHK -DBACKTRACE_SUPPORT
>     * new build flags or prefix
>
> Best wishes.
> Yours,
> Wang Peipei
>
>
> On Thu, Aug 29, 2013 at 11:40 PM, Mikhail Kulemin <mihkulemin@gmail.com>
> wrote:
>>
>> About perf version: yes, you need to use perf version corresponding to
>> the linux kernel version.
>>
>> According perf compilation: you need to install smth like
>> "binutils-dev" package to resolve dependency form library and try to
>> compile perf
>>
>> 2013/8/30 Peipei Wang <wangpeipei.90@gmail.com>:
>> > Hi Mikhail,
>> >
>> > I get a git clone from
>> > https://git.kernel.org/cgit/linux/kernel/git/namhyung/linux-perf.git/,
>> > then
>> > I checkout the tag v3.10, install libperl-dev, and use exactly the
>> > command
>> > you give to me, but there are still a few problems:
>> >
>> > peipei@sif:~/linux-perf$ sudo make -C tools/perf -s V=1 WERROR=0
>> > NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1
>> >     CHK -fstack-protector-all
>> >     CHK -Wstack-protector
>> >     CHK -Wvolatile-register-var
>> >     CHK -D_FORTIFY_SOURCE=2
>> >     CHK bionic
>> > <stdin>:1:31: fatal error: android/api-level.h: No such file or
>> > directory
>> > compilation terminated.
>> >     CHK libelf
>> >     CHK libdw
>> > <stdin>:1:19: fatal error: dwarf.h: No such file or directory
>> > compilation terminated.
>> > Makefile:603: No libdw.h found or old libdw.h found or elfutils is older
>> > than 0.138, disables dwarf support. Please install new
>> > elfutils-devel/libdw-dev
>> >     CHK -DLIBELF_MMAP
>> >     CHK libaudit
>> > <stdin>:1:22: fatal error: libaudit.h: No such file or directory
>> > compilation terminated.
>> > Makefile:681: No libaudit.h found, disables 'trace' tool, please install
>> > audit-libs-devel or libaudit-dev
>> >     CHK libslang
>> >     CHK perl
>> >     CHK python
>> >     CHK python version
>> >     CHK -DHAVE_ON_EXIT
>> >     CHK -DBACKTRACE_SUPPORT
>> >     * new build flags or prefix
>> > /usr/bin/ld: cannot find -liberty
>> > collect2: ld returned 1 exit status
>> > make: *** [perf] Error 1
>> >
>> > What should I do next??
>> >
>> >
>> > Best wishes.
>> > Yours,
>> > Wang Peipei
>> >
>> >
>> > On Thu, Aug 29, 2013 at 9:14 PM, Peipei Wang <wangpeipei.90@gmail.com>
>> > wrote:
>> >>
>> >> Hi Mikhail,
>> >>
>> >> I am using ubuntu 12.04 and I just update my kernel version to the same
>> >> as
>> >> yours:3.10.9.Then I got problems about which perf version I should use.
>> >> The
>> >> error is like this:
>> >>
>> >> peipei@sif:~/linux_install$ perf script
>> >> perf_3.10.9-031009 not found
>> >> You may need to install linux-tools-3.10.9-031009
>> >>
>> >>
>> >> What version do you use?? I could not found a corresponding version of
>> >> linux-tools on ubuntu repository, neither on google results. Please how
>> >> I
>> >> can get an appropriate perf version to use.
>> >>
>> >>
>> >> Best wishes.
>> >> Yours,
>> >> Wang Peipei
>> >>
>> >>
>> >> On Thu, Aug 29, 2013 at 2:58 PM, Mikhail Kulemin <mihkulemin@gmail.com>
>> >> wrote:
>> >>>
>> >>> Sorry, I didn`t mention that I described perf behaviour for latest
>> >>> stable kernel 3.10.9.
>> >>> For my examples I use perf on Fedora 19 with latest kernel available.
>> >>>
>> >>> What disrtib are you use? Can you update it to latest version?
>> >>>
>> >>> As far as I understand you are working with kernel 3.2.0 and perf
>> >>> corresponding this version of kernel has different API for python.
>> >>> I quickly look at sources
>> >>>
>> >>>
>> >>> (http://lxr.linux.no/#linux+v3.2/tools/perf/util/scripting-engines/trace-event-python.c)
>> >>> and could not find mention about process_event() function. It looks
>> >>> like hw events handled with trace_unhandled() function as another
>> >>> kinds of events. So you should use another script for tracing with
>> >>> this version of kernel.
>> >>>
>> >>> According scripting support: It looks like you need to recompile perf
>> >>> package (or package that has perf utility) with scripting enable. You
>> >>> need to check how package maintainer compile perf in you distribution.
>> >>> For example in Fedora perf located in package perf when compiling
>> >>> kernel (because perf sources located in kernel tree).
>> >>> Perf compiled with make command:
>> >>> make -C tools/perf -s V=1 WERROR=0 NO_LIBUNWIND=1
>> >>> HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 pref
>> >>>
>> >>> Check such build scripts for your distribution, maybe Python scripting
>> >>> disabled in build time (possible).
>> >>>
>> >>>
>> >>> 2013/8/29 Peipei Wang <wangpeipei.90@gmail.com>:
>> >>> > Hi Mikhail,
>> >>> >
>> >>> > I got stuck when enabling Python scripting in perf. It tells me to
>> >>> > install
>> >>> > python and recompile perf after that. However, even after I removed
>> >>> > the
>> >>> > linux-tools at first, reinstalled python-dev amd reinstalled
>> >>> > linux-tools,
>> >>> > the perf script -g py still shows messages as follows:
>> >>> >
>> >>> > perf script -g py
>> >>> > Python scripting not supported.  Install libpython and rebuild perf
>> >>> > to
>> >>> > enable it
>> >>> > For example:
>> >>> >   # apt-get install python-dev (ubuntu)
>> >>> >   # yum install python-devel (Fedora)
>> >>> >   etc.
>> >>> > # ========
>> >>> > # captured on: Thu Aug 29 11:16:01 2013
>> >>> > # hostname : sif.thho.net
>> >>> > # os release : 3.2.0-43-generic
>> >>> > # perf version : 3.2.42
>> >>> > # arch : x86_64
>> >>> > # nrcpus online : 4
>> >>> > # nrcpus avail : 4
>> >>> > # cpudesc : Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz
>> >>> > # cpuid : GenuineIntel,6,42,7
>> >>> > # total memory : 8133464 kB
>> >>> > # cmdline : /usr/bin/perf_3.2.0-43 record -e cache-misses ls
>> >>> > # event : name = cache-misses, type = 0, config = 0x3, config1 =
>> >>> > 0x0,
>> >>> > config2 =
>> >>> > # HEADER_CPU_TOPOLOGY info available, use -I to display
>> >>> > # HEADER_NUMA_TOPOLOGY info available, use -I to display
>> >>> > # ========
>> >>> >
>> >>> >
>> >>> > Best wishes.
>> >>> > Yours,
>> >>> > Wang Peipei
>> >>> >
>> >>> >
>> >>> > On Thu, Aug 29, 2013 at 12:59 AM, Mikhail Kulemin
>> >>> > <mihkulemin@gmail.com>
>> >>> > wrote:
>> >>> >>
>> >>> >> There is a possibility to use perf script with python or perl.
>> >>> >>
>> >>> >> 1) Record needed events with perf record
>> >>> >>
>> >>> >> [mih@home perf]$ perf record -e cache-misses ls
>> >>> >> [ perf record: Woken up 1 times to write data ]
>> >>> >> [ perf record: Captured and wrote 0.013 MB perf.data (~556 samples)
>> >>> >> ]
>> >>> >>
>> >>> >> 2) You can see actual info about events using 'perf script'
>> >>> >>
>> >>> >> [mih@home perf]$ perf script
>> >>> >> # ========
>> >>> >> # captured on: Thu Aug 29 08:33:20 2013
>> >>> >>
>> >>> >> <...some info ommited...>
>> >>> >>
>> >>> >> # cmdline : /usr/bin/perf record -e cache-misses ls
>> >>> >> # event : name = cache-misses, type = 0, config = 0x3, config1 =
>> >>> >> 0x0,
>> >>> >> config2 =
>> >>> >> # HEADER_CPU_TOPOLOGY info available, use -I to display
>> >>> >> # HEADER_NUMA_TOPOLOGY info available, use -I to display
>> >>> >> # pmu mappings: cpu = 4, software = 1, tracepoint = 2,
>> >>> >> uncore_cbox_0 =
>> >>> >> 6,
>> >>> >> uncore
>> >>> >> # ========
>> >>> >> #
>> >>> >>            :2717  2717  1148.761687: cache-misses:
>> >>> >> ffffffff8107cc0d
>> >>> >> task_tgid_n
>> >>> >>            :2717  2717  1148.761690: cache-misses:
>> >>> >> ffffffff8107cc0d
>> >>> >> task_tgid_n
>> >>> >>               ls  2717  1148.761693: cache-misses:
>> >>> >> ffffffff8111e2f6
>> >>> >> __perf_even
>> >>> >>               ls  2717  1148.761696: cache-misses:
>> >>> >> ffffffff8106e410
>> >>> >> flush_signa
>> >>> >>               ls  2717  1148.761702: cache-misses:
>> >>> >> ffffffff812f1867
>> >>> >> clear_page_
>> >>> >>               ls  2717  1148.761834: cache-misses:
>> >>> >> 3a5bc17f70
>> >>> >> open64 (/us
>> >>> >>               ls  2717  1148.762713: cache-misses:
>> >>> >> ffffffff8139c103
>> >>> >> do_output_c
>> >>> >> (END)
>> >>> >>
>> >>> >> 3) You can see time of each sample but can not see number of events
>> >>> >> in
>> >>> >> each sample. By default there can be different number of events in
>> >>> >> each sample. To get such info you can use custom script. First of
>> >>> >> all
>> >>> >> generate basic template
>> >>> >>
>> >>> >> [mih@home perf]$ perf script -g py
>> >>> >> generated Python script: perf-script.py
>> >>> >>
>> >>> >> This script handled only tracepoint events. (For more information
>> >>> >> about scripting for perf read "man perf-script"). To handle hw
>> >>> >> events
>> >>> >> you can use function process_event(). This function is not well
>> >>> >> documented but rather simple.  There is one difficulty - you need
>> >>> >> parse C structure of perf_sample to  get info about time and number
>> >>> >> of
>> >>> >> events. I use scruct python module and use perf_struct defenition
>> >>> >> (for
>> >>> >> example from
>> >>> >> http://lxr.linux.no/#linux+v3.10.9/tools/perf/util/event.h#L83
>> >>> >> )
>> >>> >>
>> >>> >> My perf-script.py :
>> >>> >>
>> >>> >> import os
>> >>> >> import sys
>> >>> >> import struct
>> >>> >>
>> >>> >> sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>> >>> >>     '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
>> >>> >>
>> >>> >> from perf_trace_context import *
>> >>> >> from Core import *
>> >>> >>
>> >>> >>
>> >>> >> def trace_begin():
>> >>> >>     print "in trace_begin"
>> >>> >>
>> >>> >> def trace_end():
>> >>> >>     print "in trace_end"
>> >>> >>
>> >>> >> def process_event(param_dict):
>> >>> >>         event_attr = param_dict["attr"]
>> >>> >>         sample     = param_dict["sample"]
>> >>> >>         raw_buf    = param_dict["raw_buf"]
>> >>> >>         comm       = param_dict["comm"]
>> >>> >>         name       = param_dict["ev_name"]
>> >>> >>
>> >>> >>         if (param_dict.has_key("symbol")):
>> >>> >>                 symbol = param_dict["symbol"]
>> >>> >>         else:
>> >>> >>                 symbol = "Unknown_symbol"
>> >>> >>
>> >>> >>         # Extract counts value from perf_sample struct (Dirty.
>> >>> >> Addition to API neeeded.)
>> >>> >>         (counts,) = struct.unpack("=Q",sample[48:56])
>> >>> >>         (time,) = struct.unpack("=Q",sample[16:24])
>> >>> >>
>> >>> >>         print name, counts, time, symbol, comm
>> >>> >>
>> >>> >>
>> >>> >> 4) Run your custom script perf script -s perf-script.py
>> >>> >> [mih@home perf]$ perf script -s perf-script.py
>> >>> >> in trace_begin
>> >>> >> cache-misses 1 1148761687085 task_tgid_nr_ns :2717
>> >>> >> cache-misses 1 1148761690924 task_tgid_nr_ns :2717
>> >>> >> cache-misses 9 1148761693240 __perf_event__output_id_sample ls
>> >>> >> cache-misses 121 1148761696003 flush_signal_handlers ls
>> >>> >> cache-misses 1467 1148761702371 clear_page_c_e ls
>> >>> >> cache-misses 8503 1148761834505 open64 ls
>> >>> >> cache-misses 8469 1148762713882 do_output_char ls
>> >>> >> in trace_end
>> >>> >>
>> >>> >> Time in nanosec - third field
>> >>> >> number of events in sample second field
>> >>> >>
>> >>> >> 5) If you use -c option when running perf record script will report
>> >>> >> only 1 event perf sample (but actial number of events per sample is
>> >>> >> determine by -c parameter)
>> >>> >>
>> >>> >> Mikhail
>> >>> >>
>> >>> >> 2013/8/29 David Ahern <dsahern@gmail.com>:
>> >>> >> > On 8/28/13 11:21 AM, Peipei Wang wrote:
>> >>> >> >>
>> >>> >> >> Hi all,
>> >>> >> >>
>> >>> >> >> Here is my issue, looking forward to the suggestions from you
>> >>> >> >> guys.
>> >>> >> >> I
>> >>> >> >> have a java process and I can get the process id. I want to get
>> >>> >> >> the
>> >>> >> >> information about the event cache-misses for this process at the
>> >>> >> >> sampling rate 100(For this, I use perf record -e cache-misses -c
>> >>> >> >> 100 -p
>> >>> >> >> pid) . And I also want to know how many cache-misses events
>> >>> >> >> occurs
>> >>> >> >> for
>> >>> >> >> each second(For this I use watch perf stat -e cache-misses -p
>> >>> >> >> pid
>> >>> >> >> sleep
>> >>> >> >> 1)
>> >>> >> >>
>> >>> >> >> Any one has ideas about how to get both of them?
>> >>> >> >
>> >>> >> >
>> >>> >> > I believe you will need to write your own perf command to do that
>> >>> >> >
>> >>> >> > David
>> >>> >> >
>> >>> >> >
>> >>> >> > --
>> >>> >> > To unsubscribe from this list: send the line "unsubscribe
>> >>> >> > linux-perf-users"
>> >>> >> > in
>> >>> >> > the body of a message to majordomo@vger.kernel.org
>> >>> >> > More majordomo info at
>> >>> >> > http://vger.kernel.org/majordomo-info.html
>> >>> >
>> >>> >
>> >>
>> >>
>> >
>
>
