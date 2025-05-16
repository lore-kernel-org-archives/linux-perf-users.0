Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033218DF6D;
	Fri, 16 May 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406133; cv=none; b=YZgm0pmCrjt3IvP5xclb7n7bGjNTQIcpTzt4SY9Tcr8fP0twgEdtQBWoQoFuyg455nOUll9taBy++kJBK11nK2sXEil3gb7gK+0/5xnGM2QLJwWyAcckgtDDjO612GtWSSfm9Ep69q3kcXrrPZZqpHe/2qWQ1reEyvrz0XfWKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406133; c=relaxed/simple;
	bh=J/QIpR8OrpPuQ+5A7yOJJ6px/zqtCG8WzG0h+HuXQ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXiltqAseu1rCYDke/9x5Rf/jn0F8l7Q2kmIlKHG/seVcbJpGKjXtk4rY8Dh9X+UuZfdRlkycPu5gH1YhjZ3/ilYosEqiYDaq+qb4hwi6XKhkw5PomqTjPripR+RUxoshWhQ3R1DlMV509H8lQ471oSbJ7Yl/3KXRwqN21vZFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny4brOeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny4brOeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C5FC4CEE4;
	Fri, 16 May 2025 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747406132;
	bh=J/QIpR8OrpPuQ+5A7yOJJ6px/zqtCG8WzG0h+HuXQ6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ny4brOeJKXph/t0D/hx1MGGohyf6S7Y0VZRSXauILnXRs3dGKithzOLuUj201t9yU
	 TnxIc+MET1ilm8OyXKte1fvFHdiZgsHACSFiYGGv4HWbQpmwkcG2yiJzIIqFSgJj+4
	 xX4DYsRAxQ2Vpc3WFXMu1Yd+mz4+3apPWO9yKSWTs8zkweOjM6s9VPdSthHyxVdOMH
	 TZRDRjeuo0YLxkEFR1BDF8aR6DOGWfKySiSrY2HekzLli65jWY+rMZLYkTa3upyuV7
	 MWIYfzsg8g3wTxPX7ueJ5xJyH7IZvaoDICYNFTieAFzLdjSJT8bAzKzxCB4zUCfk8o
	 qKYbA5fqhTHqw==
Date: Fri, 16 May 2025 11:35:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf intel-tpebs: Filter non-workload samples
Message-ID: <aCdNMenCaonhRfJK@x1>
References: <20250430200108.243234-1-irogers@google.com>
 <CO6PR11MB5635C6FF9A6C91B68FCE7937EE90A@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR11MB5635C6FF9A6C91B68FCE7937EE90A@CO6PR11MB5635.namprd11.prod.outlook.com>

On Thu, May 15, 2025 at 08:46:22PM +0000, Wang, Weilin wrote:
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Wednesday, April 30, 2025 1:01 PM
> > To: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > Arnaldo Carvalho de Melo <acme@kernel.org>; Namhyung Kim
> > <namhyung@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > <jolsa@kernel.org>; Ian Rogers <irogers@google.com>; Hunter, Adrian
> > <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>; Wang,
> > Weilin <weilin.wang@intel.com>; James Clark <james.clark@linaro.org>; linux-
> > perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH v1] perf intel-tpebs: Filter non-workload samples
> > 
> > If perf is running with a benchmark then we want the retirement
> > latency samples associated with the benchmark rather than from the
> > system as a whole. Use the workload's PID to filter out samples that
> > aren't from the workload or its children.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>

> Tested-by: Weilin Wang <weilin.wang@intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > ---
> >  tools/perf/util/intel-tpebs.c | 59
> > ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 58 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> > index 7fd6cae1063e..4ad4bc118ea5 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -3,7 +3,7 @@
> >   * intel_tpebs.c: Intel TPEBS support
> >   */
> > 
> > -
> > +#include <api/fs/fs.h>
> >  #include <sys/param.h>
> >  #include <subcmd/run-command.h>
> >  #include <thread.h>
> > @@ -121,6 +121,59 @@ static int evsel__tpebs_start_perf_record(struct
> > evsel *evsel)
> >  	return ret;
> >  }
> > 
> > +static bool is_child_pid(pid_t parent, pid_t child)
> > +{
> > +	if (parent < 0 || child < 0)
> > +		return false;
> > +
> > +	while (true) {
> > +		char path[PATH_MAX];
> > +		char line[256];
> > +		FILE *fp;
> > +
> > +new_child:
> > +		if (parent == child)
> > +			return true;
> > +
> > +		if (child <= 0)
> > +			return false;
> > +
> > +		scnprintf(path, sizeof(path), "%s/%d/status",
> > procfs__mountpoint(), child);
> > +		fp = fopen(path, "r");
> > +		if (!fp) {
> > +			/* Presumably the process went away. Assume not a
> > child. */
> > +			return false;
> > +		}
> > +		while (fgets(line, sizeof(line), fp) != NULL) {
> > +			if (strncmp(line, "PPid:", 5) == 0) {
> > +				fclose(fp);
> > +				if (sscanf(line + 5, "%d", &child) != 1) {
> > +					/* Unexpected error parsing. */
> > +					return false;
> > +				}
> > +				goto new_child;
> > +			}
> > +		}
> > +		/* Unexpected EOF. */
> > +		fclose(fp);
> > +		return false;
> > +	}
> > +}
> > +
> > +static bool should_ignore_sample(const struct perf_sample *sample, const
> > struct tpebs_retire_lat *t)
> > +{
> > +	pid_t workload_pid = t->evsel->evlist->workload.pid;
> > +	pid_t sample_pid = sample->pid;
> > +
> > +	if (workload_pid < 0 || workload_pid == sample_pid)
> > +		return false;
> > +
> > +	if (!t->evsel->core.attr.inherit)
> > +		return true;
> > +
> > +	return !is_child_pid(workload_pid, sample_pid);
> > +}
> > +
> >  static int process_sample_event(const struct perf_tool *tool
> > __maybe_unused,
> >  				union perf_event *event __maybe_unused,
> >  				struct perf_sample *sample,
> > @@ -140,6 +193,10 @@ static int process_sample_event(const struct
> > perf_tool *tool __maybe_unused,
> >  		mutex_unlock(tpebs_mtx_get());
> >  		return -EINVAL;
> >  	}
> > +	if (should_ignore_sample(sample, t)) {
> > +		mutex_unlock(tpebs_mtx_get());
> > +		return 0;
> > +	}
> >  	/*
> >  	 * Need to handle per core results? We are assuming average retire
> >  	 * latency value will be used. Save the number of samples and the sum
> > of
> > --
> > 2.49.0.906.g1f30a19c02-goog
> 
