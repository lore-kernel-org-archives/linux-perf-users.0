Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CC25D527
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966216; cv=none; b=TlLXcGI4WAAoFwI542IQdajPymed+WlgzBGww9oFrcy3y/xAyoV2QC3f2LKaXGS6xNic1cvVvMQz4lyfB1CFEAwDHXkfaSDMd5ZkQ0kx4YVCT8uBrtLYQCiqg9gKFX6Zt7Kn+u+5OA+GCbTLhlDFuEwIaA8EOoYJoIIOBV8ELrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966216; c=relaxed/simple;
	bh=Tiwbde6lhRPpVFkuGMnOq1cdj+tm313o4sMRI6JbwIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7bqFTgQ7NX+0XGON/7Tbc46AgtE8tePttcVIie5Vj3vlhH1rHq/5brxxGXws40EtKTosxGFGwijeySiPGyXqFPr6SApqFCbRUO/GFxpFpNA62K3dNC1yxlspcx3C0JFmiEgzOfQeBKUZNXmSiWB5HOScFaztkDSbYqOF2eruWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC8HyX6o; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC8HyX6o"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295c64cb951so231935ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 08:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762966214; x=1763571014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im8M93syO4Wdo1dQDINgUp1S7N0dhhvUu+q127lgjpw=;
        b=SC8HyX6ol1VS7yWQdw286KVJ2HzJk/P4NyrY+t/lIjSFo5wQeNL0ViuXlqUEBsj33T
         haoBOEJf7mMfhIAkF4hisuoPVktrIP7/wVRsoHraT3g9uZJIzQS1pSw9byeMzhtpegWY
         oW0Pf0G+IuiPChZm3j0Y3W7VPD9aq0DhH4q8DWFfJjGoA6f8cl4KP/Y9EuE/JPFSfwdT
         fSa07FvLuuUhLbe+5iN7HjphxyoZZDj12SvDsQbtF06SuDJMGfQ2SKw5L15WTNGugn4s
         rkhKC2OtkiPEOw1g7ToDNXyokxEAhpXlXm1eASemufSpfRvO5baEbRAdKXpren4fOavj
         Vqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966214; x=1763571014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im8M93syO4Wdo1dQDINgUp1S7N0dhhvUu+q127lgjpw=;
        b=Xapu+YjodaHCXDjwHqgv1Nuc/FC/yKGuUbWjkWl+numwBiW/0/QoY8GvDECwaLtbJ+
         2lHDiweA8s99G4DlWUiRj78A8v9Ttn5cvs0dU24Ys+QXOCBSjd0sQRujOl1s6DrHP0mO
         XqTvsADeuq1aVNIFfPHKo2QFxvrWjbMTucyTK4Qz8GJEVZWYz02zcuXC5TNNzkcUdhWX
         W5TOQUHZxyjbVZh9B+IQ/X/VTlRyPqnXdexTsDzm/YgMwTk6sVzx7b5OSni38puiKXP/
         B7HcfPve9Dr1BtGft85YgT/KwT3Ger0v4K1F8e2wlvDWtHwonA+Fh5xhR4TsJ8wgof3X
         JCTg==
X-Forwarded-Encrypted: i=1; AJvYcCUgNBn4UB+MSus6SB6SZU8/2rux7eKmfWAu5pJODgdkPD/3XdPS8kn5zUWYcAbfT96q9hIGGBmrXZ/O3qepa+xS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GnOVPtQDL/PC4mQ7dKCXVewLOESJgri1/A3rJMojTHkk2IlQ
	BxAGPMpmLAgKK2jG9A8GYNRQt89hYypBWQf9yNyXqZv9XLFy0NrNmH3aaRCpLTBkDw73y84pU1R
	y/CHKMfV0xs0lBmEDN8Q3DPysrzEOT1uqCkw719Yk
X-Gm-Gg: ASbGncuXwFniegQ5KpNemnju1gKuILi2Qrc1rrVZ4JgJ+UCx5w52CDby3I8MGoXGZNb
	tyNG/rbFypJPiTh8y2qb0cu9kWXDZwUtBWunJGCDJE89IYzAQFszDdMeJ/MauPE2fLeHTDhHdon
	o1ToVmChyZsWU6mrdQu+UGvfaS42QvVsLe2qvSFTwJ47LcXR3goCL3CCVzfZAP8VzIngHUJx+G3
	DlOWA0i2V1qYQv8KvCCkXJ2n3/QoBhjpCKoO5EpEpnZONJIWYRYGkMiGfLIzVH6Q9T3Zy/TN6K6
	qKEI9tODb5WqAon9aBTpLQusiSJoQk8/sZjV
X-Google-Smtp-Source: AGHT+IGwx5bn7xQydBmWpG2XwjQli5nNX+W9qsqwOXGCIONZx5bVCiDz/zbGXu7F7IfB1kae8B/JhUVm1uX9/31LFp0=
X-Received: by 2002:a17:903:1a68:b0:295:5138:10f2 with SMTP id
 d9443c01a7336-29850761942mr2821745ad.11.1762966213583; Wed, 12 Nov 2025
 08:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-perf-pmu-cap-docs-v2-1-3c451f7b0b2e@collabora.com> <d01d3f15-c144-4e2a-9aee-6308a897f3f2@linux.intel.com>
In-Reply-To: <d01d3f15-c144-4e2a-9aee-6308a897f3f2@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 08:50:02 -0800
X-Gm-Features: AWmQ_bl2JhgUXo9a1z19NSTipK_Tr2OyLPJE-WcM9aaK9x3Mjo8BIxtSG8U4n3s
Message-ID: <CAP-5=fU2=s+88RQE0iq8DD+mxjMUca4UHkSM3TjkS8T_7p=KKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] perf/headers: Document PERF_PMU_CAP capability flags
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, kernel@collabora.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:11=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 9/9/2025 7:39 PM, Nicolas Frattaroli wrote:
> > Over the years, capability flags for perf PMUs were introduced in a
> >
> > piecemeal fashion whenever a new driver needed to signal to the perf
> >
> > core some limitation or special feature.
> >
> >
> >
> > Since one more undocumented flag that can have its meaning inferred fro=
m
> >
> > the commit message and implementation never seems that bad, it's
> >
> > understandable that this resulted in a total of 11 undocumented
> >
> > capability flags, which authors of new perf PMU drivers are expected to
> >
> > set correctly for their particular device.
> >
> >
> >
> > Since I am in the process of becoming such an author of a new perf
> >
> > driver, it feels proper to pay it forward by documenting all
> >
> > PERF_PMU_CAP_ constants, so that no future person has to go through an
> >
> > hour or two of git blame + reading perf core code to figure out which
> >
> > capability flags are right for them.
> >
> >
> >
> > Add comments in kernel-doc format that describes each flag. This follow=
s
> >
> > the somewhat verbose "Object-like macro documentation" format, and can
> >
> > be verified with
> >
> >
> >
> >       ./scripts/kernel-doc -v -none include/linux/perf_event.h
> >
> >
> >
> > The current in-tree kernel documentation does not include a page on the
> >
> > perf subsystem, but once it does, these comments should render as prope=
r
> >
> > documentation annotation. Until then, they'll also be quite useful for
> >
> > anyone looking at the header file.
> >
> >
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> LGTM. Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Ping.

Thanks,
Ian
