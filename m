Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DE219F2
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rb45NIwH"
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03282D67
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 07:50:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so15466a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699890610; x=1700495410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuk3UTwDW/yoy9m5RFJx2zCUvzj2frFN4dnCSnzxK50=;
        b=rb45NIwHw64eYtT6BBC47TRDxFOyVDNn5ysCVfRaRC3GFAsCseVdCSpAN0CUlGJuw7
         PMxfBefKjHxDM8T8D1ctGOSEMGl6rHbx7M3EIs7+Wh4W3hrOlufzRnQxku336UImwmU2
         mtIEUu+/hbLHGkpzrx299YYhMMa6dylqZ9BTpaxWmjCRUlhfyliEPsFszfk+E1Nj7cO9
         NEUjb8sDPctgL6Q5DSVt/ZHdY2oPLLJ7ubNMLy8IF/nXvEGuYb91jrS9XWU4y1v6yUHY
         hQNSRpg5QfoV5vFhSzSpcoJpV3+CJ8Tm9g8LEwDccXob05v0a8TPprEWU9ygCTTW1mtF
         5kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890610; x=1700495410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yuk3UTwDW/yoy9m5RFJx2zCUvzj2frFN4dnCSnzxK50=;
        b=G972Wx1VKhmwuwuHymNhhE1VCJx7cXKM0bTc5u38/q/uAvPRtN28Y0k7MsgSy/ada/
         Dstyt/gAglm4GaLtiOpLWNTiAoM52AJ1Me6fO0mjP0BdPLEuYz1HmmJM+kbtyujNHN4p
         Uzirygh4ouYAl90m+qFCpzlROm3RylLe5GFIj2vMXzHV5g77rEwQL+9q1kmfXCt2yJjM
         G7MlpKOl8I0K8LruEeZllU80+Ue62w60r6XmNgBYQCuywbtMBbe51r9o8yI3FMLPB+i3
         LHJdV7cwv3QuPETMByqSXYaAGt8rU02IIXJI9vOxID9jbUPyPM8AiPQKtXQ3hl69ju0K
         j7lA==
X-Gm-Message-State: AOJu0YwtESOTkFfqBJ+tsMypU3M0lcoEYO/b3cusz12GEQptzu8sCNZ4
	YvMHmodW2uZyg/6yFtrgfNnkigNB/S9AR5SrccR38L53ZElCzHTMdOGKz6qU
X-Google-Smtp-Source: AGHT+IHCqeGgKNsciaP/v0NjPqyimy8DoFYlasks4ATIasY1CXD7O1EuquDbi006FB2VbJf/GuDiCeeCGphgS0Jh1c4=
X-Received: by 2002:a05:6402:b90:b0:544:e2b8:ba6a with SMTP id
 cf16-20020a0564020b9000b00544e2b8ba6amr125391edb.3.1699890610302; Mon, 13 Nov
 2023 07:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109164007.2037721-1-kan.liang@linux.intel.com>
In-Reply-To: <20231109164007.2037721-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Nov 2023 07:49:56 -0800
Message-ID: <CAP-5=fXGavfHvSPs5dRWmS93gspj4uUE6ftd855xFyN-hKRTzg@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Ignore the non-group case for branch counters
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	tinghao.zhang@intel.com, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 8:41=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The perf test 27: Sample parsing fails with the branch counters support
> introduced.
>
> The branch counters feature requires all the events to belong to a
> group. There is no problem with the normal perf usage which usually
> initializes an evlist even for a single evsel.
> But the perf test is special, which may not initialize an evlist. The
> Sample parsing test case is one of the examples. The existing code
> crashes with the !evsel->evlist.
>
> Non-group means the evsel doesn't have branch counters support.

Thanks Kan, do we need to add this condition to
parse_events__sort_events_and_fix_groups?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.c#n2174

Ian

> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Closes: https://lore.kernel.org/lkml/ZUv+G+w5EvJgQS45@kernel.org/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 58a9b8c82790..7a6a2d1f96db 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2355,6 +2355,10 @@ static inline bool evsel__has_branch_counters(cons=
t struct evsel *evsel)
>  {
>         struct evsel *cur, *leader =3D evsel__leader(evsel);
>
> +       /* The branch counters feature only supports group */
> +       if (!leader || !evsel->evlist)
> +               return false;
> +
>         evlist__for_each_entry(evsel->evlist, cur) {
>                 if ((leader =3D=3D evsel__leader(cur)) &&
>                     (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRAN=
CH_COUNTERS))
> --
> 2.35.1
>
