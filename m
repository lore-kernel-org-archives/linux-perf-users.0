From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Wed, 2 Aug 2017 15:50:47 -0300
Message-ID: <20170802185047.GL12201@kernel.org>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbdHBSuw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2017 14:50:52 -0400
Content-Disposition: inline
In-Reply-To: <20170724182007.GY4134@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

Em Mon, Jul 24, 2017 at 03:20:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter escreveu:
> > +++ b/tools/perf/util/machine.c
> > @@ -20,6 +20,7 @@
> > +#include <sys/user.h>

no need for this header, see below.

> > -static int machine__create_module(void *arg, const char *name, u64 start)
> > +static int machine__create_module(void *arg, const char *name, u64 start, u64 size)
> >  {
> > @@ -1148,6 +1149,7 @@ static int machine__create_module(void *arg, const char *name, u64 start)
> >  	map = machine__findnew_module_map(machine, start, name);
> >  	if (map == NULL)
> >  		return -1;
> > +	map->end = roundup(start + size, PAGE_SIZE);

We have the page_size variable, that gets its value at:

tools/perf/perf.c:	page_size = sysconf(_SC_PAGE_SIZE);

always available, determined at run time.

Also, what is the reason for the roundup?

> >  	dso__kernel_module_get_build_id(map->dso, machine->root_dir);

- Arnaldo
