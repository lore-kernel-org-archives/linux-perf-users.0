From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Profiling Java code running on Sun HotSpot JVM with linux perf
Date: Wed, 31 Aug 2011 08:35:44 +0100
Message-ID: <CAJSP0QUEcbuxE6n0pb3rydaUuna_nLi-gPZVT6TXGS5OXMAK9A@mail.gmail.com>
References: <CACiFetRWM4nmfAhB1J6dSSJdiQnCqov8XQYHqrSuxSiMrWoLFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35283 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab1HaHfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 31 Aug 2011 03:35:45 -0400
Received: by yie30 with SMTP id 30so373310yie.19
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2011 00:35:45 -0700 (PDT)
In-Reply-To: <CACiFetRWM4nmfAhB1J6dSSJdiQnCqov8XQYHqrSuxSiMrWoLFA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Geoffrey Blake <geoffrey.w.blake@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, Aug 30, 2011 at 9:03 PM, Geoffrey Blake
<geoffrey.w.blake@gmail.com> wrote:
> Hi all,
>
> I am trying to profile some java server applications using %>perf
> record -a, and as expected the majority of the execution time of thes=
e
> applications is spent within jit'ed java code.=A0 According to these
> lists, the jit should be outputting a /tmp/perf-$pid.map file for eac=
h
> thread being jit'ed.=A0 The Sun JIT does not seem to have this output
> enabled by default.=A0 Does anyone here know what options I need to s=
et
> on the command line to get the JVM to output the symbol map files fro=
m
> the JIT?

I don't know the answer but if you don't get one here you could check
the OProfile mailing list.  I believe there was a solution for JIT
compilers with OProfile and people probably got popular JVMs like
HotSpot working.  That might reveal what support HotSpot has for doing
this.

Stefan
