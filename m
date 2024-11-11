Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75018A6BD
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347145; cv=none; b=eWT/HA4x7TfQsDtv2SYu59fWdfyjpvuRWJyuOqxJpAmy9M4w2b6VkH8RL6PLPXiMvzf+0fvJNZUM60csGWFhLhyNy5TTCiH84p7hsTIM8h496bLsBk6ODo3UfWqHMF/FtHeEfkK8C2LEWnVPXml/O+Pgx2jj7sGXQkhCH2bUAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347145; c=relaxed/simple;
	bh=0iMwnOCaNUckqNYwj9IxWml8cDp9NfqP6DyiJCASkVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+g4Jt4vsl1A6+I641DIOzOfWDh4wtwwwFPobbhq83+JZgbXvQK6J2kkJLGmzBRAeDs5Q1NWKKq+WvXv9NbIvOcoR5MRbVKTzEg0toOxYeIZG7xjQTyBMMAoSKM4+vcawN0d3BKmb7wEA9vqbTo3SA0hVL5JnbqIeHp5V8eIuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRYxMzbq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRYxMzbq"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso2075ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347143; x=1731951943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CttvC4iXIitG/QjHtPIpONj7j8KiFKM1bMpkt+sN7a8=;
        b=kRYxMzbqbeFNysJ35lkb14L7ZgJjFiybRkm1AIBu4XfkQvRFYgkBWpynSvUfiPf1pF
         RE+KKVNCVnQNxf0fni7sE/x0JUrQONoKmYDeGy/tcU1GmP41fn0AHiLGItvM9dEYQfVF
         dI9QN6gBejcHI9xRzfcJNHU0Z0WZiQCG9KautOdY6nHcLaEdy1n9j3dCk196k38kPSj0
         6TTgHu1835WLldE653QdRcXmG7bSge8tqNeFlyVUE40+FzURZGFFA7Y5yvfBTGvZGXtq
         9va/4bNfBr4dpQV3sD+xNFKESkLet1zdAxWpWBWbMFsVxadbfF8Hgcecbzsh+9i5/jxs
         pfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347143; x=1731951943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CttvC4iXIitG/QjHtPIpONj7j8KiFKM1bMpkt+sN7a8=;
        b=mlyXHNNRXqi3R+bokRNFhbto9ctM5CEnNPLE8ghBd329LFqhdrPmQoPiJTDBmjzaCZ
         zqm4st6Pu4M7NDig3f2lYFmsu08T6rxyGNBBpnrZKFdzis4zT4op54SXpYn8vEJObTWy
         vZp+YzlT+db1+WmLxWlBJOnkIw/5ad/l6rzhkxz1gU+IlfK8DfMFCxJCwDO7gBHCy/tN
         hmeUxi+IpPbg29c2wr9Xkw4FOtNWSxhK9Y8cPrxjNceL57QNV0iXaaEVZmN1suUxStYc
         HAXlbJbO24YiWEWn/PGup+Vd2pp3NZmuV8W9hqSUh5pmkkqBETvvT2vTYLxl9MprbuCk
         mEXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzt857zzyJMsYvU1MGB8e+P2Onqjuy6X6UsaJxczJcLdMJdWJZQ9j/M6rZpX8v+Qibnb/cNprNNGs2KsD6sgap@vger.kernel.org
X-Gm-Message-State: AOJu0YyC2b3xrUKAOuM4AvA0zEMIbokyXebjhdRIGdHSy/WKfXXL+o8V
	ddKZZXEvqIBW4X/CuDUPuyY0MV8Q/aVazJs3zNJZ0ek74KzqkqOVlvFSkefiRmvMSRF3AUmL1rX
	NQgR4ACvqk2KGKbnlM0NpZXc3+kOEM3xSimmR
X-Gm-Gg: ASbGncsSA3yGW9RjHoMPv8zJykscLDVy5Tyw2a/OMZC77JUk3yrJ5ApUMz5egRm2WsW
	rLbJGz7VN3s7cvwangQvfMEL4tsEM8T5zbFNHLf3VOnyZE2XRzm1s7Evd+qA/xew=
X-Google-Smtp-Source: AGHT+IFFV9mLRnwjUKkTdCz6BKlhqJ1vaYTtYzUC0x+E/M8lH7Sim7BDXEmAO4pMMzkgPM3dJsnkE5+nBf3LjPjq8a8=
X-Received: by 2002:a05:6e02:1a6d:b0:39e:68d8:2891 with SMTP id
 e9e14a558f8ab-3a6f8a0618emr9043415ab.6.1731347143054; Mon, 11 Nov 2024
 09:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-4-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-4-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:45:31 -0800
Message-ID: <CAP-5=fW4pKRdmiQ5J4mdzVfXgKpnzHxHWooSktp5xsy68FQKaA@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] perf record --off-cpu: Parse off-cpu event
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
> Parse the off-cpu event using parse_event, as bpf-output.
>
> no-inherit is should be set to 1, here's the reason:

nit: s/is should be/should be/

> We update the BPF perf_event map for direct off-cpu sample dumping (in
> following patches), it executes as follows:
>
> bpf_map_update_value()
>  bpf_fd_array_map_update_elem()
>   perf_event_fd_array_get_ptr()
>    perf_event_read_local()
>
> In perf_event_read_local(), there is:
>
> int perf_event_read_local(struct perf_event *event, u64 *value,
>                           u64 *enabled, u64 *running)
> {
> ...
>         /*
>          * It must not be an event with inherit set, we cannot read
>          * all child counters from atomic context.
>          */
>         if (event->attr.inherit) {
>                 ret =3D -EOPNOTSUPP;
>                 goto out;
>         }
>
> Which means no-inherit has to be true for updating the BPF perf_event
> map.
>
> Moreover, for bpf-output events, we primarily want a system-wide event
> instead of a per-task event.
>
> The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
> index to retrieve the perf_event file descriptor it outputs to.
>
> Making a bpf-output event system-wide naturally satisfies this
> requirement by mapping CPU appropriately.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index a590a8ac1f9d..558c5e5c2dc3 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -38,32 +38,21 @@ union off_cpu_data {
>
>  static int off_cpu_config(struct evlist *evlist)
>  {
> +       char off_cpu_event[64];
>         struct evsel *evsel;
> -       struct perf_event_attr attr =3D {
> -               .type   =3D PERF_TYPE_SOFTWARE,
> -               .config =3D PERF_COUNT_SW_BPF_OUTPUT,
> -               .size   =3D sizeof(attr), /* to capture ABI version */
> -       };
> -       char *evname =3D strdup(OFFCPU_EVENT);
> -
> -       if (evname =3D=3D NULL)
> -               return -ENOMEM;
>
> -       evsel =3D evsel__new(&attr);
> -       if (!evsel) {
> -               free(evname);
> -               return -ENOMEM;
> +       scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-in=
herit=3D1,name=3D%s/", OFFCPU_EVENT);
> +       if (parse_event(evlist, off_cpu_event)) {
> +               pr_err("Failed to open off-cpu event\n");
> +               return -1;

Woot, love this! Much happier to see parse_events being used than hand
crafted attributes. This will help us keep things synchronized via
event parsing.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>         }
>
> -       evsel->core.attr.freq =3D 1;
> -       evsel->core.attr.sample_period =3D 1;
> -       /* off-cpu analysis depends on stack trace */
> -       evsel->core.attr.sample_type =3D PERF_SAMPLE_CALLCHAIN;
> -
> -       evlist__add(evlist, evsel);
> -
> -       free(evsel->name);
> -       evsel->name =3D evname;
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__is_offcpu_event(evsel)) {
> +                       evsel->core.system_wide =3D true;
> +                       break;
> +               }
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>
