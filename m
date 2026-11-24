Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795553119;
	b=Jq0MABtYpa/JPw4fHQS9C9hL8GzncUpozRmTAd8Z0IkkF4Bh02NNUxyURG/VWXo+fsRA
	 2X29GsCjclEip1G/LtPwWCrEluyCQkgEeqTLHtFrke9sw7yeLnEp3mOOG+aeyYpskszRu
	 0uQTvVoT9bXnsm7lHsDUqT/Pbk1CDd9+W1w+2qmyw6qQj0B2i5IgRR0QJYyz+5GkENok0
	 MoLp4KhvBiM2aAagNgax+PrDr8Gdcpmxfngh84XNv6s5e50D7f2i0PdM9fSEOItBOTENI
	 CW8qlGdk21SXKLgd9Gdzy68RexsTDVrT5svHKdE30K0parGeLH7JOnZQ8DKI+WzCbpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
	b=z/A0I6NJ7eihgdXzUvHRiElc5mFJ+rGBBvV6YeduZPENI2YsnG4dvJEQbgEELAx3utTJ
	 JNLFXRkKX9YS09jHJlaydCBmSF5LDTHvej4zkQZIxcQq1mXVTF+pW57E1hnJYDOEQ6uaG
	 Nx+PuaU0f1ak5RRyYeLnNTjl2+fy1j/C/S635UPD4ou0BudSG7lYLb1nAF0NrXZF/Fhna
	 feAxZrOST3X2pX39Snu4U6JiYwH/CtF3EK/iArSn9+or601cHHxHgdN5ZHLeRjHwWgnT8
	 ZM5h4cRcuKq+YfxO8XSlkMEHJJPJ5eWEhahtM8zoY5Zpy3eDTyqXILzlhnTyDGbs7OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCn08jhD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F13606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 20:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F13606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCn08jhD
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso3183339f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 12:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795553117; cv=none;
        d=google.com; s=arc-20260327;
        b=oiBLBcWiwtG+n6myHLfBdCZVokiBP564RQqdKUFelRR2dvF+Rh7tgfd+TxN4UIlYFF
         g8bqbKRRfvP563Dxd7OyYwjUhC1p/cTjyqPMJ1m+Aa40P0ISkIF+tseqkuRhwlIiKzjs
         FuhHE7v1LxgdYt6cGXaiqF78BiibvrpWjg7ZWSN6eQyaTElUDUedVgLvCzhFh0mrfd3f
         Ro6mdzzULQS7/OMM+PPvpJIskb8BcfZD0Zn+PaCFPDvPLtnQM6m6GLNbKuAfAt0eFT7K
         jWAOgIGpPT1CV8erSzLIYXJCaDPC8wH1vnSqQyQFlkQ9OYK/xjqDXqN3r3A088Dwj9aT
         /JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
        fh=YZFAaTuJ0wN48JKq79cCO6qaifXZDLMA1UjJIwzqJNM=;
        b=lhERsbR9pyZjIK+O5qCGP8IAlT0zI5xZ6mgur0SqbScW21mUe+nl+k2KjBXiiHbZSP
         mQYB8bzY1qKUwruMy3KG9avajM+GH8nMRpGJ4AMqCG0oWEXQJSCtl6c+L0qmvJsurEIc
         W7Sjx8FiX9aNRlbqGnQiOLqYCuNJoT0Ppjtod3yWMrUOTSmPC3b0Ttu5S7ZM3kykkU3/
         xNCuoK/8FsHKCCIwX4b4lvrBiXRaRugkT4OQqHuOGwYdorKILezn34xISM40WP4f05fN
         EyFA3KgjhK4Rv0vJid27FgEDJkCtrFuhV7HTcouzKTaek31FMbLufOlpupK6XJcusoop
         vtOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553117; x=1796157917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
        b=BCn08jhD6dcYbL56FcmbIIqgSM3gcFwqBKX9r6iUjsIpRs4WjR+nWaRsTDMQXV5nvf
         0kFxr/r4fBMk843u4DR3ThQfMWFDWQXi85yEKZOwQpFqeJFrfokTeb3yGCpaJXJEKRHD
         qi6uzJcqiK1gwuwHOty1ibHtqyAUbAcGoTpb2nvCRwR/qx1ua29ambFTT2LJ67u/1dqp
         jRZtngHp/I4LBrn5n5iV3/TyL6e97093+e4xAL8+WsEQPCH5S7WtTfYO0li5xffoWl8u
         WwKAPyTNxUqObsAl26U8ceWbBAMG1kPhocd05VVev/25Km61QfRwcUIzr/sHXiFfQ/4D
         UiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553117; x=1796157917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
        b=uIefQm0DJSIkkbfkT/X95Yg9sjIBb28koPYFBTrsf5ZNytTPlXOkHqxkZGWJnfyzts
         bnPqDZ1/yQzN7IwqfR2up0dyIwhpuf/BXIeFFjoGU3M7cPC+/R8TVQ4l5KRyQ3zlCWlQ
         oXONGFIQc6DzX6rNmUlqF1qw2zG6fLe5qB9zbU+OzU0f4tnFrlwD7BoBiAjt0sVwZScj
         ROXl9lMQggvI4lMicAzY2TT65UKhpOZqI9YHFdY2MYIIfWvHInf54hcXaZcSeFDFPjWL
         tmZo2sf5NPy/A7AYY1IDZXZByqRxD5FoS9gQu8XAv6YH2w8tR+XwiDqL2pcNmLWTMgpm
         kG8w==
X-Forwarded-Encrypted: i=1; AL+hErHThMjGjnN8wi6EvB+I0dR3cPwKrpzq/ZKy447IAZizuzR5O1oOHrgo5gbGufZiVTymXNO0TlStVSrM/o67zIhJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+l4ao0uak9Dxy9KcAZ6ttEPKO9nFn23rjjk+XJVe9fa6vUz00l
	EkBh6vZPGgEfOz+08c602GixCZ8ZLf/dBNsRtjV0gsJb+fscxQXVees+fRlxA9SEhk71nsJDdYz
	eJmUyDsF0I1oBDsbvRJA/L3WskLSeskE=
X-Gm-Gg: AZFdTZdDlKKcJYkxvWru9NHche8StFAggmAzks6y9UIygXwUZDRCszuPSQCHxCZjswm
	JfARVaUWPZSbsehBMGJtyCiRfLHCLowHJ+ySxi5BdoFYNxA+Kl7W7u1w+ku1U3aZxjPy5KyKO53
	ij9grw6w3Sl2cyFwt28Y5jlcRy5c5UDJfzhTr6rbHW5Rc38/q5vNLmsBUw/H7SFwCwRaZBbr+lU
	f2c//ghkOibfNXAyCUjiGPGBDjvryf1ivAA0CHe0ACZ/63I1bqPcYB1dVVscQxj6W5w8o2Ls7K+
	eAUjFaPW9PDH5IGf2JgXVQGSr1HPR9QbbtstjOGtqTgRt0MfsPVG9NEoYe3yu93e2uRt4ANt+gC
	xz4a/17zrUKSe+Z3zPBpfj9uFcJ4Zql2rBFTTJHjvcGjVRYW/Lotrbg7RvmcwUdTpRpr+7WwKuC
	/dkUNnS2Z7wjhcHHLXIw==
X-Received: by 2002:a05:6000:188b:b0:4af:e519:ccd7 with SMTP id
 ffacd0b85a97d-4afe519cf33mr19369322f8f.3.1795553116730; Tue, 24 Nov 2026
 12:45:16 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124091252.567037-1-thnkslprpt@gmail.com>
In-Reply-To: <20261124091252.567037-1-thnkslprpt@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 12:45:05 -0800
X-Gm-Features: Aa3M54oO4ObFmmKWLKbGgp6jmNEjafbKXGnZR5o2jDkMklXDyCwW4aie0WGn2gQ
Message-ID: <CAEf4BzbfJtEfZtzScW4Gy2UM+7fCV2stzNX19T03fYcYN09wPQ@mail.gmail.com>
Subject: Re: [PATCH v2] uprobes: avoid postponing return-probe SRCU lease expiration
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	andrii@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 1:13=E2=80=AFAM Avi Weiss <thnkslprpt@gmail.com> wr=
ote:
>
> prepare_uretprobe() reprograms the per-task return-instance timer on ever=
y
> successfully installed return probe. If a traced outer function remains
> active while nested traced calls arrive more frequently than the timeout,
> the shared timer keeps moving forward and the outer instance can hold its
> SRCU read-side lease indefinitely. This delays unrelated synchronous upro=
be
> unregister operations that wait for the same SRCU grace period.
>
> Keep the first pending expiry by arming the per-task timer only when it i=
s
> not pending. prepare_uretprobe() is the only rearming producer for the
> current task's timer. Order return-instance publication before the pendin=
g
> check, and order the timer core's detach before the callback reads the
> return-instance list. These full barriers prevent both sides from missing
> an instance at the expiry boundary.
>
> Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with time=
out)")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
> v2:
>  - use timer_pending() and add_timer() for the per-task single producer
>  - explain the actual store/load ordering for the full barriers
>
>  kernel/events/uprobes.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index caf444762a27..838e0080ae1b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2052,6 +2052,13 @@ static void ri_timer(struct timer_list *timer)
>          */
>         raw_write_seqcount_begin(&utask->ri_seqcount);
>
> +       /*
> +        * expire_timers() calls detach_timer() before invoking us.
> +        * Order its pending-state store before loading return_instances.
> +        * A publisher that saw the timer pending must be visible here.
> +        */
> +       smp_mb();
> +
>         for_each_ret_instance_rcu(ri, utask->return_instances)
>                 hprobe_expire(&ri->hprobe, false);
>
> @@ -2304,7 +2311,16 @@ static void prepare_uretprobe(struct uprobe *uprob=
e, struct pt_regs *regs,
>         ri->next =3D utask->return_instances;
>         rcu_assign_pointer(utask->return_instances, ri);
>
> -       mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
> +       /*
> +        * Order the return-instance store before timer_pending() loads
> +        * the pending state. Either the callback sees this instance or
> +        * we rearm the timer.
> +        */
> +       smp_mb();
> +       if (!timer_pending(&utask->ri_timer)) {
> +               utask->ri_timer.expires =3D jiffies + RI_TIMER_PERIOD;
> +               add_timer(&utask->ri_timer);
> +       }
>
>         return;
>  free:
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
