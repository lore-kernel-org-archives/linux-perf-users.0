Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F817303C97
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169907; cv=pass; b=aS4WB430YbhMxlAz8rrmIGYTFdMi+joj2Jn1XgSbFQ28cCmdGdoTTYd6JLFpLCJigh160vU3dRWArsFfZucwqzfHLbuskNvVXU7W0jYhv7b6KXcqYuJRm3EsXrkmlJQ0dWLXeJWqt5YaBmimRLtVnb0L1p3PoTMfGx66I4rCJX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169907; c=relaxed/simple;
	bh=FjX6PU2BP+ECnJIc7+9RJ4ml17iGk5ZNrnS3+lm95u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brcB+U33/y0OgFqf8opV0lQpb/IbmLRU8oPIIg0TUZM2Qi/HheZjbPxbi2shiLk86dqhlOCUv95MKe6I5s9Iy8xrUR43q2Us/8BTCX6TGcF00KeUbhptbB6BEhO9/7K1wjsa8fRaRvy4g5utq3nEdBbKLSWMrxjI20oPhuKfCac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkFoQeIb; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkFoQeIb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso52525ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 19:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784169905; cv=none;
        d=google.com; s=arc-20260327;
        b=FbWT3beVGX2ollY9Vw7rWfx+GA4O9z3UM2vvND1rWObCW48bnCbEqBX4YryVEAer2w
         ECsS7idv2meT4BdSk/sIsHNgyXEvwtcmppkgDPQ1cJ/ncDl/uoiMnz7bJ1Uyqku3jIb0
         6WLijJhXJSAEXCwDCQMeULmEsLJ8thFg83hy1NFEt3fc1xWUp5qrdu7it521EF/hRRCU
         0UzfkOHBFNm8IaLUAliSLd+jtFKYRqItFl2GXLXtkzbxkXxaLlp4JU91k/bO30qZCF8g
         jxwBoCWqZThUb04kVhCRxq7V8WJR28cBwIpAPLBzD/HQ/Gd6I2P3VfdZRWyzyFGfwctl
         e0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w9M4uT3MAj/sBxvep8cpJ1JC82mQWUFhrOmRXPihQxs=;
        fh=A21dyV5An9IQxxY0PiM/VzzDxJYyCCVyg35rvwHRdyg=;
        b=lVbcBzVysXa2QojrZUt0C1/tgASpQMQ0ep6kDPdC37MuysGUzN07fGo0cLRpowvNFY
         TRtPpxcyFo1uTsp2hRlCKNfSKeWqNjgymHdUijQRCRwO2aIPiYf75vwwTpCzoyJoqBnj
         yh5DK9EQfdG2k1A0cHwb0tFrkunv2NY7YN02p4gcPHzIgiUSnJpbLiSJl3IVTPRbxXKP
         PVq7UYMBTgtqg4jTdROcb9Wfiu2+Iw+ZRvV4wpUOBxw11w0qOx3QPs71Lx2tdCJnd5Y5
         WPBhs2pibwRAJ/e5+dxQSYGj1hXrb5olicNzOcbBqKZn/oJ4mDZw3VK+kaYgAi2uYWmi
         54uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784169905; x=1784774705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w9M4uT3MAj/sBxvep8cpJ1JC82mQWUFhrOmRXPihQxs=;
        b=GkFoQeIb8dFAIySxKfT045ud5wKNaeHUIpYcixDyyL0kTz1AfNqAOBs1JoZz8vthAl
         bIQzKcSg5xbUMubuz9v5eewysztTk/8rkR8D4n6BerfpuwiiJ/lXEH5fYy4IJa4fvX+D
         tkuvNJ1HFeMP8POogI0tp+SBa+DIFMtX7cUw0s+ijb+gUct+eEC/pVO5j5kKzRvNFrGi
         JnViWNIaHWrHb78VDQ0ClabBOpADP2FyZWAIyodwtAZZ9U9s22sAeHRWUy22Aj6Y/cpz
         UPRzJRxnckFhHsnsqmC2/pmfb0xwtazLmuLMjjZ9P5bndT7lAtPncIrEtzPaf3ZMsn/I
         ccTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169905; x=1784774705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9M4uT3MAj/sBxvep8cpJ1JC82mQWUFhrOmRXPihQxs=;
        b=je88bi7fV1gtBChQ/ds0MHsPnFOs+ZjcODYmz6jQTLTytRdpT46dkhV+GPFNu5L76+
         A5AzFdApHeL58n6rdC+ztzPTGckrhFjLTJ97zhn5bxUCVxWwl1V5AsHMS6VCHnmUSp5X
         oTG/5l1My62nSerb8oRlNtK7Z0UZSWLtEd6Xd4UiyWgjzw35qC1Laq59bnKz//Ii82wc
         Xc7et0OZBPr8v0mdeskUGItND3FwMgStTiTJ0G4i6ThAOWo4vur07ta7zJzrZiqNP384
         hDlHtGkqooBN57D/LR3TjjeWsUyb4qQ98IsKJWpmRk84Z0Gq6Vd+mhT3IRW7G4MsF6ta
         FYVg==
X-Forwarded-Encrypted: i=1; AHgh+RpCsMM9Q0C5sm6sfmBdN9MDgTv2HKDTYRAkxMrmK8mdXUppUa4GdWgang3NJ1ZIJrFcPHh93Vl0FaUWBYfYF0/d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5L30dwQcQPp5fWbcdLYlJQTsAyzOKrHsSjsnb2CDAHhsT4c8Y
	VW8lvQ2zzV+wv9Fs2RpI8scU+64vetYq8ewZOKYhwz+yrhVSB01h1JkQePeyVfIfIsH8QcpF32Z
	htcZYW8kfdkXH5aJu6U4tx1vCdoOcERjSD31v0pxp
X-Gm-Gg: AfdE7ckSff52odV6JR55ZL3CELTsI6oW6nEa4Oa0s8ryC2plfVPa4WrxtYMo2/kufYh
	Ym0qGuYzxA6HQ3z0daPRnWc6RQM2JPKmcGDPEp2zKg95yhj1Kw5UcXuQ0HvAcD3ubosk0TYy+r9
	BtQ7HUQnkSK2UDkNJG2tjr7fbbdxtE+B0nqHWN47gfxnlIACT0ND93lrOWtKBKNNk98wUNl+Y6e
	9rcs90Jbo3NKkwmPdVmrhStdt0KUZm8yN4e1CDHfiCXFqgyXqIM0BTtDNYFRr0=
X-Received: by 2002:a17:902:ec8f:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2cf1d9d9ae6mr997675ad.1.1784169905101; Wed, 15 Jul 2026
 19:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716004336.2731086-1-namhyung@kernel.org>
In-Reply-To: <20260716004336.2731086-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Jul 2026 19:44:53 -0700
X-Gm-Features: AUfX_mx5ra8fLJGpPa-h2CMVw_HCcIOVxVNEgQ-Fp8nDEFTK8bVr0JeUuTqsYzo
Message-ID: <CAP-5=fU00=N5h5h-SJVhbK6858agvO=Yf_6GgAd99FZTKOtOmg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix a compiler error in util/libbfd.c
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The bfd_boolean type was gone and converted to the standard bool type
> but we have some old code that uses the type.  It caused a failure in
> the build test.
>
>   util/libbfd.c: In function 'slurp_symtab':
>   util/libbfd.c:94:9: error: unknown type name 'bfd_boolean'
>      94 |         bfd_boolean dynamic =3D FALSE;
>         |         ^~~~~~~~~~~
>   util/libbfd.c:94:31: error: 'FALSE' undeclared (first use in this funct=
ion)
>      94 |         bfd_boolean dynamic =3D FALSE;
>         |                               ^~~~~
>   util/libbfd.c:94:31: note: each undeclared identifier is reported only =
once for each function it appears in
>   util/libbfd.c:102:27: error: 'TRUE' undeclared (first use in this funct=
ion)
>     102 |                 dynamic =3D TRUE;
>         |                           ^~~~
>
> Fix it with standard bool type and constants.
>
> Link: https://sourceware.org/pipermail/binutils-cvs/2021-March/056231.htm=
l
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Should we add a fixes tag for backports? It's not clear we can provide
a sensible SHA.

Thanks,
Ian

> ---
>  tools/perf/util/libbfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index c1c12308cc12ffea..d8241c7caac50836 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -91,7 +91,7 @@ static int slurp_symtab(bfd *abfd, struct a2l_data *a2l=
)
>         long storage;
>         long symcount;
>         asymbol **syms;
> -       bfd_boolean dynamic =3D FALSE;
> +       bool dynamic =3D false;
>
>         if ((bfd_get_file_flags(abfd) & HAS_SYMS) =3D=3D 0)
>                 return bfd_error(bfd_get_filename(abfd));
> @@ -99,7 +99,7 @@ static int slurp_symtab(bfd *abfd, struct a2l_data *a2l=
)
>         storage =3D bfd_get_symtab_upper_bound(abfd);
>         if (storage =3D=3D 0L) {
>                 storage =3D bfd_get_dynamic_symtab_upper_bound(abfd);
> -               dynamic =3D TRUE;
> +               dynamic =3D true;
>         }
>         if (storage < 0L)
>                 return bfd_error(bfd_get_filename(abfd));
> --
> 2.55.0.141.g00534a21ce-goog
>
