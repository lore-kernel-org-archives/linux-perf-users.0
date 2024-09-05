Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E49443
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549956; cv=none; b=e0EBv3vaYeTohrueobmT8q7psqkjUAqZOh9KEEBA/ADHNorknAQF9SjtABYuVEmn2QD6OWb+197jvGCYLLQJ6MgBihxWFbYwVy1KJfFaTplhZpO3Q6bYnqYvHijMZy/Q8cHv2qxIDi52namDYPY+54GzzaaW06M+hSHRyqE70M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549956; c=relaxed/simple;
	bh=iriroBusaW/ja43I0Lv+MaWGqHnVGuDI+W6WvRHsTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZmxxofBk2E55NNcuN/1K4yeaGOed0hP0RebXeciO/Q5LWrBQbPYCCYeiTEkqyBqXk3JczQzHG7ldlImnshdJ3tz6cLwOQb50Shmjy43Ia4QVIj0SuSehMGYUWDVgUJcbM4iMmKXqQJOW5ddaS3QINrEqHgzloTAHTegb+Lw8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7igGvhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7igGvhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BA0C4CEC3;
	Thu,  5 Sep 2024 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725549955;
	bh=iriroBusaW/ja43I0Lv+MaWGqHnVGuDI+W6WvRHsTEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7igGvhFELYvRRm7TZwjgcMLDgUY/N20S8r1HeXXQ5xPgNGP1zcgRZcBNOZtX7AQ1
	 NwoQwOQ5r5KbuHn12D2PIIRrp69RjjfWzi6jMZubAkxQ5wasCaM935EhqCKo/bsCZz
	 G7iONaljbrwsYvAjRNAE7YRovM+iKAVt0uUYi04aPoD6ssNGYEVuZnxw4KEET/U+rw
	 JaURVfGeNvmvl3GFylyXpsbG0vWUO6AFJFKIKntLOgLYsUQUkckE0VUTnKsWLMWWW3
	 yRrLyvTARto8FYJ+vh9ZypY3W6u2jF9Ys0i7eSwTZKY/kCh9n4GzFW9e2JG5m/BsDU
	 2pjtqNZfbCS+w==
Date: Thu, 5 Sep 2024 12:25:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	namhyung@kernel.org
Subject: Re: [RESEND] More dwarf support in python interface
Message-ID: <ZtnNgBvos91bMpyb@x1>
References: <20240905151058.2127122-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905151058.2127122-1-ak@linux.intel.com>

On Thu, Sep 05, 2024 at 08:07:54AM -0700, Andi Kleen wrote:
> [resend because I typoed the mailing list address in the first try.
> Apologies if you see it twice]
> 
> This patch kit adds better support for resolving DWARF from
> perf script python scripts:
> 
> - Add new perf_brstack_srcline / perf_ip_srcline functions
> to resolve full brstacks or individual IPs.
> - Support the DWARF discriminator in addition to the line number
> - Report the inline stack to python
> - Report the build-id and executable name.
> 
> Most of the patch is just plumbing to pass all this information
> around.
> 
> The first patch is a bug fix and can be applied independently.

Got it, waiting a bit for the rest.

- Arnaldo
