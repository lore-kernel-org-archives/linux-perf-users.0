From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/3] perf script: change process_event prototype
Date: Thu, 3 Mar 2011 18:07:56 +0100
Message-ID: <20110303170750.GB1807@nowhere>
References: <1299086960-26964-1-git-send-email-daahern@cisco.com>
 <1299086960-26964-2-git-send-email-daahern@cisco.com>
 <20110303024003.GC1946@nowhere>
 <4D6FA19A.3040604@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56114 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758221Ab1CCRII (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Mar 2011 12:08:08 -0500
Content-Disposition: inline
In-Reply-To: <4D6FA19A.3040604@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@ghostprotocols.net, mingo@elte.hu, peterz@infradead.org, paulus@samba.org, tglx@linutronix.de

On Thu, Mar 03, 2011 at 07:11:38AM -0700, David Ahern wrote:
> 
> 
> On 03/02/2011 07:40 PM, Frederic Weisbecker wrote:
> > Seems the thread is needed by any endpoints. It would be better to resolve
> > it from process_sample_event and pass it to the process_event() handler.
> 
> tracepoints yes; S/W samples no. If you want it I'll add it.

Hmm, yeah that looks more sensible, the majority of users seem to need it.

Thanks.
