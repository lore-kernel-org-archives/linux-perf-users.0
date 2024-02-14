Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4513EFF6
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946942; cv=none; b=asNRQHw27MGYukOJv37c37MMlGBrRMaxWOg3a5XcqwJkqPciLsqwXi9CyIsfIVE1c0ulqnu3SUSGAzH6IlCaaW1pe3fY/yCm1abCzRd/fpUtwcVxTTyJeKRJ372FVULdmAeIYQvQpXoM3mvsRicGZpJJ0OWIjPI8KkgZL6u3U88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946942; c=relaxed/simple;
	bh=3c2GIuuOcUIlF/1ZcnXuHB65jZ0swkmR0K4YPD0mw0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dubfytPD46W7+WhRRCbM2RktWk/XicMND7NUSJaYlU2TnSuv/6blsV1JUm+uS0/06LnGforTez0O7Ot6jF98a92MpUz20CsqLNy3yeWB94ZAgmu8oUiQVCQRgL1iYb/92W2SGu4F6UFXpyZIZA5LC8GTuC2w7kjyDpOF4DS5nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6uHT5gz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6uHT5gz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1db61f7ebcbso11825ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946940; x=1708551740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSPUubyM84iE4if7k7+oIKp95nXKMAdaOOfobzF3zB0=;
        b=R6uHT5gzBOPIvhY3BIQChUvPniZgQLgKUpwTFUCoIl3oB8tNk/I8MRw7xEotb/zX0Q
         mkCKfJvW6/CkNOr6ro5+yNc/3XkVUWwgLoZz1S34kpvmABHW++0L18t4pnFs/c3J0436
         LGw3hg5+bzkpTOU3yxnjtOD/YSOBwG9oujJTsjs36QtHPu1c2nfGLQPLPzDBkwgSIcxy
         T/sv5YRoHIsci8PFiw972IlTW7CImJiBemDGZAqi5n1zbXgh9y/PBQqHhAXQlxx9GmnL
         DCdBnD0peYQBYSuVYkIdiS6equEuFxJrSrPY9AFEAcSw8YDrxOUq5vXNzdPO7X8pECXf
         DEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946940; x=1708551740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSPUubyM84iE4if7k7+oIKp95nXKMAdaOOfobzF3zB0=;
        b=n8CMgpKRUIG4ejAdHZhQJEXU7KE5f00Ehd2VngINCmTCtX6lhz908l5A3BHSc9eQeA
         +BhP62oWTRrQ6QelNgq/9Hah6AwASUF5XWMMTxJpey8qgiiOqb+A1JQUrMI06IYPh8yW
         w8tCUwzhs/9Ct1TcWjxhWA9+JOpDJJJs5NuR/D/y0yExIr3glVpk4YbOayUrhM2wP0za
         AaYA6aO6ePBY9Qp6AFlNyo2CMhDar9AlNJPBBnfgmbUyH9WxeE4Zk/Q2+DDk/o+EWl9A
         doNTI+tGvD7JhiYOIIC975PTRtFDc2cl2zHs3fC2QJlEAkWhXiv6sux0iucM5b3bWyJw
         /dFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZaHdQTqA/I2mk3HDqn1bkIPO3bmsJQB9WRosszyqH5InhymoOEnNPXPHtxWUhe+gm84r72+eFYoWgSn2kOeCAdh3/S04jcoeWj1VdmpvcXQ==
X-Gm-Message-State: AOJu0YzTR4nCP6ovMI/Ue4Cp/QjKGVRF5vZBJl/QAMfdwlAw9NzcMVQR
	QW3WItX+KJtk3kzQvXLD4uRGY+STV2+XogXszerNd98v7nLMWD5kPU1o7B0so6iaC+20iP/rztF
	yxG1cwwW01O2kdcgj49Yl7Io5vbcr70AFxcuF
X-Google-Smtp-Source: AGHT+IFs8GCOC1Z1vNjMOHZlsyycKXE6lDJY0f+bDQxt7tw86T7dQdf0yTj1R5o+IbfIUHdOmfrLkolaVuy4fv1aNEY=
X-Received: by 2002:a17:902:7b94:b0:1d8:d90d:c9ae with SMTP id
 w20-20020a1709027b9400b001d8d90dc9aemr335917pll.1.1707946940434; Wed, 14 Feb
 2024 13:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1> <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
 <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com> <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
In-Reply-To: <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 13:42:09 -0800
Message-ID: <CAP-5=fUP-Ss1UNKWUwzSpWAO1trCdXNMkey1gYnpZPODn+Gn-Q@mail.gmail.com>
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

On Wed, Feb 14, 2024 at 1:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 14, 2024 at 1:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, Feb 14, 2024 at 10:27=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Wed, Feb 14, 2024 at 9:25=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > > > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > > > threads") made the iteration of thread tids unordered. The perf t=
race
> > > > > --summary output sorts and prints each hash bucket, rather than a=
ll
> > > > > threads globally. Change this behavior by turn all threads into a
> > > > > list, sort the list by number of trace events then by tids, final=
ly
> > > > > print the list. This also allows the rbtree in threads to be not
> > > > > accessed outside of machine.
> > > >
> > > > Can you please provide a refresh of the output that is changed by y=
our patch?
> > >
> > > Hmm.. looks like perf trace record has broken and doesn't produce
> > > output in newer perfs. It works on 6.5 and so a bisect is necessary.
> >
> > Bisect result:
> > ```
> > 9925495d96efc14d885ba66c5696f664fe0e663c is the first bad commit
> > commit 9925495d96efc14d885ba66c5696f664fe0e663c
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Thu Sep 14 14:19:45 2023 -0700
> >
> >    perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> > ...
> > https://lore.kernel.org/r/20230914211948.814999-3-irogers@google.com
> > ```
> >
> > Now to do the bisect with BUILD_BPF_SKEL=3D1 on each make.
>
> This looks better (how could I be at fault :-) ):
> ```
> 1836480429d173c01664a633b61e525b13d41a2a is the first bad commit
> commit 1836480429d173c01664a633b61e525b13d41a2a
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Aug 16 13:53:26 2023 -0300
>
>    perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter
> using &=3D sizeof(saddr)
> ...
>    Cc: Adrian Hunter <adrian.hunter@intel.com>
>    Cc: Ian Rogers <irogers@google.com>
>    Cc: Jiri Olsa <jolsa@kernel.org>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ```
> No LKML link.

Hmm.. basically that change fixed the BPF program to verify and so the
problem has been long standing with the BPF code. Maybe perf trace
record never worked with BPF.

Thanks,
Ian
