Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B91A6832;
	Fri, 12 Jun 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223773; cv=none; b=Q30Yi9LV3jMFeSqhNNKeQmTzB6u2nyDk5+7FXV8qWOqP6A597WNsp7k8/hsljmAPA8tNumyoJ//vpKgdREkJDsR2Jy1BPFWHOehgH5t48hE5gnDA+0UtDnCujbV7Zx3GJtGIcNNFggQhbLwtdWDDxPFuLqu1WmtzXHcABYs3Gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223773; c=relaxed/simple;
	bh=0zO5FUPnBiCbV39VBeeTjChm0KOwJCSdMGnMSE1BZdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdeJCApEJXfkep0+jVbcOUEeV/JHpdmFyVykK5xsUeHjKPv7RdMuvLR7XJx0WQHiwR0GqSd3IZkr1y3s55mDRmOvCy+XsvkRQOHxnYPsosA3JpnAwt4NTZisRLELiXmgyVb1K9HHLWh33PSBudDBDQaWqPXn0A883Gffnlc0ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLvgjGUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLvgjGUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C58B1F000E9;
	Fri, 12 Jun 2026 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223772;
	bh=HCNfAz3mDFedjsmdKA1MePIX1PcVqAUz1Toy+7WBBKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aLvgjGUXcsA9N0Efq4/jEOdQP956NoKD3BtfAES3HvLos5IQAGIENfX/GJmfbMOl9
	 JqgYnMlywXObAaZIz1hZFrIwwV2/lYeuOjhxtfJuJQids5UDHe69jrlgYKGlUCE9ye
	 BgSLzti800WheiR41+0C95QzjO1GWcpmgAh1nkWPiMzlo/RsuojpBlBlS9C7MCzn1t
	 q3hZYC0794mCfSXuPbpVczmRwEBxR3PlllrlQtv99zn7rr5Xnouk/HYnwyN2siSdP2
	 gbS4smGPWT8F1XxWx77ieu8KAXIvGuhiIFo971cm0jyAn/gOuomKMeMqYw05Kf0apV
	 vGdFFDO4K068Q==
Date: Thu, 11 Jun 2026 21:22:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Fix false NMI watchdog warning in
 aggregation modes
Message-ID: <aitRVyjj6SGNDYTg@x1>
References: <20260611215632.562900-1-ctshao@google.com>
 <CAP-5=fWgNn=VkHmdhR2+R2J_m0WitAf+sXNRh+k=P3+dNApchQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWgNn=VkHmdhR2+R2J_m0WitAf+sXNRh+k=P3+dNApchQ@mail.gmail.com>

On Thu, Jun 11, 2026 at 03:33:38PM -0700, Ian Rogers wrote:
> On Thu, Jun 11, 2026 at 2:56 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > To fix this, restrict setting of print_free_counters_hint to
> > only trigger for core PMU events by checking counter->pmu and
> > counter->pmu->is_core.

> > Assisted-by: Gemini:gemini-next
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> The suggestion for something like:
> ```
> pmu = evsel__find_pmu(counter);
> if (pmu && pmu->is_core)
> ```
> isn't really necessary because we nearly always set the PMU. Also, a
> case where we lack a pmu has historically been for a core PMU, making
> the whole thing contradictory. The patch as-is is clear.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
