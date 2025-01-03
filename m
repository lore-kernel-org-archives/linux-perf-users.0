Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244E8F64
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866530; cv=none; b=MN7Uto3zXbwk+XxaJ7zSRRZ0rWiRokNCSnmA1txtv08B40YxzI9Rh7VUpYyMrwUafOmglfpJ++qG9Awa8S5y1kjZx+WYPhDNUPgEROD9TvyoyaQcsnrAuJxahMk8CFoeuA5sjeU1LH4Ji5FbTAKzP1+Gl8FmctcMSXV9XppqldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866530; c=relaxed/simple;
	bh=MjxVQX/rCXpWmxAQaFRD/fm3fePTtFgOSvt2KuQbhSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEBFfobJIjYz1Eisf1REhnz7bR1OnA/j35ZSGCVDMilPRpPr7MzJW4Uy/zbv9keQg93A41v+NapFGTF25HIU9dT9CV/E4zGktxKa0klgmfI8pulTxDbUIn05kTl1Fglm8gAcT/En7N5WjTtC1bsf8u1ZlMnGO6ckYXWOOTxfi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lurDJYDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lurDJYDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C56C4CED0;
	Fri,  3 Jan 2025 01:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735866530;
	bh=MjxVQX/rCXpWmxAQaFRD/fm3fePTtFgOSvt2KuQbhSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lurDJYDfz75w+0TGkaoBEcrXdP5so7/Qv4f7xAe8sY5EALanDYfqcwOzoYqHZrnx8
	 eAYod2+nvk7xdPC3UzE7lGZaXyxF7HKnIORo7s3f7ZQHxqgq+5k/uGSqSWVAFDqJ/U
	 8RoXRgryAD4UnXee6yDDk/PdmwzSq0DgWQa8qigNDQDXFcnirP03LgXW+DTtEEzkR9
	 8Tcw5Big5Rc/RwiQuJJi4+JVVq356gPZp/P1/WxHveII1jJP1Z61eNnr+auZi+5DhL
	 W3Dl/LtfZhbkhPhZLsBZYfWPXKgJ0f84fIx2ugqekCP7zrc2xUbKkjBPKEEoG+LJJo
	 u/pSBiGXbr2yQ==
Date: Thu, 2 Jan 2025 22:08:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
Message-ID: <Z3c4nupM-UENN5LM@x1>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org>
 <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu>
 <Z3bYltoidQpqtyJ_@x1>
 <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu>

On Thu, Jan 02, 2025 at 08:42:26PM +0100, Christophe Leroy wrote:
> Le 02/01/2025 =E0 19:19, Arnaldo Carvalho de Melo a =E9crit=A0:
> > On Thu, Jan 02, 2025 at 03:41:17PM +0100, Christophe Leroy wrote:
> > > Le 26/12/2024 =E0 16:51, Arnaldo Carvalho de Melo a =E9crit=A0:
> > > > On Tue, Dec 17, 2024 at 02:18:07PM +0000, James Clark wrote:
> > > > > On 16/12/2024 7:01 am, Christophe Leroy wrote:
> > > > > > I noticed with 6.12 LTS Kernel that perf top and perf record/re=
port
> > > > > > don't display kernel symbols anymore, instead it displays the r=
aw
> > > > > > address with [unknown] as object.
> >=20
> > > > > > After bisect I see that the problem appears with commit 659ad34=
92b91
> > > > > > ("perf maps: Switch from rbtree to lazily sorted array for addr=
esses").
> > > > > You might want to try applying 0b90dfda222e3 as it claims to fix =
this
> > > > > commit. I doubt that will fix your issue but it's worth being sur=
e.
> > > > > There was also another fix recently that could be related: 23c44f=
6c83
> > > > > Did you try the perf-tools-next branch? Maybe something that's al=
ready fixed
> > > > > needs to be backported.
> >=20
> > > > Right, I tried reproducing this on perf-tools-next and couldn't, so
> > > > please test it there.
> > > I tested it again on latest perf-tools-next (ed60738a9b7e ("perf stat:
> > > Document and clarify outstate members")) and still have the same prob=
lem,
> > > all kernel symbols appear as [unknown]:
> > >     PerfTop:    4163 irqs/sec  kernel:28.3%  exact:  0.0% lost: 0/0 d=
rop:
> > > 0/14199 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> >=20
> > So this seems to be on a virt environment? Or have you explicitely used
> > '-e cpu-clock:ppp'?
>=20
> It is a real HW and I have _not_ used -e cpu-clock:ppp

I think we need to change the output of 'perf top' output to streamline
this reporting process, I'll try to look into it, how to cram more info
in as few top lines as possible to help resolving issues.
=20
> root@vgoippro:~# cat /proc/cpuinfo
> processor       : 0
> cpu             : e300c2
> clock           : 333.333335MHz
> revision        : 1.1 (pvr 8084 0011)
> bogomips        : 66.66
>=20
> timebase        : 33333333
> platform        : CMPCPRO
> model           : MIAE
> Memory          : 512 MB
>=20
=20
> > Also can you please run with -v or with -vv to see if we can get some
> > more clues?
=20
> Sure, see at the end (first is the one that fails, followed by the one th=
at
> works)

Thanks!
=20
> > Maybe it is somehow not able to read kallsyms or find a suitable
> > vmlinux?
=20
> There's no vmlinux but it should be able to read kallsyms as it does with
> earlier version

Right, I got distracted by another issue while trying to understand this
one, CCed you on my report on that.
=20
> > Also what distro is this?

> No distro, it's raw embedded system built from scratch with gcc 12.3 and
> glibc 2.38

Ok.
=20
> > I did one more test, this time using --stdio on a raspberry pi and
> > explicitely using '-e cycles:ppp' to get as close to your report as I
> > could:

> > root@raspberrypi:~# uname -a
> > Linux raspberrypi 6.6.51+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.51-1+rpt3 (20=
24-10-08) armv7l GNU/Linux
> > root@raspberrypi:~# ~acme/bin/perf --version
> > perf version 6.13.rc2.ged60738a9b7e
> > root@raspberrypi:~# timeout 5s ~acme/bin/perf top -e cpu-cycles:ppp --s=
tdio
> >     PerfTop:     926 irqs/sec  kernel:79.8%  exact:  0.0% lost: 0/0 dro=
p: 0/0 [4000Hz cpu-cycles:ppp],  (all, 4 CPUs)
=20
> root@vgoippro:~# uname -a
> Linux vgoippro 6.12.4-01797-g8ba9a9738762 #556 PREEMPT Sun Dec 15 19:22:33
> CET 2024 ppc GNU/Linux
=20
> root@vgoippro:~# ./perf --version
> perf version 6.13.rc2.ged60738a9b7e
=20
> root@vgoippro:~# timeout 5s ./perf top --stdio
=20
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
>    PerfTop:     524 irqs/sec  kernel:51.1%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
>     17.18%  [unknown]      [k] 0xc0891c14
>      7.63%  [unknown]      [k] 0xc005f11c

I think I hadn't notice this '[unknown]' one bit before :-\ the [k] is
there, so having unknown is odd

>      4.48%  libc.so.6      [.] _nss_files_parse_servent
>      4.10%  gau            [.] engine_loop.constprop.0.isra.0
>      3.91%  libc.so.6      [.] memset
>      3.24%  libc.so.6      [.] strcspn
>      3.05%  libc.so.6      [.] __GI_____strtoul_l_internal
>      2.48%  libc.so.6      [.] memcpy
>      2.19%  libc.so.6      [.] memchr
>      2.00%  libc.so.6      [.] _wordcopy_fwd_dest_aligned
>      2.00%  [unknown]      [k] 0xc005f0f8
>      1.81%  libc.so.6      [.] _IO_getline_info
>      1.81%  libc.so.6      [.] strlen
>      1.72%  libc.so.6      [.] strcmp
>      1.62%  libc.so.6      [.] __ftello64
>      1.62%  libc.so.6      [.] internal_getent
>      1.53%  libc.so.6      [.] _IO_seekoff_unlocked
>      1.15%  libc.so.6      [.] __nss_readline
>      1.05%  libc.so.6      [.] _wordcopy_fwd_aligned
>      1.05%  [unknown]      [k] 0xc01f82c8
=20
> As a comparison, the following one works:
=20
> root@vgoippro:~# ./perf-good --version
> perf version 6.8.rc1.g39d14c0dd650
=20
> root@vgoippro:~# timeout 6s ./perf-good  top --stdio
=20
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
=20
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
=20
>    PerfTop:     451 irqs/sec  kernel:31.7%  exact:  0.0% lost: 0/0 drop:
> 7575/7575 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
=20
>      9.60%  perf-good      [.] io__get_char
>      6.40%  perf-good      [.] __symbols__insert
>      5.19%  gau            [.] engine_loop.constprop.0.isra.0
>      4.08%  [kernel]       [k] finish_task_switch.isra.0
>      3.64%  perf-good      [.] kallsyms__parse
>      3.20%  libc.so.6      [.] memset
>      2.98%  [kernel]       [k] kallsyms_expand_symbol.constprop.0
>      2.65%  libc.so.6      [.] memcpy
>      2.54%  [kernel]       [k] format_decode
>      2.43%  libc.so.6      [.] __libc_calloc
>      2.32%  libc.so.6      [.] _wordcopy_fwd_dest_aligned
>      2.32%  perf-good      [.] io__get_hex
>      1.99%  libc.so.6      [.] __GI_____strtoul_l_internal
>      1.88%  libc.so.6      [.] _int_malloc
>      1.88%  libc.so.6      [.] got_label
>      1.77%  libc.so.6      [.] _nss_files_parse_servent
>      1.66%  libc.so.6      [.] strcspn
>      1.66%  perf-good      [.] strlist__node_cmp
>      1.55%  [kernel]       [k] __copy_tofrom_user
>      1.55%  [kernel]       [k] string
>=20
>=20
> Here is the output with -vv of the one that fails:
>=20
> Using CPUID 0x80840011
> Problems creating module maps, continuing anyway...

This one: comes from here:

        if (symbol_conf.use_modules && machine__create_modules(machine) < 0=
) {
                if (machine__is_host(machine))
                        pr_debug("Problems creating module maps, "
                                 "continuing anyway...\n");
                else
                        pr_debug("Problems creating module maps for guest %=
d, "
                                 "continuing anyway...\n", machine->pid);
        }

static int machine__create_modules(struct machine *machine)
{               =20
        const char *modules;
        char path[PATH_MAX];
                  =20
        if (machine__is_default_guest(machine)) {
                modules =3D symbol_conf.default_guest_modules;
        } else {
                snprintf(path, PATH_MAX, "%s/proc/modules", machine->root_d=
ir);
                modules =3D path;
        }              =20
                       =20
        if (symbol__restricted_filename(modules, "/proc/modules"))
                return -1;

        if (modules__parse(modules, machine, machine__create_module))
                return -1;

        if (!machine__set_modules_path(machine))
                return 0;
               =20
        pr_debug("Problems setting modules path maps, continuing anyway...\=
n");

        return 0;
}


problems parsing /proc/modules?

symbol__restricted_filename() didn't change since 2012

modules__parse() also didn't have recent changes :-\

Maybe these messages are just red herrings...

I'm just ABENDing, to use a term a relative that is a brazilian bank
manager complaining about some internal systems mentioned as being
utterly irritating and that I found revealing about my age :-P

I'll try to continue tomorrow :-)

Off to bed!

- Arnaldo

> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       3
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> decreasing precise_ip by one (2)
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       2
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> decreasing precise_ip by one (1)
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       1
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> decreasing precise_ip by one (0)
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> Warning:
> The cycles event is not supported, trying to fall back to cpu-clock
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1 (software)
>   size                             136
>   config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       3
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 3
> mmap size 528384B
> 0x11b71568: mmap mask[0]:
> Missing PLT entry size for /lib/libc.so.6
> Missing PLT entry size for /usr/local/bin/gau
> Missing PLT entry size for /root/perf
> Missing PLT entry size for /lib/libelf-0.176.so
> =1B[H=1B[2J
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
> =1B[H=1B[2J
>    PerfTop:     259 irqs/sec  kernel:86.1%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
>     35.33%  [unknown]           0xc0891c14 ! [k] 0xc0891c14
> ---------- end
>     12.93%  [unknown]           0xc005f11c ! [k] 0xc005f11c
> Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
> Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
> Map: f900000-f909000 0 /lib/libcrypt.so.1
> Map: f920000-f921000 10000 /lib/libcrypt.so.1
> Map: f921000-f948000 0 /tmp/perf-863.map
> Map: f950000-fb4f000 0 /lib/libc.so.6
> Map: fb70000-fb74000 220000 /lib/libc.so.6
> Map: fb74000-fb7e000 0 /tmp/perf-863.map
> Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
> Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
> Map: fdf1000-fdf7000 0 /tmp/perf-863.map
> Map: fe00000-fe59000 0 /lib/libdw-0.176.so
> Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
> Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
> Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
> Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
> Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
> Map: ff10000-ffe0000 0 /lib/libm.so.6
> Map: fff0000-fff1000 d0000 /lib/libm.so.6
> Map: 10000000-10341000 0 /root/perf
> Map: 10360000-1036a000 360000 /root/perf
> Map: 1036a000-1036f000 0 /tmp/perf-863.map
> Map: b77f2000-b77f9000 0 [vdso]
> Map: b77fe000-b782e000 0 /lib/ld.so.1
> Map: b783e000-b7840000 40000 /lib/ld.so.1
> ---------- end
>      4.83%  /usr/local/bin/gau  0x7218c    d [.]
> engine_loop.constprop.0.isra.
>      4.63%  [unknown]           0xc005f0f8 ! [k] 0xc005f0f8
> Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
> Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
> Map: f900000-f909000 0 /lib/libcrypt.so.1
> Map: f920000-f921000 10000 /lib/libcrypt.so.1
> Map: f921000-f948000 0 /tmp/perf-863.map
> Map: f950000-fb4f000 0 /lib/libc.so.6
> Map: fb70000-fb74000 220000 /lib/libc.so.6
> Map: fb74000-fb7e000 0 /tmp/perf-863.map
> Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
> Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
> Map: fdf1000-fdf7000 0 /tmp/perf-863.map
> Map: fe00000-fe59000 0 /lib/libdw-0.176.so
> Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
> Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
> Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
> Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
> Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
> Map: ff10000-ffe0000 0 /lib/libm.so.6
> Map: fff0000-fff1000 d0000 /lib/libm.so.6
> Map: 10000000-10341000 0 /root/perf
> Map: 10360000-1036a000 360000 /root/perf
> Map: 1036a000-1036f000 0 /tmp/perf-863.map
> Map: b77f2000-b77f9000 0 [vdso]
> Map: b77fe000-b782e000 0 /lib/ld.so.1
> Map: b783e000-b7840000 40000 /lib/ld.so.1
> ---------- end
>      1.93%  [unknown]           0xc0067d90 ! [k] 0xc0067d90
> ---------- end
>      1.35%  [unknown]           0xc0011718 ! [k] 0xc0011718
> Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
> Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
> Map: f900000-f909000 0 /lib/libcrypt.so.1
> Map: f920000-f921000 10000 /lib/libcrypt.so.1
> Map: f921000-f948000 0 /tmp/perf-863.map
> Map: f950000-fb4f000 0 /lib/libc.so.6
> Map: fb70000-fb74000 220000 /lib/libc.so.6
> Map: fb74000-fb7e000 0 /tmp/perf-863.map
> Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
> Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
> Map: fdf1000-fdf7000 0 /tmp/perf-863.map
> Map: fe00000-fe59000 0 /lib/libdw-0.176.so
> Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
> Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
> Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
> Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
> Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
> Map: ff10000-ffe0000 0 /lib/libm.so.6
> Map: fff0000-fff1000 d0000 /lib/libm.so.6
> Map: 10000000-10341000 0 /root/perf
> Map: 10360000-1036a000 360000 /root/perf
> Map: 1036a000-1036f000 0 /tmp/perf-863.map
> Map: b77f2000-b77f9000 0 [vdso]
> Map: b77fe000-b782e000 0 /lib/ld.so.1
> Map: b783e000-b7840000 40000 /lib/ld.so.1
> ------Missing PLT entry size for /lib/nof/libstdc++.so.6.0.30
> ---- end
>      1.16%  [unknown]           0xc001a90c ! [k] 0xc001a90c
> Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
> Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
> Map: f900000-f909000 0 /lib/libcrypt.so.1
> Map: f920000-f921000 10000 /lib/libcrypt.so.1
> Map: f921000-f948000 0 /tmp/perf-863.map
> Map: f950000-fb4f000 0 /lib/libc.so.6
> Map: fb70000-fb74000 220000 /lib/libc.so.6
> Map: fb74000-fb7e000 0 /tmp/perf-863.map
> Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
> Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
> Map: fdf1000-fdf7000 0 /tmp/perf-863.map
> Map: fe00000-fe59000 0 /lib/libdw-0.176.so
> Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
> Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
> Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
> Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
> Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
> Map: ff10000-ffe0000 0 /lib/libm.so.6
> Map: fff0000-fff1000 d0000 /lib/libm.so.6
> Map: 10000000-10341000 0 /root/perf
> Map: 10360000-1036a000 360000 /root/perf
> Map: 1036a000-1036f000 0 /tmp/perf-863.map
> Map: b77f2000-b77f9000 0 [vdso]
> Map: b77fe000-b782e000 0 /lib/ld.so.1
> Map: b783e000-b7840000 40000 /lib/ld.so.1
> ---------- end
>      0.97%  [unknown]           0xc0067da0 ! [k] 0xc0067da0
> ---------- end
>      0.97%  [unknown]           0xc0891c18 ! [k] 0xc0891c18
> ---------- end
>      0.77%  [unknown]           0xc001a908 ! [k] 0xc001a908
> Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
> Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
> Map: f900000-f909000 0 /lib/libcrypt.so.1
> Map: f920000-f921000 10000 /lib/libcrypt.so.1
> Map: f921000-f948000 0 /tmp/perf-863.map
> Map: f950000-fb4f000 0 /lib/libc.so.6
> Map: fb70000-fb74000 220000 /lib/libc.so.6
> Map: fb74000-fb7e000 0 /tmp/perf-863.map
> Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
> Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
> Map: fdf1000-fdf7000 0 /tmp/perf-863.map
> Map: fe00000-fe59000 0 /lib/libdw-0.176.so
> Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
> Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
> Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
> Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
> Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
> Map: ff10000-ffe0000 0 /lib/libm.so.6
> Map: fff0000-fff1000 d0000 /lib/libm.so.6
> Map: 10000000-10341000 0 /root/perf
> Map: 10360000-1036a000 360000 /root/perf
> Map: 1036a000-1036f000 0 /tmp/perf-863.map
> Map: b77f2000-b77f9000 0 [vdso]
> Map: b77fe000-b782e000 0 /lib/ld.so.1
> Map: b783e000-b7840000 40000 /lib/ld.so.1
> ---------- end
>      0.77%  [unknown]           0xc0067d54 ! [k] 0xc0067d54
> ---------- end
>      0.77%  [unknown]           0xc0067d94 ! [k] 0xc0067d94
> ---------- end
>      0.77%  [unknown]           0xc0891c10 ! [k] 0xc0891c10
> ---------- end
>      0.58%  /lib/libc.so.6      0x94f3c    d [.]
> __GI___pthread_disable_asyncc
>      0.58%  /lib/libc.so.6      0xaed94    d [.] malloc
>      0.58%  /root/perf          0x143c00   d [.] ordered_events__queue
>      0.58%  [unknown]           0xc002d720 ! [k] 0xc002d720
> ---------- end
>      0.58%  [unknown]           0xc0067d4c ! [k] 0xc0067d4c
> ---------- end
>      0.58%  [unknown]           0xc0067da4 ! [k] 0xc0067da4
> ---------- end
>      0.58%  [unknown]           0xc00a781c ! [k] 0xc00a781c
>=20
>=20
> Here is the output of the one that works:
>=20
> Using CPUID 0x80840011
> Problems creating module maps, continuing anyway...
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       3
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> decreasing precise_ip by one (2)
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       2
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> decreasing precise_ip by one (1)
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       1
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> decreasing precise_ip by one (0)
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> Warning:
> The cycles event is not supported, trying to fall back to cpu-clock
> ------------------------------------------------------------
> perf_event_attr:
>   type                             1 (PERF_TYPE_SOFTWARE)
>   size                             136
>   config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   task                             1
>   precise_ip                       3
>   sample_id_all                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 3
> mmap size 528384B
> 0x11ed8e18: mmap mask[0]:
> Missing PLT entry size for /lib/libc.so.6
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: cannot get elf header.
> Using /proc/kallsyms for symbols
> Missing PLT entry size for /usr/local/bin/gau
> Missing PLT entry size for /root/perf-good
> Failed to open /tmp/perf-887.map, continuing without symbols
> =1B[H=1B[2J
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
> =1B[H=1B[2J
>    PerfTop:       1 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0
> [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
>    100.00%  /lib/libc.so.6  0x46e64    d [.] __libc_sigaction
> =1B[H=1B[2J
>    PerfTop:      99 irqs/sec  kernel:41.4%  exact:  0.0% lost: 0/0 drop:
> 7841/7841 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> -------------------------------------------------------------------------=
------
>=20
>     13.51%  /root/perf-good     0x1e83f4   d [.] io__get_char
>      8.01%  /root/perf-good     0xd6f7c    d [.] __symbols__insert
>      6.50%  /usr/local/bin/gau  0x72194    d [.]
> engine_loop.constprop.0.isra.
>      6.50%  [kernel.kallsyms]   0xc005f11c k [k] finish_task_switch.isra.0
>      5.00%  /root/perf-good     0x1e8a24   d [.] kallsyms__parse
>      5.00%  [kernel.kallsyms]   0xc0886ed0 k [k] number
>      3.50%  [kernel.kallsyms]   0xc00c3644 k [k]
> kallsyms_expand_symbol.constp
>      3.00%  /lib/libc.so.6      0xadc6c    d [.] _int_malloc
>      3.00%  [kernel.kallsyms]   0xc088557c k [k] format_decode
>      3.00%  [kernel.kallsyms]   0xc01f82c8 k [k] timerfd_read_iter
>      3.00%  [kernel.kallsyms]   0xc088b920 k [k] vsnprintf
>      2.50%  /lib/libc.so.6      0xb5d10    d [.] strcmp
>      2.50%  [kernel.kallsyms]   0xc0888bc4 k [k] string
>      2.00%  /root/perf-good     0xcc854    d [.] strlist__node_cmp
>      2.00%  /root/perf-good     0xd6c10    d [.] symbol__new
>      1.50%  /lib/libc.so.6      0xbcbb4    d [.] _wordcopy_fwd_aligned
>      1.50%  /lib/libc.so.6      0xb4ae4    d [.] memset
>      1.50%  /root/perf-good     0x1e8618   d [.] io__get_hex
>      1.50%  [kernel.kallsyms]   0xc001a860 k [k] __copy_tofrom_user
>      1.50%  [kernel.kallsyms]   0xc01f5248 k [k] do_epoll_wait
>=20
>=20
> Thanks for your help
> Christophe
