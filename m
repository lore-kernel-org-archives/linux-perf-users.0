Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AA1DB350;
	Mon, 28 Oct 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133625; cv=none; b=Fum+01CL3+rebvYozTj3Hc8b+d25e+rlBkF/Oclv8B65saCYfEmbCyby6pvxM7OthXG4BN063DyFfcrii0d6kdwQnLkOIMb+gEqlDsW0SWJgFIIWNwLtrJ2JZbyc3bzsneEKoXyA9sb4H64zvFb+2zB/eDa9pfzuHg0FvJt/ZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133625; c=relaxed/simple;
	bh=OptEfkBlqnLUcNrZkw8zjO+SkzPv2Z++IFDjSLN66ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQlKJEGKsEJaol7Iy6b8DRsQyWVq+khetadf+qJiKllKgypaT2eSM9RFfu8ewrNlj7RXI/lZRMrcPDnNoIsorOXlL/PI5foH3HpxvhcA/Ov+cVCdG0+N68LKaesriopuKyPkaFElRrhHgBb7Jw2F8nvOEEgo3Y1nGnx6ebqDxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooNScbAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooNScbAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2195C4CEC7;
	Mon, 28 Oct 2024 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133624;
	bh=OptEfkBlqnLUcNrZkw8zjO+SkzPv2Z++IFDjSLN66ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooNScbAjyxpdu74JVGExx/m71ciQbe/1kU+MHXg0Xm+JT/vCgVpKenkCIkf1JGmVJ
	 9nkQvvvAPHyXcTvz5hMjTNxdw6U64zWj2JVUvllxeF43Fz52gSn8hRr80UZsYiIFnE
	 BpnbHdTJSzRauOJ0i6WaJExnzalfVoxs6PZGGD5+ZOe5m/6uQys0UFy4Ff7wPai2Hk
	 80iIJYYr8rTIeB3zD+F1EFCOn/NZQbGBtK50zhudN+FGepn7Pkmz8jcn8pIx/xvegf
	 79pJeMRZeIYxpowZwE8DM/09biIXtQdJHl0bE7mQ0ZIoPjzyfX13Y5GpyAgKHVhgMS
	 1Muk0FaRQMN8w==
Date: Mon, 28 Oct 2024 09:40:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Graham Woodward <graham.woodward@arm.com>
Cc: acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
	irogers@google.com, james.clark@linaro.org, mike.leach@linaro.org,
	leo.yan@linux.dev, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	nd@arm.com
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Message-ID: <Zx--dTqaZPjeWA2I@google.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>

Hello,

On Fri, Oct 25, 2024 at 03:30:05PM +0100, Graham Woodward wrote:
> Currently the --itrace=b will only show branch-misses but this change
> allows perf to synthesize branches as well.
> 
> The change also incorporates the ability to display the target
> addresses when specifying the addr field if the instruction is a branch.
> 
> Graham Woodward (4):
>   perf arm-spe: Set sample.addr to target address for instruction sample
>   perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
>   perf arm-spe: Correctly set sample flags
>   perf arm-spe: Update --itrace help text

It doesn't apply to perf-tools-next cleanly.  Can you please rebase?

Thanks,
Namhyung

> 
>  tools/perf/Documentation/itrace.txt       |  2 +-
>  tools/perf/Documentation/perf-arm-spe.txt |  2 +-
>  tools/perf/builtin-script.c               |  1 +
>  tools/perf/util/arm-spe.c                 | 31 ++++++++++++++++++-----
>  tools/perf/util/auxtrace.h                |  3 +--
>  tools/perf/util/event.h                   |  1 +
>  6 files changed, 29 insertions(+), 11 deletions(-)
> 
> -- 
> 2.40.1
> 
