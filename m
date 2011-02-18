From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 1/3] perf events: fix WARN_ON_ONCE for 64-bit raw data,
 SW events
Date: Fri, 18 Feb 2011 15:04:50 -0200
Message-ID: <20110218170450.GB302@ghostprotocols.net>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
 <1298008433-22911-2-git-send-email-daahern@cisco.com>
 <1298026821.5226.642.camel@laptop>
 <4D5E8338.8010602@cisco.com>
 <20110218145348.GA302@ghostprotocols.net>
 <1298041291.5226.776.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298041291.5226.776.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, paulus@samba.org
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Feb 18, 2011 at 04:01:31PM +0100, Peter Zijlstra escreveu:
> On Fri, 2011-02-18 at 12:53 -0200, Arnaldo Carvalho de Melo wrote:
> > > So size should be changed to u64 rather than modifying the
> > WARN_ON_ONCE?
> > 
> > Yeah, I guess so, 32-bit has to die it seems, gets in the way of
> > testing
> > :-) 
> 
> No!
> 
> 1) don't use RAW unless you have to
> 2) you don't have to, goto 1
> 3) if you do anyway, ensure its properly padded

Ok, but using that struct definition on 32-bit land, will lead to non 8 byte
alignment, right?

- Arnaldo
