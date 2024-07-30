Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB71AA3C1;
	Tue, 30 Jul 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368407; cv=none; b=lKwrtZPfz4wRv0a5SmuJ5F2EH7HLoukESSY5S9dvTD6CBluSnyoqmI5wy8mK9P40UsEFPHxHK0Dhm+uENx7kISYtMBB8r8XTqiSCLTsSjCtDFMzh1wgBchhZle+QecXwIS3Fijvzqi9ISB9iTifqJBuWQuh5Atv4m7zAd4LLKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368407; c=relaxed/simple;
	bh=6B5XsX7IYMmuFt+49nvMLh0u66zrny/uFMQzyKZcYYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sulaGyOC20vZM41YaG3pp6eMrsO1ol/Icn+bpR6sS8FaEwf+WRmBR7T+GB//No2PqccpRUwrggUCdBevCj/34EnrofhsJboIrTRNIUp+JcjANq86MBqC80ABVBllO4Ko/rLHBiqdlvulksIlnaur5wELd1T9t0boPScAswFJNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpMHQc8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpMHQc8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D455BC4AF0B;
	Tue, 30 Jul 2024 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368406;
	bh=6B5XsX7IYMmuFt+49nvMLh0u66zrny/uFMQzyKZcYYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpMHQc8MlUffhfQJK2jZy5HuWyI5n/uSvQ0qzOjEQvEx1ByRB2zWjhyecRqObEct2
	 OGUuM7dMVMZPf6Z8xU73vi6NMUhvxPYug4G6mLvSdGZjugJffP8cpE5i4jXLpSOhrw
	 urkZfso1ONhR1c0NYtmcC510djhLJ7Mqt6DDZgQnmBqrtSQqxJT/CiF/LHgVvPPbvy
	 +EbNU1JldlokXKDupBGy+xZu6SYhXTPhiQphG5/DbH5gZpHutrRm9G3xn18dwpI7lA
	 mixNi7qU2SmpiQZ83KZZ82tYd3hB+2hJ/J/lUGYUqSqYHcZIpdoDbOoSYpEURAjDEz
	 69NNH0U4iewIg==
Date: Tue, 30 Jul 2024 16:40:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Small changes for perf tools
Message-ID: <ZqlBkspp7pbo8rma@x1>
References: <20240730062301.23244-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730062301.23244-1-yangtiezhu@loongson.cn>

On Tue, Jul 30, 2024 at 02:22:59PM +0800, Tiezhu Yang wrote:
> Tiezhu Yang (2):
>   perf tools: Fix wrong message when running "make JOBS=1"
>   perf list: Give clues if failed to open tracing events directory

Thanks, tested and applied.

- Arnaldo
 
>  tools/lib/api/fs/tracing_path.c | 2 +-
>  tools/perf/Makefile             | 8 +++++++-
>  tools/perf/util/print-events.c  | 3 ++-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> -- 
> 2.42.0
