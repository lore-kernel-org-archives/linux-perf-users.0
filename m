Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BF801
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797193; cv=none; b=il/WoCBuWFWm4yoNTQSMXTBEQW7Ozxz3OfXT55mDM7DI3dZ8BVG6PFJyVYzR/byp+Fy0FF9bYgeZIyZTt0D1LxBhxsg/7EZXdkf5sc7lCLjj6WsqR9m0UqwfdS+tVJD9LH+jiG+PotjJOdddHCrx2Ab2pxXR6pr+iuEp7p5SzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797193; c=relaxed/simple;
	bh=7QOVtt0e8gEg3/WGLk0iqEq8f7Z5oWqO0ZG0EQcwiNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Of33eaElN4bxxVHH3DEzB3WiVZGZIeTUYnBBcGcfh/PQx1NzMDsjJoZmDXmZaTEAXJu8bCRJcae5575llmQf96j6ZIZfsR9QccI2gK+dJLMhMtBCRWvW19WKJTqlHAO8vC0yFELmnUJSSoJGlrHX6yytCtNMzTjuuQI1KHEYSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDraffFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDraffFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCBDC4CEF0;
	Fri, 18 Jul 2025 00:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752797192;
	bh=7QOVtt0e8gEg3/WGLk0iqEq8f7Z5oWqO0ZG0EQcwiNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cDraffFrarya0sA8u/D3TqPDUoqsliTdRaI2SrGyTEyGJTG9Az6XCtutl1BnQnCOs
	 0RFGS5P2eBNyo+AE/vO3LK/RpnLdniMcN7t03wiec2MOvzcD/cF0I+cRCorr+PlUw+
	 fjidmf9X5jyy2ailLWfpNPzDeuqu+aKKoPfD5gBcFnwebfZRtzgB8o2w6fBcZkX5x3
	 scBy7xtBR3MVr6q0uj57Bxv7MlxnVNY+PGD9+InCqSJFqYdeNJrE+Cj+VYm1YBOUjH
	 17FhbXjeM/eGHpxD/7xQY9AGxiLvAXhG7J4bh+opQP/ifIDeh4CrM37Dlcpl4SLfDJ
	 wEL5ugljwVr3w==
From: Namhyung Kim <namhyung@kernel.org>
To: mpetlan@redhat.com, acme@kernel.org, irogers@google.com, 
 linux-perf-users@vger.kernel.org, Anubhav Shelat <ashelat@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 dapeng1.mi@linux.intel.com, james.clark@linaro.org
In-Reply-To: <20250716203914.45772-2-ashelat@redhat.com>
References: <20250716203914.45772-2-ashelat@redhat.com>
Subject: Re: [PATCH v2] perf sched timehist: decode process names of
 processes in zombie state
Message-Id: <175279719246.656724.5249718346589585675.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 17:06:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 16 Jul 2025 16:39:15 -0400, Anubhav Shelat wrote:
> Previously when running perf trace timehist --state, when recording
> processes in the zombie state the process name would not be decoded
> properly and appears with just the PID:
> 
> 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
> 1140057.412222 [0012]  :1248612[1248612]                   0.000      0.000      0.332      Z
> 1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
> 1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
> 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


