Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0A1A2545;
	Fri, 17 Jan 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136490; cv=none; b=KvyDRf2ESI2XedqJ9/mG1rEbRifamSsAubJdutfpQJGPRiN7UdJL9Idqx9fd0otUoMp4ZeZvnjAe2j4ybZIruHcEr5w+qwXPsZGdGWazbeK018i2UOZ/8jBIi90mn9L4/rwnNYV1y7KT7oPp9FdNKnh9di1USpcAlnYLhpOVle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136490; c=relaxed/simple;
	bh=l/6wF/EDMIvsA/eaOJsLjWnKZtD+VU0hJlgH1WsjcsM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KGwvce66RNkVQ1OxcNilYE+0I7IrLz6y2AHPgv1J/0e+N/i4PYmRic4a82y/e8odeFOXsliep26YX3v00iYjq0LXYk88BngOXtMCaEdVSZIjKrTXtIVGmA0aiuk4egZ0rxF1XmF9LpP153BicpWU14yKFPI0t0iJF9DDex5o/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi5EULaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi5EULaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AB1C4CEE0;
	Fri, 17 Jan 2025 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136489;
	bh=l/6wF/EDMIvsA/eaOJsLjWnKZtD+VU0hJlgH1WsjcsM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Qi5EULaT8xEatiBtldu/tQTmfjbLEPSMTkWX8mYP8TE8eKOQd1RAX3z4mCyOwG4km
	 zrsoqG/jadKViIJMkREktihor/YYwm/fFvkZC4c3o0aIp0nh60z9g9UXTmydowUL8V
	 Xe5wpbySvRUvXJ5Sa5CK90Jp4Cm4pGMoungbHxRsogmBrKcmxVLmpFpHdHPeXUYqv0
	 WNp0+9dXxwmim9cp6r6fVRVZM+Jb528BQJVCcP4cVNphY6VTxQkBLC+uXtfEVYfpiC
	 +erNfRjYGEq4foAHfbSruWx7yNbqOjiNY39ejUnrfiNfBJVyFfkqTues8b2XW5NFar
	 GScDoAz0LSZ9g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250110045736.598281-1-irogers@google.com>
References: <20250110045736.598281-1-irogers@google.com>
Subject: Re: [PATCH v5 0/5] perf test: Add a runs-per-test option
Message-Id: <173713648943.2190713.18158908440161125480.b4-ty@kernel.org>
Date: Fri, 17 Jan 2025 09:54:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 09 Jan 2025 20:57:31 -0800, Ian Rogers wrote:

> Add a runs-per-test option to perf test inorder to better diagnose
> flakes. Each runs executes as if it were a different test, the tests
> appear together in the output:
> 
> ```
> $ perf test -r 3 lbr -v
> 122: perf record LBR tests                                           : Ok
> 122: perf record LBR tests                                           : Ok
> 122: perf record LBR tests                                           : Ok
> ```
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

