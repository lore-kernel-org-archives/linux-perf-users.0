Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAC1B85F5;
	Tue, 24 Sep 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203199; cv=none; b=S5o2rgI12IH8cvbFBWEHH6Ke/5Qd4FXRyrbnyJnFcu/lZgVFo7YyF5tRjI1bW73+J6l9aDhjdVso2kVzb84HTrowQy6HXxTNX3apg+lAm1fkYMxxk6RVWVYAQdc0msNe2tnTNUoLvh+AXo8fiEyQw0Ol5nTINGCnJZgHbH9ozLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203199; c=relaxed/simple;
	bh=JhjrFkdpUJYeUmwJD3cUTzagKIJWPAaIKVgloH2Lt0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsVrkvZv0adghBPB71f3zGy//gbbQrSewQjWNC+GRZT721mrqqntNbIEDJbisakpTv2lNWxDmg6kIhGcQfvjda+zjoIX+3UccfPQWe3FkmgB20MUvLraa2+Soh975pPFAupyHZsZj2E2p1TvvDDEdq6GAR9C/w+GARtxtu8/JZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2WzohY5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2WzohY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C83C4CEC4;
	Tue, 24 Sep 2024 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727203198;
	bh=JhjrFkdpUJYeUmwJD3cUTzagKIJWPAaIKVgloH2Lt0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2WzohY5fE/ILL5aSlnmLPAULJcSJWIh5S7Cq7bNRLnhVteMviu5jjnKheRk4MmaG
	 zPzKi1qL2SaiyAhxSMbvqt+mqyqrbdtxTjEAhU//6FYQevf+6ulVSxRkDXuj4nu/Lt
	 vMmpR+PN0DDNR1OVlfx92m+r9/mCUwlTb2CuhB0CiuRaqzwRNwYacVD3ZvxKtBlW35
	 F/DeIXXC3/rBC2f/fqAESBnYQw8qvrigoiT/tsL4kkb2sTk0bxgorVGdvKEB4Zqk47
	 Y27/Lf7TTL3/ydeWyQN3KEWQ4aEO5xRY0IunWBu6AnMYvN+D6CzYymhFFQPfjg6MWR
	 0aD4ZXH2rV0eQ==
Date: Tue, 24 Sep 2024 11:39:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hemant Kumar <hemant@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Subject: Re: [PATCH v1 2/3] perf probe: Fix libdw memory leak
Message-ID: <ZvMHfB1f_GbtRqSp@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <20240924003720.617258-3-irogers@google.com>
 <de38a809-1968-4d6d-b1ed-1f47e8762ee2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de38a809-1968-4d6d-b1ed-1f47e8762ee2@linaro.org>

On Tue, Sep 24, 2024 at 10:17:08AM +0100, James Clark wrote:
> 
> 
> On 24/09/2024 1:37 am, Ian Rogers wrote:
> > Add missing dwarf_cfi_end to free memory associated with probe_finder
> > cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> > tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> > 
> > Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame sections for probe location")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/probe-finder.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 630e16c54ed5..78f34fa0c391 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
> >   	if (ret >= 0 && tf.pf.skip_empty_arg)
> >   		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> > +#if _ELFUTILS_PREREQ(0, 142)
> > +	dwarf_cfi_end(tf.pf.cfi_eh);
> > +	dwarf_cfi_end(tf.pf.cfi_dbg);
> > +#endif
> > +
> 
> I noticed that c06547d converted an _ELFUTILS_PREREQ(0, 142) into
> HAVE_DWARF_CFI_SUPPORT. But there is still a mixture of both in the code
> (unrelated to this patch). The commit message doesn't say why it is better,
> just that it could be changed, so I'm not sure which one is right.

I think HAVE_DWARF_CFI_SUPPORT is better since it reveals the intention
clearly.

Thanks,
Namhyung
