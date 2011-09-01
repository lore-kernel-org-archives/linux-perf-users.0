From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Profiling Java code running on Sun HotSpot JVM with linux perf
Date: Thu, 1 Sep 2011 11:21:44 +0100
Message-ID: <CAJSP0QWGBQuV=p6ue4BQvFUSzTt0-BHnsVT01jaFeEn-XN3=PA@mail.gmail.com>
References: <CACiFetRWM4nmfAhB1J6dSSJdiQnCqov8XQYHqrSuxSiMrWoLFA@mail.gmail.com>
	<CAJSP0QUEcbuxE6n0pb3rydaUuna_nLi-gPZVT6TXGS5OXMAK9A@mail.gmail.com>
	<0E02F16954AF394BB163AEE50FDF54856909CA60E0@GVW1121EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50941 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1IAKVp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 1 Sep 2011 06:21:45 -0400
Received: by yie30 with SMTP id 30so1269819yie.19
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Sep 2011 03:21:44 -0700 (PDT)
In-Reply-To: <0E02F16954AF394BB163AEE50FDF54856909CA60E0@GVW1121EXC.americas.hpqcorp.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Cc: Geoffrey Blake <geoffrey.w.blake@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, Aug 31, 2011 at 10:00 AM, Maucci, Cyrille <cyrille.maucci@hp.com> wrote:
> Hey gents,
>
> I probably have a dumb question (if there are dumb questions...).
>
> I always thought that system level profiling tools/framework like perf-events or Oprofile or Caliper ... being used to profile java based applications were only good to show the high-level breakdown between CPU time exec'ed in java code and CPU time exec'ed in 'native' (JNI) code, i.e. something like
> 20% spent exec'ing JNI code vs. 80% spent in exec'ing pure java code.
>
> But if you want the breakdown of the 80% spent in java code, i.e. the perf java methods breakdown, etc.... You need to use a java profiler (Jrockit Mission Control, Jprofiler, etc...) and can't expect this information to be provided by perf-events / Oprofile / Caliper /etc...
>
> Comments ?

Tools like Oprofile and perf can collect program counter samples.  If
the JVM provides information on where native code blocks live in
memory, it is possible to map them back to the actual Java methods
that live there.  For each sample you look up the PC in the mapping
structure that the JVM has provided for the profiler.

Stefan
