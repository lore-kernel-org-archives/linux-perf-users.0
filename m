From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/2] perf tools: add reference timestamp and use it in
 time history dump
Date: Sun, 12 Dec 2010 22:39:50 +0100
Message-ID: <20101212213948.GD1784@nowhere>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com>
 <20101209171853.GC13027@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:43350 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab0LLVjy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 12 Dec 2010 16:39:54 -0500
Received: by fxm18 with SMTP id 18so5631982fxm.2
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Dec 2010 13:39:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101209171853.GC13027@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org

On Thu, Dec 09, 2010 at 03:18:53PM -0200, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 07, 2010 at 06:54:43PM -0700, David Ahern escreveu:
> > David Ahern (2):
> >   perf tools: Add reference timestamp to perf header
> >   perf tools: Add option to show time history of event samples
> > 
> >  tools/perf/builtin-record.c |    8 +++
> >  tools/perf/builtin-report.c |  131 ++++++++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/header.c    |   51 +++++++++++++++++
> >  tools/perf/util/header.h    |    3 +
> >  tools/perf/util/session.c   |   26 +++++++++
> >  5 files changed, 217 insertions(+), 2 deletions(-)
> 
> I'll go to a business trip today/tomorrow, will try to check these while
> at the hotel.
> 
> Frederic, if you have some time, could you take a look? I touches the
> HEADER_FEAT stuff, the feature has a huge potential, merging app
> specific logs with perf report output helps correlating counter to app
> specific events, great stuff.
> 
> I would just love to have at least one more person reviewing this,
> thanks,


It looks mostly ok, except few nits I noticed.

Thanks!
