Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4A1CAA80;
	Mon,  3 Feb 2025 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609352; cv=none; b=QP6kDQ2FE7I3UjYF8Q5ktbCswixMsMe818KslxAHr4UL4UlG6aQVrEbQp7Uc2jYFllfOMzLn8DqqRyJ5ybQsGXcQWNNIaWB5TwaQVBnSX2lN70LHDyO3dAzVWjlRQkaomuBjJlsp6PXsxkqchMVn6tjsvqJy3T45R3vSKStdhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609352; c=relaxed/simple;
	bh=FuknJvZINB2MhejnfbzskLxCoUIZsnM2PQVADAIMXFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bbWz7oKiYX9Kzgsw3/m2hHCHPTrtSJtXJFtZuuh1whWD61j6ebSw5R9QE4bWDbpVs0ogwCXX1r3wkLYMNRnbgobh86X/P36ezHrZUBZMNL8fdHt90Yz4AdsiykyGuxqq1Wy5IGPMNggYBaxSPMhnk83Wmocy8DO7rj4EH5J6JrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTqUsn1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTqUsn1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B16C4CED2;
	Mon,  3 Feb 2025 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738609351;
	bh=FuknJvZINB2MhejnfbzskLxCoUIZsnM2PQVADAIMXFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JTqUsn1ZeCmisYfmCeZYfuXhIde5S27ZSa8+vTYk5AgA6r5eXI3foWwWOhOCDW4nn
	 m6CGg8AkV5UMLB4BhuixZAKPY+pL7uc9JsgS4JABOjcp6BFSPc+lcK/WBbBOGo+a9j
	 bV/DqrTE1QpSE9s+ifbSwFFBuXXRJfIqIlZr1Oea+0AQa3rw5v8wmq7Z/yVjpo0L1x
	 FW9cX7ufqlXT4AjfDjVdesYW1rRJzVgx7/z6fWpL4I3gvfBmyDLpls2ufzUMNjeuh4
	 E8zX4qEW1meVf9RzPLxi62+iievxQE7vEbUPH+FCQ/YfxVXEigJo/JFTj9pgzQ/xfG
	 CJi9x9EEqfJlA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Cc: Ali Utku Selen <ali.utku.selen@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250129154405.777533-1-james.clark@linaro.org>
References: <20250129154405.777533-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf: Always feature test reallocarray
Message-Id: <173860935114.138188.17102084306556571882.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 11:02:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 29 Jan 2025 15:44:05 +0000, James Clark wrote:
> This is also used in util/comm.c now, so instead of selectively doing
> the feature test, always do it. If it's ever used anywhere else it's
> less likely to cause another build failure.
> 
> This doesn't remove the need to manually include libc_compat.h, and
> missing that will still cause an error for glibc < 2.26. There isn't a
> way to fix that without poisoning reallocarray like libbpf did, but that
> has other downsides like making memory debugging tools less useful. So
> for Perf keep it like this and we'll have to fix up any missed includes.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


