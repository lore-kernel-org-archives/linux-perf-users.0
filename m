From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: measure uncore events
Date: Fri, 4 Oct 2013 09:25:21 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1310040918420.19931@vincent-weaver-1.um.maine.edu>
References: <CAJh9x3o3au3ouwn4TTPt+CGyh3bo_u0Qo5LiKshe3HmSY7er4w@mail.gmail.com> <87d2nltypp.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:57984 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab3JDNRu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Oct 2013 09:17:50 -0400
Received: by mail-qa0-f41.google.com with SMTP id ii20so991822qab.14
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Oct 2013 06:17:49 -0700 (PDT)
In-Reply-To: <87d2nltypp.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Yuanfang Chen <cyfmxc@gmail.com>, linux-perf-users@vger.kernel.org

On Thu, 3 Oct 2013, Andi Kleen wrote:

> Yuanfang Chen <cyfmxc@gmail.com> writes:
> 
> > I'm trying to measure uncore events. After reading [1], I tried "perf
> > stat -a -e "uncore_imc_0/event=0xff,umask=0x00/" /bin/ls", it says
> > "invalid or unsupported event".
> >
> > The machine is Intel Ivy Bridge i5-3320M with ArchLinux 3.11.2-1-ARCH.
> > 'perf --version'  is 'perf version 3.11.0'
> > In '/sys/bus/event_source/devices/uncore_cbox_0/events', there is only
> > one event 'clockticks'.
> 
> Uncore monitoring is only supported for IvyBridge Xeon E5+ / Core i7
> 49xx systems, not for your CPU.

are you sure about that?  Support for plain Ivybridge Model 58 uncore
(which I assume this machine has) was added in Linux 3.10.  

Or are there low-end mobile IvyBridge chips that lack uncore support?

Now for model58 IvyBridge the kernel doesn't seem to export predefined 
generic events, but you can do things like manually set up events
like
   UNC_CBO_CACHE_LOOKUP:STATE_I:ANY_FILTER
and they seem to work.

Vince
