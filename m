Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D9255E5D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382096; cv=none; b=ryIKYvuI0NkJO7qUE/QBQpfI6vgUbGmxJHRDSaPn8MtVzevxPfRLE4P01MuML0I/SliPKkQe5/+9zvvEJPjqvk5yyyl/gRizJHa6ZgWXFEqnMkcr+wokvD0/tWVIx4YBlLcQZXOROkDIozsM3Y5ysE3MdPN1SSZBrDltHPYDN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382096; c=relaxed/simple;
	bh=2ifwWhQTxxQiW7dj498V1n5a4KBtNGzB0N41R6fK8oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOQg7/sYiFqyuEd1rG5ym2V/dDgiQINp76V0bvOZq+267Fa4l+0Pbaqi4YMiETW/OXvKZoW6GcmbprxlsQhU4Z7DhrJX7G1FqTD8xg189PzeZeA2ZxtUzORuSB5UkOU/xywwPxVzTlwFVnOZfsZHEwTLRtJd4onAxc2WAu+ExCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kklk7Pgl; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kklk7Pgl"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d146357fb2so189275ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739382093; x=1739986893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeXd2qd1PEvqx/l3JSlPWtr5yCxb0WRCNQDPWgVQ0Kk=;
        b=Kklk7PglehriuVyW/wG5Wk6V+0GWHzQEn0TTCli9NrI680U4VpyTTRzcYRW7cXm73l
         GBgOENUiFcE33Q7osH2CtoKQaTrkE8UhNgeTsC0hcCst3mpKI0D6C6O8Wn1INZonRl5k
         UnT8we9NpQZOx8+eY+SiYxFcPsNGkBpjS2/5vhZ7QBxAOWdUU+Xx6AhyDMijTZflgpCt
         g9Ex9qQBwc+Vmqo9gQDTa5/sYu4uYxjYR5km6bClQBv2092DMS6FmLtd/q+bT0B64T7q
         7Q0cDWfo7ogPLpInaYHK8dK4ASW48WUbCngFmgo6wKDmK052JTL5HOXD2ZtslJA6Xivu
         6uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382093; x=1739986893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeXd2qd1PEvqx/l3JSlPWtr5yCxb0WRCNQDPWgVQ0Kk=;
        b=sgRaagT/+a39MFGIFJuan2Vd0BSx891O1fui1DAQ9hi2DJ70dQVDA94Jd3AXGrnRzM
         ovwLIooSu5GWhaC8g3fvqO431yiEpK+TVoQPXEzCXaxfCuE9QZttx/q7a+h/raK5kF3b
         8xlGScZ/EoIXh1GL+Ba3NEysTgkhI1RlsiBwjdDilqpRL7sHv/nvzQNsXzDFItMXnZx9
         JvNBmCVK6NxPFXOYWwLD6yBqNcye3kzcOdHq2nDz+7QZORsMsFcwnx57/Tvs+jB9PA4r
         qpk4NsUHcrcN21zanafBbt1dVz7t3khZzB9n751yuQ0SqwMzHDczhN7Lc0lDu35UPEmJ
         bhjw==
X-Gm-Message-State: AOJu0YwHWHAQHc0JfiElNKjSHj/ZGfV71mFvY7qBsWzivlGkuDnwe+2D
	uaUfgbCzp0FYh5Mc6F6lIWgvFmAXFmuBjpj11R/mvIh04wIO96TswHof8Y4I+EPGL8e4qb4o5cj
	M+bSIK51XOwG3NtSyFGdtqhOKLjH8WLaeTYzY
X-Gm-Gg: ASbGnctreoI1yvrJ5mALItcp16xad+b7LdPB4lzQgQEGgJPqF3hI9Ps1WKH1v9JcX+A
	axViBQ3bXBNxVlv1Y3Hy7QCVgBOJkUlaz7/xdGscL5qG8q7YWj29AA8N2nSUMtrNfKOhMfoBADw
	TbFEDa2Fraxa6lH8Evv+2qvsH2
X-Google-Smtp-Source: AGHT+IG6ln2ls+6Cio1iDB94DvtDvdxN8J57O1VI0o2VYwaNeyMhRXZUVRYHBe/f6/+RK/lgkCetQ560EYq3lA0BMRc=
X-Received: by 2002:a05:6e02:2188:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3d17dd35fa4mr3758535ab.3.1739382093504; Wed, 12 Feb 2025
 09:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212163859.1489916-1-james.clark@linaro.org>
In-Reply-To: <20250212163859.1489916-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 09:41:21 -0800
X-Gm-Features: AWEUYZlS7lomJpvNC0yKKIVS8FncUi7vMJdQti4JegYHkMOW8jnx6mWsb9BSOQo
Message-ID: <CAP-5=fWG8vkKypjJe5SZoPTsRpjG8WpgcAHcji9ipyFnkG2X=Q@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Fix Tool PMU test segfault
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 8:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> tool_pmu__event_to_str() now handles skipped events by returning NULL,
> so it's wrong to re-check for a skip on the resulting string. Calling
> tool_pmu__skip_event() with a NULL string results in a segfault so
> remove the unnecessary skip to fix it:
>
>   $ perf test -vv "parsing with PMU name"
>
>   12.2: Parsing with PMU name:
>   ...
>   ---- unexpected signal (11) ----
>   12.2: Parsing with PMU name         : FAILED!
>
> Fixes: ee8aef2d2321 ("perf tools: Add skip check in tool_pmu__event_to_st=
r()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Thanks James, I'd assumed this had been covered by Kan and Namhyung.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/tool_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> index 187942b749b7..1e900ef92e37 100644
> --- a/tools/perf/tests/tool_pmu.c
> +++ b/tools/perf/tests/tool_pmu.c
> @@ -27,7 +27,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pm=
u)
>         parse_events_error__init(&err);
>         ret =3D parse_events(evlist, str, &err);
>         if (ret) {
> -               if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> +               if (!tool_pmu__event_to_str(ev)) {
>                         ret =3D TEST_OK;
>                         goto out;
>                 }
> @@ -59,7 +59,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pm=
u)
>                 }
>         }
>
> -       if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) =
{
> +       if (!found && tool_pmu__event_to_str(ev)) {
>                 pr_debug("FAILED %s:%d Didn't find tool event '%s' in par=
sed evsels\n",
>                          __FILE__, __LINE__, str);
>                 ret =3D TEST_FAIL;
> --
> 2.34.1
>
