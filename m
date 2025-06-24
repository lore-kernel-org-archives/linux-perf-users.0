Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C02E610E;
	Tue, 24 Jun 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787590; cv=none; b=tU5CacJyTXCtua1ql9oIJi9vCKTHuNjRZ+Xsm1w3LeYU/dHpjJIC6j0E7VO+Ws3r38b3TY05xnVG6soyZqgaoY1zS7P0/cVnJXfOMncwnc0UvqIwd697DkEnvqo8krtPjBNBERzU+CCQ0WhVzgY/NWkNSMEGJ64Owin4s+W9jkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787590; c=relaxed/simple;
	bh=2qxYrSUN1uG+PyMnaYr5POQeUIdyRVylP6WEC7glwOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mhc1PuHujouFQ+9vjOfG0Jp2JFq0pGadXWzKpvzc4tGsBHg6d4yp5U1q1YRwF48wKU9/whxEcYMawQQjaz2kA5aLbwScvthhl1Z7mUnyXUQN4BcyH8a98YEqGZNsiYn3loPWlPyPrrJ9y5nygSOapc7LphSIbIErqCFc/kei8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t24sxjSQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t24sxjSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C40C4CEF2;
	Tue, 24 Jun 2025 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787589;
	bh=2qxYrSUN1uG+PyMnaYr5POQeUIdyRVylP6WEC7glwOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t24sxjSQ2SmgUgWBA9Cz5OhUrSW7fUzRhin5hJkhn/kW5HjdZl/vxMVCHME1YP/2p
	 yrh4FDFZr2BtBrHJmyn2fhNOT1fkFchUQQZex1U58/xYxnjW2QygoZ3XhX5h/SVZBi
	 kyd+2dTECXjxd8ZbjXSmjx7ucvMswXRIJjbWJFxTyvL3J6KHhAEpQmXfBj+StdhCP3
	 lR1qVQ6K9HY8MQPyHWhyAu6XCbD9eD6XOOL6EBAJ/e3mXrxxmw2teFLs7mWApbqZwP
	 6AnBhaJTNAGimpSqm7QSVGfjWJWEs2fK283V0AMCqyi4PwbE/QI+7oxDM3updFdvAB
	 gaVGgpT4EdxIQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, Sergei Trofimovich <slyich@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250505174419.2814857-1-slyich@gmail.com>
References: <20250505174419.2814857-1-slyich@gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: skip non-regular files
Message-Id: <175078758903.337518.10854344069618331237.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 10:53:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 05 May 2025 18:44:19 +0100, Sergei Trofimovich wrote:
> Without the change `perf `hangs up on charaster devices. On my system
> it's enough to run system-wide sampler for a few seconds to get the
> hangup:
> 
>     $ perf record -a -g --call-graph=dwarf
>     $ perf report
>     # hung
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


