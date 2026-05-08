Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3B25F994
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276952; cv=none; b=KjdvCkv7dmc3wHfgER0ES9Kil1QCWwN704ThDlXi+V5VfTL83Yf9iAdNLZZewMIVUVJngWSR/qdImwyc7Ihf9ZC+82fskAcx3O7KTrAIlF8sqdK6O+qOuY9JApGKbPM6NCxNG5W7Bq0dTJg5Zlp78AbPg9+WuJz3wDGbOJciew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276952; c=relaxed/simple;
	bh=C3YlD/L+1vzerHYK+QFCC8Z6B6+86PSuaKLWBMNBv0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEgmf8r8XHG3eDL7OgdCpsCav33cHRAsXMk5Mg7TReZYvMiy4aj+EGeK4jn4AXcph23ZoC6vf9+PgnbJlx7T6iewNQsB1HRTkiAAOHvrkVj1f4zjk7E1y1i6gOS2Tpjg+4dYqw5rybPEaALEVFKyviY67FJdGOJ5j40cRjHOwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLhiVN2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLhiVN2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD7AC2BCB0;
	Fri,  8 May 2026 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778276951;
	bh=C3YlD/L+1vzerHYK+QFCC8Z6B6+86PSuaKLWBMNBv0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cLhiVN2e6NxTXiTTsq7hnyDo3pr7mYMhuWC2/jsXecf1GP6k8F1uqI+njjfHeYjZt
	 vpzVWvcSIoVJtz0VPk50OI5R7eA/ILM9sgigWkTnnbbF91g1+kSXCpObdJ/EFVBdd1
	 ohzJ8ambkyOuHDJMuv5N8Ybmr3To4SBKTOkyebaNiYp1vqEft/zBS6JvtEhIB4OPbu
	 ccR2lAZvDv2NCnOah01y5Ng0rdzgGidoETOkB/6tpTqCa0muQFI00KkDP4lCM6Q4gs
	 pNfvXlYcHoaSfn9NWFMrvXKi1Hkbcotj1olHWhIfJALWNWRxayM3OlWT15AUN8CeBD
	 U68CttBBB2gMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] perf aslr: Strip sample registers
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260508082726.2795191-7-irogers@google.com>
References: <20260508082726.2795191-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:49:11 +0000
Message-Id: <20260508214911.ADD7AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Stripping register feature bits from event attributes while retain=
ing the ABI word in the payload permanently misaligns downstream parsers.
- [High] In pipe mode, dynamically clearing register bits from ATTR events =
causes `perf inject` to misinterpret incoming raw SAMPLE events, leading to=
 out-of-bounds reads and silent sample drops.
--

commit 2f6701e115da3f7f7833ab4467a9c51f40012620
Author: Ian Rogers <irogers@google.com>
perf aslr: Strip sample registers

This commit modifies the perf ASLR tool to strip register dump payload words
from sample events instead of dropping the entire sample. It also strips the
corresponding sample bit flags from the event attributes to keep downstream
parsers synchronized.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 09b7f2f8fb850..e5369589a7338 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
> @@ -751,18 +751,13 @@ static int aslr_tool__process_sample(const struct p=
erf_tool *tool, union perf_ev
>  		if (abi !=3D PERF_SAMPLE_REGS_ABI_NONE) {
>  			u64 nr =3D hweight64(evsel->core.attr.sample_regs_user);
> =20
> -			if (nr > max_i - i || nr > max_j - j) {
> +			if (nr > max_i - i) {
>  				ret =3D -EFAULT;
>  				goto out_put;
>  			}
> -			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
>  			i +=3D nr;
> -			j +=3D nr;
> +			out_array[j-1] =3D PERF_SAMPLE_REGS_ABI_NONE;

Since the PERF_SAMPLE_REGS_USER bit is completely cleared from the event's
sample_type bitmask, downstream parsers will not expect an ABI word and will
not advance their read pointer.

Does leaving the 8-byte ABI word in out_array permanently misalign downstre=
am
parsers? It seems they might misinterpret this leftover word as the data for
the next field present in the bitmask sequence, shifting all subsequent sam=
ple
fields.

>  		}

[ ... ]

> @@ -907,6 +897,15 @@ static int aslr_tool__process_attr(const struct perf=
_tool *tool,
>  	if (new_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
>  		new_event->attr.attr.bp_addr =3D 0;  /* Conservatively remove addresse=
s. */
> =20
> +	if (new_event->attr.attr.sample_type & PERF_SAMPLE_REGS_USER) {
> +		new_event->attr.attr.sample_type &=3D ~PERF_SAMPLE_REGS_USER;
> +		new_event->attr.attr.sample_regs_user =3D 0;
> +	}
> +	if (new_event->attr.attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +		new_event->attr.attr.sample_type &=3D ~PERF_SAMPLE_REGS_INTR;
> +		new_event->attr.attr.sample_regs_intr =3D 0;
> +	}
> +

In pipe mode, ATTR events arrive dynamically before SAMPLE events. If we
intercept these ATTR events and strip the register bits from the session's
internal evsel, will aslr_tool__process_sample() still be able to parse
incoming raw SAMPLE events correctly?

Because the bits would be missing from evsel->core.attr.sample_type, it
looks like the parser will skip the register parsing logic and fail to
advance its read pointer over the ABI word and register dump that are actua=
lly
present in the raw input payload. This could cause it to read subsequent
fields from the middle of the register dump.

>  	return delegate->attr(delegate, new_event, pevlist);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508082726.2795=
191-1-irogers@google.com?part=3D6
