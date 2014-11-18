From: Milian Wolff <mail@milianw.de>
Subject: Re: Is it possible to get (or compute) the consummed CPU with perf ?
Date: Tue, 18 Nov 2014 18:51:34 +0100
Message-ID: <1843797.nOROaMLjlR@milian-kdab2>
References: <loom.20141111T083453-589@post.gmane.org> <loom.20141118T183130-762@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:50244 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbaKRRvh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Nov 2014 12:51:37 -0500
In-Reply-To: <loom.20141118T183130-762@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jerome Correnoz <jerome.correnoz@st.com>
Cc: linux-perf-users@vger.kernel.org

On Tuesday 18 November 2014 17:31:47 Jerome Correnoz wrote:
> Jerome Correnoz <jerome.correnoz <at> st.com> writes:
> > Hi,
> > 
> > We're interested to know the CPU load/usage on our ARMv7 embedded system
> > when running some use cases (e.g. simple video decode, double video
> > decode, etc.). By CPU load, I mean a way to measure the time when the
> > system was doing something else than Idle.
> > 
> > I've tried to get it from the performance counter statistics but
> 
> couldn't
> 
> > find a way to get it, do I miss something ?
> > 
> > Also tried to use perf for profiling the system (e.g. perf record -a).
> 
> It
> 
> > report very useful percentage for the running processes that we exploit
> 
> to
> 
> > detect hot spots. But It reports X% of the used CPU (nothing related to
> > Idle or "rest of CPU").
> > 
> > So, any way with perf to get this information (directly or indirectly
> 
> with
> 
> > few calculation) ?
> > 
> > Thanks by advance,
> > 
> >   Jerome
> 
> Hi all,
> 
> Can someone please help on it ?

Sadly I cannot help you, but just want to say that I'd also be interested in 
this data. VTune e.g. shows these fancy per-thread CPU Time graphs which are 
shown at the bottom of this image:

https://software.intel.com/sites/default/files/managed/ef/8d/VTune-overview-fig-01.png

If there'd be a way to get similar results from Linux perf, I bet it would be 
very useful.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
