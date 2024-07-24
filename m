Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823ED15F3E2
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847118; cv=none; b=eIjWSi9Wxp9bszvqeCPCONZoZmjjctGExE02bemOIFexk6OCR7Y2LUhiJ0tUJHLHM4NerWFVR41lrE6MdW6ny8gXr095iLKkSdF6E1GVc/Xn+uQ1ISHGItIkFqY238Aqw+GqdQcwhydRaCq57OobBdwbj+jot2cw/Z6A07k2ZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847118; c=relaxed/simple;
	bh=Vw0A4MYZooitJHp244OZC2CuDx0yGD1T9A4YrRNm+Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMaxElzB9ZpXPZB94ijPT2TOwG9WnJbox0Zc7O1XxqSfhHmF+LBry7YPgbXFAimDZTqHX6K1lM/ZweOyIRPzRTJbuCGZbtTgPCXUmHQl4fKtgJP+u//IgDpHEq1eshreUzhxBx7w6gVFh8BbeM4ojODnlKKMaNrlkVPY/kM3B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JLr9JSHG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JLr9JSHG"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso122219a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721847116; x=1722451916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz1re8hEAbdCbg6+d0sgG9QoSqWm1jEP+6/Po7xO6nU=;
        b=JLr9JSHGtbmReoQIz7sX7UZ4i/eNH0hRsitoP36Ua3CmhBZYaOGrvlMX18lsWypMDw
         pdZuhnevEvvhGzWjzwk695IGslShlOIuSew0DHDB5J5ej17ig75uUkqsJ4AN2DlYoYaF
         Jj9lufdlirYtAoagV1mpaWH45ep09Rd5xcLS5uCEpNaXVqWUg7+5JeL6JsA6l0FLo4Gr
         wVCacrQTFeexFLmvNpC+ooV06NleDiaKhQ2tAI+ex1IQU8YXF2nSo1WOa6OhTWzRrSq/
         JeNodE88W+XaI56ZB6AP8aTlDunVgLsTKPUZAiHBqizEmoB4HxHxQDuC8KSnkH8FKqKS
         nF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847116; x=1722451916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz1re8hEAbdCbg6+d0sgG9QoSqWm1jEP+6/Po7xO6nU=;
        b=q4RrdwKzVn6k7Tu6A1z8cyhrfusoiFgppIrtVR08XC6uqgTU5GeK500AzHzLXAL3UV
         n/Lr6bCqgt90buG1nM6rx30cBF+lqkTgmBPPeif2YI/urh8m9vJQDLVnfoE4/by+M0GH
         oHpUlbrKoVRrMxeAKbA4r+NERQRqnYOD8Ubq/UmjDQYzTXGZgyMGklWqGY6K7opUp6BB
         3dgEa0AwFcJa67l/BTh6KHf5Wn2u25YU6MwCNLhMhPLkd6pdHTHynvqgOGHvs0JL08nz
         l2VcWo7fE3cYo2Bv5ugpr/pzznJFcmOYkr1rsVGi6HHPOFXawD7iCJ1jjgGwUcII3F+5
         KR9Q==
X-Gm-Message-State: AOJu0YxZZ40+flwI0DKUA33LIKIG6z0K7w97dLz/B3KkciTfgUTX6R5G
	s5EoRlWE23c4CGmDHzoPpd1gB28nJHUzNHBeR2wHbbHAwh2W0qDEsSFUNEixcTDirYRXLLSaCBM
	VpV8/jiaeDM3d3BtEhkGKcRr073+mMh5BSvziZ0YMa8lNyNWIVYI=
X-Google-Smtp-Source: AGHT+IEyCelTG43l+W5jC+9ilBM0QfFfNBPW0/hrkNF7fQyxMWOTtBHDhstpigm0TORwlyXxWQJr+rn6iwBWnW10gIA=
X-Received: by 2002:a17:90a:f486:b0:2c9:7849:4e28 with SMTP id
 98e67ed59e1d1-2cf23901745mr513948a91.27.1721847115671; Wed, 24 Jul 2024
 11:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722211548.61455-1-cachen@purestorage.com>
 <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com> <CAM9d7cj20KdEtg8v93+bt+ZmpTzin=N3DfAX3K8ELHLkccoeqQ@mail.gmail.com>
In-Reply-To: <CAM9d7cj20KdEtg8v93+bt+ZmpTzin=N3DfAX3K8ELHLkccoeqQ@mail.gmail.com>
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 24 Jul 2024 11:51:44 -0700
Message-ID: <CALCePG3sqCCJyRaUOiE0TqDCGmOdw7B38hBzs9PvF5EgPjU8EA@mail.gmail.com>
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:19=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Jul 23, 2024 at 6:01=E2=80=AFPM Casey Chen <cachen@purestorage.co=
m> wrote:
> >
> > Ian / Namhyung,
> >
> > Could you take a look at the latest diff PATCHv5 ?
> >
> > Thanks,
> > Casey
> >
> > On Mon, Jul 22, 2024 at 2:15=E2=80=AFPM Casey Chen <cachen@purestorage.=
com> wrote:
> > >
> > > With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"=
),
> > > when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> > > thread__find_map() could return with al->maps being NULL.
> > >
> > > The path below could add a callchain_cursor_node with NULL ms.maps.
> > >
> > > add_callchain_ip()
> > >   thread__find_symbol(.., &al)
> > >     thread__find_map(.., &al)   // al->maps becomes NULL
> > >   ms.maps =3D maps__get(al.maps)
> > >   callchain_cursor_append(..., &ms, ...)
> > >     node->ms.maps =3D maps__get(ms->maps)
> > >
> > > Then the path below would dereference NULL maps and get segfault.
> > >
> > > fill_callchain_info()
> > >   maps__machine(node->ms.maps);
> > >
> > > Fix it by checking if maps is NULL in fill_callchain_info().
> > >
> > > Signed-off-by: Casey Chen <cachen@purestorage.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
>
> > > ---
> > >  tools/perf/util/callchain.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.=
c
> > > index 1730b852a947..6d075648d2cc 100644
> > > --- a/tools/perf/util/callchain.c
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_en=
try *he, struct perf_sample *samp
> > >  int fill_callchain_info(struct addr_location *al, struct callchain_c=
ursor_node *node,
> > >                         bool hide_unresolved)
> > >  {
> > > -       struct machine *machine =3D maps__machine(node->ms.maps);
> > > +       struct machine *machine =3D node->ms.maps ? maps__machine(nod=
e->ms.maps) : NULL;
> > >
> > >         maps__put(al->maps);
> > >         al->maps =3D maps__get(node->ms.maps);
> > > --
> > > 2.45.2
> > >

Thanks Namhyung.
I have another question. When will this patch get merged into master
branch or 6.6 release line ? Our benchmark systems depend on this fix
to do performance analysis. Currently, both our kernel and perf are on
6.6.9 and they build separately. We want to update perf hash without
patching it locally.

Casey
