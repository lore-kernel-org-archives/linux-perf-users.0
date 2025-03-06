Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73825B671;
	Thu,  6 Mar 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281250; cv=none; b=ukanGO9OCMgd3gkHEO3z1am23XZ1TalROdZvnE8ao3AKx9EExpJHca6KJzp5pdDlEU72KYUQGQJk/OLVdwIvFQxAGjHuk9k/+p5A9RA57CSlnGzaIybNfOYFfELN/mKOl5+GgmC8GkBwbpAVtSgtt9dyXkci+Zl/AQzXDDQcp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281250; c=relaxed/simple;
	bh=13Ku3wN3uQXnYrvmHehtgkgvGYEQWkz1kUnyMFVrpOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=daYC6AP3KIDICXrRFnaXVfHyltpcubKPxGosI+s193kDHmPqUYXKERyYFmmmUfuAmYiXyIJiE/PL3wB3B0zTgVDYLpFPBrm4iMf5expnAUOMQHI2gj/QA7uXNW/Lp9P+UtpG+OaJdTvQw0wobgPC+FfpRW+XlB/cICg0+sVxHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCqpgRZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCqpgRZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E41C4CEE0;
	Thu,  6 Mar 2025 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281250;
	bh=13Ku3wN3uQXnYrvmHehtgkgvGYEQWkz1kUnyMFVrpOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UCqpgRZSAF3buJWySWgDDI+DiBCMZMf6yKC61bDZdciurclGK40NrS83O0aDfTy80
	 n4hfBSGyKSpXy2VJmV4rcJcUunsh3uH6F4J3UZRhpT+aJAlqtge7BNoSuoPMR9vX5q
	 oKfxiOJnwPrieN4NFYJJ26bIUblxMs2t+kgd5x4b1aD8ZSLG5cnP9BguoriUixVFnN
	 fxD3ZZherc0kb2ieDRS6/z8bIvwp8ZgRB+gO/URZRBkQKYueF5A4UPKBVK1DYnBrLr
	 2Fvm9xNL7aZk8PgF1RxoaP5/c9vG040q2BJnUekyEIrAK/3K44nwL/VsOq3MVjtDCe
	 8wOMIrhYQFi8w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Stephane Eranian <eranian@google.com>
In-Reply-To: <20250228211734.33781-1-acme@kernel.org>
References: <20250228211734.33781-1-acme@kernel.org>
Subject: Re: [PATCH 0/6 v2] Fixups for kernel maps insertion
Message-Id: <174128124996.3835280.12530365732339018502.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 09:14:09 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 28 Feb 2025 18:17:28 -0300, Arnaldo Carvalho de Melo wrote:
>         Here are the patches from the recent session on fixing the build
> when DEBUG=1 is used, please take a look.
> 
>         I think that since there are no reported problems and ended up
> being a sizeable series, we better apply it to perf-tools-next,
> 
> Best Regards,
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


