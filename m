Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0EA248881
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154544; cv=none; b=CDs+C95RXsjY7Yz7aka8rEkPqZ7hHGWVy8Iheyyu/K+zQRqehkglRNaU2Ki2SHwqAMvbZkCQ67AbsXi137CpK4XEaBySaf5H03hxtEwH4aBqu7eQMicJZhtIA8Yn8dUX9aLafqlaQxefBvJjLPbaRn3wgwZGWOC/C9eUCBOiwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154544; c=relaxed/simple;
	bh=OeYsXJHQWtxs6tEUpSeDYsW0KMnpfQr4qcQTxRMcz64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rl1pDzVI6wGoV3JjjYi5QItgvL237dHHWdsk7One0UAHkyyAJpQ+HEpaQOfcHVmG1BlulCzs/eJOHuRgWvvfltjZtiMZFaivHssLXcaTIdqINoIl47vqRETLM2xBHRmvl+Vh0cqtwKlBy8MVI5RjgT9Y+8pELOPSWuhtFj9MHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+3zvCEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+3zvCEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE6EC2BCB3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776154544;
	bh=OeYsXJHQWtxs6tEUpSeDYsW0KMnpfQr4qcQTxRMcz64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i+3zvCEQ/AWXDptmogbKPQPzNxJwe0UiC3lrkNmqzb9HkJkJLLf0WsiXGyL9iM71F
	 EjsvZf0hnQFzdjYfO3f5jtYxYPoEoTfXp563op3LaGQoL/JmTXjnRQ7jGVyEeZEmNU
	 4G9UkWkVo2SzbBf1EoEpyITpce8V23rrxgkG9wpKwc6WVmEqBZ6u702g65J1mXwGuZ
	 2ManWlwoge3xnNLiq8tnR1mkxvYlqrKOpnw6qecCy1ZINzcUMOAy97kJTLMEL+MAcp
	 IZlgVbnvrC9DO/4e27EbduxApEmBHfP+AagflkCkX7rQbo9eCANwnaZDjaNXpuiusa
	 CnoxIxVpGTWDA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331786dso612514666b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 01:15:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+chxbwhETvjAtgSo0UHz/S03mQPjae1lpSA7mwfY6kptRL7LysBkZjRftKjXIJbEuAC+Ha9zX3FpTGHngtj1ZR@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKkbNeM+n+9v836x+TOCDvcNTgeoVBmsGI6MsbjCfbJPn6Y0B
	WBnjlitS/4D/Lv5GjT324kBiYXhBKmGOR8SJmA3xuWF6lOa/t7aZFlkv+hzpq4+1pDhSRRX5GOg
	CMbN+fWSQ/Tk1l9iA1T6xlY6r4i06JpE=
X-Received: by 2002:a17:907:a0d3:b0:b98:132e:ca97 with SMTP id
 a640c23a62f3a-b9d72815099mr999030066b.47.1776154543033; Tue, 14 Apr 2026
 01:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414080424.320060-1-r@hev.cc>
In-Reply-To: <20260414080424.320060-1-r@hev.cc>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 Apr 2026 16:15:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7J=q=U7sb=d3BMGHUSW=UBm5uEH4BRen3DxUx_OF92yw@mail.gmail.com>
X-Gm-Features: AQROBzD5JAvOOgnJ0fwbJEL_jdDFzBWuM7mu8W9TrFlJlkkXtWDNGOCrh6qxqs4
Message-ID: <CAAhV-H7J=q=U7sb=d3BMGHUSW=UBm5uEH4BRen3DxUx_OF92yw@mail.gmail.com>
Subject: Re: [PATCH] perf loongarch: Fix discarded-qualifiers warning in _get_field()
To: WANG Rui <r@hev.cc>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Haiyong Sun <sunhaiyong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:04=E2=80=AFPM WANG Rui <r@hev.cc> wrote:
>
> From: Haiyong Sun <sunhaiyong@loongson.cn>
>
> arch/loongarch/util/header.c: In function =E2=80=98_get_field=E2=80=99:
> arch/loongarch/util/header.c:31:15: warning: assignment discards =E2=80=
=98const=E2=80=99
> qualifier from pointer target type
> arch/loongarch/util/header.c:36:12: warning: assignment discards =E2=80=
=98const=E2=80=99
> qualifier from pointer target type
>
> Signed-off-by: Haiyong Sun <sunhaiyong@loongson.cn>
> Signed-off-by: WANG Rui <r@hev.cc>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

> ---
>  tools/perf/arch/loongarch/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/lo=
ongarch/util/header.c
> index 0c6d82333..46f53a74f 100644
> --- a/tools/perf/arch/loongarch/util/header.c
> +++ b/tools/perf/arch/loongarch/util/header.c
> @@ -26,7 +26,7 @@
>
>  static char *_get_field(const char *line)
>  {
> -       char *line2, *nl;
> +       const char *line2, *nl;
>
>         line2 =3D strrchr(line, ' ');
>         if (!line2)
> --
> 2.53.0
>
>
