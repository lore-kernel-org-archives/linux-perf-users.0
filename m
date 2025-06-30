Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AA28FAA8;
	Mon, 30 Jun 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298994; cv=none; b=clG8GquomcihBu90RTPKfYcPGXG1yYZOhCGLIbtwSpWAgtTT/aPoSU8EqvO558Vgt7f9UdiefmbfLAZi5lnuPEOnjVyDk3Lf7pygsa5W0P8nGKhT+qMD07LYzATtHDp07pPMej8wSpUiRWomJ+2hng4WWPtc5vyCE+1Y8ZeeYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298994; c=relaxed/simple;
	bh=+n4AGyZZfi7DG4WH8ZWL/GOb/Q/M3G6MrS8evwtWqLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OKNqrZAYhc0fL444TMZXSu8Ztc4FdYEwVNYz0/u+xj4aT07Kc1KxjTWDd7yxiUUyeJK5edlsWpi7V1uaIBIE3LRr8JKna1I8JXN+5g+0LmIBndJrZFy23XKDI/XbDuUQHJzyFdCIxTwkCde2Y/b+8Ohn+xJC5k39COzssijcgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGRye6cm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGRye6cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6097C4CEE3;
	Mon, 30 Jun 2025 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751298993;
	bh=+n4AGyZZfi7DG4WH8ZWL/GOb/Q/M3G6MrS8evwtWqLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HGRye6cmjEU3/pGDX++pW5YQBH+G46JYYFXbzWf9A/GI0xtdHwg3/Mc+oTuggkP2l
	 /rkslmWqSFzJtHQe0TZ8AcdUqrxJi5Atsie8EK7SL+ekhlVf70RhlcO+DC2mno0Val
	 ifFPlLn3AjvE+fKdol1S3yMSUVx7T0xquAKlmdf1sTE69jvlxsjmjzvm8VQecsbRx5
	 /RTYp9IWYMmxIWZKW3LX44i14lb+c4LkPfTaKl1e66p5JiHPDfbGxpxb+4qBZlkBpN
	 Oay05wwqziO023j/NNzi/FysSKRZvBSbKg5KjxYExNlSXMVTLl/mT8MG/xc+OZ+G2B
	 6M5e/VQ39hvOg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com, 
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 weilin.wang@intel.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20250627201818.479421-1-ctshao@google.com>
References: <20250627201818.479421-1-ctshao@google.com>
Subject: Re: [PATCH v4] perf stat: Fix uncore aggregation number
Message-Id: <175129899290.35492.17655499590439184414.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 08:56:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 27 Jun 2025 13:16:41 -0700, Chun-Tse Shao wrote:
> Follow up:
> lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/
> 
> The patch adds unit aggregation during evsel merge the aggregated uncore
> counters. Change the name of the column to `ctrs` and `counters` for
> json mode.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


