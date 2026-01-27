Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153D29ACF7
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548094; cv=pass; b=BKlyELND83Ie+QdXOJjwyCHOntUQs132PihPAiIB+8QtNaEPcCbH2J0NISlKJlbLYntVhtiZCOKoK4wyF5uTOHSSJoTIH3qHlNUKiuQL3j3ySXJdOMralE4wE3o/ztUJLrfiT995lUfsfnMmJQ5kNwsZmcoHj3+WxBfJA4NGYaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548094; c=relaxed/simple;
	bh=P9HSiKttuCPVxcJklWQQg6SJzfTFCS1PCaCrH+OZM6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6srWwjD4QeDYyqxdIOuNIZJ4I3RxC/EBnHyXfLXjqMbP3nlVnxx9Zizw/M/kvQ5EkQfc0Bof3KL5fIeq4UCYBmeJZSCsBglu5YUyjuq91oVc6rPdb27XMzLBqkOcBbCF/siOeOz7jJhVFxp37xoIFFJVUQLDS0jxHKZ+mVTvlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu3W5wcw; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu3W5wcw"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34b75fba315so3617387a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 13:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769548092; cv=none;
        d=google.com; s=arc-20240605;
        b=Onf/Ks5tAswI5KQvE5VFiYWHRKnzy+MW5v/CVg4gdQtymly6UfMvylvR+MaWfdeHnS
         GL/WdmL0oenl2txQKKJHXIDuqXmqnTeuIr7gzeWRKjRoBmc1ZXagasH1TgP3avpwn8tC
         t8eP8x4NQZMfxukTaAfCHMBJpFgCGFUGQGK0vB15ejcKH1nXZnqUJQPrEcgLrI4AXr0n
         iQldqwI13HRYoodS122Q1KUcvSwE6JxdQv0MGkcrUqukdx7aYS8wGQkG8393iUO5xvcb
         W46aQa2wNNU/OrwndCzKJE31slDwehLVAAV6DdYkTlGyxjlwIaCT7BVxvZVc2D3LOPo4
         YQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eQdjtSgPmBAOitqfbEbhL0KWe6W19d0ewiZmP+b4tqo=;
        fh=5bdgxKUqNr/A1c9RrK3aBnwnxUAu/eX91Yky1aeKtXM=;
        b=XgoIfdMmp0Q6WgWxqslaVOKXZKfQTWK7ZTQkmsCtOGvZapVAZP9MwPjb4ruHQF7WgN
         kyu05O52RbfVSkFWYVWialhelFC3upyxe2MZMbDT9Gdmqlx2c76+iuh37SW0E4hwe+0h
         ffQjDjfkINj5qz5nBezh+6EMXXhAl/fRs83tXbqHT5nknmY+r3rXep8IDDR9tnmmMX0R
         0T4PfkkFvhSld6v2xfI8brMgnmXD9k8ReYbKH/+NGkT/56lOX9xKHK5WxGqu22fYwMcK
         LLK/VyXTT7ru4hRfaoTStN2+N7icEqyFSPTA7lH1RcN1oSNlACzGBriH5hEHOQJJCNxL
         bUIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769548092; x=1770152892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQdjtSgPmBAOitqfbEbhL0KWe6W19d0ewiZmP+b4tqo=;
        b=Gu3W5wcwaEqpdFrYhCYOQ9yVsThK5wvVFos7uFLyRYKN5fbGbY3ZY1xf4KYYXkyICF
         IpvwgqRsxRnvl961IuF+MRvxD2qKVCng4J1XVAyISHIanA3yXulfz7C/Gu/TiYeKLtL8
         QilaLHcX8+luNe1oJR+NIyr72ebxfXrDfJ47A4A7XnVXy3Kt8azFluomnepPyGQfWJJ8
         9/NeluIzRQrJGTb6ZY7GLl0n9BwXQWX7HoC8Fx5rjkX55Mq0hgi31MlVy/MJga8OvFLk
         e/QFsNrT2+ja1OovufQF2O+eeWNMxnSNKQrCX9r8awEsLss6LR+7s9Tyt3xXmzGGwO76
         TS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769548092; x=1770152892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQdjtSgPmBAOitqfbEbhL0KWe6W19d0ewiZmP+b4tqo=;
        b=QD/i9Waz4ddhlWpj+kXCHkHxs2mUL428eKGEAibFw3W4fiuLI2wsoF1bWQdOU0NZtU
         3zqJ2r1J3R3LOMdu35DLGVt6RNgX6BJDmqwdcV66mAdckijKuYiap9c5lIUcsSAmCmli
         hsK9vgiiac1SIu+oEVEeoRxHkOWonu4HnPMXbWvYEj/U8E531iUz5M1OaBrJJtMpgXWl
         i2MFmHjJ79tq7yThgSBvR2m6WuWwAQnQdu/2G5w6kQhzzpGyG6qJL7uRj+Z7MhVC9Zzt
         MV7X1Tf2d91VQ0yGDGGi5YD54wS8IvVx/zY3ugIt7xSyrB4xUpVXPirXqmOhKnZV6/GO
         nLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3kjOk8XWaJXUgU4AteBnRjRVd8Q6ZUAHHHK5frGEWjbD/dWAvoP0t4xzaPxA+6HLhgbpg6P/J+v/IeGLXRN3q@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT7LzNNa1stMs+pT8iGDopnM5zr+eznTjU0WDgf00y8o4XKeI
	q+HM+xxhxJh4raSITlTCn9Rnf2stBIQhpkNTMMjrY62OpwsidMHyOfwcKfj9goYy+XGqXZn7n0D
	cN/sNW5en5BFm7q4qMHYQ4scuyoGRWWk=
X-Gm-Gg: AZuq6aJRmvyZtD7cCqSIk0Q5UU1kfgRONfuo1euQdWcGCJSaBOLD8MYUvYksAgxJW0M
	rjNyQvHyEqaqZ/bELSi/eVeFLHcrBetJakdscHHifRrHoRb6QOqiIIp7zfvBDDzJjLmWgCLIX/j
	x6K6JgKy/FSci9Q3Khdqocec2PhvkLzU8zJ+d7GoTtNhMZqtaTyrMKIQBAKRXnszj9wN4wEl9Zm
	WLNfQkr4bZRXJkNudEFUP5pjqAfg8cwbOSDHp9QFWria8N/mKwYyZYL/R0xx7A/FU8/snD6lKJw
	8ej3VeN7RW18XJhXzqN1gA==
X-Received: by 2002:a17:90a:ee88:b0:353:3f04:1b78 with SMTP id
 98e67ed59e1d1-353fecd096emr1923735a91.4.1769548091806; Tue, 27 Jan 2026
 13:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev> <20260126074331.815684-3-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 13:07:58 -0800
X-Gm-Features: AZwV_QgA8I1tZ-9gW_jo_xgJ3AGB6q-m9rfSy7EoPH9GLYmxOLzle356wwR0nM0
Message-ID: <CAEf4BzZq8g_BciT3JNXuYZpzq9zphaVsvOTuOVnqjDS=9w73Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 11:45=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> From BPF stack map, we want to ensure that the callchain buffer
> will not be overwritten by other preemptive tasks and we also aim
> to reduce the preempt disable interval, Based on the suggestions from Pet=
er
> and Andrrii, export new API __get_perf_callchain and the usage scenarios
> are as follows from BPF side:
>
> preempt_disable()
> entry =3D get_callchain_entry()
> preempt_enable()
> __get_perf_callchain(entry)
> put_callchain_entry(entry)
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/perf_event.h |  5 +++++
>  kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 12 deletions(-)

[...]

> +struct perf_callchain_entry *
> +get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> +                  u32 max_stack, bool crosstask, bool add_mark, u64 defe=
r_cookie)
> +{
> +       struct perf_callchain_entry *entry;
> +       int ret;
> +
> +       entry =3D get_callchain_entry();
> +       if (!entry)
> +               return NULL;
>
> -exit_put:
> +       ret =3D __get_perf_callchain(entry, regs, kernel, user, max_stack=
, crosstask, add_mark,
> +                                  defer_cookie);
>         put_callchain_entry(entry);
> +       if (ret)
> +               entry =3D NULL;
>

purely stylistical nit, so this can be ignored if you disagree, but I
find code that modifies some variable before returning it slightly
less preferable to more explicit:


if (__get_perf_callchain(...)) {
    put_callchain_entry(entry);
    return NULL;
}

return entry;

>         return entry;
>  }

> --
> 2.48.1
>
