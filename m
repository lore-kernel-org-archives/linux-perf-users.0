From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf event attrributes
Date: Tue, 02 Apr 2013 13:42:33 +0900
Message-ID: <87ehetfsqu.fsf@sejong.aot.lge.com>
References: <0C53B16FB1F182409A7BA6DC928E7AFE1FDA4F@039-SN2MPN1-022.039d.mgd.msft.net>
	<m2boa4ia23.fsf@firstfloor.org>
	<0C53B16FB1F182409A7BA6DC928E7AFE20C90D@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:58562 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab3DBEme (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Apr 2013 00:42:34 -0400
In-Reply-To: <0C53B16FB1F182409A7BA6DC928E7AFE20C90D@039-SN2MPN1-022.039d.mgd.msft.net>
	(Freehill Christopher-RAT's message of "Mon, 1 Apr 2013 16:09:50
	+0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Freehill Christopher-RAT063 <RAT063@freescale.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Chris,

On Mon, 1 Apr 2013 16:09:50 +0000, Freehill Christopher-RAT wrote:
> Andi,
>
> Thanks for the response.
>
> I am not familiar with "config/config1", but I infer from your message that I would make folders in sysfs for different event groups (?) and then have a file for each event that is a bit field that can be parsed. 
>
> As an alternative, is there anything to prevent encoding the attributes in the event ID itself? I think there are 64 bits to use. Some of those could be interpreted in a way specific to the event. I can see advantages and disadvantage to both. 
>
> Both ways seem a little convoluted from a user point of view. Seems
> like a more intuitive way would have been from the command line; ie,
> provide a way to pass info from the command line that could be
> interpreted in a way specific to the event. I'm sure that was probably
> considered, and there is a good reason that method wasn't chosen, but
> I do wonder...
>
> Can you point me to the Intel uncore drivers you mentioned?

You can see it under /sys/bus/event_source/devices/uncore_imc_*/ on a
recent kernel.  There'll be the "format" and "events" directories.

If you want to see the source, please go to:

  http://lxr.linux.no/#linux+v3.8.5/arch/x86/kernel/cpu/perf_event_intel_uncore.c


Thanks,
Namhyung
