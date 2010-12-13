From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Add reference timestamp to perf header
Date: Mon, 13 Dec 2010 18:50:06 +0100
Message-ID: <20101213174959.GE1691@nowhere>
References: <1291773285-16254-2-git-send-email-daahern@cisco.com>
 <20101212201613.GA1784@nowhere>
 <4D06301C.2090309@cisco.com>
 <20101213155451.GA1691@nowhere>
 <20101213164854.GL5407@ghostprotocols.net>
 <20101213170923.GB1691@nowhere>
 <1292260289.6803.297.camel@twins>
 <1292260419.6803.300.camel@twins>
 <20101213172349.GD1691@nowhere>
 <1292261860.6803.338.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:53167 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758497Ab0LMRuL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 12:50:11 -0500
Content-Disposition: inline
In-Reply-To: <1292261860.6803.338.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "David S. Ahern" <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 13, 2010 at 06:37:40PM +0100, Peter Zijlstra wrote:
> On Mon, 2010-12-13 at 18:23 +0100, Frederic Weisbecker wrote:
> > On Mon, Dec 13, 2010 at 06:13:39PM +0100, Peter Zijlstra wrote:
> > > On Mon, 2010-12-13 at 18:11 +0100, Peter Zijlstra wrote:
> > > > 
> > > > Preferably, yes, but I don't see why we can't break the data file format
> > > > if we've got good reasons to. 
> > > 
> > > I mean, we pretty much _have_ to break data file format when we want to
> > > do splice() support.
> > 
> > Because we'll have one file per-cpu?
> 
> Right.
> 
> > But perf.data on UP will be sensibly the same as today so I suspect
> > we won't need to be compatible.
> 
> Nope, since one file simply doesn't scale, data-streams will have to
> live outside of the main file.
> 
> And when you have to make that happen, there is no reason to maintain
> any kind of compatibility. The only thing you could do is provide some
> script to convert old data files to the new format.

Right, a script should do the trick.
