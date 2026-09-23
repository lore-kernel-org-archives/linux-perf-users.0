Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F492423E9F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187825; cv=none; b=YxcHrxUrP39ZOUJDR4qGMkA8M15fKTaNoX0mbz4xGoOEwI2lNxwI8FuSW9xUvKnodhLSDJoLoajPPq0tPO8wCrzxQyZoyNgE0P4tFhnOImHJSMUOIMzSt/zmbkoJa0Nzt4usCg28sbdH7KQbur4URdbhzEpv1NsomwajCqFz2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187825; c=relaxed/simple;
	bh=0biVTLhuEt/VK+Ri866Pockk0pW0k8wAAgn8KM5+u8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYd7Reo77MyDcNdxp/nauP6rN1Lwg9DTWKZ8uwtrgs1VtcfQNhr5u7WZtB67MXgtnM4pBRiTj3hr3WNyGCHNg1LWPEetzDyvf6N5jMgK24SQPmyi+41OyKp/tpyifrdkSQgA4Fo9ksVMiUxILCf/4UT7S8xmA8pB1SFuXHT9EwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3TUrtTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3TUrtTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291E31F000FF;
	Wed, 23 Sep 2026 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187823;
	bh=VHUJ84K8fDdDiWi6oxYUIEqPrviA8AhZ2OsuggKNMAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3TUrtTOs/MjhEe2sxAoWCbrwBy0oY4dYulhwIja12Npo2BVN0P9lhGMIXRNA2OKb
	 c26fJiAWPsCV7Hh3cU+NDjf+j/4MRq3B5MJ7zgLJok6myMQKGrmXZerUeGiPhUKST4
	 RZEYdBXHLq+aVAQ35zjKT8gGUI+WrOfeGg+WVANZ8Dg3PmEXW3QU3+xiANoVJpcGBg
	 29rzbIa/nACPI0QFWgCMwwW3GNDNvVbow3SGKLmBFXfUfCWKu4H59JioDmLEWEw+QF
	 zakvUPv6vu351/GGsQcVuYCkmm6Fu8uXce9mB1HWh3wOQZCrLaMS01nS02s/nUmcnL
	 XoM9HGcSZCVuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/49] perf test: Clean up mypy and pylint issues in
 shell test libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-13-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:23:41 +0000
Message-Id: <20260923182342.291E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint errors/warnings in
> tools/perf/tests/shell/lib/ (attr.py, perf_json_output_lint.py, and
> perf_metric_validation.py):
> - Fix E0606 (possibly-used-before-assignment) in perf_metric_validation.py
>   by importing sys at module level.
> - Add type annotations for stack, second_results, collectlist,
>   get_bounds(), and main() in perf_metric_validation.py.
> - Avoid assigning -1 to list[int] expected_items in
>   perf_json_output_lint.py, rename shadowing variables, and remove
>   redundant lambdas.
> - Remove unnecessary semicolons, use lazy logging arguments, specify
>   exception types and file encodings, and initialize module-level logger
>   in attr.py.
>=20
> Also update tools/perf/tests/shell/lib/setup_python.sh to:
> - Avoid x-prefix string comparisons.
> - Export PYTHON and resolve PYTHONPATH and PERF_EXEC_PATH from
>   BASH_SOURCE[0], ../../../python (for nested test directories such as
>   coresight/), and the directory containing the perf binary so out-of-tree
>   builds and standalone perf python scripts work seamlessly.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D12

