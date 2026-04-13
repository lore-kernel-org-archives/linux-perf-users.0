Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF3347BA5;
	Mon, 13 Apr 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776111605; cv=none; b=Wu6vx+CxHGiznYZFX/vsG8zFeepTzLKRa9tyGy0HJvonPKqtKIkuZz38XS36SxDQnZKeOPkN3nEE1yqVbF/zIoqrmx+SO6TWFiKLNJVUAgjKAzdbVmFWltdOxuJpD3twP5P1RIHW8ccSJJW0Qd6TtZ4vk/RJzhLuM65yYBxQmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776111605; c=relaxed/simple;
	bh=G8pF69hZPR3Py4CbXZwMkXyPMh1Uxl1HYtd3qO/DD28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/m82N6krG8nYP3lCiTZLeT/cW3Oiu+IwlF3QCwPomsgFfvA16bP8cd2QtkV3I7l1XY1ktohHlrXQdx73JoH7dt3P8qyOJewAbLnzZuYttc4sAMNLxJXCakAM3x6coJGLqEDrzNQq+1L1EhL8mIn1qtIv8ftTiMxtmAqzWVXXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUuaXRuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUuaXRuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A63C2BCAF;
	Mon, 13 Apr 2026 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776111604;
	bh=G8pF69hZPR3Py4CbXZwMkXyPMh1Uxl1HYtd3qO/DD28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUuaXRuEjuHwyJxNKfEmtIb4CScfpaQMe3QsG2nhaYURls6LnKGG9XLEQPHo/GLJY
	 SkruKBi1NwGop0UC+p2xLLdV4w7vrTaFrvyFddnB1VZXnMv09ZfvuQXHZEM/QvejX3
	 9TSziJxL3+2TjzkcrLcCmRbUa/v6far/tX+CVaw2f0zH47/NEUWPOJNMuPN0HBaScc
	 0irSTlFYAPBXXKmkkOsSlTK7rNAAaEZe6TRq3Av6rh0GWKYFfgf9eY/KgF5VAgYrVA
	 pyiW+VDTOaXARnMBucmYSDVmyoP0bsYrce5SZQkXkLAl1DABM8hjyyGE0Wk4Wl/+zT
	 BKSPaFyv3SXZA==
Date: Mon, 13 Apr 2026 13:20:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
Message-ID: <ad1P8ebyCyfKwXH6@google.com>
References: <20260411191710.524998-1-irogers@google.com>
 <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com>
 <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
 <ad0cfz-gUKea5bI8@google.com>
 <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>

On Mon, Apr 13, 2026 at 09:57:02AM -0700, Ian Rogers wrote:
> On Mon, Apr 13, 2026 at 9:40 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> > > On Sun, Apr 12, 2026 at 1:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
[SNIP]
> > > > I've picked the first 23 patches to tmp.perf-tools-next as the rest
> > > > still has some issues.  Also I've touched some commits to either remove
> > > > some parts or split them into separate commits.
> > > >
> > > > Please take a look.
> > >
> > > Hi Namhyung,
> > >
> > > thanks for doing this but I've done a similar clean up. To totally
> > > separate the evsel refactoring from the rest of the changes, to fix
> > > the address sanitizer issues with kwork, etc. I'll incorporate your
> > > changes and then resend the series.
> >
> > Thanks, I'd like to merge what's in the tmp.perf-tools-next unless
> > there's a serious mistake.  You can rebase the rest changes on top.
> 
> I'd drop what's in tmp.perf-tools-next. Otherwise we're putting fixes
> on top of fixes. Looking at v12 the sashiko issues are all minor and
> the progression of the patches is more granular and natural.

The goal is to reduce the amount of work (including review) during the
merge window.  Also I don't think there are many fixes in the tmp
branch (have you looked at it?).  I think it's ok to add fixes on top
in this case but I can drop non-conversion patches if you want.

Thanks,
Namhyung
