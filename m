Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C0539FCD7
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211949; cv=none; b=pT7+CSZzkzFEXQybEabTN0Dt3wU5M/Qgb92WpRCSbc4xt6Uxy3a3E8TSPCjIkeU31CKKBRysUxrWqaM1yQslZQmHrYZQOC6UFxR8E5qokbHWh5ktGVGMm6awtfaPvUAzg9TdYYG0aqM/ifssUP9DBaDtdfzx6vj3svTWotVkdXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211949; c=relaxed/simple;
	bh=ya6YBHtZJ9p47xV2BxlhRegsn079nmHb4XMuK/PfKNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJij8YQ2eGoGsGaj9ZHHamn17QXoYM9RB/rutKa4RrH/otiZA7O1v19YVleKe2Ccms5PbsJVOTveEq5x7HWgdMaqTCvg2lz3DtFE8Bf31iK3JjSLZzlZ8dQDyXZkwFSjglBQeAu2Iz3xL51Mb06B22WsyyPssESw1ONddBA2dZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYrX/uZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYrX/uZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA86E1F00A3D;
	Mon, 31 Aug 2026 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211948;
	bh=HXFOgwP4Osswx+kaWgk2wVsPgZNnFHr9whhgegsSZjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYrX/uZBcYIdw5t76udiw6V7g5EHmo1MmDQmwaSiVF8inMYjxKuEEvh6ocG2N8jJ6
	 d7fbqEWuGhWd9hU8uEfla6AjU9ux16vQBRw+bL4lLcUIPjl6QtjuiBPtOEXwgGI4KH
	 +qrhNaZvQESm1Y006wnJEUDE8z5V/jz8k5X4iVA+/bkSpaaNRWIZFIES75sVDRKmBx
	 /n0GhfwoEsdT3FWJXGqa1KR9JF7yCSHDAWQFlP5pO0HQdERIdeVfCfGMzCf6KMxtK/
	 KpkpuVAx44UDxbaH5cYgsGS9x536g+b0m5p67dfsF7tkHUONOErcQ1pE1t9U0O9X96
	 raJlA7IZFCTmg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 17/19] ptwrite uprobes / perf tools probe: Add support
 of ptwrite probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-18-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-18-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:32:27 +0000
Message-Id: <20260831213227.CA86E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error code from `strbuf_addf` is silently overwritten, hidin=
g memory allocation or formatting failures.
--

commit 1e80616b3ae889174ea132bb4a1470dd0a9429ba
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes / perf tools probe: Add support of ptwrite probes

This commit adds a --ptwrite option to perf probe to enable trap-free ptwri=
te
uprobes. These probes write their values into the Intel PT trace stream
instead of entering the kernel.

> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
[ ... ]
> @@ -2260,9 +2262,11 @@ char *synthesize_probe_trace_command(struct probe_=
trace_event *tev)
>  	if (strbuf_init(&buf, 32) < 0)
>  		return NULL;
> =20
> -	if (strbuf_addf(&buf, "%c:%s/%s ", tp->retprobe ? 'r' : 'p',
> -			tev->group, tev->event) < 0)
> -		goto error;
> +	if (tev->ptwrite)
> +		err =3D strbuf_addf(&buf, "ptw:%s/%s ", tev->group, tev->event);
> +	else
> +		err =3D strbuf_addf(&buf, "%c:%s/%s ", tp->retprobe ? 'r' : 'p',
> +				  tev->group, tev->event);
> =20
>  	if (tev->uprobes)
>  		err =3D synthesize_uprobe_trace_def(tp, &buf);

[Severity: Medium]
Does this code silently overwrite the error code from strbuf_addf()?

It appears that if memory allocation fails inside the first strbuf_addf(),
the function continues without checking err. The negative error code is
then overwritten by the return value of the subsequent
synthesize_uprobe_trace_def() or synthesize_kprobe_trace_def() call.

Could this lead to a truncated or malformed trace command being synthesized
and sent to the kernel?

> @@ -2274,7 +2278,6 @@ char *synthesize_probe_trace_command(struct probe_t=
race_event *tev)
> =20
>  	if (err >=3D 0)
>  		ret =3D strbuf_detach(&buf, NULL);
> -error:
>  	strbuf_release(&buf);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D17
