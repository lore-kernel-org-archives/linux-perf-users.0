Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142D1ACEC7;
	Tue, 18 Feb 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917196; cv=none; b=CCmN/DDJN6opK+OrTwcMxpzUoJzxp05K4q/cg/0ieFiao6raJVstQuwWkO2Was7+i9rVSzZYRb6YUbNjmLJ8BoIVml/JleUQ7HPGHI7MvYN3EA35Ig9OU1VrqghsD5AtRYaJOF2OSijrRzZZQ6XV/vQKnNBwHwF/cJva3zn70dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917196; c=relaxed/simple;
	bh=dN3387dQRDuWKSMiY3P0CpgGHOeUf6kNncbWDYA/oXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5EHmrsMnT7jOogfU7e3Nhutybk8ZnjrgZIT9FlCxQ6rW0oMAd2QwCMP79BWKhctl5k3xnTUVYQmXEt71C3+7Ujs2eXqt2zwNwskpouY4v+RUNKWyAuSH4Yrjb1QzSGM9Nasc7RLd8T2ISQqMsBQ3Py52O3LbRuU7Fxb+PucKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpVgBoRR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpVgBoRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAD7C4CEE2;
	Tue, 18 Feb 2025 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739917195;
	bh=dN3387dQRDuWKSMiY3P0CpgGHOeUf6kNncbWDYA/oXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpVgBoRRucN9ARBU+yevGINKADw77hy7369xhh5yOd0nB4ECUbic+alWS1gL67rBb
	 2t2IZSkQ/DfgE9Q5o0R3Vr4EcVTeHmNKOlKQW7dxX6n/iA9tYVy5bH3hWDFCM0/Ztp
	 nEXa/D97EVpVpKrq6jBctBI9praI3fWhsJ1wwLxA2Sz8ojkC2RS4BMpqNxegvl9FIc
	 Nzw9//1UXHPnbpgOrJNY1+Sh56gOcyl4ZSRLsEHk5r/lF9XbecYQ9VTW7lxiqSaGio
	 A1FNUQ76X0nfR7ZodU311vxcxSOrBv1bYEOBwe/YwGMUytP1oruCXi9SVjPxGWviK1
	 9YVOK0Z2tQmCg==
Date: Tue, 18 Feb 2025 14:19:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Yangyu Chen <cyy@cyyself.name>,
	linux-perf-users@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
Message-ID: <Z7UHieRRnvRb5_oU@google.com>
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com>
 <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
 <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
 <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org>

On Tue, Feb 18, 2025 at 09:30:23AM +0000, James Clark wrote:
> 
> 
> On 18/02/2025 12:41 am, Ian Rogers wrote:
> > On Fri, Feb 14, 2025 at 2:02 AM James Clark <james.clark@linaro.org> wrote:
> > > 
> > > 
> > > 
> > > On 14/02/2025 5:49 am, Yangyu Chen wrote:
> > > > 
> > > > 
> > > > > On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
> > > > > > This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
> > > > > > processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
> > > > > > (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
> > > > > 
> > > > > I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
> > > > 
> > > > The name of PMUs comes from Arm's documentation. I have included these
> > > > links in each patch.
> > > > 
> > > > > I remember there's a logic to check the length of hex digits at the end.
> > > > > 
> > > > 
> > > > Could you provide more details about this?
> > > > 
> > > > > Ian, are you ok with this?
> > > > > 
> > > 
> > > I think they wouldn't be merged because they're core PMUs, so should be
> > > fine? Even though they would otherwise be merged because they're more
> > > than 3 hex digits.
> > 
> > Do we know the PMU names? If they are cortex_a520 and cortex_a720 then
> 
> It will be "armv9_cortex_a720" from this line:
> 
>   PMUV3_INIT_SIMPLE(armv9_cortex_a720)

I see, thanks!

> 
> > this comment at least reads a little stale:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n76
> > ```
> > /*
> > * There is a '_{num}' suffix. For decimal suffixes any length
> > * will do, for hexadecimal ensure more than 2 hex digits so
> > * that S390's cpum_cf PMU doesn't match.
> > */
> > ```
> > James is right that core PMUs aren't put on the same list as uncore/other PMUs.

Ok, then I guess we're good.

Thanks,
Namhyung

