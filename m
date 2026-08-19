Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07F3BF660;
	Wed, 19 Aug 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159313; cv=none; b=HDqv650diRE9xc54P2X1ERD4MkbL3c0GCj6kuHDrVUOclDIPhE5RxbuidYm/qkIImKjkXzcswBszLN45tRigyEIj07iYEHgVUMXI0zs+3bXF3NarJgV+CyTJUduRXKDkE4q3J3RHri5PpG8gYsdVZRMWvENIPIcPhVvAwJO2Q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159313; c=relaxed/simple;
	bh=AxbX295FHSnS2pkV7sAx1m8/YNLXz/RNUcY+AVXIzM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JoIAI9aPkQDO9YPZQSMAzWe+6qPnT/hvwTEEnl5VC2Npta9tLLcKJEVmuY8xc0im9JOuqh6WiDakwegoC90vN855vOMUtHpYIBFSBQoZpOiDnDADbdHsuq9rs2nJsbRR+rSO0oIjeFYzLSUx7CHoVkW+L7dt7jLViJG1cmeNxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMfIT/cJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMfIT/cJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A81F000E9;
	Wed, 19 Aug 2026 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159311;
	bh=21smCt5veLbVqe+S+GWthbuG/xZam00DYMCOlQBhZRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kMfIT/cJ4WIwWWFk0uWjh8XUTnAx8W8OWI7C2tf1xlp6Bt7171PRN75/ukSbF5crC
	 cVvtB8C6y7A02XV1Q6YetGHEjc8JI/OUBUjnCkP8Nb5b6etn72KfjadjgJzIo8GQbS
	 LinXBkpHfvE98Mzez05ZYALDu3PFVk7NqyzjF8fkwLfJH/TrcnlOmeX/tSSEnQScDT
	 rusv05dECaChlQP5tGfM7yRh5VLEn4n5R5rPQftWLV3lgYLE1Zz6Z9X7IrQNqnIZWW
	 getDqBkttWaAz41wl2vy1ihm0bVaJ6tHceoTlwTEgRMo8hbnjW4ztGCmfc38133Pg7
	 dNcnMV4y7UYpw==
From: Namhyung Kim <namhyung@kernel.org>
To: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
 leo.yan@linux.dev, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Mike Leach <mike.leach@arm.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tmakin@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, 
 rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
 mochs@nvidia.com, sauravsc@amazon.com
In-Reply-To: <20260813170155.1156593-1-bwicaksono@nvidia.com>
References: <20260813170155.1156593-1-bwicaksono@nvidia.com>
Subject: Re: [PATCH 0/2] perf vendor events arm64: Fix Tegra410 Olympus PMU
 events
Message-Id: <178715931078.2811574.8141825092501896684.b4-ty@kernel.org>
Date: Wed, 19 Aug 2026 10:08:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 13 Aug 2026 17:01:53 +0000, Besar Wicaksono wrote:
> Fix two issues in the NVIDIA Tegra410 Olympus PMU event definitions:
> 
>   - Correct the swapped MetricGroup assignments for the L1 data and
>     instruction prefetcher metrics.
>   - Correct the name and description of implementation-defined event
>     0x0197.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


