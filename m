Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67C18CBFC;
	Mon,  9 Sep 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920770; cv=none; b=Ku7nAguREhwsBnRTOqYMUROOfZJFApxL5Mvpl0Rj4Z9xkFfJkjAyJeAAueh+7hj0UW8tePWER0s/ZfdGEC8re06vI3fEBqkF5slJmb4UO5c5i1Cs3HPauxb0FgA3+hUNTbAGI7bZe+DULmJjS9JXOgu0SvKev3qX2HnF7wiux0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920770; c=relaxed/simple;
	bh=VxoyjjS0GKipy/mS0UK0CMXRJnQ+lCzjurk744xwrFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My5hgRZ02QeumEVxvEaDDKw9Dob+VG+4aIIOfSQGVBPuJ4wyPZ4RAMqjDuNnRxQRvitghbRDSa9fz4WMA37O/ZafdNFE+1kdjMMs/5TT2WpZ8lHoaOaKMtoJt0JLYiJsLqoFFFDHZDP68PElbaJUdfrjmgOIcA3jxlJDV6T++9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghqjrNz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghqjrNz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D11C4CEC5;
	Mon,  9 Sep 2024 22:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725920770;
	bh=VxoyjjS0GKipy/mS0UK0CMXRJnQ+lCzjurk744xwrFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghqjrNz1FTuhuAgKkrP7r+yEwPaVmRsOvimF6vICvQdk/90hPL/LazoogSR8lZjb+
	 /AQQgz+OeEtmvXhP8FeXJmd1iw+fdKjiBOVH6qzKg21U9NRsR8K9WK2ImfPYfW6Vyh
	 WjegQUhQNNCM46yqNVpZTeuUsurbPLZoQnbVXYTVyJczpoNOik5TtY0JYS1w34N+Kd
	 bq7Hr5hiskQnWxLnoKAPSkTKlNSA/nrGGuB4w3j5FjIEBq3q04SnKNuIkngYxcXolQ
	 J3aPK/44D+BO+A1QT9drNYsNndDj9VQXjau/7ff095fwIkVaYgvnFVfyHHL0Mbi8Z2
	 9eu1n0RcteJYg==
Date: Mon, 9 Sep 2024 15:26:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Add perf_evsel__id() function
Message-ID: <Zt92ADG9_W4ujarg@google.com>
References: <20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com>
 <ZtkyCWXVjnn-hjUT@google.com>
 <Ztn/mRDqPSpmliWq@ghost>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ztn/mRDqPSpmliWq@ghost>

On Thu, Sep 05, 2024 at 11:59:37AM -0700, Charlie Jenkins wrote:
> On Wed, Sep 04, 2024 at 09:22:33PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Aug 23, 2024 at 11:58:38AM -0700, Charlie Jenkins wrote:
> > > Introduce perf_evsel__id() to collect the id of an evsel. It is not
> > > currently possible when using libperf to determine the id of an evsel.
> > > This will allow applications to link the id returned by PERF_SAMPLE_ID
> > > to the event being sampled.
> > 
> > I'm not sure what's your use case.  We have evlist__id2evsel() to
> > convert sample-ID to evsel already.  It'd read the IDs from perf data
> > file.
> 
> That function is unfortunately not exposed to be used by applications.
> This patch is for libperf, not for the util internals of userspace perf.
> Since I am using libperf (and not the python wrapper) I am collecting
> data directly from the mmap buffer and not from the perf data file. The
> mmap buffer only contains the id of the sample, and no way of
> associating this id with the evsel that is backing the id using only
> libperf API functions. A libperf function that provides a pointer to the
> associated evsel could be another alternative to this. However an API
> that returns a pointer to the evsel is not very useful as libperf
> applications cannot read members of perf structs, as the layout of perf
> structs are not part of the API.

Right, thanks for sharing your use case.  The libperf lacks the API to
map event ID to evsel.  And perf tools access the internal data struct
in the libperf which is not good.  But making it a proper library will
take a lot more time.

> 
> > 
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  tools/lib/perf/Documentation/libperf.txt |  2 ++
> > >  tools/lib/perf/evsel.c                   | 10 ++++++++++
> > >  tools/lib/perf/include/perf/evsel.h      |  1 +
> > >  3 files changed, 13 insertions(+)
> > > 
> > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > > index fcfb9499ef9c..69c1d7efb659 100644
> > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > @@ -94,6 +94,8 @@ SYNOPSIS
> > >    void perf_evlist__enable(struct perf_evlist *evlist);
> > >    void perf_evlist__disable(struct perf_evlist *evlist);
> > >  
> > > +  void perf_evsel__id(struct perf_evsel *evsel, u64 *id);
> > > +
> > >    #define perf_evlist__for_each_evsel(evlist, pos)
> > >  
> > >    void perf_evlist__set_maps(struct perf_evlist *evlist,
> > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > index c07160953224..765b17045342 100644
> > > --- a/tools/lib/perf/evsel.c
> > > +++ b/tools/lib/perf/evsel.c
> > > @@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
> > >  	return err;
> > >  }
> > >  
> > > +int perf_evsel__id(struct perf_evsel *evsel, __u64 *id)
> > > +{
> > > +	int i;
> > > +	int err = 0;
> > > +
> > > +	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> > > +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)id, i);
> > 
> > IIUC this would update the place pointed by 'id' for every fd then you
> > will get the last ID only.
> 
> Yes I have a misunderstanding with how this is supposed to be written.
> Can there be multiple ids associated with a given evsel? When parsing
> the data in the mmap buffer, I want to be able to associate a sample id
> with the event encoding. I suppose an API to get the evsel from an id,
> and then require libperf applications to search some data structure to
> get the associated event with the evsel is reasonable.

Yes an evsel can have multiple IDs as it can have multiple FDs.  The
evsel is an abstraction to keep related events together and they are
actually opened for each CPU and thread, hence the xyarray.  Each opened
event (for the evsel) has its own ID.

You will need an array of a same size of file descriptors to retrieve
the ID info and also a hash table to map ID to evsel.

Thanks,
Namhyung

> > 
> > > +	return err;
> > > +}
> > > +
> > >  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
> > >  {
> > >  	int err = 0, i;
> > > diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> > > index 6f92204075c2..1457e5a46b28 100644
> > > --- a/tools/lib/perf/include/perf/evsel.h
> > > +++ b/tools/lib/perf/include/perf/evsel.h
> > > @@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
> > >  LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
> > >  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
> > >  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> > > +LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 *id);
> > >  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> > >  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
> > >  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> > > 
> > > ---
> > > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> > > change-id: 20240822-perf_evsel_get_id-f7e11f15504b
> > > -- 
> > > - Charlie
> > > 
