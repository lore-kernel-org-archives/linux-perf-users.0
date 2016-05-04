From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 4 May 2016 19:19:07 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1605041918110.11510@macbook-air>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com> <87ega0whpq.fsf@tassilo.jf.intel.com> <CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com> <CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
 <20160420174724.GP9407@two.firstfloor.org> <CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com> <87mvo5pklu.fsf@tassilo.jf.intel.com> <CAF5HaEXM+Wko35QCtPqYq3KMai=BOA8kfRcLX60Mad=eYaHetQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36242 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbcEDXTN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 19:19:13 -0400
Received: by mail-ig0-f179.google.com with SMTP id u10so581282igr.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 May 2016 16:19:12 -0700 (PDT)
In-Reply-To: <CAF5HaEXM+Wko35QCtPqYq3KMai=BOA8kfRcLX60Mad=eYaHetQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Cc: Andi Kleen <andi@firstfloor.org>, Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org


On Wed, 4 May 2016, Daniel Gutson wrote:

> > For enabling/disabling:
> > it works for processes that do self monitoring today.
>
> What is self monitoring?

it's when a program turns on/off the performance events manually from
within the program itself.

There are libraries that abstract this out a bit, for example PAPI
        http://icl.cs.utk.edu/papi/


Vince
