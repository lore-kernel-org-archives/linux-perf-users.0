Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20412364043
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412198; cv=none; b=b7UEy6FgWHB9yB4B9vXKOdaGs4wxviNFHM8MQfo0eI6h4zghJIxEtn3m59ZyzNHKkT5UpC9Z5Il304NTMC9KBAjg0a1XO4SRQCqI9HO0slpvb2QXIU8p0KNL3tgwSJaMMQbVzeO2EZ+Y9GToYfk/wj8OxWcRf6RT8FEjzKBn2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412198; c=relaxed/simple;
	bh=DuJ3l8qz/BKMZ0X1U4bGFZwaB15B/HOKDrGeWjXxe9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAIYK5eW6Hd6yraZ/Hx/lLp/B/GsWn7O05ViuqBg0STbYyCBpZGRApusHGSzn05oeqDwG6oDDZ9T+sgd/BrXxvcX+odidxI34ae+Ktg9eziZUsKNQKXFDhyzezsTN8dV8SrhVvOXhYT4c4gz+7oLUL0kDyAIdLcvq6Oo2k3KUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3haXcON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3haXcON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497781F00893;
	Tue,  2 Jun 2026 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412195;
	bh=GdJwKEJ9HlVfoRQkTlkS5k6mGtoeQy0dN7JSGqY9e2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3haXcONknuAvjtoXu3xSI7QMC/7/maQeIMP3pQIUwtOyY5V6A57XZahB9bZbGjV2
	 0DOEJ9poyzQciJM9yo7TwN9ViPQ2SJqAgtBYNjmkZeKZnWVDhda/UK56a4x+HFpVlu
	 qC6vndO1zYlA+XiZwiG0Fil5oxRQWp5xXDhs5+N/XCSSG0tmaAceruKmQqw2NmeVPx
	 buS59GwE5HtEDoAsOrtWLaS5grrZXCurSsRUpFgihZ+gqrMQ5CoX02xgdLIArmNTMP
	 iaaukicX+jc0/InHHEUNtsBMmwLJFuKXKPSnKHG8PHFYU7tSSoKU3h9TW5IsCu3Kbu
	 7zL610EW8jrSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/23] tools: lib: thermal: Initialize CFLAGS before
 including Makefile.include
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-3-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-3-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:56:34 +0000
Message-Id: <20260602145635.497781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the fix for the =
CFLAGS initialization order completely missed `tools/lib/bpf/Makefile`. Thi=
s leaves it vulnerable to the `EXTRA_CFLAGS` expansion introduced later in =
the series.
--

commit d569bb22d825610f92ca0c5003854cd0736f3058
Author: Leo Yan <leo.yan@arm.com>

tools: lib: thermal: Initialize CFLAGS before including Makefile.include

This commit prepares the thermal lib Makefile for future changes to
tools/scripts/Makefile.include that may expand EXTRA_CFLAGS. It moves
the CFLAGS initialization before the include to ensure default compiler
options like -g and -Wall are not silently dropped.

> diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
> index 09d8f4ba6a0ab..b55fa42cefa47 100644
> --- a/tools/lib/thermal/Makefile
> +++ b/tools/lib/thermal/Makefile
> @@ -23,6 +23,14 @@ INSTALL =3D install
>  DESTDIR ?=3D
>  DESTDIR_SQ =3D '$(subst ','\'',$(DESTDIR))'
> =20
> +# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
> +# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
> +ifdef EXTRA_CFLAGS
> +  CFLAGS :=3D
> +else
> +  CFLAGS :=3D -g -Wall
> +endif

[Severity: High]
This is a pre-existing issue, but it looks like this same vulnerable CFLAGS=
=20
initialization order exists in tools/lib/bpf/Makefile.

Since a later patch in this series unconditionally populates EXTRA_CFLAGS=20
via Makefile.include, does this mean libbpf will skip its default=20
initialization and build without optimizations?

tools/lib/bpf/Makefile:
    ...
    include $(srctree)/tools/scripts/Makefile.include
    ...
    ifdef EXTRA_CFLAGS
      CFLAGS :=3D $(EXTRA_CFLAGS)
    else
      CFLAGS :=3D -g -O2
    endif

Should tools/lib/bpf/Makefile also be updated in this series to prevent=20
a performance regression in libbpf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D3
