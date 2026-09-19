Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DF366055
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857912; cv=pass; b=X8EtokUTBrjK+97Lbyy9TNrKwHs/wyQxaEvSmA0/R9WrPFy0SKRrxkGdhrOqMKhCfpCV7CQ/LNkXEZu1v8SnXmcU5awZV9UBiY1F5gLZAvwUU1KAnNEB5Bm7Ge0t8qLBcO4/fNiNCQx+IAK5HWDjnWwWaPhy0iHObR0NU37I92E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857912; c=relaxed/simple;
	bh=HZVbSt+G1qkLumJSMkh/JGQ3tJBwKTzI0kEEv2uT0J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8aw3WvJfwSXon+OZzZtUnPA+ODJKl6/pa7I6BIbRoO60+nLdzzoLeDY0Bkgqc5xBeuEtEC4OXAbGQanVzFsZpBr+K2XbrFPYL07weAe6MAQvMUBm57FQggP+yS+QjcY8Ec6JtCmh1/U25oe0obb6YLpRQk++Ys1eAYp7BkM8tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7THQIOI; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7THQIOI"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52faa58bff5so179071cf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 15:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789857910; cv=none;
        d=google.com; s=arc-20260327;
        b=CtaNTdBDs7UEImkQgPql1kQsU820jOXsTWDwQve9gQut3g4jOHtcw7J1jUNatX7od4
         Nm7gZVQhdB7+EEaChrNymYStn6fo73oTgfaaOpUHWBAFAgfbMl4sMCezmJqeyHLI39wn
         UDmXpFFX1yXrPEjt9300hmunTk3R7oo9f6B7Ox7E95mPuRzEiyDg9oOgh5GUC+OlwVGO
         qE1dpt5cMhJ2cVWbN3TCPE38rYC20V+z6jMqg2CqDytGVA1SXrzpv3/SRgIbfGv+tKxH
         rGcJBPqjK/pXM/Ka55KNKflRasbX1GBzTpKV6fPbvZ9ypH56d1zkPm4FpNQ6+k1XNykO
         fYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WE6+DziGd7WPL7pgBonc+8aoo5lx0v1SqrA6Ym4LWYs=;
        fh=KVuE+GJGre1TzcKcswr5IEjOEcbUNqwGSYrPjKuwd5M=;
        b=l7hqj01W3E2YOTsdh+zgcg3TxvkGwUJPf6gSGkkkploRCogWcIhraZj8wMg4u5KYWr
         QwyF1o5NhP6MWBO20qWHoEiRVFu9fYIF4+XOXA5ykvDT/6TfXLhxEI1TId6H1PEGXNgT
         +t7GZvGWNZbTgkpQdM01H3VFdf5Ar58w6KPrPjzOkGTshVjwtVsWPDtweT0xA2XPNvHY
         qDO803rC6W6E3CJyT0jmRu6fN8WDaeHdHc3kuOucP8tOksWtAiHWkX/cxXnljVKcctRU
         gPOzT4EhzuwfWU6uA/YjIclIcKOqSEdvJLSW3aA/qXUvU28JrmTiWWdy8nNnDgrQ9iNd
         W7vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789857910; x=1790462710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WE6+DziGd7WPL7pgBonc+8aoo5lx0v1SqrA6Ym4LWYs=;
        b=Z7THQIOI7OrBz8hWrx4x5uwWXnTNAKpkggfY5F0ixqxbgPLp6FaF/RqCcbRwyVvhLR
         BKWGknJk3Jkc7zZyx0vcp1noHcdufqcPaWcCWFu22Xf283GDpTszF2j0/bW6sYs9FQ/p
         NgApxEgjTSNDmr8GyODLpvJ833IX7b6iyfnLygRj+XFhdTIRjJ9PAooKgU9w4/QMlXaZ
         3Az8P4G+YSZKEs9XFY7fk1BqEgj2BwSpe9S+oZ+DMMegYBl4E0mINJdTOyPKJ7ekglRX
         Nh6QD1PRQTCCc3oWBkIPCJWn4rCIGfnXJEjfwvA6Fk40NANC7zYyxOQWc8XbfsKrdYsd
         fwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857910; x=1790462710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WE6+DziGd7WPL7pgBonc+8aoo5lx0v1SqrA6Ym4LWYs=;
        b=2zjeabUQpoonWJdzUkmVrW9K+yk0z8cUMirczzFC3SDqRDw1sqqAqBYHs6XWDv8RyD
         g1ymWWlytbfzdsj2s7XaNAdN3kg6Jvjdm2jkT3N8O3HzigiXxkbbSUD1+a3iDuCwOCKh
         yPuJFsNPN0tPSg2gAuFN72KdAIDiGa9U27OIhHoSGYqXVwtAff8ARXyw6Mygr8AWfW5C
         HfUbpB/6FwPUbSoiPA0YuX14ivH4eqwFxAzb5IRRLX+gbtdDsBKjyZivYpFGckG7ac8S
         3eMycZtBdviF5qERuLWjr09Dsp4p1uLmzDwL/g4AQxobxB97TOx0e6kF6cnhFPnl50h0
         anrg==
X-Forwarded-Encrypted: i=1; AKwUvBxjzPpq6s7t9SyXzZbDEF8DDSYC/S0dTsVwG7eShIDloUDIBh7WoU8yFURoGPBX35wS41PortYISHjLW3FIrnyP@vger.kernel.org
X-Gm-Message-State: AFuF++mRFbfnXfqKGfitu9OXFyM+JnnA9YqP2LP+gelAlWIvkuehHSxX
	HpbS12dnxRtpDdKtT4cau89ayycOdzQi8zoCV+dun+N7JHesKIftNER5wGrcWcFJ8iGmoFCEhLD
	BosF1rwfkfAkbvqUluIOWiC5yVjqtMYjEvro4tvLh
X-Gm-Gg: AYBFou0+ZlIOZEyDp6EBrh4xRbSKsQZv1FQ5hvnbL/n8fI6etsU+uF/ltEtop7RsBsW
	cqQWwLpuPOlWckHw0WtEz5/xPfLHXvWsJvaVQlrCodvTeVYFHbBtwMoQrVDKvRtI9Ujo85/Cd4r
	jGQR9qlVirKT5AK8bUMvoM+nipmop9gy6LTOKwfbk1gqoPIKEm1rB/Exw9UP2wGrdMMacjLwpW9
	eO39vJK47hi9YrRU/r9fOPUX1OEdldqPaqUghfaft0H9nzOTfwVLWAp0t75wOPpmEUBMtOOofqJ
	eHJKd/ayt/XIdPYHIH9VE+NpTJWikuyqYLaC0Ty9pLYdkV9/lfFIQDQ=
X-Received: by 2002:ac8:7d15:0:b0:531:6de:6028 with SMTP id
 d75a77b69052e-532b747150amr5903181cf.13.1789857908994; Sat, 19 Sep 2026
 15:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919063745.48444-1-namhyung@kernel.org> <CAP-5=fUt43_08GcNV3bz-SFmRjBN+NoNZ7zEJyBDa+tZiN0vdA@mail.gmail.com>
 <aq7MzpfPwQkv-oML@z2>
In-Reply-To: <aq7MzpfPwQkv-oML@z2>
From: Ian Rogers <irogers@google.com>
Date: Sat, 19 Sep 2026 15:44:57 -0700
X-Gm-Features: AcwNN1UkTyo4rhv2xHwiQqVdKIaEgOooiptAL0AD3AJn-lJ4unng47STfXUmDOA
Message-ID: <CAP-5=fVPTZsV8UodhB3ASp-DvsvYwOZdNj1xdi8qGHEW=E6Png@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] perf annotate-data: Support flexible array types
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Zecheng Li <zli94@ncsu.edu>, Yanbo Zhao <yzhao62@ncsu.edu>, Tengda Wu <wutengda@huaweicloud.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 10:56=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, Sep 19, 2026 at 09:18:55AM -0700, Ian Rogers wrote:
> > On Fri, Sep 18, 2026 at 11:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hello,
> > >
> > > The flexible arrays are dynamically allocated with different size.  S=
o checking
> > > with the original type size won't match and cannot find the type if t=
he offset
> > > is bigger than the size.  This patch series detects those flex-arrays=
 and allows
> > > accesses beyong the original size.
> > >
> > > I'm not sure what's the best way to add test codes for data type prof=
iling as it
> > > seems we need to add a lot more workloads for different cases.  Proba=
bly we may
> > > want to split the workloads as separate binaries.
> >
> > We have tools/perf/tests/shell/data_type_profiling.sh, I wonder can we
> > not just have some workload with a:
> > ```
> > struct flex_array {
> >    int len;
> >    int vals[];
> > };
> > ```
> > then create a randomly sized flex array and access  it in a loop someth=
ing like:
> > ```
> > struct flex_array *a =3D calloc(sizeof(*a) + random_number * sizeof(int=
));
> > a->len =3D random_number;
> > while (!done) { /* done is set by an alarm like with noploop */
> >    for (int i =3D 0; i < a->len; i++) {
> >        a[i]++; /* Expect blame on struct flex_array here */
> >    }
> > }
> > ```
> > ensuring the type profile blames the struct flex_array?
>
> Sure, I can add that.
>
> But I was afraid it'd need many small workloads to check data type
> profiling behavior for different aspects.  Maybe we can think about it
> later when we need more. :)

Agreed, there may be a way to automate that. For the specific bug
where flex arrays fail to get type profiles we should be able to avoid
reproducing it with a simple test.

Thanks!
Ian

> Thanks,
> Namhyung
>
