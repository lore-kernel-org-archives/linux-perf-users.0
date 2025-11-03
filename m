Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321726B973;
	Mon,  3 Nov 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192414; cv=none; b=UbLBlPBVmn3jb0zYGMZuSh5ZI1tNI9EZT4D+huoX62eUvE01TiebO1edk6h3+6RqNOAVwgdvJYwj0JEzcFlaAdt9rhch7QINaiFRtZVCJHIFT8flPtTAsVyz2tsSLojM0ASoqAZ72mwXoxRd9Z+lLaGNJwrGPPva2HXA8QOYpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192414; c=relaxed/simple;
	bh=u3Qf3kLQGHHWX0YQrQGIdUs+pkdVjxKYXobLCSHTJ94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pJEAcPIMB2Zqhh9y+k7FqE21Y+dPShUlO4Xvwn5cfGQI8hKuWZxpGV+8Nnx72nXmzxF+HfnIcpEsdbqMnLi1DsvhjS1iGYBMIro1+25wNFDwp4WVVHkSmsi5LsRUDq5BoTSyEiiptH+BaEx3XAda16cNVKOuUs8rvbeQgZH+6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmouLwvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmouLwvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB315C4CEF8;
	Mon,  3 Nov 2025 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192413;
	bh=u3Qf3kLQGHHWX0YQrQGIdUs+pkdVjxKYXobLCSHTJ94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EmouLwvwzYKAoLawDPGFpaoSkgebdsld215blWbm/bIinpwyd4lygjsn+rt9QQ80D
	 TxWdBwg/qay1npEnS8XvbpD9RZCd3Gb+I6A4MBW/bxKLe7oMIE3+W+vC+/Bv8wPeC2
	 KZ2tihFlirsMe+vXdsgcNQo0YkSXmEcDImKF2gC9wLxQTLnsGPivKMI3Y+uHDkSdZn
	 QQeo8b3eUHHY0Yht9UxKq2AMbQMq+fbJlyk6cSXZNcz9/C4bMLCsdJr0wI6wPtBbYd
	 cdcNGVVGXS0GdCNLFKS+NoQqDEXX6KhyuZSWRp5WJla3LjO3Rqp3wNK1gc+o3x+ZVA
	 p0kwNEZbSTOHQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20251030040140.1115617-1-namhyung@kernel.org>
References: <20251030040140.1115617-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf lock contention: Load kernel map before lookup
Message-Id: <176219241263.1981113.9281236237114360261.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 09:53:32 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 29 Oct 2025 21:01:39 -0700, Namhyung Kim wrote:
> On some machines, it caused troubles when it tried to find kernel
> symbols.  I think it's because kernel modules and kallsyms are messed
> up during load and split.
> 
> Basically we want to make sure the kernel map is loaded and the code has
> it in the lock_contention_read().  But recently we added more lookups in
> the lock_contention_prepare() which is called before _read().
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


