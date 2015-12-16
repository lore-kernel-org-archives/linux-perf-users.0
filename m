From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 0/9] Tesstsuite - splitted to more commits
Date: Wed, 16 Dec 2015 12:59:58 +0100
Message-ID: <1450267198.3973.22.camel@redhat.com>
References: <1449514372.24573.250.camel@redhat.com>
	 <20151215120352.GC5074@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbbLPMAA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Dec 2015 07:00:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 44A3D347DA8
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Dec 2015 12:00:00 +0000 (UTC)
In-Reply-To: <20151215120352.GC5074@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Tue, 2015-12-15 at 13:03 +0100, Jiri Olsa wrote:
> On Mon, Dec 07, 2015 at 07:52:52PM +0100, Michael Petlan wrote:
> > Hi,
> > 
> > so I have splitted the suite into more commits that are related to
> > the logical parts of it.  These patches should apply to the latest
> > Arnaldo's tree on top of perf/core branch.
> > 
> > I hope it works now.
> > Thanks for reviewing.
> 
> patches 1-9 do not reference 0/9 id in In-Reply-To header,
> so they all appear as independent emails
> 

I'll use '--thread' switch for git format-patch next time, maybe it
fixes the problem.

> thanks,
> jirka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
