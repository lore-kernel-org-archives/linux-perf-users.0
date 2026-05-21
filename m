Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61F376A12
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356091; cv=none; b=WaArXrz+lyv1ROxX9BSLCuhrUrQjj/Dn3gfB5+w6ouj5nngoUmikBMjhJrQB26+LPRQ88P1bNjrQPk3GqoovhbtvEfhEJtXtka0olyNruIzXhKmHTaUxJW8f563151N4BVFby2L970xRSWDa8XQYHMaPWzwUnUMLhdAuPwVbsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356091; c=relaxed/simple;
	bh=jFzvjiI2WvET81VnNYvF4B2DJpojBVT/qBYlIgxHOX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fbe5FjokB+RL4hYomQHNaS9pUrRb1gE8/8hyJpHZAly0A5SFe8ff0/TAwRPx9rKDBtPb3FdoSHiwEN8CtmodjlmzxuLQEMAO4jH+Bs7ZveUTVwOz8vDVGwiMJafhrIyBS2QeUhWq1RTfQVp96S0l9BfVDwmop1ziJ/h3jOVy35g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoiVX8yS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoiVX8yS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FA51F000E9;
	Thu, 21 May 2026 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779356090;
	bh=sT+14C9wKd2ei6pCm+gsKyRMBcWOwR2s6qKvk+Hhuuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XoiVX8ySLwt7ajRi/WkbBbXdziS+BIKxJSc2QIdLWMWXaY8ACNyK9juxoMzPuRo5E
	 pNXSo5g5lKnWWUi+rbMLakyWnK6s1I1KFBvSzq0cs0oOAizJoEgGlalupEwzYm7iFL
	 t+r3+a+bqPwHS6t2dzOI8GHEPzMhprOqOGIqobSZCOntYq/Isi+Puu/w26pesel9dJ
	 ScxQilYDu0SkM4gnhwSIt24850o8d9VhgzbL4CTyL6jX4pfPUN0pBYzL6m+SFymwLt
	 LXo3KytG+UgJqpmQWoFFPnVfrts6YGVSr/5wSujw9b9B7sgtooU267LS3C4HUHl+lU
	 RsLgW0V+0TUmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] perf kwork: Fix memory management of kwork_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521072429.1283423-4-irogers@google.com>
References: <20260521072429.1283423-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 09:34:49 +0000
Message-Id: <20260521093450.48FA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The top_print_work function passes work->name to printf without =
verifying it is non-NULL, which can cause a crash.
--

commit 03666bc88a2d8e65da244923eb1ef63e0a473153
Author: Ian Rogers <irogers@google.com>

perf kwork: Fix memory management of kwork_work

This commit implements a global cleanup function to free all kwork_work
and kwork_atom_page objects at exit. It also fixes memory leaks during
task merging and ensures all name fields in struct kwork_work are properly
allocated and freed, while adding robustness checks for NULL names.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index a4604e1520023..f793ea578515d 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
[ ... ]
> @@ -1002,13 +1051,16 @@ static void irq_work_init(struct perf_kwork *kwor=
k,
>  		work->name =3D NULL;
>  	} else {
>  		work->id =3D perf_sample__intval(sample, "irq");
> -		work->name =3D perf_sample__strval(sample, "name");
> +		work->name =3D strdup(perf_sample__strval(sample, "name") ?: "<unknown=
>");
>  	}
>  }
> =20
>  static void irq_work_name(struct kwork_work *work, char *buf, int len)
>  {
> -	snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
> +	if (work->name !=3D NULL)
> +		snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
> +	else
> +		snprintf(buf, len, "%" PRIu64 "", work->id);
>  }

[Severity: Medium]
This is a pre-existing issue, but while you are adding NULL checks for
work->name here, should top_print_work() also be updated?

If strdup() fails due to memory pressure, or if bpf_map_lookup_elem() fails
in BPF mode, work->name can be NULL. In top_print_work(), work->name is
passed directly to printf() as a string, which can cause a segmentation fau=
lt
on strict libc implementations:

tools/perf/builtin-kwork.c:top_print_work() {
    ...
	if (kwork->use_bpf)
		ret +=3D printf(" %s%s%s",
			      work->is_kthread ? "[" : "",
			      work->name,
			      work->is_kthread ? "]" : "");
	else
		ret +=3D printf(" %-*s", PRINT_TASK_NAME_WIDTH, work->name);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521072429.1283=
423-1-irogers@google.com?part=3D3
