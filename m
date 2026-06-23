Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4F3AFAE2
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250898; cv=none; b=WPcbv9Z7MyVaRH8CLIB0JdURCUvWwleUt5ZcogTeAmHBAlvwhGoCc2Fig61ZAX4f8BGTx/GaklZQQcrfKp7J5lriNplYbrhkNhJv4yG4CPnwBOzMN+yJC8aYXfiFiY8ZtlNtZ8QJkapFtlPrLjPaoOF86URRuOElS4sHt8w4YKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250898; c=relaxed/simple;
	bh=kORnAM7rn5XQb6EWKB0bHQbZ6CjShM7kHoE0YuLnVUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n8qtl/GhSjvteoaNaqqQopwerKuKKZ/rYRgj3mP9pD03Iy9iQYkjC3kok0U8j/8jz8wN41foa6gWrkOFH2m5q44/BaRtigcFvOwMFq6ZUBxCpkqraSvA2F9fLq+a3pY0R3S6R/7jJDSO+HSs7XdEuN9nz/8AtjG6WvX4t4W8K2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byhiWYIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byhiWYIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C421F000E9;
	Tue, 23 Jun 2026 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782250895;
	bh=XsAEp+3/E7i4zPKUrIzy9SKY9WSxVzo9Xcoka1BwrZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=byhiWYIxwruh9GoHeh62NA9V0zl++pN52JY7N2ZngRYsKLBkM+uhYQCfEd7doS+qR
	 B6CiM9x2pqev6G6vP2m5ifBy7ObxGnVCkSs1FKyeA2+pmfrs9sXTH4buCD/DLzwn2N
	 1rd9sLrRIcu2K/Y7l4dFKN3N5ZPOIyHTFSeHfsONm2urq7z3VUHXx9tmhqckcLWT/w
	 FuQjxiSs9WEM/kBmkX2SJW9gv9W0so9j0d8/V1nlIzoqfPN51J8WwsNxX6cc7FTUF0
	 mguPffB2QTnDRjt4TcSdhgHlrOJmx+skRTYptnTPxhclkLgqUqmBgPJ8Uq0N3SzhoH
	 Xc6UrCtBPS0wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/13] perf synthetic-events: Fix uninitialized
 pthread_join
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-6-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:41:34 +0000
Message-Id: <20260623214135.67C421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Divide by zero crash in perf_event__synthesize_threads when no tas=
ks are found.
--

commit 30888fa2ce27193736ae38293c89b11a5e47a514
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix uninitialized pthread_join

This commit fixes an uninitialized pthread_join() call when thread creation
fails in perf_event__synthesize_threads() by ensuring only successfully
created threads are joined.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index b75f9dcf4dbfe..35de41ad14d33 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1104,8 +1104,8 @@ int perf_event__synthesize_threads(const struct per=
f_tool *tool,

[Severity: High]
This is a pre-existing issue, but does this code suffer from a fatal
division by zero when no tasks are found?

If scandir() finds no matching tasks in /proc (which can happen in an empty
chroot or isolated container), n is 0. If the system has multiple CPU cores
(thread_nr > 1), we bypass the single-thread fast path.

perf_event__synthesize_threads() then clamps thread_nr:

    if (thread_nr > n)
        thread_nr =3D n;

And shortly after evaluates:

    num_per_thread =3D n / thread_nr;

Does this divide by zero (0 / 0) and cause the perf tool to crash with a
fatal SIGFPE? Could we handle the n =3D=3D 0 case earlier to prevent this
regression?

>  	}
>  	err =3D 0;
>  out_join:
> -	for (i =3D 0; i < thread_nr; i++)
> -		pthread_join(synthesize_threads[i], NULL);
> +	for (j =3D 0; j < i; j++)
> +		pthread_join(synthesize_threads[j], NULL);
>  	free(args);
>  free_threads:
>  	free(synthesize_threads);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D5
