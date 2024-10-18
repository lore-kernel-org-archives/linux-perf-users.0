Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777E1C242D;
	Fri, 18 Oct 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269322; cv=none; b=tBP/FdtLu5jcrzUPk2vqN8imOBnnJVYXEG7BI8v91CWldtLOYYJVtWw7gJ/EeofKPLif99zpv+xEg7gdTxzbjk45KMYeeAD91w/k0kmwzoCOtAq18hqO95I9Ggdvt43SEoZt43vb27aZwXRUO7eznqrcpbzJxVD2xdsDINSUXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269322; c=relaxed/simple;
	bh=GCN0i52mR6QUgIuHTBbZ/IqnAgAAzJDouqXnbtgMwtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX9GQ6M7hcyYxS3eWLH7HXL/pqCzwWC1cO5vsKvtJCGbRC8Mq7GctKwnVxek1uUJQBjWllRdnok8IiUQCEeW9IimPo8PbNTJnt2m81j0OSYWfD/3+sIe1Sk7Zg10vuZ0V/rs2cgb/NppQ7cStFtCM3Z9ZPu2r/IzvZEn71NKAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie2i1GKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie2i1GKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C19BC4CEC3;
	Fri, 18 Oct 2024 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729269322;
	bh=GCN0i52mR6QUgIuHTBbZ/IqnAgAAzJDouqXnbtgMwtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ie2i1GKS/hngCx9bd58DvgRcSPbDsALfCMhWie0NP/x+GuEVjccuaupSAPC5g/4nT
	 8QIvD0pJtHnHt2pP2XU0AI9ZHtRO3ElRMP2HEIBwjSCnE5pybTbNyVZD/BVK+V1BfS
	 zrozbV0x/xeBSh+jeM8MJ+MZlZx8VtIpmuloCrtJDdGARg1XEACKcSXM/0BQHoOj/U
	 V3mWkZSV9CyimUpfnz2M1QRDOCjTd9y+33J6HgcZUELj7Wv0DdwYmBcVOxDpKlvNcL
	 9FOzEKtsLjXz8GQ2ifHgsdKg6XJPOjM4w7bqcGf/jQ+oO+pL5MDWV7rxzkhe9d5j5f
	 jGDM7YHo9R4XQ==
Date: Fri, 18 Oct 2024 09:35:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] CSV/JSON metric thresholds, fix printf modifiers
Message-ID: <ZxKOR_Mr0xQFy_FN@google.com>
References: <20241017175356.783793-1-irogers@google.com>
 <ZxFVYvDTtmz_JbMU@google.com>
 <CAP-5=fVicsN1_k5nycOzHnRxdmwdEk9Y==OSAaxdDL5wnX7_jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVicsN1_k5nycOzHnRxdmwdEk9Y==OSAaxdDL5wnX7_jg@mail.gmail.com>

On Thu, Oct 17, 2024 at 12:15:26PM -0700, Ian Rogers wrote:
> On Thu, Oct 17, 2024 at 11:20 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Oct 17, 2024 at 10:53:49AM -0700, Ian Rogers wrote:
> > > Metric thresholds are being computed for CSV and JSON output but not
> > > displayed. Rename the color that encodes the threshold as enum values
> > > and use to generate string constants for a json dictionary
> > > value. Disable metric thresholds with CSV output.
> > >
> > > Add printf attribute to functions in color.h that could support
> > > it. Fix bad printf format strings that this detected.
> >
> > Thanks for the quick fix, I'll take this.
> >
> > >
> > > v5. Switch some u64 printf flags to PRIx64 rather than llx (kernel
> > >     convention) to resolve 32-bit build issues.
> > > v4. Drop CSV metric thresholds due to formatting variation on
> > >     hypervisors (broken counters) and not as detected by
> > >     tests/shell/stat+csv_output.sh.
> >
> > I'm ok with dropping CSV support for now, but could you explain
> > a bit more detail about the problem?  Is it possible to see the
> > same problem on host if it has a unsupported event?
> 
> It would be. The issue is the stat-display code being a rat's nest and
> adding a column to CSV should be straightforward but causes --thread
> to behave in odd ways with an uncounted/unsupported event. Where the
> column counts differ from supported to not supported causing the CSV
> stat output check to fail. Fixing one issue leads to other issues and
> my usual desire to rewrite stat-display which can wait for another
> occasion. Here I'm trying to address that we may compute the metric
> threshold, use extra events, but then never even show the output.

I'm curious how it loos like.  Can you show me an example in both cases?

Thanks,
Namhyung

