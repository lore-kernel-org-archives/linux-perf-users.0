Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EB314B85;
	Tue, 14 Oct 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450783; cv=none; b=B+gsfZcR1kRLD1Av/233y6oh89QkD713mvU+Zm0Rfue4JKquKSYStqlbxyMSjLHv9d5ln29SnQQoSqjx7Qz0Thj4BNcTr92Fd9MSu5sKKiqJr6maJuZo3p+Re6JFBMhjhosu8J7ymk8bIJjo7JxTHull2c/CNl1jBS7surKa2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450783; c=relaxed/simple;
	bh=wR2HX3Ov24o2Od5ZUKmuoqwoAIH2OIztzSM45ZrhFAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3VOb08hK9/5Djfj/ss6fjovgJCIMb4i85A3IKXbVGvv1B8434vpXDWlmreqya4WnENkQnLRHzg8JJCHcyAtBU0ZUUNKYfeZgFCFnAmsPMsVc4p6pW1iujpnAM/IA0KA8m4aVhPtaAOhBZI5kSOFALpSNx2a86cRtFZ5F4uHU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQKbDPrI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQKbDPrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EE0C4CEE7;
	Tue, 14 Oct 2025 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450783;
	bh=wR2HX3Ov24o2Od5ZUKmuoqwoAIH2OIztzSM45ZrhFAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQKbDPrIEpj3FXKC8fC26WCSgLUH3q36UBwoxThdeX+fMv+cTvrzHfATJkOiAkENU
	 ww7M26Fa9tjs29A5e9j3zktCvReb6jBqP40eEslCofUrRm8//dR/8d++y7nQgVryqw
	 U48/MTkICO95v1amm9Pa5oBRqQlXBdSOiji+pW7dsxo56NHzkVxkn64DDounEjGhYU
	 J6NqfSVyIzF3CPSvEaSan+TX6v7h4roH7OKfscqWMc9uA757VFmd4FYk23egsJpLQj
	 tBeCssEx94sOAJJbL5V+qoE7eL7pGkR1HHwKzedC6QrxcFigBA5esGQwbdi9LVMMDM
	 nHsG0at31lvMA==
Date: Tue, 14 Oct 2025 23:06:12 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf bpf_counter: Fix opening of "any"(-1) CPU events
Message-ID: <aO5Y1PSs_KOuuy32@google.com>
References: <20251009132912.141116-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251009132912.141116-1-irogers@google.com>

On Thu, Oct 09, 2025 at 06:29:11AM -0700, Ian Rogers wrote:
> The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> wanting to aggregate a count against a CPU, which avoids the need for
> atomics so let's not change that. Force evsels used for BPF counters
> to require a CPU when not in system-wide mode so that the "any"(-1)
> value isn't used during map propagation and evsel's CPU map matches
> that of the PMU.
> 
> Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
