Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA04F4CF3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179827; cv=pass; b=HQR+jzQWvZ+hIvWfV18QZpuWosDZEIB8iE0jqc3ELCuilDAF0rGw0MGcyMqGbMZF2wZvPMoBdwUSvKutq4qIKG5GaScUsfbKYK/J2BvTwBE5a/vnRuVCLwDVFfhmH4dXYNK/i2lrnFnxupbYhvCcNJfktG3aeni9K/0MSKOPk8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179827; c=relaxed/simple;
	bh=kiPGaBDcl8hreXDZx5sIXbbCgjocPulRbpU3pmIrr8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQYu4407oNnE/DZXv/SKFB3Lfsh1wiKpwT0pnJMa7kx7urPY+rUA+F0H7LrfZJNl55qA/2TDVpKFItS1UBUwxXDVudy2Bt7lXPxuivla9BaDehtqUb6xgJ0yvVS7JIHHXuA7h62iVtMtDuRORzyERqGMLIrUyOuby9xjOqF7Dgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E62nz9y0; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E62nz9y0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-143941c2aebso7075c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179824; cv=none;
        d=google.com; s=arc-20260327;
        b=EtwfizCqHVcW+SNaoH7oMguGoCUP2f7K/z+eN2jzj8mCb/LaFnaG9ptO6K12T/o4H9
         kSTdnaXJ0a54YkiP1fK+Rd5zgdd821f/gaJ9X66qpg7xxxsCs7ouPWcUp1UJEO2++dk3
         rwMMKNLdSBWJ0+1yOPhz1rF5FVmQdhzgmGJQNDaZvoWtCf40LR4wZrRwS4yp8xpmWJnr
         8xqW8fnBLHFGbjVOjLYOHWnAdt2U9Bs5JkOcX0HQiLumP8AIfBancuvSYnrvqOiRtUDf
         1ODQYiFEsXXkRgIhM7zsZkrjKDkw/kRFJl6w4BKHLMxEOI7xfoGJmc4yP3saDbfjFRSI
         QdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1lgxg5mOOsgs40jnIeWBbdhia7xPrn/6V29iVBWpK6w=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=AUJSwcesVcabv0smhTFR3cfxvAChAfIKujhpYSbeyVY31h25vtdFafd4a8EPDkwGbc
         iXqZb40IroGJLtNwb8fEvgKPOEf12s+y9prx6KlrQhqjSt+DCzwrk8nmxWiPMxd24kWC
         kMJpwq+0Rf0ZUVH0RPMgmWOBdY/ryg1vosmtQ/8x5Imr2oUbc8vaPoW8HRvjldx4Zbuw
         pkPRankkPnxTyJ6A3Kmyip1cQavh0KDO6uI7EY9zt5NPVHJc1SocFiFukR59DYe7uzuV
         jA1mC0wPEsfPmWzOKWjxPhHBN6kWuH7RgJVZn+xacKXoB35Yvod9HxPSjAyTicPeoWAl
         PG+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790179824; x=1790784624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1lgxg5mOOsgs40jnIeWBbdhia7xPrn/6V29iVBWpK6w=;
        b=E62nz9y04aVpKxiJQpSj/SQoaLpQykiV4mAeDHF9K4o2Ngpc0uz/L5vN6QaxrX7sMx
         1qrzBcKD+6qeWcaWHBhH0JIjC50jz8an1rPdhfT3MBduADTdLKkRElDT0lntydmfBcDQ
         lGsiYMJks6X5Wjf/TzKzJPE2w5bXoUtc+xXkmKmg2RK7WNSTEXbSs3y2VGfQEa5bXlB7
         wXxVmz+Sn10x5EeShSUilt2vW6LOyYmaQTG9yNepQ0Prmwocqe81nRE3avocW7DeZO5s
         sK+dwg8/NJlU1BXPgfSmN+ygJUmQNXoqCyFfrsnlxB6R9/vSGUi85p/1KMso2jTHXEmz
         /kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179824; x=1790784624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lgxg5mOOsgs40jnIeWBbdhia7xPrn/6V29iVBWpK6w=;
        b=UTbjH8ABh4AoL0ZGXBYvyNa9APoBGeFmDKHaX3WE2bzTWi67gXrXNWyx7DsADXDZbT
         eDg6IJhOGljvT2myeQqYxA9we3p7CZXSTvECD7EPQbacqDco1gBCKR4kS3W+TVZOdP9c
         e1qOvK/Mjf9gqLj1xdFNvAVKycLwCcaDIsDScCOSpx73vdLMQhqepet2pHWsxcmTul1b
         D4Hze8rzN3dCAwRwbu3PhF6jSs2QL1JY3JBq9KcORwfn69zwyTz8Yy1wvpWHAGUxhdbE
         GRqo/xpVWmhUGVwWbbkQnF/l0ozUTX9GZZtGfNA50S8ehkwl1b5qAlTYsTXkwImLXHdF
         TYGw==
X-Gm-Message-State: AFuF++kVpOOgm7BZnPvFHEIjGwpyxsryM/oQadcbUY5tulH9efE+R8k8
	5+cF6V+Ayx51DN9Ut5PUHkS6HkzW0hHpl2g55vfEx9IHpzx4PY/8xaDIQGAR1ZxkzD4GSe6CQQO
	a+99a5cjzUlU7KuO5ey/925kTGDGwk534JdfLe0X7mIGectlEQM8TWwyy
X-Gm-Gg: AYBFou0J38qra0WfWQiOvah/XKt9ROGaNGCSG4mKFopOA/ZFumBPmOHt63m56AWYodN
	WOPPcQnTdYEihCXtchW4ITlppBazYIzU0CgBqACcl70sjlG0wCL84rAfnxDjMZTtKEXig05+7ka
	DbYps0RbvjhDbOm4g103kTsf4hX2Q0BpQXDxhDcPiUwuGsC1rNXhpog1liLCJ3hV1bNL+UjUCnO
	BjcTTNiSstzZGdB0EH8k2FdaZpQlWboeb4eV3amqKDO9T0SrXfEYxsmrllxwvPRLjQU440f3szV
	+7cZ6mPGGB4T97X4nVW9YZqLejVzksBC6vzH/b01IDfSsxcqYukynYF2YIMLmvxbPjUtZ/K/gzu
	F7jH97JuTZnz/xsHt8vsn
X-Received: by 2002:a05:7023:88b:b0:144:cad0:b470 with SMTP id
 a92af1059eb24-14502f73758mr49806c88.6.1790179822479; Wed, 23 Sep 2026
 09:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <f022c34f984e5037f4f4bb0daa75963ff8912e4e.1790145937.git.irogers@google.com>
 <20260923072549.DF9921F00893@smtp.kernel.org>
In-Reply-To: <20260923072549.DF9921F00893@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 09:10:10 -0700
X-Gm-Features: AclHuK_tTcX4yQRPKVniDHNvuKbSOQVLrDerNyRp97HRo5GX_hyE6oEQHiXfNJE
Message-ID: <CAP-5=fWvd_j84D=MHNQ_vJXrtbeT_GsH2LiVa_JOYbO9mh2h1Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/23] perf trace: Include the augmented arg header in
 nanosleep's payload length
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:25=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] bpf: use of C99-style // comment violates BPF comment style guide=
lines
> --
>
> commit fdd001e20d7e2bd912d88ce8d78d5f254e09e3cd
> Author: Ian Rogers <irogers@google.com>
>
> perf trace: Include the augmented arg header in nanosleep's payload lengt=
h
>
> This commit fixes how sys_enter_nanosleep() sizes its output record. It
> includes the size of the augmented_arg header in the length calculation,
> matching the behavior of other augmenters. This ensures the entire timesp=
ec
> payload is correctly output to the ring buffer.
>
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -426,7 +426,8 @@ int sys_enter_nanosleep(struct syscall_enter_args *=
args)
> >  {
> >       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> >       const void *req_arg =3D (const void *)args->args[0];
> > -     unsigned int len =3D sizeof(augmented_args->args);
> > +     // the size + err in all 'augmented_arg' structs
>
> [Severity: Low]
> This isn't a bug, but does this violate the BPF comment style guidelines?
> The BPF subsystem requires comments to use the standard /* */ format rath=
er
> than C99-style // comments, even for single lines.

Ack. The code already uses // for the same comment elsewhere, so using
// is more consistent. There should likely be a global clean up of BPF
code to use /* */ comments. I'll not spin a new version for this
change.

Thanks,
Ian

> > +     unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args);
> >       __u32 size =3D sizeof(struct timespec64);
> >       int err;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.=
git.irogers@google.com?part=3D2
