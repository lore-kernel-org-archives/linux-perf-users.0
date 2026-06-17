Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D7352007
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731227; cv=none; b=DVOUBFRPZ3y/rWj9eIDcytxUCLG10u8DOu5y4cyBlvCA5cepxuox4P2v7FLs5LWH58oHvEdeX7l3qWvGV7Y4fOYqKhEfpj82VKU8onmhZZ0SbVzEDRoXlkcVSnK2FmyN1xyaEZGKkyvsJGzxPH17w/nclqSEaC+mV/CGvUlHSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731227; c=relaxed/simple;
	bh=Ulknh3sXPM0HGu0jLeLHBRQbW0BuDdXFK3RjOmt6Imc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gboMmqobFmMyj0vHPa/XnM0pQkEiDkE+m6Q9B0BgAGKA616arawaMu5j2kawMIFoMVGKWpUofCMZZToNIsYjqAzH7FZSGBd/+6N9aKbKqwyevOVIvZFTLUxIMBjht8EaDiOXVXEt1C3i0GYNfOd5FHUIxf3zvkh9JeBlXvKQZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koz9I568; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koz9I568"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49EA1F000E9;
	Wed, 17 Jun 2026 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781731226;
	bh=PoBecDPHxMh2MGOsFdboUFrg4JF/wIHdd7c2xwyOFwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=koz9I5680MOP/29pgQ9yyqPI3zg1Jn4Xb+GjP2kHij10phUWwseHg9qbGXJlcOPAn
	 DP9DGnMBwO4TtLRHaZadVahWgDbbBQugcPmLBYuwWJD3Qeif5l1oAMNJbK/erX4ayP
	 medkxbWz3XmRvF449rDVnndu/l4aTYXNMy/xyN8Kf02pvMGMQ0rRhYDPDWv5t/Y2/8
	 85kv+YJdAQrUudw9DkrfB7RIVHbZY1yg2fAR57BW7nMyMmRk2YXUW/izyOo6jzcTGb
	 v/RYHTcXWFehhgNmD6O8Me5PmfL+fi/yZtjw+MEgAJZt7aiyGM6BhxY1aqE8pjyX7u
	 j3Uvr3AaSzUIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/9] perf cs-etm: Support call indentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-7-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <20260617-b4-arm_cs_callchain_support_v1-v10-7-e8b6e5d63db5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 21:20:25 +0000
Message-Id: <20260617212025.E49EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unnecessary allocation and tracking of branch stacks when only t=
hread stack is requested.
--

commit 169dda630ecfdc4196986b24719c6d9bd8a72971
Author: Leo Yan <leo.yan@linux.dev>

perf cs-etm: Support call indentation

The perf script callindent is derived from call stack in thread context.
This commit enables thread-stack when either itrace thread-stack support or
last branch entries are requested, and feeds taken branches to
thread_stack__event().

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index e43f0c1dd0078..30536b919af73 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -638,7 +640,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_q=
ueue *etmq,
>  	if (!tidq->prev_packet)
>  		goto out_free;
> =20
> -	if (etm->synth_opts.last_branch) {
> +	if (etm->use_thread_stack) {
>  		size_t sz =3D sizeof(struct branch_stack);
> =20
>  		sz +=3D etm->synth_opts.last_branch_sz *

[Severity: Medium]
Does this code unnecessarily allocate and track branch stacks when only the
thread stack is requested?

By changing this condition from etm->synth_opts.last_branch to
etm->use_thread_stack, it appears tidq->last_branch will be allocated and
tidq->br_stack_sz set to a non-zero value even when the user only
requests thread stacks.

[ ... ]
> @@ -1563,7 +1565,8 @@ static void cs_etm__add_stack_event(struct cs_etm_q=
ueue *etmq,
>  		/* Enable callchain so thread stack entry can be allocated */
>  		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
>  				    tidq->prev_packet->flags, from, to, size,
> -				    etmq->buffer->buffer_nr + 1, false,
> +				    etmq->buffer->buffer_nr + 1,
> +				    etmq->etm->use_callchain,
>  				    tidq->br_stack_sz, 0);
>  	} else {

[Severity: Medium]
Because tidq->br_stack_sz is now non-zero, this feeds into
thread_stack__event() and forces the thread stack subsystem to allocate an
internal branch ring buffer and update it on every taken branch.

Since etm->synth_opts.last_branch is false, isn't this tracked branch stack
completely ignored later, resulting in unnecessary memory allocation and CPU
overhead during trace decoding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-b4-arm_cs_=
callchain_support_v1-v10-0-e8b6e5d63db5@arm.com?part=3D7
