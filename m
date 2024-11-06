Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463B1CCB34;
	Wed,  6 Nov 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878623; cv=none; b=HVgrm0VkOl1VZHGUSBY6M5g60dm34vZ+RbyH1EVBrbew0b43+rGBrx433PZKTUeRKQXdEcPf7/0iksf8mEt3A6a5tZTJUNfjDSa6aKuASVZvu+YgnmVSQkcrTlSNQu1k0FW1UgU1Kqez95mf1dbTg5/V3v2X2kSslD7fuTQ+wPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878623; c=relaxed/simple;
	bh=If2i5o23d50+LpgvLZSHaiNVPerDOZ97QUkr4t9cvIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkSDezaVOLzMYLsiSyzvI+q0tsxdUqXRCONhHV+ErYijh0mTeqLQ/2zKf1YzwENSkzpn+u9+mLS7C2NbG9AjRcl9FCl1LkY23xKcSvebQBVF0dt7RarnV/A8N/YHP/JyPG8t+DCekwlsMRONg5WW1OvkLxMj67GlLklBVhe7iEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShqLWas9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShqLWas9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB35C4CECD;
	Wed,  6 Nov 2024 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730878623;
	bh=If2i5o23d50+LpgvLZSHaiNVPerDOZ97QUkr4t9cvIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShqLWas9FCX+qvlmwO8Xikkhh//NVy0ZyG6KiQA4w4sjhMygr3moBge1F+kEnq8sO
	 DTt9EmsSQPvC9YvE0LjRBnmFMhYWj7RClZANC0iL/IqYZwtfcLiyILtF462LTRz5pW
	 cohLSj9kCCAqhrsM7XmeMWeA5rl5Mt/4xCY+htmhuw+94tFV+Fk9tOgcp3EP6F/io1
	 wPFE5I6RPWat1gKcGsq+mSfk2JU91NtW28LHxfGtwYcfWEocrs+kaEntA0OYjuQlhM
	 ywoXmjQlkqG4qNJlIbZOpxnM7QWXhcEr+AD5w3wHVBXi9UAFRCB3wBJO2KasQ/8kY2
	 h6kVmHwrIgkwQ==
Date: Tue, 5 Nov 2024 23:37:01 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf tools: Add the empty-pmu-events build to
 .gitignore
Message-ID: <Zyscncm_MDm5Swy9@google.com>
References: <20241105052409.7783-1-haiyuewa@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105052409.7783-1-haiyuewa@163.com>

Hello,

On Tue, Nov 05, 2024 at 01:24:05PM +0800, Haiyue Wang wrote:
> The commit 0fe881f10ceb ("perf jevents: Autogenerate empty-pmu-events.c")
> build will generate two files, add them to .gitignore:
> 
> 	tools/perf/pmu-events/empty-pmu-events.log
> 	tools/perf/pmu-events/test-empty-pmu-events.c
> 
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>

It doesn't apply to the current perf-tools-next.  Can you please rebase?

Thanks,
Namhyung

> ---
>  tools/perf/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index f5b81d439387..51713b655f62 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -39,6 +39,8 @@ trace/beauty/generated/
>  pmu-events/pmu-events.c
>  pmu-events/jevents
>  pmu-events/metric_test.log
> +pmu-events/empty-pmu-events.log
> +pmu-events/test-empty-pmu-events.c
>  tests/shell/*.shellcheck_log
>  tests/shell/coresight/*.shellcheck_log
>  tests/shell/lib/*.shellcheck_log
> -- 
> 2.47.0
> 
