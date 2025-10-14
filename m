Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52B3148B5;
	Tue, 14 Oct 2025 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450720; cv=none; b=szJLrm+eoQTlDWicup9VnXcYqxYPn6u8gtwgN5piBhBvnWMwUNbIk7EsAbYV5BjZ6XYjDWCIpRZkqQiNu9U308WNsYvwBllubHQEd/dO5PMtoptNXkzGD70o+8tauVI+JSS4d9n5ivYuB+RNG3kE3VmlDISmfvwIw03eaktNXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450720; c=relaxed/simple;
	bh=2MfDvynREwOPKM2rSXg1NAtdptV1OWDgLGMaa+9JWbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlP0vsx8d3hADzC4dyd6n1R2WKMbLvIdw6UA/aWsysqtTY12jJLQBt6MlfUw8mzTqBMz3Y49lXOVq2MfwpoyP04YcYBWdf36W0vBzytigRW49mSRUmkpo3DBHhDtkQaLtH2IBJcQzzvJMXojCO1h8mukfVhOnYmsRFEhuHgmwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BevzrwrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BevzrwrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E81FC113D0;
	Tue, 14 Oct 2025 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450719;
	bh=2MfDvynREwOPKM2rSXg1NAtdptV1OWDgLGMaa+9JWbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BevzrwrOQioWYVZF5T/75LuuuIr+AfiWWVqd4Z8EfMLhkapb7llyBwpNJOeWy1G/P
	 8K5Ub0w25pdyL3XDdHbegrce59cX7pTymL0V7MWkXrHt1V6pqwcDc2rG5lHl8qmuEl
	 o1OikTQRctmEU/dyH8PUP9T87gjbwFdrZbq+G9HY0IihOTEl29tshY1wt9nZES989U
	 8i2QHMCyDN8xWcEA1S6dOl1hE33w9SgECVXZJsWq6ZeEKLhdPie3wr9RP5F27QnWVK
	 uEd8gd89k5Ehf2eAGsy3wWtmFCKWQa10JliN1rLuYRuc5C+edkJefVroYV3J1zMcFf
	 Z8R58vjX5f9Ew==
Date: Tue, 14 Oct 2025 23:05:14 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] perf build python: Don't leave a.out file when
 building with clang
Message-ID: <aO5YmjYdSjlpGzjV@google.com>
References: <20251007153835.3578633-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007153835.3578633-1-irogers@google.com>

On Tue, Oct 07, 2025 at 08:38:35AM -0700, Ian Rogers wrote:
> Testing clang features doesn't specify a "-o" option so an a.out file
> is created and left in the make directory (not the output). Fix this
> by specifying a "-o" of "/dev/null". Reorganize the code a little to
> help with readability.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Justin Stitt <justinstitt@google.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

