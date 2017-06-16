From: Jan Kratochvil <jan.kratochvil@redhat.com>
Subject: Re: perf report: fix off-by-one for non-activation frames
Date: Fri, 16 Jun 2017 13:57:44 +0200
Message-ID: <20170616115744.GA14948@host1.jankratochvil.net>
References: <20170515150444.6841-1-milian.wolff@kdab.com>
 <20170616061456.GA2472@host1.jankratochvil.net>
 <5576772.scvU8aRrkq@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5576772.scvU8aRrkq@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 16 Jun 2017 13:51:37 +0200, Milian Wolff wrote:
> > perf-4.12.0-0.rc5.git0.1.fc27.x86_64
> >                   39e32e gdb_main (/usr/libexec/gdb)
> >                   10b6fa main (/usr/libexec/gdb)
> >    0x000055555565f6f6 <+54>:    callq  0x5555558f17a0 <gdb_main(captured_main_args*)
> >    0x000055555565f6fb <+59>:    mov    0x18(%rsp),%rcx
[...]
> Excuse me, but I'm having trouble following you. The non-GDB backtraces you 
> are pasting do not show srcline information. So what exactly is broken?

There is broken that perf now reports address 10b6fa (corresponding to
relocated address 0x000055555565f6fa) but there is no instruction on address
0x000055555565f6fa.  If you 'objdump -d' it you cannot find any instruction on
adress 0x000055555565f6fa (or on address 0x10b6fa).  There is instruction on
address 0x000055555565f6fb.


> Maybe paste the perf output you get now and highlight what you'd expect
> instead?

Actual:
                  39e32e gdb_main (/usr/libexec/gdb)
                  10b6fa main (/usr/libexec/gdb)
Expected:
                  39e32f gdb_main (/usr/libexec/gdb)
                  10b6fb main (/usr/libexec/gdb)

I agree perf needs to calculate with 39e32e and 10b6fa.  But it should display
to user 39e32f and 10b6fb.


Jan
