Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA71AB6CC;
	Thu, 12 Dec 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037259; cv=none; b=Xu4xoH3aNsh7ECTCu9Wd0J0zShsvDshn2/SN/2sI4omSNakmt5xdjoN34SEjmApRUGjZi617pvVkhrTvnBd74yQMBL4TrzfZohmH5rNt/xyL9ETMjrgz6xJoUQFSsVeUFkiGERj0QqQTI5lpmXlTowFXCKiKr+PPsdmLQyRcK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037259; c=relaxed/simple;
	bh=F2C1jSuGEivYzOLyd+tu0wp65wj7EUbR0WwjJ65VuAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShD43epDEDgDHODPlwlmxGGkiryzrfJt9EsSJHTXO9tcyqWLtIPhqWXZefkERm3FmD5QXISIYr8HnbRmRc2DDI19WR16SRsrJwKH2eXG3GoC5Pye88QVzsU/pSWLPBa2mimAFDFYh2hCpy0bndPdlHe3HmGNLXIia8snqtd3n5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJMbw7XN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJMbw7XN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D264EC4CECE;
	Thu, 12 Dec 2024 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734037259;
	bh=F2C1jSuGEivYzOLyd+tu0wp65wj7EUbR0WwjJ65VuAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJMbw7XN4PA7G9WBzGPKjGHpPxQX1jgxzNcEF+H9m5k/dVPGmB6zbmcSNox3M7FZ3
	 HYCt+Z2GCSs94miZN4qh+fyyRVUKT3uwB4Lafpv9SGZoJMDxVIRVujhp8LMq+cLvlu
	 ou0NYfVQhiDDhOzTwERDb50pQ11TAACqqZ2R3s6f+HMpe9jHfhDUnuV+g0Zj5fBy5L
	 4sQLz7UDrOMsH/6+j1/JdXklXYOKkf1Bc2swEsVoitTevHmM5Fe3E++m3BLjcaspLc
	 BGI7tTU/+mlWW/HElJ4cOsg31x0Td5D9unED0HaXzAjTk/p7MWq8aqazTVva6LyRvs
	 OQzJVnhsgId9w==
Date: Thu, 12 Dec 2024 13:00:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
Message-ID: <Z1tPCfRTkC5BjZq0@google.com>
References: <20241127212655.922196-1-namhyung@kernel.org>
 <CAP-5=fXtL-MFW5YW=5WsYNftCAj7MaXVwN8R3veuiODiC85bdg@mail.gmail.com>
 <Z1suPi7XLncFKtG4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1suPi7XLncFKtG4@x1>

On Thu, Dec 12, 2024 at 03:41:02PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Nov 27, 2024 at 04:51:15PM -0800, Ian Rogers wrote:
> > On Wed, Nov 27, 2024 at 1:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > The sample data is 64-bit aligned basically but raw data starts with
> > > 32-bit length field and data follows.  In perf_event__synthesize_sample
> > > it treats the sample data as a 64-bit array.  And it needs some trick
> > > to update the raw data properly.
> 
> > > But it seems some compilers are not happy with this and the program dies
> > > siliently.  I found the sample parsing test failed without any messages
> > > on affected systems.
> 
> > > Let's update the code to use a 32-bit pointer directly and make sure the
> > > result is 64-bit aligned again.  No functional changes intended.
> 
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>  
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Looks good, applied to perf-tools-next since this is something that is
> not new nor looks urgent.
> 
> I think that since we have multiple maintainers, one for not urgent
> stuff/development and the other for the current window/urgent stuff,
> that we should express the expectation about where a patch should be
> processed, by having on the subject the tree the submitter thinks should
> take the patch, i.e. for this one:
> 
> [PATCH next] perf tools: Avoid unaligned pointer operations
> 
> While for urgent stuff we could do:
> 
> [PATCH urgent] perf tools: Avoid unaligned pointer operations
> 
> wdyt?

Looks good.  It'd be really great if contributors can do this.

But I also think 'next' should be the default so only 'urgent' would be
specified if needed.

Thanks,
Namhyung

