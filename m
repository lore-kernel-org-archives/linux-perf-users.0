Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8B27B352;
	Fri,  6 Feb 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412212; cv=none; b=p27YlGgekzPXzj0mI5u/711euOuWLJ1BLv3NJQ/2lOzGFU6bCLXvSyEPKd3eLPmem2szeVI60T2g0VzJW+5EWK+aV3PVRW3HSQ3ElPvQCkiDRMX2dtvg0v3bPhaMNgR98AFiqyquEC+i+7uMZuwSYOyK8X5A8jf1rCGcp69vG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412212; c=relaxed/simple;
	bh=Y6GL8biqSlwg+JjbjBGKjAdmb4rNfSuaBVuCtCJFLxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTL8SwTvTOqA28pfYmLmhsiTsJKtbB+XmMBmnYubUjHWvxG9w1DICFKPJSWpb3yv2lLUI/F9ZYG3jNLilEctNfRnlJ2r8qxQkcxKUFTeD8rVU40o73g848HXA4F/ZfLUVJCZQ54kzgXvOemqYwMPPuyMkGmWraSYQ1aX3H9s13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElKqVx4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElKqVx4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32589C16AAE;
	Fri,  6 Feb 2026 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770412212;
	bh=Y6GL8biqSlwg+JjbjBGKjAdmb4rNfSuaBVuCtCJFLxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElKqVx4wZ5oP58BitfoQkCfU1Jn7XF2XNxJqcTQ2A9IyP2CUaQjqEMa5Af5on8oYP
	 pLS9TL0BGK5ucEcYkcYPGGaFZBT5BYtMmedhiXi7TZOfbKh1wr+dJ2Xu8L5W/H3r20
	 WJnJ39WAhYhnR1mBHRezNbrs+i024UFxEW+hvd9ejrHald+xuSlOPjEVwGeFUXgjR7
	 m0xTmk1Xwl7oKmkbOJlv8BNJ3vin7KHfRbYgpxHRsuzRVUVTzdNvqi/4R87akOZEGu
	 5bSvmCc59m0+1J7ZRbs3ls4J/nWHPD/D0y5NB9v+CSXVfHYlbD+HoraMdmtI06ZnKB
	 yA3gAvQbYrwsA==
Date: Fri, 6 Feb 2026 18:10:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v1 1/2] perf callchain lbr: Make the leaf IP that of the
 sample
Message-ID: <aYZYrxyg7MTepxKQ@x1>
References: <20260205205622.530825-1-irogers@google.com>
 <764406ae-c604-410c-9205-7f3343a4bd8f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764406ae-c604-410c-9205-7f3343a4bd8f@linux.intel.com>

On Fri, Feb 06, 2026 at 09:44:04AM +0800, Mi, Dapeng wrote:
> 
> On 2/6/2026 4:56 AM, Ian Rogers wrote:
> > The current IP of a leaf function when reported from a perf record
> > with "--call-graph lbr" is the "to" field of the LBR branch stack
> > record. The sample for the event being recorded may be further into
> > the function and there may be inlining information associated with
> > it. Rather than use the branch stack "to" field in this case switch to
> > the callchain appending the sample->ip and thereby allowing the inline
> > information to show.
> >
> > Before this change:
> > ```
> > $ perf record --call-graph lbr perf test -w inlineloop
> > ...
> > $ perf script --fields +srcline
> > ...
> > perf-inlineloop  467586  4649.344493:     950905 cpu_core/cycles/P:
> >            55dfda2829c0 parent+0x0 (perf)
> >  inlineloop.c:31
> >            55dfda282a96 inlineloop+0x86 (perf)
> >  inlineloop.c:47
> >            55dfda236420 run_workload+0x59 (perf)
> >  builtin-test.c:715
> >            55dfda236b03 cmd_test+0x413 (perf)
> >  builtin-test.c:825
> > ...
> > ```
> >
> > After this change:
> > ```
> > $ perf record --call-graph lbr perf test -w inlineloop
> > ...
> > $ perf script --fields +srcline
> > ...
> > perf-inlineloop  529703 11878.680815:     950905 cpu_core/cycles/P:
> >             555ce86be9e6 leaf+0x26
> >   inlineloop.c:20 (inlined)
> >             555ce86be9e6 middle+0x26
> >   inlineloop.c:27 (inlined)
> >             555ce86be9e6 parent+0x26 (perf)
> >   inlineloop.c:32
> >             555ce86bea96 inlineloop+0x86 (perf)
> >   inlineloop.c:47
> >             555ce8672420 run_workload+0x59 (perf)
> >   builtin-test.c:715
> >             555ce8672b03 cmd_test+0x413 (perf)
> >   builtin-test.c:825
> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/machine.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 5b0f5a48ffd4..e76f8c86e62a 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2423,8 +2423,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
> >  	}
> >  
> >  	if (callee) {
> > -		/* Add LBR ip from first entries.to */
> > -		ip = entries[0].to;
> > +		/*
> > +		 * Set the (first) leaf function's IP to sample->ip (the
> > +		 * location of the sample) but if not recorded use entries.to
> > +		 */
> > +		if (sample->ip)
> > +			ip = sample->ip;
> > +		else
> > +			ip = entries[0].to;
> >  		flags = &entries[0].flags;
> >  		*branch_from = entries[0].from;
> >  		err = add_callchain_ip(thread, cursor, parent,
> > @@ -2477,8 +2483,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
> >  	}
> >  
> >  	if (lbr_nr > 0) {
> > -		/* Add LBR ip from first entries.to */
> > -		ip = entries[0].to;
> > +		/*
> > +		 * Set the (first) leaf function's IP to sample->ip (the
> > +		 * location of the sample) but if not recorded use entries.to
> > +		 */
> > +		if (sample->ip)
> > +			ip = sample->ip;
> > +		else
> > +			ip = entries[0].to;
> >  		flags = &entries[0].flags;
> >  		*branch_from = entries[0].from;
> >  		err = add_callchain_ip(thread, cursor, parent,
> 
> LGTM. Thanks.

Next time please express that with an Acked-by, that way b4 will collect
it.

I'm adding it this time:

Acked-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

ok?

- Arnaldo


