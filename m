Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCAA217704;
	Tue, 11 Nov 2025 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821178; cv=none; b=iM8m3znxGrZVt2h+cYy1/PfGun5vkWuo2Dhu66a1S7sfWFJ7USdIul0KdWnfx6Jhnr4reJS2p/nyDxNTDxKPONNcGwblFNlOVw4P27NuUBYx/blQSNFyGquG1eOpRHOZuqocYhlmZH2AhyOjPQxP+q0+VwDWi7P2g3zCaOIajuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821178; c=relaxed/simple;
	bh=bC8jNFIc6+4J9pipsXJlcQn+LZNzRA+JYVbrsF20VUc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kn+UwquIQJdLawtggeD946noPR7MDG72cw7aZFjCtDh1V3giUggzGIoSQotLzG44MoseElgUMFHshvW/NE04Lvp62avEepki/8pc5ptZzBv9keECq2p2H38YZjHX5KlCnMaUw6y/40TVXHpRxWuA/UeyFvn2YwcdqsdCcmepILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIekzkNB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIekzkNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496BAC113D0;
	Tue, 11 Nov 2025 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762821178;
	bh=bC8jNFIc6+4J9pipsXJlcQn+LZNzRA+JYVbrsF20VUc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rIekzkNBC07m1u883s/inDjJav+mlzGcLfNBp+znswjR0/iXwYUbnqrWqJAdpAZNM
	 RfT//vIAQqqOofwavai/EhsW9hUYyFyzUt6XPBmYy9XgnpdJwYXia0XOWWsJuZOvsU
	 YCTH+u+Nku/UnhbarhtxoP/5xFJgJ/oOUQFDqEksySyKNonVkzs0wgRH86pLrT9ZjK
	 3eCNUXwKS3/Xr42iJJq0sQ01K9BtTzMMPMHYeQwX0SOpITn36ZscSVyqcMB/vZA0If
	 5hiPFP8+RSkGMffBJfOjha2gPWAlSjNMrBaZPdhvc6ZEa235Q4KMTEczR3jnF8J80z
	 h99bNrdJi8mRw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251109005959.2540616-1-irogers@google.com>
References: <20251109005959.2540616-1-irogers@google.com>
Subject: Re: [PATCH v3 1/2] perf pmu: Make pmu_alias_terms weak again
Message-Id: <176282117718.883417.18438690676356695984.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 16:32:57 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 08 Nov 2025 16:59:58 -0800, Ian Rogers wrote:
> The terms for a json event should be weak so they don't override
> command line options.
> 
> Before:
> ```
> $ perf record -vv -c 1000 -e uops_issued.any -o /dev/null true 2>&1
> |grep "{ sample_period, sample_freq }"
>  { sample_period, sample_freq }   200003
>  { sample_period, sample_freq }   2000003
>  { sample_period, sample_freq }   1000
> ```
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


