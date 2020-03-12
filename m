From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Date: Thu, 12 Mar 2020 11:51:45 +0100
Message-ID: <20200312105145.GC311223@krava>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309062552.29911-7-kjain@linux.ibm.com>
 <20200310183455.GB12036@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200310183455.GB12036@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 10, 2020 at 03:34:55PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> > index 3b4cdfc5efd6..036f6b2ce202 100644
> > --- a/tools/perf/arch/powerpc/util/header.c
> > +++ b/tools/perf/arch/powerpc/util/header.c
> > @@ -7,6 +7,11 @@
> >  #include <string.h>
> >  #include <linux/stringify.h>
> >  #include "header.h"
> > +#include "metricgroup.h"
> > +#include "evlist.h"
> > +#include <dirent.h>
> > +#include "pmu.h"
> > +#include <api/fs/fs.h>
> >  
> >  #define mfspr(rn)       ({unsigned long rval; \
> >  			 asm volatile("mfspr %0," __stringify(rn) \
> > @@ -16,6 +21,8 @@
> >  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
> >  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
> >  
> > +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
> > +
> >  int
> >  get_cpuid(char *buffer, size_t sz)
> >  {
> > @@ -44,3 +51,18 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> >  
> >  	return bufp;
> >  }
> > +
> > +int arch_get_runtimeparam(void)
> > +{
> > +	int count;
> > +	char path[PATH_MAX];
> > +	char filename[] = "sockets";
> > +
> > +	snprintf(path, PATH_MAX,
> > +		 SOCKETS_INFO_FILE_PATH "%s", filename);

also, what's the point of using snprintf in here?

jirka
