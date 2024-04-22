Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499F1BC30
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819584; cv=none; b=pqstnbXkRkaCIFfAOn1xW1jtHJiiZrxRcRto2aAPgFv3Wfgh3KvwfgXs8JcK/uni5VAkKOmIbSBbSXmOGQQbxCdPavioUtckuUtDAH+Q0Ff89TK8SXfRtDsaYvt3gzBfqzzsOrqBgCUny45vb+jpahaNPn6APRi1TDWowoDLPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819584; c=relaxed/simple;
	bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaqFE9H7omNELf9XSfaeAwiIE3W40/VR/sFuQfEUovOmD+cPqjbt0LXiAF3Gs1J9se8guRwZQy0RHUJvBUdgboQLTdIZQw4UNPGF6QB/Zmfq1Hl0YDkdNGrkoPcPjYt0ChOYhIGBmZUAmb3t+lucGtE5kk5ufguglFGq2XQeR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbzWU88C; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbzWU88C"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-439b1c72676so39441cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713819582; x=1714424382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
        b=mbzWU88CFNzYso5y3z5u0Y7gx+04dJRwteJm/Hx7ACnQ/V62GydtY5pYvdxn0tJE9j
         J4dazF7HgDQ9euLkxTPEPc+vOF27vdPqiKmzaUnD4onpIlsXIXYOecG5km7ogSX3tjmw
         WXXfnqC6OIKl77hqQHI/Abf42JvRBemo0s9xSgpzrKxqx/kSUTPPJTZDrJ53gAiDKtCJ
         W/2mXwzO6zGIHiOnPAEoKLKAr1STrw46B0RXBM1HDkxwbIi2TRhpXSAXeEpWJi+b90+t
         pF9U6pGLKCCZcrGOOCtiiAU3mE0nyaV/JSh5dHzBchvBsvuUtrHQrpCSVx9Vn86A+mPe
         PVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819582; x=1714424382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DtxLkBqU8o+Vd60v8MnikP8aabry94GM1z7ZjGXJAA=;
        b=XxnHE1tBzWwqrfXSUYgf2X6BqBJ/jR9n6qsTwKIixMHv/6BSIfOWnunoTO6aieKQpc
         kPjI42m8IhJ9yeOU7VcLehrM6BN7oOo3oGyLrEUDgmCGcHc7bJ/u2YeC3Su+cm8oIQRQ
         iE8HEQyRVLqXFay1ZA5beqi0xkNyc8+GMMe9QpaCz2IQAz5yWx7ymvnIiBe9OIqKpNim
         lRkcMYhWck0FXg9AD00agYsyiramZ6kaMV7eU7OusoACIwx6mudt5DiNZIscGVxyfb63
         CdNt2dc31EMIa0vhoSbEgB34kkWqI8VfCt0Orrwz+5acRNUJxZRh3Ifin2GGJdPFExX5
         3d+w==
X-Forwarded-Encrypted: i=1; AJvYcCV6kBCWC/a90gvXEK0p0qOiU3Urp3cUFJbBZzknEIDlNXDS5iFmxGhsMKjQUjqJPEvjqXBJOaJfBR3qE+eOnxiU83i4uUe98oAPI6ZkTMixww==
X-Gm-Message-State: AOJu0Yy5BF6D5pIY/qppmtRh/M5WyoBi/Kys/YwLTiS6AgBzxyKXqkn1
	NkfxDHVMMgRK9svjMWnTar6+D/IvgICSOlKnsh/aVpJMW1U/ZYOjgVCE10VJX32n3kNOoY/6S9q
	j5iHTwTMfmgz+uir5SrUJoDr/fNWDerPspbHo
X-Google-Smtp-Source: AGHT+IFWv3vY24WCXnrPQ0IXbKt//pYLn/SVsr2ulzPtbd7T/FKDLeYs0qIX73iBiD1osziDXA7eh7+i5RjT8f9m8Qw=
X-Received: by 2002:ac8:748f:0:b0:437:6b79:c9ff with SMTP id
 v15-20020ac8748f000000b004376b79c9ffmr83042qtq.10.1713819581839; Mon, 22 Apr
 2024 13:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com> <ZhgvE7i9HGGar1eX@x1>
 <CAM9d7chWBv14hD4huuoas4ncZaziuTnHi_JvieKqrLZF9fDpPw@mail.gmail.com> <ZibOs-_ASLcZrnFa@x1>
In-Reply-To: <ZibOs-_ASLcZrnFa@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Apr 2024 13:59:27 -0700
Message-ID: <CAP-5=fXwkrPuWBTedUxjc=2GyDwPsTA75RAyN+nj4iHSFozRwg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] dso/dsos memory savings and clean up
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:55=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 22, 2024 at 01:06:46PM -0700, Namhyung Kim wrote:
> > On Thu, Apr 11, 2024 at 11:42=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Apr 09, 2024 at 11:42:02PM -0700, Ian Rogers wrote:
> > > > 12 more patches from:
> > > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@googl=
e.com/
> > > > a near half year old adventure in trying to lower perf's dynamic
> > > > memory use. Bits like the memory overhead of opendir are on the
> > > > sidelines for now, too much fighting over how
> > > > distributions/C-libraries present getdents. These changes are more
> > > > good old fashioned replace an rb-tree with a sorted array and add
> > > > reference count tracking.
> > > >
> > > > The changes migrate dsos code, the collection of dso structs, more
> > > > into the dsos.c/dsos.h files. As with maps and threads, this is don=
e
> > > > so the internals can be changed - replacing a linked list (for fast
> > > > iteration) and an rb-tree (for fast finds) with a lazily sorted
> > > > array. The complexity of operations remain roughly the same, althou=
gh
> > > > iterating an array is likely faster than iterating a linked list, t=
he
> > > > memory usage is at least reduce by half.
> > >
> > > Got the first 5 patches, would be nice if more people could review it=
,
> > > I'll try and get back to is soon.
> >
> > For the series:
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> It is not applying right now, I've just merged with torvalds/master and
> I'm running build tests now, will push to tmp.perf-tools-next right now.

Ok, do you want me to rebase on tmp.perf-tools-next?

Thanks,
Ian

> - Arnaldo
