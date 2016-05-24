From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Getting PEBS to work
Date: Tue, 24 May 2016 07:02:27 -0700
Message-ID: <8737p7sgek.fsf@tassilo.jf.intel.com>
References: <CAE40pdfx+LMiwXMZNaLVkT_XsaYFmQQqW5iOr63JnCfOhkFBmQ@mail.gmail.com>
	<CAPAnC4NObR7Fe-fZr9z5tdD0cyyVhd6WojN-aWst2Z2rtxQ6SQ@mail.gmail.com>
	<CAE40pdehnoK4yO-050=0cfbw8viegNmiXKUZYxw8nMXgi6TGzg@mail.gmail.com>
	<alpine.DEB.2.20.1605192045590.18235@macbook-air>
	<CAE40pddwJZOikG2kS9z7pwhPgvBsupKsskangpX2FZriQ3ERmQ@mail.gmail.com>
	<20160523140539.GF8897@kernel.org>
	<20160524101726.GS3193@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23087 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbcEXODw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 May 2016 10:03:52 -0400
In-Reply-To: <20160524101726.GS3193@twins.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Tue, 24 May 2016 12:17:26 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, Vince Weaver <vincent.weaver@maine.edu>, jim mauro <jim.mauro@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 23, 2016 at 11:05:39AM -0300, Arnaldo Carvalho de Melo wrote:
>> > # dmesg | egrep -i 'pmu|pmc|pebs'
>> > [    0.381095] Performance Events: PEBS fmt1+, 16-deep LBR,
>> > SandyBridge events, full-width counters, Intel PMU driver.
>> > [    0.381101] perf_event_intel: PEBS disabled due to CPU errata,
>> > please upgrade microcode
>> > [    0.395348] NMI watchdog: enabled on all CPUs, permanently consumes
>> > one hw-PMU counter.
>> > [    1.231836] nouveau  [     PMC][0000:01:00.0] MSI interrupts enabled
>> > 
>> > Gah, it was there all along!
>> 
>> Wish this was exported by the kernel somehow, then tooling could emit a
>> sensible message :-\
>
> You mean something like so?

Also the disable/microcode fix is really only needed for PEBS events
with cmask != 0, such as cycles:pp. Everything else in PEBS works fine
on Sandy Bridge. 

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
