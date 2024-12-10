Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F31E52D;
	Tue, 10 Dec 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836536; cv=none; b=TcvLpuuq/aJNlX6mbJO2zwncItc1Jw8TftUdQd7b7wx6jn/fUFW2M43QrhZJcSUECnNqsj+KUA8y5JgjBzHfcdGNoD56ZfKbFSjz05Jt2UhBpkjrfjky1pb0Tka4GBfOOyTS8NeocmKcu/+PsVD2lw+QZRHhd5iHsXeccyZorMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836536; c=relaxed/simple;
	bh=LqZ03NPt2oqcQSx8/itvDBKprwoopoJ6bbtd6IPULkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kONVb+269slVUqV9hfNv585xUuuvlRaRi0rXeGpcPYae2QF6AOBDYw+NAyRY5xXrYjJqL8ByHHFD+FWBZ7obCpe22JJ45i1PnQP2YVdF9PSqsAjNQ6ha5aRmoBKA3qjzUzXHPIiSBF9qtKWMd9HBZjf4DX1HqMIorVBkECR1ukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abGiSbIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abGiSbIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47BDC4CEDE;
	Tue, 10 Dec 2024 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733836535;
	bh=LqZ03NPt2oqcQSx8/itvDBKprwoopoJ6bbtd6IPULkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abGiSbIXYTeUeVzV1rzdESvB1bPxcjqobRg3RHDsohwthBoJ08rGFjMkX8pVzF2Ge
	 uudnRNisbPn/ICxjtitgnbFn6zQCgm8tBKNnWlvmweCC+2BeUyicRSJlJFyyybydyw
	 cz+0/+tH938AU59c38TQxdJ2fb7EMI9MGf/X8+Hb6TguI30mXMUoH0KoSFMkPsY7aI
	 yR2bKRdLv9iCcX+QaXVKP9+hHXPnfZIm3sbWrNlqWyKEAuc+XUDicQPMUUFErtSzEi
	 9TBcEOQuwO8c2VpbFL91eQXamnxTJzx8opHGZ7BLodIsNOvA7t/QIq4GBSpksT1OvK
	 xD8biU97uku2w==
Date: Tue, 10 Dec 2024 10:15:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event
 descriptions
Message-ID: <Z1g-8ggHQ8MoVNhx@x1>
References: <20241113165558.628856-1-irogers@google.com>
 <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1>
 <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>

On Mon, Dec 09, 2024 at 01:29:15PM -0800, Ian Rogers wrote:
> On Mon, Dec 9, 2024 at 12:28 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> > > On Wed, Nov 13, 2024 at 8:56 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > For big string offsets we output comments for what string the offset
> > > > is for. If the string contains a '*/' as seen in Intel Arrowlake event
> > > > descriptions, then this causes C parsing issues for the generated
> > > > pmu-events.c. Catch such '*/' values and escape to avoid this.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Ping.
> >
> > A fixes: is missing, probably this should go via perf-tools, i.e. for
> > this merge window?
> 
> We don't yet have arrowlake events/metrics, should there be a fixes?

Ok, thanks for the clarification.

> I'm just preparing the patches for the latest vendor json from Intel,
> but they will depend on this. I suspect given the size of the vendor
> json it will miss the current merge window.

Probably best to have big patches via perf-tools-next at this point in
time.

- Arnaldo
