From: taeung <treeze.taeung@gmail.com>
Subject: Re: What do mean children of top ?
Date: Thu, 05 Mar 2015 10:20:06 +0900
Message-ID: <54F7AF46.80608@gmail.com>
References: <FC0BA225-3078-48F1-AC1D-67D6F84D6416@gmail.com> <20150303162348.GL5187@kernel.org> <20150303234629.GE27046@danjae>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35717 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbCEBUL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Mar 2015 20:20:11 -0500
Received: by pabli10 with SMTP id li10so38194370pab.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2015 17:20:10 -0800 (PST)
In-Reply-To: <20150303234629.GE27046@danjae>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org


On 03/04/2015 08:46 AM, Namhyung Kim wrote:
> Hi Arnaldo and Taewoong,
>
> On Tue, Mar 03, 2015 at 01:23:48PM -0300, Arnaldo Carvalho de Melo wr=
ote:
>> Em Tue, Mar 03, 2015 at 02:04:47AM +0900, TaeWoong Song escreveu:
>>> Hi, perf users
>>>
>>> About
>>> The function perf_top_config() on builtin-top.c:
>>> It depend on whether top.children is =E2=80=99true=E2=80=99 in perf=
config
>>> that whether =E2=80=98symbol_conf.cumulate_callchain=E2=80=99 is =E2=
=80=99true=E2=80=99 or not.
>>> (when =E2=80=98top' only work with =E2=80=98=E2=80=94call-graph' )
>>>
>>> The output of =E2=80=99top =E2=80=94call-graph fp=E2=80=99 is chang=
ed depending on  a boolean value of =E2=80=98symbol_conf.cumulate_callc=
hain=E2=80=99.
>>>
>>> Do mean children of top relationship of calling functions which are=
 parents or children ?
>>> Linked-ring of invoking functions ?
>>>
>>> I wanna exactly explain the effect of =E2=80=98top.children=E2=80=99=
 in perfconfig.
>>> Can anybody tell me the different between true and false on top.chi=
ldren ?
>>>
>>> If anybody a bit give hints me, I=E2=80=99ll appreciate it.
> The effect of top.children is same as report.children but just for pe=
rf top.
>
> The children here means that functions called from another function.
> Let me give you an example:
>
>    void foo(void) {
>      /* do something */
>    }
>
>    void bar(void) {
>      /* do something */
>      foo();
>    }
>
>    int main(void) {
>      bar()
>      return 0;
>    }
>
> In this case 'foo' is a child of 'bar', and 'bar' is an immediate
> child of 'main' so 'foo' also is a child of 'main'.  In other words,
> 'main' is a parent of 'foo' and 'bar'. and 'bar' is a parent of 'foo'=
=2E
> When you record with callchain you'll see something like this:
>
>   Overhead  Symbol
>   ........  .....................
>     60.00%  foo
>             |
>             --- foo
>                 bar
>                 main
>                 __libc_start_main
>
>     40.00%  bar
>             |
>             --- bar
>                 main
>                 __libc_start_main
>
> These percentage are 'self' overhead that came from the samples of th=
e
> function themselves.  If you use --children, the overhead of children
> will be add to all of parents to calculate 'children' overhead.  In
> this case we'll see somethink like below:
>
>   Children      Self  Symbol
>   ........  ........  ....................
>    100.00%     0.00%  __libc_start_main
>             |
>             --- __libc_start_main
>
>    100.00%     0.00%  main
>             |
>             --- main
>                 __libc_start_main
>
>    100.00%    40.00%  bar
>             |
>             --- bar
>                 main
>                 __libc_start_main
>
>     60.00%    60.00%  foo
>             |
>             --- foo
>                 bar
>                 main
>                 __libc_start_main
>
> The first percentage is the children overhead and second is the self
> overhead.  As you can see, the children overhead is a sum of the self
> overhead and all (self) overhead of children.  It gives you an higher
> level view which function (including children) consumes cpu cycles (o=
r
> other event) more.  And with '--call-graph caller', you'll see which
> children are called from this function.
>

Thank you very much.
I've clearly understanded about children in perf.

Thanks,
Taeung
