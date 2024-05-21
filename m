Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800C208DA;
	Tue, 21 May 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320759; cv=none; b=UedERdfQFY/8IAEsgDVKZN/xABpTeWmkh6ruMm4BAuDhTY6u/gQjOeTQkIgsd98cUtm85lIj5cWwO9Iv4AaEOgtWShnlRfWKsPlTD5D9CYuNTTaRaDdPcbhTjUtn/MC8ueZs8hrvRls0oHBLDxTcEaCjFS6yzapwIaBCp/GeKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320759; c=relaxed/simple;
	bh=0p50TxWeuKVV+sR+6J8Ck7CfuXv5gfWjV85pFForRUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7M6VQaKwV38YAh9cErcufStk70qGepHbIHQW/jYSL7bpOTFKiCTJg/FszgEgKJYDNZpd7rYIlSYMPwD2OkjY7/5rw91A+95xC7ZcAwdiFrk47qF257PNLrVawgl6R4vhyYp8ltTgaQFpgF8RYHrJSFzG/OWLIdW7w+m3hXuXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upvdvzah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upvdvzah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37826C2BD11;
	Tue, 21 May 2024 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716320758;
	bh=0p50TxWeuKVV+sR+6J8Ck7CfuXv5gfWjV85pFForRUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upvdvzahWfv8fs44zqgXihhgcg4km/sfEClY0rSg7DVyjwztEzFP48ET70RWDRkba
	 EQPvNmr+uxxjCrLSeW1FodEc7hBIplkXnUxNcKh1gm0+72gSs/69WzIUcRlxWjt+lg
	 ujKb421AWpgXc4uncqBWkbrSRZtO3DcVJlkZglrqFTxKTPO8pqZh9x9uJxmXfxaUX5
	 31exZPCzkuJa1EjxmntXJfstuiLw42zlN8umlFV8+wjcvRLGU5aO22etRiIg26fRUq
	 DhCh3bQ+GVywor3jheDUamQOsx/hu0gsXcXr88un1EMbSWBV/G+W2WntECk15lRUK7
	 Z+G37cAHRoV8g==
Date: Tue, 21 May 2024 16:45:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the
 default
Message-ID: <Zkz585EIxBwoP4OZ@x1>
References: <20240516222159.3710131-1-irogers@google.com>
 <CAM9d7chsZ3EDRYW=YEJBd7wCYRLWNqMOFt33C=ghaY_UqZvGKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chsZ3EDRYW=YEJBd7wCYRLWNqMOFt33C=ghaY_UqZvGKA@mail.gmail.com>

On Fri, May 17, 2024 at 06:25:16PM -0700, Namhyung Kim wrote:
> On Thu, May 16, 2024 at 3:22 PM Ian Rogers <irogers@google.com> wrote:
> > Instead of decaying histograms over time change it so that they are
> > zero-ed on each perf top refresh. Previously the option '-z', or
> > pressing 'z' in tui mode, would enable this behavior. Decaying samples
> > is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> > the default and rename the command line options from 'z' to 'Z' and
> > 'zero' to 'decay'.
 
> While it may make more sense, I'm afraid of changing the default
> behavior.  I think we can add a config option for this.
 
> Also instead of adding a new option, it should be able to use the
> existing --no-zero option.

Hi Ingo,

	What do you think? -z and the default to decaying is in 'perf
top' since the very beginning, when it was called kerneltop:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0143bad9dbf2a8fad4c5430562bceba196b66ea

Cheers,

- Arnaldo
