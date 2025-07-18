Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A489182;
	Fri, 18 Jul 2025 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797193; cv=none; b=hbLpVNjyW9Sa+WaOV9PGQQTVX/dhTVII48TlokPw3DLAYa+YJYLtgigYDfrVB01E1f+YRTYqEjOjD8CPIA6i9Tppx9aZRq7/GKZ6uGqkzFLwhvzIdDRKhNToUvz9p6uBqq+WGIwYsuk5aMs0BjM5+oVes6rY+u77tWlyML+uJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797193; c=relaxed/simple;
	bh=GZD6G30HqjgR/A80DL+8tLA/WKiBDWC8lpoeOimL0h4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZWTNCUE5y4JemB6Ay8LwHSGA/tSFGcOaty6wR7RtMT5RA905j4lqgGT+RZxiazW8ND2/XaHPyTOkJDLzyhzYlHhBpo/BE+16rl8arqAA5VNMKYSK4eGnOEViBc8H1v4Tm6RGOKNPLXzUnDGIJjqlrLAE52K55sGTxDL11+DXi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYNN9ufk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYNN9ufk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B1CC4CEE3;
	Fri, 18 Jul 2025 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752797192;
	bh=GZD6G30HqjgR/A80DL+8tLA/WKiBDWC8lpoeOimL0h4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YYNN9ufkFhvKcVjvrHQPXgoD+FCaXwCdPt4qBCzZf6nICTDCauO5stP0bLCy/xqH4
	 aVwuzddLw7hufiQ33zQCgM48ue7yVIl/qDff+YzViEjyxakDLfcNtOjItvB+GLjcvE
	 lrbyrwyN6PNUwxR+7Nj3r4/82Q/6Z4v0+zifen+SVay15z7oywizeELI6mn0+ny8jr
	 0IBnDCLIowPjYQud6UgUB+qvikdNBlhI+rP0CLkmJw50BCj0V4KKCIb0GMh2c8M7ri
	 w7VhHUtrv2ZiPRD5kPqzjYqjl5nM8kIWQ8axvhxCXaJaMCVxx5IWwjSCqqeadFYC43
	 on5jQc5xbnKpg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Wangyang Guo <wangyang.guo@intel.com>, 
 Tim Chen <tim.c.chen@linux.intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
 Tianyou Li <tianyou.li@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250716004635.31161-1-irogers@google.com>
References: <20250716004635.31161-1-irogers@google.com>
Subject: Re: [PATCH v1] perf flamegraph: Fix minor pylint/type hint issues
Message-Id: <175279719184.656724.221004202740500543.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 17:06:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 15 Jul 2025 17:46:35 -0700, Ian Rogers wrote:
> Switch to assuming python3. Fix minor pylint issues on line length,
> repeated compares, not using f-strings and variable case. Add type
> hints and check with mypy.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


