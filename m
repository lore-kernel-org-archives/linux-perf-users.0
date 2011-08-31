From: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Subject: RE: Profiling Java code running on Sun HotSpot JVM with linux perf
Date: Wed, 31 Aug 2011 10:00:06 +0100
Message-ID: <0E02F16954AF394BB163AEE50FDF54856909CA60E0@GVW1121EXC.americas.hpqcorp.net>
References: <CACiFetRWM4nmfAhB1J6dSSJdiQnCqov8XQYHqrSuxSiMrWoLFA@mail.gmail.com>
 <CAJSP0QUEcbuxE6n0pb3rydaUuna_nLi-gPZVT6TXGS5OXMAK9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:32854 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab1HaI5x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 31 Aug 2011 04:57:53 -0400
In-Reply-To: <CAJSP0QUEcbuxE6n0pb3rydaUuna_nLi-gPZVT6TXGS5OXMAK9A@mail.gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>, Geoffrey Blake <geoffrey.w.blake@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hey gents,

I probably have a dumb question (if there are dumb questions...).

I always thought that system level profiling tools/framework like perf-=
events or Oprofile or Caliper ... being used to profile java based appl=
ications were only good to show the high-level breakdown between CPU ti=
me exec'ed in java code and CPU time exec'ed in 'native' (JNI) code, i.=
e. something like=20
20% spent exec'ing JNI code vs. 80% spent in exec'ing pure java code.

But if you want the breakdown of the 80% spent in java code, i.e. the p=
erf java methods breakdown, etc.... You need to use a java profiler (Jr=
ockit Mission Control, Jprofiler, etc...) and can't expect this informa=
tion to be provided by perf-events / Oprofile / Caliper /etc...

Comments ?

++Cyrille

-----Original Message-----
=46rom: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users=
-owner@vger.kernel.org] On Behalf Of Stefan Hajnoczi
Sent: Wednesday, August 31, 2011 9:36 AM
To: Geoffrey Blake
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Profiling Java code running on Sun HotSpot JVM with linux =
perf

On Tue, Aug 30, 2011 at 9:03 PM, Geoffrey Blake <geoffrey.w.blake@gmail=
=2Ecom> wrote:
> Hi all,
>
> I am trying to profile some java server applications using %>perf=20
> record -a, and as expected the majority of the execution time of thes=
e=20
> applications is spent within jit'ed java code.=A0 According to these=20
> lists, the jit should be outputting a /tmp/perf-$pid.map file for eac=
h=20
> thread being jit'ed.=A0 The Sun JIT does not seem to have this output=
=20
> enabled by default.=A0 Does anyone here know what options I need to s=
et=20
> on the command line to get the JVM to output the symbol map files fro=
m=20
> the JIT?

I don't know the answer but if you don't get one here you could check t=
he OProfile mailing list.  I believe there was a solution for JIT compi=
lers with OProfile and people probably got popular JVMs like HotSpot wo=
rking.  That might reveal what support HotSpot has for doing this.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-us=
ers" in the body of a message to majordomo@vger.kernel.org More majordo=
mo info at  http://vger.kernel.org/majordomo-info.html
