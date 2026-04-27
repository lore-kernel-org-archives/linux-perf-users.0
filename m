Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B22DF12F;
	Mon, 27 Apr 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329164; cv=none; b=V3vioPdfW+tAVyCguiQINBS3PeeLG93GOXHowU4O0E3YbeZFsaSjuXrm6cdU7bbDiasSnraJ6ixL7b3OP8IMoKjQv+qBLknRWPl1gC8sFfIcvlDl1IRP9x81XI3BvrYAJc7g1CVeYyPM1/wgVJ8VQvW/cUnh99TCNSCS86xI/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329164; c=relaxed/simple;
	bh=TrxfmseYikTsEh9knmvKXJvB//fVaqjJqYhtjV2MEGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJQ31TUAcKXN5BmWGYqurNR211i2HV57udUOg7YEgbkskIjffRONuudSnEVFTNj38gi9/C2vLcIFHnj6AuGoa3r+AJgFTX96RRaSSy4GiPoyC9SemmwlAhCHOC7S+4RxFN9aNSGMRTnXQYBjZm5PwFcdl2ce8GBUvazPaZ4B/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJzViXrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJzViXrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B203C19425;
	Mon, 27 Apr 2026 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777329163;
	bh=TrxfmseYikTsEh9knmvKXJvB//fVaqjJqYhtjV2MEGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJzViXrRYTTYzC7rWzdbktKPRjCSxPOxyOqHSxrgLixLP+HOamuT/qh0kWmr6eN/X
	 TKnnvjTp9PjDy3D5ZSjaw6aIe+jL70miCqt4CIvyjduxUiaxr94ZIW4FbGf043ENRU
	 mMTL2czhgFzmDusBg54ZPe7m24gUDpEOYYWID4wnLEMiYUU3a0jOtlZZCgDXO8oz61
	 W4r/ihsVz1dqdSupxZqdHFs1Rd6qixaTPLYRRp1fMgs68lu2i1jNXu/NdSRM/JVkPG
	 sK1rS1QqeXiPA5J61Mo4iDtEHDmKazB28So/Zt184oS1Zk0QyWLIu5dc40JGFWgymz
	 oC9gFyrCLntvA==
Date: Mon, 27 Apr 2026 15:32:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Martin Kaiser <martin@kaiser.cx>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf test: fix sys_enter_openat event test for musl
Message-ID: <ae_kClvu1mDBE218@google.com>
References: <20260427090225.794482-3-martin@kaiser.cx>
 <20260427094939.4FB8EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427094939.4FB8EC19425@smtp.kernel.org>

On Mon, Apr 27, 2026 at 09:49:37AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The updated bitwise check `(tp_flags & flags) != flags` fails to verify the `O_RDONLY` access mode and permits arbitrary unrelated flags, severely weakening the test.
> --
> 
> commit 0700122c98ba7f263a329cd8f9fbeef95b67603e
> Author: Martin Kaiser <martin@kaiser.cx>
> 
> perf test: fix sys_enter_openat event test for musl
> 
> This commit updates the sys_enter_openat test to allow additional flags in the
> captured event. It replaces the strict equality check with a bitwise mask check
> to accommodate the O_LARGEFILE flag implicitly added by musl libc.
> 
> > diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
> > --- a/tools/perf/tests/openat-syscall-tp-fields.c
> > +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> 
> [ ... ]
> 
> > @@ -120,7 +120,8 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
> >  
> >  				tp_flags = evsel__intval(evsel, &sample, "flags");
> >  				perf_sample__exit(&sample);
> > -				if (flags != tp_flags) {
> > +				/* C library wrapper may set additional flags */
> > +				if ((tp_flags & flags) != flags) {
> 
> Does this check still verify the O_RDONLY access mode?
> 
> Since O_RDONLY is defined as 0, the flags variable evaluates to exactly
> O_DIRECTORY. This means the condition functionally becomes
> (tp_flags & O_DIRECTORY) != O_DIRECTORY.
> 
> Does this unintentionally permit other access modes like O_WRONLY or O_RDWR,
> and ignore other unrelated flags as long as O_DIRECTORY is set?

I think it's ok for tp_flags to have more flags.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> >  					pr_debug("%s: Expected flags=%#x, got %#x\n",
> >  						 __func__, flags, tp_flags);
> >  					goto out_delete_evlist;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260427090225.794482-1-martin@kaiser.cx?part=2
