Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EF2022F3;
	Fri, 18 Oct 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264811; cv=none; b=hCTk+eLVFb17S3aoeQLcRTH9PkryGub+9qOcuq3KWYxt886KN74nigZ+rSVV0aW3y8ZxY5d4DGr+nhNAWyhJAvfngFp3mpEBvTj2V2ruwyw5qlcw9ifXLARlZi3w1HxCTCDz8SFWuaSrOkoTvGplbnoEjPFGJ/Iy8QfU0/sq67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264811; c=relaxed/simple;
	bh=5eYNbZUigYhBxYOXnV+9vqer5der0qHZSZ3vpJSXq9k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kjureWKpYMb3QMl1doSf6azKYgfKkEsrE1svsQ0UeSJ7O3Di8068xnqWOuT9noGV2UUif2InvgAGgFc0Z253qopGuthSPsUirej/44otIWZZJcYL6mPvlbU4QokwSD3KTX2I7hPQ9AsnlBIyd9JroHDz+mcx8zbLC43ikbHhqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF6PnDCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF6PnDCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C3CC4CED5;
	Fri, 18 Oct 2024 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264811;
	bh=5eYNbZUigYhBxYOXnV+9vqer5der0qHZSZ3vpJSXq9k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JF6PnDCwRQRvYk2jJ1+yqnbivCh0ofVgKjqUe24AxZ8bkHSglPiknTx4wqV5Ju2xB
	 J/IYWLZAASzq4aENx8TYstGO6hgpoqaHHdxK5Anxi2IYC/iLlrAt5EEhITPiddW+lX
	 yYQZAioxMsOLDyNZ3CXWHyg7pgF9L09FEHxfCFmiZx4aBuKxaX4JoVWldR6zomzys4
	 Uiss20xvVUnOUYsY1kJf3pPvLl1XtiegscZd9U9yRZnl73Me0m0iaqUib0+GeoWCpg
	 km+R5hxzp472m2dFMzvymVQ6tm4trf5Hwsvvi1mH8dP7sFKfqHSj3E5hTo6w3qVS9K
	 PFKvN4GoJfd8Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
 zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, 
 Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
 Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20241015000158.871828-1-irogers@google.com>
References: <20241015000158.871828-1-irogers@google.com>
Subject: Re: [PATCH v2 0/3] Make "Setup struct perf_event_attr" a shell
 test
Message-Id: <172926481069.1381973.16405989898927387636.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 08:20:10 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 14 Oct 2024 17:01:55 -0700, Ian Rogers wrote:

> The path detection for "Setup struct perf_event_attr" test is brittle
> and leads to the test frequently not running. Running shell tests is
> reasonably robust, so make the test a shell test. Move the test files
> to reflect this.
> 
> Before, if you build perf like `make -C tools/perf O=/tmp/perf` then
> run the built perf test for the "Setup struct perf_event_attr" it
> skips (causing the tests to bitrot, fixes to be sent, etc.):
> ```
> $ sudo /tmp/perf/perf test -vv perf_event_attr
> capget syscall failed (No such file or directory - 2) fall back on root check
> 17: Setup struct perf_event_attr:
> 17: Setup struct perf_event_attr:
> --- start ---
> test child forked, pid 806601
> Using CPUID GenuineIntel-6-8D-1
> ---- end(-2) ----
> 17: Setup struct perf_event_attr                                    : Skip
> ```
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

