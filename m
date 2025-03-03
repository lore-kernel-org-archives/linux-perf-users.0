Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F4264F9B;
	Mon,  3 Mar 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020935; cv=none; b=Tj0cm7r8tEo6nxL/bU9dMts7vffkgRr4h0ceCLFGWdUadp4sXGaHPnPisLmRfMN5z1hkYg8s1XUbeXd+u30F/bNWJOTYUO0XSWFRGDU6sN5TQqPKTCShXFTJ5oJc6vdhK7lBnVULcQ9A9yDH69NKWwcxqdZiKQwPpEYXgBbG4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020935; c=relaxed/simple;
	bh=EnLfVkrNyjpIHFqxy19mP4RoR35DmExVHJ6s0CkUN9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=up3xjtq+Kob00UyDSFD58GEtrdzNJn4ztTa0+0Y63xhdokLnu2+phnCD3ozxn2vyDBGhquU4lqXEjYDtA9IutwayySFKTUnpMoyag3crl2gxlpXvQYAt81nx0cyR0nkJpUK1dqZxXkYX8+NKIGnB2XPlriFhFFMKSKoldF7d3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0vaj8kS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0vaj8kS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E6C4CED6;
	Mon,  3 Mar 2025 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741020935;
	bh=EnLfVkrNyjpIHFqxy19mP4RoR35DmExVHJ6s0CkUN9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I0vaj8kSKT3kpmh9/rYYAGT4xzKgcH3510BUJin2Lcp0zFOeWT91vHsH7rng/s6KE
	 VnLtXRw/K8hlA5T8JAzFFlgVg2YgKF+nL2OlLamF7Y6R0BLFbxgjrWt4vhrUtZbWox
	 HAV5K9uuNM0x6GqRyfGdGIw8J1A4+CuwynWqrvrSXtWLOO0LHNV0sYDopelaQJXZic
	 y+uFucWEb1THOps7spETQeA6QXFqwpY2MxsNXlEQ/z0ZKVZV3Q46dep6vW2gIkZDuS
	 VtVFDLfzWux7Twe+IxDx306Sma0myxT0FVIJa6S+haPmnZo6dvGuVt/VZ4A1weRir0
	 6xKQHUpOb7W2g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228090941.680226-1-colin.i.king@gmail.com>
References: <20250228090941.680226-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] perf test mmap-thread-lookup: Fix spelling
 mistake "sythesizing" -> "synthesizing"
Message-Id: <174102093458.2010975.16927872868230723724.b4-ty@kernel.org>
Date: Mon, 03 Mar 2025 08:55:34 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 28 Feb 2025 09:09:41 +0000, Colin Ian King wrote:
> There are spelling mistakes in TEST_ASSERT_VAL messages. Fix them.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


