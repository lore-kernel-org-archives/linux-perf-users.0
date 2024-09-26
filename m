Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC07136337;
	Thu, 26 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371740; cv=none; b=oANiq3AgI+z0uASE5X/FAjqmO1XRpIIdQRbfptSHPHuefKEmuiT2f5TqdurtHmGU5ofUh7vu6/YE961SudjjYR69qwzUV1ZqWaQXPXvP0TVAckrzQFSKStEHivR+mBjIdmaMvRz5d+6S4rJEh5sOKFInlPCeHFmgtSmE4DLYkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371740; c=relaxed/simple;
	bh=LLDqwerUj7WwDeFcUQ0BMKOjYyZGVE47RFGgqegx4Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFq8WWRwBaAlgt6NLPeCVv/rlTsAikJcqY7ljTdZ61WmHxliGWzFfWshlTC0PxD8UD8vj5B48STWl/FSzGOX27egyhobyw90bfZfiwCU7wKEdvHFvmleNfCb4Ub2GHbHCS2bqBnSQno8ftALZfJZ6rbok14cIL/q1Y/SV30hqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM2sQfbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM2sQfbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6486FC4CEC5;
	Thu, 26 Sep 2024 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371739;
	bh=LLDqwerUj7WwDeFcUQ0BMKOjYyZGVE47RFGgqegx4Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gM2sQfbGar5KtsCDKRTk14XZjIZohtUepVC9Psf564P0akIO3Oq4HKWM+Sb0NSzrr
	 4AEeoVy9BNDF62bkhWdyxPZsdRmAxfmNED/R0uYZu/38zMQvMx4QAjy01ECe1Wf2zk
	 SR0RS4UoFvwx6VWeN/YGKuOHX0RNKkHJfd3BgMSKhC+dUrbctVNT4flen6AvZz41rc
	 7wNeXCuDOCc/qAtRE3M9QNmbyQnJJHYlf1jW2iAYIVD7ug67clcz6q9az7uUTptfM2
	 4ls3F2Mtin3eH54KV/Hjm8+G2uzl1wLLqq1h84j+mae1y71tw20v9PUdFZVZcnVYvm
	 aKKDsasPyarrQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf symbol: Do not fixup end address of labels
Date: Thu, 26 Sep 2024 10:28:57 -0700
Message-ID: <172737172354.3854998.16269602769912786358.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240912224208.3360116-1-namhyung@kernel.org>
References: <20240912224208.3360116-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 15:42:08 -0700, Namhyung Kim wrote:

> When it loads symbols from an ELF file, it loads label symbols which is
> 0 size.  Sometimes it has the same address with other symbols and might
> shadow the original symbols because it fixes up the size of the symbol.
> 
> For example, in my system __do_softirq is shadowed and only accepts the
> __softirqentry_text_start instead.  But it should accept __do_softirq.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
