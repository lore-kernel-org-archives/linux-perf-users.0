Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC423ED59;
	Tue, 10 Dec 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854646; cv=none; b=r6Koaumo/1cqP7zVhSoseKbNxJICmJl1BzqGAtvTQxQUuG6fxZPcbxID5nzW0CEDK2i9kBPwsRVoHysF1RuRooI3kmRH3wFQlWJAlY72N4TiTS3/QDErnDA3zt1vOcXaZPm0WCdeKWC+XMoyAG5K0vJOz3as1oV526MqJEL0TtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854646; c=relaxed/simple;
	bh=jN756xLVBFxNxpzSE64UVqN6NuUqd49ydB11a1N3dIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fapmFQ7ewUXiNMJTf3pxI5HFh+DU0pwElBLRt7XSWOcqGa2MsuutJ9ouUKsuGbZb0G+I/afAkzKCfGrgPxkL/PzqUhQ+xfnJ988K1bEm2NI7w+0mjnobCNa3UdCSbNV2FZkHpcMvymsqErX+SFOTb17Ps0uKtElCokLLJNYnGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEqVO4SP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEqVO4SP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FC7C4CED6;
	Tue, 10 Dec 2024 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733854646;
	bh=jN756xLVBFxNxpzSE64UVqN6NuUqd49ydB11a1N3dIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEqVO4SP9BPt5gJeIBldqzX3p8Y/ruyTVW++MXZ1C7yppD0Rw1qcpc/g2iQ1NpyTh
	 Ocdzk5bgm/+ea83z+Yymk1z9j3370D3jc67oRptrMv+LHqiIw7/mCPqVZLnOcn6soX
	 U0+fSOt7SceXTiL3YG/z3O8ww3t0blhUNk1iJJRcqhyKo3/aZFPQaaiFrvVSEUqGHY
	 f0WcUBKbX5SjAOpEGvEGW2bbilN4f3rfOd1KLg7FBcEBYGeWMQXRevLf8jpRpuIozH
	 Sgu93ibA8wi3MEz+7ohFBx/0nI5iD5ssTbjOMQ/Q2zeFSIgBhPskoUpNiLmWr47juG
	 qTPHra/UsysrQ==
Date: Tue, 10 Dec 2024 15:17:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 0/4 perf-tools-next] perf ftrace latency linear buckets
Message-ID: <Z1iFsz-Jis6rgpjb@x1>
References: <20241112181214.1171244-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112181214.1171244-1-acme@kernel.org>

On Tue, Nov 12, 2024 at 03:12:10PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	Gabriele has been using 'perf ftrace latency' in some
> investigations at work and wanted to have an alternative way of
> populating the buckets, so we came up with this series, please take a
> look at the examples provided in the changesets.
> 
> Thanks,

Applied to perf-tools-next,

- Arnaldo
