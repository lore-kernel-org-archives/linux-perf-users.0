Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C913AEF4C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551284; cv=pass; b=h/+0jzp8iA7x1nKh9i1/vu4el0j0DnCdJfsR8kjIDlL+y/Npve8sTK6cp1kEby06+p0coI21xuG15dwLplODO9mO46cFsGu9RN6Ve4XoCrhob69RxTSKlYLq6CkSJrvqIJuQj6DkjL1mTBqYoU1DPI5vO6xciMKGZJfRw/fEH0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551284; c=relaxed/simple;
	bh=Gqd5L8gDohSJp5Vd7yaYyZr5rq08Y0cfupDOewLAH1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU72ikWGsk1i8SgIT8MbbtxtvWjdRokIo49l2wq7MzQNsdiXKHPjyx37DkDOgsIwmkZ9flZiRMwcEfF8sKfGvpiGlSUbsQ1FoPnvbTvN5vvxPhvE296I7sp8VutBzux20ozDhYzogDOEuWqeC4L/a0CZM5omwck/x0XuQ+BJrrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mr8Nu8nY; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mr8Nu8nY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b1a48855so12405ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 12:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781551282; cv=none;
        d=google.com; s=arc-20240605;
        b=G7wSHw0Wf2XKOFCP4aB0HDbw503rL0++qpNvyFE8dRRYgsa8NoiyK2qHfPt+lrPwjx
         mG0r+xVlhVD2wohVALBlZt/MU3dmCbdO41b4TIKl3/o5Q4Pdz1DJ2toqInU4CxvHuVbS
         Ewr8nghK4LUsFKAMNlqHaX81FkGd4lPakn/fu8BPlQZNEP2R2YUFLO3ML63HHSMwQ/se
         u2XPti/y1BH8CCndgGbeynLHb5RCG/Ue+SXG3bzzssl0zvrZbUyAIPR6JKxJrgvhktjf
         WfXhSArDvdDusipRp7R0SE9+kBBGL/lpxLHTyVccPxt4no7Yfo78egixCW+BXzuU27Eo
         3ysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbiWFe400pAoemBYa6Fx6rmYKwhjaRTCOKJDbn2kr78=;
        fh=cO1W5lS+ML3jFPjkhMtkHXg4Xqp5OT5dokuLAwXSmk4=;
        b=DnUeSX+aw0syCPdZ9/nAS8SA8rCFmun2Hle6mYbmYRRcl3qTj0pDWj9SCAw7X6dvvG
         JrkTbgwsVlG0o7bm8JAtLoeW1b9h0h82hkr+dUFMAlVWqgRHhyfldWnCIGNA100g2Pes
         JX6m22cH47l9pJ85ji6iVL1dGFLW8CmV/PbsP7t/ubA9mewvAqqrxybuhUK/M1X3e9UM
         Gf4BmKdS3+kQYRmXd9iRPg8fquwhKFDTzRzHa72+J/hr70D8sLRjHfbVuY/UmpNOGMxA
         R2uTuV7uxmmRXmzmNj4Ydpx/2fHU9ZrenNxLdxGt8mSsSz3E8mGgHlv1lMcn4I4ijQx1
         XdOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781551282; x=1782156082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbiWFe400pAoemBYa6Fx6rmYKwhjaRTCOKJDbn2kr78=;
        b=Mr8Nu8nYdVNBN6udsmudO5f1klyzHKdW553boK510ekqxFGMMbhWZI7QtJerCDpfQD
         IopJ7vsha56T+/HS9QUxvT0QoyzMY1G5rqO956RY9jIpBnZYD+EvgIR25793zRLrUufw
         xaBLtrLtUAKIMHggRL6xJh6PCEXlUGi7lMKb42A5w0/y2nPWoK3cn2NRu1gbO2+gO+YA
         A26MTQEbJDRt9XVVTKpxoIy5Ef16HCywsxUBKeAtmTLelPaq7hDmcsziOYxWoPXpl5WR
         BjY0wFvOr7C7FtE3NcLtwU/1ZDzoqye54ovuxqeVqODZPPz+2XrJ8Nm3qP3r4LqLUkkq
         1ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551282; x=1782156082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbiWFe400pAoemBYa6Fx6rmYKwhjaRTCOKJDbn2kr78=;
        b=TwUYWXJOFtKNuUVSM7HrBPTr/OZ8HChYZ06uXAeK4pg+tcuhElGkVbX+d/66dLU4oW
         Tw23zDhZk1k7R6wVy+jzlzwGbse/FLrvrnGrFUIRun/4L1ggocJ6PSOJC+MerO/8VeSw
         a0pg5H0bt7HFg+IjzX7+QPbgATVS2hG5Di8hmOeMHkwovKZbaR7AiHMW2fYTh6J7Iwoz
         WqbcET1+PXmPtsb8pj4qfOiscuCPt2Qlki7OzDZM+3d9EIhyEoR/GalQ6aeYL90wdpyJ
         I3fSunNSFfE59uZYHvZvFnRNaBxBZhB4FPv8Cx00yH/bboS7VYY9msYwPFs1gOv0iS67
         WVfA==
X-Gm-Message-State: AOJu0YzFzuyasggJqX039NxXtHI2mlupKyX12BhxflD/GnqveO6s0zGD
	QfBdB6O9adW7e79FqO6IeJno7MAiC7+Y+SUd5fIrl4RqqGPsJ5lO9H0B8bkMytdEww5B6P/388y
	0hEEHw7YCbYRx/FkS4PzyJ1rCtrUj39mffNFBr45S
X-Gm-Gg: Acq92OEe/LdONjMQQkNW7C5maQO303+I9ZLt2XuY56jGHH7eWwCWu6s8NRf+d0AWXs5
	QqQwiZBk7FNqrqOguZxbKmf9RgEtrlrmGpHrxOcNpOKQ9LVnyKUcZeB25zI0cUQ0/8KkBrOWmfk
	lkYSQzSMq/DRz5ThYDNK4GskG3zzwSYoRaaXfEnU/W18L+JhJVtkIGHaqaadoroMU6nLmDDipmJ
	1lWxIcQStBKLhkwZwkoI+Y/U8OgAZ+nUp4PZmd5t3iEZIs+5ApEMUzexY3Iogiv0PNRGP5eRQZC
	RAJ91WwoDG58+1GlR4hSiJRbkPi6ivLWJY9D
X-Received: by 2002:a17:902:d4d0:b0:2c1:ee6e:be21 with SMTP id
 d9443c01a7336-2c69a43961fmr295575ad.31.1781551281430; Mon, 15 Jun 2026
 12:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612192847.1221091-1-thomas.falcon@intel.com>
In-Reply-To: <20260612192847.1221091-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 12:21:10 -0700
X-Gm-Features: AVVi8Cca0dYZQnUU5Pfi9rTS0IzPxnNmSSCFNH_dlr3TpZqRXQcA1AORdYJeBO4
Message-ID: <CAP-5=fXicnkOSeRCgZu2OXNvOJYVM9qOQdrUStOomnoT2powkA@mail.gmail.com>
Subject: Re: [PATCH] perf: Document recent additions to the perf.data file header
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 12:28=E2=80=AFPM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> Add documentation for recently added HEADER_E_MACHINE and
> HEADER_CLN_SIZE data to the perf.data file. Also fix a typo
> at the end of the header section.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  .../perf/Documentation/perf.data-file-format.txt | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/p=
erf/Documentation/perf.data-file-format.txt
> index 0e4d0ecc9e12..b90cba9168f8 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -464,7 +464,21 @@ struct cpu_domain_info {
>         struct domain_info domains[];
>  };
>
> -       other bits are reserved and should ignored for now
> +       HEADER_E_MACHINE =3D 33,
> +
> +ELF machine and flags data. e_machine is expanded from 16 to 32 bits
> +for alignment. Format:
> +
> +       u32 e_machine;
> +       u32 e_flags;

Thanks Thomas! I found that endianness was missing from the
e_machine/e_flags for capstone disassembly support. Part of me thinks
the unused 16-bits of the e_machine could carry information like this.
That said, we also have endianness information via the perf.data magic
value. Anyway:

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

> +
> +       HEADER_CLN_SIZE =3D 34,
> +
> +The size of the cacheline in bytes. Format:
> +
> +       unsigned int cln_size;
> +
> +       other bits are reserved and should be ignored for now
>         HEADER_FEAT_BITS        =3D 256,
>
>  Attributes
> --
> 2.43.0
>
