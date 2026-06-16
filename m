Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53234657F4;
	Tue, 16 Jun 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625786; cv=none; b=AwfE8cCwf4aihbqMoL+TlEvukqwkvYbaaWwuAb/RoJsJ8eX6CabC7/vvdak12TkSLgE3YmRsklrABNQYDBtTReTm24rMl0djJqbxCTpygx3ZcaD5e+AirRfzUD272Nj6fdB4MOqZNfTbHjYipLytxhrnxx/TxU0fzG8AnQXmU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625786; c=relaxed/simple;
	bh=Mw5IgsnN7DNwwUQHsgasLdh9fk6jhKqNpH2Nv522Vrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ0tlON1e1h+BjKSJsV/fKMVHfh8fljguQ0uwV4wD5vanh/qhb04yTAMweF/5Q6hRqnJwn296dRUGyNotbhtevAsa849EOp/hyLNqbL3MPXVWMcExxUos7bnCIn5oRX84+5EW8mthqJLaWBizDEPgj80hbr4ac2katS8nywSHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZS50b5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZS50b5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0C41F000E9;
	Tue, 16 Jun 2026 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625784;
	bh=7OHd0UBpn0rgUH6NJV8ruQioGXLuV/btshrbeH7Pyyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZS50b5owRSlNiNmvBC7hf743BZmidStIwVBwouxAABBrgP+2jkz10FIo0rDADkxl
	 ZSV0LAfBQuDR7zeBrX/sx+UO0tVENtRIOezku+SGdrwl9SW/goYzXiAB0s6Z+X3Ge5
	 IH9ocnBWeLRpLKa4TpiaWm9q5XYJNxAwUdEPcJ1wSoM0lrnQRwD2v+x/eCTCdX9KL6
	 stG6nUm+7naMeBkN0kGMd0k+TupxunOjV/JgH3EcadBpXxY8M8yhfSXM1I5nvjVfa+
	 1M5RIz7EEsoIyfu/Cg0MulNgXI415hUkxqEa9qt3YJZF3IKKSraqMtBPtUtsdpbc5M
	 /lr7Wf7Z6GLKg==
Date: Tue, 16 Jun 2026 13:03:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v21 08/21] perf python: Use evsel in sample in pyrf_event
Message-ID: <ajFztSaBdZgJ6sJF@x1>
References: <20260616011543.4037138-9-irogers@google.com>
 <20260616015219.0BCC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616015219.0BCC51F000E9@smtp.kernel.org>

On Tue, Jun 16, 2026 at 01:52:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Missing NULL check before calling evsel__get() on the result of evlist__id2evsel() leads to a potential crash.
> - [Medium] Missing perf_sample__exit() on the error path of guest_session__fetch() leaks the evsel reference.
> - [Medium] Missing perf_sample__exit() on the error path out of perf_mmap__read_event() loop in test__perf_time_to_tsc leaks the evsel reference.
> --
> 
> commit c23db56d8fc8d40b59596916ce6b0537514263aa
> Author: Ian Rogers <irogers@google.com>
> 
> perf python: Use evsel in sample in pyrf_event
>     
> Avoid a duplicated evsel by using the one in sample. Add
> evsel__get/put to the evsel in perf_sample.
> 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index ec759a11f7588..d79112cebb716 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3365,7 +3365,7 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >  	union u64_swap u;
> >  
> >  	perf_sample__init(data, /*all=*/true);
> > -	data->evsel = evsel;
> > +	data->evsel = evsel__get(evsel);
> 
> [Severity: Medium]
> Does this new reference acquisition cause memory leaks in existing callers
> that do not expect sample.evsel to hold a reference on early errors? 

So this was something I wasn't expecting: patches for tools/perf/util/
inside a python binding series :-\
 
> For example, in tools/perf/builtin-inject.c:guest_session__inject_events(),
> if guest_session__fetch() fails, it returns an error but the cleanup block
> checking if (ret && gs->fetched) prevents perf_sample__exit() from running,
> leaking the evsel reference.

this looks valid, no?

And while looking at it, there is another bug in that function, but now
I'm looking like sashiko ;-)

Namely:

 tools/perf/builtin-inject.c
╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
 1970        if (sample->cpu >= gs->vcpu_cnt) {
 1971          pr_err("Guest event with unknown VCPU %u\n",
 1972                 sample->cpu);
 1973 -        return -EINVAL;
 1973 +        ret = -EINVAL;
 1974 +        break;
 1975        }
 1976        /* Change to host CPU instead of guest VCPU */
 1977        sample->cpu = gs->vcpu[sample->cpu].cpu;

But the comment for your patch seems actionable, i.e. it is an issue
introduced by your series, by calling that evsel__get(), no?
 
> Similarly, in tools/perf/tests/perf-time-to-tsc.c:test__perf_time_to_tsc(),
> the CHECK__(evsel__parse_sample(...)) macro jumps to out_err on failure,
> bypassing perf_sample__exit(&sample) and permanently leaking the newly
> acquired evsel.
> 
> >  	data->cpu = data->pid = data->tid = -1;
> >  	data->stream_id = data->id = data->time = -1ULL;
> >  	data->period = evsel->core.attr.sample_period;
> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 89d0f4cec6c7f..18af70488e07a 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1874,7 +1875,11 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
> >  		else
> >  			orig_sample.deferred_callchain = false;
> >  
> > -		orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
> > +		new_evsel = evlist__id2evsel(evlist, orig_sample.id);
> > +		if (new_evsel != orig_sample.evsel) {
> > +			evsel__put(orig_sample.evsel);
> > +			orig_sample.evsel = evsel__get(new_evsel);
> > +		}
> 
> [Severity: High]
> Can this cause a segmentation fault if the sample ID is unknown or corrupted?
> 
> The evlist__id2evsel() function can return NULL for malformed perf.data files.
> If new_evsel is NULL, passing it directly to evsel__get(new_evsel) will
> dereference the NULL pointer when trying to increment its reference count.
> 
> Could we add a NULL check here before calling evsel__get()?
> 
> >  		ret = evlist__deliver_sample(evlist, tool, de->event,
> >  					     &orig_sample, machine);
> >  
> > @@ -1913,7 +1919,11 @@ static int session__flush_deferred_samples(struct perf_session *session,
> >  		}
> >  		sample.file_offset = de->file_offset;
> >  
> > -		sample.evsel = evlist__id2evsel(evlist, sample.id);
> > +		new_evsel = evlist__id2evsel(evlist, sample.id);
> > +		if (new_evsel != sample.evsel) {
> > +			evsel__put(sample.evsel);
> > +			sample.evsel = evsel__get(new_evsel);
> > +		}
> 
> [Severity: High]
> Similarly, could evlist__id2evsel() return NULL here and cause a crash when
> passed to evsel__get()?
> 
> >  		ret = evlist__deliver_sample(evlist, tool, de->event,
> >  					     &sample, machine);
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260616011543.4037138-1-irogers@google.com?part=8
