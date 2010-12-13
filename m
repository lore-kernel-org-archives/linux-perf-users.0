From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 14:48:54 -0200
Message-ID: <20101213164854.GL5407@ghostprotocols.net>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com>
 <1291773285-16254-2-git-send-email-daahern@cisco.com>
 <20101212201613.GA1784@nowhere>
 <4D06301C.2090309@cisco.com>
 <20101213155451.GA1691@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:64354 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab0LMQtA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 11:49:00 -0500
Content-Disposition: inline
In-Reply-To: <20101213155451.GA1691@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: "David S. Ahern" <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Mon, Dec 13, 2010 at 04:54:56PM +0100, Frederic Weisbecker escreveu:
> On Mon, Dec 13, 2010 at 07:39:24AM -0700, David S. Ahern wrote:
> > On 12/12/10 13:16, Frederic Weisbecker wrote:
> > >>  int perf_session__create_kernel_maps(struct perf_session *self)
> > >>  {
> > >>  	int ret = machine__create_kernel_maps(&self->host_machine);
> > >> @@ -167,6 +190,9 @@ struct perf_session *perf_session__new(const char *filename, int mode, bool forc
> > >>  		 */
> > >>  		if (perf_session__create_kernel_maps(self) < 0)
> > >>  			goto out_delete;
> > >> +
> > >> +		if (perf_session__create_ref_time(self) < 0)
> > >> +			goto out_delete;

> > > So, it does record it anytime?

> > Simplest to always add it the header as it does no harm if not used.
> > To make it conditional means adding an input parameter to
> > perf_session__new() and then updating all the callers.

> > Is the preference to make it conditional?

> No, I suspect the overhead is plain unnoticeable. And if it becomes
> any problem one day, we can still make that conditional later.

Right, but it just ocurred to me, can't we encode this in the file stat?
Also, how do we deal with:

$ perf record --help
<SNIP>
       -A, --append
           Append to the output file to do incremental profiling.
<SNIP>

?

I now think this should be implemented as a PERF_RECORD_WALL_CLOCK
synthesized event, to be inserted just before we start collecting the
other events.

That way, when --appending, we just insert another and use that from
that point on.

Look at tools/perf/util/event.h, enum perf_user_event_type and look how
those are synthesized.

Thanks,

- Arnaldo
