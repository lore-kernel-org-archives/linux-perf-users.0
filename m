From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 15:51:18 -0200
Message-ID: <20101213175118.GD7417@ghostprotocols.net>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com>
 <1291773285-16254-2-git-send-email-daahern@cisco.com>
 <20101212201613.GA1784@nowhere>
 <4D06301C.2090309@cisco.com>
 <20101213155451.GA1691@nowhere>
 <20101213164854.GL5407@ghostprotocols.net>
 <4D0659A7.9030608@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:49639 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554Ab0LMRvY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 12:51:24 -0500
Content-Disposition: inline
In-Reply-To: <4D0659A7.9030608@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Mon, Dec 13, 2010 at 10:36:39AM -0700, David S. Ahern escreveu:
> 
> 
> On 12/13/10 09:48, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Dec 13, 2010 at 04:54:56PM +0100, Frederic Weisbecker escreveu:
> >> On Mon, Dec 13, 2010 at 07:39:24AM -0700, David S. Ahern wrote:
> >>> Simplest to always add it the header as it does no harm if not used.
> >>> To make it conditional means adding an input parameter to
> >>> perf_session__new() and then updating all the callers.
> > 
> >>> Is the preference to make it conditional?
> > 
> >> No, I suspect the overhead is plain unnoticeable. And if it becomes
> >> any problem one day, we can still make that conditional later.
> > 
> > Right, but it just ocurred to me, can't we encode this in the file stat?
> 
> I would not want to rely on stat output for timestamps. eg., copy that
> file off box and not have the timestamp preserved.

Yeah, I should have deleted that part, as I suggested something else
after it :-\

> > Also, how do we deal with:
> > 
> > $ perf record --help
> > <SNIP>
> >        -A, --append
> >            Append to the output file to do incremental profiling.
> > <SNIP>
> > 
> > ?
> 
> Is it realistic to expect/allow an append using different perf binaries?
> That just seems plain odd. Then, if one invocation used --timehist and
> another did not output would be bizarre. Of course an append with a

Well, if you use the existence of a ref time and refuse to append to a
file if --timehist is not used, nope.

> reboot between tests would cause problems as well.

Why different perf binaries? Isn't the following scenario valid?

1. perf record --timehist

<stop recording for a while, wait some other time when we know something
 interesting may happen, some periodic higher load that happens,
 whatever>

2. perf record -A --timehist

3. use perf report showing the wall clock time and merge it with your
app specific log

- Arnaldo
