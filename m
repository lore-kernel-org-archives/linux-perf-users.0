From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 0/2] perf tools: add reference timestamp and use it in
 time history dump
Date: Thu, 9 Dec 2010 15:18:53 -0200
Message-ID: <20101209171853.GC13027@ghostprotocols.net>
References: <1291773285-16254-1-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35041 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab0LIRS6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Dec 2010 12:18:58 -0500
Received: by ywl5 with SMTP id 5so1520240ywl.19
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2010 09:18:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291773285-16254-1-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org

Em Tue, Dec 07, 2010 at 06:54:43PM -0700, David Ahern escreveu:
> David Ahern (2):
>   perf tools: Add reference timestamp to perf header
>   perf tools: Add option to show time history of event samples
> 
>  tools/perf/builtin-record.c |    8 +++
>  tools/perf/builtin-report.c |  131 ++++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.c    |   51 +++++++++++++++++
>  tools/perf/util/header.h    |    3 +
>  tools/perf/util/session.c   |   26 +++++++++
>  5 files changed, 217 insertions(+), 2 deletions(-)

I'll go to a business trip today/tomorrow, will try to check these while
at the hotel.

Frederic, if you have some time, could you take a look? I touches the
HEADER_FEAT stuff, the feature has a huge potential, merging app
specific logs with perf report output helps correlating counter to app
specific events, great stuff.

I would just love to have at least one more person reviewing this,
thanks,

- Arnaldo
