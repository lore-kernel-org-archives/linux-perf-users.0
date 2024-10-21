Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960871CBEA1;
	Mon, 21 Oct 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526504; cv=none; b=rWGNw65U2Cj3hcV/BjaS+emxzTIfFA8fkEiULyJQ2QYoZjMvPybnv2ZIWTy/fid13yl6FJe73/C4H7/Fyd9AGzmSFcOhiS3N/u5JcvMT+yqwjIULgNwc2j/LykFd3p1lJIIXaGCtbAtrB8sR+QLlnGPJOPdRwiWCnPQJcDM9xC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526504; c=relaxed/simple;
	bh=58nMe9/sBr2WMbK0mMLjlVfW1lUjOJg1ouADVeJFbV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hy8tVhZGJj4gW8sJNg3WpqcfwMN1fmoSUNTOCyI+AlaoZ7gM2GSWQyM6ri86jSQG9l7yM8eqDBmvhvKdXaMNXOrYxrl9otjBEUO+hSlAsvbfY8dFx8UUoGFLymGAahb9g287Osrfvo9zypfOnECWJiQDoDYsa5Oc1qtBjYpIAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG6mWoWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG6mWoWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E944FC4CEC3;
	Mon, 21 Oct 2024 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729526504;
	bh=58nMe9/sBr2WMbK0mMLjlVfW1lUjOJg1ouADVeJFbV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eG6mWoWB1uTPZUeSzeI7CepojOoB/Wa58JUVDitH51iOjK/umGn2X0EVZYiTvF0E0
	 ZgByTZNlKeSELLTrwmn3HVWxeRv4bWp+b199Nr13Y/sWKnu4NTJWbVBiJ5jZTkUXM0
	 hsN9+CF9PXy/jqDIgO31QXnpKVBSUgPmLuKIfekaHMJ7FQiOC70dtbwc1d/20yRNeV
	 9OTU825nLAQ5xOcUQGoTB8Tv6XLncJp4uSblK2iEnPoezXdxV2f9hm4QMqspyB6yfj
	 pejfWoEYF7/AUmGBnfKOms8pFYeeunBs8gmxSvk2Jl7yCyTvA7K9yxwmqAbiRJDF4O
	 Tc8NbUct8q2dw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20241018204306.741972-1-namhyung@kernel.org>
References: <20241018204306.741972-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf test: Update all metrics test like metricgroups
 test
Message-Id: <172952650390.3574386.12595508041018662806.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 09:01:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 18 Oct 2024 13:43:06 -0700, Namhyung Kim wrote:

> Like in the metricgroup tests, it should check the permission first and
> then skip relevant failures accordingly.
> 
> Also it needs to try again with the system wide flag properly.  On the
> second round, check if the result has the metric name because other
> failure cases are checked in the first round already.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

