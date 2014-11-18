From: Jerome Correnoz <jerome.correnoz@st.com>
Subject: Re: Is it possible to get (or compute) the consummed CPU with perf ?
Date: Tue, 18 Nov 2014 17:31:47 +0000 (UTC)
Message-ID: <loom.20141118T183130-762@post.gmane.org>
References: <loom.20141111T083453-589@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51778 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbaKRRcB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Nov 2014 12:32:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XqmdC-0002ZR-9g
	for linux-perf-users@vger.kernel.org; Tue, 18 Nov 2014 18:31:58 +0100
Received: from 77.242.202.231 ([77.242.202.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2014 18:31:58 +0100
Received: from jerome.correnoz by 77.242.202.231 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2014 18:31:58 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Jerome Correnoz <jerome.correnoz <at> st.com> writes:

> 
> Hi,
> 
> We're interested to know the CPU load/usage on our ARMv7 embedded system 
> when running some use cases (e.g. simple video decode, double video 
> decode, etc.). By CPU load, I mean a way to measure the time when the 
> system was doing something else than Idle.
> 
> I've tried to get it from the performance counter statistics but 
couldn't 
> find a way to get it, do I miss something ?
> 
> Also tried to use perf for profiling the system (e.g. perf record -a). 
It 
> report very useful percentage for the running processes that we exploit 
to 
> detect hot spots. But It reports X% of the used CPU (nothing related to 
> Idle or "rest of CPU"). 
> 
> So, any way with perf to get this information (directly or indirectly 
with 
> few calculation) ?
> 
> Thanks by advance,
>   Jerome
> 
> 

Hi all,

Can someone please help on it ? 

If not, thanks to redirect me to the right list to ask such question.

Regards,
  Jerome
