Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE5223323;
	Tue, 14 Apr 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145866; cv=none; b=YRAPBsXd9oNOYS6YqSz5IN9DlPYeDQT2s38AdmL23PbH0r7v7iSowAkuUI5FcKqh4u10nWVID/86tLowUUiyMBxAV6G6G9yM93Z+UKvRQRM7ouV7jSwYMBSztEmA3NPZ/YqAM8hyNsGMXaxdXgb1x1C0S9nmNWV4fhB2ch7lqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145866; c=relaxed/simple;
	bh=NWmyIt82aJGIhkA9bM5kw0zrXESL/v4qMM/khKZiXN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oShfOl1+XqHtHvhANe0F54j24Z/+JDzzlqnosbqWtcaJkbrGPUWvEoSijxSWpGBXaRXqHzwCbGzUBuD+VkA1kOU2RjguSsw3nI+jHBoE/5UaK7jpHK+TwA4pxUMZHYdBvsllcwVZc+N6FRtrktpCZYOzl/6nsGZtaKNa57Dzh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZynjR6lS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZynjR6lS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988E5C19425;
	Tue, 14 Apr 2026 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776145866;
	bh=NWmyIt82aJGIhkA9bM5kw0zrXESL/v4qMM/khKZiXN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZynjR6lSaJm6q7dSxF7ZRsbZ72q5bwCKXCZTN6KubqmGa6hW8ZJIFnkGfCvWWPeBK
	 0icYGKgW/JKRbyU4q6dJABr80t7kqoNjzT2wPgnWmgw3xl2Ng42zeGvLe4L6Zyn4PC
	 cqoKw2gzDw/pHypjNCcUK//uuT0uUgSFi2PqbeqUvHBhGbI4V0WuYOa4Db4Io+2N1j
	 6DJG6C2kaopiJ6whWsZBk/13/YbO0/cUy9xLS9/5SsqiYjLvtbOCRo0PCEeGg7Xb7m
	 uBl7EgKVS36QIt148Ms161Nn/wTy/rkPWLqTlMVzAKFUkezoQDxDeiQwL8eykOHx2C
	 y1gL//JlOGyYw==
Date: Mon, 13 Apr 2026 22:51:02 -0700
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
Message-ID: <ad3VxtQSL8ClGiEQ@google.com>
References: <20260411191710.524998-1-irogers@google.com>
 <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com>
 <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
 <ad0cfz-gUKea5bI8@google.com>
 <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>
 <ad1P8ebyCyfKwXH6@google.com>
 <CAP-5=fWC7JT4mn-JwBpZ6YvUm4qBFp=wOb+bOj8AM79gxHK0_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWC7JT4mn-JwBpZ6YvUm4qBFp=wOb+bOj8AM79gxHK0_w@mail.gmail.com>

On Mon, Apr 13, 2026 at 01:55:39PM -0700, Ian Rogers wrote:
> On Mon, Apr 13, 2026 at 1:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Apr 13, 2026 at 09:57:02AM -0700, Ian Rogers wrote:
> > > On Mon, Apr 13, 2026 at 9:40 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> > > > > On Sun, Apr 12, 2026 at 1:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > [SNIP]
> > > > > > I've picked the first 23 patches to tmp.perf-tools-next as the rest
> > > > > > still has some issues.  Also I've touched some commits to either remove
> > > > > > some parts or split them into separate commits.
> > > > > >
> > > > > > Please take a look.
> > > > >
> > > > > Hi Namhyung,
> > > > >
> > > > > thanks for doing this but I've done a similar clean up. To totally
> > > > > separate the evsel refactoring from the rest of the changes, to fix
> > > > > the address sanitizer issues with kwork, etc. I'll incorporate your
> > > > > changes and then resend the series.
> > > >
> > > > Thanks, I'd like to merge what's in the tmp.perf-tools-next unless
> > > > there's a serious mistake.  You can rebase the rest changes on top.
> > >
> > > I'd drop what's in tmp.perf-tools-next. Otherwise we're putting fixes
> > > on top of fixes. Looking at v12 the sashiko issues are all minor and
> > > the progression of the patches is more granular and natural.
> >
> > The goal is to reduce the amount of work (including review) during the
> > merge window.  Also I don't think there are many fixes in the tmp
> > branch (have you looked at it?).  I think it's ok to add fixes on top
> > in this case but I can drop non-conversion patches if you want.
> 
> While I'm glad the patches are landing, since the changes depending on
> the refactor haven't been posted and won't make the 7.1 merge window,
> I don't think there's a huge rush to land this series. That said, I
> think v12 is in a good place regarding both the shape of the patches
> and Sashiko happiness.

Ok, then I'll drop the whole patches in the tmp.perf-tools-next except
for the first one for a typo fix.  The v12 will aim to the 7.2 cycle.

Thanks,
Namhyung

