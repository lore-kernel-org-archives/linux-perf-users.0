Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538B480961
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047167; cv=pass; b=apUtZYzEQ2177P7zaN6ri+V7EvunGBmDsLbV5dX1g/i7TMdAzvjQfsogMQW3i3FBfTI2Qc12nw7C7nUmdXGuXoKb2zMC4fTkYfQY40jWchX0PY+wRIIWlgIZmTSqo/VC/aXufBPZebPeamQwOtMtytevfGf6kCJ9LwSb3c1nOv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047167; c=relaxed/simple;
	bh=K1AQGDcWC/4GgVV01r8j1JfDHR23FXKaCinGQS5aAX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWLeH9SSR124WG4BqJrAZ6J4KIQkx13lYS5nAn7ywHypTXYOR43C5E2yaQnESKctQEEaAeas39i3G+EqUjIto0TEsSTulUA39BGA0EnxX0M1Eothzd1Z7sFxpJ7XLvv0jfGwJHf5SeodZfj5gWFvRkQLtcilQ6gVZT//t9Bhv7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPjK9h0B; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPjK9h0B"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacef7d299so157735ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 09:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784047165; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2Pnv8W9wZf4ObFr8OM/TTQHGgcaTikUqmDLjoK46UwoeW7ct49cMxkgf3kW4U2xr/
         yahvsmt+YSV6o98eKaLQpYlbeLYMR5XFNOhyYO4nOBAdMBFTZEudTRBVSVJHSeDcCOBT
         uXXGtKelIkU/p32GjOxsCrDjKd6w2n483ofJTFnjLoLPlnc9l9BeoASNq6fES0rZ4eyb
         heHofWh35E5/QXWC1uHU9RO6m8GXZ0n3iXcOz7/GGbvSv9mTFoQaztu7xilOOV2klHwF
         UCpuKr3c7DSF5xJmeTL53b2abaS8SROPhokIdKCpRhTb9+GFC2zJP4fbTrOiikXpQWQ+
         nhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t0F/NHhcKFnHJCtvxiz4DGJcsT0f79av2OZqgWRJWgg=;
        fh=yqOEi7zMQ+lXgqQNhORK0VSUodX77YgTv3Ow5iX0X/s=;
        b=N/HsGT2lD7PElIaNDm79dtZkzbmY8dTGk2PDBTgoa/9LiO/TJ5PUhw6O8gwi/CLzKE
         IAKRVubOM0G4f1WFKTJ13hZA2yyJrFRNYA8NZTZt+BX4tf3Wa5jIpkHtUPFADPu4qgrB
         nUzvC3TIIkJbqQfVWkyMG/ghfS2iAXBYoxAW1tNZ1OKX+QOVPxVa93WK3Ya26M4o5OdU
         Fg8tFPe1WhA+5BizXn9020xrHjylYzE+uKdNumyVUaGZveKL/7hD3zU1r6kVHKXiv7s7
         /fTaRn5TRB5HSraXuICO5UQWeRDgcjgjKWludOqiMzJ7NV40WHo0E19UZNYRsZuDyLOs
         +RZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784047165; x=1784651965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t0F/NHhcKFnHJCtvxiz4DGJcsT0f79av2OZqgWRJWgg=;
        b=EPjK9h0BvNsILcHtblILqZ/QGm9deAM+55VqPiMcox45wGOuRowjlg3O2BstmyzRVB
         0WiV2ToDEw4UyLrNLPikP7FQ0nON5IzIuU5mligXeXZlkedNsDjh6wASdwKilgQGFQW3
         J9aBRAlTZ4vmHsQTeHkJC0cC8PPHsKIVMZyK/elNif8IkUn7NXMkEIgRbsPe73NJC4Ii
         jIwJA6ux9JpPLYU/TFwpcrAke5Lr4kyD8BhpWGDCVJg555jS/b4Pz6qOInLgwC3SEFbf
         V9QbAW0Dd78fVl649sZ4BFRH1ckOOi4l38gUHsU2sDWn+h1nWj7TPdm25fmk++n5n1ML
         ngLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047165; x=1784651965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0F/NHhcKFnHJCtvxiz4DGJcsT0f79av2OZqgWRJWgg=;
        b=QdWYxsYUJdiFakbGZZlHf6VlcDgQjwQgHfHk/KsYnTRBloMv0ujdYzKT7IzerbMxXL
         Dt3j5RRLvqsTQyTOW7JPc20Pi3ZfVMTJQHKbB+Y0EHN7CZat0Q5THbrAjCOpOEI+y9yl
         uYjYUC7Um8T7WWvwDFLjTlOTxHmI/OXkNPAFVmZ42xOrnzcJx7ENZ6g2BKnPSCwa1Oqk
         0rJ4MEAhJrS050lklR/XnnRQewX3n8OzWbNMzZUYuCFK4KWCyK+C4+Q6g0G+aGnRJqy3
         YE4cawefgGQSraNvELSsYMQEJWVFNuS+81+R/fXxtS8in7CJg/p6bP4ObG4KSVDJTjW7
         70ug==
X-Forwarded-Encrypted: i=1; AHgh+Roa++OL7lJlqKbllBFsJNxDlHxDI68n+FJffAWfVU1uHfnSYGlM/x2jSpD3+t8MGY9NJyh63zM6HOdOVpyot+7+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/SSKyyHWSd1VCdaKp6soF5NfNUvu/gvIySYXocAiQv1zyquK
	33zNStuANnpmRdT5bweyVCoNjk6apMs22u8aNbq2oSc0nIplzx+ORVDlpxUW231zMZ4HQsZrMEs
	3DZ7maotBDqBlpbZYGcqB4MgRdokYm0tMQ6Rw2+cm
X-Gm-Gg: AfdE7cnpuFTad48mMVOi6/HeOB7yHI79b2CklYm73o52qAgIXPBeVhykL1j37yrR2gj
	CDgx6bMPtxboJ6klH49iIh1ogyHX7dRoH9AMO9n5ZuWgnY/jHwMzA7fxorMFpVvSYSoMeF2agaH
	oYZhKqoY52DmakL50jQd6m2/yglmz7jFMlOfb1Fkp857u0gNyDDC7nM4JWJruvfdv0jeriKjfa2
	lPpH4wOFM7oR1si9TLhh8N+xC3MTED0KkF/uMSIyOUiqj8BB0olBRsojpciT8aG+kt8MgCSk2YV
	xZOxWo1r54vs/QReZFJKHimuM6w=
X-Received: by 2002:a17:903:1ac6:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2cee169252cmr6840345ad.7.1784047164981; Tue, 14 Jul 2026
 09:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707034019.241762-1-irogers@google.com>
In-Reply-To: <20260707034019.241762-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 Jul 2026 09:39:13 -0700
X-Gm-Features: AUfX_mwsovP05k79U93RtnVIkEHFoZ9-uJl1mYMf19KT9pk1Ohjo33KExtXs3nA
Message-ID: <CAP-5=fUgh+wZVnPU4ZjvYmhHRpNChx4ScWN=pkBGDKwUdCgv6w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf jevents: Deterministic build fix and mypy cleanliness
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:40=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Nazar Kazakov reported non-deterministic builds due to the metrics
> being reordered in the jevents.py output. Fix by sorting metrics on
> more than just their name.
>
> Checking the code with mypy showed a large range of type warnings. Fix
> by largely adding asserts that values aren't None and by adding type
> annotations.

Ping. There's Sashiko feedback on patch 1:
https://sashiko.dev/#/patchset/20260707034019.241762-1-irogers%40google.com
but it basically says that having a metric name with no metric
expression will cause a crash, which is expected behavior.

Nazar, it would be great if you could provide a Tested-by tag :-)

Thanks,
Ian

> Ian Rogers (3):
>   perf jevents: Add more components to the metric sorting order
>   perf jevents: Add python type annotations
>   perf jevents metric: Add python type annotations
>
>  tools/perf/pmu-events/jevents.py | 82 +++++++++++++++++++-------------
>  tools/perf/pmu-events/metric.py  | 23 +++++----
>  2 files changed, 62 insertions(+), 43 deletions(-)
>
> --
> 2.55.0.795.g602f6c329a-goog
>
