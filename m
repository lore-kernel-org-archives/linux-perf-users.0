Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFA5013AD
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780256; cv=none; b=iL6MZ4OIBuySt/thLXgWBZbDZmLL3E/GsiecEX6Vur8Q44TI+k1oD5L2rGy6eiL6RuWDaEM59xcENdCr8s5Z1XU61UTs/JsnmhcUiJo9Nz5eFpMnKYOBla5RoAG4C8rOdRyAF16QcFCaTbgFcAOIx2kGzVXO0ZJkiGkWd01Rgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780256; c=relaxed/simple;
	bh=TgQozvBAT7GYM/DjQUJoiJAbF3/TBupjNLoMN6YLNXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLJIRkCzjxVvsQckcpVmlMBQbqvQfzH+9RAfB2n+d7sMF9M/2NaN2ow05KG/nQj7vcZAWXIly8n75h1GbscM6fgsIyC9JbkASjUy3+b/lHTc82enu02vnPEZi5y7cWem3LNRMVFRczgDgG6kXfCuSCVX5Rfp6DkZCE/j96nIuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gricQvwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gricQvwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02331F00893;
	Wed, 30 Sep 2026 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780246;
	bh=jvq3Uo0vpwUlFTlCxpc82gK6CzZBKVeyIrzlGa7OFCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gricQvwNfPKTmRJu5Qgjbp97Gp5wrDFlBwYG0MftLWXUGshNdLiuyJ1nB6pXd7eQX
	 Z4QrlcNesamWK+cfx9BTcPPPLrGStz6UzwOelGPLZCwCpGY/PgSf1cAFF36vVJmR5E
	 Eq+0mhRGzbJ8piqnfiSV6cxncX/s4E3NGZFzxyl5lywgHI0wyAEcU6Z84cVlepyLYu
	 k8lYBcHJCLbGlNQv4WawpU0foLORzevkGM6ffSTTwmfMOSFpdJjv8iJLpRx6rDe2WV
	 jchTNPmxJYwORZd5fjmNN/CUcfvdfdzITJQU+yTuaEN7Fnrj0mtpF0Duk1xddehSk/
	 M2CIfqQAtsrCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Don't send SIGTRAP after exec removed the
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danish Khateeb" <danishkhateeb03@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930144248.59858-1-danishkhateeb03@gmail.com>
References: <20260930144248.59858-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:57:26 +0000
Message-Id: <20260930145726.B02331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing READ_ONCE() on concurrent lockless access to event->state
--

commit a39b84d0fe4531dad91da56d867a84ee0e8c6cf6
Author: Danish Khateeb <danishkhateeb03@gmail.com>

perf/core: Don't send SIGTRAP after exec removed the event

This commit prevents sending a SIGTRAP to a process after an exec() call has
removed the perf event. It adds a state check in perf_sigtrap() to ensure
signals are skipped if the event state indicates it has already been remove=
d.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 634d2ccbab82d..eabe6cdf7a888 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -7631,6 +7631,15 @@ static void perf_sigtrap(struct perf_event *event)
>  	if (current->flags & PF_EXITING)
>  		return;
> =20
> +	/*
> +	 * The event was removed after this signal was queued, e.g. by exec()
> +	 * (remove_on_exec), which may also have closed its fd (close-on-exec).
> +	 * The new program has default signal handlers, so a SIGTRAP would
> +	 * kill it.
> +	 */
> +	if (event->state <=3D PERF_EVENT_STATE_EXIT)

[Severity: Low]
Does this lockless read of event->state need a READ_ONCE() annotation?

If another thread sharing the file descriptor calls close(), perf_release()
can run concurrently on another CPU and modify event->state using
WRITE_ONCE(). Under the kernel memory model, reading a variable that can be
concurrently modified typically requires READ_ONCE() to prevent compiler
optimizations like tearing or rematerialization, and to avoid data race
warnings.

> +		return;
> +
>  	/*
>  	 * We'd expect this to only occur if the irq_work is delayed and either
>  	 * ctx->task or current has changed in the meantime. This can be the

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930144248.5985=
8-1-danishkhateeb03@gmail.com?part=3D1
