Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF022E3F0;
	Sun,  2 Aug 2026 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785649593; cv=none; b=tOiL03lh5mj4QDTVBKQ1wSLyBt6DuvxELbGpLPklsfsaPA7uPnnhBpS2m9U66p6b9sIKlaHN7m2MrUoUBhzLkH13oPnIw7+6vgxs+HhWzf7asnovn9XYkeDrZaiLDk7+TOuKVZ3qm7r25FrOV3phCF+GhteCXg9V1QM4R1T5z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785649593; c=relaxed/simple;
	bh=se7sQejZXq8eQzcq25Jq8pouQJCxEcGvFFH+nQyFiYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dxtbQVKooTNnh9ReW9MWVge8WC3MANOhmlhIS/1xkgkAH3ga1RUVBPlPO/aovvyWjgdHGUZ9M6OXlnwDy4lvA6WdQiT76NqfE9rjvYynfc8a85UtYHSsgeaEaE/QBBz+nUjbzLcXIsvwDQsUj0eAeb/6Cj4b6tGFIbMd9RkrrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4KU2HeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4KU2HeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A51F00AC4;
	Sun,  2 Aug 2026 05:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785649591;
	bh=TBZpB7ixj6bCt9she0aN7Pt3icHcDcBFL/UsdzEOfzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=H4KU2HeKWLjWNWwEq/MDJCy3BfENVkI9Z5MNjwW5F3bM3gh9KCQpafL1ugQvQDziQ
	 NVJXEgiS+As/4/ZK5VX14gR5ilbnSCBTsLAmv8t2CDsR93ElvIAUReEBDpNetbFxoZ
	 rRENU9cOQwVB9Xno99DOXyQOIOUOLTXiwN3Yh10okFgiaaLMLEBpCIBWGb1BFneos0
	 XMCgwxCra2nfyc62B1yW/NkhOpnEf5P5jp9ptXJecBBuKkxjxK2ix8aa7BtAADkpyx
	 XhUQu7fxLAWJvOQRcAe/cusKANWr7uHUf25Rb3Luv+7R7DvWh7VUIotAwRuJMoZZS7
	 376kjtM48wixg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Alessio Podda <aleph.pi.gh@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>
In-Reply-To: <20260724154057.896074-1-aleph.pi.gh@gmail.com>
References: <CAP-5=fVpWMOg8PE_b9or5PHwLBY0H1UNOZRxUXR-5=qwEW2M0g@mail.gmail.com>
 <20260724154057.896074-1-aleph.pi.gh@gmail.com>
Subject: Re: [PATCH v2] perf unwind-libdw: Fix unwinding of multi-threaded
 processes
Message-Id: <178564959113.665203.10711182524144920172.b4-ty@kernel.org>
Date: Sat, 01 Aug 2026 22:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 24 Jul 2026 17:40:57 +0200, Alessio Podda wrote:
> The libdw callback API has two levels: dwfl_getthread_frames() first finds
> the requested thread using the next_thread() or get_thread() callback and
> then walks its stack.
> 
> Since perf only has a snapshot of the stack of a single thread, it
> provides a stubbed-out API that always returns the pid the Dwfl was
> attached with (i.e. whatever was passed to dwfl_attach_state()), rather
> than the actual sampled thread's TID.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


