Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70760126F2D
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932575; cv=none; b=WMUIY7FU8ook4bFY6Y0vPG3fEQ8mw+isr607PytOc4iL+CE/crmIf+zWXhWRyBJdOEmkSzG8hXtIyqU1fdS0BmSD2rxax7r3vd3zURrNGqtQhhzRE2M7EEfWMVA4c0gyJXxX5QO9y6m3Y/YVhvRmMxwt+hvU/kprRPQQkBBJKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932575; c=relaxed/simple;
	bh=A3jNuo3+aMfBd/a46lrJjMimq4KWfJzitCEn+KfU/AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+/kg5lOEeHJxuPDGnk0v5Xo5646L2MPDjgwfD/6fTTCIrqkwclTfOJApGMhyu/lsm9ZWmJXENUl0sFcb7G7lQh6MUwHJpK+f1AZMG8MUWyiS7YCzub4SSlJzKBE5VZmgfR2UrA/MisObmViFZkZdmhmGa21UW0XouVLGHWmZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RMn6m3Cm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RMn6m3Cm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db61f7ebcbso1875ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707932574; x=1708537374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytC4jjoAE7J3d4w3/cSQmAwPp9HtPh6tMpBf/7S8E5A=;
        b=RMn6m3CmAuSCPkd5EZGiLiTuzTxcBqUfCEmXcixPlzWvOmDhEuXsWWuk8NIMWyWH2q
         Y6lHLHA5PYs8l+gi5WNqFsTpZBi3eXw6WNcM/Rs39Xt8uzvcuje8emk0KmuxeI0at4VQ
         VwmdpGYHHwuSL+5gbtA6OhtFRbUWxEPzXM5EMvps5SOv4KAjjsJK5YY/CccUCT0swCTb
         BWj1r3Pgmm6SDBOIw2mjxQG1ewe4D2idJT1etVEblpLHDBdNUWHNsiu8/xxAY9LbD+5q
         tcPxvEijWGRPfyqbi36fQ4lxGq6XNg7gzYprNKAMdlOKzObSvUJ6NBPYnN2GEjjG+It2
         pIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932574; x=1708537374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytC4jjoAE7J3d4w3/cSQmAwPp9HtPh6tMpBf/7S8E5A=;
        b=H9xjpDiVYK9gB2OHqjn/LLJ0Lwgm+i0PA/m+YMUcdWX+FPV5/rE/WWw6kWo+lUhjf4
         2I0Tb/EruZZHM/QbCovzV3kgxebJYAdRQEo7iRUSnqf697ijZV8OYQf7OB62z4JfozTd
         12NjNQD2AXXTGHxMSuZVn+JyoHt4YAEYbfz2QMcotYf/6EIazA20cu3iaYqtyJ+GZDmo
         35u221Qtur5pWvT08zqSq1Ogo9u5vKjdwXFFJMse6w9p2djZTjqBFe4UeXMuvGRhDhij
         3/X15LHP8csUgdlUVs9lPdl/yUg6sWf35diVw448ME1hyLpz3/1MtpiBu2h/DU64b1an
         7iWg==
X-Forwarded-Encrypted: i=1; AJvYcCXqyHbAUzTBgWVI+I3maie8yGdCYor6+sgOyhiv9KXrID1im+2tS2uK9gB8HILevKD6J3w2k+XziDPJJKxULyogGGxW7nWvpRRa0LpF6uzacQ==
X-Gm-Message-State: AOJu0Yzt8UQUAN1I7H4IiWFbaH63j96Yc8TnWhv1fq1ZJdnHWkER1Syi
	3umNLU++5ZvtdLsRhpSOlvNtlwGB6NbTew+E+COWKjDv5jYT05OXO9cVVzhyXBWFihC8QSnEYwh
	agAspg13WVeTGCk9T5T9FrpFjbVfF0kTPkRZu
X-Google-Smtp-Source: AGHT+IGOEogg4Yb9tI+FXwQw1QPr+hnIsaI5VmnKkS2h0TY3p0ODsid8cM97Zc2mxcKRzzKTDXH/NW5voAiEg5ceDGA=
X-Received: by 2002:a17:902:cac2:b0:1db:55d2:5e26 with SMTP id
 y2-20020a170902cac200b001db55d25e26mr263767pld.9.1707932573479; Wed, 14 Feb
 2024 09:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-2-irogers@google.com>
 <Zcz3UO5Jq4zAqSfx@x1>
In-Reply-To: <Zcz3UO5Jq4zAqSfx@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 09:42:38 -0800
Message-ID: <CAP-5=fXeLX8i8sK8EVquDqnV31rtum_K4TLtw5nG=nfL9-PKvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf report: Sort child tasks by tid
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:24=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Feb 13, 2024 at 10:37:03PM -0800, Ian Rogers wrote:
> > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > threads") made the iteration of thread tids unordered. The perf report
> > --tasks output now shows child threads in an order determined by the
> > hashing. For example, in this snippet tid 3 appears after tid 256 even
> > though they have the same ppid 2:
> >
> > ```
> > $ perf report --tasks
> > %      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >          2        2        0 | kthreadd
> >        256      256        2 |  kworker/12:1H-k
> >     693761   693761        2 |  kworker/10:1-mm
> >    1301762  1301762        2 |  kworker/1:1-mm_
> >    1302530  1302530        2 |  kworker/u32:0-k
> >          3        3        2 |  rcu_gp
> > ...
> > ```
> >
> > The output is easier to read if threads appear numerically
> > increasing. To allow for this, read all threads into a list then sort
> > with a comparator that orders by the child task's of the first common
> > parent. The list creation and deletion are created as utilities on
> > machine.  The indentation is possible by counting the number of
> > parents a child has.
> >
> > With this change the output for the same data file is now like:
> > ```
> > $ perf report --tasks
> > %      pid      tid     ppid  comm
> >          0        0       -1 |swapper
> >          1        1        0 | systemd
> >        823      823        1 |  systemd-journal
> >        853      853        1 |  systemd-udevd
> >       3230     3230        1 |  systemd-timesyn
> >       3236     3236        1 |  auditd
> >       3239     3239     3236 |   audisp-syslog
> >       3321     3321        1 |  accounts-daemon
>
>
> Since we're adding extra code for sorting wouldn't be more convenient to
> have this done in an graphically hierarchical output?
>
> But maybe to make this honour asking for a CSV output the above is
> enough? Or can we have both, i.e. for people just doing --tasks, the
> hirarchical way, for CSV, then like above, with the comma separator.
>
> But then perf stat has -x to ask for CSV that is used by the more
> obscure --exclude-other option :-\
>
> Maybe we need a --csv that is consistent accross all tools.

I've no objection to a graphical/CSV output, I was in this code as I
was restructuring it for memory savings. Fixing the output ordering
was a side-effect, the "graphical" sorting/indentation is mentioned as
it is carrying forward a behavior from the previous code but done in a
somewhat different way. Let's have other output things as follow up
work.

Thanks,
Ian

> - Arnaldo
