Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845A1AA1DC
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346900; cv=none; b=TzsU5e+lOmrY4gtauOrTaluA5Z5Hay/iibxi34YZ7kYl47qvQUwPpLzGLWg53AeJ3LEHAf6UUSLaHqAeSwfprNmYkXLvUyxy9HO6WlbYw8No7QBCNbBaNsrGWrdCJzYeOrGppXismHtCI96Ts2hIQIEyH4jEnBJKtSOIEySykAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346900; c=relaxed/simple;
	bh=j767+Q1r37SUH2n615lZg0OOIFpm90KEXiFOwlHbyOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGK2xfuUvvzHMs32D+2vKJU3bMXh0+Do0dk4yOYW4UV5ztsERhT2pRD7OWiGexYtqHvlkjB2MxctzNZ7IPHb7MMVUqftWEhlS6K5JAiYQH53EDJ5lfHGZiaX/LiJrSYdcYhdUe8YjTxs5P6p4vFOdSoYoobIS05BKBOzn9SNOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFy7uowh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFy7uowh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460a8d1a9b7so506991cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346898; x=1731951698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eIWyin90eSMWDk2KIoYfMdKN5d2WbTrGD/3InglUdw=;
        b=DFy7uowhrkj1q+nlR8CLXPmUDQuqPb8UrYyDo5FcUQpRRxPQfKGuduMra21MquFHeC
         myNtnwqwGFY6Pn8unZZ+sz3Mwym95Yz3y5he8BktyHbf99ARUxlZlMf8p0rutJXW/+Lu
         foGZN0SKOgneC7pKmQcIkddaq//uL/7JscLek4tCnGYO50GhDP0rhay7SALpIG9FHuBq
         AEPF2C8xf8VlADxTyoKzhov4+s6L/HeMFsSR5OZXySg1kInlRk+8nnVS5K1T963nlaLN
         ZIGRK56AqJEEdZh3sUXRQ5L0KUkFyAi7pG8Z0y7TXUTkUAnnmY1riiDLa7X/Rk84pwP2
         NIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346898; x=1731951698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eIWyin90eSMWDk2KIoYfMdKN5d2WbTrGD/3InglUdw=;
        b=tK5611UWwhT1IqH9iN/uLzupiDFBfZ+KsElePX3ikljOtanVbQAnHNkMoms7KONn+u
         QdQqwmss6PWULF2uJjfefnmvRdp4Ym0sW6P3EVSjlpP60N6sPbzt7apkYEnWbZglk0/R
         MpFoWvMk2zcLLog9COvKERt9mZJDNAfhdpOFsbD4K9yOUq/J6fIC1aGv2s9Ppu+NwTV1
         8PglG35lkaan4dLjeEv4e4StZj63AJZIMDILLkYLHYr/LnSR4oKRp2sll24S1NmJ3Ao0
         LoCXotzhWrMbNQdnmUiw0O5TnZWqasTaFA3C3j09U0BkRlN1QdhALZxlWzL6o1d6TaPD
         aL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFWw3XKYf81578qEgsmzeSTlcQ/+2ck6ov7XO3btXmj95kT45WK3X/Si9SdMMSqtWpHiv+U3X8ZvsVMhbZ2ksQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlH33XwM+JHhwhEye1FMFFp4G3SrWjlZMipK7Ujo+Tj2kIbWtS
	POy63iOlAV0TU88sH6X7vC8EgvrQdlPLZM4i4nBWH2W6obMZ3TVSdZ2dT9G8/n3F45lqsr0adBl
	wE1q9eOtd5HFbe+ywW1CQb7mTIf0/mA/YFyEy
X-Gm-Gg: ASbGncukE8gUWmDBHSos9trBtm2A+biyNvyrTo+JqgpcYXhUou6TPTKLjNkFPkqZCX4
	kVgH5i0LkNYUHZqGzwyF5szjRB9CsIN89UK56pEXGnX4XO2gzvg+4sWc0njFq70Q=
X-Google-Smtp-Source: AGHT+IFXHqqr9T9fYqBjdk/y4XDoYoQXljKGYDZzdrbYdE3NEYkwRL0/DPAPhGpQprT/9y8WY5pCe2FdqGVr6tBHEcs=
X-Received: by 2002:a05:622a:1454:b0:45f:9b3:c7d4 with SMTP id
 d75a77b69052e-46316965e68mr5312121cf.6.1731346897791; Mon, 11 Nov 2024
 09:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-3-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-3-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:41:26 -0800
Message-ID: <CAP-5=fUXvpgZ-bkCYjYaTu0OOkqETx+TStKJOupx1y5woS8PWw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] perf evsel: Expose evsel__is_offcpu_event() for
 future use
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Not sure if no commit message body is okay. Otherwise:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 2 +-
>  tools/perf/util/evsel.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f780e30aa259..695f831b463d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1193,7 +1193,7 @@ static void evsel__set_default_freq_period(struct r=
ecord_opts *opts,
>         }
>  }
>
> -static bool evsel__is_offcpu_event(struct evsel *evsel)
> +bool evsel__is_offcpu_event(struct evsel *evsel)
>  {
>         return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCP=
U_EVENT);
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 04934a7af174..7f68004507d8 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -554,4 +554,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
>  void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evse=
l,
>                                 const char *config_name, u64 val);
>
> +bool evsel__is_offcpu_event(struct evsel *evsel);
> +
>  #endif /* __PERF_EVSEL_H */
> --
> 2.43.0
>
