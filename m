Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8A1F26E5;
	Fri,  8 Nov 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087303; cv=none; b=Ibgz0dkjAgLOEujPXfzYb/9TlC65XghJOBAL3hNXn1BtG3N3Ju08oZBhQEU4joA0JiG7Et3Vo7I1wAFk2Dnpowbw8mQDoyYfKUVY8mg2SUMVF7D1uSgJvEzRv+NzP5D8VDmRSGEsmDBnHeM+H1bISWv9+GIPwYeJlSI7Yy292lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087303; c=relaxed/simple;
	bh=SE5CUUuy+gl7JMHBBOFQKucUxwfW7EVGaxZmqEXj/Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARqvv3wjQYLGhdpknn56QERgvlI6lYpFKnZ/zn1F8GuYQVG0h/1NVJe2+ns2GFQcyJlPE/1AvcRm7lqSQ4bYmIuDorxL4vqUuSP9MrynQ45kqA6jqFR4xZ2z14pKX6aC9JdArcG2hBovkk4ctQT6Tjjm76QbAfiDlRdzqFtjOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so354434966b.1;
        Fri, 08 Nov 2024 09:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087299; x=1731692099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sa0aIjYUnNOdk3sJZexighJ1A3K0kXkmtmzzhIaAaA=;
        b=J3HdZqdtgDEely7IOfANPtP9RRrC7SwEIWkKORteFWGKmpeo6oltT4tqVF/HtWgurJ
         5pCcLxITh93nvFrHRMhEQinEvsHwf2QOcrsUmRrqNlJmZE7Goe5BAlQHAlri0nWU/jok
         haeuMAVUGjT3fJiKGUvEBjTNHuIkKJxSdpt0/m+wY4WEOCUZd7dOc/nlT7vldygQ4Rfk
         Gsii/7tZ3N8diXvKEQzX1H6YtuJ2IT2PezKHQ8LBq7jwkPcEX17U4ZBg/KohkG6IZVVj
         tGNGEGeXuG0+dnsbiqDvIB7eEU7vdS6UXhg7uUeRvZLyGQYhsTCLghb4HbIGRx7RJwal
         fcCg==
X-Forwarded-Encrypted: i=1; AJvYcCUFHhRgvlzLqroHpWCbSA2fH4va8KGTr9gZRsgHJAMwFQoWRPeM6RJzviDy4pufoyerP8Wq2rWaBw5TLi0=@vger.kernel.org, AJvYcCUN10MWYa0W+kosXbAtXel1jgTeOMBxrAL+ES/r8eMzW0qfpQR0/P9I5ETvpDpMvig3D4XQG8M1roYiCEmmlIyo+Q==@vger.kernel.org, AJvYcCUm/T/T7dZGi6lWXk27fxZ+zEIIjBSvjDKSmOkGGNRGw8OW0lt4gpt+/usYeqrMS+FbP/Dqugc0SB3c4WhPxtldM9o3@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLu+zN+blFrW9rqbzgY523c4YoA9vsIMadj18/o1T95aH7EAz
	Gb79tv2TCpSR0lRGmpdeEyckIqJ5D/sCaB1tWXTQUyQWywzr09Wj
X-Google-Smtp-Source: AGHT+IEjQtzAskhOZWIcSDFpCq8EWZT2XYLfLsv4npIaf/mRn6Vw/hJReWOaEsDd3xIh38Nzc7NGIQ==
X-Received: by 2002:a17:907:a03:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a9eefeece47mr303212466b.24.1731087297540;
        Fri, 08 Nov 2024 09:34:57 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a194e6sm255504766b.41.2024.11.08.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:34:57 -0800 (PST)
Date: Fri, 8 Nov 2024 09:34:54 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] uprobes: get RCU trace lock before list iteration
Message-ID: <20241108-positive-axiomatic-potoo-ec0248@leitao>
References: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org>
 <20241108090023.GE38786@noisy.programming.kicks-ass.net>
 <CAEf4BzabO7NuSTZ5fKSb2UBZAxA9EnrXVtO2=J38B1UN5ExBrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzabO7NuSTZ5fKSb2UBZAxA9EnrXVtO2=J38B1UN5ExBrg@mail.gmail.com>

On Fri, Nov 08, 2024 at 09:28:17AM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 8, 2024 at 1:00 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 07, 2024 at 09:14:45AM -0800, Breno Leitao wrote:
> > > Acquire RCU trace lock in filter_chain() to protect
> > > list_for_each_entry_rcu() iteration, protecting the list iteration in a
> > > RCU read section.
> > >
> > > Prior to this fix, list_for_each_entry_srcu() was called without holding
> > > the required lock, triggering warnings when RCU_PROVING is enabled:
> > >
> > >       kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
> > > ---
> > >  kernel/events/uprobes.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index fa04b14a7d72353adc440742016b813da6c812d2..afdaa45a43ac3948f7983175eda808c989e8738a 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1103,11 +1103,13 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
> > >       bool ret = false;
> > >
> > >       down_read(&uprobe->consumer_rwsem);
> > > +     rcu_read_lock_trace();
> > >       list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
> >
> > Maybe I'm confused, but isn't uprobe->consumer list protected by
> > uprobe->consumer_rwsem, which we hold for reading?
> >
> > That is, AFAICT this is a false positive and we should be doing this
> > instead, no?
> 
> Yep, you are absolutely right. RCU-protected traversal is important
> only for handler_chain() and handle_uretprobe_chain(). Here it's all
> under lock, so no need for RCU protection.

Thanks. I will update
