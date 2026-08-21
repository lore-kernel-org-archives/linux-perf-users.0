Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEA1F8723
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337250; cv=pass; b=dThX63VO2klDoa9qAFW5mcgOTUgz3RG0eE9rDv3uH9U/ByOgjLtHYrdwLXTWljf1qSvnp5o7mA5dufKYpHsHjMiBS/leZt0h12KswOVer/5ZRwBr5irOfFhcc16flijx/1a7WPqJI5fdobjoNsLu1p2OH3W+KC6VA5NMRXKFWH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337250; c=relaxed/simple;
	bh=2A92KqKoCJmcZ56ZasJV/t7WaDXgH6qSgLNOV+CEQaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8wlAuCkPOKIdztIAuivGEC2BvDgw7ycLsyIupZdBp4kW9MHkkugv15s9uQjlwOuDwiNkHuSPUyTSn6i66TKTZZ2XOunB2D1M1IiGIitKUrabYuy0zguTmYkMSV63/YeLQQs8BqrioetPSezmsp1WOn6khn+TxQextZbll5i4ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUeypJUo; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUeypJUo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso951985a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 11:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787337248; cv=none;
        d=google.com; s=arc-20260327;
        b=dIUTyIGV7BUBdV40S+xof2ZCiYF1Y8pqoJQ8H9fi1vErp9mWCq4seqYTbXXibrlrDd
         NxGPnPAwty1aqN4wC9PT8ukNSnuOERdIkVmfOUXR8YLIhmm21Pa4MwW7E6kGhOIGSmAo
         Y0YWeq+iaytJwsxHWNgN2dJSoRjOYeuvbgBI0YDpnd7SFK2KLe/sZs92mS+z3JoiBW6I
         ZY0n635bIDhbSuK0QmjZ1GuV75inMbjnRcQ502gmPC1gwClIaCHUkEx7x9wCWvwpappt
         SQpHmXVFfU9ofQ/VpmCay8YIaP2qGfGBQH0nmps/qYKYT+sPn1k9LkdvVEDpso8LqaV9
         3n/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0Ukbw5yEgIofWImq0KqMRHmw7+kGVu41QRqHiQ2DTo=;
        fh=Gy0WA4i3gCVvRd6pBXQiyjPn0sa2o9QCPzSsFUGu1SA=;
        b=n7zixbGGX+fPv0dbINv0ajuK0mT1M41cZI89CCxqECGQT9hvwNtTwFWE6VM+HDVSin
         mHVYomIltJ9ZeOGMdS8AOahikNezUza784vs9PEgMz60znrUgjVoKY1zpXCtTtzxXJof
         IEQg2ciew0dHK6xAVRupprQPgS/VPQ7PtPV/8XnDuRy32T4ClOFyMJKZNRU9v48CdSXz
         w3x0sXUTM1OzOwLZ8unfSLk9shk4HO/UhEIFiGyafswSIx6gWOvNIFBxFflfvfAzfdgK
         KTV4jlUN6yxNRcI7A5W2i4W/oJLSx5TkejvV3voOVm8ZMpQ3JGNbLO4oYr0kKimqn0qS
         9jDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787337248; x=1787942048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0Ukbw5yEgIofWImq0KqMRHmw7+kGVu41QRqHiQ2DTo=;
        b=rUeypJUoO2uLmKZLOE7GfBMYob3PTQ79N2DcnLL/LhJC9mDO3pnAKaNL6TNfaECykp
         CcamObRLnWx4MkSQST827fTRgvOgLogbCnIX2KEEb09oBCGGzv4lgmL/m5O2GLzPftsQ
         qY3DXd/vAAzAVewNLOE69Kt1QpZb++e+P/jcjl6iotOmTmpoM3mGMankC5y8lfISy00Y
         7UZ+bDBD/BaS5AyeE8fWo13zbjIA3PWepTsJ9JRnGSveeGHu4NTpPQBJEAPmWUvpwtc3
         jmeef3xFBzApf3iKM4ztzTGKpD2ywjEc2b5AqP/xFc6RLEIfryNNrSqzG93pknqk0a19
         obww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787337248; x=1787942048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0Ukbw5yEgIofWImq0KqMRHmw7+kGVu41QRqHiQ2DTo=;
        b=GgYeNiHXHkPa1+riIFTORK3XjJOo74ww6J/SZXKgvq1bDv0whZq+OPMqNIaSP72oRu
         J+eqynND5Cs+UfJWCZT0TkAOoZd3wqPG1x3MK9z2Kt+LTR7tlvWn/yBHeueuxGWi/v9R
         gu+oFtMzTrIqIwJecg1+cm4OrN0xr6+Fb2HEKGVVyevlcDenZUwi+XWw642hAmNuuweW
         4iHfrGN7DPakaBvzHg1BS1jzhgXay8F1NCB2Uyldb2Yxtlya9mzHi/LVSLJK2YDndreg
         Gb0aIK4yn725UXXISubjqul4loguJI2GNoupTCwbqkgvu4AMjUcSnJ3MgSEZq8Lt/dEP
         XTqg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+pgHULcAIGp2nHvUgQQo8vO/ce9dVjLCA0VSOuOR0l2iDdemzQPtckndz6B/DeiEY5XjalFiafriH0cD+jAZI@vger.kernel.org
X-Gm-Message-State: AFuF++kzLlKvxu1eWs7CKj0oq23/A6xJs4QTsfvqraoIaFJHgYUjkRan
	j2uIVp4967GjI9gOJ5CeaaGafeorTOPsh4qSa2zW6JMsA+r4plir4nCD3rA/NEzlK5hxUiprY6W
	gc74wU8kr7r15VvT/2FlZEnBr803R3YU=
X-Gm-Gg: AR+sD13y3KP8wWYOJ0Jri8zYsschaEtTxXl6JVk3WBAOgc787TtH2Bo01rZngSQrfuG
	KjzpoPnGi+jw6ggRSFLhkaJOseruyUUeUjfJcehs5w6l8Nw3s21TBoi0j465/Lz7o5T3VLAzx8m
	TXd34St3lTi3I1hqUWojEMILq6NJ0jJuYScXL+C+hcvJw+9hh5TA6sIeggZJ7HrlQYYuXjTcdF0
	5lJJS7iWfw21YnNL/h5R4t6E5SfNfzcYH16Lqfs+7GM2vDNfDLBOzfGgsXO8eQfo/nkE6fjWMuc
	9uCQtPLwt3ObIWwjDgMqtN87yW/7KBV6lsh90Jeus+oX1oDV56V5Bn9UdHl3vvP/ZjmAQDPi0S9
	tDp9vzgC2MOrEnoGt7Kfm9NwYoVQKJZ9exiq3
X-Received: by 2002:a05:6a21:3a45:b0:3cc:fb7d:a9ab with SMTP id
 adf61e73a8af0-3cd4b9ea5famr1632166637.2.1787337248227; Fri, 21 Aug 2026
 11:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821014210.18681-1-kartikey406@gmail.com>
In-Reply-To: <20260821014210.18681-1-kartikey406@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:33:54 -0700
X-Gm-Features: AcwNN1UMxCVEBEK7W_zIG4V60WyE6AsN7ajAZMnJmYaQz6_nFKVc9evdZTs2M6Q
Message-ID: <CAEf4BzazKkRiOCAAERt6YueeVYnnYeNEPmxH+EW3F4CR_YVjsQ@mail.gmail.com>
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, olsajiri@gmail.com, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kpsingh@kernel.org, 
	matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 6:42=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> During fork(), perf_event_alloc() reads parent_event->prog locklessly
> which can race with a concurrent bpf_perf_link_release() clearing and
> freeing the prog via perf_event_detach_bpf_prog(). This can result in
> a NULL pointer dereference or use-after-free in bpf_prog_inc().
>
> Fix by holding bpf_event_mutex when inheriting the BPF program during
> fork(). Make bpf_event_mutex non-static and declare it extern in
> perf_event.h so it is accessible from kernel/events/core.c.
>
> Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  include/linux/perf_event.h | 2 ++
>  kernel/events/core.c       | 8 +++++---
>  kernel/trace/bpf_trace.c   | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..5c6dabb6dccb 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
>  }
>  #endif
>
> +extern struct mutex bpf_event_mutex;
> +

exposing this mutex like that is definitely a smell.

AI tells me that this perf event inheritance case can happen for
non-tracing (i.e., BPF_PROG_TYPE_PERF_EVENT) events, which are
attached while holding perf_event_ctx_lock, not the bpf_event_mutex
(this one is held for tracepoint/kprobe/uprobe programs).

Please validate and adjust the fix.

>  #endif /* _LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7..a89e33c47073 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13433,12 +13433,15 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (parent_event->prog) {
> -                       struct bpf_prog *prog =3D parent_event->prog;
> -
> +               struct bpf_prog *prog;
> +
> +               mutex_lock(&bpf_event_mutex);
> +               prog =3D parent_event->prog;
> +               if (prog) {
>                         bpf_prog_inc(prog);
>                         event->prog =3D prog;
>                 }
> +               mutex_unlock(&bpf_event_mutex);
>  #endif
>         }
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 75495a5c3507..730fc22a9daa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_o=
ps =3D {
>  const struct bpf_prog_ops perf_event_prog_ops =3D {
>  };
>
> -static DEFINE_MUTEX(bpf_event_mutex);
> +DEFINE_MUTEX(bpf_event_mutex);
>
>  #define BPF_TRACE_MAX_PROGS 64
>
> --
> 2.43.0
>
