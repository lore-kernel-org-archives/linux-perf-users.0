Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080C2170D3;
	Thu,  7 Nov 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003303; cv=none; b=IyzHuudDkw/beYdqhj2as5dCcwetB7DelYeS4llp0P+0FCL2vLhgPP6drLCAr8+CXKquH+TbFdc0DIbCXm7pDQNCieBLuV80I7wb0n50oTkjIN2DWu22JwWcTD3rKLmbXjWnSD3kpfkmgjHPjW+FBogk3eZMYXAb7x3YHw0W5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003303; c=relaxed/simple;
	bh=BiWZx9utTVPbugYmmLchlJQEL4iQC+XA08BO9EJFLG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YluHJoXI7Ps45IVTHj2jkcgEeuIQ//UF+Z+ow2QKFwOpancsencqiIcf1VBhcMWxM1AvInI0Fx4StOZ10GAA1aW5tnR2nIMHDp7jS3maQF5CeHYxdKVSiSyZDpumENuSR69HErF7OxopwU9f2fUMD5W+n3wWPsS1ZZryP7LvvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/yC47T0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/yC47T0"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so949326a12.3;
        Thu, 07 Nov 2024 10:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731003301; x=1731608101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUPi5nxVIg8EhFR2eIIdqyLXPKoto2/NVhlsl2Rn0qo=;
        b=c/yC47T09zHCOSlA0YO9ObwbM1J7ozeOB4zrbpPvxaOOCtTKhEd0lMSV2Tr6CnqrOL
         qjjXYpwjU1adS24hg4DyQL7ZDhXp3bL+Tzi7BtO52Xq4w9If+gqHbIusrBt4YUIo/lq3
         +/RAgM4ck/Rp2u+EI5ZGe/Hq+2mdZkAbVe45mcaJ6A7YaRsTqADe9gmFA25KeDNwLhKN
         OdDp6rhRvTwRbL/nyJnwc2gouJCz+3z2dXuUiJzjLlwyq5wKy9kxHrBf8l5/mqWoByQS
         PAngi5DCkDAD4YJ8yg/rYXWRO3jjuRksWD46M/QF5T2reWKukb63dtsdRokJYzTXk2BD
         WPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003301; x=1731608101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUPi5nxVIg8EhFR2eIIdqyLXPKoto2/NVhlsl2Rn0qo=;
        b=okVg6P3Z8Eulut35i3x1mEBCuigPU1FWUtYfc9F1w6lcVZsFUwO6vNVtEphoyv8Iel
         aycWTfqq+AgRzwwkGO8zebv+HscrjYJVgqCAai+BwXHMGExIIBM4sp8a+MMa8ZAdak64
         24R4bvSM7jr+NAhw4j8G81d+YtDeCjs9kY0ryDVZa0K9+Ey2elaTshPbIuq/waws/9rU
         TrAXK1z+Yl4nOw5YqlO1VFWahqubD1LHOwnxZnNOTIL+dUmytjhMCYM/DOOyUlnrqRzw
         p6/4oYJjf7EOm2PAqqHnuDcilGbkFYffQz2IeFiucATeH/geMgxc/aoBzM7B3bVGCR0n
         Yx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0opPsmgGddKAnBJLQtlsCmxbsquQZBsphSBMAvntt49hA96iQ5+I3RlLfPD0eH12ZNEgoRE9egNJiwM2iJnzAvQ==@vger.kernel.org, AJvYcCU8VuUwTbo7Ams13z6unOe8/bGWqAKsEAAuS1NLJULS28KkhN7+CjGk3SHvt16GrZSW2l2kMKgmY96qjuGGRLtJT8wt@vger.kernel.org, AJvYcCVEdtQjlMsvVlyGoq+g1QK/ksoHNOOa9TCNrHl8FXkm8lcK3KOyt4Styla2afyuVMAXABd4s7wRfJQBncc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWoBRksFaN6bOgyR+k3vGDZIsWFdXgqLJmEyPxAACI2A10RQ4
	uvc5vJInhysontOCeFGZAu5DAW5Od22m1XURdLKHD7O2O085yZf5sskj8mIvx7++t/RIwO6KI9f
	Bz6kMSc/6XsKJuhr/f8YsGZFZ+Bc=
X-Google-Smtp-Source: AGHT+IGtKJdBSvLXMi4/lO+OxpJfltwU5r91XxNiE8zYieRtr4Rys/welSksZArBUxTfljeNGLoHrRicb1fPZYoxLnA=
X-Received: by 2002:a17:90b:4c06:b0:2e2:cd11:c9b with SMTP id
 98e67ed59e1d1-2e9b16eb849mr153796a91.3.1731003301540; Thu, 07 Nov 2024
 10:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org>
In-Reply-To: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Nov 2024 10:14:49 -0800
Message-ID: <CAEf4BzaktmbL0T4a1i-hR4SCYYDSNUO1AWAY4UujefecyMUz8g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: get RCU trace lock before list iteration
To: Breno Leitao <leitao@debian.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:16=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> Acquire RCU trace lock in filter_chain() to protect
> list_for_each_entry_rcu() iteration, protecting the list iteration in a
> RCU read section.
>
> Prior to this fix, list_for_each_entry_srcu() was called without holding
> the required lock, triggering warnings when RCU_PROVING is enabled:
>
>         kernel/events/uprobes.c:937 RCU-list traversed without holding th=
e required lock!!
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly =
under SRCU protection")
> ---
>  kernel/events/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)

LGTM, thanks

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>

>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa04b14a7d72353adc440742016b813da6c812d2..afdaa45a43ac3948f7983175e=
da808c989e8738a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1103,11 +1103,13 @@ static bool filter_chain(struct uprobe *uprobe, s=
truct mm_struct *mm)
>         bool ret =3D false;
>
>         down_read(&uprobe->consumer_rwsem);
> +       rcu_read_lock_trace();
>         list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_re=
ad_lock_trace_held()) {
>                 ret =3D consumer_filter(uc, mm);
>                 if (ret)
>                         break;
>         }
> +       rcu_read_unlock_trace();
>         up_read(&uprobe->consumer_rwsem);
>
>         return ret;
>
> ---
> base-commit: 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb
> change-id: 20241107-rcu_probe-bef660d84990
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
