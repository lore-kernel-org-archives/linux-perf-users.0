Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1820ADF8
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400890; cv=pass; b=T8cXuyhXl6fWNULZz66VHXGiAVM+HnfwcE8FugYavhvA4DfEIv8W1ajgziVko7hTf1ufPRexi3e5QC3MuCTnd0tWHuDgVVWjsvtTBfcLpg7QiG4xIk5uDJWDgV+1GzdcJ4Vqlk5fod/b72M3MxO7vf8571KA+Pk/iE3MErqQZYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400890; c=relaxed/simple;
	bh=N4Fjx9tROeMbPDKksh21KcpQq4T9sIggDrL6n+lYp5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3p3R2TbKEChUjV0X/UdA3QR2l69I/kDc/Gmd0XJE6JStX0oS5JlvD96Qx2z8zcLByypnI2GfSZ7+KfkJoh8TpdX6h3JpTFUO4yHdnlrN4ns1ePbSOAgQktanxxm6Xs79YmKSk7y38bTkm676MTIkmFX9TM57LGl39MFN4Yq/+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1N8eTCK; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1N8eTCK"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-135e88b8e55so302779c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 15:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779400888; cv=none;
        d=google.com; s=arc-20240605;
        b=Bc9hNwFNAwp3RmhLlLMavTsNwNltvZNDYy4xojHShSzX2Th9ia7p+UWrNI6CFo5/lm
         h9rXEYe3dKESoQjxOVWK+uUTOvIjspL5/M8OAayBfHRfkhYvVsc7/80aYTB7v39s5koJ
         P/Cjm3sLsQEStSB/FUnsO589Te7WT4Ba12Xr7NJoQxK8UfcEM2MfAr7i0SzplAty6/qz
         q1dsjFdo/8etXPjBXF5ylLFG0lTq3WEq8hyHyEGehI1vMs/7HEUnNZqrvWdicaL43Kg6
         lUszD9pz8n2SCJETiSDl8FLxTLvk5ApHyDgycGYvQlJ3SVfC4oFmDzA/Mo2DLIogAt4O
         iHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9y4H2uszFxZcCkY9wTX2g9+u7oXwsEvHiSVj7q7N+5k=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=Vtn/SSxwDrPfta7FDfdwjFYNX9sbaLETK5XMqS+F27SysaTqI22yJiElz3jZJ/5wYJ
         +Q7kX/Dna2B2xthVQgFSC/PhycxJ83bohZKNtk7JtFf2kw1xx71ztoD+KwyFlPnyrQJg
         H/X1hV84jyriEIhc9vBVoK4FFjZfBSOH2PayA5OfGjEsvhZJEmsABfG9LD0F/3fGWEOL
         /DK/PCQk/HwIeuSsyX48kLqVlGkw79u4zKpLrNqmmzvu7SNyjBc3nLBq9LbZZPLNRGp5
         VYSMpcDJLajgNhiR8ehPDaZQcEgAABOCkBdeizGWHXNyP39UhJzO1hzkn+05JSG4vAlQ
         G21Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779400888; x=1780005688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y4H2uszFxZcCkY9wTX2g9+u7oXwsEvHiSVj7q7N+5k=;
        b=X1N8eTCK1TrQOfhKHMRyNyI+at56w98+9gez0+KaO7sXrQRNcW8D3aJDvr4fQBn4RD
         kGbVW7K66HRsSkQzgJ7kz5dW+ewXwaz06mw2uNvB9KCWQVTfB45ZCGhat2kyfJAVkPUH
         j/tAlJm2SxHB+sU66sa6I7rPQy8xFkzdkHUPuBoZfDBz2y6+Rof1GykLEwxvpShYOKCc
         UqQB3PwQNXedhRLJ91D+rS0h1SADHcJZ0H/EJzTX25+me/TsKlu3JM/RPg/nmGvdVKcH
         PPVnJ2DAxdo2eC/sd6pebGj1EQmHZDWMSDGPSAsKXHns5wYLcp/E0DRngJSdo7y27jk1
         OphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779400888; x=1780005688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9y4H2uszFxZcCkY9wTX2g9+u7oXwsEvHiSVj7q7N+5k=;
        b=gLs4eAZ1nvxOvvNk0TReZ57GssxcWcCYWTMnt+hv93yNgYvDr52/gmIoRMNAVcaiUt
         Ub8blOaRahb5A/N/vTTnnBThUI1zwydxvhhcKwXn0fFF4gFE3dRApD5PtfpaEzYRQ1XC
         WSRHiB7ZLvgoPoXs1OuaJchzmXGlMVHgVFZGlmdpH3gEYDzdED6H2rHle3530Xbnir3l
         fBcxQ34Z5Q0rEaUNk7pyIOFHEkTD6/jfe5VrTOCF7AK6aXujlNwRHZBdXoMTTmhgIZyN
         1uqTr9YLVZMAj1Avh+MmANdnPEVAIFkCevthhMJ5BHz0TgS+NSJUgsnwJtGR9nFJVoDT
         HIRQ==
X-Gm-Message-State: AOJu0YxbUnc0tkRmtKdcdqNxkLC0Gx3rc/z91fF6U9lcnm3I2tl+ImOL
	Ehbm3ibzZYViNh1xC3qJy4Y5T15lpGm2fKglqJb+hwknEWzTNi5IwCi/gAwJHoFU7U8p16y7U2l
	L6cjFvegCb/5q4SYgCKuKu3X9ROvN5ieNScHXSITgdiDp6T0sOBsmFcQf
X-Gm-Gg: Acq92OExnGIG09eljqEVCd/KVcwd6LOP/nB0++v+fPJmWktwNhT7X0DwWDJrMezXj98
	gQnNP27LbyKRcDRkyBbCi+2eGUfCYjE2zqcwFhaPTolW+I25KRtpnbciGyh2N7PXnZMugWf+iA2
	de0spBdNSB1ZDflSF1M5IV72GIlGCK6VViGqHhIdLJTUMSkoAMqm3AooC1wSWCkHrhO8Gu+2VW0
	J6ET73nIgkoBljcxk8VR5KxdkT6TnOfqcchsQ5S73Wy5lg3X1pwpqI05Q4E8v/RUkr1WKBN7uGJ
	OA6N2yWoAEXsanxfJRT9p1Ec+wA=
X-Received: by 2002:a05:7022:699f:b0:12b:fb81:d69b with SMTP id
 a92af1059eb24-1365fb3f9e1mr444923c88.19.1779400887229; Thu, 21 May 2026
 15:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521201505.124690-3-ctshao@google.com> <20260521210856.4751E1F000E9@smtp.kernel.org>
In-Reply-To: <20260521210856.4751E1F000E9@smtp.kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 21 May 2026 15:01:15 -0700
X-Gm-Features: AVHnY4KTFuuRNrnFj3sBK9etQBeO9LKQmbYilyAosOf0LBBoJ4GM_Bj2P9HHT1U
Message-ID: <CAJpZYjUAi-CjyXW1ZLfLN9f9HFwfmpkzkR8w3o_RDMbVnYOqrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf stat: Use aggr_nr scaling for Intel uncore
 miss latency metrics
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:08=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Replacing `source_count` with `aggr_nr` for uncore events yiel=
ds mathematically incorrect metrics.
> --
>
> commit 25ed3f24e52414351780a2cc517f2d6534c79d03
> Author: Chun-Tse Shao <ctshao@google.com>
>
> perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics
>
> Update metric.py to support the new aggr_nr keyword in the python metric
> generator. Replace the usage of source_count with aggr_nr in IntelMissLat
> inside intel_metrics.py so that uncore latency metrics scale correctly on
> multi-socket and SNC systems when aggregated globally.
>
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 52035433b5054..d99c7dd43797c 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> [ ... ]
> > @@ -674,10 +674,10 @@ def IntelMissLat() -> Optional[MetricGroup]:
> >      else:
> >          assert data_rd_loc_occ.name =3D=3D "UNC_CHA_TOR_OCCUPANCY.IA_M=
ISS_DRD_LOCAL", data_rd_loc_occ
> >
> > -    ticks_per_cha =3D ticks / source_count(data_rd_loc_ins)
> > +    ticks_per_cha =3D ticks / aggr_nr(data_rd_loc_ins)
>
> [Severity: Medium]
> Does replacing source_count with aggr_nr here yield a mathematically inco=
rrect
> metric?
>
> aggr_nr evaluates to the number of CPUs in the aggregation unit for a spe=
cific
> evsel, while source_count correctly tracks the number of PMU event source=
s
> (e.g., total CHAs).
>
> For system-wide uncore events in global aggregation mode (AGGR_GLOBAL), e=
ach
> PMU's evsel typically monitors a single CPU mask, so its aggr->nr evaluat=
es
> to 1.
>
> Could dividing ticks by 1 instead of the total number of CHAs result in
> metrics being off by a factor of the system's CHA count?
>

A false alarm, source_count is always a static number of evsel, which
should be replaced by aggr_nr when calculating per-socket metrics.


> >      loc_lat =3D interval_sec * 1e9 * data_rd_loc_occ / \
> >          (ticks_per_cha * data_rd_loc_ins)
> > -    ticks_per_cha =3D ticks / source_count(data_rd_rem_ins)
> > +    ticks_per_cha =3D ticks / aggr_nr(data_rd_rem_ins)
> >      rem_lat =3D interval_sec * 1e9 * data_rd_rem_occ / \
> >          (ticks_per_cha * data_rd_rem_ins)
> >      return MetricGroup("lpm_miss_lat", [
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521201505.12=
4690-1-ctshao@google.com?part=3D2
