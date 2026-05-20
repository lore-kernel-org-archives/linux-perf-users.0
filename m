Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60F202997;
	Wed, 20 May 2026 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304531; cv=none; b=HmfI8LUywkl6G0L5Ort2MzRxEulMI7OYB38qHAiwREOLNdlfTE8K3weWr35asSptAnBIPpg5uU2UWYbqtRDXSq5VGlUnHRNXGpxdFMqTAbjJTcNzc69uZYvRNtePvbY4coMdI7gicm8RsPhB11x7UdRTR7nU5TGSSFe99cvEelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304531; c=relaxed/simple;
	bh=b9pQ+sTEj+L0M6T4Ww/MQl7PoVGyfZx3O/6GhwDKViM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9so4lNjo/OVz367aq/d5JGMZ5p7KGlNuqmBA1JSGnLic1VvE8ThHY9gHfRFdZRU7nx5L/k9VsumynT8rmbb96vihBJJENQHkAefqRnoaB5nwLmyr0d3bw6HfrPxkzoRjRjLVn5zQjD2ytUjkHk/S5WKQl7R6I0vPSAnh8CZXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE0PgPd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE0PgPd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61531F000E9;
	Wed, 20 May 2026 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779304530;
	bh=u060Tj+XkEmBUEYqEe5HvdVavNc8hc7R3+izGwxCrxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OE0PgPd6bIWSCZJwMWIHTvVHdUEbQUedAPz8KmEx5mNkNLU3QtXDgTArGsYnPDY7H
	 uhPCboFY4XhntVr0A2wqqocNnkWGtgy1ujOoGZgBi3UrHHnsQN57iyVFRz36uLP/2M
	 2wO2E7grvPOTwx6DVcsg8xgI/TDHH2L/rjsZmkodsyvoH3cg6wTmM51bdcDdnv1R/Q
	 TCd3J62KCMTzwCdz73R+FC25JSYUMnRzW/8UaSTvGTzWeY2gYbLqvvumxfJGBSNUjx
	 QvW2B6s2WiKYMm4PaJbZygCCoySGdra+UWkt95E3d+2RUcdVEgPLMlu3vV0OOJBK0C
	 0PE+wfNwlYbSg==
Date: Wed, 20 May 2026 16:15:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag4IT7YfVyFjggK6@x1>
References: <20260512223001.2952848-1-irogers@google.com>
 <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520190538.142018-1-irogers@google.com>

On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> Nearly all perf code ends up passing an evsel with the perf_sample,
> which is problematic if you want to rewrite the evsel (such as with
> off-CPU processing) because all uses of the evsel need to be fixed
> up. Since the perf_sample now carries its own resolved evsel pointer,
> passing evsel separately is redundant and error-prone (allowing
> parameter divergence bugs).
> 
> This series cleans up the redundant evsel parameter across all perf
> tool subcommands and APIs, ensuring that tools uniformly retrieve
> event attributes directly from the sample itself. This simplifies
> function signatures and improves API consistency.
> 
> Additionally, this series incorporates subsequent memory safety
> improvements, robust bounds checking, and memory leak corrections
> prompted by address sanitizers and Sashiko code reviews.
> 
> The original combined RFC patch:
> https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> was split up per reviewer requests.
> 
> v14:
>  - Incorporate Acked-by tags from Namhyung Kim.
>  - Re-polish and expand commit descriptions to provide thorough explanations
>    of the changes and their rationale.

Thanks, tentatively applying it to perf-tools-next, for v7.2.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
