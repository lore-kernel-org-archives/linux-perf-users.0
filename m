Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BF937E2FD
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599522; cv=pass; b=u9C6u2/NVSMkcwD3DA8cD+BiiD1T/AOmXNUNz9tm3Et53yU1z9T9UIFaA9+G8qXCMubzg1XY8o2DPa40vdVSj9tIk4r4kNMxsXIiKKk+J9r38VIs7TlzwXGL5jMmlOrPTbHYS5AiQ80ib6l5hnQIk6DBKEZeHAYCMWsRaHhkT2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599522; c=relaxed/simple;
	bh=uqQR5A+NApAFfcJB/0uAzfApelqazJ7yoMmqs7u1qKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaQmmWrkUKdO4/obV2P4bDLvv2vy7KReMhs/5xjPc2648tIs3TK3V7WBcN1iy2JnqAIq6aNmkPz8qCrAbLFm8dFvCtl5jvdaOuf6g+0eYuPCUa7Flb3v8QO0fu9M57i6KpEn54ecaVwCTmEp9jrZQu9W0PBNMLjDRR1kaGTUZGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCy0abPU; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCy0abPU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so735ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 08:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778599520; cv=none;
        d=google.com; s=arc-20240605;
        b=FXSgWlH8T7t2deaG+DfYvzbeMoYbUuVxQoo6J/+XheyqiqgjPP6NIuH1rDfeZm88ay
         thFcn5DHcJIoobX48G4o5NoKzj2i9I8Z3nV9SD9GTu/DYVbdbs4QiJQsJhbhgALV2LQu
         0FKMW7JJsPvw1Rcdq6K6nS4wXFwPKuivWXqD34YvZ/f8Q90vNfndjDWpzvnS4kVayfoX
         +8CQcPCIiXjRV7tvUxU76fwN7i8Pwempyfh4N1ZYQC3+1e12Tva7MfruQXtI7JuqefWR
         ExW+uOS/Fu1WU18C+pVg5rLmA5a9rWkIWbORHcHGzeJr02esxoSwqSNqEPgfoEZDD8Ch
         +xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pCF8EF9uhuCXnTADA0Lz5Q0Xn3rxqcJFaJu6fvaWxf8=;
        fh=PEbx8RKpkibU8PTtV+g8A5OGNj+rmsNb4SsiunPsSmo=;
        b=ekhf/aDc+PRHztJc3i/61KQ4bNsjGfZ6u3SHKLIN65EsUDE5qZCbpDOL+tv8cHSRdJ
         FQBypD9h7OdKDJltGU7xOblg7kvbMJrQKuTCf6trKwCIPUVY1MWjg2Sp+v8EtrzNQ5qS
         r+MdHURUv0p0Yo8ROHCxqeXp8RtxmTowj/ALuy4PDbAXwqCQhgsMslWQHfgE7GyOwP6z
         NdAjViYyA0aBJ5LlQyXET+Hu987ux41Ua24ozbaOGVI/UfByygl03C3Xc6DlBpTtftWd
         zgnEv4/OnyLppLT6q2BJ8XVrsX4MC+Kg9oocqqoTnL7RNDTuVfFo7ooeminOKss/x8Hc
         ++uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778599520; x=1779204320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCF8EF9uhuCXnTADA0Lz5Q0Xn3rxqcJFaJu6fvaWxf8=;
        b=pCy0abPUUGjIi2+HFAV6vm+hGIvyydbtmEM4RbPPsG4HKvjTIaI/4CRo2OT9egLr1Z
         tGGePN7kW7pZnTR3uzmpvXCHNAaLWn02A10nCXc+wE1hVwka/y/inbLXCh1uG2SpufzS
         UlQ/KlKXrK56PzO7LaCbJnyDF4vitWdl8qvp1abZxKXdWJa5Xpt593cjck4JYBgC2R4U
         Gb/7DYhToWXDnD9kvzuR/AUQQV9zYNz3uZEewB9iGj6ReXlKlRbvOLkbqS3DdKkzCCoQ
         sLAg0oYGVP3VTM0Ba9gr7j5nrwaBLghMWi+a+0xjD/waCef5TKa4j95+dJY0MCAwbHPj
         59BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599520; x=1779204320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pCF8EF9uhuCXnTADA0Lz5Q0Xn3rxqcJFaJu6fvaWxf8=;
        b=n7b82Fj78WbPcbYkYeLaY9WkDN39FCWhtq2dJARdAXPzcDmsSijwA0ZGbpwupFFCqD
         x1+Npx3WjWu0L1y7kMUWrARvrWbW9GI3L02ox37Fuc+d9ig2nXRtwnWhfslUQ1vn2uba
         wSzLsd8g54YM/DjyVdVCuXmx03Tl16vf2Ug6DSzucExH7PVoEoAmfW5FZEExzd+82vke
         VDvtWIMkaI4vIW1s098+FalO/2XK89elv2+r6KamDTz1R+swlLic/Y6qqZgq36HZhD/Z
         6mTV9GUWleb2VMg5MWUdV1wpHHgivHp7stsgjVGfEmxe1MirR4jy5PfVMdIT5MHqNOfb
         4NJA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ugkqs9DJH+CZpwVElOuj/lyZBFfBiFur/tjFMKgBj/sBT2pFtTDNGtfoAm3lxVL7ADLaeGa4JYOxkCiiYEN2H@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuiN0vn0UMgk13kx2gdQgGeBI3QAug93ZY1ee31NulvfCm1UV
	Zdjt1f4yRMuMnZSGyGi6bZarWAzy0Olwe5DRySb2jDR4qTU7krouojwWONHQNsiCAUI6M3uOTqm
	hHk4OYsWRKrTHXIYNEhKmPqKgLEM5duV8mDIWLGLJ
X-Gm-Gg: Acq92OEMWTiEtdnxB7ltiJhDxtqTTAgaEDB+beaCumMmWJ1iy8sfHIU4VakMWyYzrLl
	uDD1r4jXQ36Wiw0WL37y/sAHdp67pebqRnzZsu5GFEqqK4Uup6E8D3vg4J4UlNggUVQ7CX+DhJz
	Z8EA/wPm8R+AxlyDVf6VQ21SiTulG+6V8vUd5DxZWOqsMINx4rPE50nK/Lr+/omXjyOi6Ax+qD/
	kJH8Cy9LJv1i4s7kjHc72cFXhjBPcufjliinMuOhrv5p+LCFy7Kq4S3sKYFDu9RW0IOAsBs4qQr
	Y9BFGfqYRRqrfo+J9oBMogd6RUE9guoKf84LEFWWB7uVQZPu
X-Received: by 2002:a17:902:d2c5:b0:2b2:70ba:305c with SMTP id
 d9443c01a7336-2bd02d427d7mr2646245ad.8.1778599519898; Tue, 12 May 2026
 08:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512120408.59332-1-gautam@linux.ibm.com>
In-Reply-To: <20260512120408.59332-1-gautam@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 08:25:08 -0700
X-Gm-Features: AVHnY4KscqlZT4Uqne60gnuuNIQFVcY_1jsFyYGu2W1Zp30pR_YDSXLM1EVq4T4
Message-ID: <CAP-5=fUzQRCpF4U_0dnPxrx5sa3U-XbpLzn=c=EbeRsCY2=dPw@mail.gmail.com>
Subject: Re: [PATCH] perf kvm stat: Update the exit reason mappings
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 5:04=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.c=
om> wrote:
>
> Sync the exit reason mappings with the mappings in trace_book3s.h

I see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/powerpc/kvm/trace_book3s.h
Would it make sense to have a copy in perf and use the check headers
code to keep them in sync?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/check-headers.sh

Could you add the commits that add the H_VIRT and H_FAC_UNAVAIL
definitions? I don't see them in Linus' tree yet.

Thanks,
Ian

> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  tools/perf/util/kvm-stat-arch/book3s_hv_exits.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h b/tools/perf=
/util/kvm-stat-arch/book3s_hv_exits.h
> index 2011376c7ab5..2688ca7d0399 100644
> --- a/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> +++ b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
> @@ -26,8 +26,10 @@
>         {0xe00, "H_DATA_STORAGE"}, \
>         {0xe20, "H_INST_STORAGE"}, \
>         {0xe40, "H_EMUL_ASSIST"}, \
> +       {0xea0, "H_VIRT"}, \
>         {0xf00, "PERFMON"}, \
>         {0xf20, "ALTIVEC"}, \
> -       {0xf40, "VSX"}
> +       {0xf40, "VSX"}, \
> +       {0xf80, "H_FAC_UNAVAIL"}
>
>  #endif
> --
> 2.53.0
>
