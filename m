Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463534F7CC2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179694; cv=pass; b=dBro8X6zarJ+a3KdA5mYhOtO4IUVLfAXF8rXB0LV1p/dyf/AjUdLQWcG2zRdFUeOszDGX84yLgo+MQamqtlEl9nCtEtmek+5y6V2O0nNRD6wbDQpaUvTvSOmFne28Dd3MNlXmwX0IZi3YCrEnYOXzzH9IdAHYi2QzxgaDdCF+DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179694; c=relaxed/simple;
	bh=otTxnRwSEe2Cg65KBPvgnCXx+Qa+TzM40oDmSLpRi+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuzA1Svwc9E1ytX95CJTR5vWDc2H8HtO/J/BJ2x5r6ioOIpchImr2WtsTRcEHNxRv2eqsAImm0m6Ehch/UtwsQEHRHVMSHNtkufSnJmKPkRVf/2RZetIneRcXNjQYGBcWbPhjAdqj6lm1xSmgk5uqzrhC4H8TKOENmgpP8ffsyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQJptH29; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQJptH29"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-530e8c6fb80so270551cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179692; cv=none;
        d=google.com; s=arc-20260327;
        b=cwQcJXSuBESXbcKlKwQKhpYZslgInYGyva4Ug/hPsCM+P21oIsgJ+iS0xZLIlJdyAw
         FqL17qmv/NPKXL8Xy0EGWOhFP65099ym3LV+8osGBOKt4IglTymPqGcMq0NMEib0fQQF
         AqFm6N3tm5dCDbdi5Uf++RJK0lJIF8UGDxw7FjTJc1UXDijoQENAg+qC3Or5isLF+fyj
         XadO30kJwsn8XmVfrcUhV4yndM+Heb12zahGd6Rbk8ssztmkttlxu6sJZSEPwV/TMcLI
         gi153zywhbOYmoqRw2vRvKfsF4rnjzsTzzi6X5mObnVVFq80QWmyFhh3uNW6kvD0DzyE
         4iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Njf5cVebfts0c9IxXjwiEMkJJZX/u05wOCxpZr/+PhM=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=Yzm8r9d1RhRbD4xY4GRwvpN3oMPBM3pK2pwZNEP0L1GsBmCYAMMT86PVUvltlsIWf2
         Vt/FHB6y/c+3fPQuWnKgbLOxgER/2rHVlTXpxN3dZ+iCRRvqEufuA+2iK/paUcBK6FBz
         57UyZS79iUDLvzcn0DGcITmOwqark0Jh0WtqQH2Dg50v3hoqSwCosvzM/Qce/h7nAkiq
         ILR2VP5MtTRXN2fzfMHcBLot78OGT7SR5ztz4K4jh3Uhm64oXbOyfDX91cLF4jll4RpC
         cmMq75jgb/Oe7l9i/L0XagXxwZPw2Vn/PXOUxNezG9aH1NHVslEK59CE7e+qnbut2avt
         uT4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790179692; x=1790784492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Njf5cVebfts0c9IxXjwiEMkJJZX/u05wOCxpZr/+PhM=;
        b=CQJptH29aOGThAsEqHhElPAnekdg9RCK7VuLVBeYic9wec+lVhXXnd7bFiyywCLBCw
         pwHmTdJT79SiLkU14p3ghOXkEukygo7hU2Qq2FfYjI+HciCyu93FQUjU95icmE35vxeT
         nqz7lSTX1Kl9j8/k9j9sTxgEwNLnRfUaM6OQ0MJlXXv/SV5D+J26dv58IOij7L7R5HcW
         JZ4U+ITtYIBR1J5mr7eT/G6RuiTlLtzXA0oYO+QEwoqzJa2OlcZQtPlOsUW1oYg9Mswj
         JJM98XJDQIJRZk4gt/wo8qNOGLFBrgF+wHKITz1m4q1ZCHRquXIiSor5TADPUggmM/UX
         Btsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179692; x=1790784492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Njf5cVebfts0c9IxXjwiEMkJJZX/u05wOCxpZr/+PhM=;
        b=W+raX2/X4b/2JOjxODTdoyu+2ektgIBLfdtytonS7a4yDKjZs7+ICRYsKGEB4xjTeT
         xvLOsRYto4YKPBUP4LPQUMoKu5UNGXRYLnDtjmnRt6dRKxgkZ/kcXuimMsnddlU2Ben1
         hDkmMMu12gV0lSWpJxN7gZEuJ6gNdUR3tvcwWMGrHKQc2ZMKZ5T2J9JyPCNgarjKb2uc
         BE/RHwAMlfRd9MVCkWX258rCJHIUJFRUVwYOF9qtCzbx7ZnogbkRprMT2mpe+/lmJZlC
         rdUfEPXMj/mlTFMs1hZ7APxPx5xrzR9s+LltAlJ90k0Nnx1I3KIdOQUq/h69llzm0eIF
         o1BA==
X-Gm-Message-State: AFuF++kfqibiEXC3faoZ2ECWVUW67HW+Hx88B9ky4fGf+AiOxWPzQ0J+
	duKnimyYjfgmxhasR+1uMd7VCq0qHsiU5PagWJHCWEXMGKb3JVL07GmB8/+30bC6ZnaJvQeHcXc
	+mfcqL9qeS1Wd8EXQgGiGRBnQBJWbiyYazShDGuZB
X-Gm-Gg: AYBFou00xQVSS/XJqKUfFAIPJ92PGbDX2d7dfO9P5drpCcucHmLDFkvuMU+QcE8lbzj
	ZqyKYP13POLyIVgepjwNziVOY8rKFa5QVDYqvJbN6aBP0bE6PAvoWlVgXnR35fMC8O516bTlSmM
	GICFPUyO/dbX/MRGdv890lyY9a2N7N2p3jdhHo+aRjm38nfOyHmzhrp/J33tC+A0LKEVa+AgMOw
	378Cg240cDrc2nfbx8QzxRBDT8HPuQPzhFXWQjOR4JDM7dt8cmlN5ekvUksllU/g8eahik4sOj9
	6bZUJ8XQxRVyrDuh6qfhsfz3vlDY+AODzk0oMBMTwgiSctqn2ZOPkYn1sXx290JlO/VaUQTccG0
	YRWvwWmIEyQ==
X-Received: by 2002:ac8:5f88:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-532f9b3b9b2mr443451cf.1.1790179691149; Wed, 23 Sep 2026
 09:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <f5bac55bce2ca58eec592de327907d7bd3aa61e6.1790145937.git.irogers@google.com>
 <20260923072932.0FE251F000FF@smtp.kernel.org>
In-Reply-To: <20260923072932.0FE251F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 09:07:56 -0700
X-Gm-Features: AclHuK81oTR9yTfsrrhThSo8unEPr6qEIby2LXnssjQiYl4RLnyvHbJdeMeyqnA
Message-ID: <CAP-5=fVnWC7quFZGrdX_q7yFdutT_Nt4vm+rVknPrF=xaFsnNw@mail.gmail.com>
Subject: Re: [PATCH v5 14/23] perf trace: Enumerate the target again once BPF
 is attached
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:29=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf trace: invalid procfs path in pid_list__add_children miss=
es child threads' descendants
> --
>
> commit 1823e747d15e463dac6663bf4d27392bbba3f047
> Author: Ian Rogers <irogers@google.com>
>
> perf trace: Enumerate the target again once BPF is attached
>
> This commit adds logic to re-enumerate target tasks from procfs after BPF
> programs are attached. This ensures that any tasks created during the
> startup window, between the initial enumeration and BPF attachment, are
> not missed by the tracing session.
>
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index ddbe1c8ec1dd4..6b52f0d408dd4 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
>
> [ ... ]
>
> > @@ -4691,6 +4696,247 @@ static int trace__set_filter_pids(struct trace =
*trace)
> >       return err;
> >  }
>
> [ ... ]
>
> > +/*
> > + * Append the tasks tid has forked to tgids.
> > + *
> > + * task->children holds what a task forked, and a forked task leads a =
thread
> > + * group of its own, so each is something to expand in turn. New threa=
ds are
> > + * not listed: copy_process() gives a CLONE_THREAD child the real_pare=
nt of
> > + * its creator rather than the creator itself, so a thread is a siblin=
g of the
> > + * task that created it. Those are enumerated from the task directory =
instead.
> > + */
> > +static int pid_list__add_children(struct pid_list *tgids, pid_t tid)
> > +{
> > +     char path[PATH_MAX];
> > +     pid_t child;
> > +     FILE *fp;
> > +     int err =3D 0;
> > +
> > +     scnprintf(path, sizeof(path), "%s/%d/task/%d/children",
> > +               procfs__mountpoint(), tid, tid);
>
> [Severity: Medium]
> Does this construct an invalid procfs path by using the thread ID (TID) i=
n
> place of the thread group leader (TGID) at the root level?
>
> Since Linux procfs only exposes thread group leaders at the root level,
> a non-main thread's TID will not have a corresponding /proc/<TID> directo=
ry.
> This can cause fopen() to silently fail with ENOENT when
> pid_list__add_children() is called for non-main threads.
>
> Could this result in entirely missing the descendants forked by non-main
> threads during the startup window when using -t with a child thread or
> expanding a process group?

So readdir won't show threads in /proc but the opening /proc/<TID>
does work, which is somewhat obscure. The code must be this way to
work for children forked by threads other than the main thread, as the
TGID+TID lookup would fail for them.

Thanks,
Ian

> > +     fp =3D fopen(path, "r");
> > +     /*
> > +      * Absent if the task exited, and on a kernel built without
> > +      * CONFIG_PROC_CHILDREN. Neither is worth failing for: what is mi=
ssed
> > +      * is a task that has gone away, or descendants the kernel will n=
ot
> > +      * name.
> > +      */
> > +     if (fp =3D=3D NULL)
> > +             return 0;
> > +
> > +     while (fscanf(fp, "%d", &child) =3D=3D 1) {
> > +             err =3D pid_list__add(tgids, child);
> > +             if (err)
> > +                     break;
> > +     }
> > +
> > +     fclose(fp);
> > +     return err;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.=
git.irogers@google.com?part=3D14
