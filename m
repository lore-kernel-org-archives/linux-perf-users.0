Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1331DF998;
	Tue, 28 Jan 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091725; cv=none; b=N+qkWeD1R4uMEwBRUfxJgQqDNxkvaTvzMmmcj7hO3OcDyRw/7FYb9vYdqoIcl1BrFfFXueu1Xjfh5OZ14NCFrYTlGdBxh0r70H8+2BUy8C8V7sQpWhvdDMg9Z/GEXQpC/wFfDKz564MFZZa51gHT65pCh3nIThrklAHXWT9IQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091725; c=relaxed/simple;
	bh=3zTvpNb7Hd18kV0EdwHUPj8ncUv8Rhf5JMVojsEoIjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f7p1Ngzn93MGcep8IFruSji3oVYEgMKW+NIRGEI/TLd+A65dEUT/u+RVQSg4JzOwGadmUnIqdFmp//bLntllSKuBC+sQ4x4faFn6A/2ruMW/9yFGgIrla5opZTMwbfNPV+20pH8rOm5TAC/Xmqf/707gRgbrVed7oJXUAJD3POw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4c/58mN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4c/58mN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA1FC4CEE5;
	Tue, 28 Jan 2025 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738091724;
	bh=3zTvpNb7Hd18kV0EdwHUPj8ncUv8Rhf5JMVojsEoIjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g4c/58mNkhJGC1SZzHdl6y7NmE+uxBKHtURSruzyh1tFaWT2+Mw17HRVoqF4QWUHV
	 p5X35rxW0ZGo8osxPK/LIAysI1DNhxkfp5lOu3+p8Nj4sKli8odzxNOtkGlkQsNHz4
	 EN2nA4u+PeZSWRnh1E2eqWKHIjk/ymL3XTl/wU5i3z03QMrTUQe6DzYrRpRSk0+R/l
	 hO5J7dW9FlGPF9QhuBIsfjpcHQMG4dzuzrZh2DcHpPPnUamCDWygH7IpJeTkAr7/tM
	 HOidAuniaLo7Aoe6ITugbAk8tmpvHdEueYfHMP4/S5zqQC5rLbxzwqJaieOpWXPH/V
	 2/wKE6cQ3Z5jw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20241218115552.912517-1-james.clark@linaro.org>
References: <20241218115552.912517-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf cpumap: Fix die and cluster IDs
Message-Id: <173809172447.948154.8687721946839031306.b4-ty@kernel.org>
Date: Tue, 28 Jan 2025 11:15:24 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 18 Dec 2024 11:55:51 +0000, James Clark wrote:
> Now that filename__read_int() returns -errno instead of -1 these
> statements need to be updated otherwise error values will be used as
> die IDs.
> 
> This appears as a -2 die ID when the platform doesn't export one:
> 
>   $ perf stat --per-core -a -- true
> 
> [...]
Applied to perf-tools, thanks!

Best regards,
Namhyung


