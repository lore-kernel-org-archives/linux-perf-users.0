Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EBD12E5D;
	Wed, 21 May 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848371; cv=none; b=K58GDaKQLTm9Y4Z5C1cABZgbr/QIbTqn9hQzGv1SWIasOHcXQErwCtIMyEtD1d49fRPBa6w3te26x2/s/f7XR0Sd8AP64HwILLEJ2dS7VeDluAiJ1HQO82r+D9O883Uk0xmDZLqyRSMGaNDwjgR66/yS5XFRV8M6UwPx4PL/Cjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848371; c=relaxed/simple;
	bh=iDmqZQGNMVKU+cuZqTBGhWkqN9SOiLkBoPy5AWJdavg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihWiju14N45ffIk5ZWulznVD6PnaNP6tGbydhvyac4uDJoE/ldsagFyrJltqph9nmrCCAuiKOdH/M6+Zp39yXCvDRMoeeCtzWn4pbv9aZVbMa5U/O2S/ASTUbPgjij+PGpmBFVhs5XzDC1isx1SpAdaib5ovQaOrMWjD9DA6iDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBzsPo3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBzsPo3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CCFC4CEE7;
	Wed, 21 May 2025 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747848371;
	bh=iDmqZQGNMVKU+cuZqTBGhWkqN9SOiLkBoPy5AWJdavg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBzsPo3q/bjv1B0VZ/SwzCpD916P2m8SqwKk0FvTT3ioA5B4bR5ONWcxsEAL6eZPS
	 lNyPNL7KPVlEkFYmhxYu0In13LEbGK7AV0f6aJ161mSNqjf/IA06RoDWnV4qhPJiMN
	 wuP3Jz8EKLGLjLjSU22KCLalEYxSwtmpqBvlLDD2ai//c4T1GBdEARAmU6vmURHrna
	 HWOCezN1br+Ys+DOGY6kLlxkn2USx2BuxhE0wqEOi+zS+luZolsueOsnktvMschRPL
	 aaMYDgFm0VR7UYPwf6dNammozgMPd1ocO5fL4cYUBMAGJUXgmltzk8v9K0D8Ozf79G
	 f7/DNk5MRU9wg==
Date: Wed, 21 May 2025 14:26:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 4/7] perf python: Add support for perf_counts_values
 to return counter data
Message-ID: <aC4MsLuemgbUiqOk@x1>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-5-irogers@google.com>
 <aC3TMl2MJL1_BASE@x1>
 <CAP-5=fXXbpqQcFj-SUVWAQrmzWhnLNVU=3MiChdCqv4YpiGYGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXXbpqQcFj-SUVWAQrmzWhnLNVU=3MiChdCqv4YpiGYGg@mail.gmail.com>

On Wed, May 21, 2025 at 06:56:44AM -0700, Ian Rogers wrote:
> On Wed, May 21, 2025 at 6:20 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, May 19, 2025 at 12:51:41PM -0700, Ian Rogers wrote:
> > > From: Gautam Menghani <gautam@linux.ibm.com>
> > >
> > > Add support for perf_counts_values struct to enable the python
> > > bindings to read and return the counter data.
> >
> > This (and another one in this series) are coming from Ian, that didn't
> > modify them, so we need a Signed-off-by: Ian, as per:
> >
> > Documentation/process/submitting-patches.rst
> >
> > ---
> > Any further SoBs (Signed-off-by:'s) following the author's SoB are from
> > people handling and transporting the patch, but were not involved in its
> > development. SoB chains should reflect the **real** route a patch took
> > as it was propagated to the maintainers and ultimately to Linus, with
> > the first SoB entry signalling primary authorship of a single author.
> > ---
> >
> > I'm adding them to my local branch, please ack this,
> 
> Ack. Thanks and sorry for the work, will try to do better next time.

Thanks for confirming,

- Arnaldo
