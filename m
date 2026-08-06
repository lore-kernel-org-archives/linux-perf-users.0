Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995234CFD0;
	Thu,  6 Aug 2026 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992669; cv=none; b=ocl41srZAhWBlIVNE/0+ywB6eq9l3FLGDme2rENMVtdxVXuhDuV1iEGh49KaEhBofaKvq2BVYDglFQbX5DiyI1seAjqvXH7mA3ryrT3I0krSto0MwHs2C92MS/uv7fUn8qNI99JCd7i1xU3tYM00Q2kp9dzN3cfqQPeOYD8kzRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992669; c=relaxed/simple;
	bh=y2nY7Ddj1ilDqfuOmu/nq8TuntAGPNteU3SvX2zXoZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJiXeZ7z4oHqwi11/e9DIeoHdM8Rt9Rtq4A2Lq+LcuVyS5rU7jXH2M7QNUNpAOqxVBVdUg/FQxLBUHX9mbzN4rP2WmvNgOfPeIKoT0LMnOJ8gn26fPnEI0FUpZzjnaFhCpdqNWOybMBMEu5JMaw7d5Ap3MxHtfikoFdYZDw5pU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNinsIMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNinsIMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BBA1F000E9;
	Thu,  6 Aug 2026 05:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785992667;
	bh=orlhqB9RIlj+umpMXPNDPo/x5CnhrUG4fH7OflsucyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nNinsIMTjxwdsjlgSbDydLu3Qf/iVnliXlbb/x9x+R0y9zG3vYBQn9ccYcf/4VJ2v
	 fLQE9N8m5OGCRbM7tOkNRIcuAIrz1p4/nlm/k61fOcKF0gZTCXqdn+e33pl+PHkIY3
	 mltAKFk8/4XDdPz3p+cEuSzYXBhxf3MBm/xwqHb1BV1EsOIsDR2zqoVzNRdfKNdCNz
	 cP+Vg5IJc4uf0ZTX6n4rZKl74gujyYwoao3XHrSWnnv6SM6s2P/JQflR29doGlXRGq
	 RUKG78+1Tecr6ei8m8VXQ2+ZYvXyee9VWVyqHjewXA2+TpW5gRUBq70CPMNRBmvzoF
	 ul6PSoIxhHnHg==
Date: Wed, 5 Aug 2026 22:04:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/4] perf sched latency: Refine outputs, unit scaling,
 and histogram support
Message-ID: <anQV2fx7jhSzql_D@google.com>
References: <20260805210751.287746-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805210751.287746-1-atomlin@atomlin.com>

Hello,

On Wed, Aug 05, 2026 at 05:07:47PM -0400, Aaron Tomlin wrote:
> Hi Namhyung, Ian, Arnaldo,
> 
> This patch series improves 'perf sched latency' by suppressing misleading
> empty table output, extending pipe mode stream processing, introducing
> dynamic unit auto-scaling for latency and runtime statistics, and adding
> latency histogram visualisation alongside time-span filtering.

Thanks for working on this.  But it doesn't apply unfortunately.
Can you please rebase on to the current perf-tools-next?

Thanks,
Namhyung
