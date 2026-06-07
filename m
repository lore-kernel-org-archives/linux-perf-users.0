Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FED308F38
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875739; cv=none; b=Pw+jxW+B5lpUIHpWoQoK0ezhHAcJgVvKgrqjHEbtKSQFMplUvJrCf6iIa7388Cfja0enIvaEEo9XcnudF1SG+vAU8NBFpM5Fd1aMegv5MF6Pw5Ka+VZ6Gn7i0AStZVP7Sqdml4+gJGgA5n0CTp2/oDkjMdQCtVWuLwiTQevsT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875739; c=relaxed/simple;
	bh=KfP59EXrqwC+zZfg83JKFoLJlKEenRZghTA5K3GfNNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3yO3ofK0f+u+NLmTl4LE0rhWaqN/zPMjZS3OpmvcAzxql+WPAPHiK4QLxt0RxEV/2dyHRtsdwHQXueazY9zCrKTIr7zNVBsdn1GSh5zUoGq4SlYvEfmJO98ZL8rbUux65E76XSWArIiaovBE85LkQ4YA1nsKjkLqIJoItLUlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+Nooama; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+Nooama"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1625A1F00893;
	Sun,  7 Jun 2026 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875738;
	bh=+jpVUEEz3njuYS18GgFhJY6KcPYCzbHHHPu9Q6fZ2ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+NooamaWnBfX/w8EIfWdSfFvyw2c1yjLPe2v7uJQuPUtvMG/1k/exv0o78075hqu
	 GAU+sdGSRB+nPkgssGuEqhqn1rJa/Zbaray/ilTJ76TSxLfiFnJwXMss7Ulxye6dEY
	 /onyjEVurFDBXjPmkspHsqPWOZtWRQdai69gdNI1/B54tw6wxHbHONCTDi2eQNMhfl
	 ku+YHI0iQ8vD+6AuMviVRs9MuUgm5ANSXHEEjRi/KhIudUrZ6rQISJmTqLi0zYJVJJ
	 wV9jaEFROuKj96LU7ufC1MjWqPHRkYHd+wHT0yhTK+aZ4h8U7TE9ItDIkQrvIbLzqS
	 WAcnT8N7vqchg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] perf sched: Bounds-check prio before test_bit()
 in timehist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607232925.1935819-7-acme@kernel.org>
References: <20260607232925.1935819-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 23:42:17 +0000
Message-Id: <20260607234218.1625A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Logic inversion in priority bounds check breaks --prio filtering=
 for initial events.
--

commit 1cea9987d6681e3cb6b64fbd144fd651abc72351
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf sched: Bounds-check prio before test_bit() in timehist

This commit adds bounds checking for the priority variable in
timehist_skip_sample to prevent out-of-bounds memory accesses in
test_bit. It attempts to skip samples if the priority falls outside the
valid range.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 1ff01f03d2ad1..5f3510f9ca249 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched =
*sched,
>  		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
>  			prio =3D perf_sample__intval(sample, "prev_prio");
> =20
> -		if (prio !=3D -1 && !test_bit(prio, sched->prio_bitmap)) {
> +		/* prio comes from untrusted tracepoint data =E2=80=94 skip invalid va=
lues */
> +		if (prio < 0 || prio >=3D MAX_PRIO ||
> +		    !test_bit(prio, sched->prio_bitmap)) {

[Severity: Medium]
Does this logic inversion unintentionally skip valid initial events that do
not have their priority recorded yet?

In timehist_skip_sample(), prio is initialized to -1 to represent an
unknown priority:

    int prio =3D -1;

With the previous logic, an unknown priority of -1 caused the condition to
evaluate to false, allowing the event to pass the filter:

    if (prio !=3D -1 && !test_bit(prio, sched->prio_bitmap)) {
        rc =3D true;
        sched->skipped_samples++;
    }

With the new logic, the condition prio < 0 evaluates to true when prio is -=
1,
causing the event to be unexpectedly skipped.

>  			rc =3D true;
>  			sched->skipped_samples++;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607232925.1935=
819-1-acme@kernel.org?part=3D6
