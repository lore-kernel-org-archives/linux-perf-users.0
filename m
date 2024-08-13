Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53523741;
	Tue, 13 Aug 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575626; cv=none; b=YGCKQAdIHwtsIxK0MLsGZUenVF98FpR+IedApjJIxE27B2akU9dMzexuqZKIJLDITydk/ItRN1lQd2hAJ2D21KxUCuM/FbTqlTw27n1BsL3KR1nxtmTPyU0ZpF5Lj6UCdLp4bO0hHc1iFUuBCiyBVQsYxLW77TuLSt80YgoJZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575626; c=relaxed/simple;
	bh=xrOBLeDvSsrZu3kwqyv5pE7AOqFdFMAnuNJB/UZATXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9Sszik16xChqas8AyvZXJZf201FIm4+KpCzaTOO6JC3Z6G9uYH3x2YKh7QI41NQVzut4B3bX/6mWI5dj7Pe2Y+F7aeC0cC6P9TmSA+l6gu3ukkW4idT5ujIrnDq8iC9bakSbKsIiocoavY/d5WCBLH+Fb9jJMzM4nXfMcC++yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUycGlj1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUycGlj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C41C32782;
	Tue, 13 Aug 2024 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723575626;
	bh=xrOBLeDvSsrZu3kwqyv5pE7AOqFdFMAnuNJB/UZATXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUycGlj1YgN8FLcNfyErhuBJw0tKiZEo8750tJQFHehM72Yndu/S/bnO+wkXKT2H5
	 tEMAH6xpacj3I4LnH5u/i25fPdIivwZmC3609uHlOKVHIo1NSnjqcgQfn/vYxLD0LN
	 IMDEjqgs95DTr38yQt2hVDy2079uY1nus+TvCGUeafH53Tl+fdKtON7pmJoPFS6PCH
	 ecSY+Qo6NnyVIr+Vu6xy8SNyJtZGuQc77ySp6EZj+GPamF2+yEdezhvJ+9ZVhBGQnu
	 9Qq5j63A4rhO3Zu5/Nl0aUCAlmVBdiNwoWezuWW/54vlTnr92JTfesMOU6MldAgGip
	 tZd2tkgaJsfwQ==
Date: Tue, 13 Aug 2024 16:00:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V3 0/9] Support branch counters in block annotation
Message-ID: <ZrutRVjI02ELnpYH@x1>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813160208.2493643-1-kan.liang@linux.intel.com>

On Tue, Aug 13, 2024 at 09:01:59AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V2:
> - Rebase on top of the tmp.perf-tools-next commit 9da782071202
>   ("perf test: Add test for Intel TPEBS")
> - Add Acked-by from Namhyung and Reviewed-by from Andi

Thanks, applied to tmp.perf-tools-next, will move to perf-tools-next
later/tomorrow morning after the full set of container build tests pass.

- Arnaldo
