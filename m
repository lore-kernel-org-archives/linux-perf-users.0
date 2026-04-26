Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868478F3A
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777179139; cv=none; b=Px8Es2gYlqE0osxmTu5UrWFLZQ4N1yq+xHZlFq75vvSNYbTZos/4vI5NXHGmcCfWCiGkjJUN8BQhntWLW3u3d9tR5G5FNUa3LDezzzhhf/ZykY/KhGqt28GX0t9IwTK0m2SBdQR8iJ6wUovsqUViXCa8ZOIoirSzALZwCE2tBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777179139; c=relaxed/simple;
	bh=f/P1gN5XtAD+iphe1hxL4+Q4YTdlu77wY7a0cZierpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WjpQj94a4cfkjDSM0a3Vjmm9W37/vLcmgKMtc285kmlBdg2HpA6ZcVxDDRullUrZHmu9pqUT59vCthDjei6BvyzmqD7XDYoDeM+ucKF2Yv8Hbl2ET20O1KPMR7TbwAu7jdu7rv0Ztu0VykXvTNobMl44AC47RoghDjIWQ6R0lG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRzfr4U6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRzfr4U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB15C2BCAF;
	Sun, 26 Apr 2026 04:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777179139;
	bh=f/P1gN5XtAD+iphe1hxL4+Q4YTdlu77wY7a0cZierpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lRzfr4U6/uHIpL5wfGKjM+n/GHWL0noelIl07VpkorgE9WnP+MS03nvhxtil0tOJN
	 YziotcPiAzkDa6zwi5qx6UP1w5TsLF0QOHoFh2xduA+LIvj88fOjJcOKDGYu1m13m6
	 bE10tCDLtz94fIOrdH30AbmS7cxdPvUzfoMgW2sxbNQm2xHWrEMQ5wn3ls/jFrwZ9b
	 wGf6hBZXf+BvgYgjoqr6CAofI5wFWvSVF42MKK7XBB+wIyPe+d/gL8I6MD5Ydr3jnk
	 M02wa0nQsS9ucIXgmPIwnCISswH01VykaR4DU4c0blShmMFxhjpu7LBWB/E+YiGeJn
	 22qvVYxseAjIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] tools/perf: Fix the check for parameterized field in
 event term
Reply-To: sashiko@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260426043006.48113-1-atrajeev@linux.ibm.com>
References: <20260426043006.48113-1-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 04:52:18 +0000
Message-Id: <20260426045219.6AB15C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Stack-based buffer overflow in `perf_pmu__for_each_event` due to u=
nchecked `snprintf` truncation underflow.
- [Medium] Meaningful code and commit message mismatch regarding the substr=
ing check.
--

commit d8e4b8dc1bd869d8438cc91880ce9791dc581a82
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Fix the check for parameterized field in event term

This commit fixes an issue where the check for parameterized fields in
event terms was incorrect, causing them not to show in "perf list". It
also updates buffer sizing logic to use scnprintf instead of snprintf to
prevent out-of-bounds writes.

> Fix this check to use:
>
> if (str_ends_with(alias->terms, "=3D?")) {

This isn't a bug, but the commit message states it is using
str_ends_with(), while the implemented code actually uses
!strstr(alias->terms, "=3D?").

The code implementation appears correct since parameterized terms might not
be at the very end of the string, but the commit message does not match
the code.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..fad7ef4c8e5d 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
[ ... ]
> @@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
>  		pr_err("Failure to parse '%s' terms '%s': %d\n",
>  			alias->name, alias->terms, ret);
>  		parse_events_terms__exit(&terms);
> -		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->na=
me);
> +		scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->n=
ame);
>  		return buf;
>  	}
> -	used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, al=
ias->name);
> +	used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, a=
lias->name);
> =20
>  	list_for_each_entry(term, &terms.terms, list) {
> +		const char *name =3D term->config;
> +
> +		if (!name)
> +			name =3D parse_events__term_type_str(term->type_term);
>  		if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> -			used +=3D snprintf(buf + used, sub_non_neg(len, used),
> -					",%s=3D%s", term->config,
> +			used +=3D scnprintf(buf + used, sub_non_neg(len, used),
> +					",%s=3D%s", name,
>  					term->val.str);
>  	}

The switch to scnprintf() here prevents buffer overflow within
format_alias(), but does the immediate caller perf_pmu__for_each_event()
also need this fix?

Looking at tools/perf/util/pmu.c:perf_pmu__for_each_event():

        char buf[1024];
        ...
        info.name =3D format_alias(buf, sizeof(buf), pmu, event, ...);
        buf_used =3D strlen(buf) + 1;
        ...
        if (strlen(event->unit) || event->scale !=3D 1.0) {
                info.scale_unit =3D buf + buf_used;
                buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_us=
ed,
                                "%G%s", event->scale, event->unit) + 1;
        }

If snprintf truncates the string, it returns the number of characters it
would have written. This causes buf_used to exceed sizeof(buf).

The subsequent size calculation sizeof(buf) - buf_used would then underflow
to a massive unsigned value, leading to a stack buffer overflow on the
next write.

Should the snprintf calls in perf_pmu__for_each_event() also be converted
to scnprintf to prevent stack corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426043006.4811=
3-1-atrajeev@linux.ibm.com?part=3D1
