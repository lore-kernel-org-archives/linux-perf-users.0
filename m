Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9E3BB13F;
	Thu, 24 Sep 2026 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272246; cv=none; b=p+uR38rPVYFil4F1bZPT89pszmPLnos3vzZLDtNGfCvEtt75798y+moPX07OhJ8y64WSDmJJwfRBnZTeDO4HsNKrHnAjesTj1Qg6OBxeCAf+5Rxxa462Fb5+j1A/PZbQrnU/iWJ1bJr/zfHJbTN7cV2w+593T9MeYMrkvY5izg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272246; c=relaxed/simple;
	bh=yXTnajMiA2cnyDs0Z+K86mraKjJ/BpC2FWacLv2TybY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsIEUIdQFaYOIPdpVop4okhp9EhMvC4IgHma2S4C8GdzT2YI/UAiOaz8OTDQOhTToTWISHbEKaobNMu/eKMIYBt0mRH76BC+kJUaIR1SZwEfFmCynICHNCG03lYFnInPZRVO3ienmKC8kZlc9yY3FHsKeOHVmDsBSyUxxWBT/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcax6uEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcax6uEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C807A1F000FF;
	Thu, 24 Sep 2026 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272245;
	bh=xvAW5wenuOCDifc3lYRejWUr7WTYlRvWSV6In7YPAVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hcax6uEbKsFzMtGyjIJYWqWWkyW/3BmZRWxc+8ZA+LELUxvKMxRGhM+oI9cvLai/T
	 JU3mVFEfPtSDjRJNr7wM5F+Z3PnpAvaWCjn5Q7Er4NvD3lvS+LNxIxRxd6YKGMF37R
	 WHeOGS0Bf0m/F6FsvV/GPOGPZJBlN13XY8pqSCK9LmNyT79CYMiQrQI5q/dQA0RL1p
	 YP8BOlzEgoepG5eWSY8qi5PfG+O4ZrwOrzKpm2XsCeYYaiSMXB4lr33t4gF+JWv9gW
	 tt+8fyzi8YXrNSypTpltLgbhIcIR3MuQ+hLyxEsLQieioTEfcXSrXS2j62RaizW3FO
	 JxnQ3EoCOhzow==
Date: Thu, 24 Sep 2026 19:50:42 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf test: Improve shellcheck source directives
Message-ID: <arVi8iy821vO44tO@x2>
References: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
 <arGXoU4idVCKb2cC@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arGXoU4idVCKb2cC@google.com>

On Mon, Sep 21, 2026 at 01:46:25PM -0700, Namhyung Kim wrote:
> On Mon, Sep 21, 2026 at 04:47:27PM +0100, James Clark wrote:
> > Confusingly two things turned out to be relevant to this. One is that -a
> > doesn't make shellcheck follow "external" paths, which these are treated
> > as. You need -x for that. Secondly, the source= directives don't cause
> > it to follow the path either, they just suppress a warning message about
> > dynamic paths in versions of shellcheck before 0.7.2. This warning can
> > be silenced with "source=/dev/null" and doesn't require any particular
> > path to be provided if -x isn't used.

> > James Clark (2):
> >       perf test: Remove redundant shellcheck source paths
> >       perf build: Follow sourced files when running shellcheck
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
