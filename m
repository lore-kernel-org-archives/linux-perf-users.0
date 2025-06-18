Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DC21A455
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277676; cv=none; b=pUuQ2GgpGm2kkggzFn4/S9bEx1NGkr7wTUuWIszlLV7L67HQrRdtiG1qsqxdnRDk8dt0dlxTKNuGzh3UYyzUZX7Gdnod1H9TCI+qUDabsZX4RLFeATfRyxxEtR58mSTq6XyXTwdCzsevh6+Af1W5m00EJNHCO7fuEg18O2yTCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277676; c=relaxed/simple;
	bh=Ii4He89YY3opDskRFAq9rL0IyOgwNxjFOSPH0hx9nAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGmWvJhZijbNrljpSz/iYCpNbyuVfaNS7IyF5he7if0W1e1AmHnN16RmSB7UQ7KJtSi/sX1MjzMmWY0D2i3cyel6Eh8Z3Ftgn7muwSi90tjfg5rTeq2Su6nJD7Dk9RC/YLN32ny35cH/LAk2i1+WyWVDVZZE5QCJablaOrFzZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+ZgOLgd; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+ZgOLgd"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so6015ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 13:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750277674; x=1750882474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baK9Gsm4MNKfiN0r8kRfhIc4uLs8B4puo9CE3miwC8w=;
        b=X+ZgOLgdVf8LXFjLghB2/yDGdF/H72cBKEDFp1CU8XmXHO1ugMAHTuLQg6hV3EU2eQ
         3GR7G5r6V4QtXSVlAYfUK1i8B6B0Twe+WmBeyO+/nPon2hNhUHbmjimoZUcs1CIt/CQQ
         TkmEFbHWOBOVoJIDbxuDrzmAzvYibni62zIZIeUDTIA5FyGhX3CG0t8iTCMOyLTTVHuo
         qmTooh0JOIs7Tf7E07tKrCrFs9+JEi0btC2TIHRMq8DxSyXuSgl2hvzHMF6ceQQLHRiF
         LBM0HHeh6q4kfZ/05bvBPp+oUfvQGZWJh99j3hnKNf/d9l73Icwr/qkoPNJV1h4uEfOg
         KTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277674; x=1750882474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baK9Gsm4MNKfiN0r8kRfhIc4uLs8B4puo9CE3miwC8w=;
        b=YKrNgoxMffZi6pBc7kd9g3ASM6D9jsCEh1zEMy/S/xse9etAz16wXVxyjPlPyf4oKH
         GfirfcHK7OH1gGOSHS9a63Aa4DYW+0qpnadkPvrF8knB872esQ6pYzqi1A9IxhhNHRc5
         VGGezKQVMFEKs5qe9ljme1U1pH7MP/SoVKnggT47ZIiV4dFVlOAYJLKfkvDL4jwTIS48
         0doIjJP/MbtyKPH+HcJ+kFAQ7SOXrk7fSdqb5b/mFOekxins7DrUyizxgcGoVO1lzclU
         O0zFBEUNb8XQOQIEKjE0XTvXKX/B5CSu/XA1ppD3i7+vB7h+0k1aCWgh9dJLmWgzYAaL
         RXiA==
X-Forwarded-Encrypted: i=1; AJvYcCXCiJkOX30mhDtlh+Y5wrC3fF/nLwOyMLuDImXxzInjNkz06tj22a6lUM7smBQ6aibNNgewsUDUkKjzfjkO0JCp@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjZBihM2N89lbVWzlt6nQxL8ZDjJt6j1iAToUTfYA7sd66Wha
	7Mg6jaZOe1LSsz3jSeScMN3/LVG7O4NVAL9t/H6BaCxmhgZO5g9gFcCJ4skpdZ/FM9eVjUTxONr
	5d+pASFWd7tL0uAol2GAQCy+/kkx6sr3tbKDVGYfn
X-Gm-Gg: ASbGnctzw8fm2+tEydRFuOORgRZfKPXbJM6zxtiVOCxSRQe/U5ctrPlRVNA/iLsa+zm
	yKNvlbel/1jbE0lw7NvFMU/EANASKkrWhos/N1/YqXRvPIRR9pyalPA3IvnVOKCiy0946f5NfLJ
	4Gx3XsSAF9d7kJNIapcl4/aO4SHS9b2/sh6xBciEz1JZAmkgAXEiSAiz2Gca2YEcj+61oBd8hI
X-Google-Smtp-Source: AGHT+IHKK0++eaJilM8rf5aNc+eJJZ/qA0gTHaH37/E8oI5bLXNavWh44KaWMPRhHRL2uN48LvYkH5mDxqUbTp1wEww=
X-Received: by 2002:a05:6e02:1aa3:b0:3db:854b:9f52 with SMTP id
 e9e14a558f8ab-3de30a9a21amr798835ab.7.1750277673699; Wed, 18 Jun 2025
 13:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
In-Reply-To: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Jun 2025 13:14:22 -0700
X-Gm-Features: AX0GCFtIxALuuiINu3lESm4gT6cC9jiAaUqbCpvVA0a-vl9RoiCCqJh-Mc9x5B8
Message-ID: <CAP-5=fW4VSEQm2AG+znK854H6rUz6i60NKjJCybJ+6N5fEZFQA@mail.gmail.com>
Subject: Re: [PATCH] perf/headers: Document PERF_PMU_CAP capability flags
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, kernel@collabora.com, 
	Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:09=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Over the years, capability flags for perf PMUs were introduced in a
> piecemeal fashion whenever a new driver needed to signal to the perf
> core some limitation or special feature.
>
> Since one more undocumented flag that can have its meaning inferred from
> the commit message and implementation never seems that bad, it's
> understandable that this resulted in a total of 11 undocumented
> capability flags, which authors of new perf PMU drivers are expected to
> set correctly for their particular device.
>
> Since I am in the process of becoming such an author of a new perf
> driver, it feels proper to pay it forward by documenting all
> PERF_PMU_CAP_ constants, so that no future person has to go through an
> hour or two of git blame + reading perf core code to figure out which
> capability flags are right for them.
>
> Add comments in kernel-doc format that describes each flag. This follows
> the somewhat verbose "Object-like macro documentation" format, and can
> be verified with
>
>         ./scripts/kernel-doc -v -none include/linux/perf_event.h
>
> The current in-tree kernel documentation does not include a page on the
> perf subsystem, but once it does, these comments should render as proper
> documentation annotation. Until then, they'll also be quite useful for
> anyone looking at the header file.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Thanks for taking the effort to do this!

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> There may be more perf documentation patches in the future, but right
> now I'm focused on getting a minimally viable driver for the hardware
> I'm working on going. Documenting these seemed to have a fairly good
> effort-to-future-payoff ratio though.
>
> I Cc'd Corbet in case he has any input on the verbosity of the
> kernel-doc syntax here, maybe I'm missing something and all of these
> could be in a single /* comment */, but as it is in this patch doesn't
> seem too awful to me either.
> ---
>  include/linux/perf_event.h | 74 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ec9d96025683958e909bb2463439dc69634f4ceb..7d749fd5225be12543df6e475=
277563bf16c05b1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -294,16 +294,90 @@ struct perf_event_pmu_context;
>  /**
>   * pmu::capabilities flags
>   */
> +
> +/**
> + * define PERF_PMU_CAP_NO_INTERRUPT - \
> + *    PMU is incapable of generating hardware interrupts
> + */
>  #define PERF_PMU_CAP_NO_INTERRUPT      0x0001
> +/**
> + * define PERF_PMU_CAP_NO_NMI - \
> + *    PMU is guaranteed to not generate non-maskable interrupts
> + */
>  #define PERF_PMU_CAP_NO_NMI            0x0002
> +/**
> + * define PERF_PMU_CAP_AUX_NO_SG - \
> + *    PMU does not support using scatter-gather as the output
> + *
> + * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not suppo=
rt
> + * scatter-gather for its output buffer, and needs a larger contiguous b=
uffer
> + * to output to.
> + */
>  #define PERF_PMU_CAP_AUX_NO_SG         0x0004
> +/**
> + * define PERF_PMU_CAP_EXTENDED_REGS - \
> + *    PMU is capable of sampling extended registers
> + *
> + * Some architectures have a concept of extended registers, e.g. XMM0 on=
 x86
> + * or VG on arm64. If the PMU is capable of sampling these registers, th=
en the
> + * flag PERF_PMU_CAP_EXTENDED_REGS should be set.
> + */
>  #define PERF_PMU_CAP_EXTENDED_REGS     0x0008
> +/**
> + * define PERF_PMU_CAP_EXCLUSIVE - \
> + *    PMU can only have one scheduled event at a time
> + *
> + * Certain PMU hardware cannot track several events at the same time. Su=
ch
> + * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.
> + */
>  #define PERF_PMU_CAP_EXCLUSIVE         0x0010
> +/**
> + * define PERF_PMU_CAP_ITRACE - PMU traces instructions
> + *
> + * Some PMU hardware does instruction tracing, in that it traces executi=
on of
> + * each instruction. Setting this capability flag makes the perf core ge=
nerate
> + * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID =
and TID,
> + * to allow tools to properly decode such traces.
> + */
>  #define PERF_PMU_CAP_ITRACE            0x0020
> +/**
> + * define PERF_PMU_CAP_NO_EXCLUDE - \
> + *    PMU is incapable of excluding events based on context
> + *
> + * Some PMU hardware will count events regardless of context, including =
e.g.
> + * idle, kernel and guest. Drivers for such hardware should set the
> + * PERF_PMU_CAP_NO_EXCLUDE flag to explicitly advertise that they're una=
ble to
> + * help themselves, so that the perf core can reject requests to exclude=
 events
> + * based on context.
> + */
>  #define PERF_PMU_CAP_NO_EXCLUDE                0x0040
> +/**
> + * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data
> + *
> + * Drivers for PMU hardware that supports non-AUX events which generate =
data for
> + * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the pe=
rf core
> + * to schedule non-AUX events together with AUX events, so that this dat=
a isn't
> + * lost.
> + */
>  #define PERF_PMU_CAP_AUX_OUTPUT                0x0080
> +/**
> + * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \
> + *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> + */
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE  0x0100
> +/**
> + * define PERF_PMU_CAP_AUX_PAUSE - \
> + *    PMU can pause and resume AUX area traces based on events
> + */
>  #define PERF_PMU_CAP_AUX_PAUSE         0x0200
> +/**
> + * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output =
buffers
> + *
> + * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict va=
riant of
> + * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strict=
ly
> + * require contiguous output buffers, but find the benefits outweigh the
> + * downside of increased memory fragmentation, may set this capability f=
lag.
> + */
>  #define PERF_PMU_CAP_AUX_PREFER_LARGE  0x0400
>
>  /**
>
> ---
> base-commit: 31d56636e10e92ced06ead14b7541867f955e41d
> change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
