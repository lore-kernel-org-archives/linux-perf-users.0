Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389752E064;
	Thu,  1 Oct 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869421; cv=none; b=pMqABZJhWuXSfFnDZNbFnDR5D3998j9v8QzESDHMkLYwFlR+TyBkFxe0DKOhQ5S3kWCJBlaeNq5lIrfaJl5++v2zNZyfAFtTEVLOWcm3jnWZSiWcjvxTcLjKYWOqeny4WfqHLC/1OG77i8gomhADOBSd4jAxfzZSq7QixSnD6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869421; c=relaxed/simple;
	bh=6O00NnDwTRJ8WvKVPSJxU60mnvq2Lp5r6YGRnhPUg1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SghlNDuyvIVfneLVqnCaQXC9gxkGKIMih+MPnpgkB7U+0UZKxbn7gdR1neT63AdcPEjwRVswuhzCzMvwkUZi1JDdEcpohaR4L/kJhB4i56fZXOD06klGppUE7AmheoHlEtUQ6dbZG2gHMD4V4cAqTjrC6c5KYwago9wpZrpcvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwI9GwIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwI9GwIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE0C1F0089A;
	Thu,  1 Oct 2026 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869418;
	bh=vMWJxkzwYJ6Jpiq55XDoKxamwzisRVsjxdc2hDyeR08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZwI9GwIo2T5F+kEA90uRetteVQsnf01wMy6Gk4uUs2w3qaehv/tWLIezIUfFPeg6/
	 UiEPmHj2r6XqSXtGic8BNprzJnFMC8tRM5QrUYOYEtpa8sftYULa1uK+t5PqIxL7Zj
	 t8JuXC94dbzgFXDcxE2fa4Fu37fr4KNsy/htqUg5Ybn3doDJZix2Db7vSsnr2WUchd
	 H2Fr6f7b/pDsnQ0EV4qSdwxDFs5+rJDQeBq35PPrrURwhYWtgxwva7EyOPTADIbTXI
	 yAcZ57oJmBqQgSvTvfSD3k2frrY5BW+W5nfiLVRfXBs6gsOMQTD7ng4YHXHCcv1EkN
	 U0/y15/puEuxw==
Date: Thu, 1 Oct 2026 17:43:33 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/26] perf trace: Filter the target's tasks in BPF
Message-ID: <ar5_pbVm1WYiq8Bg@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-16-irogers@google.com>

On Mon, Sep 28, 2026 at 11:25:54AM -0700, Ian Rogers wrote:
> +static bool task_traced(void)
> +{
> +	u64 pid_tgid = bpf_get_current_pid_tgid();
> +	pid_t pid = uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
> +	bool *traced;
> +
> +	if (!has_pids_to_trace)
> +		return true;
> +

I didn't look at the generated code, some optimization may well make the
bpf_get_current_pif_tgid() to be executed only if has_pids_to_trace is
!NULL, otherwise it would be better to move that to after the test.

I'm applying it anyway, just caught my attention while applying.

- Arnaldo

> +	traced = bpf_map_lookup_elem(&pids_to_trace, &pid);
> +	return traced && *traced;
> +}
