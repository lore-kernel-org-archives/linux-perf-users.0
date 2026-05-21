Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68C3C76B8;
	Thu, 21 May 2026 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368249; cv=none; b=rbvTwQUyrhrhUMqllZrKsF8iyL3rvPiEUcP99jmHZLj4XaHMW9qO4PMJWBQD4zrRJB3oIQQw5yADA3LDfmxP7WKAzMpzYfXgZ58KVdLsSE2L1RzGf5HjIsVTe3eP/oUJC9YwIuBY79nTAEnnHg+f969U9urC81wnTbqpAqA39O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368249; c=relaxed/simple;
	bh=qN5TuMnx+cQyXEC/L+JVunM7W124rW6VLj27VBE57lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEN4p4m9oSZzZLAopGD9wZdFmBV7FaSx5QZZzIooPCPxSxHe08DjCVrfLT4vTW6zXbIL5DNmRj3Y9BesQj33gHS6aQd9mVzeLxja6pLP8iX3fxFqelrguExx9FWwyqiGpr2AQtEuJvfQb8QfP67mBagwgrcWw8jcHiyzw5SaL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG9xm2KM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG9xm2KM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CE51F000E9;
	Thu, 21 May 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368247;
	bh=FREUpEoryvYyTQmrjQgHhs51TfdO7ahUBt7LIV+ChZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YG9xm2KMCrOZ4mDpYC7wWL7rpy1xBmd0aYCKj15bvNaWpOSxQbw/gCN1KIyF0kLV4
	 a/H+jqayMLrGcLio/WNvThyweUw8Zz//J4YnWkpkeMviSkm6ovqMkbbBLxcPs61PO6
	 8QZ5lKHwlfRsTaEHW1KilXZfk4mbXZi7lq2BbXbI2qSp89IEcmeP3EivGfxCS+3ZJq
	 SR5nRyK9h7zvJSGEroMG+lHbTIOHy44S3t7btxS2N7qxQC0q1I3TzmSGse6erLnqMv
	 hBiE3Ttj4P73jvlN2YB2B8fz70QhKcvjtfp37u3S9pNe01CGXKgpO5XlqyWwoSplid
	 lrotT1XqeLPqA==
Date: Thu, 21 May 2026 09:57:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 27/27] perf test: Add truncated perf.data robustness test
Message-ID: <ag8BNL5po6NB7g7e@x1>
References: <20260521011027.622268-28-acme@kernel.org>
 <20260521020751.8BF2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521020751.8BF2C1F000E9@smtp.kernel.org>

On Thu, May 21, 2026 at 02:07:50AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test fails to detect OOM (Out Of Memory) kills as failures, allowing resource exhaustion bugs to pass the robustness test.
> --

> > +++ b/tools/perf/tests/shell/data_validation.sh
> [ ... ]
> > +	# Detect crash signals portably — signal numbers differ
> > +	# across architectures (e.g. SIGBUS is 7 on x86/ARM but
> > +	# 10 on MIPS/SPARC).  Use kill -l to map the number to a
> > +	# name on the running system.
> > +	if [ ${exit_code} -gt 128 ] && [ ${exit_code} -lt 200 ]; then
> > +		sig_name=$(kill -l $((exit_code - 128)) 2>/dev/null)
> > +		case ${sig_name} in
> > +		ILL|ABRT|BUS|FPE|SEGV|TRAP|SYS)
 
> [Severity: Medium]
> Will this miss Out-Of-Memory (OOM) kills?
 
> If a truncated perf.data file causes perf report to read an abnormally large
> size from a partial header and attempt a massive memory allocation, the
> kernel's OOM killer may terminate it with SIGKILL (exit code 137).
 
> Because KILL is missing from the case statement, the test will ignore the OOM
> kill and consider the run a graceful error exit. Should KILL be added to the
> list of failing signals to ensure resource exhaustion bugs are caught?

Will address in v2.

- Arnaldo
