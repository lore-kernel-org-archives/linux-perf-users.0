Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F01420DD
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783489; cv=none; b=C6FGLxr1E42wjlbSIgPPwFoYOeqlom+USHCPqoJ1lY/KDfvY/wlyxnVDOksz6Ai6g7NK/aGkZ4dpzqfvj0gPVAAtuEMtCEIJSXGYAU55SHXa+NlSOos/xFfIj/W9681BTPUsbK7U+sgbmmAdHWNlF/sfytmqYkmDa8UP6IYWBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783489; c=relaxed/simple;
	bh=scTRRdLYljPzOCHnoN0wzeR+bN014q89J6h1+HuAKGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDepLYR58Ezgor4GRknasvG5uTDxBXCqTOFZDNuqoXcnYL9IhiqPThASRmK93RC3qJYEc0ZCAhYbPGqgjQ7oLs/rgcNIDhcMY+LIlZPOAbABkTN7CaDmadPSREgbDYdwr6nG1bmuvYPig20bDUq9jZW3ZBIbvR9dzJCcYDJZS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWAuNNJK; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWAuNNJK"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so340665ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 07:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736783487; x=1737388287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INZ0B6iBklDeX2F+5IYxEoS6jrTc6xAI91JQU5/uctI=;
        b=HWAuNNJKY80otnldwysL2mCaGHMtqIzFqdMaz09a3Ls3DPS6sfw8lXBXwPa6rMlha7
         M64+iB2U062S1RQDUmWA5qSdg8zH9Wp2E1zGuylwv72wKWmll1fy5O9YB/3UOsT1wYxk
         tevTJ9AI62c5N3h9dHmp/LUZtE7RlWRYFqjcj8MBYyY10R/R1vmTGIjXADU7BJkac13b
         TIvBNCVKz5Jzp/qtm7ILUuEhu+B3cunloZ8EoLQGDb3CX3ExVDz+lPzXNmnHrYsWzFJU
         d4V0M1V0m05X/J3XCfj0uRC3yHZm5n/bFn60oErQftcq0WSPpT1m2wY3nsTBd+ITxWUa
         8muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783487; x=1737388287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INZ0B6iBklDeX2F+5IYxEoS6jrTc6xAI91JQU5/uctI=;
        b=u9PHSmET2DEJJjfsGbBFGsTMwEXVnMYXJJ/GIHr3EGV1q4EcVJ4LD7+XqWfvm8Frii
         s0FtaU4g33a88DNdMrKSUDTAiJQzbbpnXyLFJdCULB3AyQXd/6SxXtgL9OpzgURtd0DF
         YR9wPIMq8zUpXwShO+5qRmIs+/Va1VO6U5Wb9kMwTE8W3GvI9m9HTCn3Hca5klFtyyJR
         hyFVRYYtQdsWitUGiZWPXQfxDGBtganOJz4WmM9YO/jCOcSf/rmvAYj7rzlPBIS+ShYO
         /7YFvsz77e5O4IVhRGiE+YHW5KjwhK36y2z513/tWMliPOQUASBwwqmDzUacA3D8HmmF
         YcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZBGZn2NBh0s4DqTNRN/8z8YpRrQTJS0xwc4CoLJDDTe45VhSTrLhfdLroYBi+PT803O9ZjivIQ7aiu3NiZFPP@vger.kernel.org
X-Gm-Message-State: AOJu0YxSw/ihXe/jbS7lXit57/BXUJQW/LWEuFsxXz6iVaa6nDpAmB62
	4tcGPSthtJFKt2mGtR0gPcOfFXOBorA+d/+Fot5FurGFjCBlbtc48NhfzhTSe7iiSacBFYGgvzt
	DgLiRKeMD8dhJFebSLklOO0gSC+Xp3yyTJkI3
X-Gm-Gg: ASbGncscZKxohivEK+OR8u3xlbqYEg4jhPkTpQPFHP4MlUM57rJYEsURKKGe4icnGwU
	iaUzqMD7ak728fAiBJFcbPMCvHj+FVOmtoAJI0R7iI0yQoZdY5cXN3PSezM7J8y49VNuZkw==
X-Google-Smtp-Source: AGHT+IFz8DLc5V3tpQN5NvmsIMT92IiGQbP2/vAb0j4DorUhoh9QalNbZkYCxgWQ1g7pdxxS+Ai2nY25JT8YyPyej/Y=
X-Received: by 2002:a05:6e02:20c6:b0:3a7:df79:71b3 with SMTP id
 e9e14a558f8ab-3ce589396d5mr9241005ab.19.1736783487009; Mon, 13 Jan 2025
 07:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110172006.680753-1-irogers@google.com> <da5792c3-8f53-4be8-8f53-e1cf6660feab@linaro.org>
In-Reply-To: <da5792c3-8f53-4be8-8f53-e1cf6660feab@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Jan 2025 07:51:15 -0800
X-Gm-Features: AbW1kvYBgR1Ge8kRNpf5x-KRRsTH8l00xG8qTvKhzBXVQx8QamgOWcH3rbBgrMk
Message-ID: <CAP-5=fXyVtZChi1fkochiyKw6AztdhEE_rfpJUsz_P9po5bhXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf vendor events arm64: Add N3 events/metrics
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, Nick Forrington <nick.forrington@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 4:35=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 10/01/2025 5:20 pm, Ian Rogers wrote:
> > Using the scripts at:
> > https://gitlab.arm.com/telemetry-solution/telemetry-solution/
> >
> > Generate perf json for neoverse-n3 using the following command:
> > ```
> > $ telemetry-solution/tools/perf_json_generator/generate.py \
> >    tools/perf/ --telemetry-files \
> >    telemetry-solution/data/pmu/cpu/neoverse/neoverse-n3.json:neoverse-n=
3
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   .../arm64/arm/neoverse-n3/core-imp-def.json   | 930 +++++++++++++++++=
+
>
> I assume you got warnings about missing groups, if one is missing that
> results in everything being dumped in core-imp-def.json. I have an
> internal ticket open about it which is why I didn't post N3 and V3 jsons
> yet, I'll check on it again.

I was testing with JEVENTS_ARCH=3Dall. I'm not sure what the group
warning is, do you have a link?

> Up to you whether you want to continue with it like this and I can send
> a fix up later but there's also a conflict with the recent Fujitsu
> Monaka events.

I'm happy to let you push the updates. An alternative, that may work
around the group issue, is just to push the event updates. Any chance
on an ETA?

Thanks,
Ian
