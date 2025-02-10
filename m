Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568B247DD3
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203608; cv=none; b=MhA94pJac9hUtpEJ3vqvPVRmFsTfvFdnb+05I/3kw/23mFlP0poQEKV72aDTxwZA4e9R72zAcKZd6QcitUH9mcCEufOOA46YYrU3oMAPwT1nlpIikZwsnEGT4CjQ27i98+LenA4kBegy8IlikmbOMvhr7UKv4m7vKNTge9+Cti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203608; c=relaxed/simple;
	bh=Olzjpcb+w+3A57LrTJ+oJsty2EVJPRVXqH/zLH5m3+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uLy6g66Kj7qnoEpBH4ygeEGOR4tKgpW3dDd41whTIcAPOwX1mEJx2XN8ZOW9sGDdY5u7id86ds45I6muSOJ+OpG67d/rEolAVI0iC1mKby2U9TWC8MBEh0K1fhzsd71MyDiV+2s6Nax4/JlTSZdGrrikcppHLFo4gAq4cJTB+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZg88tbk; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZg88tbk"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d147331fb5so461815ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739203606; x=1739808406; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Olzjpcb+w+3A57LrTJ+oJsty2EVJPRVXqH/zLH5m3+k=;
        b=nZg88tbkCF/ZLr+o4hjG0MpCbmFvrC1NPLhA0kbkugmrXa388GtIxXIqENix8FxwSn
         uSDboYTiZm9IGJgveXDmwgREVTeaCx9a/616bYwReVGz2yHAEoin9sThkggfOKFlBk60
         AQJccbjdssxeHZeU+KzpGayyFOxNIq0kdHtHauG4d7AIBq+biQ0fhDvZIicOksYxkcJ4
         jopMjyvr3kerCsiQHZ0si7kyG8uIaPVZ7+hWdOj2Rx70Z2t8/u4jQ8ROVQDxy/A4w+Ve
         uqLEo2EMWBqQxh+VEPpH+G/MnRFmste7FgWR0aF43sMoKp3uw7i1OcG19IVF8kEYydsW
         sBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203606; x=1739808406;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Olzjpcb+w+3A57LrTJ+oJsty2EVJPRVXqH/zLH5m3+k=;
        b=LOobdP5kEGpqNEJXLkXUTnb42wLsBuRwCxw/YZnOms8z6yqF9NqRX6+RsoQpYbBic1
         UpJ8E7fMGm8ELUllXIT+pV5dJXAdJhYhF5CqhfoMZbf3E/HaUXygsBOGldm9UxIz00Ge
         yzRaqgkFoM2E4yfmkRhPjR1GIKft9ySgklOwN1XfGkCyiCuEOtjGPpIcCsDqHxuxP0Cm
         2VD3q7Z5yc7E+OdkJSf8juRoIAK6Ymf06+Jko/d4u1jZChWpnAF0YQh3cbAngifRtkiz
         6xFfKbJtE0smUMZdg+qzfa+jgtdUPpz/3DvJ9O1MFB03lZeMX4ldYECWOCacIRj/ZNu5
         Ev4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtDHWIO9DMyGtCJZu6/bQ7SzKoP6pd59pC/b3ulAHLOgguSFupnnMdASA59sAFH31PJK9ph920Auu7QdgA2/xS@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEUkRu9eZhr4LFJtT8tfs+AwNBfaTMhFtFa0gz3ywyNRxrQkp
	P6uxINJqxuN4v/NTgIEoMR3ly8jaDavk9zqs4Z+obXBupkdhJKCIxhN2ClFqW/AZSErg8fkWIE2
	dUpXJK5DSYW3eOiQ/LKZFSP4rJhNNu3tncgQG
X-Gm-Gg: ASbGncva6GeC+h35ONiCHUaxKVf8OOkbxCDE0gc82CdCi8f3DHm3/0affL4JpRVUB/K
	I8iaNyURiprf1DZN4f83LZftU18wFNVXNwc1aAQT4HDYQ90AV3SwrNoNfEpPNoKxkcGKuj+gA8k
	4f/q3PABwO59w6Cb/VFd6NBp3D
X-Google-Smtp-Source: AGHT+IEn7qcZK0y1O32iGhtabjLE5FOvyLkUu+evcFif5hHQbnRDOMZauWsp/8NYcRCYQqbVTjH3a+jsSUqrRuLGrAM=
X-Received: by 2002:a05:6e02:1ca9:b0:3cf:c075:da88 with SMTP id
 e9e14a558f8ab-3d14f123828mr5278305ab.23.1739203605922; Mon, 10 Feb 2025
 08:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <CAP-5=fXL=nS1-m1+gJsYfWfvyn0ouikX3=RvyKdiM7+ewS9-mg@mail.gmail.com>
In-Reply-To: <CAP-5=fXL=nS1-m1+gJsYfWfvyn0ouikX3=RvyKdiM7+ewS9-mg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 08:06:34 -0800
X-Gm-Features: AWEUYZnE2XLv9epQXHXfgD7vbBK_XUhKNaQU6ZOpF1_J3_u4h3FTCaw-aXF08Qg
Message-ID: <CAP-5=fU3beskCJLQdKE8Mjdsx0wTiihh7Z9k7VQtZuJBZC5b6Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Python improvements for a real use of parse_events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:23=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > While parse_events access in python was added, it wasn't used by any
> > python script. In enabling this for the tracepoint.py script a number
> > of latent bugs and necessary improvements were discovered.
>
> Ping.

Ping.

Thanks,
Ian
