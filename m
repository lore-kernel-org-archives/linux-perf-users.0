Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516D1E8346;
	Wed, 12 Mar 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809233; cv=none; b=py63Q2B+zcJi/S1QVsLLGD8pSW/L3pxuXtQTxKSniiRYFYEuNJSkSPktnGEit2hMFMn8qLjWuUzYbKSt532uGtYcQl1gSsI27zAErDEGMHtB1GNtltEqdGWv1e8GvV8o7/09+/mO5fuAzDpjpqkxhhIq1HsTG7siOntQqWOplrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809233; c=relaxed/simple;
	bh=T17z7ZZgBrdvFAyiwQUxd/nAm4zqegF5ywX2Di6uSZE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aW7vg/8jARoZXuRm8zB5NsQp8tOA23/K1X7bRYVWZhB+1CtuXtlmDlhq2sh4AWQadxKn7nHW52dd0Kku2lelocuSHEbIxatJvMfosXBskYYWdlRAbIHjB9ZEYtZCpPNsnkjMeKe48qJm6AAWc68My2/qeMauujl16nDF/qZm1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPQM8VTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPQM8VTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276C4C4CEDD;
	Wed, 12 Mar 2025 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741809232;
	bh=T17z7ZZgBrdvFAyiwQUxd/nAm4zqegF5ywX2Di6uSZE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lPQM8VTSIIPVSNrpygoaXTPNRVy55y6Ui/P6+wvFKhkECX7cIPUCykyK7WEzcUZ5t
	 UKhWAxKS3fdwM2cRyC9ng+lKKE718Q0CwDXSwn+gvh3E19pStCGmGLKzi7WVE5/Uz/
	 pntMUmUfQwt7rtpLWv7sbC1z0fChVAD6RpV1DUJtl3OvjSLaIRP1QgL9iJz6OrtOoe
	 hPCQJRwHx3zrt7lpLc1fOHG2go4HotUeUcEsTKruKc6nZ6zE4KC90PBDfblBw3oeVz
	 30qnqoh1RdRyAEeUltg4gAuLkSJTRaqAyE0nl/oz80Ru1ARyJD64o4bOSbL7H8AkK8
	 sa9J+wYmC8eIw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 James Clark <james.clark@linaro.org>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
 Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
References: <20250228222308.626803-1-irogers@google.com>
Subject: Re: [PATCH v2 00/11] Python improvements for a real use of
 parse_events
Message-Id: <174180923210.2923844.7937416471195450232.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 12:53:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 28 Feb 2025 14:22:57 -0800, Ian Rogers wrote:
> While parse_events access in python was added, it wasn't used by any
> python script. In enabling this for the tracepoint.py script a number
> of latent bugs and necessary improvements were discovered.
> 
> v2: Fix a whitespace issue on the evlist.config patch spotted by
>     Howard and add his reviewed-by tags.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


