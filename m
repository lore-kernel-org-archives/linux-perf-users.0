Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3A30B536
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804256; cv=pass; b=jwHjXH7HWAQ1ssCmtmHvjfIL9nKpYp2ioHiCXbclMjYV0lQKDlU56Q2JKw+UB9ocRke9jlMBkRIul96u0xfLWbnHketwhCxwFYbFlNIhXMlGV/rsDBfQVXOL9evGQmvC4d4ufCb47bu/9rFZyExo9qs5rELIg/LS3INMucQIJnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804256; c=relaxed/simple;
	bh=dcn7oDy1+lw3lX1sFe2xWeSgJmlACo6AUQO8T8b1G1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dlyfo3MAanOvLCvtgPGIXJuSPDnWHbw3x/zGO9Mby6xdLKIknjE0xNjWTYaCrXje/7qM5rrZwOHZRpugS+SRl3pxWTn9zthZs9XRN+ZGDZsSumdEJC+QIjK/6Pu/2l/U6n9iroiVEhS/sWKjQdr02HAAFFu+Uy7qMjDMvtQHxOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFE4TYdu; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFE4TYdu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435a517be33so1578312f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 12:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804253; cv=none;
        d=google.com; s=arc-20240605;
        b=KBxuiw/ug7Qe51g2KIWzjhB4kwlpYZF0AT9TwIgVDIzNbhZnZos35kjpgGqmHE27hu
         V5wPojzu8rq9W4xG1CBrJBRWni454UsGr0slv94O+vMtgNgnX88oj/7wN1LeBU3Soh7o
         h9gUlK9X+NjZC4LAvQpAEEHi8hUABpBWvOuKX+nPrnEZRD6FXU4aLTbCZ5wfw/J3CKG3
         IZDZUht8cl+vUdnu0Ug/hSDqtew07kaQGgnpbtDH1C2+ZLB64jW5Ha2+acJdTIlrMCMO
         SMgvWZNFZ87acCi9e3LLX8x8onDsi4687mfSFgMIAdCJ6PGfuF7vy5j68r415+owiGE7
         F3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kjr7bMIFo4y/rzwVSJirfBe5gxEvBTg8iQyuzOMiR0g=;
        fh=8r8zuaKVhObeJElU5Sie1ufl9owqDiwtHENCN3AhDH0=;
        b=LzcARaoFiFeceRGFdSoMNvECgvOfJ6Qb3ORqa38hiKJe1tT+MO50RWfwm/LRxf4/nL
         ATOQWowMLA9DDB61xY7ppi/uK0pHsvam3JYF4Afji51kecCQKvtXi7DuxBsq9HAPBgOK
         BPG8UUNg5q74JsHdshwrAmXLM3UMyTxFCqh/Lo/JoGlX1k2Ds0U+bqBl/Lr6RoG4wKcu
         MULD3qpAHsyuaaEr2QklpmWnkghphvrkpZzyBkS0PWXlYFa9dl//bqp9UpzJ13447+Fs
         +gRI1qOrRuIrIEccSnupCHLHtf56Pp434+A6fw/EVgkCNmMPJs7rLatp8NVex6UcpxV/
         NYew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769804253; x=1770409053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjr7bMIFo4y/rzwVSJirfBe5gxEvBTg8iQyuzOMiR0g=;
        b=dFE4TYdukKAO5wYrwVjiJBMEBYhjKKmjntFh+Fw3JsjYRpHjuv7ZcxuIsD4r8/SNyn
         6CYCw/5ooNGytTpVFkmOAY+Xuc7kUfSOd3DOQp2FDFLimvB7D1pYYLTkvbPpZmIdTYWP
         0SEypfxHJ/MqzrbzWwUm46G98vzESUzIfTgD8h+yEDGaHbG3g5/kuM1DQX4CKYdrcGbm
         rX7oHlvzr5YyDqmRJxNW0SeGuJ6TPATFyGt5lXpgx/4ZsDgFwjPk3f4lt5nio0SGXpag
         1Zv5wrJQSt8gNsqMvmGrftd+Vg6MCUxrm+SIBULFt/v+iR0a5GKaye51doO/iQPNutDL
         IvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804253; x=1770409053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjr7bMIFo4y/rzwVSJirfBe5gxEvBTg8iQyuzOMiR0g=;
        b=OsPK1qMOSlyNHup7Qrcjl/lJbEWrnc2jK3LrkFh8QgGNhNJq8aBCyih/8BhiZumvoR
         eEcyUCqPTdJWx8vBQv8XggGmaw16/sYp/69dsGmz2upd7Anr6sksL9ztFEok5fxmIDAU
         SitPBPd3HTIiNmTQcIYUPWUS8mQtBTL5FlnzZa+4liSsgJC1E2qByss6ClYzYKWPyqE4
         v88J3n2t1pY9TI1HYsuvyP4AwQXhhohEJojqr87hf8AOgvBVwKx3R+TP0czhczl+cbti
         NJg7esc7HUwX6T5I8BBr5Zv+aCKATtgc4AmTyoN4lgCqMA7mH9tTl9wVWEq5NngHxsdE
         SQDg==
X-Forwarded-Encrypted: i=1; AJvYcCVMxZDrbp1i0FgVpZ1zpCyBWU75rLCu8WWCE096rRZwY/GHMKoyNkjZ8xbtvjHUK1Wgz7r5WIbpDhH+pxWEMpLI@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7aZDP5uv+BVP3dnRn5aDr1YB6iIZ/L18hKSfT8tFFZtGu0pN
	rWQ03woad7urvNCRZrQnm8dFix5Ngx72Juqhr0736LjElUwCh+MpR7yBdOgoMWNEUhjYwPqVZ+Y
	Ri16SMP+3GpKmbHTe7hBnfI5OKH9qa6g=
X-Gm-Gg: AZuq6aIyJ78L0Wy8xt1q8GklKLYlo5Me0WlXv/f+08hgzR96FKfcWV2HWmj6mLTvE0n
	bb5PUaRKntKUJwh5zJqnyaVSwt7yCGRHrMQEHRVwFZ8iVogxKo1laD/k//CX4myHaDnNHsri7uj
	uifYNf4zpPPlBk5NBMQbS003WTyajpNfrx1KRzc2QOmsoyZa8IICBTyKidLypUjGW6LZs/gM0vM
	r7AORpkE0Di6qlkKpViEXcis53oSGcrsh7nzhkWDsQr+CIMWiEdkuwGsx6i/dIcgXFfuplTgnmF
	hU3qTHkuCSKWAu5WcKL11u7ZuREM6Bw6hY9OLeW4wAJmOZpWkL0zKikzmN+cH0BfsjNQcXlcdgc
	lEc5Q8YoZ9PVKUA==
X-Received: by 2002:a05:6000:1acc:b0:435:e451:2f93 with SMTP id
 ffacd0b85a97d-435f3ab4f75mr5973066f8f.60.1769804252984; Fri, 30 Jan 2026
 12:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130081208.1130204-1-jolsa@kernel.org> <20260130081208.1130204-2-jolsa@kernel.org>
 <CAP01T76RmkoJA+g=-Vr0mBvx29j8UjK_xg7VDwUR-FxtJbjnuA@mail.gmail.com>
In-Reply-To: <CAP01T76RmkoJA+g=-Vr0mBvx29j8UjK_xg7VDwUR-FxtJbjnuA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Jan 2026 12:17:21 -0800
X-Gm-Features: AZwV_QiM-Q3Vh8Xa7yKijEZkB1UwCHRq1IX5wfjw6oG_oa9yJS5wZTPQsMFVJgE
Message-ID: <CAADnVQKRdbQCd-DKfQhfVPh=GxBThNfcVUnbkKTBY=b_u3rV7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow sleepable programs to use tail calls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 9:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 30 Jan 2026 at 09:12, Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Allowing sleepable programs to use tail calls.
> >
> > Making sure we can't mix sleepable and non-sleepable bpf programs
> > in tail call map (BPF_MAP_TYPE_PROG_ARRAY) and allowing it to be
> > used in sleepable programs.
> >
> > Sleepable programs can be preempted and sleep which might bring
> > new source of race conditions, but both direct and indirect tail
> > calls should not be affected.
> >
> > Direct tail calls work by patching direct jump to callee into bpf
> > caller program, so no problem there. We atomically switch from nop
> > to jump instruction.
> >
> > Indirect tail call reads the callee from the map and then jumps to
> > it. The callee bpf program can't disappear (be released) from the
> > caller, because it is executed under rcu lock (rcu_read_lock_trace).
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h   | 1 +
> >  kernel/bpf/core.c     | 4 +++-
> >  kernel/bpf/verifier.c | 1 +
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 5524f9429e76..3b0ceb759075 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -287,6 +287,7 @@ struct bpf_map_owner {
> >         enum bpf_prog_type type;
> >         bool jited;
> >         bool xdp_has_frags;
> > +       bool sleepable;
> >         u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
> >         const struct btf_type *attach_func_proto;
> >         enum bpf_attach_type expected_attach_type;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index e0b8a8a5aaa9..5ebece600aeb 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2401,6 +2401,7 @@ static bool __bpf_prog_map_compatible(struct bpf_=
map *map,
> >                 map->owner->type  =3D prog_type;
> >                 map->owner->jited =3D fp->jited;
> >                 map->owner->xdp_has_frags =3D aux->xdp_has_frags;
> > +               map->owner->sleepable =3D fp->sleepable;
> >                 map->owner->expected_attach_type =3D fp->expected_attac=
h_type;
> >                 map->owner->attach_func_proto =3D aux->attach_func_prot=
o;
> >                 for_each_cgroup_storage_type(i) {
> > @@ -2412,7 +2413,8 @@ static bool __bpf_prog_map_compatible(struct bpf_=
map *map,
> >         } else {
> >                 ret =3D map->owner->type  =3D=3D prog_type &&
> >                       map->owner->jited =3D=3D fp->jited &&
> > -                     map->owner->xdp_has_frags =3D=3D aux->xdp_has_fra=
gs;
> > +                     map->owner->xdp_has_frags =3D=3D aux->xdp_has_fra=
gs &&
> > +                     map->owner->sleepable =3D=3D fp->sleepable;
>
> Sounds reasonable, but why not permit tail call of non-sleepable prog
> from sleepable prog?
> The problem is only if it's the other way around.

I think that needs deeper discussion.
sleepable only does rcu_task_trace while non-sleepable relies
on implicit rcu.
rcu_trace_implies_rcu_gp() is always true and this helper will
be removed soon,
but I would still consult Paul and think through the implications.

So I'm going to apply it as-is.
