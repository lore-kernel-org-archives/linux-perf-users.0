From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: RE: perf event attrributes
Date: Mon, 1 Apr 2013 16:09:50 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE20C90D@039-SN2MPN1-022.039d.mgd.msft.net>
References: <0C53B16FB1F182409A7BA6DC928E7AFE1FDA4F@039-SN2MPN1-022.039d.mgd.msft.net>
 <m2boa4ia23.fsf@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:56480
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758978Ab3DAQJy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Apr 2013 12:09:54 -0400
In-Reply-To: <m2boa4ia23.fsf@firstfloor.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Andi,

Thanks for the response.

I am not familiar with "config/config1", but I infer from your message that I would make folders in sysfs for different event groups (?) and then have a file for each event that is a bit field that can be parsed. 

As an alternative, is there anything to prevent encoding the attributes in the event ID itself? I think there are 64 bits to use. Some of those could be interpreted in a way specific to the event. I can see advantages and disadvantage to both. 

Both ways seem a little convoluted from a user point of view. Seems like a more intuitive way would have been from the command line; ie, provide a way to pass info from the command line that could be interpreted in a way specific to the event. I'm sure that was probably considered, and there is a good reason that method wasn't chosen, but I do wonder...

Can you point me to the Intel uncore drivers you mentioned?

Thanks again,
Chris

-----Original Message-----
From: Andi Kleen [mailto:andi@firstfloor.org] 
Sent: Wednesday, March 27, 2013 8:32 PM
To: Freehill Christopher-RAT063
Cc: linux-perf-users
Subject: Re: perf event attrributes

Freehill Christopher-RAT063 <RAT063@freescale.com> writes:
>
> Any info or suggestions are appreciated.

The perf model for this is to use bit fields in config/config1 and then declare those in sysfs, so that they can be set as cpu/foo=1,bar=2/ The kernel driver then extracts those fields.

This only supports numerical values, not string enumerations.

You can see the Intel uncore drivers as a example doing this extensively.

-Andi

--
ak@linux.intel.com -- Speaking for myself only
