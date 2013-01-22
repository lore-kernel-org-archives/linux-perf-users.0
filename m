From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf not measuring LLC events?
Date: Tue, 22 Jan 2013 16:06:00 +0100
Message-ID: <20130122150559.GH1037@krava.brq.redhat.com>
References: <loom.20121215T192044-606@post.gmane.org>
 <loom.20130118T172647-728@post.gmane.org>
 <20130121143816.GE1995@krava.brq.redhat.com>
 <CAO+S5Jkah32o+C7_ZXPjut0=LUkzpFhX1r_=T1iS0LXwf2zHLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867Ab3AVPGD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Jan 2013 10:06:03 -0500
Content-Disposition: inline
In-Reply-To: <CAO+S5Jkah32o+C7_ZXPjut0=LUkzpFhX1r_=T1iS0LXwf2zHLQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jeff <krackajak@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Mon, Jan 21, 2013 at 08:10:03AM -0800, Jeff wrote:
> Specs:
> i5 Sandy Bridge 2400
> Model 42
> Stepping 7
> 
> Ubuntu 12.10 64 bit.
> Dell Optiplex 790
> 
> 
> On Mon, Jan 21, 2013 at 6:38 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Fri, Jan 18, 2013 at 04:28:51PM +0000, Jeff Johnson wrote:
> >> Dervin Thunk <dervin.thunk <at> gmail.com> writes:
> >>
> >> >
> >> > Dear all,
> >> >
> >> > I'm trying to measure the LLC events of a program. I'm running
> >> > linux-tools-3.2.0- 34 on a fairly recent 4 core Intel machine. For a
> >> > certain program that reads a 64 MB file into memory, I get
> >> >
> >> >  Performance counter stats for './algo data/E.dna':
> >> >
> >> >                  0 LLC-loads
> >> >                  0 LLC-load-misses
> >>
> >>
> >> Dervin,
> >> I am experiencing the same issue. I am running perf on an i5 machine. Have you
> >> gotten any feedback regarding this?
> >
> > I'm getting some 'sane' numbers on 2 cores i7 SandyBridge on 3.6.11-1.fc17.x86_64
> >
> > not sure if this was broken back in 3.2.0
> >
> > please be more specific on what system you're testing on
> > and provide whole perf stat command line
> >
> > jirka
> 
> Specs:
> i5 Sandy Bridge 2400
> Model 42
> Stepping 7
> 
> Ubuntu 12.10 64 bit.
> Dell Optiplex 790
> 
> Perf command: perf stat -e LLC-loads -r 3 <my binary under test>

I found Ubuntu 12.10 is like 3.5 kernel, right?

There are some perf tool cache event fixies after 3.5,
but non of the tags I tried showed the error.

Any chance you could try with latest upstream - kernel/perf?

jirka
