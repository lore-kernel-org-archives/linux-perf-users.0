From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 04 May 2016 14:41:01 -0700
Message-ID: <87mvo5pklu.fsf@tassilo.jf.intel.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	<87ega0whpq.fsf@tassilo.jf.intel.com>
	<CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
	<CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
	<20160420174724.GP9407@two.firstfloor.org>
	<CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8946 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbcEDVlC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 17:41:02 -0400
In-Reply-To: <CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
	(Daniel Gutson's message of "Wed, 4 May 2016 14:20:37 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Cc: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org

Daniel Gutson <daniel.gutson@tallertechnologies.com> writes:

> I kept thinking about all this, and I changed my mind towards a
> simpler (a first step) yet useful approach.
> In the same way people spread some printfs for old school debugging, I
> keep the idea of some perf API made available
> for the application (which calls depend on some flag, say -DNPERF
> similar to -DNDEBUG, so if the macro is
> not defined, calls have no effects).

> The first relatively easy (again, but yet useful) feature that comes
> to my mind, is the ability (from the app) to
> label phases of the perf recording, including enabling, disabling, and
> labelling.

ftrace has a labelling feature like this (/sys/kernel/debug/tracing_marker)

But you can just do it on your own by defining some uprobes with
perf probe for unique points and tracing them.

The main challenge would be good user tooling support.

For enabling/disabling:
it works for processes that do self monitoring today.

For non self monitoring there were perf patches at some point, but they
were rejected because it wasn't clear if a process should be able
to opt out of monitoring on its own.

I suppose it may be ok with an explicit opt-in on the perf side.

BTW I suspect the main motivation why you need this is because
perf doesn't have a time line to select what time region to browse.
The information is actually all in the perf.data, the UI is just
not good. I sometimes now use vtune (which reads perf files)
and has a time line to work around this.

At some point it would be nice to add a time line to perf. Unfortunately
I don't think it would work well with the terminal UI, so would
need to be done in the gui mode.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
