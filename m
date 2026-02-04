Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A93849C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163465; cv=pass; b=WRuAl5nVu74YeRk52V+OqdVjfCQGLGI21VU353I9xtqDw+LjJQpTiHvz4j5rdeqAShJgGades6vIwhxmLxa0uCnr9Q+Y/7gvPobZWTH6xjeZQi408UgPc8BNaolM2KHEcuFA1Lpf2/fSgnYyv8fPjvH8HGHVXSCezPpqPR848Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163465; c=relaxed/simple;
	bh=kc1jJFUYanm72nBVwKH4HomeAzrqvPYkmvnRxU+TcFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K83rt9d7S6sWkV8PFEVNoKk9GE4ftm7/opAsy2sJYvyJEHNrZgWsGaa0CJkmtXrfD5TLfCc6mh0PtVPnIIxMMPiSet1fHttlKvppSgHw7G1ET/rVBfqKqdwsY7i4AFUIHMYfZ800qPRM6xge15PGNch2ioFCSo7uyDftShG+vgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2VSMOmA; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2VSMOmA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3532aa9a77eso2890827a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 16:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770163464; cv=none;
        d=google.com; s=arc-20240605;
        b=DQacz7DJyMUqoKW8EkkG4+HhbJC6EoLf8RV6xiGB27whktxLl5BElaMsyLektkvsMf
         lRh/LO7PggMVuHPURNBEm3gg96wO5WXyaHLi1S1DkhClGLXSYLcHEgUbN+yolhlBpOmc
         qGvMCF8+4/NaZLi9TrebLPeM1q6Z40kak5ssDCBkbSX2f6RZ36dZ8k1cm1HX9qKj52CV
         lS1DMa87Rw14F/XSOQpZldXdopRrSqAkKN6DWvpukuNDz+9iJbqUaclnLeY2QuPjOkBm
         KuSGoswq3gxcUKtS2I5BhI5ach2n1wFTtZAhdW7MPft+zz6h8vrj4eicq2vZTmr2fKfE
         JRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpXUMfuHceqRwFl5jbM1rv8f5sHVl9+U1rfTT6u6uw4=;
        fh=y4Gbx/hpFFeP2jEJJzZuqjxoCQ92ZMjldlcvrGh7CqY=;
        b=IDWUPF7WZbrmOx7vqAYG6rR7r6C9XJhMt07KzG2N9QLY6oJGZ/RshaXVyGqAl/t3wF
         OHJCkD45ZF91n1q2VN5UoU1zENIK3GDyMh5RZlS7nBfzboWQd3HQ46b1KrvfEf5pNmI9
         x3Z0R7zwdsb/J/ownndwhbSOuIf3iCFYOcCnxNUS6jcjgkrZSjyzE1s1KArUKR+yL7jU
         NryTOMLJPgmhobXwC/P3v2k/mY2STf8Vk/d6EY4CmeSNOGmgjjm7od9KZjQQv/brQx9i
         Ja++LVKvijO5Dm5oUHHSJDgrH1MCCm2RnjOob+bNtZopiggGGs/d0Eh/Xdbvym1gUkn9
         v4BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770163464; x=1770768264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpXUMfuHceqRwFl5jbM1rv8f5sHVl9+U1rfTT6u6uw4=;
        b=D2VSMOmAsHiahz4DbC3UFCG+y5QoGVop1AXBMbYN56JVPaSHEUsWtT7jvkNNHdf92f
         h4fij5846cO/FW+kCCjzFeYVgnSz5VAxtelUcl+AHmw6JSlmlyICF1fnB/BJjyeih3dJ
         L9MaVAiyluGLhjNz7DRBnNO2SlFV+j9sal3DpP2+WK06q1jwVj6l5UPbJIcfjUiczU18
         9GTgmsUkdoBP7bC/XVPcQZ3dFk5eWrGhnWEInSuFgYaSX43C7cFSBxlt32kgF2CAw9Gp
         /sRR2x9N/wSAy7Js+li4nTHct31MXLah8LEZRwABgYVNsauWwDmYtGV0VUIPzj9TyRGU
         g1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163464; x=1770768264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpXUMfuHceqRwFl5jbM1rv8f5sHVl9+U1rfTT6u6uw4=;
        b=GkbfNIo6yQl5zeKJsU3QTw4aTE1c5X3XWyLSjyVomMgNbk8mDlVwUNPjwsWQYOjMmn
         eC//rFrUgniV1a/d8YIB3Uys+/dBJej8M17zGAYirAYtGBQvfavjUd62XibY0ex0Qkmt
         n7tpGIuAN1FHDtKguUtjCNLg0ss8/mdacSw3shAy5WXdR04C1wvH+/yL0H96HfWXhvI8
         ZsP8U+a7wdds9GsgiRqQ/ZYgJU9OXlwtTn4pxt6Z3QQ88U9Fj2uOtM3NZIeZC39iJo2j
         axedc001CQO/jfw6GVLeLNi/O3gYqnUHgauKS13Lxzt8VluMnN++O7T/2NbTg0PM597O
         gnFA==
X-Forwarded-Encrypted: i=1; AJvYcCWwaVJVf57vNfWK5UTg5ffnjrhwHWQ4cnSCKaWsJ2ZxAILfVJ8CLtk5Chu3rFA9dvu4J9hPffcy9yK5qcNa3pUX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38n/dqep0pTQBC0o2noLjA7Lu8ysnoeKF5pPdkiC0yCNIYX5d
	2H4dSgNM+jhWNsTnLXPXOuoQFYXKgQVJrNBgaG9ii8547x4MONARf9GZWoc/xuO2nYXij/tGQk1
	unnmeggPTt0uQwEw6clPdPmnNTOV3h7M=
X-Gm-Gg: AZuq6aJByVFCUOSP89Ia3Nia5sn1vE9ouDUOa+qvNr/uEAphnRTIfHuvJBGp20EDFYP
	8pXMI0fLNTfYsx0+7JYJE0um1H0Yn2slFmQQoxeRLpG+fzxEX8xJaj9ydyiqc83dtAZuIjRNa5c
	lPdRczwTbuGZdcftSUTSklCioIoDGhA+Xtmd923gcpGlczAgmDRxMdLyzfmVbY3LaOkxtZpwVgb
	sGgTyWEu24tndUzYMoebi+9gr7bJbONiIbucsrzAcBALvT2gC9OP/Dls45y7qHMgdWcQ357UOX6
	IKHZX4tAeaE=
X-Received: by 2002:a17:90b:3843:b0:340:c60b:f362 with SMTP id
 98e67ed59e1d1-354870ae597mr1057131a91.6.1770163463573; Tue, 03 Feb 2026
 16:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128061753.1857803-1-wangqing7171@gmail.com>
In-Reply-To: <20260128061753.1857803-1-wangqing7171@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 16:04:11 -0800
X-Gm-Features: AZwV_QjSU-xHFZaTZk9jkYzsceYdCAUetSnMDf2M6ltGkpGoSojCsn00RQszOxw
Message-ID: <CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com>
Subject: Re: [PATCH] bpf/perf: Fix suspicious RCU usage in get_callchain_entry()
To: Qing Wang <wangqing7171@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, peterz@infradead.org, acme@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:18=E2=80=AFPM Qing Wang <wangqing7171@gmail.com>=
 wrote:
>
> There is a patch intended to fix suspicious RCU usage in get_callchain_en=
try(),
> but it is incorrect. Specifically, rcu_read_lock()/rcu_read_unlock() is n=
ot
> called when may_fault =3D=3D false.

rcu_read_lock/unlock is not called when may_fault =3D=3D false because in
that case BPF program is already running within rcu_read_lock/unlock
region. So I'm not sure this patch fixes anything really. And even
with trace_in, if we cann rcu_read_lock/unlock one extra time it
shouldn't be a problem, no?

pw-bot: cr

>
> Previous discussion:
> https://lore.kernel.org/all/CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=
=3DwwyRw@mail.gmail.com/#R
>
> For perf's callchain, rcu_read_lock()/rcu_read_unlock() should be called =
when
> trace_in =3D=3D false.
>
> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_=
task_stack() helpers")
> Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D72a43cdb78469f7fbad1
> Tested-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  kernel/bpf/stackmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..f97d4aa9d038 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -460,7 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
>
> -       if (may_fault)
> +       if (!trace_in)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
>
>         if (trace_in) {
> @@ -474,7 +474,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> +               if (!trace_in)
>                         rcu_read_unlock();
>                 goto err_fault;
>         }
> @@ -494,7 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> +       if (!trace_in)
>                 rcu_read_unlock();
>
>         if (user_build_id)
> --
> 2.34.1
>
