Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57B40E8D8
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543232; cv=pass; b=mNT+NKkZDEAEvWpQktOTo1Ci5mgntmLA90/M/1OpxL+6C5OkJ+qLyf2Rsjj1F16qhaXCb8aAi52jZJGrZ8mI41+t+PagBgduLAiT4iEU/AICAa79uiZ5xYcNZFUivWy0lua15v536wxDEt5B9vOBAciZltGXxBoE/WqykriUt6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543232; c=relaxed/simple;
	bh=lbHzclepDHFSccFp2GdZ3FM9JzjpfFUtMESjuZXrilU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR4jRRysJ3ByHet1TPPMwOwJoncms6zAsvgZW5yraSyPSyjnKYCeBkxIUIPyEIill20P9wtYVCdOhUicB24sie9qdwRyOnAa4e5c1mm9/mumLTsMxHrqqOgRQbQ+tfokboR/ESIiJwrfA5ZlEGJY3mo6peTsC1pyUBqAXyIGK48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaLVplJ7; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaLVplJ7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf22c18ad3so2705ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543231; cv=none;
        d=google.com; s=arc-20240605;
        b=ISTQFD5gpHDKswyYMowWzPCEW7agEvxVLEn2BBxzIMrAqwdlYfFOHwuMSakMG0oZ05
         iS8JfN+2D1ledeR/0MwwbVIsNPJUrDRG/nNNzGTp7CykUbYzjV4PJxbjma7MquPXkH2G
         BWnjc2v4SZmVyrFQ9Mf4MskfHBKKZrMf1I4jhMiEsUt37lhxiCHnJC1xwIgkO2rWe0re
         cdLhRXtuRgqqQpI9MKPljS1SgYCH0NWwu1Kz+SOr4Ft59EGjdH69KQy9McpaT0V7ZCNq
         wMcLBhksV/fQvx41kslhm4Zucqo99a6oWP6wwVZ+6UXJwflBDQtMT3n2trnIpnWpllWB
         1pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LWA+qZ8vXjZNdtbc/VmELDy/vXC0fmJYLjkMetTJU2Q=;
        fh=r4g6V9Ci4xmki/HGxW+B4/zRII7+SGZHHbVBh+Rt7Io=;
        b=GDM5ifFhh3LYSkWxEBNxGZ+IQ5gQjc8nOv3SE60fMmDhAuGuv03QV9kkqBWosdeTMJ
         HxJjQ07CP/IzppROAc2up7E7E0jmLuwsw0TZQTKi445aqoip1BbfhbM5oHmm2LXpkE68
         WbE6oLFvI6ta2Rv3mzmbwn5R+KvBFbhrM0vTvgwOKquXLH53hZqG6kuiEABHE5X0De/e
         6QqVX+rMVpxGvMj+6BZFv6wO35kb9THX8/pAqCODjLZhJqfXRh/RCmLZQofxDLisWiDT
         aDoWFI4XsoZLK0lLc+yllRKdjgthjF750BXIE8UISVc5bwrhjZJXAt72xAHO32FZDGz8
         FsTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543231; x=1782148031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWA+qZ8vXjZNdtbc/VmELDy/vXC0fmJYLjkMetTJU2Q=;
        b=jaLVplJ7zr2mb8MpofIUaVBfFjgEV7BHzYsa5u7/ausbAmWbRAQEKwfK6+IJcitZhB
         nE7vEzQo5Zr7nE22pBqq6I786ybFSixgWsU8bV12RCKDeBS3g2DipCLUs0h2eOElkwzj
         LqVGmUrp3kMJOybo4dxaDPX0Ax8EjJGGLzBZtqo/z2u6nI9c9qy68laTT+n50KhXbr/Y
         WgAEmAP3laQL2JwFSxfNTMoxnKGjs1gQBS0N2oagpEfUuhs1xxHzhKGq9PrEqnbvwe1j
         z12qV328dCf9OMOIMzuiejY6WWioq7NPscmInsGvzQKuCAFoXROYBAXa8VsJY7eQpQ0N
         WcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543231; x=1782148031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWA+qZ8vXjZNdtbc/VmELDy/vXC0fmJYLjkMetTJU2Q=;
        b=N2Lzlkj+pjT75d2Oks/yIRERU6JeLLvBf+Qele3umLrhjLcLfBWTJtrkwjy89HSS12
         dBhWx/lapJiHGP2psVp1Cr1g11esb8uD0FUmZzVUeW5watA20CGfmk94q+MUpHszNcUa
         fCD10J/1Rr5auV4tsz0whP8S8px7YMUL91xH1ECPgtPDSmLDYRQU5eijfhcM59DOSWpW
         PFFl2aIg3Dgra17jVCt5ZAd5qx/7rlBINTVBn0SLNR+cLVT+uediekdLv6Z+Q7zZApvB
         a0cSKD3Zb2WtZTJ9IH5D0L7NvJ23vWaZ10VFlxcXqpcM9U2aovHex+7FEFIwAPhf8V3p
         1NKQ==
X-Forwarded-Encrypted: i=1; AFNElJ95363+zQxmpTPhynpT+CgXfLB9npiPnekBvbMAf9Gqc/EYXZRvywBt74BiRu4P7aoBlVJD+3VQ5Enbl+qa9xKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyxcjbdU7zsMGfNI4sUGlFo+hyrlXqqA3j3tICgdXmP0umjHI
	MDPT96HD1UDrdbDS+d9/F6wXr9qPVVW0FGIy0l3Npz4dr+8xUFQKMHxjgNXz5CJttxAtlMcjlHW
	4EFK7s+DjNjBXwiagSFMsff+93f1n58VaZDhiybF+
X-Gm-Gg: Acq92OGqdEgquBsyly2kfTr4GYq5xhyoRZIgDvkUWebxQtfTRlhbuDmwVAvbzG2rkSq
	WmZXrS/yRqwPbyKpQlHxA94tuUUrYqQyhSG7qepAxNozwKov785+CCl9keLt3Cotr2A0Be3cG6N
	wJCk28aqqGfbCAzx3XD/IMyC2aLHyBQANkXCgEzrYHl4KCc6ht2SqL1F/MSzAXMWJaCp9xDwI80
	y94XTBgmP4J25P4zFmad8ZDecHF39ehPU9E0ZBt05CigpORR5CsbI6E+w2SahjzLyq36mhOwndy
	RCC+Mlrvisp/8rIJbFn3m5tbEmYK5+cddgghZk4EsJx3Qeo=
X-Received: by 2002:a17:903:37c7:b0:2c4:3ba1:9b26 with SMTP id
 d9443c01a7336-2c69a151fd1mr90105ad.0.1781543230297; Mon, 15 Jun 2026 10:07:10
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-2-acme@kernel.org>
In-Reply-To: <20260612222413.40791-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:06:56 -0700
X-Gm-Features: AVVi8CeajnhwnEv6I-KMZQ6ZxqNKmE5OI1ShYbQp1GUOpSCZ4PdX1YFwvPh_2zE
Message-ID: <CAP-5=fVSAH2ApNnamYW1KD3m8+fzURHkCTUiZsuNR_dNCVUkEA@mail.gmail.com>
Subject: Re: [PATCH 01/13] perf symbols: Fix bswap copy-paste error for 32-bit
 ELF p_filesz
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> filename__read_build_id() byte-swaps 32-bit ELF program headers on
> cross-endian files, but line 178 passes p_offset to bswap_32() instead
> of p_filesz:
>
>   hdrs.phdr32[i].p_filesz =3D bswap_32(hdrs.phdr32[i].p_offset);
>
> This clobbers p_filesz with the already-swapped p_offset value.  The
> 64-bit path on line 182 is correct and swaps p_filesz from p_filesz.
>
> The consequence is that the PT_NOTE segment read uses the wrong size,
> which can cause either a short read (missing the build-id) or an
> oversized read (reading past the segment into adjacent data).
>
> Fix by swapping the correct field.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: fef8f648bb47726d ("perf symbol: Fix use-after-free in filename__re=
ad_build_id")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol-minimal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index 091071d06416e290..f4b0a711a62cf3de 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -175,7 +175,7 @@ int filename__read_build_id(const char *filename, str=
uct build_id *bid)
>                         if (elf32) {
>                                 hdrs.phdr32[i].p_type =3D bswap_32(hdrs.p=
hdr32[i].p_type);
>                                 hdrs.phdr32[i].p_offset =3D bswap_32(hdrs=
.phdr32[i].p_offset);
> -                               hdrs.phdr32[i].p_filesz =3D bswap_32(hdrs=
.phdr32[i].p_offset);
> +                               hdrs.phdr32[i].p_filesz =3D bswap_32(hdrs=
.phdr32[i].p_filesz);
>                         } else {
>                                 hdrs.phdr64[i].p_type =3D bswap_32(hdrs.p=
hdr64[i].p_type);
>                                 hdrs.phdr64[i].p_offset =3D bswap_64(hdrs=
.phdr64[i].p_offset);
> --
> 2.54.0
>
