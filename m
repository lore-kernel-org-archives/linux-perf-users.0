Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8E1A6811
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974585; cv=pass; b=bdUXJkN0w2ZNxE77qIE+b4sIx6gDrqHt82cETymN1Mjd/0mR6r67Q4VVsGs++ntDDd0gZqknbYBi994Q0jD52MOy28yVI7KPYcK+u69hk+w3U423CJtapsdxyMpG51205NVE25XQ3TEmeZKZqL8Ykmu3or3fctHCJjW6n6y3Jr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974585; c=relaxed/simple;
	bh=WPUmmPGbPc3cI5r5Nmf5R3eObvEc9Qq58fWQgd+JvgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALZLu1BmZqPNg9umQp+z7BgW/sxaLF8tIAYI6DLtIAWwJGvX0K6oKFhMceHBQMyOk59r8fJYJ9kFrVFok+2ij1wA5WVqpsG+ZBAz+y5BzwsF06Xh1uCAh3trNBwwjPLCQnvtZ0DCuD3UXO9pCjxJRutObbdvoxaiHL+kPCp3+6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESh54kIX; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESh54kIX"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10e86e52so57651cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 17:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785974576; cv=none;
        d=google.com; s=arc-20260327;
        b=V1KDRWLYtqbGlDStwXG78einVhCOUFBVwG2uYw0IMAK16Mq+HbVzTpmlzCeUUqZK0/
         DE76u06kmQKIzl9NqYsHOb4b/fS2wdhl4LWcPwsN2XQ02lQ5Rh2c2XzkliBQ1AwxDAcH
         QHIze6SRScGRTlnVis1uDKn0tXOklnwTUpaLEGoqNDaERv0RsqtDinwJZHEWBrk+c46f
         c/lJ7VS5+xCIml43/DkaYKINKGlO61FuZB9so0bee0uHFFAI+Faxl2xtGQbm4i3gMr+t
         TLlYbuW525/aMZrNvXt+4NpHPN3EexMR8I8h2ovg4npNJp2G8SlpTG0QaCX3qxe9pw+7
         /ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VVt/o+L4LAjHR8RdGfwDCIK3OadXwqlv4q2CaRGCUCg=;
        fh=Gb9h+W6gHQ8qQueDUdlMo5LznvChAQuWCOr4LtqNI/g=;
        b=p/uM7lJwFHKx+fAFI7z+QtIrzQZ2red9NrFhZiSASlujEX+38KQ2etOVvr1kxHKpup
         GLNkd5wEItDSQiMe6NioL7XGmNlAkYOzj6o4hOksy35CPoKZTXBrolJEFL1NWdesXvGV
         5Lcyl8WzswcDHk6TIs2TuQz2+DZBQQGHstnli+cRCmBHw7iPqKiZDrfHB2q9vRzPZ2+0
         TZkNG9EQOuEoqA1ZvAAFrSCNbw6llYHzM5rur8L1enopvDF1PbR4uP01ZvkVX39AdOVS
         HCxFSsEMTYhQtDhEGr7K5hw5IJmCw6K+nxskFqSpZt2oDgsBQah6nf5MYC/oZTB44ij6
         zYMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785974576; x=1786579376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VVt/o+L4LAjHR8RdGfwDCIK3OadXwqlv4q2CaRGCUCg=;
        b=ESh54kIX3TVaz0W4C2zQVsr5ojdVmnviFoBlGgUrVn6/cj+Wpv8q5mshVNAGKGx+s2
         S6K50NeC2ja2C3Zq+dpOtlQ+0e3Hi87jcGhUIN2Jas72Q1iEz8fdq3AR6HHXmejUm1nY
         6XkmRQzQr7Qyy5hNuyLaNlmFeYhCCbFqBJcS4XgNX25IhKMlEehkk5BVmq1LLeGeKJDp
         E3I3q2CDMTKvJtLGgyDCYBz5Pgqt+mWbJ6u5O/5+kAhVdWtBvzZnUG82jp/v7j/ZWwXT
         +ZchAls+ZXuqnR+AU6tTir5J24PO7loSjkTMIYrDux0WUgQDPUd/f6sQ0fhV87myqdPv
         t2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974576; x=1786579376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVt/o+L4LAjHR8RdGfwDCIK3OadXwqlv4q2CaRGCUCg=;
        b=Y3N/O116g+w99sQacgVCsohtkTM+yAYAykQRpPSv22O+n0sy1fK8xIhfJ70kTn77eR
         NgfVKvHLcqD/NZypcPnlJL+BOpKfe9A05WYg0v8Khk/ALQ/53AMD6M15YJ9hmvryrjKL
         Y12xn/6H3w+Il5gcKDVudWRhtTUDQrp2nCToXfB14DbCHKchHj3XVCYynITtvBMZseO7
         QaOIzBKGMMEq5Lynexx3aFuRQbwLUaZDkKunCarbjcAkr10y7NKt7khMZ1vxlxphVo/8
         iEAnkQhqZweH8RLml8ZHFU7bsSFU73m0Ii8J5Uk65cDw0IurJRaslGCSNsM3TdFKRomn
         17oA==
X-Forwarded-Encrypted: i=1; AHgh+RrdeQh57fwhArtd6B2XzKnXZLzaFwbVEAnTeeRtYy1J80IfS/vMJ8BMS6V2nh6B/K9nj8GXW4JgYUVcqA8hN70F@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9BezAw0up2oZWKi7zP2FzeqsR+zT+s4TU2Uyfx9fJTqwI89ov
	o46oQN1Ok+5HMYceaW6vplqZkDqrW8SBmtN3rZEVLslTGhouIqdUirYmYSHZDRd78fxDOqKO6D9
	VqFqMIWp3wOfTuBttKyCZF6zB9Ii6Fb3Q1A/XtQW5
X-Gm-Gg: AR+sD12z/tXGzCqbui9wdizC0axCmoVlZtL43oWiW4Ba8P/13A0uCjY+w3umU0bq5bz
	IZTBAFxZ0mS2b1fq40NRLdTnHCkQmTCbj61NBgTdgQX3mg8ty55IVB5ic8lleFMY1n3uKKU83vM
	nFGBFaKUqW52X5WX4WUn3oulvm46bDK4dgoI+jamA/tze2nYvY4CIAUnmsJt2f8n1VtWvwQdkv5
	fVd/01mQo0pD9tS43OYpjvS7pb7DpRjq2vrxKBjFo7OaVvBZ6Fwzyo/xmRzQiiffWvYb0i2wtQ0
	Z1ic2xcPnIA28fOLiZqg3ej+wITTxaIlabyDqxA3MimrnQ==
X-Received: by 2002:ac8:594c:0:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52cfbf2957cmr7411311cf.6.1785974575897; Wed, 05 Aug 2026
 17:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151043.237233-1-acme@kernel.org> <20260805151043.237233-3-acme@kernel.org>
In-Reply-To: <20260805151043.237233-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 17:02:44 -0700
X-Gm-Features: AUfX_mwRNPwcgD_O84tAJfPczzv62ANNy6qeZmA33QTmilHG_EI-Lca49Z6TWpU
Message-ID: <CAP-5=fWt=s5yMPHAsfAszqzpjz4CVUQb7gu4d+cVBp13T_AkUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf c2c: Clean up registered formats on
 c2c_hists__init() and c2c_hists__reinit() failure
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:11=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> When c2c_hists__init() or c2c_hists__reinit() calls hpp_list__parse()
> and it fails partway through, format structures registered via
> perf_hpp_list__column_register() and perf_hpp_list__register_sort_field()
> are left on the hpp_list.
>
> In c2c_hists__init(), only one of the callers, c2c_he__alloc_hists(),
> handled this with perf_hpp__reset_output_field(), while perf_c2c_report()
> did not, leaking the partially registered entries.
>
> In c2c_hists__reinit(), neither perf_c2c_report() nor resort_cl_cb()
> clean up on failure.
>
> Fix by adding cleanup inside both functions themselves, so all callers
> are protected, and remove the now redundant reset in c2c_he__alloc_hists(=
).
>
> Fixes: 78b275437873 ("perf c2c report: Add sample processing")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Assisted-by: Opencode:mimo-v2.5-free
> Assisted-by: Opencode:DeepSeek-V4-Flash-free
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-c2c.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 160b82694d391c50..bc16a57e092742ad 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -229,7 +229,6 @@ he__get_c2c_hists(struct hist_entry *he,
>
>         ret =3D c2c_hists__init(hists, sort, nr_header_lines, env);
>         if (ret) {
> -               perf_hpp__reset_output_field(&hists->list);
>                 c2c_he->hists =3D NULL;
>                 free(hists);
>                 return NULL;
> @@ -2147,6 +2146,8 @@ static int c2c_hists__init(struct c2c_hists *hists,
>                            int nr_header_lines,
>                            struct perf_env *env)
>  {
> +       int ret;
> +
>         __hists__init(&hists->hists, &hists->list);
>
>         /*
> @@ -2159,7 +2160,13 @@ static int c2c_hists__init(struct c2c_hists *hists=
,
>         /* Overload number of header lines.*/
>         hists->list.nr_header_lines =3D nr_header_lines;
>
> -       return hpp_list__parse(&hists->list, /*output=3D*/NULL, sort, env=
);
> +       ret =3D hpp_list__parse(&hists->list, /*output=3D*/NULL, sort, en=
v);
> +
> +       /* Unregister any formats added before the failure point */
> +       if (ret)
> +               perf_hpp__reset_output_field(&hists->list);
> +
> +       return ret;
>  }
>
>  static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
> @@ -2167,8 +2174,16 @@ static int c2c_hists__reinit(struct c2c_hists *c2c=
_hists,
>                              const char *sort,
>                              struct perf_env *env)
>  {
> +       int ret;
> +
>         perf_hpp__reset_output_field(&c2c_hists->list);
> -       return hpp_list__parse(&c2c_hists->list, output, sort, env);
> +       ret =3D hpp_list__parse(&c2c_hists->list, output, sort, env);
> +
> +       /* Unregister any formats added before the failure point */
> +       if (ret)
> +               perf_hpp__reset_output_field(&c2c_hists->list);
> +
> +       return ret;
>  }
>
>  #define DISPLAY_LINE_LIMIT  0.001
> --
> 2.55.0
>
