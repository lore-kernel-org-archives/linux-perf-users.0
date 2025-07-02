Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF182F50A3;
	Wed,  2 Jul 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474584; cv=none; b=jueNA1u+BqzwCmom/v4FrZQxrGArjbJu5R6PbyvJmIbJsdt4f7MwqkW7pHs9iQh78Y3XRZQon1qxthyiUDPWoJq973m+zLZIWyFKfW7JsLAsg5WQkQ8DAENo/kcLpIzrCYwg6Qz+vaj/Lz3iYXvrPZmBIwS9ebM3QBgtv8/noss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474584; c=relaxed/simple;
	bh=BPj2I1nKYgeebYPBzlMghOFMPdWzb+1ukzy1T9+iUbI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ngMM5cxngbDanzZPksSw2sP2Rwni9Ho3AX/iYiG7m9JVWWISW6mfhPkmfWPC305yzEyn5QnDVp3WnNRbjkW+RwCgzk1FqujtR8tmwokxmdBu69v7MaT90t+ZvKQA59Fqkru+o4CdBtJH6DaLfuEHc0bM57M3usiQuSNr1Yd+4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1cEQnwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1cEQnwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A44DC4CEE7;
	Wed,  2 Jul 2025 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474583;
	bh=BPj2I1nKYgeebYPBzlMghOFMPdWzb+1ukzy1T9+iUbI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V1cEQnwH0eQWpzv1bQI6WeoOI8+d5AsBq+d+kbLFJoCZQccNNvLCzb9kI6hh1wKkl
	 dwQXa7Dt9KZhZ7PgbDiM0yobsxveVEnCG7rgDxVfg5Gy/vl/hjPXXsYev/R/m2XWoY
	 nxPlmzwwFTy3czGCr9hgvM3telOgKl2/j7EkQNvgasTtiN+eZzoi4P4LM3nHnts4H6
	 xi5hzmkhAr6mVDXXMeByPaeFdAjyeaFMMArXbDIivpHraB4mpn09rx3psMdsAVbQb7
	 k7cx3g01+Bn8rzAMCwBNNfrolUA8tc4/yzOhvdUpbr/PW72wgH9+jTuvD1LnBj58cT
	 u2CNdmfzkPaJA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250628012302.1242532-1-irogers@google.com>
References: <20250628012302.1242532-1-irogers@google.com>
Subject: Re: [PATCH v3 1/2] perf test workload noploop: Name the noploop
 process
Message-Id: <175147458305.1845320.7375334735356810228.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 09:43:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 27 Jun 2025 18:23:01 -0700, Ian Rogers wrote:
> Name the noploop process "perf-noploop" so that tests can easily check
> for its existence.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


