Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C02F745C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708992; cv=none; b=cQ/7k0K08nEWrRGD4yeLgRFxLpv+tdxUe6GgOCV/5LttWFMg4hyQ81sMDu+iQAWCug43MFKITjV4Ci9Jou8yk5TNUpRkiQom+lgEburIg1j6Bh0nJ2qCvIqEb2ms1ARFD/8bqsOHQSo7Yyx5vLHBG4Mtb/wYlCzG6HbEc+yNv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708992; c=relaxed/simple;
	bh=bo015T8rFxf3xCZl8Gax1BGDFJbUrhC6WpwPWAeNsF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeOlW7lh8RAA6a+mj7df4glOzPwPd4LA5TERtLEo0lrja56rT1QlLggyMpgVZJw06PT9FoTnOI1KTZSiyTyxwAMLzYGp+Y1+OAlAbjhB0MHTQ8NudXF5lJGbTWsh8cwSOCE81FwZWGbCrdrdLkK8Vvk90r9tnOBsAiHwUu44enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhQZ9Jk8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhQZ9Jk8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2980343d9d1so4315ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 12:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764708991; x=1765313791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzpdKcBRaKOXGb/ALoW15oUHxpAYozQton5VjG+oWwY=;
        b=DhQZ9Jk8lhJgebaoOwTtUtQCAiHJLk49aH/Y7EMxy5SESsHNxE2hIKbmzlIgFYTxQW
         wzhPmEvutP7MGT8irF1MMlG7k8jFiw9qT4S3JncE3sp9tBU4U8RJDDgH3taOCkk5hGj2
         EJjHsqmUl3bIQPpbpZKKY27+mv8sZhIXCcxayXTHS9uiG/IahsOP+31z5NLpRvK/8OLx
         aCbeqBZOCfu8fdy1UcGicU0VmaE0ls6y3csANzN8XgWUTXohoiuiFCQs0U8enk2IXlkF
         iKR31RE6xP7K3+ZnSLTd4FwSI/0LYrjZRm9k2B4np49UddgEu18WkoEPUoIEldlZ9wIq
         T9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708991; x=1765313791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzpdKcBRaKOXGb/ALoW15oUHxpAYozQton5VjG+oWwY=;
        b=t1Ypq7gBt4Ar2q0OFx5lniEgRgcTpo6sK9MjYklqJEj4cbTLD6w/hfufoDtbhkpCJn
         8M0ufrk8cr0puMRUocIUYMP1TlULbT6JJHMD94NhFte6m7RX2T+jonLSP5P4irEXeJ5q
         T0v2xJiqtNZdijCNbGxFAXuFErKqFgwdRi2myslnpR9xUEMCfdpMqkOdqNpTeDfc2Qgw
         hREZkBgHlACH9fZxXiDvs80TQxxehkX13gh4dOs+rXsCpd2X26qR+fUion9IYudTxuAe
         29T8Vk/3RRHlcBqJyIVQVeUrapoRDNS3aiCSeBa814xq/Iq6E2DAYGoPXVL67ns1vxqn
         bzIA==
X-Forwarded-Encrypted: i=1; AJvYcCUMJNGcTwAchAgvoB6mtZImW5t4N5XdCveBcEZWE/R0KwVNBKSEyiv5wF3rmRrHsiNhdnsdGJn2WQD+C/UCAgRX@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKl3TfDnl/i7xBPHrHSpsjmvD4eYrHvFnzjjJxJYZ6nrYq7YD
	5rzmmf6ayJAX5vFX1yBINCJ1EvdrXJlL56codgYsu2JGc/+QOocFu58QvSVwFEfRQ/BtRTHuf2d
	vatJzmyyHeDW8Jtcu2kxa0A/GGfdIYRYUP0b3DD5D
X-Gm-Gg: ASbGncuWYcAmvK8YUGsSITUadxEfVU6usKTv6K582Mw3fz83VRSXE7/RD17c/+E6WkR
	H48KHbIdBv8YdUWZO3S4fmoaIJkwKsnL67A+q0dDvtlg10MUVU3ROPqWAhVJIHvNZhgLI4Ke+Vd
	7Z/N4/N6EM/L3GE/tLFLgNR+R5UWnxtnG/efyFoFL5PzFfVV5lL06UAyxgSYg+RqcL5C7FukQYo
	bNjstXfQui70n+OFDFlU1xf/lEaO5KD9kqWw5ExswKPY/GUlq7oU+T8Je1n/u3G4qRskI2O9W1+
	BLmaVOXNtHqEN1AwPmfXOnVX
X-Google-Smtp-Source: AGHT+IHG2E3G3/pRBI9ftj2dWVn88YYqeUv9BxCxcJntMyzZ6KlncLrctcZJyMOxl/VKnnhA4zorVN29dMVVpxT0fWA=
X-Received: by 2002:a17:902:ce90:b0:298:3544:aa72 with SMTP id
 d9443c01a7336-29d67f32d2amr14755ad.9.1764708990466; Tue, 02 Dec 2025 12:56:30
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202081645.931527-1-namhyung@kernel.org> <20251202081645.931527-3-namhyung@kernel.org>
In-Reply-To: <20251202081645.931527-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 12:56:18 -0800
X-Gm-Features: AWmQ_blRyHvmMd7hptkwfb0ZHqHrFXq2A7kvuZPosRG0_r1ohIvj8dPjz7jlh9c
Message-ID: <CAP-5=fWPCtER+BR5BFX4XjBCijTpB+kAkaSe+0pZ8fAx_72NHg@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf tools: Fix split kallsyms DSO counting
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's counted twice as it's increased after calling maps__insert().  I
> guess we want to increase it only after it's added properly.
>
> Fixes: 2e538c4a1847291cf ("perf tools: Improve kernel/modules symbol look=
up")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5a38435d90c96092..8eea49c50453d13a 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -960,11 +960,11 @@ static int maps__split_kallsyms(struct maps *kmaps,=
 struct dso *dso, u64 delta,
>                         if (dso__kernel(dso) =3D=3D DSO_SPACE__KERNEL_GUE=
ST)
>                                 snprintf(dso_name, sizeof(dso_name),
>                                         "[guest.kernel].%d",
> -                                       kernel_range++);
> +                                       kernel_range);
>                         else
>                                 snprintf(dso_name, sizeof(dso_name),
>                                         "[kernel].%d",
> -                                       kernel_range++);
> +                                       kernel_range);
>
>                         ndso =3D dso__new(dso_name);
>                         map__zput(curr_map);
> --
> 2.52.0.158.g65b55ccf14-goog
>
