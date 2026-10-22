Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703606;
	b=4ZxkDb9MjT/X4NuDodbjgMwoDBgiK3YKrSQj7I/loR2eq0O6C7sQFKuE3uu2sEBOhmd/
	 yiNKZlQ/yWvg44yOrvmtOX3OdKEV4b+EkVsebL5HvdYHerLhhIFmbr+LwTE5fO0Tt8VlH
	 IOamCgIV/hizAFZ7daiGj8ZC6HXi1C0mDXFen0g83MhrjunBUftY8SNnhQSTPBQ2IsUjP
	 tNIcZzP2xhb/1zp+8U52Z2Hj/3UUFuFsaDeRQBvu/CjVbkij4AoeP7bZBJCGzqeyzPlXV
	 0kKnFbrEWfIF7ChDlwBJvrErh5S7e29Tl2RRXR3p/vELLD06wvPaerxBzt1jNGgaezw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zu39K4rqHyOdUSQLpBVtVU0mWc6KejOhZ/J0gKovzv8=;
	b=XayvnR6WbutUjeZ/ABC56AycJK1+KppMiQFG8cEEERnlfELczvIrwBSCneFAc4+ZX5yb
	 fYKjaXj6n6CYlJzhI9kHdKSdVnF7ovEa7Tjx4KWMtYituaV+0EMG+0FGT6F4FekSVOcDS
	 zsvi8ESD4UrrLP8K7D7bI4yQxVg1/dIHPjRAxwFlT9HJuSJxxaeDNZ3VGooxaN9IE5nty
	 +3vASY+4WCTKH4VbyRFNUDMoSZV7JApURg9V0bXRpQOu2nE8X6mSBINLcbU0KQS13Wiew
	 8NbB44u12JE9macaiEtqkZKYvtNvwf8wWxrKKZGP82QMorlpT+/NGFpVA1liuHTy5wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DxZzMXu5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DF606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 21:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E1DF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DxZzMXu5
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-535f598d126so28971cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 14:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792703605; cv=none;
        d=google.com; s=arc-20260327;
        b=dqTIa2J9QKkVecS1fnSR/18pYDfd07Oc4wwhYDuxvQ+gAyjJSyOAewRcA5MzHQS6+h
         JSAqP2Cwp5fELBsqNcH0JWnnbS1CBvi1ADRn00/9TekJsYY83mr+7XScYXvr0+4siVpU
         VyjqduMsdCY/0fOnDcNy06phKT+DcRLjI+2UwZhk//FvIk1TU+xKKFtb5MfoCbnV7k7v
         P+fcPr6iTkAwz54fin32sVXb4XKNLQo54vFEbZjY72SecJ5h29qoPPb1a4RPeuK4wVyU
         efivfP+Vmw2AKtXSU73Lrxyl8oYmcvRZs0PTKzARC+ypSKgASRpzmlLynwiWLBuAwGQv
         ebUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zu39K4rqHyOdUSQLpBVtVU0mWc6KejOhZ/J0gKovzv8=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=XZu3kezvGoCNTpbYhEAXBiq5fNOSIizL4m9HZ31Y8Eu4hf8l/vmLAOJ5z0hnzeRfmh
         Zh+De9b27KDZxOuJVoPTxmVTcSwipoOgxTdOqppPdS+B9Jr8F3TXGnNl684JD9cwBWEk
         nh1UndjcfpIm2IbHqkGnVjOo55NPV/P9dtMqz7xLgSHEPeoaegNKy6a1X1uptnU8z+L4
         SOyN0KHhpeu0NRGV1ftTwnh3Z34dPJef/BV+T8jYh1W+/U1GvreXngb8vojdufNFhYa2
         YV76yYfob+zM9dienX9JLmp65IOQxij7n4dx3T+dsuCiHtTZdxWoitPTBpuxyGxjobd5
         Ko6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792703605; x=1793308405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zu39K4rqHyOdUSQLpBVtVU0mWc6KejOhZ/J0gKovzv8=;
        b=DxZzMXu5c2kLwl/jl1g36CPTHnP7nIUodZyj1I0ufZikIkvMCQjVUEdhgRmL8nyoTu
         DdGxzOSaWbKCspfRaEe6reCPM9G62g0UiJaGl/ToIQUXgtgSkCMPDFQppIqlxnycC+EL
         kXSb0G+gVPCAzQSkI6+DxEH/15Kt009FEh3hxa9rLWSy8YagE+U7AYvd+dGbDu3rjNvZ
         JCZe9lTLkUc6AkPprJDJlUqgARE15j3S+9BzJDygzO9fvCe/fY+lTZXGymXWdtxTRi9a
         s0wl05rE3hdvKEeUHWppj2isPFS5hFrEwAgFW/OiYtn3IhQLrl0da9ORQxdVswC9YX0+
         cP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703605; x=1793308405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zu39K4rqHyOdUSQLpBVtVU0mWc6KejOhZ/J0gKovzv8=;
        b=ihEhTo3wSZEo/mMFq8wywqKesoq3ZDnmpXBgMwAfFwbkQaH3QiIXxOqccKl+C+GxgP
         GX55goP4AxLeYat+8LK1MEQII40Z8lBfUL6nUApcGPDHNi6rg5ylfwekiwCfo/iX+L8B
         9julQq51WT7hzeHFh4BLh+L4EeZQueMgzjEhpVbVWrG2Zltami++7nAEmNMNs6cYELur
         BZ1tTFcHyI552ffK/RCE1/oBwCeCtw6XOnZ4VYzZ6Y1jNxJ7UM6Gr3Blvd4fobcKcYl3
         udfa200S1qp29ZicyZeM0K1H/Prs8R1CApn6A44bDyW/I+G2w/mJFytptt5LKOQnGmwu
         VnCw==
X-Gm-Message-State: AFq9FYLVhMe08QNs5M0uqBl5qF0AoPr5Dxi+yLXSGeP0s3V8KaBeQgS3
	XMgXJSSdSLWjWbeI6EA4LjlyvOpAZcVnM2ZbXdne2L9f0M4OdQUtgUGdOYlW6AtUXzA08qiLxgy
	3S+0mfL1R/Wjk9fmrHG+TFMmlJZ1Pa8Rvpb7wKRMUn/mJAAq7JTwTZub3JOM=
X-Gm-Gg: AYBFou3ssAk3Ie6CLNVqg4B5b5K8ha+Q+e7fIh/ZeUr/j5TgKL6RZYlqlD1AMuMAG5t
	o7nF+y6CXfoiFOKVyTy84VJPp5+5z0GOSnn/q4tchacSjEyoOqpbzBisOI05cmHR+Ih/rJBC44K
	UUeY3PyFNwv+fGsF1E/9PBLGRjj3Z8LZf5JKg/xpvhnsAE6xGd/oxUnBE5Ur00STRKaMPXYiRed
	pIgWzDWc/jSihXaw8RywzX3388TDTSgCMaxgqgyA6h9V6am1SZBrBmEh5M5TmwSMFxDrptO/k3e
	oWXStx+mrDu0wmdlR3XKow2mJnNxxgWs1fjufmKP0j/KC2+OI1LJr4KIvF8DmekyQX/X3kQUklC
	h4KuVPpYYv7YKyk1QXZo6nbtQiXHaeTMzW8naipmg42Pe8jXXxtciGSHTWgrJB3n0tQ==
X-Received: by 2002:a05:622a:a0c:b0:532:eff8:3491 with SMTP id
 d75a77b69052e-536c1cf9c51mr1694561cf.14.1792703604321; Thu, 22 Oct 2026
 14:13:24 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-7-irogers@google.com> <sashiko-outbox-182008@kernel.org>
In-Reply-To: <sashiko-outbox-182008@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 14:13:11 -0700
X-Gm-Features: AclHuK8_6jlQfZ8Ya1VQB1vC7VCbf2a5AGSMLdrz-LmFZTthd1zlfoA7b6te61k
Message-ID: <CAP-5=fVNh8X-zpHBf1PELH0KD_JudKsfADP2WQB7ScuzCK=ONA@mail.gmail.com>
Subject: Re: [PATCH v8 06/19] perf comm: Add __guarded_by annotations to
 struct comm_strs
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 1:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf comm: struct comm_strs __guarded_by(&lock) breaks build o=
n Clang < 22
> --
>
> commit 5b99280fd6ec287f3ff5bbe3100d016159c309e9
> Author: Ian Rogers <irogers@google.com>
>
> perf comm: Add __guarded_by annotations to struct comm_strs
>
> This commit annotates the strs, num_strs, and capacity fields of struct
> comm_strs with __guarded_by(&lock) and __pt_guarded_by(&lock) for Clang
> thread-safety analysis.
>
> > diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> > index 6343a3c9debed..9fc4e91a36e9f 100644
> > --- a/tools/perf/util/comm.c
> > +++ b/tools/perf/util/comm.c
> > @@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
> >
> >  static struct comm_strs {
> >       struct rw_semaphore lock;
> > -     struct comm_str **strs;
> > -     int num_strs;
> > -     int capacity;
> > +     struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock)=
;
> > +     int num_strs __guarded_by(&lock);
> > +     int capacity __guarded_by(&lock);
> >  } _comm_strs;
> >
> >  static void comm_strs__remove_if_last(struct comm_str *cs);
>
> [Severity: Medium]
> Does referencing the struct member lock inside __guarded_by(&lock) and
> __pt_guarded_by(&lock) on struct comm_strs fields in tools/perf/util/comm=
.c
> break the build on Clang versions older than Clang 22?
>
> In C mode (-std=3Dgnu11), referencing a sibling struct member inside an
> attribute on a struct field requires -fexperimental-late-parse-attributes=
,
> which was introduced in Clang 22. Without that flag, Clang looks up lock =
in
> file scope and fails compilation with an undeclared identifier error.

Thanks for the review, but I don't believe this is the case.
-fexperimental-late-parse-attributes is only needed when the attribute
names a member that is declared *after* the annotated field (a forward
reference). Members declared earlier in the struct are already in scope
when the attribute is parsed, and Clang has resolved those for
guarded_by/pt_guarded_by in C for a long time. In struct comm_strs, lock
is the first member, ahead of strs, num_strs and capacity.

I checked this with Debian clang 19.1.7 and 21.1.8, both older than
Clang 22:

  struct foo1 {
    struct mutex lock;
    int val __guarded_by(&lock); /* compiles without the flag */
  };

  struct foo2 {
    int val __guarded_by(&lock); /* error: use of undeclared */
    struct mutex lock; /* identifier 'lock' */
  };

I also did a full perf build of the series with clang-19 and WERROR=3D1,
removing -fexperimental-late-parse-attributes and passing
-fno-experimental-late-parse-attributes to force late parsing off. It
builds cleanly, so none of the annotations in the series rely on a
forward reference.

Also, -fexperimental-late-parse-attributes is already accepted by
clang 19, and Makefile.config only adds it when the compiler supports
it. With an older Clang, the probe fails and the backward references
still work. So I'd prefer to keep -DWARN_CONTEXT_ANALYSIS enabled for
all Clang builds rather than gate it on the flag.

Thanks,
Ian

> In tools/perf/Makefile.config, -DWARN_CONTEXT_ANALYSIS is enabled for all
> Clang builds even when -fexperimental-late-parse-attributes is not suppor=
ted
> by the compiler:
>
>   CFLAGS +=3D -DWARN_CONTEXT_ANALYSIS -Wthread-safety
>   ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-bet=
a -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
>     CFLAGS +=3D -Wthread-safety-pointer -Wthread-safety-beta
>   endif
>   ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x =
c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
>     CFLAGS +=3D -fexperimental-late-parse-attributes
>   endif
>
> When WARN_CONTEXT_ANALYSIS is defined,
> tools/include/linux/compiler-context-analysis.h expands __guarded_by and
> __pt_guarded_by to the underlying attributes:
>
>   # define __guarded_by(...)            __attribute__((guarded_by(__VA_AR=
GS__)))
>   ...
>   # define __pt_guarded_by(...)         __attribute__((pt_guarded_by(__VA=
_ARGS__)))
>
> Should -DWARN_CONTEXT_ANALYSIS in tools/perf/Makefile.config only be enab=
led
> when the compiler supports -fexperimental-late-parse-attributes, or shoul=
d
> struct member annotations be guarded accordingly?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.17=
17523-1-irogers@google.com?part=3D6
