Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1E1D5CDB;
	Thu, 20 Feb 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075973; cv=none; b=G443lUrEtXpykPyjKLdgHZPy+QNb0+yINbs4SraOMuTX0BIA7SXXbahfpU+0e2sBBNbIb9YGnCFNDn24ShmjHNVKxeRH+lobtaB5mn9xzy3RIYssPt1JWIZNpSMh5CVMWu/XY2DKk4tVJMxI4eBn4ABqAY+YWNLS4EmNG55WoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075973; c=relaxed/simple;
	bh=PP43OYuPlNHNxFvSCHIJdG/EzfaJf9/lwR9yOfRdtqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l2sCvXR8CXbU+r6l/aEWXdrRS8uX5fpRRbiT/KkO6pLdBa9hvU1LlmYDtKK5LWz2N+dgCCzuG1rOUYBk9p4KhIN55DCKgfRC9AVrp6KmfAPJB+dLyAt1sCCxLYAP+n5T8HypsoqHwp4gj29xmcAH59uLrvLrLKEUn9Bvpt64WQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnxopEQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnxopEQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E55BC4CED1;
	Thu, 20 Feb 2025 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075972;
	bh=PP43OYuPlNHNxFvSCHIJdG/EzfaJf9/lwR9yOfRdtqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cnxopEQOsy8P6QjeRX4Eb5RX2wIKeM743Il0ABPpvq1thyxDtIiFDWlAZAVIjWjTo
	 /A0idObPQzCx6O6D8liBpN7SUMavHr7Xkx1ce5c/VoFMlp+ROSw/smYe/2pnq7BvUe
	 /xdWjIbn2fLV3p8EirsXr83H/clWgEZTmYXMPZgulePPYA+ni0Y+P+I4WHQD8l0cT4
	 6BbrMp7RoP/ihgNrBAgmEdCBekPIddVEhp9Ilk9AGGbAZALq2EkAwA0E22oWyGzU6d
	 Z6xxpsPytoG6YTbwv7cj7RGnKDq+BurZQaoEyvHIydLR3guPy3pNHWDqgXS51Ht5DH
	 ggTbZi/S6V3HQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, irogers@google.com, cyy@cyyself.name, 
 James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250219151622.1097289-1-james.clark@linaro.org>
References: <20250219151622.1097289-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf list: Also append PMU name in verbose mode
Message-Id: <174007597241.1790567.5642220302421438732.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 10:26:12 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Feb 2025 15:16:21 +0000, James Clark wrote:
> When listing in verbose mode, the long description is used but the PMU
> name isn't appended. There doesn't seem to be a reason to exclude it
> when asking for more information, so use the same print block for both
> long and short descriptions.
> 
> Before:
>   $ perf list -v
>   ...
>   inst_retired
>        [Instruction architecturally executed]
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


