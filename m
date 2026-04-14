Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640E3E8C44;
	Tue, 14 Apr 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186719; cv=none; b=Og4dcPwY/9f/ejdKIbMWpoEoxfeqkQxve+TI7zS/D9T3qFoG6/CHWKh0PmvfI283+wZRFXe8RMR7MjJflLWt8O/kl0fV8BgbncBlm829CHwIq14X0q2tWwdinAnTdadn1QSwZFDjGByfFwuK3xv9dE7IyL7UHqlMFBi6o8JX5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186719; c=relaxed/simple;
	bh=PCcOZzZV+YBNGmDBjrwElIIxEVO+5zVTJORp5CqOpiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iVCrQyaD19UfxCBV2Dxw1V0Q/FuX78eGz03DdW8aks96He/uW9W0iiMTEtIsvY1UakCfPJwlqgbMXpBwawTUoaqECCi8EYUmPLNScY7Zx+L3zBfPVsvlq7hw/jx0+qnGXRMlte1YiIbAZOUYRqyzbztlmkfqAYzui3rOBTwA/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgKTZai2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgKTZai2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C87BC2BCB7;
	Tue, 14 Apr 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186719;
	bh=PCcOZzZV+YBNGmDBjrwElIIxEVO+5zVTJORp5CqOpiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KgKTZai2OOELrBr6hTnVPYbFej6WrymyQznF+aeMHiMHfW9fAaJoAWBIp4Zg+dhg5
	 h6acQrGCuZ0i76bjK0hnuW4IX1H/Na91SMtAJve0dWIiq9egK8Ikv71teZraypguSw
	 Tfi3g2TlpMa48/bj/UvPGDbNzYyS9MykgPNmhqSM+iYeOLndoBjYe6GW/BXCFkhBaO
	 ci7ZA1KEo9vy+Tzd53Ol+TyYCTWfIx1+G5NSZG6LRvjzgr76na9D1y7sOMThqndMry
	 rxd3AWKvU2770seOtIuIIsw/iF8zqhF88152D2uYkPsvhkRr6Khv7KI1G169HKUeQw
	 6NEY7YuB6JWgw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 collin.funk1@gmail.com, ctshao@google.com, james.clark@linaro.org, 
 jolsa@kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260411193705.735269-1-irogers@google.com>
References: <20260410002351.10856-1-irogers@google.com>
 <20260411193705.735269-1-irogers@google.com>
Subject: Re: [PATCH v2] perf test: Fix inet_pton probe failure and unroll
 call graph
Message-Id: <177618671913.1519819.13206361304836444443.b4-ty@kernel.org>
Date: Tue, 14 Apr 2026 10:11:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 11 Apr 2026 12:37:05 -0700, Ian Rogers wrote:
> When adding a probe for libc's inet_pton, perf probe may create multiple
> probe points (e.g., due to inlining or multiple symbol resolutions),
> resulting in multiple identical event names being output (e.g.,
> `probe_libc:inet_pton_1`).
> 
> The script previously used a brittle pipeline (`tail -n +2 | head -n -5`)
> and an awk script to extract the event name. When multiple probes were
> added, awk would output the event name multiple times, which expanded
> to multiple words in bash. This broke the subsequent `perf record` and
> `perf probe -d` commands, causing the test to fail with:
> `Error: another command except --add is set.`
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


