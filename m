Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EB2AE6C;
	Wed, 25 Sep 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727244036; cv=none; b=qJiwGrT6zxePNJgMG65H/+aopGxaNZWC1WmL6rkMNTBjzCk+Y7YKO8kJpTLfSXRxOKXAZQCMaTvNifIg7uGasU4ZSnPIk8Mre3E7AdHvW+22clPfFVJswHES5e0HSaU7rQJ68tPUtejmKP83XzgcZDnkigr6QFN2+vDP/UtNC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727244036; c=relaxed/simple;
	bh=a2kUZamx3G6wtAWBvJMzf+1y5KXNDyS621iqqz8/pcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2XoejfG/mmqvDKjGTSsUI0YrlT97ANX44dnA8M6jc3hk2eQ18alKdEcIXkxgUQ5H2XR2iwNkiOkc9svl9niWePLRcxJJsZvlIF3J1DpAImeUXtE9VorzPBxPsioksU75ZEcwv8+y5f6a+Y5ztKWYA3RABlayhh7MwQHW/keQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc4Mzta4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc4Mzta4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C58C4CEC3;
	Wed, 25 Sep 2024 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727244036;
	bh=a2kUZamx3G6wtAWBvJMzf+1y5KXNDyS621iqqz8/pcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bc4Mzta4TydL6KZLckxFiVKNQD+FMAdCa7UCN3VsIUUUBuy2u8VNsNiIPYNNNSbeN
	 YET33M0NDNo60lfZkA5yz+JAq3jjqA9PpeP8Pls7lBzix2I/DkTKiCbHOVA1C+heZr
	 69VS6xsLgAhd+4xPFxNmfZ2lHEgQTC6fr2nUG8uRt/6KflD8cVbh81ORgKZIjDYivs
	 5FvSylLsYWTka8ebY6Ni+B1gaPFJQuw3zQA6FDtx0faXmRIV7k6RSK2iYzB81o2NhR
	 pFAx/CjIB4fjhjHCQleLnkGRPQLcYzTfgaqbWQgkiH6HJ3UzKHtWWpAZxRUl2b34Mr
	 2JKxH7ld3XZ+g==
Date: Tue, 24 Sep 2024 23:00:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZvOnATEtJJQWhThK@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <20240924003720.617258-3-irogers@google.com>
 <de38a809-1968-4d6d-b1ed-1f47e8762ee2@linaro.org>
 <ZvMHfB1f_GbtRqSp@google.com>
 <CAP-5=fXCtcHiA0SgEZNe6KQBq+rFb2b8ar7awjvUiDOB+0M_SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXCtcHiA0SgEZNe6KQBq+rFb2b8ar7awjvUiDOB+0M_SQ@mail.gmail.com>

On Tue, Sep 24, 2024 at 12:47:33PM -0700, Ian Rogers wrote:
> On Tue, Sep 24, 2024 at 11:40 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Sep 24, 2024 at 10:17:08AM +0100, James Clark wrote:
> > >
> > >
> > > On 24/09/2024 1:37 am, Ian Rogers wrote:
> > > > Add missing dwarf_cfi_end to free memory associated with probe_finder
> > > > cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
> > > > tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> > > >
> > > > Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame sections for probe location")
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >   tools/perf/util/probe-finder.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > > > index 630e16c54ed5..78f34fa0c391 100644
> > > > --- a/tools/perf/util/probe-finder.c
> > > > +++ b/tools/perf/util/probe-finder.c
> > > > @@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
> > > >     if (ret >= 0 && tf.pf.skip_empty_arg)
> > > >             ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
> > > > +#if _ELFUTILS_PREREQ(0, 142)
> > > > +   dwarf_cfi_end(tf.pf.cfi_eh);
> > > > +   dwarf_cfi_end(tf.pf.cfi_dbg);
> > > > +#endif
> > > > +
> > >
> > > I noticed that c06547d converted an _ELFUTILS_PREREQ(0, 142) into
> > > HAVE_DWARF_CFI_SUPPORT. But there is still a mixture of both in the code
> > > (unrelated to this patch). The commit message doesn't say why it is better,
> > > just that it could be changed, so I'm not sure which one is right.
> >
> > I think HAVE_DWARF_CFI_SUPPORT is better since it reveals the intention
> > clearly.
> 
> Let's just nuke the conditional compilation, the CFI support is in
> libdw (calling it dwarf is just actively confusing) is 15 years old:
> https://lore.kernel.org/lkml/20240924160418.1391100-7-irogers@google.com/
> https://lore.kernel.org/lkml/20240924160418.1391100-8-irogers@google.com/

Sounds good as long as we checks the version or the API in the feature
test.

Thanks,
Namhyung
