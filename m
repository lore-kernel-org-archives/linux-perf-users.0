From: HOUSSEN Franck <fghoussen@gmail.com>
Subject: Re: Can not trace perf-probe event (made to probe the main function)
 with perf-top
Date: Mon, 21 Nov 2016 11:35:34 +0100
Message-ID: <CABvthioh4_zwA-9YC_ydUrmrxwM-9WVVBgE6YX4UF0ZZ9DPEhg@mail.gmail.com>
References: <CABvthiqxj=FCj-hg1Bhdnx=sTMZVt78nAM_N89HuuzfkBf7ZJw@mail.gmail.com>
 <20161120222617.39bc8304001c7690f82d52b4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35555 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbcKUKfg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Nov 2016 05:35:36 -0500
Received: by mail-wm0-f52.google.com with SMTP id a197so138465936wmd.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2016 02:35:35 -0800 (PST)
In-Reply-To: <20161120222617.39bc8304001c7690f82d52b4@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Oh dear !... You are right ! Thanks,

Franck

2016-11-20 14:26 GMT+01:00 Masami Hiramatsu <mhiramat@kernel.org>:
> Hello Franck,
>
> On Sat, 19 Nov 2016 17:36:39 +0100
> HOUSSEN Franck <fghoussen@gmail.com> wrote:
>
>> Can not trace perf-probe event (made to probe the main function) with
>> perf-top ? (see ReadMe.txt - works with perf-report and -s option)
>> Can someone help ? Missing option ? Known bug / limitation ?
>
> From ReadMe.txt;
> ----
> ~> sudo perf top -K --stdio -s sym,dso -e probe_main:main
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% [1Hz probe_main:=
main],  (all, 4 CPUs)
>    ----------------------------------------------------------------------=
---------------------
> ----
> Have you tried to run ./main program while running "perf top"?
>
> Since the main function is just called once when starting run
> the main program, without invoking it, the probe_main:main
> may never be occured.
>
> Thanks,
> --
> Masami Hiramatsu <mhiramat@kernel.org>



--=20
Bonne journ=C3=A9e,

Franck HOUSSEN
