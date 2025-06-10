Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA0231825;
	Tue, 10 Jun 2025 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580739; cv=none; b=kDMW2V1up0Xlb9Y+735cuXeWQZRxWLfdqup8II1CJh78p3K21JgbuUI/bPq2fMMywdLMi3XMKCfz7kzEJFKljngTghIvSNKuvekbSK+1p6pG/p0ynCa7/bTCt1dbmFhc5EiChauX8E2SsfCB+PZbYG1RIfeh+ibTqKt+Ooz0mD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580739; c=relaxed/simple;
	bh=WwbhyVyzMP1DBXpUmnNFe4g0dv0vDRqgxsMdg3A4B6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=swGH+NqwbC/p+HZkFmOrPEBd6ai+Y5FpVzu0cimMhR66u2ao72mCH7mv9LzC0Rzl79NrcTk0XD6aykQ3ximMImqB+Ta4ymVP/mQNAegAZvgQJN+1lIR+XEmK5vMc6xCdKgl/atDj2kUO6A9e109fv2A1SWZKnNNugJu3Zc+HzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dptEaj/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dptEaj/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF71BC4CEED;
	Tue, 10 Jun 2025 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580739;
	bh=WwbhyVyzMP1DBXpUmnNFe4g0dv0vDRqgxsMdg3A4B6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dptEaj/jojU9Forejnn9h+T99nt955Z7N07HqiUsqNPr6M30X8iJKxB7oCzPhKIHn
	 cV3qmaq6weiL2QpeSauYHKoAl9noRmezdDLwPHIsvy4Pr/iPfsvQ9Csj6uMSM4rNaV
	 yFdLHbu9ySeszXwq/ArS8Dv8OkhzOzRiLJ1Lqut1sgpqUI26TrythurDRkrxG0/yVd
	 KAifl71Ox+dCeK9LAUYR/c0SduHJmY25qxk7R678sBby47Hvldq7va+IQHcP4S8IM9
	 KoZkvcf+62eU9+xeu6yX+2pk0Y6d8iChK6jBH4gDBp4I8If9qxoxfwQBF+9AY3Wu6Q
	 p5RuXSyCVmMZw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250604174835.1852481-1-namhyung@kernel.org>
References: <20250604174835.1852481-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf bpf-filter: Improve error messages
Message-Id: <174958073883.4039944.15365887459982691266.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:38:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 04 Jun 2025 10:48:35 -0700, Namhyung Kim wrote:
> The BPF filter needs libbpf/BPF-skeleton support and root privilege.
> Add error messages to help users understand the problem easily.
> 
> When it's not build with BPF support (make BUILD_BPF_SKEL=0).
> 
>   $ sudo perf record -e cycles --filter "pid != 0" true
>   Error: BPF filter is requested but perf is not built with BPF.
>   	Please make sure to build with libbpf and BPF skeleton.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


