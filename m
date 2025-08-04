Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8410E4
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Aug 2025 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283282; cv=none; b=Iios2Pmo+uzY+92lpm7QPym+R6nfOiwtp3EAf8TKMlSvxTEI1a6/A82D6Nm4vE6cKwRKk8zoGQnRvIZsby6+MQljAMmDo21Yz2p1FcVma/lGATlGqssnZSy1RO8e3mUMPJRnyxsrYl1XRKHfI5rjzEJ6Yz/364tT2e6ehhqI9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283282; c=relaxed/simple;
	bh=Xp6i4jbg/DJWBbnw4peXx45P/VMxOwrg4+MomZCxb1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZmCFKfAp88RFQ+Vy9dt6Ku7wmi3NYAs+ZpmB9s6JmJzt5Xut/78QSA0cE8lPJpV56H82rgcIPYcfWVc55kgHgMnGmPKzzLs4rx4J269xK45vVCSlCQmTbHkLF8RMPfn4sAoqB1Pg+PeprCHqq1k7wPfTuwnlYZa4+QU+F/1DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ffL1KVL0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ffL1KVL0"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e3d0cba6a7so14625945ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 Aug 2025 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1754283280; x=1754888080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve4t7PRwwZ+6CdX8OjiqWX7q4e7rTv0zRJjQYn4MAVE=;
        b=ffL1KVL0eNSwV1m1m0W39natThWFFMlc5AHpedcgxDxWPAcnzgNTl4rXca5axMA1/4
         Jn7HIHyy8NJdW0i/XdoPS55E4Z82zBgv5NtUPXVQ3kHRHLL/oUR13tamMig4QrQmqlog
         pFpRn0BCrhTvcMmWLTx5Dk7xGfqF2Gol467h8OeWNAvOZOS7cRmM42MO2zxcTuCklxlj
         VKK/dDFYkJXjcJnp7w6bb7bEbuQJuz61BhtlYYJac6M5UQNzZyXFgNMG/RMxKB2Y/Jh4
         6cb7RQfnh8wgRSz1eBLX3GIIEILTHFtWmQXA35jGe2kNqA51dEGz2NVtTLshZTiBPazL
         4sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283280; x=1754888080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve4t7PRwwZ+6CdX8OjiqWX7q4e7rTv0zRJjQYn4MAVE=;
        b=qLudC3uElnNsiif4AVJTkMVaZ1m7NIByUHqbQf3RQ6aT3KTZbTMwLzvrKLmUY2KW5X
         IhzMs6aeAE01MqMbcr/F82rVsPPcxwMIySXrPyjQp3b3tHsMdK1FZcF3fdnrRydmBdsz
         A4OhAl1PhAYTKuU8i1Ol3BtHNxgu23E4g6k2Dp4iOl9Qjl9D0ofpXs4I3S4JQmzs3F43
         wL5Ejd6TAVXfdrMKgw6hdxy6u8n8E8TNA8BM8BD9KEB1sCAzdvzFV6rmHPUSOW5xSGcD
         YHF3AjF2YYCAcwaRyss3I84hmVvqRi6ZY43JC6vGMyv9vnvrmKlaLLai0GmK6gLAwv7y
         FZig==
X-Forwarded-Encrypted: i=1; AJvYcCUyny+9QUcLy3uhbHXksvMsjh7JSuCBvNC5uaDiQH6gjPi786XSTGOFjvbHUugP0MZ4TyWEceOddu7ZYoiRoJcX@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvKfsdQGjzL3NjmVolFaRJXe0JK5KJ0D3Joow1yaMcXdRFwBd
	XeIvy+xHYU6puDrnLSnzk69gsqQzA7oiehxW2AmAFw9VmPQSeHvuzxMw5J8gJqs864az0uD9X3G
	YS8h+rVDVNx0VKp9v7s2J7SAHHoXgbdq+or4TseIgKQ==
X-Gm-Gg: ASbGnctH4qKET3gJfw3TPW0m1ElJy6fexNPWf0bKyZrNeBhtD18xVqIUSeshdbvhi5M
	NT1WvRbQdqWVajjPO4px769uyW/FHbUSkSbH9JTcxbcQltuJzqenjpL9bUmh4xDpdxUnZWt++vK
	9xZKyJ0mDOy3ryEot9KJdjRdLypMPCQyusw80tPH+KV7Mk0iWG8y811OjP2HdqtvSOkruH9qwsX
	AWgykazQWukoHRX0Q==
X-Google-Smtp-Source: AGHT+IGOf/eAmkl4Q0GWF4AohALUlaptRfDp1Iij/yEDJsJjyKHpMVaSn+/FjgEyVm9U379DEkNm6wknUSqAYZiC9bE=
X-Received: by 2002:a05:6e02:1b0b:b0:3e4:117d:68b3 with SMTP id
 e9e14a558f8ab-3e4160fb7a9mr156363575ab.2.1754283279671; Sun, 03 Aug 2025
 21:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804025110.11088-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250804025110.11088-1-cuiyunhui@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 4 Aug 2025 10:24:27 +0530
X-Gm-Features: Ac12FXyo1twqSxNMLHLAzUl4BV1Wjd1pROzrJyHs7h6O6ZZZs4qmilg-EddkdoU
Message-ID: <CAAhSdy1QDZc9LAnoZacFeQt-vCbrBCxxM4cY=EvLJXFAWifv5w@mail.gmail.com>
Subject: Re: [PATCH] perf: riscv: skip empty batches in counter start
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: atish.patra@linux.dev, will@kernel.org, mark.rutland@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:21=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Avoid unnecessary SBI calls when starting non-overflowed counters
> in pmu_sbi_start_ovf_ctrs_sbi() by checking ctr_start_mask.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/perf/riscv_pmu_sbi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 698de8ddf895b..3977f7488e4ef 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -877,8 +877,10 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct=
 cpu_hw_events *cpu_hw_evt,
>         for (i =3D 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
>                 ctr_start_mask =3D cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf=
_mask;
>                 /* Start all the counters that did not overflow in a sing=
le shot */
> -               sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BIT=
S_PER_LONG, ctr_start_mask,
> -                       0, 0, 0, 0);
> +               if (ctr_start_mask) {
> +                       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START,=
 i * BITS_PER_LONG,
> +                                 ctr_start_mask, 0, 0, 0, 0);
> +               }
>         }
>
>         /* Reinitialize and start all the counter that overflowed */
> --
> 2.39.5
>
