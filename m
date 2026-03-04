Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996E3BD62B;
	Wed,  4 Mar 2026 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633611; cv=none; b=mAfOqSHjxSbX3Yu1PfO6Fo30HabNH5hszMIL3Ai13wz/1vgRyvT43c+JttY6G5VkBnqVdq6tjxn7J+4BA26JmwXnYuW33EyFyxXFt0E3oLdb5l7IHWiUWwJtjctlE4pd51iL0NORCs36zXpNIT+Nr5YSxnM+KOXyhD1XLmHD+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633611; c=relaxed/simple;
	bh=d9PIsSZd7uVzzY/HxpBv9BDACXxBfjT/nqQ6wkyowo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5b6i5vasfXfykia/sotRA+E75MD0uoZf9Bp3HBGNvL5PtZoFoVG/gd/dl8HU8zS2pY7H/Xxmt5Tbor0l05ZlclNnh2P9zeDCJXjER+4oJbX+sZBgZxMP2/3SU0fGju2A50InlAwMtm3cn8Ca8Of9YksFzCA6mN3xTg9r0yqyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enPqFZzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enPqFZzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C78C4CEF7;
	Wed,  4 Mar 2026 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772633611;
	bh=d9PIsSZd7uVzzY/HxpBv9BDACXxBfjT/nqQ6wkyowo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enPqFZzvffkqgsBqwyCXzpeeTJ2SuarxkAQ217BjD9LY1LTlzDwRSn3ja3DRPEI8c
	 23VQbGNVmbt1B6vZ7KXKfLaa/fsHqR/1X+xSKJksr+8Noy6shBQlbyWnvEpBVdOwtK
	 lsoCz1C1E8B5H6wSkTlg1j0CxroABLRPLMPCF88PZ5gbWGcvnn2rGXCv9WrnYcBrN4
	 cY4l0eVBgs2LayJ1Pt0+00TzKMjXrKHb5Axfu3iPogNHylflsZCNCkH/FALHa9As/B
	 zl2RmcITflrcpYMwsamUol80rd6bqEaNeZ9UrJwpjMmf81s4AXWyYkS9R3TjnIeiHv
	 hfE74CrtzY1aQ==
Date: Wed, 4 Mar 2026 11:13:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Changqing Li <changqing.li@windriver.com>,
	Namhyung Kim <namhyung@google.com>, namhyung@kernel.org,
	james.clark@linaro.org, charlie@rivosinc.com,
	linux-kernel@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] tools/build: make in-target rule robust against too long
 argument error
Message-ID: <aag-CNeYM8q4HskX@x1>
References: <20250728093153.2330009-1-changqing.li@windriver.com>
 <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
 <ef286bfd-0703-4393-87eb-4b0a85084767@windriver.com>
 <00dac1a5-16b0-4b54-8525-c0c706f08626@windriver.com>
 <CAP-5=fUCyYVg-h=YuLy9HRDWzvc7Jm3a9tZM29Bez4R-eTBSOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUCyYVg-h=YuLy9HRDWzvc7Jm3a9tZM29Bez4R-eTBSOQ@mail.gmail.com>

On Tue, Mar 03, 2026 at 02:33:04PM -0800, Ian Rogers wrote:
> On Mon, Oct 27, 2025 at 7:16 PM Changqing Li <changqing.li@windriver.com> wrote:
> > Kindly ping.  Could you reproduce it?  Any comments?
 
> Sorry Changqing,
 
> I was reminded by:
> https://lore.kernel.org/lkml/20260303211503.165337-1-mmayer@broadcom.com/
> that "argument list too long" is a problem for others.
 
> I tried reproducing it, but I think it doesn't fail for me, possibly
> because MAX_ARGS is larger on my system:
> ```
> $ xargs --show-limits
> Your environment variables take up 6133 bytes
> POSIX upper limit on argument length (this system): 2088971
> POSIX smallest allowable upper limit on argument length (all systems): 4096
> Maximum length of command we could actually use: 2082838
> Size of command buffer we are actually using: 131072
> Maximum parallelism (--max-procs must be no greater): 2147483647
> ```
 
> Anyway, the change makes sense to me.
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Ok, so I'll pick this one and the other for rm that you mentioned:

https://lore.kernel.org/lkml/20260303211503.165337-1-mmayer@broadcom.com

I'll have it in perf-tools, for v7.0.

- Arnaldo
