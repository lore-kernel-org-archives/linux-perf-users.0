Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11794478E5B;
	Fri, 27 Feb 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227971; cv=none; b=iF7ppY2+hoQ19Jb0K4f3RKl07HBPsoD/APBUPxiuktvQjhdPiHCkkDRqhRxRLuFoVl2ud6JxisBXzC05tRaQSyAPpl7GzigZVnRzT4N179NTR73ZsSDlYZn73NwP6xx6b/shal9gfbEeSBHH1XOz76tv1Tn/UvoihhqLlRNbWq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227971; c=relaxed/simple;
	bh=4Bcq5DBmzV7NDGcNBIn+YI+kh7IQgvwZm4evcOFBoLw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TLwm/dbmsjSDugEdSsYEWr9Y9DyXgtmGegHf6sWGcAIapfZUyaK84Ykj88PevzqV2ffoI9zjLixh8V8tElcnx6h6xtZO3JHbBK/Ig26C34YSCzHy2R/VgQ3aV+j5/vEh78SjgM5tA94Mtwsw6DDyRyR1P5mYbjEobqvu/F4MX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FucmdOkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FucmdOkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF47C2BCB1;
	Fri, 27 Feb 2026 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227970;
	bh=4Bcq5DBmzV7NDGcNBIn+YI+kh7IQgvwZm4evcOFBoLw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=FucmdOkhG0G3t8fD7dPJpJ85fCukaaAVGID1Hjc3oLNbQzV3d3TskdVucQ5C+ednr
	 mo1SeKCFPgQmBSJOlRBr+zJtV+MJm2ZzEhs+YRBQ86lW5p56evELqxXrTeSWnppWXI
	 D5HjFakXA5D+/ilmvxR2Rmq3tgKQzq21bARbgO+45vaCf9G5RM47ZINPwpABxcl8Xv
	 kE4/yoXTv7Z9RnQ2pgguvovj8jG+JzN7wiAikEqDG8x596HjVnTvX6Enn/gy7cJLol
	 ORvV9WFeycp/tmCb1TPYD1stBj9Kd+s/O/IXTTBQ5qTqUVPY5aYN/HRqtIndqS6Avx
	 /wubLjf/Kx1Xg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20260226175936.593159-1-irogers@google.com>
References: <20260226175936.593159-1-irogers@google.com>
Subject: Re: [PATCH v2 01/10] perf vendor events intel: Update alderlake
 events from 1.35 to 1.37
Message-Id: <177222797041.277001.16540713245344430231.b4-ty@kernel.org>
Date: Fri, 27 Feb 2026 13:32:50 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 26 Feb 2026 09:59:27 -0800, Ian Rogers wrote:
> The updated events were published in:
> https://github.com/intel/perfmon/commit/632936400cfc5978c7b4519c865c137de523bfdd
> https://github.com/intel/perfmon/commit/a96d6bf4b50d6ce31e2ffd0be8d13022d07ae319
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


