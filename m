Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E2EC0;
	Sun,  9 Jun 2024 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900079; cv=none; b=CG17EIqbSm5/bpIBZ11CU16vKMiIcoG/VGFv86P5s4/GNjz9RQCQoBfY/GZxOpvW5Qd6hqfyn712JY4oz57Of5ea0ttMYC/XzJU2O8zjFMx/pMyAx43pbQW+mP1KIL5SLCZLYdJ5ZYv8Gx42hFd2zadVVUFfjgzFLTYnDXE7Lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900079; c=relaxed/simple;
	bh=gCFD56xrPAyUQ+zx7LWVeY5PRcTCWGUQ9+BPZ2pW7dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW8gPRdUfYmw5KbDuy/NSxUXbK1H33xTZwPTTijSBmEHQWwh8reG6bpG9K3BBliUUUAc1IuWXm7vVGU0FZO8mjsJwdO0lJZM4MhOqcm6MZrwGSZ704w7pUSeb/nsj9qCQSquyzso+pCRczRKmthkIZhy6PpBo10KKycnRCje5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOqAncGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOqAncGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB51C2BD11;
	Sun,  9 Jun 2024 02:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717900079;
	bh=gCFD56xrPAyUQ+zx7LWVeY5PRcTCWGUQ9+BPZ2pW7dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOqAncGv5m/frkDyK8tX3FXlDW3COWL81rcEZat7j0Upb7Rx4AwVP8krjZJpP5cXx
	 GP9sgYiVzD+DErDdCcZEwsOznEcZ8Xwcp3Os6U4Sw2+28iVfNC84hso9bbqfBNS2SZ
	 EmP8tVim4Zi9D5Mm2A54XpErGGsK48c2mPyXyZo7Gi3lcWbynFlqS8BoWDq83DbBCT
	 8F4gyO68+3UfMaR4m9P147OAyWJSmreLC9qxolLdATpoUu8SNwXk2XH5m+nHD/NFhv
	 JERkXrfPlQsytAUzEcCdx1NSn5Um57oNIIp1euNMOyL3Us7L3JZ4C80WIgFRFJhnzT
	 cDdF8BbJ6opig==
Date: Sat, 8 Jun 2024 19:27:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v11 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZmUTLOeLcdYs-cqe@google.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
 <20240605052200.4143205-4-weilin.wang@intel.com>
 <ZmJEP_42Ehlt-c-6@google.com>
 <CO6PR11MB56350EA26F8AD92B222C528DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZmNdYwAxlXkQ8WJt@google.com>
 <CO6PR11MB5635DC04091BBE1FEC59642DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO6PR11MB5635DC04091BBE1FEC59642DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 08:45:13PM +0000, Wang, Weilin wrote:
> 
> 
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Friday, June 7, 2024 12:20 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hunter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor, Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Biggers,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v11 3/8] perf stat: Fork and launch perf record when
> > perf stat needs to get retire latency value for a metric.
> > 
> > On Fri, Jun 07, 2024 at 01:07:12AM +0000, Wang, Weilin wrote:
[SNIP]
> > > > > @@ -2186,6 +2240,9 @@ static int evsel__open_cpu(struct evsel *evsel,
> > > > struct perf_cpu_map *cpus,
> > > > >  		return 0;
> > > > >  	}
> > > > >
> > > > > +	if (evsel__is_retire_lat(evsel))
> > > > > +		return tpebs_start(evsel->evlist, cpus);
> > > >
> > > > As it works with evlist, I think it's better to put this code there.
> > > > But it seems perf stat doesn't call the evlist API for open, then we
> > > > can add this to somewhere in __run_perf_stat() directly.
> > > >
> > > > > +
> > > > >  	err = __evsel__prepare_open(evsel, cpus, threads);
> > > > >  	if (err)
> > > > >  		return err;
> > > > > @@ -2376,6 +2433,8 @@ int evsel__open(struct evsel *evsel, struct
> > > > perf_cpu_map *cpus,
> > > > >
> > > > >  void evsel__close(struct evsel *evsel)
> > > > >  {
> > > > > +	if (evsel__is_retire_lat(evsel))
> > > > > +		tpebs_delete();
> > > >
> > > > Ditto.
> > >
> > > Hi Namhyung,
> > >
> > > I hope both this and the one above on open could stay in evsel level because
> > > these are operations on retire_latency evsel.
> > 
> > Then I think you need to remove the specific evsel not the all tpebs
> > events.
> > 
> > > At the same time, a lot of the
> > > previous several versions of work was to move TPEBS code out from perf
> > stat to
> > > evsel to make it more generic. I think move these back to __run_perf_stat()
> > are
> > > opposite to that goal.
> > 
> > Oh, I meant you can have the logic in utils/intel-tpebs.c but add a call
> > to tpebs_delete() in __run_perf_stat().  I think it'd better to keep it
> > in evlist__close() but we don't use evlist__open() for perf stat so it's
> > not symmetric. :(
> > 
> > Anyway, all I want to say is that tpebs APIs work on evlist level.  So I
> > think it's natural that they are called for the whole list, not for an
> > event/evsel.
> 
> I think we're trying to work at evsel level and open(remove) or close one 
> retire_latency evsel at a time. In addition to that, we put all the required retire_latency
> together in one perf record launch in order to reduce overhead to fork multiple perf 
> record. I hope this makes sense. 

Well.. I think we can do something like this in the current code.

__run_perf_stat():
  ...

  tpebs__start(evlist, target);

  evlist__for_each_cpu(...) {
      if (create_perf_steat_counter() < 0) {
          ....

instead of doing it in the evsel__open().  What's the issue with this
approach?

> 
> > 
> > >
> > >
> > > >
> > > > >  	perf_evsel__close(&evsel->core);
> > > > >  	perf_evsel__free_id(&evsel->core);
> > > > >  }
> > > > > @@ -3341,6 +3400,9 @@ static int store_evsel_ids(struct evsel *evsel,
> > > > struct evlist *evlist)
> > > > >  {
> > > > >  	int cpu_map_idx, thread;
> > > > >
> > > > > +	if (evsel__is_retire_lat(evsel))
> > > > > +		return 0;
> > > > > +
> > > > >  	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd);
> > > > cpu_map_idx++) {
> > > > >  		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
> > > > >  		     thread++) {
> > > > > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> > > > > new file mode 100644
> > > > > index 000000000000..37b7a4f92dd9
> > > > > --- /dev/null
> > > > > +++ b/tools/perf/util/intel-tpebs.c
> > > > > @@ -0,0 +1,397 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * intel_tpebs.c: Intel TPEBS support
> > > > > + */
> > > > > +
> > > > > +
> > > > > +#include <sys/param.h>
> > > > > +#include <subcmd/run-command.h>
> > > > > +#include <thread.h>
> > > > > +#include "intel-tpebs.h"
> > > > > +#include <linux/list.h>
> > > > > +#include <linux/zalloc.h>
> > > > > +#include <linux/err.h>
> > > > > +#include "sample.h"
> > > > > +#include "debug.h"
> > > > > +#include "evlist.h"
> > > > > +#include "evsel.h"
> > > > > +#include "session.h"
> > > > > +#include "tool.h"
> > > > > +#include "cpumap.h"
> > > > > +#include "metricgroup.h"
> > > > > +#include <sys/stat.h>
> > > > > +#include <sys/file.h>
> > > > > +#include <poll.h>
> > > > > +#include <math.h>
> > > > > +
> > > > > +#define PERF_DATA		"-"
> > > > > +
> > > > > +bool tpebs_recording;
> > > > > +static pid_t tpebs_pid = -1;
> > > > > +static size_t tpebs_event_size;
> > > > > +static pthread_t tpebs_reader_thread;
> > > > > +static struct child_process *tpebs_cmd;
> > > > > +static struct list_head tpebs_results = LIST_HEAD_INIT(tpebs_results);
> > > >
> > > > It can be 'static LIST_HEAD(tpebs_results);'
> > > >
> > > > > +
> > > > > +struct tpebs_retire_lat {
> > > > > +	struct list_head nd;
> > > > > +	/* Event name */
> > > > > +	const char *name;
> > > > > +	/* Event name with the TPEBS modifier R */
> > > > > +	const char *tpebs_name;
> > > > > +	/* Count of retire_latency values found in sample data */
> > > > > +	size_t count;
> > > > > +	/* Sum of all the retire_latency values in sample data */
> > > > > +	int sum;
> > > > > +	/* Average of retire_latency, val = sum / count */
> > > > > +	double val;
> > > > > +};
> > > > > +
> > > > > +static int get_perf_record_args(const char **record_argv, char buf[],
> > > > > +				const char *cpumap_buf)
> > > > > +{
> > > > > +	struct tpebs_retire_lat *e;
> > > > > +	int i = 0;
> > > > > +
> > > > > +	pr_debug("Prepare perf record for retire_latency\n");
> > > > > +
> > > > > +	record_argv[i++] = "perf";
> > > > > +	record_argv[i++] = "record";
> > > > > +	record_argv[i++] = "-W";
> > > > > +	record_argv[i++] = "--synth=no";
> > > > > +	record_argv[i++] = buf;
> > > > > +
> > > > > +	if (cpumap_buf) {
> > > > > +		record_argv[i++] = "-C";
> > > > > +		record_argv[i++] = cpumap_buf;
> > > > > +	}
> > > > > +
> > > > > +	record_argv[i++] = "-a";
> > > > > +
> > > > > +	if (!cpumap_buf) {
> > > > > +		pr_err("Require cpumap list to run sampling.\n");
> > > > > +		return -ECANCELED;
> > > > > +	}
> > > >
> > > > Hmm.. I thought you supported system wide collection, not sure if it has
> > > > a cpumap.  Anyway this check makes the earlier one meaningless - you
> > > > need the cpumap always, right?
> > >
> > > TPEBS should be work with "-a" or "-C". I'm not sure what the cpumap
> > would be
> > > for "-a". Would it make sense to add "-a" only when cpumap_buf is NULL?
> > 
> > I think the best way is to check target__has_cpu().
> Yes this is an ideal way to check. But since the tpebs_start() is called in evsel, I'm
> wondering do we still have target here?

Please see above.

Thanks,
Namhyung

> 
> > 
> > >
> > > >
> > > > > +
> > > > > +	list_for_each_entry(e, &tpebs_results, nd) {
> > > > > +		record_argv[i++] = "-e";
> > > > > +		record_argv[i++] = e->name;
> > > > > +	}
> > > > > +
> > > > > +	record_argv[i++] = "-o";
> > > > > +	record_argv[i++] = PERF_DATA;
> > > > > +
> > > > > +	return 0;
> > > > > +}
