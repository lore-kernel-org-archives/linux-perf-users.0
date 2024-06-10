Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAD1667CE;
	Mon, 10 Jun 2024 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063938; cv=none; b=dw11Wju8P4Jg60bym9N3vfugAz/wVSm7ptRVGn1YBUuHa2Ij403L2TmtonbcT/RXWdBiCpeIscAFmvJJ3heniH6m2JxCtXvwdHE4+OlhhHhMp/ES0hiF0u+chKQHwm8X10ypmcct0YMdNfyZ6gqjvLDcqjh4ZR1ZDdnhZbW+qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063938; c=relaxed/simple;
	bh=TMd9ShYqXLeevvMtmc025xx4ND5vCFYKY163BbYiDQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2u2/DYn3/xOBEFzSCAm3xixKX9UdBLqibS2EmBieBjvIEpaEeu/cEyNtVGQScRydXNX+JB2U6TfFXFzQnvnQo8r2srS/c8q71inkKs6OQ3wOfUUNYmdK74V5JA04zy7Y6mVk4M/LQb7a/Wa0m7Ce7X4U2vYrFSTpIflcKMdtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaAhs4eC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaAhs4eC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B833C2BBFC;
	Mon, 10 Jun 2024 23:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718063937;
	bh=TMd9ShYqXLeevvMtmc025xx4ND5vCFYKY163BbYiDQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaAhs4eCThrvSd04FwUkG/bwBIcHs+7/sOiGosfwJrtSzlG9OnTd54sUA0Dufw7IB
	 PRrXr3pnvSyHCkzwvzvURpoC+m95gdK10lgNQbdb0tM1AVoxwoOj42FXCGve6b5l3I
	 zP5JxNwaapH3H1r+afZqniAuZh+1yQtmS+uoa4QsdGsDrfA5lvOncB5PW1p3g2Eoo9
	 l3yBC7MgTtZIX4hEFws/Eu2VrLk41RBSPDleXjSyhTmxIeqtZS6vd8mVxb+74Fg0P7
	 SXkGZrb/a8mBecKi6rxqi38o5qMxgraiuqJqyf3tKYRb3xann34IQC39W6HIfd/FY6
	 N/6xPzq+d92Xg==
Date: Mon, 10 Jun 2024 16:58:55 -0700
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
Message-ID: <ZmeTP8cnK12dgJxq@google.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
 <20240605052200.4143205-4-weilin.wang@intel.com>
 <ZmJEP_42Ehlt-c-6@google.com>
 <CO6PR11MB56350EA26F8AD92B222C528DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZmNdYwAxlXkQ8WJt@google.com>
 <CO6PR11MB5635DC04091BBE1FEC59642DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZmUTLOeLcdYs-cqe@google.com>
 <CO6PR11MB5635B74E5C5FFE7182501DCBEEC52@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO6PR11MB5635B74E5C5FFE7182501DCBEEC52@CO6PR11MB5635.namprd11.prod.outlook.com>

On Sun, Jun 09, 2024 at 03:02:21AM +0000, Wang, Weilin wrote:
> 
> 
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Saturday, June 8, 2024 7:28 PM
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
> > On Fri, Jun 07, 2024 at 08:45:13PM +0000, Wang, Weilin wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Namhyung Kim <namhyung@kernel.org>
> > > > Sent: Friday, June 7, 2024 12:20 PM
> > > > To: Wang, Weilin <weilin.wang@intel.com>
> > > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > > <mingo@redhat.com>; Alexander Shishkin
> > > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hunter,
> > > > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>;
> > > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,
> > Perry
> > > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
> > Biggers,
> > > > Caleb <caleb.biggers@intel.com>
> > > > Subject: Re: [RFC PATCH v11 3/8] perf stat: Fork and launch perf record
> > when
> > > > perf stat needs to get retire latency value for a metric.
> > > >
> > > > On Fri, Jun 07, 2024 at 01:07:12AM +0000, Wang, Weilin wrote:
> > [SNIP]
> > > > > > > @@ -2186,6 +2240,9 @@ static int evsel__open_cpu(struct evsel
> > *evsel,
> > > > > > struct perf_cpu_map *cpus,
> > > > > > >  		return 0;
> > > > > > >  	}
> > > > > > >
> > > > > > > +	if (evsel__is_retire_lat(evsel))
> > > > > > > +		return tpebs_start(evsel->evlist, cpus);
> > > > > >
> > > > > > As it works with evlist, I think it's better to put this code there.
> > > > > > But it seems perf stat doesn't call the evlist API for open, then we
> > > > > > can add this to somewhere in __run_perf_stat() directly.
> > > > > >
> > > > > > > +
> > > > > > >  	err = __evsel__prepare_open(evsel, cpus, threads);
> > > > > > >  	if (err)
> > > > > > >  		return err;
> > > > > > > @@ -2376,6 +2433,8 @@ int evsel__open(struct evsel *evsel, struct
> > > > > > perf_cpu_map *cpus,
> > > > > > >
> > > > > > >  void evsel__close(struct evsel *evsel)
> > > > > > >  {
> > > > > > > +	if (evsel__is_retire_lat(evsel))
> > > > > > > +		tpebs_delete();
> > > > > >
> > > > > > Ditto.
> > > > >
> > > > > Hi Namhyung,
> > > > >
> > > > > I hope both this and the one above on open could stay in evsel level
> > because
> > > > > these are operations on retire_latency evsel.
> > > >
> > > > Then I think you need to remove the specific evsel not the all tpebs
> > > > events.
> > > >
> > > > > At the same time, a lot of the
> > > > > previous several versions of work was to move TPEBS code out from perf
> > > > stat to
> > > > > evsel to make it more generic. I think move these back to
> > __run_perf_stat()
> > > > are
> > > > > opposite to that goal.
> > > >
> > > > Oh, I meant you can have the logic in utils/intel-tpebs.c but add a call
> > > > to tpebs_delete() in __run_perf_stat().  I think it'd better to keep it
> > > > in evlist__close() but we don't use evlist__open() for perf stat so it's
> > > > not symmetric. :(
> > > >
> > > > Anyway, all I want to say is that tpebs APIs work on evlist level.  So I
> > > > think it's natural that they are called for the whole list, not for an
> > > > event/evsel.
> > >
> > > I think we're trying to work at evsel level and open(remove) or close one
> > > retire_latency evsel at a time. In addition to that, we put all the required
> > retire_latency
> > > together in one perf record launch in order to reduce overhead to fork
> > multiple perf
> > > record. I hope this makes sense.
> > 
> > Well.. I think we can do something like this in the current code.
> > 
> > __run_perf_stat():
> >   ...
> > 
> >   tpebs__start(evlist, target);
> > 
> >   evlist__for_each_cpu(...) {
> >       if (create_perf_steat_counter() < 0) {
> >           ....
> > 
> > instead of doing it in the evsel__open().  What's the issue with this
> > approach?
> 
> This is basically how tpebs__start() was invoked in v9 (https://lore.kernel.org/all/CAM9d7ci7tgjR8LVNx+ZrFKMGo+OZn=eFSksPL56MeP_Q84PkMw@mail.gmail.com/)
> 
> I changed it in v10 so that it works at evsel level. 
> 
> Ian, could you please let me know what do you think about this? 

Ok, we sync-ed offline and agreed to have it in evsel level.  I still
think it's better to handle it in evlist level (at least for TPEBS) but
unfortunately we don't use evlist__open() consistently and there are
places it's not called.  Probably we need to convert the all call sites
to open evsel to be from evlist__open() then move tpebs__start() there.

Thanks,
Namhyung

