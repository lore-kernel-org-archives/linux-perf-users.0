From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf-list: perf list sw segmentation fault fix
Date: Sun, 6 Dec 2015 16:14:26 -0200
Message-ID: <20151206181426.GA2493@redhat.com>
References: <1449064322.24573.140.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbbLFSOa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Dec 2015 13:14:30 -0500
Content-Disposition: inline
In-Reply-To: <1449064322.24573.140.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, ast@plumgrid.com

Em Wed, Dec 02, 2015 at 02:52:02PM +0100, Michael Petlan escreveu:
> The PERF_COUNT_SW_BPF_OUTPUT entry is missing in the event_symbols_sw
> array.  Due to that "perf list sw" segfaults,  because a NULL pointer
> is passed to strlen() function at util/parse-events.c:1895.
> 
> After this patch, the syms array is set correctly,  so "perf list sw"
> does not segfault.

I had that fixed already, its upstream by now.

Thanks,

- Arnaldo
