Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424175;
	b=AkQ6Azl3Ze94aFDyF2lmqzIhT59bvX2oTZSPINkIkX8rZFU261aWo4VWIupy+Ah3ewGm
	 RWAqy9rd0kABkrVY1iiwsH0cVOiskPRm0aq3ZzX96HrnEpXmSkgIu+EJmSBwAHtWYdOtu
	 gLxmF886rd83vBc/dcw1m8V/jdrUxn//7eSUOoCWsp7dg01LeNrXRd765CKifyAM74HbX
	 VMuflIWz68YMr05CxALt2scAE8vICWigAKmg5r/ebLJ8j3VxtIJMIoJRP2H0hIPxpuyXK
	 95MMd/6oPlXnqI04k1WIlcIhSaL8nH+N7ZLqXb3VFDwiqG9ynUUKMnlk0jgQOik0IGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424175;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=su/OSGH3o3MLwTj+8nkFYFF/21RU8CHFM9EYwvQE5zY=;
	b=jdwOGeA63d3RMs0U5VJjAVXF4yfyjtu0tMjPsNY/pNp+szhMJxRUYju+oiieHdO+8c6U
	 y6+NSAZLAF2rg9UBzieBYrdzk3+1cQ/3tMNL6/r5K0isiuinXh7/1zFNbbA+9Hmjfq0cL
	 5aFqhZdJK6bHUwAfYr9kphbBga4ZWrbcBCWJbvM57stahJ1LLq+KDO5zbM3xDKaSYCqSA
	 a+upMysxBiac3JrkjjYfLg1WWJE9sBlMLHWskcO3zkSQGiUejhleUE3tS1+kvqWrsHmKY
	 B8MWqFFLseqL1UnErCtTymSKuIRN7QSKJ75yoETJJnzMWXb1q2qEIxl2g71ZMP3JwHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPiXsdRi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04156606A8B1;
	Wed, 11 Nov 2026 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPiXsdRi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413381F00A10;
	Wed, 11 Nov 2026 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424174;
	bh=su/OSGH3o3MLwTj+8nkFYFF/21RU8CHFM9EYwvQE5zY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=jPiXsdRiA0pPH2dhL8KZOEIMQLhL9tpT6pbGPjHcApmgk7JyLXSKcdWjoqwJJjYGE
	 bEzRncO3PUuXF05XtvjyT8sN9yfpqui+x9EmLvubdEmIYhO2BC7VB5MWWUmqI/z6s1
	 7GXE57oPxRv+2gaHVc8XbFQMpibOUhEKWpDeB0DLCGl17BFRVe3dUQc0QoQzVp7ICZ
	 RdIROTSgv8xYfVPvJcaya9w33oZPauyb5/csh7sgch4IOzk3JnLMvD4fmV/uWDq4Ap
	 MKkWiuROrKMMG+mMb0uMSST7zZdZzIPWi4mxpTeniyWl1423mNceD8XGA1eGmSZgxC
	 WekdiB3HVyPzw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lirongqing <lirongqing@baidu.com>
In-Reply-To: <20261105080429.2472-1-lirongqing@baidu.com>
References: <20261105080429.2472-1-lirongqing@baidu.com>
Subject: Re: [PATCH] perf iostat: Do not compute interval deltas a second
 time
Message-Id: <179442417410.676192.4506999525247903583.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:34 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 05 Nov 2026 16:04:29 +0800, lirongqing wrote:
> process_counter_values() now computes deltas directly in evsel->counts
> for global aggregation too. It saves the current cumulative raw count in
> prev_raw_counts before iostat prints the interval.
> 
> Subtracting prev_raw_counts again can therefore underflow the count.
> Worse, replacing the saved raw count with the interval delta corrupts
> the baseline used to calculate the next interval.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


