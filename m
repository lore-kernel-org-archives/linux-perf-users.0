Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620B305070;
	Fri, 21 Nov 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755379; cv=none; b=NteAlHpEvQ8Mo2DP08KElZq2adtcpKoC5BsEtiX0RJrb05GUCr94Qul7C5G2VdquZDJntn5lbeZaLWtoXmkT15716KvGDbvUGhBIjUqmbi75Rij9rDNgiSrSIRpRCQtpHazZrOQTG6+bxt2HA6ATMrkQTvbNAKGs5GZUcHpCmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755379; c=relaxed/simple;
	bh=VD6YMdWhuq2WEgkm2XQCTRQaKHYqJEFqrQCvV2EIH6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QS0bs9o2UbA/3qyfIi3uVqXP6soaEKyDgr4aLT4KxHOxZjXrRGQOQ+HE9ArCSNhhRef0TTJF8uBIqisOLZfxZn/8ykWhGI9lzKLK1vy8GgdnO+FBcvu2XslZMyL0sjP4AoAX4b5G68Ls+l6/YoKBA1MEpuoQfSPx5W6r0wnNizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0RvkImK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0RvkImK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1726EC116C6;
	Fri, 21 Nov 2025 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755379;
	bh=VD6YMdWhuq2WEgkm2XQCTRQaKHYqJEFqrQCvV2EIH6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j0RvkImK+DlqrF5+A8PFcAsJBrA0AHa32t60C2kB9eI2YCTx+AEzQb+G8i8oZVXwd
	 aX8qXyb4cujscBp03Z4DE30HnQL+g1Fzu92j7IIB5ZKpZiGL9dhgQiKp3wkTba4Rju
	 X/IIuvzH5jS/5p97LSRpffuwu0+VJ+IeDYo8+ByLZaZM3o8QcbBMZ6IYfI6Cbux0qw
	 m00LJowjPd0SkTAR3xBZEXV1BYsHDnEGmZp880OGI2BYFpavErPIWrnQFKd5yXc5O2
	 XtpjRyt1MFH5Lvoj4dez/nuicWsSqJ16k9XNd8/gkhCL4PWs8PbkS8bVtIgSfyKq+s
	 hrFg82XglkBQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20251120004726.61660-1-namhyung@kernel.org>
References: <20251120004726.61660-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 1/3] perf list: Print matching PMU events for --unit
Message-Id: <176375537798.3973666.12812393973696853621.b4-ty@kernel.org>
Date: Fri, 21 Nov 2025 12:02:57 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Nov 2025 16:47:24 -0800, Namhyung Kim wrote:
> When --unit option is used, pmu_glob is set to the argument.  It should
> match with event PMU and display the matching ones only.  But it also
> shows raw events and metrics after that.
> 
>   $ perf list --unit tool
>   List of pre-defined events (to be used in -e or -M):
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


