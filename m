From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 20 Mar 2015 18:34:29 -0300
Message-ID: <20150320213429.GR16485@kernel.org>
References: <20150319225858.GA16485@kernel.org>
 <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
 <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
 <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
 <20150320203922.GO16485@kernel.org>
 <20150320210709.GQ16485@kernel.org>
 <CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:42356 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbCTVee (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 20 Mar 2015 17:34:34 -0400
Content-Disposition: inline
In-Reply-To: <CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>

Em Fri, Mar 20, 2015 at 02:12:30PM -0700, Stephane Eranian escreveu:
> On Fri, Mar 20, 2015 at 2:07 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Em Fri, Mar 20, 2015 at 05:39:22PM -0300, Arnaldo Carvalho de Melo =
escreveu:
> >> Em Fri, Mar 20, 2015 at 10:15:53AM -0700, Stephane Eranian escreve=
u:
> >> > On Thu, Mar 19, 2015 at 5:39 PM, Arnaldo Carvalho de Melo <arnal=
do.melo@gmail.com> wrote:
> >> > > On Mar 19, 2015 9:34 PM, "Stephane Eranian" <eranian@google.co=
m> wrote:
> >> > >> On Thu, Mar 19, 2015 at 3:58 PM, Arnaldo Carvalho de Melo
> >> > >> <acme@kernel.org> wrote:
> >> > >> >         This patch, together with what is in my perf/core b=
ranch, should
> >> > >> > implement that feature we talked about recently, i.e. to al=
low
> >> > >> > annotating entries in callchains, please take a look at see=
 if you think
> >> > >> > it is ok,

> >> > >> I tried on tip.git and a simple example. It does what I wante=
d.
> >> > >> I will try on more complex test cases.
> >> > >> Thanks for implementing this quickly.

> >> > > Thanks for testing, please let us know if you have further sug=
gestions,

> >> > Ok, it does not work.
> >
> > Are you sure? I just tried, take a look at:
> >
> > http://vger.kernel.org/~acme/perf-report-annotate-callchain-entries=
-in-multiple-DSOs-in-the-same-hist_entry.png
> >
> > In there you will see that in the unmap_single_vma case there are
> > callchains that pass thru multiple DSOs in userspace (I used --call
> > dwarf in 'perf record') and those are marked as having
> > samples/annotation and when I go to those, pressing 'a' after movin=
g the
> > cursor to it and it works as expected...

> > Do you have some specific example I could try?

> I tried on an example I cannot share.
> But I am guessing you could reproduce with a test which calls a libc
> or libm function
> heavily form multiple callers in the main program.
> Example:
>        -  pow()
>            50% foo() [main.c]
>            50% bar() [main.c]
>=20
> If I move the cursor line to foo() and annotate foo() is shows me the
> code of pow().

+   49.83%  pow-me-harder  pow-me-harder     [.] main
+   27.16%  pow-me-harder  libm-2.17.so      [.] __ieee754_pow_sse2
-   17.76%  pow-me-harder  libm-2.17.so      [.] __pow
   -=E2=86=92__pow libm-2.17.so
      -=E2=86=9280.70% main pow-me-harder
           __libc_start_main libc-2.17.so
           _start pow-me-harder
        16.82% 0x4000000000000000 unknown
        2.44% 0x1 unknown
+    2.57%  pow-me-harder  pow-me-harder     [.] pow@plt
+    2.36%  pow-me-harder  libm-2.17.so      [.] @plt
+    0.04%  pow-me-harder  [kernel.vmlinux]  [k] intel_thermal_interrup=
t

And if I go to the line:

-=E2=86=9280.70% main pow-me-harder

And press 'a' I get:

main  /home/acme/pow-me-harder
 10.25 =E2=94=82 3e:   mov    -0x10(%rbp),%rax
  1.03 =E2=94=82       test   %rax,%rax
  4.39 =E2=94=82     =E2=86=93 js     53
  3.87 =E2=94=82       cvtsi2 %rax,%xmm3
  1.63 =E2=94=82       movsd  %xmm3,-0x38(%rbp)
       =E2=94=82     =E2=86=93 jmp    71
  0.03 =E2=94=82 53:   mov    %rax,%rdx
  0.91 =E2=94=82       shr    %rdx
  0.29 =E2=94=82       and    $0x1,%eax
  1.85 =E2=94=82       or     %rax,%rdx
  7.38 =E2=94=82       cvtsi2 %rdx,%xmm0
  0.55 =E2=94=82       movapd %xmm0,%xmm2
  6.54 =E2=94=82       addsd  %xmm0,%xmm2
  0.68 =E2=94=82       movsd  %xmm2,-0x38(%rbp)
  1.44 =E2=94=82 71:   cvtsi2 -0x4(%rbp),%xmm0
  2.82 =E2=94=82       movabs $0x4000000000000000,%rax
  0.62 =E2=94=82       mov    %rax,-0x40(%rbp)
  0.07 =E2=94=82       movsd  -0x40(%rbp),%xmm1
  4.30 =E2=94=82     =E2=86=92 callq  pow@plt
  1.53 =E2=94=82       addsd  -0x38(%rbp),%xmm0
  4.13 =E2=94=82       ucomis 0xfd(%rip),%xmm0        # 400818 <__dso_h=
andle+0x10>
  4.06 =E2=94=82     =E2=86=93 jae    a8
  1.49 =E2=94=82       cvttsd %xmm0,%rax
  1.49 =E2=94=82       mov    %rax,-0x10(%rbp)
  0.35 =E2=94=82     =E2=86=93 jmp    cb
       =E2=94=82 a8:   movsd  0xe8(%rip),%xmm1        # 400818 <__dso_h=
andle+0x10>
  0.14 =E2=94=82       subsd  %xmm1,%xmm0
  2.57 =E2=94=82       cvttsd %xmm0,%rax
  0.66 =E2=94=82       mov    %rax,-0x10(%rbp)
       =E2=94=82       movabs $0x8000000000000000,%rax
  7.84 =E2=94=82       xor    %rax,-0x10(%rbp)
 16.80 =E2=94=82 cb:   mov    -0x10(%rbp),%rax
  2.15 =E2=94=82       mov    %rax,-0x10(%rbp)
       =E2=94=82     int main(int argc, char *argv[])
       =E2=94=82     {
       =E2=94=82             int n =3D atoi(argv[1]), i;
       =E2=94=82             unsigned long long total =3D 0;=20

While if I go to the line:

   -=E2=86=92__pow libm-2.17.so

And press 'a', I get:

__pow  /usr/lib64/libm-2.17.so
       =E2=94=82     Disassembly of section .text:
       =E2=94=82
       =E2=94=82     0000000000026290 <pow>:
       =E2=94=82     __pow():
       =E2=94=82       movapd %xmm0,%xmm2
       =E2=94=82       sub    $0x18,%rsp
  1.70 =E2=94=82       movapd %xmm1,%xmm3
 12.86 =E2=94=82       movsd  %xmm2,(%rsp)
       =E2=94=82       movsd  %xmm3,0x8(%rsp)
  2.43 =E2=94=82     =E2=86=92 callq  *ABS*+0x1b110@plt
  0.49 =E2=94=82       movabs $0x7fffffffffffffff,%rcx
  0.28 =E2=94=82       movabs $0x7fefffffffffffff,%rdx
  1.01 =E2=94=82       movq   %xmm0,%rax
 12.58 =E2=94=82       and    %rcx,%rax
  2.18 =E2=94=82       movsd  (%rsp),%xmm2
  1.29 =E2=94=82       cmp    %rdx,%rax
 19.70 =E2=94=82       movsd  0x8(%rsp),%xmm3
  1.50 =E2=94=82     =E2=86=93 ja     57
  1.58 =E2=94=82       xorpd  %xmm1,%xmm1
 13.35 =E2=94=82       ucomis %xmm1,%xmm0
  0.89 =E2=94=82     =E2=86=93 jnp    a0
       =E2=94=82 52:   add    $0x18,%rsp
 16.83 =E2=94=82     =E2=86=90 retq
       =E2=94=82 57:   mov    _DYNAMIC+0x230,%rsi
       =E2=94=82       cmpl   $0xffffffff,(%rsi)
       =E2=94=82     =E2=86=91 je     52


Since I don't have glibc-debuginfo installed, I get just assembly.

[acme@ssdandy linux]$ readelf -sw /usr/lib64/libm-2.17.so | grep -w __p=
ow
  1737: 0000000000026290   429 FUNC    LOCAL  DEFAULT   13 __pow
[acme@ssdandy linux]$=20

Strange, are you pressing 'V' on the main 'perf record' view, i.e. befo=
re
getting to the annotation browser, to see the DSO just after the symbol=
?

Trying with a deeper callchain in pow-me-harder.c...

- Arnaldo
