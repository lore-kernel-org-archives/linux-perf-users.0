Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628D1A38DE
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Mar 2024 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711258016; cv=none; b=DT/smD+FXhZWkN7QHv5qGRs1Di5xdRFWgFtL+hVlKY3vc8AL22TbWkMhf8e1rovIixJ5d17o+yW+9K/e18nD4OPDpdBHivY3LrTVpDMryvqAt4577TLdhvHBjubgvexuveAgncPsqviiPsU65It67xLWV0ehuLg/gsSxBFa7EQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711258016; c=relaxed/simple;
	bh=j079EurHa/3stFGZ/lRDTfWJwJKaoNSnmge157CW+jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5jSDay9s7M7VdSSOBnmf5nLbQnKEkJcLL+kTyPXcaDVDGwC2PrHSUMbAZA63LUgG853HrN12/HBJuZsWExl69gjVTipKh+HWwBstScfTPog07gaSKMCQs4Vb1/CR1Tn3dXG89iY+caycUWEsHEGcF1XQBoiCTNFeDEmnMxWt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=omb7Xomm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omb7Xomm"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430d3fcc511so176691cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Mar 2024 22:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711258014; x=1711862814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN8g/xZoptYVJ5FsfZed15QS7HE6W3eYDa46wXkoQOw=;
        b=omb7XommhwB66mnlrULq4jZ4dtml9VgUz92meYpHGBzDZk6nM0d+8qRAijvqJR3gef
         1+y6n13u2mttmp1Hv90CMGyY0mA0Ua+YU898q5uSP/ksD2q04qRV4V/yzOK8vUWNrmiq
         drA7WXizibgg5uutLX4ZgShfCFDKSrlWTO+czzGezqrav0RLhJh19dz3ZB0v+BiDsYyo
         J1b6xpMfT/4BpmIiGIPZzviJleoi5zDjTamYe4imrVHM8DNHZkPEIm4Igjpkr+n0sjtY
         4i/LdEpuZpq9JT3iaqv1llOadF3nUiNg9sacVrFJy1+7hEUWDmUZcyqi5gOUGfI3D6pC
         f7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711258014; x=1711862814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN8g/xZoptYVJ5FsfZed15QS7HE6W3eYDa46wXkoQOw=;
        b=Jjm74u+5XvgWOlfO+YPghsVN4pQ4NDESz6PoCk8+kiPqW9aFw7hBkTQZQNDtJ99sHh
         Y76f5U7PE91+Er225141uympFk8wKxyddPls5qKs8b55+rEB1aCg8zvYfb/RQ7rWlzpa
         JpTQMAE1eJgRshDlKMNcDo4ikjzb4Z/tbRYLz4UwzTKjJvWOgBFWsKuwdOfEU0xsW15r
         a28Aj9TV1c2v1u9e7XM3lj0t2V8aNZDyqPOTTAI15wlqM7eYFPgTNhI+3v0kCKsEXP38
         MxFxWQG2KbyPmbmFfIPAFAk5PYYpJAUl2itFHXMFLqtvhlanUBJahMO9IkiZ5YbHZ2g2
         6j8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzvp/Af3ZRyU+FglS07oliMlJ0JzUZZFPwxShfrGO2yEB5dQWDUQogvaIN4WX+aB2rN/hGa+gN+IqVR3NW99GbtY4y/kgZ1S6UxQTNdTJYMg==
X-Gm-Message-State: AOJu0YwlBD9lcfTt4pc4iBhEAlvmlKEA5ztGiEziKAvSfPfgvT1ydAla
	vccUsxWkqBueC1aujwAaULByxU2m95mpFqepN2RZpNAY/6aHdShBlTrF3zeuSn6v52Q++lmMkK8
	ZDGzlg0BMLd7My0FowVcIAnn8HqvBeoS4g/MS
X-Google-Smtp-Source: AGHT+IHY9kyWE3pD9lQTodwqBCg4s4JbXqjdoB+7slTo1auRAaUk6lay/L+V8Pmbxl6l+zP3Tch5JnLoQLSsgD1azzw=
X-Received: by 2002:a05:622a:8c7:b0:431:3d4d:92ed with SMTP id
 i7-20020a05622a08c700b004313d4d92edmr223747qte.9.1711258014088; Sat, 23 Mar
 2024 22:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-13-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-13-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 22:26:43 -0700
Message-ID: <CAP-5=fW2VFA9fdHiiufrDD011gFHGP6dzdRTV7HT-cBQ0HL5sw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/15] perf stat: Handle NMI in hardware-grouping
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add an easy nmi watchdog support in grouping. When nmi watchdog is enable=
d,
> we reduce the total num of events could be assigned to one group by 1. A
> more efficient solution will be added in later.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 95d3868819e3..f1eb73957765 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1947,6 +1947,10 @@ static int insert_new_group(struct list_head *head=
,
>                            size_t num_fixed_counters)
>  {
>         INIT_LIST_HEAD(&new_group->event_head);
> +       if (sysctl__nmi_watchdog_enabled()) {
> +               pr_debug("NMI watchdog is enabled. Reduce num of counters=
 by 1\n");
> +               num_counters -=3D 1;
> +       }
>         fill_counter_bitmap(new_group->gp_counters, 0, num_counters);
>         fill_counter_bitmap(new_group->fixed_counters, 0, num_fixed_count=
ers);
>         new_group->taken_alone =3D false;
> --
> 2.42.0
>
