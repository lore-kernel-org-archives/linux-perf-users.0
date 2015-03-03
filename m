From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: What do mean children of top ?
Date: Wed, 4 Mar 2015 08:46:29 +0900
Message-ID: <20150303234629.GE27046@danjae>
References: <FC0BA225-3078-48F1-AC1D-67D6F84D6416@gmail.com>
 <20150303162348.GL5187@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41943 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbbCCXrJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Mar 2015 18:47:09 -0500
Received: by pablj1 with SMTP id lj1so22066062pab.8
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2015 15:47:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150303162348.GL5187@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: TaeWoong Song <treeze.taeung@gmail.com>, linux-perf-users@vger.kernel.org

Hi Arnaldo and Taewoong,

On Tue, Mar 03, 2015 at 01:23:48PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> Em Tue, Mar 03, 2015 at 02:04:47AM +0900, TaeWoong Song escreveu:
> > Hi, perf users
> >=20
> > About=20
> > The function perf_top_config() on builtin-top.c:
> > It depend on whether top.children is =E2=80=99true=E2=80=99 in perf=
config=20
> > that whether =E2=80=98symbol_conf.cumulate_callchain=E2=80=99 is =E2=
=80=99true=E2=80=99 or not.
> > (when =E2=80=98top' only work with =E2=80=98=E2=80=94call-graph' )
> >=20
> > The output of =E2=80=99top =E2=80=94call-graph fp=E2=80=99 is chang=
ed depending on  a boolean value of =E2=80=98symbol_conf.cumulate_callc=
hain=E2=80=99.
> >=20
> > Do mean children of top relationship of calling functions which are=
 parents or children ?=20
> > Linked-ring of invoking functions ? =20
> >=20
> > I wanna exactly explain the effect of =E2=80=98top.children=E2=80=99=
 in perfconfig.
> > Can anybody tell me the different between true and false on top.chi=
ldren ?
> >=20
> > If anybody a bit give hints me, I=E2=80=99ll appreciate it.=20

The effect of top.children is same as report.children but just for perf=
 top.

The children here means that functions called from another function.
Let me give you an example:

  void foo(void) {
    /* do something */
  }

  void bar(void) {
    /* do something */
    foo();
  }

  int main(void) {
    bar()
    return 0;
  }

In this case 'foo' is a child of 'bar', and 'bar' is an immediate
child of 'main' so 'foo' also is a child of 'main'.  In other words,
'main' is a parent of 'foo' and 'bar'. and 'bar' is a parent of 'foo'.
When you record with callchain you'll see something like this:

 Overhead  Symbol
 ........  .....................
   60.00%  foo
           |
           --- foo
               bar
               main
               __libc_start_main

   40.00%  bar
           |
           --- bar
               main
               __libc_start_main

These percentage are 'self' overhead that came from the samples of the
function themselves.  If you use --children, the overhead of children
will be add to all of parents to calculate 'children' overhead.  In
this case we'll see somethink like below:

 Children      Self  Symbol
 ........  ........  ....................
  100.00%     0.00%  __libc_start_main
           |
           --- __libc_start_main

  100.00%     0.00%  main
           |
           --- main
               __libc_start_main

  100.00%    40.00%  bar
           |
           --- bar
               main
               __libc_start_main

   60.00%    60.00%  foo
           |
           --- foo
               bar
               main
               __libc_start_main

The first percentage is the children overhead and second is the self
overhead.  As you can see, the children overhead is a sum of the self
overhead and all (self) overhead of children.  It gives you an higher
level view which function (including children) consumes cpu cycles (or
other event) more.  And with '--call-graph caller', you'll see which
children are called from this function.

Thanks,
Namhyung
