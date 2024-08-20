Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCE17FE;
	Tue, 20 Aug 2024 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120509; cv=none; b=E5IuU7/E76w4Zxlyn/7aFhWkJAwkOh6fKVEHaZ+kd0PzfXPn1WekNkB+kaC02hGLbzmXuZi5ZZWwi3ZpOMc4cXv6ZrwC1zs3T4N50rpZOVst7Ptzq8pJft+GmQDJ1lhcMZxd0HInQ1biTyvKZk1PZ2kNY16rG7dPQkvzJM8pGHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120509; c=relaxed/simple;
	bh=0KoJq1vnleQkjfw+raHEDEEh7XnWFx/CNYgQoGSnhE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYy0x0rqy3xkkbp3UbMwV/UKQPoFuSSeRuU6CFgGZ5I8uBLi6GLGlCOZLnWvatD8M1Szeh1YAG9jO/cD7ZaGQSShUI4M0zRIOjodUssN9fYjdCg7T3IHQYxBaj2FJi3E/h2XDs7Vw2TumkH1x/0KxMEGLyKXiIW3bmHh+FMWgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so3388645a12.1;
        Mon, 19 Aug 2024 19:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724120507; x=1724725307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9VpRDPJmjSGP8qOZ+q4FIyaOEMrL3Rjqjqn/PBRJ/E=;
        b=byC2giI46hQR/QBH8TPoGN4rvriY89LxWHrnIYJAFxgn56h9P/DfTdVPbH9LaU+a5G
         nO8+y4UhE5yQnq0eqcRrGooFwRab20o+k0BiKNPYNXV4O90GbQ1AU6fdYxbGZQtt7zP8
         nqVAHlULsWSqWJjuriRjGb0rZMdW8x2obsxGM1HnmKedrY7zwRYZRo+6MBTP+jbQt6tL
         h5+wlOKtPseiZaRUtX9O1pNis4nILpFOqCzIwGZkrFGutCEjNusxriTpW3whiJxktIvc
         B724R/6HcLgDjwN0RZFv21pIsR/B6M0zvvjsyhfyc8x2gRfEY0fJ5rnEvcNBpM7sdadA
         4SiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZDpWrk/3E0Jxak8qq8SbBsN1i2JlwwpUKNfi4hBwFnf4Xcwwq6UGhC4zG/ifinNqhqoFV2iyaBXFpzkczELkoehCfjJAjru3juV3j7aqXsvoWl/Z0nog7Qfo1Z3FGcAd1AFQobpI+aznyfAI6jw==
X-Gm-Message-State: AOJu0YwhTDHDsJmFQ2YtadOUj9ONMCHaKKtiLMHYkiFhpNjIpsMhJUo6
	43B59nj0DnYecWmlDTqjzPWUZkWv9THWWA8bg0DHoELZdhJ117YRnF5us3DLK1s7agRea1kp8VO
	sccGfEJEMFEi4Rc+WV3Mi2nM0WjDw+FuR
X-Google-Smtp-Source: AGHT+IG4fKHu+ReRVMk6yBrShF7fzgg2ODdng5yINhFql1Z1crMf89WP4nUPVJQGmz8Jmu2jZnGIHCy8bi6gxT7UDeE=
X-Received: by 2002:a17:90a:9a92:b0:2c8:ea7b:8891 with SMTP id
 98e67ed59e1d1-2d3e00f2f60mr11505827a91.29.1724120506616; Mon, 19 Aug 2024
 19:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819233603.54941-1-namhyung@kernel.org> <CA+JHD93fa33YL_AHL9RfxUOoBm+hw8zHbk13BU4qD8B3p4KHug@mail.gmail.com>
In-Reply-To: <CA+JHD93fa33YL_AHL9RfxUOoBm+hw8zHbk13BU4qD8B3p4KHug@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 19 Aug 2024 19:21:34 -0700
Message-ID: <CAM9d7cjLvS5BUO_AEkfR3LsT8SNB8MCt-DTHCiRDrZyQxhySoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf annotate-data: Show offset and size in hex
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:12=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Mon, Aug 19, 2024, 8:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>>
>> It'd be better to have them in hex to check cacheline alignment.
>>
>>
> Why is it better? To compare with the usual output of some other tool?
>
> Spelling out reasons helps reviewers/users.

Cache line sizes are power of 2 so it'd be natural to use hex and
check whether an offset is in the same boundary.  Also perf annotate
shows instruction offsets in hex.

>
> Maybe this should be selectable?

I can add an option and/or a config if you want.

Thanks,
Namhyung

>>
>>
>
>>  Percent     offset       size  field
>>   100.00          0      0x1c0  struct cfs_rq    {
>>     0.00          0       0x10      struct load_weight  load {
>>     0.00          0        0x8          long unsigned int       weight;
>>     0.00        0x8        0x4          u32     inv_weight;
>>                                     };
>>     0.00       0x10        0x4      unsigned int        nr_running;
>>    14.56       0x14        0x4      unsigned int        h_nr_running;
>>     0.00       0x18        0x4      unsigned int        idle_nr_running;
>>     0.00       0x1c        0x4      unsigned int        idle_h_nr_runnin=
g;
>>   ...
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  tools/perf/ui/browsers/annotate-data.c | 4 ++--
>>  tools/perf/util/annotate-data.c        | 2 +-
>>  tools/perf/util/sort.c                 | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/brow=
sers/annotate-data.c
>> index f563a3bb072c..cd562a8822b7 100644
>> --- a/tools/perf/ui/browsers/annotate-data.c
>> +++ b/tools/perf/ui/browsers/annotate-data.c
>> @@ -427,12 +427,12 @@ static void browser__write(struct ui_browser *uib,=
 void *entry, int row)
>>
>>         /* print type info */
>>         if (be->indent =3D=3D 0 && !member->var_name) {
>> -               ui_browser__printf(uib, " %10d %10d  %s%s",
>> +               ui_browser__printf(uib, " %#10x %#10x  %s%s",
>>                                    member->offset, member->size,
>>                                    member->type_name,
>>                                    list_empty(&member->children) || be->=
folded? ";" : " {");
>>         } else {
>> -               ui_browser__printf(uib, " %10d %10d  %*s%s\t%s%s",
>> +               ui_browser__printf(uib, " %#10x %#10x  %*s%s\t%s%s",
>>                                    member->offset, member->size,
>>                                    be->indent * 4, "", member->type_name=
,
>>                                    member->var_name ?: "",
>> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-=
data.c
>> index aa330c7d8edd..25105b3b9a13 100644
>> --- a/tools/perf/util/annotate-data.c
>> +++ b/tools/perf/util/annotate-data.c
>> @@ -1660,7 +1660,7 @@ static void print_annotated_data_type(struct annot=
ated_data_type *mem_type,
>>                 nr_events++;
>>         }
>>
>> -       printf(" %10d %10d  %*s%s\t%s",
>> +       printf(" %#10x %#10x  %*s%s\t%s",
>>                member->offset, member->size, indent, "", member->type_na=
me,
>>                member->var_name ?: "");
>>
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index c4046d5d1749..d315308f9170 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -2312,7 +2312,7 @@ static int hist_entry__typeoff_snprintf(struct his=
t_entry *he, char *bf,
>>                                  he->mem_type_off, true);
>>         buf[4095] =3D '\0';
>>
>> -       return repsep_snprintf(bf, size, "%s %+d (%s)", he_type->self.ty=
pe_name,
>> +       return repsep_snprintf(bf, size, "%s +%#x (%s)", he_type->self.t=
ype_name,
>>                                he->mem_type_off, buf);
>>  }
>>
>> --
>> 2.46.0.184.g6999bdac58-goog
>>
>>
