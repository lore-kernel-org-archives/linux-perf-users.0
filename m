From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 15:55:38 +0100
Message-ID: <1298040938.5226.771.camel@laptop>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
	 <1298008433-22911-2-git-send-email-daahern@cisco.com>
	 <1298026821.5226.642.camel@laptop>  <4D5E8338.8010602@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:52191 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab1BROyY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 09:54:24 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PqRix-00063i-Nv
	for linux-perf-users@vger.kernel.org; Fri, 18 Feb 2011 14:54:23 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PqRiw-0004yZ-Nj
	for linux-perf-users@vger.kernel.org; Fri, 18 Feb 2011 14:54:22 +0000
In-Reply-To: <4D5E8338.8010602@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, paulus@samba.org

On Fri, 2011-02-18 at 07:33 -0700, David Ahern wrote:
> 
> On 02/18/11 04:00, Peter Zijlstra wrote:
> > On Thu, 2011-02-17 at 22:53 -0700, David Ahern wrote:
> >> This check does not work out for 64-bit counter:
> >>
> >>     sizeof(u32) + sizeof(u64) = 4 + 8 = 12
> >>
> >> which does not pass the WARN_ON_ONCE test. I'm guessing (hoping
> >> really) that the intent is that the size of the raw data is a
> >> multiple of 4 bytes, not 8.
> > 
> > No the data must come in 8bytes strides.
> > 
> 
> Then the sizeof the size field needs to be moved to u64; right now it is
> u32:

That's a false conclusion.

> struct perf_raw_record {
>     u32             size;
>     void                *data;
> };

> So size should be changed to u64 rather than modifying the WARN_ON_ONCE?

No.

> Another gotcha is in perf_output_sample there is:
>             struct {
>                 u32 size;
>                 u32 data;
>             } raw = {
>                 .size = sizeof(u32),
>                 .data = 0,
>             };
> 
> While that meets the 8-byte stride I was concerned that changing the
> size field to u64 breaks ABI.

It would.

No, what you need to do is provide data that is sized such that it
matches the 8b stride adding padding where needed.

Anyway, I don't think you need RAW at all.
