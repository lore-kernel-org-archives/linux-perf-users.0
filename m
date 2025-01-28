Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF11DED68;
	Tue, 28 Jan 2025 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091725; cv=none; b=HP51h2I+NZjKA3SPAk9uYcpRDS8EuZ7KXS7SdCVXAdPqvOv0jl744LBTH960UxoYvsWclkIuLyfd1DI6Bbvxj/ZGcZ84G6aysHPVdle8NMkOngeEJki1PzfaBgQNtNwbQ4VR3maIZ9OkZuq5/3LvfBa4IAporoAbW8ZmdaGCLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091725; c=relaxed/simple;
	bh=kU2V5BkpD5AXJFkq2dx3+21LvAiAq/ezICqbi3fHJEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K4tGb5dWERLEozHLjOgwdLX9mNRqD7f2xYwJ2yciDFjdQW8gfp6fV2fOO9v4gv0SikAnv7UbhwbR39GUyk14OtjbmtiVTI9pLPV3h6C9je3WKvCLSMikQ0CqFdqY7Qq8wdP4fbkMErMP87AtLbvh3HMUTWlE11LbSxeGuLHLdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa/Nfxqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa/Nfxqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0603CC4CEE1;
	Tue, 28 Jan 2025 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738091724;
	bh=kU2V5BkpD5AXJFkq2dx3+21LvAiAq/ezICqbi3fHJEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qa/NfxqqtQEuOIFHaX7ny7N1zT/09cpi8//ecyFKWIkKKXHai1KCPWymJZXKllkKa
	 vHY1QQfPLtes/DJodZvaeyzdTtf3YcP/BVPiAeLZiDlrw+3GFugLJiVVAcm4d1UCvp
	 DTZhj+YbVcN/t6bgA1SBuSEXqtnNifRX6b4v521Ic5cidLUYF/U5eIc75nMcLFXcYh
	 1/a8u91hKHLJJNTstF098lICRzLxD7XyfOEbT3p9wWjmVPiTtEr/TrWXmAYputwXgM
	 /KnkliDpEPf3dzzhEpDkDZ+0WqJOE0np6LivvimRgbb1viYD6KiEQCTxdAi2FcuUxn
	 me5wxXfMFQTNg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20250128170629.1251574-1-namhyung@kernel.org>
References: <20250128170629.1251574-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf test: Skip syscall enum test if no landlock
 syscall
Message-Id: <173809172397.948154.11710273039435718570.b4-ty@kernel.org>
Date: Tue, 28 Jan 2025 11:15:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 28 Jan 2025 09:06:29 -0800, Namhyung Kim wrote:
> The perf trace enum augmentation test specifically targets landlock_
> add_rule syscall but IIUC it's an optional and can be opt-out by a
> kernel config.
> 
> Currently trace_landlock() runs `perf test -w landlock` before the
> actual testing to check the availability but it's not enough since the
> workload always returns 0.  Instead it could check if perf trace output
> has 'landlock' string.
> 
> [...]
Applied to perf-tools, thanks!

Best regards,
Namhyung


