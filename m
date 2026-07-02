Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5C351C3D
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 04:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965404; cv=pass; b=WzJUamd8drLtD3aMkHWvAahOEr0etjfTe7lYGK6wZVsDNPc/ljPkKvDHs+KmHB0m6a5Hn7c/K1UbRlGdPBVla71KhKt4uqTbI2DcrHEMvgyMJRQrP+fSgyUd/jYzR0HAANs9XE1U9yqaTsuymirP5SHqhcXdd7DvlTZLAjojc50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965404; c=relaxed/simple;
	bh=Q+4Ej4+9fCjdhkaoclqMTkAz5hQBRxCHsaPlG7vG3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEftBu7f935VxlZRzFtvA7zOx7bZoKG9ZgqSIwHDoCM3/E6fzraiOszzTLDEwrhGQFwXVXLShVcjMoPrvt+nX2B8d5yZ8Gdj/rpvG+QJZbO/NXD4DeQU91GVmLRV6Twm8AWSKnZXA6srUEY0WxSzSSeFRcHG6V6297heRgxhDT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3nJJnrb; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3nJJnrb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c9b1db4964so138275ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 21:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782965401; cv=none;
        d=google.com; s=arc-20260327;
        b=qlxr4kF/EuVWFfOsysHGr2QqSQpvlKiRiSWzOeuYLV9W9esYT0xaRuRINl2+oDkXCX
         GdLRgHUugdFehFZLvpDzMal5yC//eN4Z543jTkboEsChbL1sh7f+MXY3+z+91Hgd10Rw
         05Vh+a6XZZ9OoWaCvh2U/JgQYQBey4LgmfU+o+aWGK54jdCLqWKyd5pTtZJdBzWsP5EB
         eV5G+tDNYpp4ye5r9nLutU85MmpzOMzcBYEezNV+FHdZEhcJ6GPTL3Atz1Rj5YUXPnt0
         AhMClW0K5R03Gk/3WXxsZaxXPRxlJ5CjWE7oWWHmjkHTmhplgUNOWfB4L0cw99Tx6uJK
         hYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RD3AU6vU2VPlUwVyGnznpArGQ8W5Q5jnjAkJqBE07sk=;
        fh=RraW6B+kCVqKtz8TBWwcOVqRuiGoTMZIQojfY4dymRE=;
        b=kPubukO9nwfuqqA6WsfB3LhY+wUfDKz/7mMk39Ful9WXhTc0trt/fz+kUikWwW/CVW
         MKuPgtFEysVj9RBRS+VP4QpibGG/h/MBkOpF4USz08XglFThysVzdMz9lJVWxAVFz5JW
         yiN7x/tuYV8bPMCNuGuWyS+SWQQvJ9TpuUxAfwH9u7vlWK7xSC/8+1cAXVBO6V2Q6Jys
         yow7RkCEc1sSIAHhx5wbDdnckCpHIBlg8F2oHKBBkbKOd+llUqp7jPoKXLRDG+TAHZ9z
         i08KGx9ysGOFBBK7rHVtLgfB4xOIo6D3wFC80kTamDezivyU7HVZf6EOoL+2uGo/cIJo
         44fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782965401; x=1783570201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RD3AU6vU2VPlUwVyGnznpArGQ8W5Q5jnjAkJqBE07sk=;
        b=i3nJJnrbHpQvRPeT7Uyj07gq0bunmkGHNRKSOThvaHMihZow683Bs84KhwupXVsfJ1
         yJKo6iwoZwBfHnNIU1F9xd9ltHogfUt+izB/KB1oPyVSskWCtgPgWaxR5ymYCYvjwWu0
         +2TzzvtQNhKjSRQL9fVWeiIGhiTozY/E9slADl6i+z4lN7c0z1Ltqh6t32Mr9b0d4EOq
         a8qgqs1xXOd462JAC+6oWTALnbFOCsb/v6NDNhwjUKL3khmZPjHkkZJZtf4jRlYLhB7U
         ubhLKVqV9C2DXRsl8N4zAHmJ7in1982QA1KaiNJ3/qcBk7Plq4ozHfUjBLepv5qoSwER
         GHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782965401; x=1783570201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RD3AU6vU2VPlUwVyGnznpArGQ8W5Q5jnjAkJqBE07sk=;
        b=n/8Re0Mla/XpX4laPRMuE7gTtrdPl2nnep5+5c79xuI6wGHYZJr2KVv4eprw+4T29M
         0iqcMfIEmCLqONTCRuppm3LcQqKK/wcEmUw2s8ktvtFm+9ShJbHZDojAksIls3vsfZta
         U59dQ+Ia2Fpf9Ly7FUIikRiVvTEuRMyTi7MHreXEKB2F4pMFQWCtWwjjZ2hdMIOodha5
         scs0cee6uQIN6jgeCyARcWN9GweOirp8bCe2Wi6iBFy+FLqF2g9M9JHpRq6xzp6Xwd3G
         GswMDGWYHpA/WlKjl9a7qOy84acTwA+IZcXnZD/FMPuKhOAFxZFNKIw0lD28ud9Ek92L
         mKSw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+6GIP/u7BB0ZQmPVTyGs33n+MqqAcCrtng6zxfDa4SlLbumwfAyaUiiGGBb3P7Ei8vlr+v1aujw2G7HHz6SKi@vger.kernel.org
X-Gm-Message-State: AOJu0YzSe4TMQMvFBsgg8RpcW38WAIP0lD6Cx3wI+dsI6+x6LtyUEpDF
	4SrS9iXswBn4J6Kj1286+TxSRj3ZHivG2hPvtmOQyW5B+wpZdXTbSqNU+HKQK4tEp45ma2yD4Mr
	QMtYeUtDlvW1mbfM2GoPhGm732vzD2mUN8vopF4Tq
X-Gm-Gg: AfdE7cl9xh1mHCNPs0GNTUqjRsPMTTIVQ4hn1+4ikzXkdDVE0/aras1TZ91m6D6VoKI
	+Alzrnq1j/FHxMQEwIsTH65WKHS/k1OU3zuENimeAwMXEgA6vzPDWrPUb521Fnyo8e6nMZIPF90
	AFC293oDdxMRzFa++7HWE6sR+riO11MxMdXOabPu5EfuiIBBHMWOsNQBMCb0oWKEy8t//NiTORs
	Ft/NPtQin3rcaqIrJpEiydyYTupL3LV9K1vBO+1JvYs366oqTwO/PLhs3WYbwqTlz9VEmqtug==
X-Received: by 2002:a17:902:c408:b0:2c7:f688:f22f with SMTP id
 d9443c01a7336-2caa6fdab93mr470055ad.13.1782965399443; Wed, 01 Jul 2026
 21:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701194153.401218-1-namhyung@kernel.org>
In-Reply-To: <20260701194153.401218-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 21:09:47 -0700
X-Gm-Features: AVVi8Cek5zXmvzINfB6odq1v1gvw2NR0PwqqU2wbewYXL5qtXeCCwTi-Txsu8MQ
Message-ID: <CAP-5=fVvxW9u2qxrqiRR2PM54REs9A4Fta5anmT=WsjoqvR+DA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] perf kvm: A small update in the default arch event
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 12:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> Ian said there's an issue in the perf kvm record command line option pars=
ing.
> This is my attempt to address the issue, simplify the code and fix memory=
 leaks.
>
> v3 changes)
>  * remove unnecessary error check  (Sashiko)
>  * update test code after rebase
>
> v2 changes)
>  * handle kvm top subcommand  (Sashiko)
>  * handle other arch/condition for the default events  (Sashiko)
>  * add <stdlib.h> for musl compatibility  (Sashiko)
>  * fix some memory leaks
>
> Thanks,
> Namhyung

I built with -fsanitize=3Daddress and ran the kvm test. Everything passing.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (6):
>   perf kvm: Factor out kvm_need_default_arch_event()
>   perf kvm: Check kvm_need_default_arch_event() early
>   perf kvm: Kill STRDUP_FAIL_EXIT()
>   perf kvm: Do not copy filename string
>   perf kvm: Fix a memory leak in the usage string
>   perf test: Extend perf kvm tests to check default event
>
>  tools/perf/builtin-kvm.c                      | 109 ++++++++----------
>  tools/perf/tests/shell/kvm.sh                 |  10 ++
>  .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  31 +----
>  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  37 +-----
>  tools/perf/util/kvm-stat.c                    |  41 +++++++
>  tools/perf/util/kvm-stat.h                    |  18 ++-
>  6 files changed, 116 insertions(+), 130 deletions(-)
>
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>
