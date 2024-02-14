Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405013EFFF
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946620; cv=none; b=QjxDxn1Lij5vle2YRhY27OW3FeaMzfcvODFOegPJkbwrgSz98mo20Kg4denemuijca7syGXiTN98OGRt5GESvxgvjFC628TVhfw4lBTNTV8qeF4l5Ro4VesaCMZEAyDU76kxL/A7MiqfhhboKcl+pkwOTm76AGqmG+kpRcdjUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946620; c=relaxed/simple;
	bh=8NTIdvfdUShCf6KiTT4xVJr3A6EVG7UAZSouPXwWvFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMahB8y1IzfFT4LtpZlgDhGtkmZNhby+4+tNBDX0VtEcP/Qk1jpI9MtyX9EuGSKO0ELYICPGQVBw4esuyCzXNhPMRwN+xxLzP7qqHKvm0M/SyPNxRl+Bh+fydYwXspWOdTgFQEixSBiBz/eHd+qeDEepmZdLNR5cGDkFZxi+FNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zZUZLQkh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zZUZLQkh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db61f7ebcbso11115ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 13:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946618; x=1708551418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm+3lAjNKCUXMK2MWRX3aA9k1EZES8aqndD5uWRzKz4=;
        b=zZUZLQkhf/CogbGFIeK5zRCFwghXNPXzycZM/MtAFgXa2PlMR9+LHRRjTejEL82o66
         1/CDPdgLTmdv5u+cpLtgUWKmFSIvGUYm2r1PxSmRTMmDIuBQq3G94PHMGpsITbCs1x48
         YMg1/EDTJ3Xd2zJSevQ6zG1byffgP2NXyiOadttSROhU+dVeqBS1vj4nE1lDr/A2T8bE
         GNwpGCtwesf6t4pENX0FH6QGoW2hGYmsJgcYltE2/VpsjWolzEKrC+5CHa4UnjOKEVSV
         MutFRk1jW68cx4gfnTZQAAmEUxVpqihr5uuzUSGROC1ttOqnO/IAHgfNebtmgsAE3aNW
         ZKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946618; x=1708551418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm+3lAjNKCUXMK2MWRX3aA9k1EZES8aqndD5uWRzKz4=;
        b=ov1+dYlnNO1ujSG2TvuXQJc9sEMF+arAVvhhHBv0TFY8tF8jZ0A7IdeQ9uJeiNkieW
         Sw8jmav5apy9pSNpIs1ff5wm3zhmL1o4Jc7PRKmk9aO1I43XDGKDI8Y2DjpoQI2CIkx5
         dNLgGdXvn62q5+p/zV52AMU79lUc9Xk9j54n/o1QpLCwNqcPw9UzcuS5W98TvB6SKjPO
         +1gDgr4L/+dXAtxC/UnXuICti29iyXJKHZcCD7oi3FDE9VTUu4Iis/m41OuulGyI15mb
         /vlhTBMvYCg4hiP5s5hcBb+mTtquzqkv2h+eTM2DPxYiHUNUyjaKT6P7IxFZVuVlSHe8
         clKA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDgXoW4h9bUui3QmQljio41Eib0LFm2xRFKa1W/7vJBAAzCikheM0XCufkOVUeGrL9zZ0Ic5FICIlzaG0OILG8tiOOfuPW4yPKxBD5jDrCw==
X-Gm-Message-State: AOJu0YzgfDXiAEe8f5vzd9BctUvagCiHjakpYAhOGu9YxW6GkFxNJ0qe
	gEP384H8tkrv7KJlYTP1nPbig7lQWtL5oidaGjj2rF6MlAEYvIy5KIXodIP3XYY0Ivr5msaEKh4
	mqerTizgGygnwUj1OK9k47BTZKbW08FyqNr6f
X-Google-Smtp-Source: AGHT+IEGLkc+Vg1BB8RNbFLPcn9sA2EgZUBHfDxP0H0iDn+vMm3xC36CC6KY+0zBUA64/i36/KFEaMcOA8knBoDpJss=
X-Received: by 2002:a17:903:2053:b0:1da:292b:cf94 with SMTP id
 q19-20020a170903205300b001da292bcf94mr397991pla.4.1707946617972; Wed, 14 Feb
 2024 13:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1> <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
 <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 13:36:46 -0800
Message-ID: <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 14, 2024 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Feb 14, 2024 at 9:25=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > > threads") made the iteration of thread tids unordered. The perf tra=
ce
> > > > --summary output sorts and prints each hash bucket, rather than all
> > > > threads globally. Change this behavior by turn all threads into a
> > > > list, sort the list by number of trace events then by tids, finally
> > > > print the list. This also allows the rbtree in threads to be not
> > > > accessed outside of machine.
> > >
> > > Can you please provide a refresh of the output that is changed by you=
r patch?
> >
> > Hmm.. looks like perf trace record has broken and doesn't produce
> > output in newer perfs. It works on 6.5 and so a bisect is necessary.
>
> Bisect result:
> ```
> 9925495d96efc14d885ba66c5696f664fe0e663c is the first bad commit
> commit 9925495d96efc14d885ba66c5696f664fe0e663c
> Author: Ian Rogers <irogers@google.com>
> Date:   Thu Sep 14 14:19:45 2023 -0700
>
>    perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> ...
> https://lore.kernel.org/r/20230914211948.814999-3-irogers@google.com
> ```
>
> Now to do the bisect with BUILD_BPF_SKEL=3D1 on each make.

This looks better (how could I be at fault :-) ):
```
1836480429d173c01664a633b61e525b13d41a2a is the first bad commit
commit 1836480429d173c01664a633b61e525b13d41a2a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Aug 16 13:53:26 2023 -0300

   perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter
using &=3D sizeof(saddr)
...
   Cc: Adrian Hunter <adrian.hunter@intel.com>
   Cc: Ian Rogers <irogers@google.com>
   Cc: Jiri Olsa <jolsa@kernel.org>
   Cc: Namhyung Kim <namhyung@kernel.org>
   Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
```
No LKML link.

Thanks,
Ian
