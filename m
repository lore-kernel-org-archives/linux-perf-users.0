From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Date: Wed, 26 Aug 2020 13:00:46 +0200
Message-ID: <20200826110046.GF703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bc078472-e859-b7dc-c451-d737dd573edf@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 25, 2020 at 09:14:11AM +0100, John Garry wrote:

SNIP

> >   				goto free_strings;
> >   		}
> > -		err = func(data, name, real_event(name, event), desc, long_desc,
> > -			   pmu, unit, perpkg, metric_expr, metric_name,
> > -			   metric_group, deprecated, metric_constraint);
> > +		je->event = real_event(je->name, je->event);
> > +		err = func(data, je);
> >   free_strings:
> > -		free(event);
> > -		free(desc);
> > -		free(name);
> > -		free(long_desc);
> >   		free(extra_desc);
> > -		free(pmu);
> >   		free(filter);
> > -		free(perpkg);
> > -		free(deprecated);
> > -		free(unit);
> > -		free(metric_expr);
> > -		free(metric_name);
> > -		free(metric_group);
> > -		free(metric_constraint);
> >   		free(arch_std);
> > +		free(je);
> >   		if (err)
> >   			break;
> > diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> > index 2afc8304529e..e696edf70e9a 100644
> > --- a/tools/perf/pmu-events/jevents.h
> > +++ b/tools/perf/pmu-events/jevents.h
> 
> Somewhat unrelated - this file only seems to be included in jevents.c, so I
> don't see why it exists...

ah right.. I won't mind getting rid of it
 
> > @@ -2,14 +2,28 @@
> >   #ifndef JEVENTS_H
> >   #define JEVENTS_H 1
> > +#include "pmu-events.h"
> > +
> > +struct json_event {
> > +	char *name;
> > +	char *event;
> > +	char *desc;
> > +	char *topic;
> > +	char *long_desc;
> > +	char *pmu;
> > +	char *unit;
> > +	char *perpkg;
> > +	char *metric_expr;
> > +	char *metric_name;
> > +	char *metric_group;
> > +	char *deprecated;
> > +	char *metric_constraint;
> 
> This looks very much like struct event_struct, so could look to consolidate:
> 
> struct event_struct {
> 	struct list_head list;
> 	char *name;
> 	char *event;
> 	char *desc;
> 	char *long_desc;
> 	char *pmu;
> 	char *unit;
> 	char *perpkg;
> 	char *metric_expr;
> 	char *metric_name;
> 	char *metric_group;
> 	char *deprecated;
> 	char *metric_constraint;
> };

as Andi said they come from different layers, I think it's
better to keep them separated even if they share some fields

thanks,
jirka
