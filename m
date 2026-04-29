Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5C38BF96
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492720; cv=none; b=c8vILJe82rauBZcNN+D65/izv+iVKb2hn6UqrPgRtfPi43l6xdxyY0nBf8Zj1JRkvlER64ltawdYtkxk6xQPZCkysSffQgqUNtkZ29H6acKyGYPavSUPYAHgkCBw2lkEm+PwbhPnXt1xyOqeViez+qFpnuDLUdIw0uYG6q1sy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492720; c=relaxed/simple;
	bh=Anh05KaOJVevxih8Th2T642fEHWvVGa6j/QImBU+3xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GROvsjBcorkvIxQMJbCJYZcRFK9vdtyxn8kAh6kLxu0KeP5sQLAPpGAER1h9b2hC1JX6mOzOmbUgJaiv0zxVM4Yisw/FsdUMG3OKBqRTc2AQvkBzatTVcLHyAc6qu3eq9VHcvVM32xLJVY9AyTLZ9up5MXCASHBsVEOlIau1+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwGDqRcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwGDqRcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF7C19425;
	Wed, 29 Apr 2026 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777492719;
	bh=Anh05KaOJVevxih8Th2T642fEHWvVGa6j/QImBU+3xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RwGDqRcBSJhbEOg4a6eWmZxZ/GqlwBFRtanH7VyZF0An3aWI2jnwH9nGh+BUuK7Op
	 ahN8QQEmQuY9D3p86tSmgs4TeTcAQUL2dWsE/pc6rVb4lMvTslKgWKLwPgIBf6Aq1k
	 ku/FAqTLhJTxPUXd9HrI9lAwx/doCFtYcHXh6bj2Uj974IFfgDh+GrjchA4rq7hpQf
	 hIHJcoXguP1T4irH2Myc2EMreCBwrKAizvRM701ekwbJCwCWg/JXTVUfjq03j9ic9d
	 SpW6lYDSqZZT0KU21wWM3cVt+DKIXM4CFcR3A9Q4RrhypdUNzv6f8sQUZ+cFpf0j4P
	 riluOFt6aOfGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2 v2] perf script: Fix missing '+' indicator when
 branch counter reaches upper limit
Reply-To: sashiko@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260429152917.178803-2-thomas.falcon@intel.com>
References: <20260429152917.178803-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 19:58:37 +0000
Message-Id: <20260429195839.29BF7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch incorrectly prints the saturation indicator '+' when b=
ranch counter width is 0.
--

commit 7ec212bf30c80539ef5e37c2e9ff148610e094d5
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf script: Fix missing '+' indicator when branch counter reaches upper li=
mit

This commit restores the missing "+" suffix indicator in perf script which
represents that branch counter events may have been lost due to saturation.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c8ac9f01a36b..f865c8b2f95f 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1287,8 +1287,12 @@ static int ip__fprintf_jump(uint64_t ip, struct br=
anch_entry *en,
>  			if (!verbose) {
>  				for (j =3D 0; j < num; j++)
>  					printed +=3D fprintf(fp, "%s", pos->abbr_name);
> -			} else
> -				printed +=3D fprintf(fp, "%s %d ", pos->name, num);
> +				if (num =3D=3D mask)

Could this incorrectly print the saturation indicator if the branch counter
width is 0?

Since mask is derived via (1L << width) - 1 earlier in the function:

    perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &width);
    mask =3D (1L << width) - 1;

A width of 0 results in a mask of 0. In this scenario, num will also evalua=
te
to 0, making the condition num =3D=3D mask evaluate to true.

Would it be better to verify that mask > 0 before checking for saturation?

> +					printed +=3D fprintf(fp, "+");
> +			} else {
> +				printed +=3D fprintf(fp, "%s %d%s", pos->name,
> +						   num, num =3D=3D mask ? "+ " : " ");

Is a similar check needed here to prevent the same false positive in
verbose mode?

> +			}
>  		}
>  		if (numprinted =3D=3D 0 && !verbose)
>  			printed +=3D fprintf(fp, "-");

In non-verbose mode, a false positive on the mask check introduces a
regression where the output becomes +- since the numprinted =3D=3D 0 condit=
ion
above will also append a "-", contradicting the intention that "-" means no
event occurred.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429152917.1788=
03-1-thomas.falcon@intel.com?part=3D1
