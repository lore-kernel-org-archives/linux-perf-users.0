From: Dennis <daodennis@gmail.com>
Subject: Re: JVM Profiling: Does hotspot emit frame pointer, and other Q's
Date: Sat, 10 Jan 2015 01:37:19 -0800
Message-ID: <CANqRL=Qeyc_HjO5s_+d2iT-1XSbak8zk121EaoY=8CLMZmqg2g@mail.gmail.com>
References: <CANqRL=RKvTEWc=t0ff_NOc6Ja8j3MLq5s-ZmsPtXZOfTMGB8Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:37992 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbAJJhU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 10 Jan 2015 04:37:20 -0500
Received: by mail-qc0-f179.google.com with SMTP id c9so12353454qcz.10
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2015 01:37:19 -0800 (PST)
In-Reply-To: <CANqRL=RKvTEWc=t0ff_NOc6Ja8j3MLq5s-ZmsPtXZOfTMGB8Qg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Apologies for tempting fate and not reading the archives :-).


"Perf support for interpreted and Just-In-Time translated languages"
http://thread.gmane.org/gmane.linux.kernel.perf.user/1817
and
"A hotspot patch for stack profiling (frame pointer)"
http://mail.openjdk.java.net/pipermail/hotspot-compiler-dev/2014-December/016546.html

Would it please the mailing list if I merge my questions into the
perf-users thread above or continue with this one?  Most of my
questions still stand though and I don't want to derail that thread.

Between either or both the light-weight-java profiler and perf I can
find a way to come as close to possible to always on / continuous
profiling of a JVM.


Regards,

Dennis O.

On Sat, Jan 10, 2015 at 1:03 AM, Dennis <daodennis@gmail.com> wrote:
> Hi,
>
> http://www.brendangregg.com/perf.html mentions the following** in
> regards to profiling JVMs.
>
> 1) Is this still an issue, if not when was it fixed?
> 2) Are there workarounds? (Other JVMs?)
> 3) Does it even matter? What is the status quo? Are symbols just not
> resolved or are parts of the stack omitted completely?
>
> 3 The lightweight-java-profiler seems to be able to resolve most
> symbols, but I don't understand why it can and perf cannot.
>
> ** Note that Java may not show full stacks to begin with, due to
> hotspot omitting the frame pointer (just like gcc). There is currently
> no option to disable this optimization (either in OpenJDK or Oracle
> JDK), meaning that profiling is basically broken. I've heard that the
> performance benefit for omitting the frame pointer in hotspot is
> negligible, meaning, we lose the incredibly useful ability to profile
> stack traces for no real gain. Hotspot, at least, need to provide us
> with an option to not omit the frame pointer.
>
> P.S. I love the perf tool!
>
>
> Regards,
>
> Dennis Ordanov
