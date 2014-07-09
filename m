From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Interrupt caused by software events
Date: Wed, 9 Jul 2014 10:05:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1407091002490.26636@vincent-weaver-1.umelst.maine.edu>
References: <20140708144242.GA300@gamayun>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:47579 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaGIOAz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Jul 2014 10:00:55 -0400
Received: by mail-qg0-f54.google.com with SMTP id q107so6521857qgd.13
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2014 07:00:54 -0700 (PDT)
In-Reply-To: <20140708144242.GA300@gamayun>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, 8 Jul 2014, Martin Ichilevici de Oliveira wrote:

> I'm looking for a way to determine which instruction caused some events:
> something similar to what perf annotate does, but in an online fashion. 
> Ideally, I'd like to have some kind of handler that gets called whenever
> a perf event occurs. Is that even possible? If not, is there any way I 
> could get this information in a real-time way?

Not really sure by what you mean by "real-time", but you can theoretically 
set up the perf_event mmap buffer with a low threshold, and have it 
configured to send a signal to your program whenever an event comes in.
In theory you can get the PEBS-like info out that way.  It's going to have 
fairly high overhead though, especially if you set the sample rate high.

It's even worse if you are trying to get full info on *every* event.
That's probably not possible with any even that happens more than a few 
times a second.

Vince
