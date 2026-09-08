Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43764915BC
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911826; cv=pass; b=fcE7otYbfDUoJyVYDVRFv6TfYVqK5f4XzKAcmGqtcqQ/miL1oESOUBBObJY50Zp1eQTm9bCX/QYg18VQRQQg/45xVqBab9SDJ9moQh+XIef+DiVL7RdC1CXzVgeOM+4FKznwzuPL9A+2TmNOIKXDBwwbbNpnmLbDncdIvjEYWLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911826; c=relaxed/simple;
	bh=628eJwJ9wuOWW1/lXqL89nVW0Y/ymQ6HB1IV5BIVpVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+DJ6B+oa1b7++9y3kqmTxOOw0cf7HIDPDQbUICzDwyMGICkfdcENWB2/6dVc2CP2k7yjThOT0jRSPqHi5KLlIOmUPyyK0F2xpR6FQUzVGihf7Y5bfRiRbpBr8WuqttzCpOKqNtZIsQgNPnZuEqfCkV69ydQM3O7VBQ4YD+8iQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHlL7GiX; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHlL7GiX"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so5560676a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 16:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788911824; cv=none;
        d=google.com; s=arc-20260327;
        b=O3bdywce7F5c2vVwHUxTjzmoRZS9oiy2ZP9leeUsCTUCoynLc/5o2Clkslbe80IRvo
         TrR27n4MJMIl7FaVnrOn7qOvg3Db6G8AVcRJE/1jwonFr5s3aZz4UkzWp5nO+n7kEGEL
         GPm+iLLNod7a8HqcZ9hxqsej7uQYA2ZYGmr76e6MjINCm9SBuHyLjFiOJ4rl8+etJd+N
         LyaSUaIbjWIK1GZWurXCEudsIRW/RmnR0ZQabQFVBisBm9yzKqSa1VU5PNSAMYuen0t/
         nMsYNJpY+UxVxuWzTiLCbCiOMk8robm8XLoUJarNITZtgc6kC/N3EWI7n59vSbkKU8fz
         QzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUbke3agCBehQZD3LTnsv+Yr1q7SSgAI36/xYk34inM=;
        fh=XLosR5e30pMWupmbnDyqs6uehjYguC7JBmUqftTRYbs=;
        b=eZfnn8DYEO5aSyJBDYClON4L33DUknPz2tDK69EeRNbofNn8yPNuEA7DYftH5WOJE5
         9wW7oD1ftRfPOSa4pMDNuax+mumxGgYsBVZdalOeSUV7oO9PpGT4eeqIdcytNw0+2sU2
         dnfWcG+S4X00V7G8xOnkbYAS6VMhcrcVAcZcAMPUfRJHe+lqMJmD99R6nh/rntAi0oKe
         OO+44wXdcVHA66fIltH1ePQY5brjIybicVXqfj4d5A2WTROWW6me4Ock8CnDGS4eHmpB
         W4QoTPoV8SMLz+H4flL+0loIOcAl+Eo9kSqE6GMAUgMRzPL8US2UoUM2f/7O2mRk9NCz
         zSpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788911824; x=1789516624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OUbke3agCBehQZD3LTnsv+Yr1q7SSgAI36/xYk34inM=;
        b=lHlL7GiXAHCV0CeKGqj6ghTv706fQs5ZOZVJiBm6VCJi+d+U+SZwdswMLT4xeD7LIC
         qDKaTGzI8w6KpIi0CTCagB1HkSjYvLfSbQJeOFpvWlrFMm94NV1Swv3RY6FYp6ifJHCt
         YHlIK1e1gsPT88Eet0QxfdKMkY0q/G6w0TOqkAjKXKHbBjAJk+I/xcK16CHDpffv9Buw
         cgrbYbxEKNVLH1PUbp/3g9elyOmv7a/qDFcaQDoX8NjwedgzrQOpL0ki92tCzgnUY4lx
         g+MNgzvS6zqmyeCjEepL+KbBPTRwfPD28KeKEFeF6WMUWXXc7q6/wB/xUwJvam6MYj3k
         vXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911824; x=1789516624;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUbke3agCBehQZD3LTnsv+Yr1q7SSgAI36/xYk34inM=;
        b=NeMT+1HfSCNaqoSRUB8g3lBClYOWHWwR2PCBulgn67szhsJmadYRHGhjapNHoiRJBl
         mTuDDf0NzAqeUMO+sN6A+L/fNuk02zyXT4aAfcEbgTcF4RWICeaDZXGjbpYK80MixqLD
         N9wXDD0BzeHMwMRfS6EpWNFV7z6asvxQ5YPhajG0mkG0Fi7QGk1STJITt9SWK5tJs1sf
         gM55Ai0wWV11jyEyIzrx5a9yP7nLptZbyDobyk290EmRS3L9jY1+PUwYJ1w2vuX/vr36
         PPjL/B09SPvft8Raq2ry7KhcNKxHEfhj9sCjEwbYrYZz/ZyNz5E0oe0tdspkMd7Rfzyu
         vG3w==
X-Forwarded-Encrypted: i=1; AKwUvByhU8XoCUOc7JHW9TUOW90ApRAbvrmEn32HVjXOoq5lMb1r5TgWgwP31akeb9ZyQmMu4FAy8tpfFcTGKpVAiDIT@vger.kernel.org
X-Gm-Message-State: AFuF++l7ZVDPxJEzTp7+vClafzAVcg0X4k9dPDoLmJ5nWX04KlY8zETY
	VdBtEPJKWpGgVBevhOaBf60HGb1KQ+AoXXIdpKjhBbyKdMFxxvk6QcAryEYjqMBv2v2D5G2pz3N
	e+2VvUDMhgED5jWlYtUzRCDlIFcVLJes=
X-Gm-Gg: AYBFou3/72uvSEM4Ikqsi8Zn5hBAw5II3GcEcb7tTYbjIiajCU4h0IZE03rZFBFmnY2
	XzQRovW4r65gp66YuZYSgVvSPbsH8ns5T8k932wpmAYV0wCBl1Z/k9YemTl+SaSbBGAJwjIuRf+
	UYyNOA0+gDCht9gblRfJXOc1CBZUn9KI0criOk+VQTvCsp2Hq0OrMaASQdv3fBPfxXSyfJpwZFS
	lauzIZYrkhtOn96VZGrWbYGCy5JP88wKGuuF72BQYwb7Iw9ujvKy6VHlJnHj2DYRWqrGyS2kFu2
	C9TXt/gKqbvk52b8XBF+bukDXmVNDOICUNAfdNhqBhaPFf1Udq/GF5ZE6ELbY0ukLuiYX5iixcW
	/4fFY8HNyxZHypvshiDIEx33BOLkTUPROlOWszfOksQ==
X-Received: by 2002:a17:90b:17c2:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-39b25f1c5bdmr44794040a91.0.1788911824009; Tue, 08 Sep 2026
 16:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com> <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 8 Sep 2026 16:56:49 -0700
X-Gm-Features: AcwNN1VUyICb33m7c5chcJwIX9wvZPXxMox9HJyQvMTJTGld-kg0qcmeLgTy1AI
Message-ID: <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot state
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:27=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> A perf counter can be zero at fentry. PMU multiplexing can schedule the
> event during the BPF program. The old counter check then drops a valid
> sample.
>
> Use an armed flag to track each successful fentry snapshot. Reset all
> flags before new reads. The fexit path clears each flag when it consumes
> the snapshot.
>
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftoo=
l/skeleton/profiler.bpf.c
> index f48c783cb9f7..6c654bd9b346 100644
> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
>         __u64 running;
>  } __attribute__((preserve_access_index));
>
> +struct profile_reading {
> +       struct bpf_perf_event_value___local value;
> +       bool armed;
> +};
> +
>  /* map of perf event fds, num_cpu * num_metric entries */
>  struct {
>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> @@ -21,7 +26,7 @@ struct {
>  struct {
>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>         __uint(key_size, sizeof(u32));
> -       __uint(value_size, sizeof(struct bpf_perf_event_value___local));

this is not a bug, but... ;)


struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
___local variant?...


> +       __uint(value_size, sizeof(struct profile_reading));
>  } fentry_readings SEC(".maps");
>
>  /* accumulated readings */
> @@ -45,7 +50,7 @@ const volatile __u32 num_metric =3D 1;
>  SEC("fentry/XXX")
>  int BPF_PROG(fentry_XXX)
>  {
> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
>         u32 key =3D bpf_get_smp_processor_id();
>         u32 i;
>
> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
>                 ptrs[i] =3D bpf_map_lookup_elem(&fentry_readings, &flag);
>                 if (!ptrs[i])
>                         return 0;
> +               ptrs[i]->armed =3D false;
>         }

this is preexisting, but why do we have two separate loops: first
lookup up fentry_readings pointers, and then separately a) reading
perf counters into local variable just to b) immediately copy it into
map_value.

can you try simplifying this and doing bpf_perf_event_read_value()
into ptrs[i] directly? all within the same loop?

it might have been some verifier issue, not sure, but I think this
should work just fine

>
>         for (i =3D 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
>                                                 sizeof(reading));
>                 if (err)
>                         return 0;
> -               *(ptrs[i]) =3D reading;
> +               ptrs[i]->value =3D reading;
> +               ptrs[i]->armed =3D true;
>                 key +=3D num_cpu;
>         }
>
> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
>  static inline void
>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>  {
> -       struct bpf_perf_event_value___local *before, diff;
> +       struct profile_reading *before;
> +       struct bpf_perf_event_value___local diff;
>
>         before =3D bpf_map_lookup_elem(&fentry_readings, &id);
>         /* only account samples with a valid fentry_reading */
> -       if (before && before->counter) {
> +       if (before && before->armed) {

this is such an unlikely situation that I wouldn't even bother
"fixing" it, tbh. alternatively we can check enabled or running for
zero, I don't think realistically enabled can be zero if we actually
captured it an fentry

pw-bot: cr


>                 struct bpf_perf_event_value___local *accum;
>
> -               diff.counter =3D after->counter - before->counter;
> -               diff.enabled =3D after->enabled - before->enabled;
> -               diff.running =3D after->running - before->running;
> +               before->armed =3D false;
> +               diff.counter =3D after->counter - before->value.counter;
> +               diff.enabled =3D after->enabled - before->value.enabled;
> +               diff.running =3D after->running - before->value.running;
>
>                 accum =3D bpf_map_lookup_elem(&accum_readings, &id);
>                 if (accum) {
>
> --
> 2.53.0-Meta
>
