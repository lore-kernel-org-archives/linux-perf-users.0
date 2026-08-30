Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7443F104C;
	Sun, 30 Aug 2026 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068145; cv=none; b=Z1ab7cSFr1h8DrI9bbU0NfcchGnRfWouX0tJ3ht4rq/rv2TmUoikpsY6ZTWrNVI00RpQ78XVxCrpf7A8OGHRwpUO4UX9/9XdUKsGJls5yFSmJin17b6N7lZjsvqpsc92BNmjhee1Kj0tXZbIyO6A3Ttz3PB8VaOqaQoaLdd0sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068145; c=relaxed/simple;
	bh=Wml9QOI8fuoGxuEYW7poOWCL8vPRyBft1dto0Ic4VcQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Va84AzzD0CQ33iFKl7L1tDsjUw6jO+S0L27ztGCpT1v4GE1nBOHwueTuqqT5/08jNCLF73JNheemr88MtGsNSAK6x9Y+LTwguN3kMbD5iW9n3+KuzdzNXkitEnEZITu2jp8X7o/NbasDwzbh3xm075Row3Em7BnZ5kAGH4uYjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQXOxIuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQXOxIuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9833D1F000E9;
	Sun, 30 Aug 2026 05:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068143;
	bh=xooWg9MwtV39aWrq6giH4Pf5Dv7kaBBgLX5fEFfV/o8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iQXOxIuFxuXuC6eCuJzs0qKeFdkD3FJa0eTZ3fRpnBh10B9hLy4khXHeDcAzBM/M4
	 vcyNGWujWVmSkV6s58F3WxINmWFtwP5h31zW0JpvIsW4MJ8UnPUpBLXYCb13u+jNV3
	 depH5e2S3WPumjVi3w9/squNItgscXUqUvAdrKwUeobSluxTkD3qNrH/q5FJtzpEak
	 7P9BMSOyIqeLs0L5CHJ6tmMBFpEOjUczaG1mbsbOH+QlPFRMXXMt/mbQMHfeJixfA8
	 TpVhK55HPbBza8NgaSfZKvGCGxidS5wiNT+Q8f/Oxajb0bOyWsuzrkPosR1komqinH
	 kP0MRmIxhb4QA==
Date: Sun, 30 Aug 2026 14:35:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v13 08/12] selftests: tracing: Add syntax testcase for
 wprobe
Message-Id: <20260830143540.7d56a0a490869810eebf7df0@kernel.org>
In-Reply-To: <20260822093502.C0C1B1F000E9@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739068097.1520941.17014781036682940369.stgit@devnote2>
	<20260822093502.C0C1B1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 09:35:02 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The test comment `# BAD_ACCESS_ADDR` does not match the actual error logged by the kernel, which is `BAD_PROBE_ADDR`.
> --
> 
> --- Patch [8]: [PATCH v13 08/12] selftests: tracing: Add syntax testcase for wprobe ---
> commit fc72e33e91d484bd38ebdde9110dabef02740205
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> selftests: tracing: Add syntax testcase for wprobe
> 
> This commit adds a new testcase, wprobe_syntax_errors.tc, to verify the
> syntax error handling of watch probe events.
> 
> > diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
> [ ... ]
> > +check_error '^w'			# NO_ARG_BODY
> > +check_error 'w^10 w@jiffies'		# WPROBE_NO_MAXACT
> > +check_error 'w ^symbol'			# BAD_ACCESS_FMT
> > +check_error 'w ^a@symbol'		# BAD_ACCESS_TYPE
> > +check_error 'w w@^symbol'		# BAD_ACCESS_ADDR
> > +check_error 'w w@jiffies^+offset'	# BAD_ACCESS_ADDR
> 
> [Severity: Low]
> This isn't a bug, but should this comment say BAD_PROBE_ADDR instead of
> BAD_ACCESS_ADDR?

Ah, good catch! ;)

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
