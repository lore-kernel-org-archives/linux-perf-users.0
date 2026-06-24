Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7331ED81
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278852; cv=none; b=tpz6J5jrgdoe7wABo7bmCXIfwjnQWHV8iyryy8J+jlUAeaJLvVRRMGkY+gXW7v0JqUwpp/KZTv3T6tvRWL/dYcYOqhcqCQydvnWRZuaCm1JzY+/umYq3aPp32S2aHz7Cfbf8c4NCXkdGwpiIn/aH3EHP3OQa1z6/ddoFqCNmfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278852; c=relaxed/simple;
	bh=ceFIDcs8n8JWVfjSXIVv5qb1HceJ0wykTKBLoVY9OrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IB34WWLLCePcVCUHHncySHoReW0C1Tg2mwhMmktXBbIDyUB8yERWwEmkNZZISeYgmehmpi/5ldPqYT+4fY/XhOtgO/jNxxzZoYPRtpeQ8iwKiOj4fEngZ6w3od4nYyvqbzchKX7li04leRQSmW05xgjSwLA+jQBg54A3Ecu11jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjku817Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjku817Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539231F000E9;
	Wed, 24 Jun 2026 05:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782278851;
	bh=6MGiWy5zMsg4n9PlM8vucY15wW5Gw+kAFIOg8f+Mo3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjku817Y4aMFcGs37HXnYQXyMRI1kQs0hGTPtWHxqn6151PcVLif0OtQ5K/SayhQO
	 q9XS62RXK37h8rxdWxDHDfnDzHOngf5K8W0XY0uyia0fCryWorBiP9j6m1HiWcPr5R
	 R3o5qwY8EcpWn9r1figvYW71/brc0EJAD6sh5UDbCr2T8sEewhWY7LCkQQ8sr61W+W
	 SBFRqjfb8uAGK3G9kd0sfFrqZrJJShtlQNpfpJRYENxU43lK5I25r/ViB3ziE80mK5
	 FoWys8eja+Huzh8URp/9rd+jtDNYILMaNmZlwfIxWwIsD/eXBZDB7yodLQLtp65TV1
	 bpL5stzcoEmIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/16] perf synthetic-events: Fix uninitialized
 pthread_join
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-7-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:27:30 +0000
Message-Id: <20260624052731.539231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing explicit POSIX inclusions for <stdlib.h> and <pthread.h> in=
 synthetic-events.c.
--

commit 9ead28d76c34623188955779076a3c283fe73884
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix uninitialized pthread_join

This commit fixes an uninitialized pthread_join() call in
perf_event__synthesize_threads() when thread creation fails. It updates the
cleanup loop to only join the threads that were successfully created.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1104,8 +1104,8 @@ int perf_event__synthesize_threads(const struct per=
f_tool *tool,
>  	}
>  	err =3D 0;
>  out_join:
> -	for (i =3D 0; i < thread_nr; i++)
> -		pthread_join(synthesize_threads[i], NULL);
> +	for (j =3D 0; j < i; j++)
> +		pthread_join(synthesize_threads[j], NULL);

[Severity: Low]
This is a pre-existing issue, but should this file have explicit POSIX head=
er
inclusions for <stdlib.h> and <pthread.h> to ensure compatibility with musl
libc? The code here relies on pthread_join() and free(), but appears to
depend on implicit header inclusions to resolve them.

>  	free(args);
>  free_threads:
>  	free(synthesize_threads);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D5
