Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B961C6F70
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744924; cv=none; b=qWlBuzwaTuPjJER8su1k2Fhz2X3kAz5+yw1HtwPQN39gNb5A7feTy4Li8ZWzFMus7o0ls6xL75lQSBA4kN7riSY766A2JeTrJrx544tXeJi+/rtl0XQJtG3UBqg9aiFynANqYRE/ktvTM2BxXFoahV3MO7Rqm9WPAscdP6qyV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744924; c=relaxed/simple;
	bh=ZxsDYsBZQNjtZhE9ZjHvM6dVAVksoMIGwDQ9c4Ru5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffN2RzNl+sZf+wCI5+I27qMZlpLt3TT/FrGjIn6kRS/yfb6d8zULCeoc6R2NiwxC7qHYVOcffe+R5vsgYVvzWQS15tG/y1vZve1WiaPWNaqE1ezo9oJaRSo5/9leCBzlzZYYkItWpV1ENzWa6RLFRb9tXqAOi4XyShzVs/itgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBOOfGoC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBOOfGoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF919C4CECE;
	Mon,  4 Nov 2024 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730744924;
	bh=ZxsDYsBZQNjtZhE9ZjHvM6dVAVksoMIGwDQ9c4Ru5b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBOOfGoCwvxG3e6+pCJRyG6d4HbnbCOI2K9WfAeYaMWeJco9deD5Q3NgKV4zs7rSv
	 lfGgCCmZ2jvhK6fvHLoED+MbhFYn/qWLhvYCZKVLVioak5n+SBIUymswB5WijTjtAA
	 UTWJ4p37C45e8lJsocCFllZcu2VPpgwosADKA3M+DnL2380mYMmClusYlzLMBWfyZk
	 srvDP2QuijujONVAjCHevE+mZB+jmSw4TtgWgd50LvR8LzA0ktjpEAdARjSNfOAISm
	 5TykvhhWXKLwVd30ZvDzhbtljHLtbWm3S19QsoSrrvmmlfHJzl4IeRgL8al+GwOptL
	 wOeeKbtKAocMg==
Date: Mon, 4 Nov 2024 10:28:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: Can perf record make buildid-mmap the default
Message-ID: <ZykSWgPFytI0e3FE@google.com>
References: <CAP-5=fXP7jN_QrGUcd55_QH5J-Y-FCaJ6=NaHVtyx0oyNh8_-Q@mail.gmail.com>
 <b53d4d92-7d2d-4bb2-b9b4-9ecf353cf80f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b53d4d92-7d2d-4bb2-b9b4-9ecf353cf80f@linaro.org>

On Mon, Nov 04, 2024 at 10:25:53AM +0000, James Clark wrote:
> 
> 
> On 03/11/2024 6:03 am, Ian Rogers wrote:
> > Hi,
> > 
> > Without command line flags perf record will post process samples
> > adding DSO buildid events with samples it will also populate the
> > buildid cache. The --buildid-mmap option is superior as mmap events
> > have buildids within them and the buildid cache isn't generated. As
> > buildid-mmap has been available since 5.12, a full major release, can
> > we just make its defaults the defaults for perf record?
> > 
> > Thanks,
> > Ian
> > 
> 
> There's already the perf_can_record_build_id() check when it's requested, so
> seems easy enough to have it on by default only when it's supported.

Probably we can move it to the missing feature detection and enable it
by default.

Thanks,
Namhyung

> 
> Ubuntu 20 is still in support and on 5.4 kernel so there could be a small
> potential to break someones workflow if we had it on unconditionally.
> 
> 
> 
> 
