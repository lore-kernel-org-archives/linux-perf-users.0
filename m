Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98864642D
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323061; cv=none; b=iaNFn6gRqLVBNlqx66Fe/PAP9FM8oB3tIKblSFO6Zk638rTOax+vIYzonsxbXZIfOPyN1Q+SBxaKcAIQ/JwVNwMNyY+eKPWQnk1ZoI5Sd8uq+8Ujx3oOZOihG3oVhC0yGdXEGT7wClF3vf8M4uX9xGf9A5Ha6BZOjZ60g+ZzUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323061; c=relaxed/simple;
	bh=f/HvckjR1z+EcA1/XdCPwvsI1rmxwErnXXJWWVAy0/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXEHdNVZOEQ+gEUmxaLZ0EuGGfEoR+dlGLgtppL0W0u1ROVVGlZ9pFbfsSGxhU+Yppc+z3R1pH33FRaI3AGUqRK7HCzbHtnAN4eh/Hh+IYmdn16XS7wh68YBaVv4Jsq9dI3KWcVNxlaxQrWOjDzPxCwtH1fL7trVp4XehIvhvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlxLMduF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlxLMduF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso40535ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 20:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741323059; x=1741927859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGVo9Abok1/2v6z9DgP8qIQoJ2XdR68XpLtpu0uyBMc=;
        b=jlxLMduFjOdZqDhKJpFfwTqAnSzsYvxj0+sEw/yOrrZVQWDsbl1KJykwwpgyswl1Et
         czZ5JBvgfLD6hv30LedvoGuSN8L/6vGC/4QomkDBqRM4wAkGcBfCR5SP6yGsQGKbnyw+
         N/PYxHNrLQRdCJnFwNeQoGkpSrPkoxrOMeo+c+i895bvh3rGrjyvdzuOwAcBzhNe9HnO
         pz4TSHucctz9KCYwXpsqq6EBkBB7XSgFdDBovV5XC+dECH6Z3SkjqTqfn9dBD4FQDILk
         8CuK+j/Y/IWwUV12j8m815JZJ+lhjqdg+0k9GHcWAcxkT4TFGI+qnuPgb0ILKY5tkJsH
         xUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741323059; x=1741927859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGVo9Abok1/2v6z9DgP8qIQoJ2XdR68XpLtpu0uyBMc=;
        b=Njz6FWl+P6rqjJmLslPumYF/362VIaiRgeeZNNa0K2MZRlYyCP837gVAYR5mNb3F+n
         bnL0nurmwSiMJ7SFUfZPe73OL4QYgChkBNe9G5oqd5nIg/OKKPsg7z4hGZg9YWZnWxQH
         kix/H4kjN3awIkv39otD8RygfkKoXjfEr5n2WRnsB9vN4bg2ZM85KtXdEw4G/jCwWpuq
         X7o/aWZ1a+g3EaPyRJSCKG/m5yqbMCfBE1N0E0t1mhnD7t5xHpLxxAsAiMFFyE2XaakT
         kap5fWiZkS5sqf1Zf0xqdwq+3X/mGItjOCit+F7kkpA5mZtC2FVVNElbIK5Wzdu78jFV
         LqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzZk7bHkajcRcr+O+yqqN6xY1Z4WlMjjpUqQZsW/u8rBYSaxBvHmQvMeoVbBd4LZZXpYBBzpr0VfhmwnhoNaj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1v8DEu+ssDAWu+3XKGF8MickkgOEF6Eg2mH6fqNHNmu13n07+
	RQYw7ZAhTFsGTJyl2n2hkUdovNfBIJrgRPCRqIE7hnt5tUaEP3zSqmqoDUvG7aAwxXFPZDbkwX/
	qRLFiWmhiHf9BRhW23FbKrR/x3lASt50fU7Dv
X-Gm-Gg: ASbGncuY3EOU/57VDgaTgMhDcioCfauRBjqFG9+a+ICBP79uJklQwyzCERDJstRep84
	/ICmTtOtj1lAZfx1xAISs1OKq2V9scyHmNhMjg9cH8i3Edb6rXVt3Wvjc/SPLkQmQqmd4STuzWX
	C7KjyQWj17toyG2bqU38UfyM2p1r4=
X-Google-Smtp-Source: AGHT+IEC+V4uQ6fp/2Cimlle33AGQgAoxKrdpMvW4svfegfCW5fDmhNcnXkRndZt7LkR9QeW+u6npnkoFBtpu1l9WDg=
X-Received: by 2002:a17:902:f693:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-22428ebf152mr1783425ad.0.1741323058670; Thu, 06 Mar 2025
 20:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306075147.195435-1-namhyung@kernel.org> <20250306075147.195435-2-namhyung@kernel.org>
 <CAP-5=fW=Gs2ATy8DhcZFjGP5tcEemoZp9q=voFV8HRisY9ki7w@mail.gmail.com>
 <Z8nWNBKuYc0x-sN8@google.com> <Z8pTaVN1uEqjrgRb@google.com>
In-Reply-To: <Z8pTaVN1uEqjrgRb@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Mar 2025 20:50:46 -0800
X-Gm-Features: AQ5f1Jo4q09pFBed8xqghefAo1IDDAoXMdWQ_nDqarLnyHs9z97kN16c6YjkMNg
Message-ID: <CAP-5=fV1UCF3D9rrNzMbH8CNP-UAAS13TAjm_0-3rZSLD_+PdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Fix memory leaks in the hierarchy mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Mar 06, 2025 at 09:07:00AM -0800, Namhyung Kim wrote:
> > Hi Ian,
> >
> > On Thu, Mar 06, 2025 at 08:55:05AM -0800, Ian Rogers wrote:
> > > On Wed, Mar 5, 2025 at 11:51=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > Ian told me that there are many memory leaks in the hierarchy mode.=
  I
> > > > can easily reproduce it with the follwing command.
> > > >
> > > >   $ make DEBUG=3D1 EXTRA_CFLAGS=3D-fsanitize=3Dleak
> > > >
> > > >   $ perf record --latency -g -- ./perf test -w thloop
> > > >
> > > >   $ perf report -H --stdio
> > > >   ...
> > > >   Indirect leak of 168 byte(s) in 21 object(s) allocated from:
> > > >       #0 0x7f3414c16c65 in malloc ../../../../src/libsanitizer/lsan=
/lsan_interceptors.cpp:75
> > > >       #1 0x55ed3602346e in map__get util/map.h:189
> > > >       #2 0x55ed36024cc4 in hist_entry__init util/hist.c:476
> > > >       #3 0x55ed36025208 in hist_entry__new util/hist.c:588
> > > >       #4 0x55ed36027c05 in hierarchy_insert_entry util/hist.c:1587
> > > >       #5 0x55ed36027e2e in hists__hierarchy_insert_entry util/hist.=
c:1638
> > > >       #6 0x55ed36027fa4 in hists__collapse_insert_entry util/hist.c=
:1685
> > > >       #7 0x55ed360283e8 in hists__collapse_resort util/hist.c:1776
> > > >       #8 0x55ed35de0323 in report__collapse_hists /home/namhyung/pr=
oject/linux/tools/perf/builtin-report.c:735
> > > >       #9 0x55ed35de15b4 in __cmd_report /home/namhyung/project/linu=
x/tools/perf/builtin-report.c:1119
> > > >       #10 0x55ed35de43dc in cmd_report /home/namhyung/project/linux=
/tools/perf/builtin-report.c:1867
> > > >       #11 0x55ed35e66767 in run_builtin /home/namhyung/project/linu=
x/tools/perf/perf.c:351
> > > >       #12 0x55ed35e66a0e in handle_internal_command /home/namhyung/=
project/linux/tools/perf/perf.c:404
> > > >       #13 0x55ed35e66b67 in run_argv /home/namhyung/project/linux/t=
ools/perf/perf.c:448
> > > >       #14 0x55ed35e66eb0 in main /home/namhyung/project/linux/tools=
/perf/perf.c:556
> > > >       #15 0x7f340ac33d67 in __libc_start_call_main ../sysdeps/nptl/=
libc_start_call_main.h:58
> > > >   ...
> > > >
> > > >   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
> > > >   93
> > > >
> > > > I found that hist_entry__delete() missed to release child entries i=
n the
> > > > hierarchy tree (hroot_{in,out}).  It needs to iterate the child ent=
ries
> > > > and call hist_entry__delete() recursively.
> > > >
> > > > After this change:
> > > >
> > > >   $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
> > > >   0
> > > >
> > > > Reported-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/hist.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > > index fbf131aeae7ffe9b..bbc6a299b5106c3b 100644
> > > > --- a/tools/perf/util/hist.c
> > > > +++ b/tools/perf/util/hist.c
> > > > @@ -1385,6 +1385,15 @@ void hist_entry__delete(struct hist_entry *h=
e)
> > > >  {
> > > >         struct hist_entry_ops *ops =3D he->ops;
> > > >
> > > > +       while (!RB_EMPTY_ROOT(&he->hroot_out.rb_root)) {
> > > > +               struct rb_node *node =3D rb_first(&he->hroot_out.rb=
_root);
> > > > +               struct hist_entry *child =3D rb_entry(node, struct =
hist_entry, rb_node);
> > > > +
> > > > +               rb_erase_init(node, &he->hroot_out.rb_root);
> > > > +
> > > > +               hist_entry__delete(child);
> > > > +       }
> > >
> > > Thanks for the fix! A nit, iterating the rbtree of N nodes and callin=
g
> > > erase on the first entry, an O(log N) operation, means this is a O(N =
*
> > > log N). rbtree.h has rbtree_postorder_for_each_entry_safe:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/include/linux/rbtree.h?h=3Dperf-tools-next#n81
> > > ```
> > >  * rbtree_postorder_for_each_entry_safe - iterate in post-order over =
rb_root of
> > >  * given type allowing the backing memory of @pos to be invalidated
> > > ```
> > > which is O(N). I think this code would be better something like:
> > > ```
> > > struct hist_entry *pos, *tmp;
> > > rbtree_postorder_for_each_entry_safe(pos, tmp, he->hroot_out.rb_root,=
 rb_node)
> > >         hist_entry__delete(pos);
> > > ```
> >
> > Thanks for your review!  I was wondering if there's something like this=
.
> > Will update with that.
>
> I found that the following comments:
>
>  * Note, however, that it cannot handle other modifications that re-order=
 the
>  * rbtree it is iterating over. This includes calling rb_erase() on @pos,=
 as
>  * rb_erase() may rebalance the tree, causing us to miss some nodes.
>
> So I cannot use this here.

I thought the tree is no longer in use after the hist_entry__delete,
so you don't need to maintain the child/parent pointers as everything
is going to get freed. Here is what I think is a similar use:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/trace/trace_stat.c#n51

Thanks,
Ian
