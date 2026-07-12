Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F52AEE4;
	Sun, 12 Jul 2026 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839375; cv=none; b=LBJ8shM2EtGKl8JmKS8ME+QdYOt5gZwPhoNCvtqiAKGUg61PHzNRt4kwYN6yommA9RTODjAcqHuiL/nYBawV4x1fbrfVKkovybFP2LshA5tpDH3JMq7W50Q2rsOvE4cHi1NjxhU3vgFV9k5SYkAU7f/Ndg25gYRSq1iZU9n1P4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839375; c=relaxed/simple;
	bh=WZHYUVM7Iws9lMPF7n/EUApgnfcYqAhmxOI+KuQN8KM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lyojm5EZBuRrF39s1z6KSaTKTES81hMQ0Y/sXMBgZW8zMvkOv7PS2O3yLj8KTGHStDvFXmDnmBI/92SagYmLB/ugn/6kBJyLSDaUU53j5ob+nwunAJDvH/cN9zpwNUxIYUij6hJIw4xEjdfO32TysBmOGJylQjgdLNJJsTLrjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmGGRCEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmGGRCEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C441F00A3D;
	Sun, 12 Jul 2026 06:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783839374;
	bh=xYgMOxTZVQ45f5Fd+Zh6bIbq+IS4ycKwNxuQBQg2pRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TmGGRCEuLhvHG2GgvUklrWYs2/m3bRxUGr86C/9LO8MiwAD2IvsAz1Wg/Q8PRO2uD
	 XNLnhlHv6i7UxPmEUZzW4d8bIvZmTVuqhX32xUvLWUJWt0ItZn9XnxETFpHB5AiTVc
	 2hzI2sZ8UMZ5gDU10Uq3INbc6aGV/C0HKAl4sVFfatu8GhkgFdkl1+41uNxLxMjAjs
	 +epXI+09Wj6O5P/lwxg7Oip2lArRD3O4fr62InpEh+PGAHOsCYco9ue5EsUwm5HRNn
	 HtPQwFj5sRY5V6ah4RYruqd3QHUJtjFwqOaHDtlKsOmHdXt1qNtqjiEVGbNo1H3QTg
	 HTegI9ZoFJ3ZQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Yu Peng <pengyu@kylinos.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
 Qinxin Xia <xiaqinxin@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260602081104.271325-1-pengyu@kylinos.cn>
References: <20260602081104.271325-1-pengyu@kylinos.cn>
Subject: Re: perf metricgroup: Fix metric expression copy leaks
Message-Id: <178383937411.3162711.8798252992104512729.b4-ty@kernel.org>
Date: Sat, 11 Jul 2026 23:56:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 02 Jun 2026 16:11:04 +0800, Yu Peng wrote:
> metricgroup__copy_metric_events() allocates a new metric expression and
> duplicates metric_name before linking the expression into the destination
> metric event.
> 
> Free new_expr when strdup() fails, and free the duplicated metric_name on
> the later error paths.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


