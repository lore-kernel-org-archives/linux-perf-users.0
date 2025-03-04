Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFA2E3360;
	Tue,  4 Mar 2025 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113611; cv=none; b=pa1CeCwa+0Q4IG3Xuzlu7Xrc9oMHvItH6acFkGoFqp0+paOq4cx0bUXGsRSOuweNL5dID1UASgRNKvVKJPvGl97cfb+LyiBRMC+BREypEHoWj62y/fX90OYhf08HnpiM9W3numE+6xjEPq+m37JqVqp/JrXrD9vm314mSBLhL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113611; c=relaxed/simple;
	bh=mfs+zl35hkj1shpqCZddKjjAF0Q9bhJLEpmmMR4Wgi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L1Ophm3MeNYzjFQuI4B+mVPcRbPg97CRJBIMw9iSu8OhhTHRzzzVdlEwZymbkbJVQTN8JPiFvGP7n37rA1r5OB+/154LmUnbdOgukXgJkl8/MZ0hUQZVh1HZtQiWx26yJuHk16h2SQUjmZgG2YlOr8p4vWwZjz7y35ajIFgqok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyrqGkQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyrqGkQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B801C4CEE8;
	Tue,  4 Mar 2025 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113610;
	bh=mfs+zl35hkj1shpqCZddKjjAF0Q9bhJLEpmmMR4Wgi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AyrqGkQ172ZIEm+HxKmFmYZFFaKQ9g9pmsU4kxLO3xgpRLjmUpSwC8QsLbRBoDhZu
	 Qhq4NX5aUYpc6ISNdeRUTz6WuFR4Qtjr62dRx7R72/TcD/LAS1dYlQzvzQkk+4i2Nr
	 6GCxaTlVm+TV5dFoZUbwrYEZcGNQxKVTYq/jqGDJ+V81wm+SA8y32A71St7LmAROeC
	 pvaZarTgo8tTrJ95Ieb265gg67y2cp05mB8Xb5xUtP7Q8uldhlDu+FQKvmq5+g/GjO
	 uzlF0N30HGoyLdt0Lzec+vbhc5CQ1Uk0rF/h9iK6YKcXHFR2j3lH7PJOVF8s30bWyM
	 n95GVFfdBwGQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, irogers@google.com, 
 James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250226145526.632380-1-james.clark@linaro.org>
References: <20250226145526.632380-1-james.clark@linaro.org>
Subject: Re: [PATCH v2] perf stat: Fix non-uniquified hybrid legacy events
Message-Id: <174111360911.2656304.15827033005902965413.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 10:40:09 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 26 Feb 2025 14:55:25 +0000, James Clark wrote:
> Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they look
> like plain legacy events if we only look at attr.type. But legacy events
> should still be uniquified if they were opened on a non-legacy PMU. Fix
> it by checking if the evsel is hybrid and forcing needs_uniquify
> before looking at the attr.type.
> 
> This restores PMU names on hybrid systems and also changes "perf stat
> metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
> test was gated on "cycles" appearing alone which doesn't happen on
> here.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


