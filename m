Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F131E532;
	Fri, 28 Jun 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593836; cv=none; b=LXSfXPXZxS8R8ImCi5/VB2XL3one95gM9fWmX3phF6m5Nuzl+nyjpHa+sQDyqbKZOyPauanX7FuelfruFQEhqRgcB+no5Gu+htBT7rMP3nUW0PRdcrbedNul2QgYBf9SpzrefTHgALR+poeFJCBh/4sr0doYQNYp/vzOXbaLYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593836; c=relaxed/simple;
	bh=NT7RCpkhL0pdbUJvZ0pE48omVQKmWY/rzHi63uix3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ6o3KlLSA9wdj8hwb0lSK9Z3icM6P2p4DhLttqfISDNGj0BEgpAWaTnzLS/OzZD/96Dp+3qJEyz1Cc3/WgjgdCyQnPWHB8w7r7NGMJA62QWb9EZ+7dVP7kiZxCTISwUPuKdWU5tECJpKKMt07O4q4AL7duj79o1Ai4p2ly2hQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsPyBbyn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsPyBbyn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524FFC116B1;
	Fri, 28 Jun 2024 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593835;
	bh=NT7RCpkhL0pdbUJvZ0pE48omVQKmWY/rzHi63uix3Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsPyBbynKUIgPZT8W/K9ij3VPSTZ8FVahlKRUQGPH6Y1IUTfKdQloSGuf7yZyroad
	 LIQnVHQ16XIY90nxKXq+08CXp1vH/a4nMYCbRMdOgtQH+YpmjACP78Jz3e6nBtqYvR
	 gL/56meASA3p9sP8d/ftTDrkVm8Cdt2xehQmB3DWCClPAjyZIbtohqK2iPXeB7lonb
	 Zn4ZSRypp0Vs6tdYnNueZpk7gc8pmYyBJDYOixbzd7+tJZVVDwUDRS3HD6PH2tVvOv
	 3W70Jgup2Jk8wpJIu8vAsuzTHTIbckRVW8UpE4ygFnGwIfNJW5u2vT7YjZ+NeI0GSJ
	 snn1BPoDnIIFQ==
Date: Fri, 28 Jun 2024 09:57:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf intel-pt: Some small fixes
Message-ID: <Zn7raVnpmLNISoUS@google.com>
References: <20240625104532.11990-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625104532.11990-1-adrian.hunter@intel.com>

On Tue, Jun 25, 2024 at 01:45:30PM +0300, Adrian Hunter wrote:
> Hi
> 
> Here are a couple of small Intel PT fixes.
> 
> 
> Adrian Hunter (2):
>       perf intel-pt: Fix aux_watermark calculation for 64-bit size
>       perf intel-pt: Fix exclude_guest setting

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/arch/x86/util/intel-pt.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> 
> Regards
> Adrian
