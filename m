Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167C28686;
	Fri, 16 Oct 2026 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109193; cv=none; b=pnoTCJzUjSkNRnOfHfdPSGB9gQ4DiHpXzhTLyaORx7Lb3ql4ECaZVyiJWhHGnRKFEWsVIbcu/mI2I074zX5d1XfZbaf9pM5qcrY1QEoFu9rymg6pwPXLEGWbLzwZ9V7oF9zBiN2W9vQAwoP/7u27MmrAtePFj24WXrK3CwfSzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109193; c=relaxed/simple;
	bh=5iOs+8jKy8r880YGPZl/cCzNt8TCGSX6cT+HOOXFEXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZLfFlbbKy50iRokD3MjKDrxdR7XwWeo90mki6xmF0JS4cOvuZFhLqc+ojAV66Pbyf/XPYjFL6dy0TZYf5Jrdp9ZrfFEA3jtVdwL6LOLJt+Kp7YJ6latVUz1jftjQlwPfu2C0Ja/YHMD2zFuSNPZjw5JtLPqQ6AX8R356/GToko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CixQKdvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CixQKdvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA71F000C4;
	Fri, 16 Oct 2026 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109192;
	bh=4FnQ8ObvoZUTY89yJFyYxVCHQFo39nDzpbgF/pzC5ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CixQKdvwS7drBtQeoTUI6Un7ZQbjit6EBjE5u7TQoSSoskXNgnqgVdTfuF7O1nQ5g
	 nsystoKyTWKLiOFdL4+DjTD0sDOcPmc2oo0Te+zW/mQRMzYFkH6iHnOxewvn1vS5Md
	 0n+yDPNqCnR+OEKggieLxX+G1Qq5MeqqLzTCQ9h18uofIpR7Je56VSBcu18EwSlvvg
	 ShSKXMRbpqrk2FOcfroFQhxq9qMKuVCY2jO3stQKQrcto1gn25/XvpQjz6SyGDXpFy
	 w9HC63KvwIbPQstdjjJ8HLnL33aA7F3n24/TGsJIVWrbdBHAe7JA4ec6FgRbyAhlRt
	 IZKtM13FF8A9A==
Date: Thu, 15 Oct 2026 21:06:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/11] perf tools: Factor out dso__find_binary_type()
Message-ID: <atFqhKiqDT7hEc6w@x2>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-8-namhyung@kernel.org>
 <atDSmfwd4v_oLg4m@x2>
 <atEI2Ja4xpCnV7yI@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atEI2Ja4xpCnV7yI@google.com>

On Thu, Oct 15, 2026 at 10:09:44AM -0700, Namhyung Kim wrote:
> On Thu, Oct 15, 2026 at 10:18:17AM -0300, Arnaldo Carvalho de Melo wrote:
> > The patches I took (v5 07/11 onward) build with clang 22.1.8 here and
> > 'perf test dso' passes (read, cache, reopen), so please fold something
> > like this if you respin, or let me know if you'd rather have it done
> > differently.
 
> I think it'd grab the dso open lock unnecessarily, but it'd be simpler.
> So I'm fine with the patch and thanks for the fix!
 
> Do you want me to send the whole series again?  Or can you apply the fix
> on top?

Pushed out to perf-tools-next/perf-tools-next, thanks.

- Arnaldo
