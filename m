Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C883E51D5;
	Wed, 18 Mar 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859521; cv=none; b=Mo8Q7iVEhgX1DMsNSnIgGhkfbM/2zegV/ZVxhd2EDd3dh+L/SpzjmzicfDPQA6V4z4pHSMeje12szTRg8S3HOkwptODuZdiMMYHuZ/cTqQ4WSmhLNmJmyNbh/qg09PRQHFnye+tsOp0t8Rfi8uyBsmI1aNVhFFt7fndjMQPu5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859521; c=relaxed/simple;
	bh=himTCW9DpnMPSH4C7lM9gVIRHLaru/ofni7RbptCs6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtSh5qNckrfKDRM2MmIe0Frgepj4Q3km6QZKcFxK9S94xLYDufQiFLlHGHiT7PjRjnb4dS2xvAjZkBZfnnVJYoAlrKBlJpYq2Hv1xRlGRgaeHWCm8I3dYovaeHGjXF+Ddm69oD9rQVzh8bEnbHMBNPWtSJLTWol3FhQ+bfAfu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWjG0Nsa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWjG0Nsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DFDC2BC9E;
	Wed, 18 Mar 2026 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859521;
	bh=himTCW9DpnMPSH4C7lM9gVIRHLaru/ofni7RbptCs6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWjG0NsazqSaSfHrUH2YnU0E8lvVrCs+0CnlrGP+KB7XzbAU0dfRQH8YWEBCBq7oI
	 E1+g6s8ANVf6XZl6zAWHWQXVt3mzN90mgNZrhwPmkSzWfvy6DaCZMZEglNuCc+k8DQ
	 PxKKvqJBEvjYgA8oAwsEHNH3tb+FK/8i7Ipm61AL88hiIg99K4NGt7r6A0JHqiDNun
	 9VJsuKoWBg+wx92ez2JpUAGzgraDHJIXh+PrKjezo2Xah9ce3ENpmOl9VB8XiotVUX
	 Q/bF8hDYvS6IyPtgt5Xlm2TuqDme8W3Al6yhTkcVsofmOfJAq9JmcSJrzERWU/8W0F
	 uv9MzPOw6EdtA==
Date: Wed, 18 Mar 2026 11:45:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org, leo.yan@linaro.org,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@redhat.com
Subject: Re: [PATCH 2/2] perf: tools: cs-etm: Enhance raw Coresight trace
 debug display
Message-ID: <abryv7FhSguOq929@google.com>
References: <20260313132129.2743468-1-mike.leach@arm.com>
 <20260313132129.2743468-3-mike.leach@arm.com>
 <20260313144518.GN4153946@e132581.arm.com>
 <abqg-uKHqobUTn3n@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abqg-uKHqobUTn3n@x1>

Hello,

On Wed, Mar 18, 2026 at 09:56:26AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 13, 2026 at 02:45:18PM +0000, Leo Yan wrote:
> > LGTM and I tested it:
> 
> > Tested-by: Leo Yan <leo.yan@arm.com>
> 
> I think this is perf-tools-next material, Namhyung, please pick this
> one.

Sure, will pick up v2.

Thanks,
Namhyung

> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Ah, BTW, this one I picked up by perusing the https://sashiko.dev list
> of reviewed patches that were CCed to linux-perf-users:
> 
> https://sashiko.dev/#/?list=org.kernel.vger.linux-perf-users
> 
> Thanks,
> 
> - Arnaldo
