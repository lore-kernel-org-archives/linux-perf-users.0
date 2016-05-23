From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Getting PEBS to work
Date: Mon, 23 May 2016 11:05:39 -0300
Message-ID: <20160523140539.GF8897@kernel.org>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
 <CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com>
 <CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com>
 <alpine.DEB.2.20.1605192045590.18235@macbook-air>
 <CAE40pddwJZOikG2kS9z7pwhPgvBsupKsskangpX2FZriQ3ERmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57833 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbcEWOFn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 May 2016 10:05:43 -0400
Content-Disposition: inline
In-Reply-To: <CAE40pddwJZOikG2kS9z7pwhPgvBsupKsskangpX2FZriQ3ERmQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, jim mauro <jim.mauro@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Thu, May 19, 2016 at 06:06:36PM -0700, Brendan Gregg escreveu:
> On Thu, May 19, 2016 at 5:47 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> > On Thu, 19 May 2016, Brendan Gregg wrote:
> >> On Thu, May 19, 2016 at 5:09 PM, jim mauro <jim.mauro@gmail.com> wrote:

> >> Nor did r01c0. But pretty interesting you got PEBS output, and on
> >> Linux 3.8. So maybe my 3.13 isn't the problem...

> > does your dmesg say anything?  If I recall there are sandybridge machines
> > with PEBS disabled due to errata.  Usually you need to update your
> > CPU firmware to get it working.
> 
> # dmesg | egrep -i 'pmu|pmc|pebs'
> [    0.381095] Performance Events: PEBS fmt1+, 16-deep LBR,
> SandyBridge events, full-width counters, Intel PMU driver.
> [    0.381101] perf_event_intel: PEBS disabled due to CPU errata,
> please upgrade microcode
> [    0.395348] NMI watchdog: enabled on all CPUs, permanently consumes
> one hw-PMU counter.
> [    1.231836] nouveau  [     PMC][0000:01:00.0] MSI interrupts enabled
> 
> Gah, it was there all along!

Wish this was exported by the kernel somehow, then tooling could emit a
sensible message :-\

- Arnaldo
 
> Thanks Vince. I hope future PEBS explorers find the commands in this
> thread useful!
> 
> Now I have to update some microcode...
