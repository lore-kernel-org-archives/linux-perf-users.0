Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9255E73
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132562; cv=none; b=mX4C4URZpfii79Yk976RA0JEXZ+vB6l5kQ014b9swlLo/zMfgMeTTSzvG8kTxIPyvE0MbQhPUuOSjsn4A72Jm2PTdHlPKDQN/6EWhwR0TrxQspn49EYF2Br+7CMjHJr5eyHUbwFDOyZ6nyOJmnUPuApfqXaTMaZRYIRfIH5xvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132562; c=relaxed/simple;
	bh=HrfnOw4B8Z31wOUq8ZF2BF9bBY2gYTW3VYsNaMJSZsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiJWD/zbKaJ4xtxkr7jve0XN4j/RpAlb4MQNMF3r57SXGkgDTRE/85aPxZqyNuoRCoO6hoyRtPKqChfpanbZuH3YgiJSL9ueY7/vKU2DiXSvSiqmOeNrJCEhUNHc7ARUFls/yawQ21nD3+rjlQFVlLpsNMaA+0obnX3ez480k98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsxkyF2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsxkyF2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E09C4CEC3;
	Mon, 28 Oct 2024 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730132562;
	bh=HrfnOw4B8Z31wOUq8ZF2BF9bBY2gYTW3VYsNaMJSZsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsxkyF2vLOIx4sO7fbh524IfzHPncMphRGUAWUppCvD3rIeNsnSveKsx/mmqJvyVo
	 Bcei6L5LdfwZ7Rr47LdxT+8jtaP//K8hlm7tEbvSqcEYDnZydFBQTfyGsTP3GOyY9j
	 CFPQ5g8WheExHtoBmvxwYQMNYlDjiOnPmD0I56UE=
Date: Mon, 28 Oct 2024 12:22:35 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <20241028-loose-beige-goldfish-acefc7@lemur>
References: <20241015-warping-condor-of-storm-afa06f@meerkat>
 <Zw8cN9daNBvCJd3u@google.com>
 <CAP-5=fXsVXYkncR0rwxXvKp_f5dR40L9_x-qoLxwHXWMiyXh3g@mail.gmail.com>
 <a0626ecb-cc64-4c6a-abf3-76868178234f@gmail.com>
 <b1c1a76b-5094-4384-9304-360a6012e3ad@intel.com>
 <b11407cf-8cfe-40ec-abe7-165122807e1d@gmail.com>
 <ZxlwoN57PF_5YX0F@google.com>
 <Zxl5sduEDnoxEmd2@x1>
 <533a9e5e-b320-41d6-8d8a-223f69d719f5@intel.com>
 <3a6a3cab-6d4f-4136-97d9-3042279eb7a8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a6a3cab-6d4f-4136-97d9-3042279eb7a8@gmail.com>

On Mon, Oct 28, 2024 at 02:08:45AM +0900, Yunseong Kim wrote:
> Hi Adrian,
> 
> On 10/24/24 2:58 오후, Adrian Hunter wrote:
> > I would prefer the source.  Does anyone have that?
> 
> Looking through the archives, I found a source version that predates
> September 30th.

If it helps, I've uploaded the latest export I took before the shutdown here:
https://github.com/mricon/perfwiki

It should have full history of the wiki edits (in theory).

-K
