Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA816F0E8;
	Tue, 26 Nov 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647905; cv=none; b=qVXou1tO64OWIKNi9yCYue7H6QTMTgwoyLgZRbcldDJ7Ecdx17zyRktgxJiJmllLXRqGfjvkvlV/rlq5mAKSNIQvYRIyMrr5umo/dZVCSe7q8VHSQiAEg+sqw9/BDEHG+MrBza0uu6k8/nKHyZT46kH0IfbHwibOkdIuPLV1klM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647905; c=relaxed/simple;
	bh=pEIGDwnyL7MiIoKNvEGS/cLLg78Itlh+7g3BTqwGbLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC+YOCI/VDzZ04OvYddiO7cnX83g+d0sN7Kw4bvEyQIcx01tkpBOVCee0RTWXTCQAsVU6gBvWNMrwuHK+E2K+5BlCJ6fuk7zZkHRxp6a6vtHySbqVj71PZWt1pflskT2k9Ccq0BpQek4YUforsiuz5akwZJOZZ22wcNezdU2IMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnuGWi41; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnuGWi41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4274C4CECF;
	Tue, 26 Nov 2024 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732647905;
	bh=pEIGDwnyL7MiIoKNvEGS/cLLg78Itlh+7g3BTqwGbLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnuGWi41ZKX9U/C3+WDiKp2Ar+a1up1qv1dUONEb/Z/uGEJzO+C526Cigte6ISpYA
	 OvMU1lSaHnlm44V+dz2TRAuj/dEfhIyC49UYZ3q8OomoK/aGcapuOB3hbLMoMlJAv1
	 hK4M3uMep3TgCUunD+SR59Ew/qvFgEUHA++wIwKLgQksR1VhycHT4Yl7JftS7fJu+W
	 c8fXNT1zzbS9ObZqMGr/TcWzcxuUzfZ+qttDsum0aeA8hQRwzI5oqyvGvAj59sI3yK
	 xq0IMnhA+UjxWrTpZn9Mka6w4DN4AbGrundzDS5A1tkaeFSqopdcHWOg/FHqVKZ/kS
	 t27hDpveOoTzA==
Date: Tue, 26 Nov 2024 16:05:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V15 0/7] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
Message-ID: <Z0Yb3r6GjUZck77r@x1>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
 <9bb112f8-0af1-4517-a4b8-bd2edacce07c@intel.com>
 <Z0YChjympWOZeu1e@x1>
 <bb2821b7-4440-4ecc-925e-4d78ba60fef8@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2821b7-4440-4ecc-925e-4d78ba60fef8@intel.com>

On Tue, Nov 26, 2024 at 07:56:12PM +0200, Adrian Hunter wrote:
> On 26/11/24 19:16, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 26, 2024 at 02:59:02PM +0200, Adrian Hunter wrote:
> >> On 14/11/24 12:17, Adrian Hunter wrote:
> >>> Note for V15:
> >>> 	Same as V14 but without kernel patches because they have been
> >>> 	applied, and updated "missing_features" patch for the new way
> >>> 	of detecting missing features.

> >> Still apply
 
> > So the kernel part is in, I'll go over this after getting a machine with
> > a kernel with those features so that I can test it all together.
 
> To be clear, this is just a software feature, so any machine
> with Intel PT will do. Kernel can be from mainline tree or tip.

Thanks for the clarification, the way I wrote it was ambiguous, maybe
somebody would think I needed some specific machine with some
special/new hardware feature (some new Intel PT feature, that is), but I
understood that this is purely a software/kernel feature, needing only a
machine with "regular" Intel PT.

- Arnaldo
