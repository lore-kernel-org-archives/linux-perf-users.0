Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014037080B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733769347; cv=none; b=aSWJz3SXs7071D/mconyjm+W+pzbRjvdaLDTJz+4Di6X1mBtzirif39Vp2kDK/ke1jvsjr2uG8J5tntiEV/owKfMPymhhooESK7b4IM16/byGedoNU/5vGzW2atK6QjXe198PL3j/zkHxdkZUh9h36yW8So2XXWtNLND7neDMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733769347; c=relaxed/simple;
	bh=s2crCVGsbkNLHyjtyH5LlpZb9Vc4P1rWIzxahEbDWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CQWF5fw2B0NTqA5JrmLT1pmhwwQIENbSxbMOWC13O1b7Cv3EgHM0I9EQuxV7Lh/emcsJgnQUuWbf1mBMYWJ8L9VgVWFTtumScQqRzjqEhqkQChGgW2c8NMXgwP8S0ikCrSc3uEMwuUqcUvzkn1Jfvq/DknV1k10ARkvw8l1R5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cy9TP8Ym; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cy9TP8Ym"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a814c54742so472775ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733769345; x=1734374145; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clkswUKcnpDHGUyR9SCPANT3dNpNox/exTTbCbmsicA=;
        b=cy9TP8YmWzckPD2+EOiKp0zRhA1vhd4FAsQ24bBWkVdVMbn03OculG1FFLF3ULZ/M0
         xL/sREoshx73f0UUam6qWDzRFU94qMxN8ybN4+LoOmxH1mnjLScHn0k/Hz30V/tloXZ/
         YPLG8M5KS0IUaXhrJrLq5/FyKBXs8aQSic4wF7N3+eL/tTpJtGUZ0/IljYwS3BPZCSLq
         jxN3YZvxiL9IhXwTP/48bjLrGUL7HNBWRebisyCt0Z2mW5zbMOrmvW7nxX+ooSH0ubsk
         bUYfiQKGr4J7AhxfA6VQOAA2jZiUAwsCxiHLtauD/H8efVTzpjRkIRJgbhRrYD/e3wgU
         nl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733769345; x=1734374145;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clkswUKcnpDHGUyR9SCPANT3dNpNox/exTTbCbmsicA=;
        b=aqI6dWIEVQn4Q0T9LzDAHFUV6h5mIK90otUPMOz89Z/m3EjfHK9JpDzm/hsIaa1p3w
         Rx6P1G/Th7AQUVY5pGUOzR4NPI5NH5lKbTF9ZSRvUTiB5Ajf2lbDnqPs0x61dsZrQCj0
         4+itIRSS1urrZqUpIZJ3fhe1/fCS6dS7gxV8w5XgVei8iNm/oGs5NV92z5t7TMXp1C6X
         S3QIOcY21IXdsFeeF+PKselV0jPdJu9st+qsKFiJz8u1B9OToX9oKJ7qPHpZXkw532yu
         SSyBmTBiHkn33fA9SniFOTfqiXRhuHWIxerbbZcTRSxvNXQs7Mn2zVrTGptDpGkMi48p
         pYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvCCcu5ASMfxQBeG7SGy2NxcO9CxbcbW+N4td9voxx7nK4OuJPJdMrAUOxFe1Mc6xz80WItlWZCEzs1Z1DLZBg@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAvQMo1WSdiDbpVP58+uq63twFaVFHk+/yVya2N32xfaAYS60
	6cnRkwERL9cVSbdKuPQL7JAa2HsTSzf50KxVR5poGo04ukWe7XB5paMu/Xrkd6UqzNiL8vOv71m
	gZO7VKdS4rdAV4/wJn2ErOvDuYQV+ONCZs0Uu
X-Gm-Gg: ASbGncuAHiExQaXnvBleaQTfw5xfRbl63rZq8i2XEO/Qu+ycNPKyNMZBWsW8uhq11kM
	UJjuZVWmPpH1BOlzshyjsDou0mmzpBE8a
X-Google-Smtp-Source: AGHT+IH0nETxj3bC6CXrnWVkUCIleHf1QkS1NBVx0YiEYo/SjprKNunQQ2biLtQTgwxMTa06DCdU6zc0mKjwiwuYiwM=
X-Received: by 2002:a05:6e02:3f8b:b0:3a0:a34e:9ab1 with SMTP id
 e9e14a558f8ab-3a9dda2e467mr44285ab.8.1733769345035; Mon, 09 Dec 2024 10:35:45
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com>
In-Reply-To: <20241113165558.628856-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 10:35:34 -0800
Message-ID: <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:56=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> For big string offsets we output comments for what string the offset
> is for. If the string contains a '*/' as seen in Intel Arrowlake event
> descriptions, then this causes C parsing issues for the generated
> pmu-events.c. Catch such '*/' values and escape to avoid this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 6e71b09dbc2a..028cf3c43881 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -430,8 +430,11 @@ class JsonEvent:
>    def to_c_string(self, metric: bool) -> str:
>      """Representation of the event as a C struct initializer."""
>
> +    def fix_comment(s: str) -> str:
> +        return s.replace('*/', '\*\/')
> +
>      s =3D self.build_c_string(metric)
> -    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
> +    return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
>
>
>  @lru_cache(maxsize=3DNone)
> --
> 2.47.0.277.g8800431eea-goog
>
