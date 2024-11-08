Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F946199E88;
	Fri,  8 Nov 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086911; cv=none; b=spR6caXRJlhiR8mMfg+DoYBGFVs60LeXttUUm+qvTSEwpO05d3rD/cjpVCi3SBduNZi2N3Vtqn96WiUaCVbhymWICEWbjc0UdVGgwHH9FOI1jtFbrWGwXl6nIw7nwrWKW9c3nC/RS8jFW1pvZajhseryCMVR3ys0C1etLoaIkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086911; c=relaxed/simple;
	bh=8ea8ddTNBag42apcWveTNKLD6A1GuEKcQTOPIWuuwWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCSsQS3vcHLcBarxOMlAR9Vo2PzS/drZrFIMy4K0oXizO3nZQcaEeMiM27RkouNsbioRz1D1enFvnsKcjUFsHnbPfCebI6xPk9II2UfOxi0UmMBUosLoz3NdAnFeDJN0Q1qGhroGpkie3P0jjpwLi/XnAs43xyMjvxr6jTWfg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3JvSxQc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3JvSxQc"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso1993102a91.0;
        Fri, 08 Nov 2024 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731086909; x=1731691709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNHa/iC/trYWdqJBk7pL0FJKOpGxQZoeAEHdfBDty8I=;
        b=O3JvSxQcAhAHsU1lZknlJFOi83qpFKqzt9V24GhtKjha3jFKR2VsvJBINjmY2qe7UL
         zA2gsj674+uoNCeE98aJIq3GkG+/lBpqBFW/5yLPh74H1PacMFvgFlmqcomMQfjyfXqh
         HUPVokGI9/n7QL7XWekp7xgGmQs8M0mMZSINNFZFWIg9kcakT/bCHHgiWEnuljsshf8n
         HhyV2QQkSSnYjMKieYNWIDEU8Lh7pasyzhHBeDIe9ibQ2AalNdGKv3BvfqosyUWzbsRK
         1dwZGBi5jCb3zLcXulFbsb3T1dgsosyIqIP1yrEyZ0XZxQ1tI5gkn+FtwH4TW0gv7Wy2
         HoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731086909; x=1731691709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNHa/iC/trYWdqJBk7pL0FJKOpGxQZoeAEHdfBDty8I=;
        b=fABIPvNFvki0kiaooCjn6hr0uuHVyUZnqdqF83OEDu6CdawDwk0hhH3uzeyiAMm3bW
         eBDqt1oBMkE9abmfl1JpqTDX3jR6x5kiMrSzpyeeQAzDK3t8Qs8ykyCY7UlQNvC3pl8C
         21zkPxSMebHyAlCBMu8Q4rNoYsuTSlzkDjq2Q2n+gjGNSo4SeOGi6oHhk9k8OIXtVyLl
         DcSbXAqlBR4vpU8BkUU6v4O5i4vkLy964SvNeUOjIFeqdCI+XuANRBiWL0+U4joaZ60h
         feZftbap0djEeMBOWpWXigeEUowrrn7tDBYLJc0QbP15q4v1qi8PJ03sKJ+6GkYth0SV
         etnw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6lIeZF4LMUPLyUqtr67qZYWneHTIu1PSRU7qoBFERQDTMmlUkxVgwWZa9tLdgb2e2SMjuS2Tl2hKYPU=@vger.kernel.org, AJvYcCWPo5qVyWBO3CRakXwC03uzsC9sllDTQgEXrcVmG1c1kWW/O5WQR+oFsE4OCbcpT2+1AhoJGA4KKS/BhtdSgUCfuKw0@vger.kernel.org, AJvYcCX41Qxz2Qkrx24g50LbHRUEpbXjnlOllOnKsynMhGX45rXBGWiZxG4Gap8MjHQqRW1j341TrSJXwOvvXeReXVHbJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxodzWgF5kXv1USeHwutPWrz6+ciTX8TasypaN3R204R2HSvdmL
	MVZQQJoN+YCZMxL54LGjTQlF8nRgcs2ppts9SBHzRzh2SsSnJeh7lClUSagBtMiAhWOgHjYG8Vg
	OQTj0LI0kkrKx3yInAqu5lAlyiwA=
X-Google-Smtp-Source: AGHT+IFBM4Xs5aZ6NWdYVIFvrU0Z7K1T3OlTGPD9+u/fGgL8VCEvk9RSLkFHN3NkOcTz+Kkpl0KVNdQlfRPOAaOFivY=
X-Received: by 2002:a17:90b:4c0f:b0:2e2:c9c1:aacf with SMTP id
 98e67ed59e1d1-2e9b177bc3emr4589093a91.29.1731086908772; Fri, 08 Nov 2024
 09:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org> <20241108090023.GE38786@noisy.programming.kicks-ass.net>
In-Reply-To: <20241108090023.GE38786@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Nov 2024 09:28:17 -0800
Message-ID: <CAEf4BzabO7NuSTZ5fKSb2UBZAxA9EnrXVtO2=J38B1UN5ExBrg@mail.gmail.com>
Subject: Re: [PATCH] uprobes: get RCU trace lock before list iteration
To: Peter Zijlstra <peterz@infradead.org>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:00=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Nov 07, 2024 at 09:14:45AM -0800, Breno Leitao wrote:
> > Acquire RCU trace lock in filter_chain() to protect
> > list_for_each_entry_rcu() iteration, protecting the list iteration in a
> > RCU read section.
> >
> > Prior to this fix, list_for_each_entry_srcu() was called without holdin=
g
> > the required lock, triggering warnings when RCU_PROVING is enabled:
> >
> >       kernel/events/uprobes.c:937 RCU-list traversed without holding th=
e required lock!!
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessl=
y under SRCU protection")
> > ---
> >  kernel/events/uprobes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index fa04b14a7d72353adc440742016b813da6c812d2..afdaa45a43ac3948f798317=
5eda808c989e8738a 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1103,11 +1103,13 @@ static bool filter_chain(struct uprobe *uprobe,=
 struct mm_struct *mm)
> >       bool ret =3D false;
> >
> >       down_read(&uprobe->consumer_rwsem);
> > +     rcu_read_lock_trace();
> >       list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_re=
ad_lock_trace_held()) {
>
> Maybe I'm confused, but isn't uprobe->consumer list protected by
> uprobe->consumer_rwsem, which we hold for reading?
>
> That is, AFAICT this is a false positive and we should be doing this
> instead, no?

Yep, you are absolutely right. RCU-protected traversal is important
only for handler_chain() and handle_uretprobe_chain(). Here it's all
under lock, so no need for RCU protection.

>
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a76ddc5fc982..a5405e9ef9f5 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1104,7 +1104,7 @@ static bool filter_chain(struct uprobe *uprobe, str=
uct mm_struct *mm)
>         bool ret =3D false;
>
>         down_read(&uprobe->consumer_rwsem);
> -       list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_re=
ad_lock_trace_held()) {
> +       list_for_each_entry(uc, &uprobe->consumers, cons_node) {

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                 ret =3D consumer_filter(uc, mm);
>                 if (ret)
>                         break;
