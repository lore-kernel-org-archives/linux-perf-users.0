Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677191A0B0E;
	Fri, 20 Dec 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734727048; cv=none; b=ESYu/jHIQj8VPT1SwFqVlMu0uMUvzu9cnKyuc/g4diIu6m/DRVE0QFuywjV0BGa8rU6XldUF3CfyjDigS1FvGecdGjCbwM1q2gE113jwhAbO6+hvibRY3jBxAHB9sKNgpF5s6AlZfEr/3x5ZD5a/NeuQRU/un5w7r7BcwbFVYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734727048; c=relaxed/simple;
	bh=hSv76l/OwplbhDsdD6KQYnxF2rvcMBHDYBHOsX2XRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy7QO858eziqY8aM7Dwo0J1b6/lebrVskSFI1/Ym241HsU+9ZobfI7g/BFwuO8wUtus45+g74UIJi0LrnjvIFdLSxAmo0PHicmVakaD53279j8creueeXOlSWjT9JkSWu2206a9qT+iernMKZm+hrfhxTCTeJB+4SV3VIxp3Sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Birqv+Tm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Birqv+Tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D8FC4CEDE;
	Fri, 20 Dec 2024 20:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734727047;
	bh=hSv76l/OwplbhDsdD6KQYnxF2rvcMBHDYBHOsX2XRuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Birqv+Tmf8TVKmu43fUllC2rrlHb9u/rZ8HpH4nRsdEyFm2yjqX+mRbaisffLoBx4
	 Z85txYBWDqHsJnXt0yVCjykh3kqojOtmGLgAwEpXnEG6HjLMcVA529zozFLPhA/8xL
	 7Q0zHO3FWidfGpLt+kiVbVKtUYt6ytD720bOQ7M+bzB1ft15pU7s+AjrH3C1HvVZ72
	 9fqdzt7K7WjloGJpXEWxZgtNH75KGe6c16ilhOaf9XfT61cfg6OPb4J1ydgvsy3jv/
	 urkigZKc82qsGzpHmwrJjwnOvEMkMWLhYM+X1aI683bl6GX6r+ljHnzMj5XTwOiS5K
	 ACqhjVPQFYe7Q==
Date: Fri, 20 Dec 2024 17:37:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH v3] perf script: Fix output type for dynamically
 allocated core PMU's
Message-ID: <Z2XVhey0Xg5yYoQa@x1>
References: <20241213215421.661139-1-thomas.falcon@intel.com>
 <Z2XCi3PgstSrV0SE@x1>
 <d730cfe63cdd46c137630d27de32e3b9c0ab6268.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d730cfe63cdd46c137630d27de32e3b9c0ab6268.camel@intel.com>

On Fri, Dec 20, 2024 at 08:30:11PM +0000, Falcon, Thomas wrote:
> On Fri, 2024-12-20 at 16:16 -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Dec 13, 2024 at 03:54:21PM -0600, Thomas Falcon wrote:
> > > perf script output may show different fields on different core
> > > PMU's
> > > that exist on heterogeneous platforms. For example,
> > > 
> > > perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=0xcd,\
> > > umask=0x01,ldlat=3,name=MEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> > > -c10000 -W -d -a -- sleep 1
> > > 
> > > perf script:
> > > 
> > > chromium-browse   46572 [002] 544966.882384:     
> > > 10000 	cpu_core/MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142\
> > >  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A   
> > > 5   7    0   7fad7c47425d [unknown] (/usr/lib64/libglib-
> > > 2.0.so.0.8000.3)
> > > 
> > > perf record -e cpu_atom/event=0xd0,umask=0x05,ldlat=3,\
> > > name=MEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
> > > 
> > > perf script:
> > > 
> > > gnome-control-c  534224 [023] 544951.816227:      10000
> > > cpu_atom/MEM_UOPS_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown]
> > > (/usr/lib64/libglib-2.0.so.0.8000.3)
> > > 
> > > Some fields, such as data_src, are not included by default.
> > > 
> > > The cause is that while one PMU may be assigned a type such as
> > > PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot
> > > time.
> > > If this value does not match an existing PERF_TYPE_X value,
> > > output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
> > > 
> > > Instead search for a core PMU with a matching perf_event_attr type
> > > and, if one is found, return PERF_TYPE_RAW to match output of other
> > > core PMU's.
> > > 
> > > Suggested-by: Kan Liang <kan.liang@intel.com>
> > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > > ---
> > > v2: restrict pmu lookup to platforms with more than one core pmu
> > > v3: only scan core pmu list
> > > ---
> > >  tools/perf/builtin-script.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-
> > > script.c
> > > index 9e47905f75a6..685232883f9c 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -384,6 +384,19 @@ static int evsel_script__fprintf(struct
> > > evsel_script *es, FILE *fp)
> > >  		       st.st_size / 1024.0 / 1024.0, es->filename,
> > > es->samples);
> > >  }
> > >  
> > > +static bool output_type_many_core_pmus(unsigned int type)
> > > +{
> > > +	struct perf_pmu *pmu = NULL;
> > > +
> > > +	if (perf_pmus__num_core_pmus() > 1) {
> > > +		while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
> > > {
> > > +			if (pmu->type == type)
> > > +				return true;
> > > +		}
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > >  static inline int output_type(unsigned int type)
> > >  {
> > >  	switch (type) {
> > > @@ -394,6 +407,9 @@ static inline int output_type(unsigned int
> > > type)
> > >  			return type;
> > >  	}
> > >  
> > > +	if (output_type_many_core_pmus(type))
> > > +		return PERF_TYPE_RAW;
> > > +
> > >  	return OUTPUT_TYPE_OTHER;
> > >  }
> > 
> > Can you please test the patch below so that we don't do this while
> > loop
> > in all calls to output_type when we have more than one core pmu?
> > 
> > I haven't tested this patch, so please see if your patch on top of it
> > produces the desired result.
> 
> Hi Arnaldo, it looks good to me.

Thanks, added an

Acked-by: Thomas Falcon <thomas.falcon@intel.com>

To that cset,

Doing some test build test accross a number of distros now, will push
that out and then try to see if your patch applies cleanly or do the
adjustment to apply it.

- Arnaldo
