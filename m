Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DF2AD37
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698017; cv=none; b=PBrgBFedl1PXc3QD/g1LP/+18rol9JMhLdw9QiR7T5Tjy+AZ7O8yGocerGzpIfTcZpOlUjC+Xoom4hmEuHnRKaAK74Fv8uGFEb//oAOCqKPu7qIZ9knExtgkbAcqKQdmcMzqaa6/2rc+h86dFYApKOK+WOyUU/F+5awNT9IIIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698017; c=relaxed/simple;
	bh=vwHHbnV1p22QTJHuUmg875rg9+W7XGJf6P9Z2m51m1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GKMYFdhLSqyQaf8TG6MefLEhcs/la+A4DVtcgRprm6W22bZTOtkFf2Tx92vWXM2zefrff6lQjdvM14iQaD5upDfu3utmlYyOdbqOQ4tEPoCdVoto3wj97DwZ3CXj9IzMYBpuKkwZ0PmLBf5IMf+lW3VXR9u80yzij5MqOs9A8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcioKvMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcioKvMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC681F00A3A;
	Sun,  6 Sep 2026 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788698016;
	bh=EN+I5sn8iNpsXhh86NTXh7ET+vjXoako9R63BF04hPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcioKvMk1NkiDR4puRIGYX8S+bK72W2baa1JVLk6CyJ5rZOlh4axDzkjf0aFVVVTz
	 Tk3KJ+4U7uHvkqSoj6dhxWbWgGmUKjWIh9THeVJin81Z9oqkA36QpOH2Tp6HTEaw3b
	 w5UCQHxa6IGAwhEatyOHBND0P4Pjq3eELjPTn8N7PWKLu+Q8c2H9DZH/tFS9AogNG/
	 R0Z3Oc8szs/764Hz6eqQcLcy7dUHINk9RjaVnwP9V9arC+iLLiFzzU26+DIqW4GjBg
	 L/5kOjLX9ujHs1ozrnCq80xse1xvJsp2OyHCR8sKiRclOoLLfkjakMjs4k6xoNA+RO
	 VXOaoGNU16hRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Strengthen userpage update ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thaumy Cheng" <thaumy.love@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260906122350.24305-1-thaumy.love@gmail.com>
References: <20260906122350.24305-1-thaumy.love@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 12:33:35 +0000
Message-Id: <20260906123336.1BC681F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting seqlock writer re-entrancy bug in perf_event_update_us=
erpage leading to corrupted data for userspace readers.
--

commit 019372a4e61c18f0c5a22ddb487c7acef14ffc7e
Author: Thaumy Cheng <thaumy.love@gmail.com>

perf/core: Strengthen userpage update ordering

This commit replaces compiler barriers with smp_wmb() around the userpage
payload update in perf_event_update_userpage(). It aims to strengthen the
publication ordering for cross-CPU readers of time conversion fields on
weakly ordered architectures.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..9c6dfb79fd77d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6858,7 +6858,8 @@ void perf_event_update_userpage(struct perf_event *=
event)
>  	userpg =3D rb->user_page;
> =20
>  	++userpg->lock;
> -	barrier();
> +	/* Publish the odd lock value before updating the payload. */
> +	smp_wmb();

[Severity: High]
This is a pre-existing issue, but does perf_event_update_userpage() have a
seqlock writer re-entrancy bug here that defeats the synchronization?

Since this function disables preemption (via preempt_disable() earlier in
the function) but leaves hardware interrupts enabled when called from task
context (such as from perf_mmap_rb()), what happens if a PMU hardware
interrupt like an NMI triggers during this window?=20

If the NMI handler also calls perf_event_update_userpage() for the same
event, it would increment userpg->lock again, advancing it to an even value.
A concurrent userspace reader on another CPU would then see an even lock
value and could read actively-torn payload data (like time_mult, time_shift,
or time_offset), leading to bogus timestamps.=20

Should hardware interrupts be disabled before incrementing the seqlock to
prevent this writer re-entrancy?

>  	userpg->index =3D perf_event_index(event);
>  	userpg->offset =3D perf_event_count(event, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906122350.2430=
5-1-thaumy.love@gmail.com?part=3D1
