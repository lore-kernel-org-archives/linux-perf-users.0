Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56966357D09
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859633; cv=none; b=Vg+ZVPm6iOemNe92nkN9L6fBoavo23U7loWWpjqfrnoe3/axcaXjy2kPNPDnpnmaDC2kcq/W6KDHn476QQ3lZeItJBbDSiAaDAvKsT8RyUG7DGd2HfihXhugshnS28oviuQntiBvlo5vL23bSTKOHT/5/WW6HttAQ0g01psQh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859633; c=relaxed/simple;
	bh=e5qJ7/cHRftpI/ExivZm6EQbTQ/U1hWJ1r+cnnvzTAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUZhAxfMBhGvMjR0QRjLGEXt7q8Szwh4yMdqZk6LfcQvwy63FiZBBaZXEbqBIZB5oGCZmy8e0KFz+Be29mkYLZoEWWZ/0KCwb81vU4oIOlBIJphnOr26hUj8NE66xLgEjEpz7vqApEn/qmzug54rVpJ55MLN5r3UVl76c3i62pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbLdQSZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbLdQSZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E166B1F008A1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 02:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791859631;
	bh=Py5W+zOf8jcv9SphAVIYRIsYaiROXNPiORfkJ1reQcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HbLdQSZ7lUz9oL05RWz6k+V6Qv3JS5sb152wnuh9/C7fqzhiLnol9W4Zo/AYHud5+
	 G9kAB19LQKv+cDKB7IHLRfqSBGQmXA5Zjuv8mZFFEkFrZaCX93O2qHj9diPwd7wT/o
	 iQxSjMRoHzmyMWaMQng0yWVlJzy3frz4iMdaiYe0qKzQcNccon0pYeugOwWqt63NKk
	 CvskBZhjH7jFs18BsTCEE/HnXlyziHvOoW2FIvNg/52GfWxYuRgsYprVUK5/LSneiD
	 nUyyAsuRweVt25aLYJHkWXWRZ6RYIZ/Ppmq8Ce0nTi6sOXlUmqso/KpyfuXJcscrNw
	 d9zzw0VVzbABw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so2619003a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 19:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxq6YhegO6bTXVebhcB17Wn0YzV191fUmoqogBcVvrEfuTD+HLSTpXvyHQZX6sKhY8FaW0pzhhQA7zbmeQMrPBF@vger.kernel.org
X-Gm-Message-State: AFq9FYLcEzbKX+JGZ9g/lHS0tRsSuX5g5Tvnv2z2j2FRE7e+HS6VW99d
	nyojqeY4e+tw7e/kIQ8ue9DsIx+GcOcgdcGJUwIg3QjOoeevMNF9MLJnVfFI8etxaRmN9I5hbJL
	HV9i4+FIcD6LlHocMwZ4qSbLb8nlIe+0=
X-Received: by 2002:a05:6402:1d49:b0:6b1:c327:a9d0 with SMTP id
 4fb4d7f45d1cf-6b1c327b8acmr3296104a12.40.1791859630439; Mon, 12 Oct 2026
 19:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012090431.TF3iVDsk@linutronix.de> <CAAhV-H4=nnhbJS4srmt7dNdgpkEZ8_RQ5Z+0baYMiXF1UrJ3KA@mail.gmail.com>
 <20261012102143.lpVrHb9R@linutronix.de>
In-Reply-To: <20261012102143.lpVrHb9R@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 13 Oct 2026 10:46:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7xME-UrgMHcfY41793yxWyvgEMAufwgcboEL2q3Jg+VA@mail.gmail.com>
X-Gm-Features: AclHuK-5nGNIjnalns2TTYeuiR7MEop7yTmsqLsf4e42_RR9QXEQZeMe2PdFpnw
Message-ID: <CAAhV-H7xME-UrgMHcfY41793yxWyvgEMAufwgcboEL2q3Jg+VA@mail.gmail.com>
Subject: Re: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification
 to task_work()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, 
	Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Clark Williams <clrkwllms@kernel.org>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, James Clark <james.clark@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:21=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-10-12 18:15:51 [+0800], Huacai Chen wrote:
> > Hi, Sebastian,
> Hi Huacai,
>
> > > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpo=
int.h
> > > index db199d653dd1a..91e8d80220c54 100644
> > > --- a/include/linux/hw_breakpoint.h
> > > +++ b/include/linux/hw_breakpoint.h
> > > @@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_=
event *bp);
> > >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> > >  extern void unregister_wide_hw_breakpoint(struct perf_event * __perc=
pu *cpu_events);
> > >  extern bool hw_breakpoint_is_used(void);
> > > +extern void perf_arch_hwbp_send_sig(struct perf_event *bp);
> > > +extern void perf_hwbp_notify(struct perf_event *bp, struct perf_samp=
le_data *data,
> > > +                            struct pt_regs *regs);
> > Maybe this declaration can be put in one line because there is no 80
> > characters limit now.
>
> We don't save much, do we? It looks more readable. Maybe if the perf
> maintainer requests it. Looks like waste to repost it just for that.
>
> Any comments on the looong bits?
Others look good to me.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> > Huacai
>
> Sebastian
