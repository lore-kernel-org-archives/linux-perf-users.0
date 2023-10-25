Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221D5253
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 03:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElsKR7XA"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19ED90
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 20:42:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a085efa7so1573e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698205377; x=1698810177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXAzKvkf49LfpHocgTsA1yczF93G8HBB7kCYq64Or4M=;
        b=ElsKR7XA3nVm9Ly+MeOdLL+ijvu82n+x1Dfjth4BBMTB4zAB2wFI56Z/wodh5tSqJp
         2djBEn0I7NKaS054dssYhV074q12LVChvo0rgn0KcQuFIIbA82m+4SWNDTJUC8r7Fah8
         8VFTkoEyuP7Y+NPCUA9h3Z8FPDFpmOzAzRm+pOEvVvWzwV0z19Pq/RnrkUbJ5+/n7yga
         L1uF94iX0XoY7mAfHsKbjcBPfU8n44R8OsYDzS/6xzYYNCswLkR9FPR2xCdTQJwtabHr
         C35DwW11C1Oab8xUvAQWdBYFMLXLJHh33HKObcr6RS6GBxn4yYD15moVmgvIjgcUMRvE
         baDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698205377; x=1698810177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXAzKvkf49LfpHocgTsA1yczF93G8HBB7kCYq64Or4M=;
        b=YU9YuSxYkBL0ul5b74AZ7V2TvhB0WtzW+9oVh5XFCB2DWxvtwKJWVAVFK/63X38/te
         XOI0T3WwcGpkCXNV6ApIEmywoXTQAIg155MN/0eMfoIdj69/giHLHvB+Gw0O7R7llu2Y
         EP2u2n2fwCm1zuDcvTOd9C0GrVpH2AAvVpG3iYJZba/ro1nSuplLvqQ0O3OmYIwt1dL8
         aRkz/X/ZnGPNBwfgausKn7jmqE9iyuZReVWqFalkriudE0qsYs6o8/Md0JCWMjc1WzWX
         yZtpHJ5cv7z42k3xhr/p/Urqz3SRzt1Q2Quu6bCNc9YLDsCpnZ7HcbGXzY4HGTbDPr7A
         4JRA==
X-Gm-Message-State: AOJu0YylBo8uvuIitBCozzqcND6uOmKgtHBrepeIatG2BElXJxbSpCKE
	M/k+LxAcVCq8LcrKmUx4bRV6AXrnbcmww6b6ODJSWw==
X-Google-Smtp-Source: AGHT+IEFMNrtwoxhkIe+lYAjwXLdHAlBdDt6Lt6R23HObFxvKkIQyZ0SLUIDTj7EuektCSsnZ6B3IWNAv2gbzu9fHR0=
X-Received: by 2002:a05:6512:3582:b0:502:932e:2e36 with SMTP id
 m2-20020a056512358200b00502932e2e36mr25286lfr.2.1698205376825; Tue, 24 Oct
 2023 20:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025003121.2811738-1-namhyung@kernel.org>
In-Reply-To: <20231025003121.2811738-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 20:42:45 -0700
Message-ID: <CAP-5=fWnD_Ov+rf6sUxrSqu3MSy_TW+xFdD8gXOkz7nn=fUHkg@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix hierarchy mode on pipe input
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 5:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The hierarchy mode needs to setup output formats for each evsel.
> Normally setup_sorting() handles this at the beginning, but it cannot
> do that if data comes from a pipe since there's no evsel info before
> reading the data.  And then perf report cannot process the samples
> in hierarchy mode and think as if there's no sample.
>
> Let's check the condition and setup the output formats after reading
> data so that it can find evsels.
>
> Before:
>
>   $ ./perf record -o- true | ./perf report -i- --hierarchy -q
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>   Error:
>   The - data has no samples!
>
> After:
>
>   $ ./perf record -o- true | ./perf report -i- --hierarchy -q
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>       94.76%        true
>          94.76%        [kernel.kallsyms]
>             94.76%        [k] filemap_fault
>        5.24%        perf-ex
>           5.24%        [kernel.kallsyms]
>              5.06%        [k] __memset
>              0.18%        [k] native_write_msr
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-report.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dcedfe00f04d..ca8f2331795c 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -691,10 +691,25 @@ static int report__browse_hists(struct report *rep)
>
>  static int report__collapse_hists(struct report *rep)
>  {
> +       struct perf_session *session =3D rep->session;
> +       struct evlist *evlist =3D session->evlist;
>         struct ui_progress prog;
>         struct evsel *pos;
>         int ret =3D 0;
>
> +       /*
> +        * The pipe data needs to setup hierarchy hpp formats now, becaus=
e it
> +        * cannot know about evsels in the data before reading the data. =
 The
> +        * normal file data saves the event (attribute) info in the heade=
r
> +        * section, but pipe does not have the luxury.
> +        */
> +       if (perf_data__is_pipe(session->data)) {
> +               if (perf_hpp__setup_hists_formats(&perf_hpp_list, evlist)=
 < 0) {
> +                       ui__error("Failed to setup hierachy output format=
s\n");
> +                       return -1;
> +               }
> +       }
> +
>         ui_progress__init(&prog, rep->nr_entries, "Merging related events=
...");
>
>         evlist__for_each_entry(rep->session->evlist, pos) {
> --
> 2.42.0.758.gaed0368e0e-goog
>
