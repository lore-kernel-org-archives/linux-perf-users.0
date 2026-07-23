Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94033E37A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784462; cv=none; b=ZjNbJAPSCqo0yxVDXv6gDti72CPbPT86BtAgm1GNHWhhBIGDSa4584tAspPUNAgA943bBhHA+7hbogLLYX+cfWu5+AXiUNG1WVt58vo6ozxN7ptGSHutGxKID70DwTIC9B2AjlPcaXv83NLg+cRRNHMh4HmXKIYw8thj7vFP6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784462; c=relaxed/simple;
	bh=c0FRmAPRXZ9bjVPlGe9ieCokKq0LZbF7OGVY8hAARfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KE3j/T8H+LVfgra9/h0Jqd0VJgnwaJMR7cO3O2dd1k4RkPbXO+0Zgmg/2Jmv6J7k+s7dpIcz6Q75z7RNQ+N8jFNbSxsMHLjG8mgqNHkuVrsQdYmdOehkz6eQHSGQfyBbKetXKCc/RDIS7Zl52uO+1ai4RnhadklSCJLAFziY8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMKJNKbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMKJNKbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE871F000E9;
	Thu, 23 Jul 2026 05:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784784461;
	bh=HG6ru6VdsAp4sW2ADf7s8JJgw8e08lPLtCMjZqFVTdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMKJNKbP32WH0StF+EWEQSCqaaQdmTOOFIvqR3W00ubP3BeHla6dLrVghYmk9T0Wc
	 2o40BrS/MkN/d/0/5sKuP5KrBOk9tsealTUbvaWUrdpiyWSRl/Jqg78vgs+cxfmSNj
	 XD9ACMqz76bIwz9CDDUA2db9KBNXYWnuxyKa1U4ofVopVXGpbZERfRtwlJIQtWofSB
	 QmxwzMkU6OFE49wHyDKKPbYumzkklpEtw/iFROKYcSjQLGAqOlQOcS/FPPUOxEJDhD
	 ajJch8BHiL918rRg+l6w9349KY7HWPQOuueyL5/8vRVFHua1fGgnnfRHo/h6a/IUrq
	 Z4BFSP+Y1ropA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf record: Fix destructor invocation and event
 counting in fdarray__filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723050409.991665-1-irogers@google.com>
References: <20260716073753.567782-1-irogers@google.com>
 <20260723050409.991665-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:27:40 +0000
Message-Id: <20260723052740.EFE871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch completely breaks the 'nonfilterable' semantics for syst=
em-wide perf events, erroneously causing them to be filtered and their mmap=
 references to be prematurely dropped on POLLHUP.
- [Medium] The patch is based on a fabricated premise regarding the active =
event count (`nr`) increment, making its core logical changes redundant whi=
le introducing regressions.

Pre-existing issues:
- [High] Unhandled POLLHUP on non_perf_event descriptors causes premature t=
ermination due to thread and evlist pollfd index mismatch.
--

--- Patch [1]: [PATCH v3] perf record: Fix destructor invocation and event =
counting in fdarray__filter ---
commit 251ec969368be86f9fe7f805b44d3a39b2228d7f
Author: Ian Rogers <irogers@google.com>

perf record: Fix destructor invocation and event counting in fdarray__filter

This commit modifies fdarray__filter() to change how nonfilterable and non-=
perf
events are handled during poll events. It removes the early exit for
nonfilterable descriptors and adds a conditional block before incrementing =
the
active event count.

> When processing POLLHUP or POLLERR for an event in fdarray__filter, the
> function invokes its destructor callback but fails to re-inject the
> nonfilterable exclusion masks into the active event count (nr) increment
> condition. Because auxiliary and control pipe descriptors never enter the
> POLLHUP event match block, their active event count is unconditionally
> incremented, preventing the return value from reaching zero on target
> process exit and trapping __cmd_record() in an infinite drain poll hang.

[Severity: Medium]
Before this patch, descriptors marked with fdarray_flag__nonfilterable hit a
continue at the very top of the loop, skipping the loop body entirely,
including the ++nr increment.

It appears they were never unconditionally incrementing the active event co=
unt,
meaning the patch might be attempting to fix a non-existent bug by modifying
the increment conditionally instead of fixing the root cause.

Is the description of the original behavior in the commit message accurate?

> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 67b73481df27e..f97afbd6f07ac 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -116,9 +116,6 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  		return 0;
> =20
>  	for (fd =3D 0; fd < fda->nr; ++fd) {
> -		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> -			continue;
> -

[Severity: High]
System-wide events are assigned fdarray_flag__nonfilterable but not
fdarray_flag__non_perf_event, as seen in mmap_per_evsel():

    flgs =3D evsel->system_wide ? fdarray_flag__nonfilterable :
           fdarray_flag__default;

Without the early continue, when these events receive a POLLHUP or POLLERR,
they will now fall into the revents block below, prematurely trigger their
destructor (unmapping the perf event), and have their fd set to -1.

Does removing this early continue break the semantics for system-wide perf
events?

>  		if (!fda->entries[fd].events)
>  			continue;
> =20
> @@ -126,6 +123,9 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  			if (entry_destructor)
>  				entry_destructor(fda, fd, arg);
> =20
> +			if (fda->priv[fd].flags & fdarray_flag__non_perf_event)
> +				continue;
> +

[Severity: High]
This isn't a bug introduced by this patch, but when the ctl_fd receives a
POLLHUP, it skips setting its fd to -1 in the thread's poll array.

Later, evlist__ctlfd_process() handles the command and calls
evlist__finalize_ctlfd(), which explicitly sets the core evlist's poll array
fd to -1.

On the next iteration, a mismatch is detected:

tools/perf/builtin-record.c:record__update_evlist_pollfd_from_thread() {
    ...
    pr_err("Thread and evlist pollfd index mismatch\n");
    err =3D -EINVAL;
    ...
}

Could this cause perf record to abort with -EINVAL and data loss when a
control descriptor is closed?

>  			/*
>  			 * Set fd to -1 so poll() ignores this entry; otherwise
>  			 * POLLHUP/POLLERR are still reported for events=3D0 fds
[ ... ]
> @@ -136,7 +136,9 @@ int fdarray__filter(struct fdarray *fda, short revent=
s,
>  			continue;
>  		}
> =20
> -		++nr;
> +		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable) &&
> +		    !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
> +			++nr;
>  	}

[Severity: Medium]
As noted in the commit message review, nonfilterable descriptors used to sk=
ip
the loop entirely via the early continue at the top.

Since they were never reaching this point, is this new check redundant?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050409.9916=
65-1-irogers@google.com?part=3D1
