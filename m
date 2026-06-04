Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30135B650;
	Thu,  4 Jun 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604214; cv=none; b=bb6cgntS454JFYgrCLXO1jpam4RwqQSbOFnNUzOpO+NRFOO7YXUdmbryxUVUWAhMdXlvtVSpbnNbo4wbLGg5q5nBrp+wf3y8E+h5msYCFYjvJngzVSS2AVMNibAqY6gU8St+zbAeVafHzEuhqM+FI6TwTLLURPQHLIlMdSRrzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604214; c=relaxed/simple;
	bh=VsfsupEyoCZmkv7NLZUpqsNcxv6OvYq+CDiaze7h+CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fcx0/APvOInMt7JQmJBubeVbRh8qBqYpA2tpicYir1cqaG5T01OxipxrBmp4P2DjpIjerBudpf43FzuE89J+UzKzIC3gyzu82Nd291zv3j5txnFdCQsPo0n5p/Dqu2Q40my/xfxWu8HQwTszI9NdWzCuwrWRzWsdB7UCGdiS97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHs1vEL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHs1vEL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6532C1F00893;
	Thu,  4 Jun 2026 20:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604213;
	bh=3X/zLk3Uc/HrW/VcGK/2oDk/FdFUYsbXrNUQ/Gxp3Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHs1vEL9oS4rkYh4mWpMSqhahv7MORs62IHTe2fJR5P59hKQ2GooGlX4b7ZVni4GC
	 SER7ODLuC2JQq2hvDWnQulx3LtbRC5m+dEwR7Y/az8XRef4DcjpDtaRjc48N8Qv9OK
	 fzOTYqP7osk1mRNFB/CI23t55dEMPJ6hLwaBZHXx+sIBMv6Ma2VxGYDQEvx8m7ULDs
	 3A0ATz98vs/pvlMeLw49EgSqGCPq0MtB8XmEjI36U038VncvgQ6JQY9JqpEykDG9Zz
	 QE3uXRD1ne3NyYBQ8CrP49Hk6stVS+45nbzBYCWlVGeO8jPmwBF/pUnM5ja33wnJOH
	 wYv+TgFcVbbHQ==
Date: Thu, 4 Jun 2026 17:16:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: Re: [PATCH v3] perf lock contention: Allow 'mmap_lock' in
 -L/--lock-filter
Message-ID: <aiHdMc19GTUOKEaH@x1>
References: <20260604172839.2105596-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604172839.2105596-1-namhyung@kernel.org>

On Thu, Jun 04, 2026 at 10:28:39AM -0700, Namhyung Kim wrote:
> The -L/--lock-filter option is to specify target locks by name or
> address.  It's basically for global locks where name or address is known
> and fixed.  But 'mmap_lock' is a per-process lock so it cannot be used
> for the -L option.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
