Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC51DF27F;
	Thu, 17 Oct 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183160; cv=none; b=VrwZjJ3xewpiOYauMyF/vLosYN8ot3LUfJnynpvXtXTIuMkmg00FLiX82Ns74BLmM++mcja96LIvZJ4sh7vwjG+nfM+uFt2siEeegH0UfurcvK/D0oCP7HhpQTvaT7YGmU6Kz6b1sJksPG/SrDFcjTW42gJgt+xPi6Wpohx9gUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183160; c=relaxed/simple;
	bh=qHAVf/l8Gbbk8FlCBzphdScQ1uH7lbJuqOiI8AmbNsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fUEI1YoUJup/KBAitEmEeJ7aUW0Yq243oIBJBisDb6Qfay84sQFa6HAaJIXxgvNBC/lU26HnQT5CFwV5s9X32cQnkTAzM3wIpwuQSzSmNd2MJ1b53UfLJPHYs84FO+450FA3wUX1GX1mufM36JtGoYr9xB3SfNWtecz4KCfAt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdqxEKjg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdqxEKjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EEBC4CECD;
	Thu, 17 Oct 2024 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183160;
	bh=qHAVf/l8Gbbk8FlCBzphdScQ1uH7lbJuqOiI8AmbNsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IdqxEKjgTuQpmLP1Q+IRk9paiBmzZHJCdt1bXuoOT+xe99s8VhNb4w49vbGYQuOF9
	 tmdRIH3I0MSUh5QqfatyhoRV7P1Lf1I1ykKqq/e+WdYj8O3uU6K8kJ72SiS7CpFnrG
	 j4dxgoPbNkjFetnd0psLqurnzaQnRUwvOUn/4F/yySkXIu1CXqzLTliHIkB4N8kWb1
	 joSnxxwv2B7ycM33R/0hiImc3FBc7/cHdE2Hf7CTGAhMLyRFKgw1Dg7kw5tLOLeSGB
	 5rOGRkpXXwHp82Iy+NehC3fqUGIAbhYIwntn0qkwGV98TD3YkFec1SJRj86ZMyylHK
	 COMo6bJTnLmKw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dapeng Mi <dapeng1.mi@intel.com>
In-Reply-To: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
References: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 1/2] perf x86/topdown: Make topdown metrics comparators
 be symmetric
Message-Id: <172918315983.639809.13756139511632758353.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 09:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 11 Oct 2024 11:02:06 +0000, Dapeng Mi wrote:

> The commit "3b5edc0421e2 (perf x86/topdown: Don't move topdown metric
>  events in group)" modifies topdown metrics comparator to move topdown
> metrics events which are not in same group with previous event. But it
> just modifies the 2nd comparator and causes the comparators become
> asymmetric.
> 
> Thus modify the 1st topdown metrics comparator and make the two
> comparators be symmetric, and refine the comments as well.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

