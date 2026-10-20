Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523747;
	b=1lUk5hYsJ+intSOsv9lc79wMewgRSBNG6Y/DhmtepRWB/E9maujocPSYd6iMz2igc6du
	 Xv/ChRFscnCTaF6s3X4NtNFS4UVBL3dIod5I6wS8+HQRmXrd/jJ+PFly1k1o5rMHoy6aB
	 jCFJBQgOCEa4zT4++vwPXILiPlwujz0oAo37K2JDe9F/GJOCcqrI6YKQHx69eX0e2PoJE
	 dQtmEOTQaoqt1ibsN+JxsjAqsxq3TNdnjgr3nUCligaSRY1WMDDv8Qk3qSMeOu5xf6GHk
	 MqiC03CzeDDPOGeF1davRTHMrkGswgZdM66Vih4ekJ75VU4Fnk5HrOxGhYW6idymIEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523747;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HPEMm3KzAtIRLiKQFUHumEFY4JPYUMG3s2HtauHhtLU=;
	b=3jDsdewsX83mLI5aJVONxF0Z8GCB7RPoWZsyDXYbBYjEiITmZScdcxbF0/rbcD8THNTY
	 dZ/PaHOPcbFpGQ62zgfUx1Nr6AD+DAx6LynR821crWJlq2DwI7gcT0fWhfcp+u1gyNMuO
	 vgk74Gz4EFSMgGXCDpn1aOSkRuCDVI1PvpmLAmCzLY3/fHhAusWOQsrMSA2/KkgGi90H4
	 TUVRS4YImIdtJXsRqUYzijx5RN8XHh/1giRRl0Bmppk7YWcTZEO9tXwlDWtBfNVl0Gyq3
	 ptimkyb+5JYvhl67el+eOCX8H5mn3HT+nUpdqcR32BG/15S6U62xCkpLX1oSRn2xnLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MMK/YGbf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC7606A319;
	Tue, 20 Oct 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMK/YGbf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E248F1F000C9;
	Tue, 20 Oct 2026 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792523746;
	bh=HPEMm3KzAtIRLiKQFUHumEFY4JPYUMG3s2HtauHhtLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMK/YGbfoxlDs/mSVwc1CLP4DQfUFyh6QS/8vR0xl8Hh5SjHZ7xaQBUycOTbI/vhT
	 5JBOwNF4SjX3xxIAi6pBZPkl2WM5v4xDXUNWToOrXJlcAr2OdNLshXwWyCYaBKQdI7
	 LLXo2Nzqhwhs5hOnjTPxD/6D2y7VviqSihArdwRHl5VepVF/XELd81TYMuLg1DH5kn
	 zVG9nIab9mwvBjH+TPAYU9TZgq2WvERhYBRTquZ3USxxKygWIRRt+O5ZioiRtBHqMk
	 AWkQvsmyHjoGuEH7FI+t76yHBDHLQ9hYGSDKo1uoFtKsBEu8sWn0rpC8km1497GCME
	 hNeZjW4vhQhpQ==
Date: Tue, 20 Oct 2026 16:15:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Besar Wicaksono <bwicaksono@nvidia.com>, namhyung@kernel.org,
	irogers@google.com, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com,
	mochs@nvidia.com, rajjoshi@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, john.garry@linux.dev, will@kernel.org,
	mike.leach@arm.com, leo.yan@linux.dev, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, ctshao@google.com
Subject: Re: [PATCH 0/6] perf jevents: Add NVIDIA Tegra410 uncore PMU events
 and metrics
Message-ID: <ate93zQFkfAecIv2@x2>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <21f58af0-fa3f-41c5-ab03-216c60fbe2f1@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f58af0-fa3f-41c5-ab03-216c60fbe2f1@linaro.org>

On Mon, Oct 19, 2026 at 06:23:16PM +0100, James Clark wrote:
> On 19/10/2026 17:42, Besar Wicaksono wrote:
> > Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
> > PMUs.
 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
