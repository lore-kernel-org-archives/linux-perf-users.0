From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 12:53:48 -0200
Message-ID: <20110218145348.GA302@ghostprotocols.net>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
 <1298008433-22911-2-git-send-email-daahern@cisco.com>
 <1298026821.5226.642.camel@laptop>
 <4D5E8338.8010602@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59698 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab1BROx4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 09:53:56 -0500
Content-Disposition: inline
In-Reply-To: <4D5E8338.8010602@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, paulus@samba.org

Em Fri, Feb 18, 2011 at 07:33:28AM -0700, David Ahern escreveu:
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
> 
> struct perf_raw_record {
>     u32             size;
>     void                *data;
> };
> 
> So size should be changed to u64 rather than modifying the WARN_ON_ONCE?

Yeah, I guess so, 32-bit has to die it seems, gets in the way of testing
:-)

- Arnaldo
