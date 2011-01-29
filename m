From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [RFC] --dump-sym-trace
Date: Sat, 29 Jan 2011 18:50:50 -0200
Message-ID: <20110129205050.GH6345@ghostprotocols.net>
References: <AANLkTin3bp90ybuUDFQijspV0uBw=zTnczcPLBaZvO7p@mail.gmail.com>
 <4D3F871B.3060906@cisco.com>
 <AANLkTinik0+Zp7N54bkh5fBzF1hb2XoubRbuMXwBeYGZ@mail.gmail.com>
 <4D433811.7020904@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44051 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1A2Uu4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 29 Jan 2011 15:50:56 -0500
Received: by ywe10 with SMTP id 10so1504486ywe.19
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Jan 2011 12:50:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D433811.7020904@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Arun Sharma <arun@sharma-home.net>, linux-perf-users@vger.kernel.org

Em Fri, Jan 28, 2011 at 02:41:37PM -0700, David Ahern escreveu:
> 
> 
> On 01/28/11 14:18, Arun Sharma wrote:
> > On Tue, Jan 25, 2011 at 6:29 PM, David Ahern <daahern@cisco.com> wrote:
> >> From a brief glance seems similar to the timehist patch I proposed. See:
> >> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00049.html
> >> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00047.html
> >> http://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg00048.html
> > 
> > The output could be a bit more compact (eg: print some info once per
> > stack trace rather than once per frame). Also, it doesn't seem to
> > print the DSO name when symbol lookup fails?
> 
> I am certainly interested in ideas on how to improve the output.
> 
> That version was derived from a local patch; in our case I wanted a
> simple format for the output. Essentially, the timehist output is a
> 'text' version of the samples, with timestamps and address conversions
> where possible.
> 
> Arnaldo has started a new version of it wherein the wall clock is a new
> event that can be sampled (e.g., perf top) or generated at given rate. I
> spent time looking at the changes to perf command, but have been
> sidetracked with other priorities.

/me too

I have to get back to that, it is definetely a feature we need to have.

- Arnaldo
