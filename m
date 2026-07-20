Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81A199949;
	Mon, 20 Jul 2026 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784522745; cv=none; b=VhCJrZwOmqsi1J58GnpioxkkJ8B7Aor01kAH8tPOK5Xr1muF9OO3lgJ7ghkZcjfEU/fxcYZ1baUQ2/wUyP3Fugj2nd1EfwlgOYx22CF/ELIv0UMayI7W2RqUKN0SwZvK6KHzXkO2TQPlhhIIjQGx/xgUkxoLzpZ/VICOWp5FhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784522745; c=relaxed/simple;
	bh=kExiWj77I1+YCmgowZd1xV6UYAmjTGUbOXQsZ4gkcNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmkF5IyhQAyNeG/3rue+O0ZVxiSOXZPAv/Rs1tF5lrsayfZM6NfDHXbxro51XTNvcweuA5/YZA4b/m010yfXNHuHGKaw9ejm96riP95nZISks52sLDV97sTuQlOkYOXJd6Cg0NvtVyMCcSo0IC5KHx43g7z8tmcfEJ/FOaMFni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2LCJKA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2LCJKA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC781F000E9;
	Mon, 20 Jul 2026 04:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784522744;
	bh=LOk6YCf69NukHCGeVaXscwvhPER2Yr9B8bBBraT0tGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W2LCJKA/Q860fDhmhZcsgkqCwhhSdw1aPBG08fcfCl25VIzzeS5ZjOoJ9JDcVyUKX
	 an67Q0p7HIJ7ob0z3Ik8HVOdX2BQTHmmEoPDUqDmOPIaJBJqeeD5259Yfjt+oqX6Xq
	 AH3HLShlHw8umdCRszM2co8cOuajFGXQWJga/fQzTeYSeNzz2kUOmXEKATF0+1zo6n
	 CjoxUdGzv2QKj+IPz2xFTrtvOS7Y0QrETGZGXmK7v+bMXdpzaO7rFPzUpAqXJrn9M4
	 l/NuB2N+BJO8Ajm4D9s5FP8z2CnTt2Mu7j6G0GFQFP70oiwSOYvLfcgd838ekArCNi
	 8fkK0CMnKokKQ==
Date: Sun, 19 Jul 2026 21:45:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Subject: Re: [PATCH v6 01/10] perf hists browser: Increase MAX_OPTIONS to
 prevent stack buffer overflow
Message-ID: <al2n9pdO_uAH4tTb@google.com>
References: <20260710053628.1861645-1-irogers@google.com>
 <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716072351.560311-1-irogers@google.com>

On Thu, Jul 16, 2026 at 12:23:42AM -0700, Ian Rogers wrote:
> In evsel__hists_browse(), the 'options' and 'actions' arrays are
> statically allocated on the stack with a size of MAX_OPTIONS (16).
> Further down, the function sequentially calls several add_*_opt()
> functions, which increment nr_options without bounds checking.
> 
> Depending on the context (e.g., branch mode, scripting, annotations),
> the sum of added options can theoretically exceed 16 (potentially
> reaching up to ~19). This could lead to a stack buffer overflow.
> 
> Increase MAX_OPTIONS to 32 to safely accommodate the maximum possible
> number of options without risking an overflow.

Applied patch 1 to 6 (except 4) to perf-tools-next, thanks!

Best regards,
Namhyung

