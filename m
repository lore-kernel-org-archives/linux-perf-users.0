Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC21DE4D4;
	Thu, 12 Dec 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029586; cv=none; b=PoLdZXxQNaEuJdi/UpsGoMbEmCcHSAWiSJC86wtoGz34nprr8Z24c3MusL0RNNCF5OcSPNrzfqMkclECCoO7KaR+kTMNLXO5zO5/MhemPUCFSAa+kezlXY/rS+lTQ6hoSAiOnEahuuR/YzM8ixp00mntYJxYf2TqUca2Lqj18Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029586; c=relaxed/simple;
	bh=BHxnz/ZuGaoyXkYzRJJYhHFoUf9bxqFSTCwoEoQ6K8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oopoJyRYIUmu3jRPMqBFnqdMbchC1MFyp6dSDuB2cg2Xi4tNTdQoJVw+fLyTLamFv+2yeCw8HomK5wsJpIzIHwPrbMQ535RpQ3ZFEThnvebYxZcfXhr1AajBgV6Luwcs3ip3vHyBf605F7dJ9XDmgRs3OlYGm+KcJcP6n0G4PA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbk2RazC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbk2RazC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9BFC4CECE;
	Thu, 12 Dec 2024 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029586;
	bh=BHxnz/ZuGaoyXkYzRJJYhHFoUf9bxqFSTCwoEoQ6K8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbk2RazCjVg+911bJxS46cCaMPd92Ibstc7Fba+ayEhk/EST0iwWhAA1i0j1Cnlxp
	 poorKNvy8ZHIKNd3YTyYtCSAkxZ4rjnt0KknlXd2scRVIZ2MAhj9fKfFxhkH5e0kmZ
	 TWnX7hvb8/A0cF+VwJ0ftHaIJfdDOFstHSTj5/FTQmAssePc9fk3dDBH8VFmAH3dLv
	 GBjkB0dCPB1fH7qRhfzkpmnQKF905SpRIyk/YdxyRAEawsaOR5UofNDnPEmCZ9MjpG
	 n8yAyRETlalnbsmrqNKIHU+xRyLip3AF86mfo1cQ+w3drhcQkUXObwrzMN8nZRAoOB
	 e7jd8MIQevuCQ==
Date: Thu, 12 Dec 2024 15:53:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64: Update N2/V2 events from source
Message-ID: <Z1sxD-lvXnFKVy3q@x1>
References: <20241120143739.243728-1-james.clark@linaro.org>
 <CAP-5=fWeJYf4mbSKSonwNhc5smw6_OktRBG2bCObcQiDjy2iAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWeJYf4mbSKSonwNhc5smw6_OktRBG2bCObcQiDjy2iAQ@mail.gmail.com>

On Wed, Nov 20, 2024 at 10:31:55AM -0800, Ian Rogers wrote:
> On Wed, Nov 20, 2024 at 6:38 AM James Clark <james.clark@linaro.org> wrote:
> >
> > Update using the new data [1] for these changes:
> >
> >   * Scale some metrics like dtlb_walk_ratio to percent so they display
> >     better with Perf's 2 dp precision
> >   * Description typos, grammar and clarifications
> >   * Unnecessary metric formula brackets seem to have been removed in the
> >     source but this is not a functional change
> >   * New sve_all_percentage metric
> >
> > The following command was used to generate this commit:
> >
> > $ telemetry-solution/tools/perf_json_generator/generate.py \
> >   tools/perf/ --telemetry-files \
> >   telemetry-solution/data/pmu/cpu/neoverse/neoverse-v2.json:neoverse-n2-v2
> >
> > [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-v2.json
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
