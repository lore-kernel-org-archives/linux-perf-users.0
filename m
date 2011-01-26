From: David Ahern <daahern@cisco.com>
Subject: Re: [RFC] --dump-sym-trace
Date: Tue, 25 Jan 2011 19:29:47 -0700
Message-ID: <4D3F871B.3060906@cisco.com>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:52865 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab1AZC3t (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 25 Jan 2011 21:29:49 -0500
In-Reply-To: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: linux-perf-users@vger.kernel.org



On 01/25/11 18:47, Arun Sharma wrote:
> Some of my coworkers want to build tools to aggregate perf.data files
> from many different machines and provide web front ends and possibly
> other ways of visualizing the data (graphviz dot format comes to
> mind). One potential path is to use perf report -D (raw dump) and
> analyze that. But it made no sense to duplicate the functionality
> already in perf.
> 
> Attached is a preliminary patch that dumps the trace, but also
> symbolizes the addresses. It's probably not terribly efficient - but I
> wanted to post it anyway to figure out if this is a good starting
> point or there are other ways of getting perf to report call graphs
> that are easy to parse in another program.
> 
>  -Arun

From a brief glance seems similar to the timehist patch I proposed. See:
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html

The last URL shows an example of the output (abbreviated for email;
unwind the continuation lines for a better display).

That essentially dumps each sample point with the address-to-symbol
conversions done. The output of that is then fed to homegrown commands
to visualize/process the data.

David
