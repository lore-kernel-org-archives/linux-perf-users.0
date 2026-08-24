Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BD31D375
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611247; cv=none; b=MFoPVgpDCQbqizJoqFydcefG5Q6LcqQz28WAO3Ej0wjJSWowzunQgPZNypeWFCwLeifPtTC9lIV7/8YjmeWsukxSgPV9tyz93Fjgzaf7GbXXjgC+WNCEMRJ8yiHy2DvWotxNa6eKoBGnkMWm3MEdnapkV6SVLX89Y0jyF5w53mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611247; c=relaxed/simple;
	bh=IqYDSJi6Ei4kt/OmzV+hG9b+/e5gE/qZWebsD7dGQt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Kz67uZLvzbAZsCahOp+YrpAJ9axhv5He38y9Mm9Gzc1MoVWWob5XY2Q1CTGcbOLbHvxXLx24tgvCKYSbBijzvlXhgk6USlNLCS5ioK6MJm6xM+qdLajXcgnwQBEqDp9AMGMumioyO2SyGAUErhQT5ffYjqzkBldUPTFZ+c8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=C7VpEuGK; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="C7VpEuGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1787611236;
	bh=IqYDSJi6Ei4kt/OmzV+hG9b+/e5gE/qZWebsD7dGQt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7VpEuGKFq+fpgYeOCzq0TFbMpEkN1ZQ2KsIy4TwLzhSyEMBN3Jcp6cWuQgnVAEOp
	 2ibimKhmwcaShMPALvIaFtw5GiLsLP1qdczc4aWqP6dO9EsMGy47qk0DV0IcGpphqB
	 ppeVXqF5v39uffrAa7/2kTb8D/iKqPn8zS0aueRQ=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 576115EA52; Tue, 25 Aug 2026 00:40:36 +0200 (CEST)
Date: Mon, 24 Aug 2026 15:40:36 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v1 4/7] perf tools: Expose opt-in --hybrid-merge
Message-ID: <aozIZLYvv78jX-3u@firstfloor.org>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824063744.1533837-5-irogers@google.com>

On Sun, Aug 23, 2026 at 11:37:41PM -0700, Ian Rogers wrote:
> Add --hybrid-merge flag to explicitly trigger event merging
> non-interactively
> for both perf-top and perf-report.

Well it should be default on.

I don't want another option I have to always specify like
--no-children.

-Andi
