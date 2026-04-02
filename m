Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B481A294;
	Thu,  2 Apr 2026 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088481; cv=none; b=sm93sagy7z7X5HxdjZDeq4uvi3uVOaMjFu+7sr/iB/nwgf47TZmN0YlLsnhPCZYi+tv4zsMTUM10bh5fknx3RvEoIQm+c3hsqqfcAwtZmvyo+BRBVgYrnBeMw7Eqy+BES9sDclV38iECMSjlB4tsFvU3Nj0Rk80DDPTKwme5A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088481; c=relaxed/simple;
	bh=BVoTrSB43B3mD7g1zDt80G3wbfL9wPB6xIf01UUki+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r70tWXC93ED4M07kWf43+j+tVgxFJA4AgdNiRPqcdWPPnR7tq0Huj8Qf8xhrf+VtbrDb9Vx1SMiY1qlgyu9wF0Dxxl1CdHT5sgM6QugAM1Z3NF5h8CV7Kobid3ah4eA8V5Xt+Hx8R0OkyFrTHRRK+Z8m9Fr1CcEz5MQgIlxSJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbYjcCbS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbYjcCbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BD8C4CEF7;
	Thu,  2 Apr 2026 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775088481;
	bh=BVoTrSB43B3mD7g1zDt80G3wbfL9wPB6xIf01UUki+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbYjcCbShCezy/KNWaijH6ppPLry4kUmJEi9RzqQprW1ehc4epo98zUNotcd1Tqcm
	 UZr11+YFPiIiODK+1EwXs4goYI1BWmmhPk0yAzD1TQHFJr0e9E+Jh7IzGbXKWjWHRG
	 0Up1mF7REi6gKlk7sI64YrTpiN2gPZK1/d7cWl/2HOg3TUi5PEzHms3YJ56c1G2THx
	 OyELEVh5H4thctdQ0yMchbtUf7jc5YumZG4fYXT5142haJt9O5D8YnCmtpBB+eF1fy
	 zlHe/KKCluZntAzLAxUGjiyFt5vYsfU9W+kQerK8BghGs6PXHbehyX46Am+aio9/7f
	 cRHP96EA6xvUA==
Date: Wed, 1 Apr 2026 17:07:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, Chun-Tse Shao <ctshao@google.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on Emeraldrapids
Message-ID: <ac2zXqAgWqKqdSyr@google.com>
References: <20260212223942.3832857-1-ctshao@google.com>
 <bb9a1471-6996-47e9-a81e-8de58ab32fb2@intel.com>
 <CAP-5=fXFzmKx+buppcNBQWhEP2UyCobPwYRC-L-unpmDL=2_Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXFzmKx+buppcNBQWhEP2UyCobPwYRC-L-unpmDL=2_Wg@mail.gmail.com>

On Wed, Apr 01, 2026 at 09:38:24AM -0700, Ian Rogers wrote:
> On Thu, Feb 12, 2026 at 4:08 PM Chen, Zide <zide.chen@intel.com> wrote:
> >
> > On 2/12/2026 2:39 PM, Chun-Tse Shao wrote:
> > > Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> > > Adjust cpumasks as the logic for GNR in [1].
> > >
> > > Tested on Emeraldrapids with SNC2 enabled:
> > >   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   N0       30        72125876670      UNC_CHA_CLOCKTICKS
> > >   N0        4         8815163648      UNC_M_CLOCKTICKS
> > >   N1       30        72124958844      UNC_CHA_CLOCKTICKS
> > >   N1        4         8815014974      UNC_M_CLOCKTICKS
> > >   N2       30        72121049022      UNC_CHA_CLOCKTICKS
> > >   N2        4         8814592626      UNC_M_CLOCKTICKS
> > >   N3       30        72117133854      UNC_CHA_CLOCKTICKS
> > >   N3        4         8814012840      UNC_M_CLOCKTICKS
> > >
> > >          1.001574118 seconds time elapsed
> > >
> > > [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >
> > LGTM.
> >
> > Reviewed-by: Zide Chen <zide.chen@intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

It doesn't apply cleanly anymore.  CT, can you please rebase?

Thanks,
Namhyung

