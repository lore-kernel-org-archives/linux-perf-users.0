Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983333446A3;
	Tue, 13 Jan 2026 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340546; cv=none; b=W5U0W4hIpmxPVGVBmYtkmKAYU52Q6y53EX30AlTnJ2SPsjr8Yr/giolAf3r+fVBZ/XZTUNGpmbWPWl3xMKUe54AbytHHZ2nxmhpxvpEsYruAwMn/d6qAdCpnxU0ccmtsnnSq6FE8nkJg9iFc1HLdVUGQR/d5PslJn3aOA4/GgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340546; c=relaxed/simple;
	bh=o0mZRu8VjGfxDtp1nzPBF053EycqZgJkGMuWkeBA54E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXYNBzkCTqKXtIWH9h5UUiEmjsFw0LsnDfhu954xcqOqKTP2HmYCvtSeKsIejZP0dqZHCWTePwaPlXYe1cRk86hR6IPJcA7x8zETQ69OQRCCGdLB6IS6vwlTy0hxv5MxV4JsIdUPi7mfUoCNvGWaOhkSCtdjSxu4ZhVo092b3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U21x68t2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U21x68t2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C454EC16AAE;
	Tue, 13 Jan 2026 21:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340546;
	bh=o0mZRu8VjGfxDtp1nzPBF053EycqZgJkGMuWkeBA54E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U21x68t2goltvttMbA/Pak6+/CI3tTtK7GMt43sRD6VXLkEdXONKx/XXWef6YAKRm
	 GdQNQ0ERI5Xa5tz0tSZmlYF9x76ZuewB0HhNvjfQAd6q75vbL9El7Bqbe49XSDmUa7
	 bAN6mEMyC4fuvedjcE4+7E6M+CQ2LK8nrixlJaHFIYQgKJ/Pdct+ihR1h1ZSG5T3lJ
	 ePb3wgtAd9WPx4EOUg4/4YKmVYGvxP7RyQJMYL2ftt8UXHL/+A0FQZVYn2Ykq+at92
	 MkxtMgkdnQXI9wO9E2dIPDhtKoKf4R7TFM5U8HDd2Zfot7uaE5sbBdgKDg1yVXKJ51
	 +HDHj/CiBdklw==
Date: Tue, 13 Jan 2026 18:42:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf help: Move common_cmds into builtin-help
Message-ID: <aWa8P9Jc0pwtrIvu@x1>
References: <20251204211143.572382-1-irogers@google.com>
 <aWGr-JUBZd2YHgkH@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGr-JUBZd2YHgkH@google.com>

On Fri, Jan 09, 2026 at 05:31:36PM -0800, Namhyung Kim wrote:
> On Thu, Dec 04, 2025 at 01:11:43PM -0800, Ian Rogers wrote:
> > There's a lot of infrastructure for generating a relatively simple
> > array used by one function. Move the array into the function and
> > remove the supporting build logic. At the same time opportunistically
> > const-ify the array.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
