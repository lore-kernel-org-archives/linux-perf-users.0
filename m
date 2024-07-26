Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2F628;
	Fri, 26 Jul 2024 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957253; cv=none; b=aKopJ3ZLFDC2EKILxFCmzDCZMvKfN571oLfbpobLnv5iHJVponbsnqJiSdbE2xPaZ5DwDmHWPV1N9Pxb8/vnbDlj8juyjp4xNaFcujZLTVHRaQLyG2XQylnZxQ44/I/D9e2lgobM+bkB2fwRcS0tHWh4G5UO6fJqDpEcgQb9CpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957253; c=relaxed/simple;
	bh=HkzBVk9ixCxnJeqR4lr6p4ysyjJz/u+pMwUwFVdttCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4g9axhZHXnF8lmzXV7jnDESYCozc7OLr5NNCvCL7gbaop5olMPtv6ESnus8VSPkWez3FSw7Yr4zl84tbOAFoy3NgrD2ERBn40GbwnWSfSgAP4seAPI4B4dKN4hYL35Sy9yoh3GrThoEKi2pl3qZ/jIxb4hFeqaznlMsJFGCwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgmcvjvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgmcvjvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25177C116B1;
	Fri, 26 Jul 2024 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721957252;
	bh=HkzBVk9ixCxnJeqR4lr6p4ysyjJz/u+pMwUwFVdttCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgmcvjvVjqEwUxnVyh+zepCxsqrn3v6AkQNfiafH+xICrEEdWI+9JfF82vE3RZCiz
	 88LhKHnTb2coSjWaKkBiMBqIpguTCnbIwaUoABH9wJsRPN8m+RGxMNUDCYVF2ApbG6
	 VFE4s6b3NSKRvZYEdt3k2qGa+Jf9XD3/O/bT0A65tas4hGCnLKr5Hfz4Uv/Txn1khC
	 w/oyZ4X5wpAIf9vXkNVkR+Vk2LuaNy+0lkHkqq75wPtHmOuVnb+VeuY8x7eiHd71uh
	 XAFJLgUOyhb0XNgpP48cDnSlMexoBUoecK1JjzkM5KVnU2bec0Y8JW95vDQRC1wEGj
	 mC+k9CL81KLsA==
Date: Thu, 25 Jul 2024 18:27:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>, amadio@gentoo.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 0/6] perf: build: Fix cross compilation
Message-ID: <ZqL7gu8AOvS1gOlq@google.com>
References: <20240717082211.524826-1-leo.yan@arm.com>
 <77dd91c9-e545-4a6e-bf94-045418606f75@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77dd91c9-e545-4a6e-bf94-045418606f75@arm.com>

Hi Leo,

On Thu, Jul 25, 2024 at 07:53:18AM +0100, Leo Yan wrote:
> Hi Arnaldo, Namhyung,
> 
> On 7/17/2024 9:22 AM, Leo Yan wrote:
> > This patch series fixes cross compilation issues.
> 
> If this series is fine for you, would you mind to pick up this series?

Sure, I think we can carry this through perf-tools if Arnaldo is ok.

Thanks,
Namhyung

