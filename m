Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E54E5347
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623611; cv=pass; b=F6qJ65mxBi5LJY6z4Fctg+qezzwfHZ0zs9XcgMv0Y6ENa4kBObvGtcN2GqgpZn0q58jgfx9D8ds6Dgb2HXMyKWBot4UOeM5h7sGhIYJmn1CyrGZinkAGwh1OQJgobXT7H+o8y4mtIpwFO6X0JzdwHAnT+XS0JdBK//rrypN6e8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623611; c=relaxed/simple;
	bh=CCtsovL76mQGnwUnadWeKBo/Yn5xN9tJZzTsPA2bd9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAbbvQlgkzfhjDbhZ4MpX6bu/+M8PVA33uufttjwV+uMYumUIcNBBOwjAZN9LaAufBq+zOgh6eYK8zwJutTecsMoq5ONSKaTasWVp7u0DBfKAQbFM1/sblitheFMCSjscm2T7OuGbv7iNattjprtxA88XSnRRlraZqcclMiwgV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgGLwpU4; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgGLwpU4"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5333401e359so10421cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 12:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790623606; cv=none;
        d=google.com; s=arc-20260327;
        b=sc6F/95lZd24mpo5na4OKzlqlT9nPB+Gj+1BCObgVm4E6btfhDGxmF3ttCeAR4vj25
         YiygnQ8cAgAP1o/hSefdb3LPSr4+D5PNWp9/b8cG4xI9NCHgELvthfflUDeAeEjTCIhI
         k+b69J8BtuKza88MLMxu/SuZt1w+zRj6Qzx+uQuXlL3eCN+Vz8i1O/HRpgtstZk9zIzL
         VpWOIwMD9kzGxuBRiSkSKiGXLZD8W9KSz6AubgWATMrmncpshk2jtxi7RJ67huFbg29w
         rZkOM5EezZOMHl/oeeAPqdjKm3MdiI2amDFCx5I49WSg+RqvIdA9TBKhR3/+SBBkscEB
         fUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O1YVRuatRiCyBlEcIy8P0JVw+6nR39Uq0eyj7XmStx0=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=izwArHTujh0RHAt5WbvDCite+kcFYCAf24Vs/Gh5bdM2h+gFMiV8uXQ6z0avjeyzst
         EPlBhSMV3m9Yj1KtrOBUfCMBxaxR1lq1XUs8HchhJsRFWQ6Dj334MiacYmyG+MoFQrEh
         XVuKuGDQHKivfn1ETDkqGxjpBiMGijIQmlzT9aTyPh1bHaiFX/7YCZYqni2lSoPlOTDG
         /eJGL9bmw/1JNzqkypJbMvub6vTofrlNJGxufYTdjUEKnRyZw16XdiArzo4y6l99eMc0
         An6MVdOAgixsEbfLfrmmoesx12uWqcD31tcAmhpe2g4+emzhxI9x+9WGOiVjoeEcLPq2
         jWpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790623606; x=1791228406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1YVRuatRiCyBlEcIy8P0JVw+6nR39Uq0eyj7XmStx0=;
        b=ZgGLwpU4JX8FnDkpFnVDD18gS8SHEMYtGTjr7/7uNXD10pDWK8LAuiGGj2YeqQLX+2
         R1BNNH0JjpgZVXOLiHhQ1YnTVqu3rSwEb5j5zqTCRtEYKAbhpQ7ff6D8Dh0FTriWBwS+
         gYk0at5i8ysVLv6Kmg6cpw9QcyHB2gyqlOq2NEWaV2hbeXArrvDvnYUEeYVaYIcn8lB6
         kz5kupfclc7pkSC8ilGXP3B8sYmxqjJEfOxepSqU9R3uRUVuyt5rCqQZLg2f5kwC4e09
         0pjME2C6I6YhZ/6mjs6yaNRBm3lEVf3jI4uQuI8N+saxwvl5vhrs51kCApFsqp8OKE7w
         T3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623606; x=1791228406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1YVRuatRiCyBlEcIy8P0JVw+6nR39Uq0eyj7XmStx0=;
        b=n9d7O0jKgLbu2fUExG3lfFLpY62oBQ2Hf9Tnk2SDdbNK7Cx57DBiEghhVhOjmTw/FI
         pJUMLi8Zb+mKltnBTBHCB083nrMSpAamwLx2Q7jhGdN6j2tpL6VsYVqkA3+VffSVki4F
         hkq5lyVljQFetC8599Iv9/206EXh4FG7WZaBNmpyfPrw19d/a8oERDsTMNHXnQ3Lxin4
         PUvaUNFfuRdfVZaAjOCzhTqRbRhVaf4x311H0YNuHib5N8IcfpQUkYLv1plG4oOlRebe
         nCwyXsBja1qEBhUWXuI1IgqKBHcUBFzBE6ICqMa+7+1ec9YHoHvn5AwIS246qN2gwdNv
         pGaQ==
X-Gm-Message-State: AFuF++mcJMtlHNUrWl0pz5jARDI74xYUFkI3efJmlaQB3HxDab19/vJ6
	THvoQzH1PrROPYgBfJ8ykXtHON7gMdj57h+ZLqoTHWdfWA+paL7jlz2VToMJISpp8p0LV5YeQj5
	WQE5ersfbkBDgCD9DM6nFEBWDNSC0gRHHYwQcBMyTUvgIyNGSpjOSvfnZgwc=
X-Gm-Gg: AYBFou3Dwl08ozuPHe8FK+1sWJDOCPOVSfzpWfZTB2eIVwXM7ODuJ4o9SWoOlZQB5a0
	9crEb7+gw1tJToeMglj6sCDJk27EschJlOA1qmz/+Tp3+bFwCyQA1vxte9q2sujskriMWtKFD9V
	AkVc+qtSRe/wYdjVAKphPrt1xPZjqRw9qT6ExUI35W8Ot3v7yH8IwUKYWuf24vlVbcV4JlYcHUD
	LRAXFPmcdv+fOKrrf2L7mykgQfDqMq4HAKCgAzSCg7iYmV5+y1aGBGlQQv6DBRNW+FIBy8E/suG
	sRPfURoJCJohe9gmNRqqLyRrRVIaXwvOxDl2GS9EVQ3QlxGyegNZ3MlLbiDAnxmpa+gyDKR/qID
	PqrWIADYj
X-Received: by 2002:a05:622a:152:b0:532:a17b:9581 with SMTP id
 d75a77b69052e-533589a1f9fmr1095181cf.3.1790623604931; Mon, 28 Sep 2026
 12:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-18-irogers@google.com> <20260928184640.E53151F000FF@smtp.kernel.org>
In-Reply-To: <20260928184640.E53151F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 12:26:31 -0700
X-Gm-Features: AclHuK9vZf6ldAAIZ0qh_-pa8BEHDUt81WPZTx-PT06jSAGJTHiMtcW2Ir2uvsg
Message-ID: <CAP-5=fXkC4A4J-Acz2+bbfUup6YyHSZ6H3w8TvHkiJAErOBZcg@mail.gmail.com>
Subject: Re: [PATCH v6 17/26] perf trace: Do not return 0 from syscall
 tracepoint BPF
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:46=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] bpf: perf trace silently loses syscall events on BPF augmenter f=
ailure paths
> - [Medium] perf: out-of-bounds read in trace__bpf_output due to missing b=
ounds check
> --
>
> commit 662e5192e10694c169bbb2fe60bc8a7182517dbe
> Author: Namhyung Kim <namhyung@kernel.org>
> Subject: perf trace: Do not return 0 from syscall tracepoint BPF
>
> This commit transitions perf trace to exclusively use the bpf-output even=
t
> for both augmented and normal syscall arguments, omitting the standard
> raw_syscalls:sys_{enter,exit} tracepoints. It identifies whether the
> bpf-output data belongs to an enter or exit event by repurposing the
> common_type field.
>
> Link: https://lore.kernel.org/r/20250814071754.193265-4-namhyung@kernel.o=
rg
>
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index d327603ae4540..3dd40f3c3cbb7 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> [ ... ]
> > +/* The BPF output event carries both entry and exit, tagged in common_=
type. */
> > +static int trace__bpf_output(struct trace *trace, union perf_event *ev=
ent,
> > +                          struct perf_sample *sample)
> > +{
> > +     u16 type =3D *(u16 *)sample->raw_data;
>
> [Severity: Medium]
> Does this code safely dereference sample->raw_data?
>
> If the bpf-output event is missing the PERF_SAMPLE_RAW flag,
> sample->raw_data could be NULL. Alternatively, if sample->raw_size is les=
s
> than sizeof(u16), could this lead to an out-of-bounds read when processin=
g
> corrupted or malicious perf.data files?

Neither can happen. trace__bpf_output() is only the handler for perf
trace's own __augmented_syscalls__ event when tracing live;
trace__replay() doesn't set a handler for bpf-output events, so a
perf.data file never reaches it. evsel__new_idx() gives bpf-output
events PERF_SAMPLE_RAW, and the only writers are perf trace's BPF
programs, which output at least a struct syscall_exit_args (24 bytes).
The handlers it calls already read the syscall id at offset 8 of the
same raw_data, as trace__sys_enter() did for this event before the
patch.

> > +
> > +     if (type =3D=3D SYSCALL_TRACE_ENTER)
> > +             return trace__sys_enter(trace, event, sample);
> > +
> > +     return trace__sys_exit(trace, event, sample);
> > +}
> [ ... ]
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 3bc9e28a9b8a3..d16e55706335b 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> [ ... ]
> > @@ -408,7 +424,9 @@ int sys_enter_perf_event_open(struct syscall_enter_=
args *args)
> >
> >       return augmented__output(args, augmented_args, len + size);
> >  failure:
> > -     return 1; /* Failure: don't filter */
> > +     if (augmented_args)
> > +             augmented__output(args, augmented_args, sizeof(augmented_=
args->args));
> > +     return 1;
> >  }
> >
> >  SEC("tp/syscalls/sys_enter_clock_nanosleep")
> >  int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
> >  {
> [ ... ]
> > -     bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> > +     err =3D bpf_probe_read_user(&augmented_args->arg.value, size, rqt=
p_arg);
> > +     if (err)
> > +             size =3D 0;
> > +     augmented_args->arg.size =3D size;
> > +     augmented_args->arg.err =3D err;
> >
> >       return augmented__output(args, augmented_args, len + size);
> >  failure:
> >       return 1; /* Failure: don't filter */
> >  }
>
> [Severity: High]
> Does returning 1 here without explicitly calling augmented__output() resu=
lt
> in silently dropping the syscall event?
>
> Since this patch drops the raw_syscalls:sys_{enter,exit} tracepoints and
> now relies entirely on bpf-output, returning 1 on BPF augmenter failure p=
aths
> (like in sys_enter_clock_nanosleep and sys_enter_nanosleep) appears to
> completely lose the trace record.
>
> Should these failure paths be updated to emit the unaugmented payload,
> similar to the fix applied above for sys_enter_perf_event_open?

No, those branches are there for the verifier and are never taken.
augmented_args_tmp is a 1-entry per-CPU array, so looking up key 0
can't return NULL, and sys_enter() makes the same lookup and check
before the tail call. The size check compares two constants,
sizeof(struct timespec64) and sizeof(arg.value) (PATH_MAX), so it's
always false. A failed read of the timespec doesn't take that path, it
is output with arg.err set. The other augmenters' early returns are
unreachable too; rename's arg.size is at most PATH_MAX after
augmented_arg__read_str(). perf_event_open's failures are reachable, a
bad attr pointer or an attr->size over PATH_MAX, so only it needed to
output the unaugmented args on failure.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.36=
49015-1-irogers@google.com?part=3D17
