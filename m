Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C453242BA
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307680; cv=none; b=aWHl2tRmueJ5YWFV7aYVc9UXPpb11XvHVGfnGqBpnBZGqAiPAVgbxJpFMts1Y6/pkzcUa5+C6JQokE4pvSk5kBuNSrp4SBGgCr7Gpp/o07QndS9186xhHAjyYnW38LfrBWn0H3cD0b2HSaQNQvHyB/CYBxTEG3jfvV9EmZGb2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307680; c=relaxed/simple;
	bh=PHoKJ+GejHOY0MnVd6H8QKIhJbbxo8iLod7sKuLBnmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xp2MKXwEuyaIZLqw2OAybKtFxe0852xZoVEco3xe+lK2j3Hb8LKancJvb4dZz+QiFCsQLDXdqF6U6gJO17PDXXtWy6PekzYghTfA+msXWkWPH+JVqF1chQl/iwUtMZPZRp83eBA4YBk6hv8nJmqQCWlq+Uu1TT83/zOcxHsSZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHVkEo2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHVkEo2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2C31F00A3C;
	Wed, 20 May 2026 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307679;
	bh=NiuwJjT3UXhy9nQ6Wo8XUU8pAC8sWJG6mXXY3+Yx2HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHVkEo2IEj9Cwt+LrbSz9vTs+VnJU4lfQ3WwoInJUfFbmx8gADoRwiJLDZ5KaEaBM
	 ZR+b8rekdGOLvZXhx69+6RTUlCTnJYalOMAwv7FSjX9Zkt6anicvU/HIbjEsTH3lWP
	 Lzlj6jlwOmYN7rzSuDkAAZmj7q9f+ilqEhle64ne6rrGnXYtyOCzC1hw17caQ+FKC5
	 7cDA4nYaJp63sBlFGCOYMTtiy4SqdacqONHZt8uuNU00spasetyy47ISq2CuS7bS7O
	 utfBRMjrP2eNVWKg6sdScepc584qYLjOQd1KDMXQhULqqoDv6hp+4DOgys8/IxzkOI
	 tWJ7Ar5C5sN4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 32/32] perf kwork: Fix memory management of
 kwork_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-33-irogers@google.com>
References: <20260520190538.142018-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 20:07:58 +0000
Message-Id: <20260520200759.1E2C31F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `work_exit()` is called unconditionally from `builtin-=
kwork.c` but defined in a conditionally compiled file, breaking builds with=
out BPF skeleton support.
--

commit 215df5dc0c33de431c1c387ccda2468e8d531dee
Author: Ian Rogers <irogers@google.com>

perf kwork: Fix memory management of kwork_work

This commit introduces a global cleanup function and fixes memory leaks rel=
ated
to kwork_work objects in builtin-kwork.c. It ensures that name fields are
properly allocated and freed by using strdup and adding work_exit routines.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index a4604e1520023..f793ea578515d 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
[ ... ]
> @@ -371,11 +371,54 @@ static struct kwork_work *work_new(struct kwork_wor=
k *key)
> =20
>  	work->id =3D key->id;
>  	work->cpu =3D key->cpu;
> -	work->name =3D key->name;
> +	work->name =3D key->name ? strdup(key->name) : NULL;
>  	work->class =3D key->class;
>  	return work;
>  }
> =20
> +
> +static void work_delete(struct kwork_work *work)
> +{
> +	if (work) {
> +		work_exit(work);

[Severity: Low]
Will this cause a build failure when perf is built without BPF skeleton
support?

work_exit() is called unconditionally here (and in work_push_atom and
work_pop_atom) in builtin-kwork.c. However, the definition for work_exit()
was placed in util/bpf_kwork.c.

If a user compiles perf on a system where HAVE_BPF_SKEL is disabled,
bpf_kwork.o will not be linked. Could this lead to an undefined reference
linker error for work_exit()?

> +		free(work);
> +	}
> +}
[ ... ]
> diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
> index d3a2e548f2b62..70b711e1a23fa 100644
> --- a/tools/perf/util/bpf_kwork.c
> +++ b/tools/perf/util/bpf_kwork.c
> @@ -53,6 +53,14 @@ static struct kwork_trace_bpf *skel;
>  static struct timespec ts_start;
>  static struct timespec ts_end;
> =20
> +void work_exit(struct kwork_work *work)
> +{
> +	if (work) {
> +		free(work->name);
> +		work->name =3D NULL;
> +	}
> +}
> +
>  void perf_kwork__trace_start(void)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D32
