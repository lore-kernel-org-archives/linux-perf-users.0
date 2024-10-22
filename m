Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D01B654C
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616176; cv=none; b=Ima0jg2u+ctb1oqQurSZrClnoverAXTP5eUM3Rs13DlP5kH73vJb5EkxuKyDO8WIFStj0uUqTj77JcStgAHOOtfQBJ78T4GWLeIqDtCVhds9NqxMLnb+L4G0cZB2QhSOiF3PIehGqPEliVlDzYI4yeJhtDDxC9JSWfMF4KBl/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616176; c=relaxed/simple;
	bh=mxbA1MJvfgB8GD3sBLun6XprDlPyDtkipogNBsuQFw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFxW4DxbaVZrPPZICly4z7Osuc56Tk1pXEV4tBIbQjMgTJLlavQiuDhF4sleNqjaizGEMbP7Ic1UvhghYxC9R8aeU7GePov42h7p3ynQt1nZzFsUJqg6FOI4CNmwL9U0PI7hW2xkFKhAenoUR/u9kTXEAL90e1946qd5u1PoZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WIpbe7QX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIpbe7QX"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a8d1a9b7so5431cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729616174; x=1730220974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ESu4WqtRf9/2MFFr1073JLGDWHR1zEFiE/LbaA3GYw=;
        b=WIpbe7QXI3WsFjpTuur9pOcwi/6aYYA7WK6Lr79Ok7EgX1Vmq0JM2jNBzNrE2X4Xje
         F66yuL+bfWN4A/basD7HV8hqs7Vp3JuPPecQUUeGdi9G9hST7LzE+uQgp7g/9hXrKu/s
         hZ041BJqvetvU12r9E2U4fflJUF4KQw56bkyfO5Q45xEQKVRWeXen0SxeLx2YNAO6Jgy
         xefXkm6GsWgFLN2RLxxrTG1arnX8HDI3kt6djJqAWBN8/81Pv4QaoFImyf77vNEVtJa7
         UKWbAPfuPns5KFGRt+jHkrJprfSA5+xX2hHToG3Pd15MBkZgusjq1P+/LtbiRiahNLe9
         4jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616174; x=1730220974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ESu4WqtRf9/2MFFr1073JLGDWHR1zEFiE/LbaA3GYw=;
        b=E0REiCqyl/QlckTu4HHA5+FzLLcm1247hrA2ZXqX1KywL0LnCT9CLBZYz33vaSB1mo
         20oj9vhEfFmHn4/CcVUED8fAU2lyl2lxDvV3JS+Gkeb8zcID9l0OkBtE9KCvU4Nzm1yx
         lUiBjogqy67Ss177/UvhJJcK4oqjN+GDAlzCEaMx1c7lHE8FX/WZRaQGiol/yrkGck/Y
         +XlSviCMxyokWuIhvCzet8+9qy+P5JVa2cq1GOl98/W8FAylSUJpgbfkuJzKZh1xCsjj
         BG60Bw+GP4bEiEhtPmLygWofkh/PazV74lzXjZJnFxjTBkOb+vDOaRtFWunPYfjAN1pq
         a20Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOJaaOKC5eV08H7YjiAK/CdKlJj/fBpvKxNW70XROCFpSyvUimr/Fn1SZjwQ9DRVIi89ReQkQWVlrIiCEROK1d@vger.kernel.org
X-Gm-Message-State: AOJu0YyBg8/P6KiV0pSEIs1jANZgAnVFOuvz9i4DOEO/4Y/lRCFaQp1B
	4BFLUloe8QDtR3/3XB+iYMqfkT3f4x3fOlxtEUd/yqMySKfRcxVPHGMRHX66mU05+FmpOAZ/XgT
	71FyuGgzlffqdb3yAiKrJspUJxdIHpP0EMJAo
X-Google-Smtp-Source: AGHT+IFyzSD1nq1kW+vShKuDGIqORhiRNgNY50Ld5nAzCe8Lxet036UirBAuIWblEYuYfqS4pcCgAKIg35nYLLknTLA=
X-Received: by 2002:ac8:7dcf:0:b0:460:46a8:9e67 with SMTP id
 d75a77b69052e-46100a7fe22mr4691901cf.10.1729616173598; Tue, 22 Oct 2024
 09:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com> <20241016042415.7552-13-irogers@google.com>
 <ZxdIAfwD7YzyRMI-@google.com>
In-Reply-To: <ZxdIAfwD7YzyRMI-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 09:56:02 -0700
Message-ID: <CAP-5=fVvM_8T9b6EXC+JfpV5FAWPDJN=HfFtFhO+KU5rXd4P1Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] perf lock: Move common lock contention code to
 new file
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Oct 15, 2024 at 09:24:11PM -0700, Ian Rogers wrote:
> > Avoid references from util code to builtin-lock that require python
> > stubs. Move the functions and related variables to
> > util/lock-contention.c. Add max_stack_depth parameter to
> > match_callstack_filter to avoid sharing a global variable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-lock.c             | 137 +--------------------
> >  tools/perf/util/Build                 |   1 +
> >  tools/perf/util/bpf_lock_contention.c |   2 +-
> >  tools/perf/util/lock-contention.c     | 170 ++++++++++++++++++++++++++
> >  tools/perf/util/lock-contention.h     |  37 ++----
> >  tools/perf/util/python.c              |  17 ---
> >  6 files changed, 185 insertions(+), 179 deletions(-)
> >  create mode 100644 tools/perf/util/lock-contention.c
> >
> [SNIP]
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 2a2f7780e595..ea2d9eced92e 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -121,6 +121,7 @@ perf-util-y +=3D topdown.o
> >  perf-util-y +=3D iostat.o
> >  perf-util-y +=3D stream.o
> >  perf-util-y +=3D kvm-stat.o
> > +perf-util-y +=3D lock-contention.o
> >  perf-util-$(CONFIG_AUXTRACE) +=3D auxtrace.o
> >  perf-util-$(CONFIG_AUXTRACE) +=3D intel-pt-decoder/
> >  perf-util-$(CONFIG_AUXTRACE) +=3D intel-pt.o
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index 41a1ad087895..37e17c56f106 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -458,7 +458,7 @@ int lock_contention_read(struct lock_contention *co=
n)
> >               if (con->save_callstack) {
> >                       bpf_map_lookup_elem(stack, &key.stack_id, stack_t=
race);
> >
> > -                     if (!match_callstack_filter(machine, stack_trace)=
) {
> > +                     if (!match_callstack_filter(machine, stack_trace,=
 con->max_stack)) {
> >                               con->nr_filtered +=3D data.count;
> >                               goto next;
> >                       }
> > diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-c=
ontention.c
> > new file mode 100644
> > index 000000000000..841bb18b1f06
> > --- /dev/null
> > +++ b/tools/perf/util/lock-contention.c
> [SNIP]
> > +#ifndef HAVE_BPF_SKEL
> > +int lock_contention_prepare(struct lock_contention *con __maybe_unused=
)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_start(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_stop(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_finish(struct lock_contention *con __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_read(struct lock_contention *con __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +#endif  /* !HAVE_BPF_SKEL */
>
> Do we really need this part?  Why not leave it in the header file?

I agree it could be in the header but I think it is better not to have
it in the header. The change is trying to move things into a new
util/lock-contention.c. We didn't have the C file in the past so
putting things in the header was okay. In general `static inline` is
something of a code smell, the static says make it local to every C
file leading to duplication, the inline doesn't actually mean inline
the code it means the symbol definition should be hidden. There's
generally plenty of confusion over static inline that it's best to
avoid its use, we don't want code in header files and let LTO resolve
performance issues - there are different arguments in particular
performance crucial code that relies on inlining, but this isn't it.
It also helps the debugger to place the code into the C file. There is
also a lessening of cognitive load when you read the header file which
is smaller and without #ifdefs. I was also hoping to reduce/remove the
scope of these functions if possible.

So yes, strictly this tidying isn't necessary but given I was creating
the C file and tidying lock_contention.h it made sense to me to clean
up these.

Thanks,
Ian
