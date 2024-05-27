Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB617E8FB;
	Mon, 27 May 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830913; cv=none; b=MISYpPDHBBluPW62q3Ry0AB9TLuzgzKZYp60HYmQmMgllt/dwrNlV3zDTObZDUT0FhrXke1THg0RdJqs/+A+eH/FhBOc3KqBrwcKQYu4yFjoODmSIHd5jCdHUGd1qszkNKpV9EYUjr97JJYGBKewPYGz4l4ymiZ7zrLolA7V0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830913; c=relaxed/simple;
	bh=g5wKQU/guDYMGrjnXbyrVgUA9DXwtjgRHnR+7unS19w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY+uPJpQ/LLK3+gAx0P3AQdFOM85wzp8gNwgvncpsBj0zvRrJm6cyGiZm7aGZhrnq+6TevDnNqBgcC86v2jUl613EmtTWY0HGsvHrl9qUdV9v6uU+hxXkNIecLF0ee44XNKWlQBaYxycxrF0q4C3WbPap3H+v4edmUpCL9kL/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2bBNDXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2bBNDXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269CEC2BBFC;
	Mon, 27 May 2024 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716830912;
	bh=g5wKQU/guDYMGrjnXbyrVgUA9DXwtjgRHnR+7unS19w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2bBNDXKwr7y/APIYEViLv4yi+DGbClOrWb78qbkBgimxXWMLutwxEzII0jVXcSVP
	 JNRIgA047Krusluh6ayAhrYpkkpbK3egbkSrK2jl5RnqHyJaec/zwplQ4RgVsBe5QO
	 BT37L5M0gDw5TBIf3hSp0/gf64KS20mbWIujiKQi11GizBxlb18pgQvaawP2tefpn9
	 LMZ+wG2eG+oTJSXxFnS/nSpGtftw55uD58tVEbZq7oe0A4W0nsObC8s3qbWHvOU3uU
	 onFLFUegH9Ju4a1UbmIG1mcBMZJ8nY8EKnkTwoFE/xsmcIwjhKPn8aW7HKVAuFGLM+
	 qBwFx/xHKTZHQ==
Date: Mon, 27 May 2024 14:28:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Artem Savkov <asavkov@redhat.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <ZlTCvelaGVb6lCia@x1>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZlS9M1vcxZ3Qsx_B@x1>

On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > Add -M/--metrics option to perf-record providing a shortcut to record
> > > metrics and metricgroups. This option mirrors the one in perf-stat.

> > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Signed-off-by: Artem Savkov <asavkov@redhat.com>

> > Not building for me, I needed to add the rblist.h header and also I
> > think we need to use metricgroup__rblist_init(&mevents), right?

> Argh, that is a static function, it seems we trigger it by having
> nr_entries =3D 0, so the following should do the trick:

>   struct rblist mevents =3D { .nr_entries =3D 0, }

> So that we don't depend on the compiler zeroing that field, which for
> local variables it should not.

How did you test this?

I'm trying:

perf list metric

pick a metric then:

perf record -M tma_core_bound

And it gets in a long loop doing perf_event_open() calls...

root@number:~# perf stat -a -M tma_clears_resteers sleep 1

 Performance counter stats for 'system wide':

     4,248,865,818      cpu_core/TOPDOWN.SLOTS/          #      0.5 %  tma_=
clears_resteers   =20
       652,979,004      cpu_core/topdown-retiring/                         =
                  =20
       332,409,986      cpu_core/topdown-bad-spec/                         =
                  =20
     1,535,823,405      cpu_core/topdown-fetch-lat/                        =
                  =20
       322,562,930      cpu_core/topdown-br-mispredict/                    =
                  =20
     1,977,392,925      cpu_core/topdown-fe-bound/                         =
                  =20
     1,301,619,465      cpu_core/topdown-be-bound/                         =
                  =20
        78,222,034      cpu_core/INT_MISC.CLEAR_RESTEER_CYCLES/            =
                         =20
       727,201,022      cpu_core/CPU_CLK_UNHALTED.THREAD/                  =
                   =20
       105,140,481      cpu_core/INT_MISC.UNKNOWN_BRANCH_CYCLES/           =
                          =20
         5,067,924      cpu_core/INT_MISC.UOP_DROPPING/                    =
                  =20

       1.002715853 seconds time elapsed

root@number:~# gdb perf
GNU gdb (Fedora Linux) 14.2-1.fc39
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from perf...
(gdb) run record -a -M tma_clears_resteers sleep 1
Starting program: /root/bin/perf record -a -M tma_clears_resteers sleep 1

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.fedoraproject.org/>
Enable debuginfod for this session? (y or [n]) n
Debuginfod has been disabled.
To make this setting permanent, add 'set debuginfod enabled off' to .gdbini=
t.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 688237]
^C
Program received signal SIGINT, Interrupt.
0x00007ffff6f21804 in close () from /lib64/libc.so.6
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-16=
=2Efc39.x86_64 capstone-4.0.2-15.fc39.x86_64 elfutils-debuginfod-client-0.1=
91-2.fc39.x86_64 elfutils-libelf-0.191-2.fc39.x86_64 elfutils-libs-0.191-2.=
fc39.x86_64 glib2-2.78.6-1.fc39.x86_64 glibc-2.38-18.fc39.x86_64 keyutils-l=
ibs-1.6.3-1.fc39.x86_64 krb5-libs-1.21.2-3.fc39.x86_64 libbabeltrace-1.5.11=
-5.fc39.x86_64 libcap-2.48-9.fc39.x86_64 libcom_err-1.47.0-2.fc39.x86_64 li=
bcurl-minimal-8.2.1-5.fc39.x86_64 libidn2-2.3.7-1.fc39.x86_64 libnghttp2-1.=
55.1-5.fc39.x86_64 libpfm-4.13.0-4.fc39.x86_64 libselinux-3.5-5.fc39.x86_64=
 libstdc++-13.2.1-7.fc39.x86_64 libtraceevent-1.7.2-3.fc39.x86_64 libunistr=
ing-1.1-5.fc39.x86_64 libunwind-1.7.0-0.2.rc2.fc39.x86_64 libuuid-2.39.4-1.=
fc39.x86_64 libzstd-1.5.6-1.fc39.x86_64 numactl-libs-2.0.16-3.fc39.x86_64 o=
pencsd-1.4.0-1.fc39.x86_64 openssl-libs-3.1.1-4.fc39.x86_64 pcre2-10.42-1.f=
c39.2.x86_64 perl-libs-5.38.2-502.fc39.x86_64 popt-1.19-3.fc39.x86_64 pytho=
n3-libs-3.12.3-2.fc39.x86_64 slang-2.3.3-4.fc39.x86_64 xz-libs-5.4.4-1.fc39=
=2Ex86_64 zlib-1.2.13-4.fc39.x86_64
(gdb) bt
#0  0x00007ffff6f21804 in close () from /lib64/libc.so.6
#1  0x000000000061fbd2 in perf_evsel__close_fd_cpu (evsel=3D0xdab470, cpu_m=
ap_idx=3D6) at evsel.c:188
#2  0x000000000061fc22 in perf_evsel__close_fd (evsel=3D0xdab470) at evsel.=
c:197
#3  0x000000000061fc9b in perf_evsel__close (evsel=3D0xdab470) at evsel.c:2=
11
#4  0x00000000004e0b5f in evlist.reset_weak_group ()
#5  0x0000000000423bb9 in __cmd_record.constprop.0 ()
#6  0x00000000004276c5 in cmd_record ()
#7  0x00000000004c4579 in run_builtin ()
#8  0x00000000004c4889 in handle_internal_command ()
#9  0x0000000000410e57 in main ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x00007ffff6f21804 in close () from /lib64/libc.so.6
(gdb)
=20
So you should investigate this further.

The idea, from my notes, was to be able to have extra columns in 'perf
report' with things like IPC and other metrics, probably not all metrics
will apply. We need to find a way to find out which ones are OK for that
purpose, for instance:

root@number:~# perf stat -a -M tma_branch_resteers sleep 1

 Performance counter stats for 'system wide':

   209,159,606,886      cpu_core/TOPDOWN.SLOTS/          #      3.2 %  tma_=
branch_resteers   =20
    55,156,278,851      cpu_core/topdown-retiring/                         =
                  =20
     7,779,703,706      cpu_core/topdown-bad-spec/                         =
                  =20
    17,644,918,779      cpu_core/topdown-fetch-lat/                        =
                  =20
    39,431,478,422      cpu_core/topdown-fe-bound/                         =
                  =20
   107,325,133,399      cpu_core/topdown-be-bound/                         =
                  =20
     1,066,765,398      cpu_core/INT_MISC.CLEAR_RESTEER_CYCLES/            =
                         =20
    35,367,316,520      cpu_core/CPU_CLK_UNHALTED.THREAD/                  =
                   =20
        73,066,635      cpu_core/INT_MISC.UNKNOWN_BRANCH_CYCLES/           =
                          =20
       106,828,690      cpu_core/INT_MISC.UOP_DROPPING/                    =
                  =20

       1.001581758 seconds time elapsed

root@number:~#=20

But then:

root@number:~# perf record -e cpu_core/TOPDOWN.SLOTS/,cpu_core/topdown-bad-=
spec/,cpu_core/topdown-fetch-lat/,cpu_core/topdown-fe-bound/,cpu_core/topdo=
wn-be-bound/,cpu_core/INT_MISC.CLEAR_RESTEER_CYCLES/,cpu_core/CPU_CLK_UNHAL=
TED.THREAD/,cpu_core/INT_MISC.UNKNOWN_BRANCH_CYCLES/,cpu_core/INT_MISC.UOP_=
DROPPING/
WARNING: events were regrouped to match PMUs
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for e=
vent (cpu_core/topdown-bad-spec/).
/bin/dmesg | grep -i perf may provide additional information.

root@number:~#

That invalid argument error message needs improvement, but its one
example of a metric where events can't be sampled with 'perf record' for
some reason:

Opening: cpu_core/topdown-bad-spec/
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu_core)
  size                             136
  config                           0x8100 (topdown-bad-spec)
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  freq                             1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off PERF_FORMAT_LOST support
Opening: cpu_core/topdown-bad-spec/

It goes down disabling several perf_event_attr assuming the kernel
doesn't have support for features but ultimately fails and returns the
cryptic EINVAL.

Ian, can you take a look at this:

root@number:~# perf stat -a -M tma_branch_resteers sleep 1

 Performance counter stats for 'system wide':

   207,780,999,822      cpu_core/TOPDOWN.SLOTS/          #      5.6 %  tma_=
branch_resteers   =20
    46,114,346,088      cpu_core/topdown-retiring/                         =
                  =20
    12,533,625,786      cpu_core/topdown-bad-spec/                         =
                  =20
    25,845,036,349      cpu_core/topdown-fetch-lat/                        =
                  =20
    50,198,057,652      cpu_core/topdown-fe-bound/                         =
                  =20
    99,605,368,200      cpu_core/topdown-be-bound/                         =
                  =20
     1,720,994,647      cpu_core/INT_MISC.CLEAR_RESTEER_CYCLES/            =
                         =20
    39,224,461,225      cpu_core/CPU_CLK_UNHALTED.THREAD/                  =
                   =20
       469,464,484      cpu_core/INT_MISC.UNKNOWN_BRANCH_CYCLES/           =
                          =20
       260,388,972      cpu_core/INT_MISC.UOP_DROPPING/                    =
                  =20

       1.004820692 seconds time elapsed

root@number:~# perf stat -a -e cpu_core/topdown-bad-spec/ sleep 1

 Performance counter stats for 'system wide':

   <not supported>      cpu_core/topdown-bad-spec/                         =
                  =20

       1.003017044 seconds time elapsed

root@number:~# perf stat -a -e cpu_atom/topdown-bad-spec/ sleep 1

 Performance counter stats for 'system wide':

    19,178,297,593      cpu_atom/topdown-bad-spec/                         =
                  =20

       1.002640873 seconds time elapsed

root@number:~#

It states that it was able to count cpu_core/topdown-bad-spec/ when
calling via the tma_branch_resteers metric, but then if I call it
directly it says its not supported for cpu_core, while works for
cpu_atom, this looks wrong, no?

- Arnaldo
