Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962022E3E9;
	Fri, 21 Mar 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581808; cv=none; b=aZM5alQwTVfKchvcnUvEpTbDGKMmA75WTwOPqEUahLEULx51fyuuXzV7g9fll84XTgsF8nnZK2x/Lf20B1aDghYYDjJ5oIvded6oGU/i6X6bKHNroUUaoL/8vVaugZeusJeeWdXq03V67a6sritRSETh5EUPm0GeOSYRXlfDdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581808; c=relaxed/simple;
	bh=T/S+1dcOLcMBe5RZO5eduTb7Lb0FyXwdceEDHiisI5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YdLC7Jw/+pIzewWkNMkjmtzJAIjBD1dGqBdZ6Ry2JEpkP6+WqLcYd/FlHTrSwbhY87l+xgr9lmgUq2VVlKSDvwzUHPn2nOrf5FhPPus8Me/0lkMA4sAoYFRLdwPwxHEow3i/6WbOMK3cwR51xqrFrU9N9Z2l90Zfko71z2oayZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brLvl+kS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brLvl+kS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C01DC4CEE3;
	Fri, 21 Mar 2025 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742581807;
	bh=T/S+1dcOLcMBe5RZO5eduTb7Lb0FyXwdceEDHiisI5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=brLvl+kSj9BXf3Ks5Tt2YY8hUX4PJNxxr40QoMEb8vahp5IdReJDFlLVmBT+BAZUJ
	 KUCeZHgTWh3wm9QrLriEIK4fuY3SnqnW1ifQkAC0Uk8p5LmUmhC0xpvzWTU7qtNHTT
	 /SgUNqF2NQJZHhFh0r35eSBFY7XwYn3arhkhINCEE41J9lBjwQQwa4PaS2IIAtzye8
	 Qgb0sBtlOdkHacQF45dY6RWGyIBL2i3L5bQ5ryQsST/hs70PwqQi9laTSi+mlzaqhn
	 IHWxxTwpfk6d9yGGHNpKT87D+lGxz/n6LI2oWWV9IFgmG2Oif4snYUHTQfEoyNrruo
	 e33tP21sm2fDw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Dmitry Vyukov <dvyukov@google.com>
In-Reply-To: <20250307080829.354947-1-namhyung@kernel.org>
References: <20250307080829.354947-1-namhyung@kernel.org>
Subject: Re: [PATCH 1/3] perf sort: Keep output fields in the same level
Message-Id: <174258180714.163787.15010272622789563467.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:30:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Mar 2025 00:08:27 -0800, Namhyung Kim wrote:
> This is useful for hierarchy output mode where the first level is
> considered as output fields.  We want them in the same level so that it
> can show only the remaining groups in the hierarchy.
> 
> Before:
>   $ perf report -s overhead,sample,period,comm,dso -H --stdio
>   ...
>   #          Overhead  Samples / Period / Command / Shared Object
>   # .................  ..........................................
>   #
>      100.00%           4035
>         100.00%           3835883066
>            100.00%           perf
>                99.37%           perf
>                 0.50%           ld-linux-x86-64.so.2
>                 0.06%           [unknown]
>                 0.04%           libc.so.6
>                 0.02%           libLLVM-16.so.1
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


