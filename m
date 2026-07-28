Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5013B19D2;
	Tue, 28 Jul 2026 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262241; cv=none; b=UiGRAztvn7CTh4BvztLmloC0m6mitVDU/nQF0elK8Mt4Ivl2qTnfY3AimdXNuX/yw9GUHmQ02uLrsHfbhhmG6RqJ/whNvTshp+hlOv0K0mVLa7JRWBNT/7rpY3imX0XFcqYc1KctECWipemLepsT5OD1ZM0gumieUVmSGzuV8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262241; c=relaxed/simple;
	bh=a9zb1JCLIvbJeIwMmVlEtSth7t2tYcLP7PlU57b7k8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpcXSWS6BLlfuZBkAabxxpjWCN5r9IyM9RzUFa9fyOqmy34O1ENyatnqUyE/g4EuAbgokLOpD+wa1s7pAApF7e3LBUnx8jMacV38Br4niYbhb0iZB3aS4vqv30pFjrPlZq85NH7ynU/nF0zPBY91x4LXO7V5tN+zIvKnKgD5kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeaVpAbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeaVpAbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92311F000E9;
	Tue, 28 Jul 2026 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262240;
	bh=w4HS1+PM7E+rVTG1oaz8YkPe4Urur5sY6cIMrTNuJdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UeaVpAbUGSzVTU9I8nVPFS6BjU6Iml8IGGZ7m4waa0XJu0Lv4M9WBWKjg9M0JslNO
	 RwW/t4AEHTo+CciGv13l1YMEHTTE09E9pFCw5nSO28DjkcVkl10nWQx92zi8zVDCGq
	 ZFRoVskzO1SlY7bgi6riUPc5d9mZSneCrKkQ0O6PIFfySsmfR52dkkcZqSBVb5Dcf0
	 h6prdFAM31KsQhXtkb9G44Vn5EVUw7oaBpy2KJhfMk4D89ZL8OpFxAZAFdGI8APDro
	 f0Zn7od4GCOlp4jRVONB+Q1wNLEVehThkTlH6zuF5LyXvsdbWbhGJNPeKaZKAvnsJO
	 x2UtDmRoouWCQ==
Date: Tue, 28 Jul 2026 11:10:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] perf c2c: add a function view
Message-ID: <amjwnof0gGNvAj5p@google.com>
References: <amGpVYnDyqe7-xdy@google.com>
 <20260724101029.1000212-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724101029.1000212-1-jiebin.sun@intel.com>

On Fri, Jul 24, 2026 at 06:10:29PM +0800, Jiebin Sun wrote:
> Hi Namhyung,
> 
> Thanks a lot for the review and for confirming the layout.
> 
> I've just posted v4 with the reworked hierarchy:
> 
>   Level 1: the read-side function (pays the estimated HITM/peer
>            load-cycle cost)
>   Level 2: the contending function that writes the shared lines
>   Level 3: the specific shared cachelines
> 
> Every level now shows functions and cachelines only, with per-level
> indentation; the code addresses and offsets are no longer shown in the
> main view -- they remain available in the cacheline detail view. The
> series is also reorganized into 9 logically self-contained patches.

Great, much better now!

> 
> > ... add a shortcut to the cacheline view on the given item.
> 
> The function view already supports this for level-3 cacheline entries:
> pressing 'd' opens the corresponding cacheline detail view.

Ok, nice!

Thanks,
Namhyung

