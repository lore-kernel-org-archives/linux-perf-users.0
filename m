Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17F23815D;
	Mon, 27 Oct 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589356; cv=none; b=jo8fcL7XC1yzJNXVocjI4p9NyUJvvmGtUyvjmWx9xRklasPUdU7d1D53zcZmg3ti7gJ+qyA+7jYr0CV8HWgIrUzOzn1WGoqslutpfit9KyD6V474SiCvpg3k82xbr6/Wj5goF4M6+7gd3pm3uI5WoL8yM7CR8cWk68QVopFDQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589356; c=relaxed/simple;
	bh=o3/mgmg9hIqamiYJUEBvuA1N7S4Dmrb9TACGxl8S8f8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IdAHWcuT4Wdsw2P2xFARyD0dg34Taba+O6/JawqwJimC4+4nDFF2FFM9WyjohT1lsv5235t9PewWz79kS9Mskx9owc7GBgjZgu9Jp22JOkB/hcNgQh9N+jtVQ6s5UiWWTECkXMX8bszsq1D0cQb3J0PvnaUNdIRpuiQAGNbJIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPeBdvhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPeBdvhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB19C113D0;
	Mon, 27 Oct 2025 18:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589355;
	bh=o3/mgmg9hIqamiYJUEBvuA1N7S4Dmrb9TACGxl8S8f8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iPeBdvhsLVm/kkUyzI4GazF+KZATV3DiFxOU6r8M98uSEeZQ85ccE2FzMjihC/AAD
	 7R8NGBCIAecJb3ADpXghTzniyD5BQzvNKVvemWcS7Cg57DPcOkpzMApdQJenvfTmP9
	 gz+tAi2Rcm2mHOvprpRmIZaYSfqXPWxMa+3KhqAt2rLWwuk2XOkoBt/iVkv9lUl/Wr
	 XNSBzRjcwj0wl3F3u4nu9qTGefIq5dJAgqzBZfXvaqEs6j4vjUWNEbRdjkcT5K/6y8
	 kCHn0EzoHYkKNIoJTmDYRfl27MMMj2SiYyPDxnA8Rr6RvBRW3SVy04Aj8RvcrAJg8A
	 s855tPeoOjU6Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251025202834.1133359-1-irogers@google.com>
References: <20251025202834.1133359-1-irogers@google.com>
Subject: Re: [PATCH v3] perf stat: Add/fix bperf cgroup max events
 workarounds
Message-Id: <176158935550.1688092.6810694230290351513.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 11:22:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 25 Oct 2025 13:28:34 -0700, Ian Rogers wrote:
> Commit b8308511f6e0 bumped the max events to 1024 but this results in
> BPF verifier issues if the number of command line events is too
> large. Workaround this by:
> 
> 1) moving the constants to a header file to share between BPF and perf
>    C code,
> 2) testing that the maximum number of events doesn't cause BPF
>    verifier issues in debug builds,
> 3) lower the max events from 1024 to 128,
> 4) in perf stat, if there are more events than the BPF counters can
>    support then disable BPF counter usage.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


