From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Fri, 11 Dec 2015 10:42:43 +0800
Message-ID: <566A3823.9080503@huawei.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain> <20151209134138.GB15864@kernel.org> <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net> <56697572.90701@huawei.com> <20151210151239.GB17996@kernel.org> <50399556C9727B4D88A595C8584AAB37526515F5@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:44626 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbbLKCnO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 21:43:14 -0500
In-Reply-To: <50399556C9727B4D88A595C8584AAB37526515F5@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@plumgrid.com>



On 2015/12/11 10:15, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / HIRAMATU=EF=
=BC=8CMASAMI wrote:
> From: 'Arnaldo Carvalho de Melo' [mailto:acme@kernel.org]
>> But this requires having these special refcnt__ routines, that will =
make
>> tools/perf/ code patterns for reference counts look different that t=
he
>> refcount patterns in the kernel :-\
> BTW, I think even without the refcnt debugger, we'd better introduce =
this
> kind API to unify the refcnt operation in perf code. As I said, we ha=
ve many
> miscodings on current implementation. Unifying the API can enforce de=
velopers
> to avoid such miscodings.
>
> Thank you,
>

I tried this problem in another way, I'd like to share it here.

=46irst: create two uprobes:

# ./perf probe --exec /home/wangnan/perf dso__new%return %ax
Added new event:
   probe_perf:dso__new  (on dso__new%return in /home/wangnan/perf with =
%ax)

You can now use it in all perf tools, such as:

     perf record -e probe_perf:dso__new -aR sleep 1

# ./perf probe --exec /home/wangnan/perf dso__delete dso
Added new event:
   probe_perf:dso__delete (on dso__delete in /home/wangnan/perf with ds=
o)

You can now use it in all perf tools, such as:

     perf record -e probe_perf:dso__delete -aR sleep 1


Then start test:

# ./perf record -g -e probe_perf:dso__new -e probe_perf:dso__delete=20
=2E/perf probe vfs_read
Added new event:
   probe:vfs_read       (on vfs_read)

You can now use it in all perf tools, such as:

     perf record -e probe:vfs_read -aR sleep 1

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.048 MB perf.data (178 samples) ]


 From the perf report result I know two dso objects are leak:

90 probe_perf:dso__new `
88 probe_perf:dso__delete


Then convert output to CTF:

$ ./perf data convert --to-ctf ./out.ctf


With a python script, try to find the exact leak objects (I'm not good=20
at python,
I believe we can do this with much shorter script):

$ cat refcnt.py
from babeltrace import TraceCollection

tc =3D TraceCollection();
tc.add_trace('./out.ctf', 'ctf')
objs =3D {}
for event in tc.events:
     if event.name.startswith('probe_perf:dso__new'):
         if event['arg1'] not in objs:
             objs[event['arg1']] =3D 1
     if event.name.startswith('probe_perf:dso__delete'):
         if event['dso'] in objs:
             objs[event['dso']] =3D 0

for x in objs:
     if objs[x] is 0:
         continue
     print("0x%x" % x)

$ python3 ./refcnt.py
0x34cb350
0x34d4640

Then from perf script's result, search for the two address:

perf 23203 [004] 665244.170387: probe_perf:dso__new: (4aaee0 <- 50a5eb)=
=20
arg1=3D0x34cb350
                   10a5eb dso__load_sym (/home/w00229757/perf)
                    af42d dso__load_vmlinux (/home/w00229757/perf)
                    af58c dso__load_vmlinux_path (/home/w00229757/perf)
                   10c40a open_debuginfo (/home/w00229757/perf)
                   111d39 convert_perf_probe_events (/home/w00229757/pe=
rf)
                    603a7 __cmd_probe.isra.3 (/home/w00229757/perf)
                    60a44 cmd_probe (/home/w00229757/perf)
                    7f6d1 run_builtin (/home/w00229757/perf)
                    33056 main (/home/w00229757/perf)
                    21bd5 __libc_start_main=20
(/tmp/oxygen_root-w00229757/lib64/libc-2.18.so)

perf 23203 [004] 665244.170679: probe_perf:dso__new: (4aaee0 <- 50a5eb)=
=20
arg1=3D0x34d4640
                   10a5eb dso__load_sym (/home/w00229757/perf)
                    af42d dso__load_vmlinux (/home/w00229757/perf)
                    af58c dso__load_vmlinux_path (/home/w00229757/perf)
                   10c40a open_debuginfo (/home/w00229757/perf)
                   111d39 convert_perf_probe_events (/home/w00229757/pe=
rf)
                    603a7 __cmd_probe.isra.3 (/home/w00229757/perf)
                    60a44 cmd_probe (/home/w00229757/perf)
                    7f6d1 run_builtin (/home/w00229757/perf)
                    33056 main (/home/w00229757/perf)
                    21bd5 __libc_start_main=20
(/tmp/oxygen_root-w00229757/lib64/libc-2.18.so)

Thank you.
