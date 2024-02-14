Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3213F003
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954344; cv=none; b=RYpAj2mvkPH+YjczTzePfrJlmNMyQnTGR33xwBdxq9Og1x22M1yek6yyCRsIj3QdiDZH2rchDBxEu6oHtQfAhRVDAmV+B4H61k90AnuBJ61e1SMJb41rxEsiutr6hSKZWVX76MtskN5+zfh9vhSOK6w3RQ0NDN4BuycJ+hzy66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954344; c=relaxed/simple;
	bh=b10hcijK0qE3BkNp8u5VgKtBYxQGdaTD5bm686/cKgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT2QdwWqMsFdaJCHMmae5wT29NMGmNXkznKC18AD1TXCJhYt5wBavc+3r8jKy+BOgEjMIOsVh8gdx/wD5oDfeDt25lzBLuK9JyU9p1xYsnC+RWzW62hJczS5wylhLAf3sw/Doxlp1sIBQHr5tc3AVUBACVsP8kmxBgk4HnHlMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLCjfMJx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLCjfMJx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d5ce88b51cso47425ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707954342; x=1708559142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5gly/VFOoLySfRJOHKm6JFRHLJyyId6LtcsyMKAaXs=;
        b=fLCjfMJx26kvH/a7e+AQNb5a7oa5KYsOJ06rk4iKwdq05QEjTevilVAWQsDaVv82af
         /iD5LFFinVPpHlbv4P54VM0K0A898IZX0qIXDe7gs3xJXkM4ySGXwKjFhMMUY/TH1B6H
         UA7sCPXT6dLwpao+CQjw5Eoow+1wwZts1pxEYmM87aZ4cFR2zQ+bPxIL44lPcr8aLBl1
         SacTwpZVD3/PhYCUP0uV+jDuNSvp8hqelSd/cKRHrLtoN1xVgLanTgGSGPER0DEi6kB0
         xGRf+re8G995TwBB6ZHgbnma7lSln/KmrFDgX+89m78eYwoQRQr3pdi+JMoDw7EGFvEe
         BQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707954342; x=1708559142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5gly/VFOoLySfRJOHKm6JFRHLJyyId6LtcsyMKAaXs=;
        b=M3/hw+AE/Wux8vJX6N3WlaBDR2Ys/+eMUMKIterZNZn5UC40vvQwBxkZfzwghrvO82
         zL28Ryb8efSptFcU+LdWeQSRk/0hHjj1s3amYE1MGYLbw80071ZNolIVRM+vLgT5Y5sh
         zQY9Zo2Z+XFys2JmCc4Z9B1zuBjTgbMAtaaULqEfwzN2dm8th8E8pR3439espykLBKrC
         PBVor+HSm6wEP9B77JMyvzLSghp+hCJKIaAMqVXu9AjL8NwjBYXxjbt5hACVsXfo2ren
         kPndeC0dvIYZ85oz7vIyMSpqI3tk+Y0XETY4SUek6Qo37yelN2c9jVCNr0jd10M1G0Jw
         U58g==
X-Forwarded-Encrypted: i=1; AJvYcCXrT3h81+LV7WS588FstRatTczGA0nRvMo7dktcedSgRZGm4RWNA1gLqdEeerLgeOt5qkTG/I/DFwGLGYiLdZmSStNDk0uSi5xf6lAbxL82UQ==
X-Gm-Message-State: AOJu0Yw1orB7lXIbK7EtElr/5v5+YvkpGBvypHjukstgqFf9N8irdyfC
	CWz8nwhKPvfMGhQwt63lqAMwRV1hbqPLzyQ8qCrufiy65FPtvb7P1yU9psIPectElB2WiYvyMRl
	w4qzY9eH4Gp5oyKZCBfQlUUkSeM4e79r4cmVP
X-Google-Smtp-Source: AGHT+IHVwUB8LIh0FA6G+cYFDq6/LDCPW9SbA6YjALRn94EPRW5oD0V+gydguAGzjtnOf5jkpbatb3l7pLynjaUHRGY=
X-Received: by 2002:a17:902:d101:b0:1d8:b92a:336 with SMTP id
 w1-20020a170902d10100b001d8b92a0336mr371114plw.7.1707954341932; Wed, 14 Feb
 2024 15:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214155740.3256216-1-kan.liang@linux.intel.com>
In-Reply-To: <20240214155740.3256216-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 15:45:27 -0800
Message-ID: <CAP-5=fVeQdNYPwxc02KVCM0uAhw0u5im99gZKvAo4NTvA+nUuw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the bits of the CHA extended
 umask for SPR
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, eranian@google.com, 
	ak@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:58=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
> event.
>
>  $perf stat -e uncore_cha_55/event=3D0x35,umask=3D0x10c0008101/ -a -- ls
>     event syntax error: '..0x35,umask=3D0x10c0008101/'
>                                       \___ Bad event or PMU
>
> The definition of the CHA umask is config:8-15,32-55, which is 32bit.
> However, the umask of the event is bigger than 32bit.
> This is an error in the original uncore spec.
>
> Add a new umask_ext5 for the new CHA umask range.
>
> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server C=
HA support")
> Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.24013007=
33310.11354@Diego/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index a96496bef678..7924f315269a 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -461,6 +461,7 @@
>  #define SPR_UBOX_DID                           0x3250
>
>  /* SPR CHA */
> +#define SPR_CHA_EVENT_MASK_EXT                 0xffffffff
>  #define SPR_CHA_PMON_CTL_TID_EN                        (1 << 16)
>  #define SPR_CHA_PMON_EVENT_MASK                        (SNBEP_PMON_RAW_E=
VENT_MASK | \
>                                                  SPR_CHA_PMON_CTL_TID_EN)
> @@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8=
-15,32-43,45-55");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
> +DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
>  DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
>  DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
>  DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
> @@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_op=
s =3D {
>
>  static struct attribute *spr_uncore_cha_formats_attr[] =3D {
>         &format_attr_event.attr,
> -       &format_attr_umask_ext4.attr,
> +       &format_attr_umask_ext5.attr,
>         &format_attr_tid_en2.attr,
>         &format_attr_edge.attr,
>         &format_attr_inv.attr,
> @@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
>  static struct intel_uncore_type spr_uncore_chabox =3D {
>         .name                   =3D "cha",
>         .event_mask             =3D SPR_CHA_PMON_EVENT_MASK,
> -       .event_mask_ext         =3D SPR_RAW_EVENT_MASK_EXT,
> +       .event_mask_ext         =3D SPR_CHA_EVENT_MASK_EXT,
>         .num_shared_regs        =3D 1,
>         .constraints            =3D skx_uncore_chabox_constraints,
>         .ops                    =3D &spr_uncore_chabox_ops,
> --
> 2.35.1
>
