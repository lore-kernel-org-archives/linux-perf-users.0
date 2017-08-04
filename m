From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf record: wrong size in perf_record_mmap for last
 kernel module
Date: Fri, 4 Aug 2017 14:06:14 -0300
Message-ID: <20170804170614.GP12201@kernel.org>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
 <20170724143514.55574-2-tmricht@linux.vnet.ibm.com>
 <20170724182007.GY4134@kernel.org>
 <20170802185047.GL12201@kernel.org>
 <7e74f3d2-204d-0067-4914-1dbba3f02db2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbdHDRGT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Aug 2017 13:06:19 -0400
Content-Disposition: inline
In-Reply-To: <7e74f3d2-204d-0067-4914-1dbba3f02db2@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

Em Thu, Aug 03, 2017 at 11:41:02AM +0200, Thomas-Mich Richter escreveu:
> On 08/02/2017 08:50 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jul 24, 2017 at 03:20:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Jul 24, 2017 at 04:35:14PM +0200, Thomas Richter escreveu:
> >>> +++ b/tools/perf/util/machine.c
> >>> @@ -20,6 +20,7 @@
> >>> +#include <sys/user.h>
> > 
> > no need for this header, see below.
> > 
> >>> -static int machine__create_module(void *arg, const char *name, u64 start)
> >>> +static int machine__create_module(void *arg, const char *name, u64 start, u64 size)
> >>>  {
> >>> @@ -1148,6 +1149,7 @@ static int machine__create_module(void *arg, const char *name, u64 start)
> >>>  	map = machine__findnew_module_map(machine, start, name);
> >>>  	if (map == NULL)
> >>>  		return -1;
> >>> +	map->end = roundup(start + size, PAGE_SIZE);
> > 
> > We have the page_size variable, that gets its value at:
> > 
> > tools/perf/perf.c:	page_size = sysconf(_SC_PAGE_SIZE);
> > 
> > always available, determined at run time.
> > 
> > Also, what is the reason for the roundup?
> > 
> 
> Ok I missed that page_size and will use it.
> The idea for the roundup to page size is the assumption that the kernel
> allocates full pages for memory to load modules. The size filed in the /proc/modules
> output refers to the module size in bytes.
> 
> If this is wrong we can omit the roundup.

Its not wrong, just looks unnecessary, a distraction, I'll remove it, ok?

- Arnaldo

 
> -- 
> Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
> --
> Vorsitzende des Aufsichtsrats: Martina Koederitz 
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
