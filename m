From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Link between Intel documentation events and perf list events
Date: Tue, 2 Jul 2013 16:49:04 +0200
Message-ID: <20130702144904.GY6123@two.firstfloor.org>
References: <51D1AA04.7060403@insa-lyon.fr>
 <8761wt62f8.fsf@tassilo.jf.intel.com>
 <51D286E0.2070500@insa-lyon.fr>
 <CAGz0_-3uWqVqPLwKvpiuveBJo1DT3B5TynK9ebdBZuw5ZGe3nQ@mail.gmail.com>
 <51D2D69E.9020207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:60704 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3GBOtF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Jul 2013 10:49:05 -0400
Content-Disposition: inline
In-Reply-To: <51D2D69E.9020207@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Andreas Hollmann <hollmann@in.tum.de>, Manuel Selva <manuel.selva@insa-lyon.fr>, Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Tue, Jul 02, 2013 at 03:33:18PM +0200, Manuel Selva wrote:
> Thanks again for the help.Your answer suggests that events listed as
> Hardware event by perf listare what is called Architecural Events
> for Intel processors, isn't it ?

perf uses a superset of the architectural events
(but only a small subset of a full Intel event list)

Also it supports setting the other events in raw form
(or various add-on tools exist to provide them as names)

> On my Sandy Bridge core i5-2520M, perf list reports 10 hardware
> events, where as they are only 7 entriesin the table 18-1 of Intel
> documentation you mentioned. So I am wondering what are these 3
> additional events;

Not all events supported by perf are in sysfs.

> 
> event=0x00,umask=0x03 (ref-cycles)
> event=0xb1,umask=0x01,inv,cmask=0x01 (stalled-cycles-backend)
> event=0x0e,umask=0x01,inv,cmask=0x01 (stalled-cycles-frontend)
> 
> Looking at table 19-7 in the same Intel document, I can see non
> architectural events for my core i5-2xxx. In this table I can see
> that:
> 
> ref-cycles                       ==> Can't find it

This is typically called CPU_CLK_UNHALTED.REF_TSC or so
in the Intel documentation.

> stalled-cycles-backend ==> Counts total number of uops to be
> dispatched per- thread each cycle. Set Cmask = 1, INV =1 to count
> stall cycles.
> stalled-cycles-frontend ==> Increments each cycle the # of Uops
> issued by the RAT to RS.Set Cmask = 1, Inv = 1, Any= 1to count
> stalled cycles of this core.

These two are very broken. Just ignore them.

-Andi
