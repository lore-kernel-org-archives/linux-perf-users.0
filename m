Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF62A8C1;
	Sat,  8 Mar 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458015; cv=none; b=Or1krsHr78BF/ENAQXcLxk93KoGm46qq3zVsQXJHZ4Kdb+U88+KC0yO2t1Zq6Et8RFXDjpP+5SJGLQijy7evjCv7XKSf3ASawUiV4BfwVwPu+pSL5vS6NS+kQokf63EOF0/G5aJgZlMDPBeQdUsD6KE+TRmQuSkJyT4tBhG6aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458015; c=relaxed/simple;
	bh=2+idM9AajhMla8o4mCvYyhb7Yl5yACl9dS/uKmob9/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9vSzqxaAJJFkiyckSTZajT9S/BONQJb68gXbv2HbSMf3NNOehVXlXjdJuFi6NbX81AtxVkKCh50U+CHsFThX6iZYGU1+OHqeZB5OF35StiSX8UjDbv001UhZGtfZNWx+xfN1gOB0SHLBAxsCxd+nULvecOFWXEXZ9O2jFYl2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9dLgQwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9dLgQwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A9CC4CEE0;
	Sat,  8 Mar 2025 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741458015;
	bh=2+idM9AajhMla8o4mCvYyhb7Yl5yACl9dS/uKmob9/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9dLgQwZQ+ZJtpKZ6ULB0jNd1NUgKcEkeSX2JwRDhG8Y4bQmTSEhfTSo6NEk4XBGQ
	 syxF2rXZo29TTOutc97lOrGeDDaJ/40AldaoREwZhhIimlGUoHmuSHiqbMFbuAKCK8
	 C/HTHDo27wtOX3laFRPF618FNVm5YBASYCKbYYbxla8jOfHztO7r/LbGak8FjJX4Ri
	 kVyReZIy8Eyqis7kl3GtMuParqAcjwe3255cYjfWsO09vS34muMqZJBFinlMbviRtB
	 qnfnfq8vgC352xNXYGBiItztqhRteTNz7iPDeL+75T8HS5ri1guOwR5bUeFGu/yWMX
	 /QajX5kytIbKg==
Date: Sat, 8 Mar 2025 10:20:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v2 1/2] perf report: Use map_symbol__copy() when copying call
 chains
Message-ID: <Z8yKXPi1YMc_YIFD@google.com>
References: <20250307061250.320849-1-namhyung@kernel.org>
 <2719d1d0-6e1c-48fd-b73e-42b78c51b201@web.de>
 <Z8tudline_-qNJog@google.com>
 <d2b2716d-b482-467e-9653-9219de40bae8@web.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2b2716d-b482-467e-9653-9219de40bae8@web.de>

On Sat, Mar 08, 2025 at 08:56:37AM +0100, Markus Elfring wrote:
> > It's just two patches and they are independent.
> 
> How do you think about to offer the desired changes as single items then
> (without the context of a patch series in this case)?

It could be.  But they are loosely related as I found the issue during
investigation of memory leaks so I sent them together.  I think I added
enough explanation in each commit.

Thanks,
Namhyung

