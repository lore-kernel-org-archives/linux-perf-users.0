From: zhao bao <baozhao@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Tue, 29 Mar 2011 23:48:34 +0800
Message-ID: <AANLkTinvS527WGa7+tYo7pqgZj1dSviY0HrLo=2XGqT-@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
	<4D8DE695.3000606@gmail.com>
	<AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
	<4D8DF6E4.1070804@gmail.com>
	<AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
	<4D8EB605.7070407@gmail.com>
	<AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
	<4D8FA787.7020308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33247 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1C2Psg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2011 11:48:36 -0400
Received: by gyd10 with SMTP id 10so126125gyd.19
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2011 08:48:35 -0700 (PDT)
In-Reply-To: <4D8FA787.7020308@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

2011/3/28 David Ahern <dsahern@gmail.com>:
>
>
> On 03/27/11 01:44, zhao bao wrote:
>> The address I want is the value stored =C2=A0in X86 CR2 register whe=
n page
>> fault =C2=A0occurs, Does perf provide these =C2=A0information?
>
> Add the -d option to perf-record, and try the following change on
> perf-script:
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.=
c
> index ac574ea..85376b7 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -32,6 +32,7 @@ enum perf_output_field {
> =C2=A0 =C2=A0PERF_OUTPUT_EVNAME =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 1U << 5,
> =C2=A0 =C2=A0PERF_OUTPUT_TRACE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 1U << 6,
> =C2=A0 =C2=A0PERF_OUTPUT_SYM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D 1U << 7,
> + =C2=A0 PERF_OUTPUT_ADDR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 1U << 8,
> =C2=A0};
>
> =C2=A0struct output_option {
> @@ -46,6 +47,7 @@ struct output_option {
> =C2=A0 =C2=A0{.str =3D "event", .field =3D PERF_OUTPUT_EVNAME},
> =C2=A0 =C2=A0{.str =3D "trace", .field =3D PERF_OUTPUT_TRACE},
> =C2=A0 =C2=A0{.str =3D "sym", =C2=A0 .field =3D PERF_OUTPUT_SYM},
> + =C2=A0 {.str =3D "addr", =C2=A0 .field =3D PERF_OUTPUT_ADDR},
> =C2=A0};
>
> =C2=A0/* default set to maintain compatibility with current format */
> @@ -158,6 +160,8 @@ static void print_sample_start(struct perf_sample
> *sample,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("%s: ", evname ? evname : "(unknown=
)");
> =C2=A0 =C2=A0}
> + =C2=A0 if (PRINT_FIELD(ADDR))
> + =C2=A0 =C2=A0 =C2=A0 printf("0x%" PRIx64, sample->addr);
> =C2=A0}
>
> =C2=A0static void process_event(union perf_event *event __unused,
> @@ -829,7 +833,7 @@ static const struct option options[] =3D {
> =C2=A0 =C2=A0OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Look for files with symbols=
 relative to this directory"),
> =C2=A0 =C2=A0OPT_CALLBACK('f', "fields", NULL, "str",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"comma separated output fi=
elds prepend with 'type:'. Valid
> types: hw,sw,trace. Fields: comm,tid,pid,time,cpu,event,trace,sym",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"comma separated output fi=
elds prepend with 'type:'. Valid
> types: hw,sw,trace. Fields: comm,tid,pid,time,cpu,event,trace,sym,add=
r",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_output_fields),
>
> =C2=A0 =C2=A0OPT_END()
>
>
>>
I applyed this patch in the builtin-script.c , recompile and install
it. But I found it still doesn't  show any CR2 address info. The patch
seems to list a addr column, but perf script still work as before.

I tried two ways.
(1) In fedora 14,  new "/root/bin/perf record -d" cannot work because
of  "-d" option, so I use old perf record (perf version
2.6.35.6-45.fc14.i686), then use new "perf script" , result is still
the same as before.

[root@localhost lab]# perf --version
perf version 2.6.35.6-45.fc14.i686

[root@localhost lab]# /root/bin/perf --version
perf version 2.6.38.2972.gf88210.dirty

[root@localhost lab]# /root/bin/perf record  -c 1 -e faults  -R -d  ./h=
ello

  Error: sys_perf_event_open() syscall returned with 22 (Invalid
argument).  /bin/dmesg may provide additional information.

  Fatal: No CONFIG_PERF_EVENTS=3Dy kernel support configured?

[root@localhost lab]# perf record  -c 1 -e faults  -R -d  ./hello
hello,world
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.010 MB perf.data (~415 samples) ]

[root@localhost lab]# /root/bin/perf script
           hello  2924 [000]  1422.290866: page-faults:
c05b6d35 clear_user ([kernel.kallsyms])
           hello  2924 [000]  1422.290894: page-faults:
c05b6d35 clear_user ([kernel.kallsyms])
           hello  2924 [000]  1422.290910: page-faults:
c05b68a0 __copy_to_user_ll ([kernel.kallsyms])
           hello  2924 [000]  1422.290946: page-faults:
870 _start (/lib/ld-2.13.so)

(2) I compiled the 2.6.38.rc6 kernel(I downloaded a month ago) ,
reboot machien. Now new "/root/bin/perf record -d" can work, but  new
"perf script" shows no change.

[root@localhost lab]#  /root/bin/perf record  -c 1 -e faults  -R -d  ./=
hello
hello,world
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.013 MB perf.data (~557 samples) ]
[root@localhost lab]#  /root/bin/perf script
           hello  2229 [000]  1339.388865: page-faults:
c05ccbb3 clear_user ([kernel.kallsyms])
           hello  2229 [000]  1339.388898: page-faults:
c05ccbb3 clear_user ([kernel.kallsyms])
           hello  2229 [000]  1339.388915: page-faults:
c05cc70c __copy_to_user_ll ([kernel.kallsyms])
           hello  2229 [000]  1339.388945: page-faults:
870 _start (/lib/ld-2.13.so)
           hello  2229 [000]  1339.388950: page-faults:
4920 _dl_start (/lib/ld-2.13.so)
           hello  2229 [000]  1339.388954: page-faults:
17acb __i686.get_pc_thunk.bx (/lib/ld-2.13.so)
