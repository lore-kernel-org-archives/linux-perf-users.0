From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: fix perf test case 14 result reporting
Date: Sun, 4 Jun 2017 20:51:19 +0200
Message-ID: <20170604185057.GA18648@krava>
References: <20170601123441.24581-1-tmricht@linux.vnet.ibm.com>
 <20170601132038.GG2899@kernel.org>
 <20170601210451.GA5713@krava>
 <c06b8134-4636-c14f-c580-8b45e5256093@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdFDSvV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jun 2017 14:51:21 -0400
Content-Disposition: inline
In-Reply-To: <c06b8134-4636-c14f-c580-8b45e5256093@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 02, 2017 at 11:58:46AM +0200, Thomas-Mich Richter wrote:

SNBIP

> > I started fixing it some time ago, but got distracted, if you are
> > interested, you're welcome to pick up from my branch ;-)
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/attr_test
> > 
> > thanks,
> > jirka
> > 
> 
> I have started work on perf tool very recently to get s390 support
> working and up to date.
> 
> I downloaded your branch and discovered you have already fixed
> another issue I run into this week. For example 
> commit 070b9644981e ("perf tests attr: Do not store failed events")
> 
> I can certainly help you to get this test case operational again.
> Maybe you need to pull some of your patches out of your backlog
> and submit them the kernel to get to a common base to work on.
> 
> I suggest we should move the discussion to the linux-perf-users
> mailing list.
> 
> Your thoughts?

good idea, for me it'd be best if you pull them and change them
as you see fit.. I dont think I'll get to it any time soon

thanks,
jirka
