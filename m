Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BE1798F
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483273; cv=none; b=oCNxQtpUmYWmH5jtneQWk80zGyrmGAb8GaDc3NHJyLEWJnQRPyFTmROZw4YZhYydbjVA0Uib2j9ej+eKdpv+ejxbPXvKiE9f2eZDlBHwiSb21dIx5UgaljzfMooKHti3AQJr0u2JWeKoKFlVfmVNjQ6vy/FQVaonYPLtNtL7HYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483273; c=relaxed/simple;
	bh=qFEUHjYFyVbDhNvjgUDJOz711mZJCKiTyV+OT2JsO2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNsUjPMNgH3ExlWWRqWrROGZ9/0/P5WSy88mZdIEnBaH5NzzmKsy2E8WZgwM3zM2ny8rFNuBHi2u0H6pclooaJ07j6gjDlbgn6Vv6m4iw4nvx+A2cuevqqMGn5TKTmT0DEDB8kvciXX7ZRQiY6ywzXcroZYxuu4z72MMWMCsZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2lrcLtH; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2lrcLtH"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a814c54742so37785ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 16:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734483271; x=1735088071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvpdmlnbvNyjwHZf76pbDfjmJncAJiI50qIYmlkFWhs=;
        b=G2lrcLtHoNxdC0KsVOv46UDh5pfwEJgMdLPc72rj5COGyH1pJ/9J9VkG8j9qL9cSbO
         QdsLMwo2H9yKWyy25jgDSGInmL6Kird+QWaXRGJs11RLPjqsLfoVsBLtZIFrahHks5ze
         v3HABMVCkDbpAviAXLu2ENr5eaE2/dTG68ckChb4e60htzU47X0fwW0Sh4ryeM6psKcZ
         Q9rkMTDp5qhNAxOYl3VtUT0tcdYpKnuThzsl7i073HSb74qTo7X519Sx1rOMrrWt2M7k
         yzsE/qNMss1JkhHaVGZRcQBujTJdYj0NxxoRMandQPTPk9QEyux1H+ajxYYfP1i/LRIc
         Meig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483271; x=1735088071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvpdmlnbvNyjwHZf76pbDfjmJncAJiI50qIYmlkFWhs=;
        b=PQZdMPPbZNRVA6LyntCS93Av19zD4RtVmAJJvw7gGP3Auy8w81Yw+fucDwrZhY/eHJ
         /ZnNl6TCsj5KNGl+S/DvppYjK4ZuCYYk+gK77KrZ3/SSlvkeLW9LNQyiNxmu1VyMVEUi
         Hxsr7rRte2GI/BJu+VCzJ99F+s1/5xkzQZuRfzq86FI009YROAkbgjC4BrtGi0Htk2QE
         0nTux//W1FRfkN548Z18FN5c8z3aglpAjpkulfQAWice+fZt9fA7Yca4Cx9KgHIA9mFZ
         HQLhkeTT89ID9RMiaSPErj3E28zzJs2Xe+sdV9xdG71wdolBnCPAI3yRwjGcYYhUjb4Z
         1AVA==
X-Forwarded-Encrypted: i=1; AJvYcCXtmuCHF61n7pA3YmOPKBqVzX8Slto0qtY9cMQ5xXXIimOlt8M+7x0p7gHHVkGh93MtdqBjeB/ybay17NbS0ZI/@vger.kernel.org
X-Gm-Message-State: AOJu0YzlISqyJx1cuZ0AOiG/o6rKPw3YoGsSsVAO2i5+r04jD7bZMq6r
	yYt6FQrlsoGAIkMvkLE6D0YWIlkrVElCWoYSpUmU/OKUI41TsHDdiaQV9MQYwy4r3ZYvrShXden
	a4Aan1+UeWpQofq6kSZG2uuVJpjiUbdKDNdtV
X-Gm-Gg: ASbGncsjgGjXllWaq+r77eafCzsxM5rzGvtsRKPKzdmBPn7DaKy5GxubncTNoFUTyV1
	GbNQWzL32wF/ecNqgvmTQnRH+0jcVqvjPTTFATWU=
X-Google-Smtp-Source: AGHT+IEoTRmSrfTLob8bBnU0BLl9Mr4cn15d1XMTSUV5F1B2wnA9XXGqLTQNrwEm5b7QOJKp0qMAP56nopgrXwZmSjc=
X-Received: by 2002:a05:6e02:3c88:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3be34c58afamr427125ab.5.1734483271260; Tue, 17 Dec 2024
 16:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217115610.371755-1-james.clark@linaro.org> <20241217115610.371755-6-james.clark@linaro.org>
In-Reply-To: <20241217115610.371755-6-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Dec 2024 16:54:19 -0800
Message-ID: <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:56=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Document the flag, hint what it's used for and give an example with
> other useful options to get minimal output.
>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Docum=
entation/perf-arm-spe.txt
> index de2b0b479249..588eead438bc 100644
> --- a/tools/perf/Documentation/perf-arm-spe.txt
> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> @@ -150,6 +150,7 @@ arm_spe/load_filter=3D1,min_latency=3D10/'
>    pct_enable=3D1        - collect physical timestamp instead of virtual =
timestamp (PMSCR.PCT) - requires privilege
>    store_filter=3D1      - collect stores only (PMSFCR.ST)
>    ts_enable=3D1         - enable timestamping with value of generic time=
r (PMSCR.TS)
> +  discard=3D1           - enable SPE PMU events but don't collect sample=
 data - see 'Discard mode' (PMBLIMITR.FM =3D DISCARD)
>
>  +++*+++ Latency is the total latency from the point at which sampling st=
arted on that instruction, rather
>  than only the execution latency.
> @@ -220,6 +221,16 @@ Common errors
>
>     Increase sampling interval (see above)
>
> +Discard mode
> +~~~~~~~~~~~~
> +
> +SPE PMU events can be used without the overhead of collecting sample dat=
a if
> +discard mode is supported (optional from Armv8.6). First run a system wi=
de SPE
> +session (or on the core of interest) using options to minimize output. T=
hen run
> +perf stat:
> +
> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/nu=
ll &
> +  perf stat -e SAMPLE_FEED_LD

Perhaps clarify this should be an ARM SPE event? It seems strange to
have one perf command affect a later one, the purpose of things like
event multiplexing is to hide the hardware limits. I'd prefer if the
last bit was like:
```
Then run perf stat with an SPE event on the same PMU:

perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
perf stat -e arm_spe/SAMPLE_FEED_LD/
``

Thanks,
Ian
