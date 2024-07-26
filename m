Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A52178CFA;
	Fri, 26 Jul 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997433; cv=none; b=XfnMMfYrGiSRp76fOZv5NKg43bG/7vR6NeOCPIw/5G43FhtS5avy9faASIT767oQxMQxmk1sVQjRbqX1zn3emgbMeGaVqWUc8vg/Gv90EJdeRDL7BBvSlZ2SLPXYDZMvNwmvAGTEcgGgnFqbMWkM0QJMBYbzWuVwxMn0gKodkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997433; c=relaxed/simple;
	bh=2FjmwIGzJ5BW1ybnbpiZdxICECjVRKLvGWnmMe51Zuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYfXNvISsE439koGuZRbAnpLqlDIQcCxTeloRcQhdNfMeLVA/q0/CjHy63L/eLeuoC5jRhoWBqiLyhSaEo3Q6PoICeBoZQfgLo4ArjA2Sb3pjkz3BtZ+bfjeGrQmuzNBK15s3dxm41tR1CDbvzu+Mw39T/kJ3Yh6nvDG+OSuAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgbuErNu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgbuErNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6057AC32782;
	Fri, 26 Jul 2024 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721997432;
	bh=2FjmwIGzJ5BW1ybnbpiZdxICECjVRKLvGWnmMe51Zuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgbuErNuX9JTHZrG3oFN+i3cW5bCQrNNpAlMJXMZZWFrdYpX5q4UJd12eXQc/It8H
	 dVmNsQv6+r0oLdZ7eSuNvyFDFb8Is9BZCIdeaXSHmfHaPGFnLSC0xEuzIGrBKuM1AG
	 ZB5cTsCCixhL3l3PmEqrxbYI/6ISnu+pic8laEC1aoe6jpObhVhU9zodE9CGP1NCDu
	 4+LdH9nScFNCD/gRMRvNThJw72teVxtNft22uMMYH/M1UC9UL4xntvs7d37VyJavKK
	 ieSa2xl/FNi5X08sx42DSAVr8TlQIyEBloH//IG7runikSEHlTZxBhSrdYC0axP5TI
	 3nTlXXJ/sUOKA==
Date: Fri, 26 Jul 2024 09:37:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>, amadio@gentoo.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 0/6] perf: build: Fix cross compilation
Message-ID: <ZqOYdX5TSk1odkCH@x1>
References: <20240717082211.524826-1-leo.yan@arm.com>
 <77dd91c9-e545-4a6e-bf94-045418606f75@arm.com>
 <ZqL7gu8AOvS1gOlq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqL7gu8AOvS1gOlq@google.com>

On Thu, Jul 25, 2024 at 06:27:30PM -0700, Namhyung Kim wrote:
> Hi Leo,
> 
> On Thu, Jul 25, 2024 at 07:53:18AM +0100, Leo Yan wrote:
> > Hi Arnaldo, Namhyung,
> > 
> > On 7/17/2024 9:22 AM, Leo Yan wrote:
> > > This patch series fixes cross compilation issues.
> > 
> > If this series is fine for you, would you mind to pick up this series?
> 
> Sure, I think we can carry this through perf-tools if Arnaldo is ok.

Well, rc1 isn't out, this has been out for a few weeks, so I think its
ok to have it for the current merge window.

- Arnaldo
