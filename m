Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC6126C02;
	Sat, 26 Sep 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447456; cv=none; b=VTdi3SyP4ENtXFTZazshU3euzjiIhEWdBj2l20vK2HdrMUm1bGhVMS5RnaF+GHDI0KeP/sGhu9b43uZYscVCQ+XIUIFQwtlf5JelRIuzNVtprqmBdGn2AXnKcvVA6PBH7xbkSdER08Uz4ThUSIoQLdoGJ6i6rU8em2nPdnNcbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447456; c=relaxed/simple;
	bh=ycjJpWRxiS83B3Gb739axSwIYJArsGMxbymnVuLUfzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOau1zCQAPxbb/yjqvAVlp9GyGSy3FmE9cVMDl3PyDeNTDugppDnrfeMT3TqrOG+EtpwJTshCGk7N3ZG+JVqhi+YXaVqm/eG5L/E58xPZNMdLQ4p7jKjGdXVLMFwy33UE+ZH7U/PWHTOmfbweR4lxSxqMQo0itTs+GRLNNsigD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7ZBNloI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7ZBNloI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECE61F000FF;
	Sat, 26 Sep 2026 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790447455;
	bh=3Q5k5U8Dr19/EVe/+cvogpoYKF40IMFVWgicWrcKqg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B7ZBNloISndRdzb59HOU2N6Vd5rGOcPp8wJ90IhD/EohUCQGm/AakWEDnlt1eaPHd
	 t6Pnc04UFFah3Nr6o4QFRW+U+teypjnTDA2dn4ScijaAj2PmNbWPBDFxd9CmaW3E+y
	 aK/Ipct0HehLOof0NDT4Sx87zlX+oWEIBvTNDtBZdwr788SFH6gwMNkHmEu3A8qkAp
	 YC+Mc+pPwAkETdRTB9lP9Feov8CECdKgtGQLU/TaM5U3YZROm9tzLJoYyXv8EupGEZ
	 UCiGzIdlU1Uy6VOjHJnG9wyOzyHCaABlYYLmgoFTjMzUMgLSNMTm1zl0WjCkMhc6d/
	 SlTkZuxmFVcwg==
Date: Sat, 26 Sep 2026 20:30:51 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf synthetic-events: Check schedstat domain allocation
 failure
Message-ID: <argPW5kPvgKpMP2c@x2>
References: <20260912031112.1814574-3-sh_def@163.com>
 <4c3a6187e83a9d2e7074122316e65a18.sh_def@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3a6187e83a9d2e7074122316e65a18.sh_def@163.com>

On Sat, Sep 26, 2026 at 07:31:08PM +0900, Hui Su wrote:
> Hi Arnaldo,
> 
> A gentle ping on this patch.
> 
> The separate schedstat event lifetime issue found during review has since
> been fixed and applied to perf-tools-next for v7.4. This allocation
> failure fix is independent and is still outstanding.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
