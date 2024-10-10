Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80036F9CB;
	Thu, 10 Oct 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522774; cv=none; b=W10ktxwfSdtXAMskqm2b+79mmuqUgHoTAkcyIPwHfIwpcMNjOpWjxuKFS3W0CUtPQQXxTbBRFGrhNeQOEQK90mE9QUsgPstMGjbY+LK2Xdv0Mk7ZK5ulPvI5hj3t/Nz4XBrQsQZVGo5DTD0ENNmGv7VuQWks+Co2irn8vMh+7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522774; c=relaxed/simple;
	bh=P+IBwA3DyX2CWGogUkSF7cmDoIFQ90YAqvQcabiWl8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9e/QG/HM/nQAcLmsgBWBmp+ESMnb0UWz2/SuALg3Wdbz69AY+vSZI7Z6nkRx22qxWqVVkzML853cUWSfGQOwZepcsMbUa4/IP5ALzJxS3K430sxTmkpz2y11jqO6poFvtwnD9YohE44ZTxZrqRaFgN3fnporNHTeVwicAA+3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3hZ/bbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3hZ/bbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85311C4CEC3;
	Thu, 10 Oct 2024 01:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728522774;
	bh=P+IBwA3DyX2CWGogUkSF7cmDoIFQ90YAqvQcabiWl8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3hZ/bbknDvLNasdunyHCfM87m7KM5od3fO2hLEWdOCyA/KR1xvUV5cszN7rj1Nt/
	 PDuKYodMHxE63SVnuAixpZevTnZWnlhJBSnZRmcLWE2z6LfdTrrqXJ5wxKYRcH2iI/
	 Yf1KOB2ouj6QWr29Xmnwkq6WZXsb6+i79GxUy9GjoH9/98vTGS++ViARAd2MYWYSg6
	 ImmFYrCPl+fkANUSGVK4SkEdZgIRpym629XSxntaINch+PzflcD9aW+cGgxhTyOl1T
	 ygu8bv7pa+/WUc3N1Chi15ooGqL1cFJao4E0r5utVZHsHv1Y3mrEpynwPgTBARpntr
	 Tb1s0SKFyESUQ==
Date: Wed, 9 Oct 2024 18:12:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dima Kogan <dima@secretsauce.net>, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf probe: Support long symbol
Message-ID: <ZwcqFA4IKbLZ7Cev@google.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007141116.882450-1-leo.yan@arm.com>

Hello Leo,

On Mon, Oct 07, 2024 at 03:11:13PM +0100, Leo Yan wrote:
> Currently, a probe supports event name maximum to a 64-byte length. The
> event name comes from the probed symbol name, otherwise, user can
> specify an event name.
> 
> In the case when user tries to inject a probe for a long symbol, e.g.
> mangled symbol name in a C++ program, the kernel buffer cannot
> accommodate it if the symbol name is longer than 64 bytes.
> 
> On the other hand, this series relies on the perf tool to resolve the
> issue. When the tool detects user doesn't specify event name and the
> probed symbol is longer than 64 bytes, it will generate a hashed event
> name with 64-byte length to avoid failure.

Please CC Masami for probe related changes in the future.

Thanks,
Namhyung

> 
> 
> Leo Yan (3):
>   perf: Dynamically allocate buffer for event string
>   perf probe: Check group string length
>   perf probe: Generate hash event for long symbol
> 
>  tools/perf/util/probe-event.c | 71 ++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 
