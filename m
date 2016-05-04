From: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 4 May 2016 18:56:02 -0300
Message-ID: <CAF5HaEXM+Wko35QCtPqYq3KMai=BOA8kfRcLX60Mad=eYaHetQ@mail.gmail.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	<87ega0whpq.fsf@tassilo.jf.intel.com>
	<CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
	<CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
	<20160420174724.GP9407@two.firstfloor.org>
	<CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
	<87mvo5pklu.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32948 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbcEDV4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 17:56:04 -0400
Received: by mail-oi0-f49.google.com with SMTP id v145so82201477oie.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 May 2016 14:56:02 -0700 (PDT)
In-Reply-To: <87mvo5pklu.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org

On Wed, May 4, 2016 at 6:41 PM, Andi Kleen <andi@firstfloor.org> wrote:
> Daniel Gutson <daniel.gutson@tallertechnologies.com> writes:
>
>> I kept thinking about all this, and I changed my mind towards a
>> simpler (a first step) yet useful approach.
>> In the same way people spread some printfs for old school debugging,=
 I
>> keep the idea of some perf API made available
>> for the application (which calls depend on some flag, say -DNPERF
>> similar to -DNDEBUG, so if the macro is
>> not defined, calls have no effects).
>
>> The first relatively easy (again, but yet useful) feature that comes
>> to my mind, is the ability (from the app) to
>> label phases of the perf recording, including enabling, disabling, a=
nd
>> labelling.
>
> ftrace has a labelling feature like this (/sys/kernel/debug/tracing_m=
arker)
>
> But you can just do it on your own by defining some uprobes with
> perf probe for unique points and tracing them.
>
> The main challenge would be good user tooling support.
>
> For enabling/disabling:
> it works for processes that do self monitoring today.

What is self monitoring?

>
> For non self monitoring there were perf patches at some point, but th=
ey
> were rejected because it wasn't clear if a process should be able
> to opt out of monitoring on its own.

Any link?

>
> I suppose it may be ok with an explicit opt-in on the perf side.
>
> BTW I suspect the main motivation why you need this is because
> perf doesn't have a time line to select what time region to browse.
> The information is actually all in the perf.data, the UI is just
> not good. I sometimes now use vtune (which reads perf files)
> and has a time line to work around this.

But a untagged timeline is not extremely useful, moreover, please note
that in my proposal,
perf_label can append (if the file exists) the future data to the
existing data, so that would be a sort
of back to the past in time travelling parlance; what I want instead,
is the notion of logic states rather
than time points: suppose we are talking about a state machine (where
the machine bounces between
some states), and I want to record the metrics for each state
(separately, of course): timing is of no help there.
What I would like to know, is what happened (in terms of performance
metrics) on each state. I would simply
call perf_label("state name") on each transition.

>
> At some point it would be nice to add a time line to perf. Unfortunat=
ely
> I don't think it would work well with the terminal UI, so would
> need to be done in the gui mode.
>
> -Andi
>
> --
> ak@linux.intel.com -- Speaking for myself only



--=20

Daniel F. Gutson
Engineering Manager

San Lorenzo 47, 3rd Floor, Office 5
C=C3=B3rdoba, Argentina

Phone:   +54 351 4217888 / +54 351 4218211
Skype:    dgutson
LinkedIn: http://ar.linkedin.com/in/danielgutson
