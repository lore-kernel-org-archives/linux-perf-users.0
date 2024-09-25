Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF101547E3;
	Wed, 25 Sep 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243759; cv=none; b=rnFuIMbyk8FGcvyURBnETK4GuyW0rNDOk74AxnA8+iehEipxp9tGp5H41PNEA8ry+zn6v5PMBANYhOC8LeBFwAXaFik5Q7lyY7168pWY/nKxPXAivqN4rHTl6FekVaa3HvuD/B0EHPt4BVezzWnpLEKgVi3xvRR4tpF4GZVC2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243759; c=relaxed/simple;
	bh=gHzQSJC7kXWp+c4NYxRoj/Qi61D5q7sBNT8Rm5u9/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvz8asW2aiweZDtKolYRn17dSi+5QkOPYc/CfHUW6GTyy6MhHE2cToEyJqq358utszJmS6cjG7C8OQZESofU5+fK+qFP+6ZnrcLAmNQiAI98AfdTp2zxibT+urfCcCotczAmVYNg/zJ/TSu1KMksR5c7XkhoU2zyOorb/lt0JuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8QE/Zdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8QE/Zdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4086AC4CEC3;
	Wed, 25 Sep 2024 05:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727243758;
	bh=gHzQSJC7kXWp+c4NYxRoj/Qi61D5q7sBNT8Rm5u9/p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8QE/Zdi/WLDvWukNfEPK6kWqA7ptbBmx8M0zUxYDSPTW9UM1Dj/oay51pxnjJalf
	 rMZv5PPbA15f0brCWfifgp+trIgA74DSvaq5qKBgwQbT47HhQexhvPbeK0tncmi9ux
	 de/GmhjkLmQDm8bND2cKlHFeuKOH4EDdLS5WNCoDWFAmNv/kETeN0e9M/THKmSPtq7
	 +nEAgIncGdhSzC6WOi6ytMt0l0R6lJohIp4x/lO7ig9cOnNdUHX5A46ZNpm0RdurF9
	 ztd5q1DPTVo4bdyNRxa0rGMQadynogDHb2GniLMKZsEVgtt5hmdYyvHHMZ7lxl58Y7
	 5N/cN4RT8SmrQ==
Date: Tue, 24 Sep 2024 22:55:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Monakov <amonakov@ispras.ru>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf symbol: Set binary_type of dso when loading
Message-ID: <ZvOl7NOloeSn50ZZ@google.com>
References: <20240426215139.1271039-1-namhyung@kernel.org>
 <b9a82437-cd4a-5331-47da-b0d1640169d7@ispras.ru>
 <ZvOkj-USs2PRXxsH@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvOkj-USs2PRXxsH@google.com>

On Tue, Sep 24, 2024 at 10:50:07PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Sep 20, 2024 at 08:04:00PM +0300, Alexander Monakov wrote:
> > Hi,
> > 
> > On Fri, 26 Apr 2024, Namhyung Kim wrote:
> > 
> > > For the kernel dso, it sets the binary type of dso when loading the
> > > symbol table.  But it seems not to do that for user DSOs.  Actually
> > > it sets the symtab type only.  It's not clear why we want to maintain
> > > the two separately but it uses the binary type info before getting
> > > the disassembly.
> > > 
> > > Let's use the symtab type as binary type too if it's not set.  I think
> > > it's ok to set the binary type when it founds a symsrc whether or not
> > > it has actual symbols.
> > > 
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Any chance this can be applied and propagated to stable? Annotating
> > functions outside of the main executable is broken otherwise (regressed
> > since 873a83731f1c ("perf annotate: Skip DSOs not found")).
> > 
> > Tested-by: Alexander Monakov <amonakov@ispras.ru>
> 
> Thanks for the test.  For some reason, it doesn't seem to be merged
> while patch 2/2 is.  I'll add this with above information.
 
Well, it actually needs to go to perf-tools tree.  Arnaldo, can you
please pick this up?  It should have this too.

Fixes: 873a83731f1c ("perf annotate: Skip DSOs not found"))

Thanks,
Namhyung

> > 
> > > ---
> > >  tools/perf/util/symbol.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > index 7772a4d3e66c..63936269ec15 100644
> > > --- a/tools/perf/util/symbol.c
> > > +++ b/tools/perf/util/symbol.c
> > > @@ -1927,6 +1927,9 @@ int dso__load(struct dso *dso, struct map *map)
> > >  		if (next_slot) {
> > >  			ss_pos++;
> > >  
> > > +			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
> > > +				dso__set_binary_type(dso, symtab_type);
> > > +
> > >  			if (syms_ss && runtime_ss)
> > >  				break;
> > >  		} else {
> > > 
