From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 04 May 2016 16:50:14 -0700
Message-ID: <87inytpemh.fsf@tassilo.jf.intel.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	<87ega0whpq.fsf@tassilo.jf.intel.com>
	<CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
	<CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
	<20160420174724.GP9407@two.firstfloor.org>
	<CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
	<87mvo5pklu.fsf@tassilo.jf.intel.com>
	<CAF5HaEXM+Wko35QCtPqYq3KMai=BOA8kfRcLX60Mad=eYaHetQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19186 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbcEDXuU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 19:50:20 -0400
In-Reply-To: <CAF5HaEXM+Wko35QCtPqYq3KMai=BOA8kfRcLX60Mad=eYaHetQ@mail.gmail.com>
	(Daniel Gutson's message of "Wed, 4 May 2016 18:56:02 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Cc: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org, eranian@google.com

Daniel Gutson <daniel.gutson@tallertechnologies.com> writes:
>>
>> For non self monitoring there were perf patches at some point, but they
>> were rejected because it wasn't clear if a process should be able
>> to opt out of monitoring on its own.
>
> Any link?

Here's an older variant from Jiri https://lwn.net/Articles/568602/

I think there was another newer from Stephane to enable/disable perf
through an prctl, but I can't find it right now.

> (separately, of course): timing is of no help there.
> What I would like to know, is what happened (in terms of performance
> metrics) on each state. I would simply
> call perf_label("state name") on each transition.

Ok. It could be done using the uprobes. But would still need to write
the tools to filter by it.

-Andi
