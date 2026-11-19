Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795101362;
	b=xfhE7sxuhoMurKQYOrXeQWZ1LiU9l2oA9uU21HcuAe2Lxz4KffrPuXaY+qF75Zp0RXZL
	 mJifiC/poXqjiD6aE0NxLh78NOUUCO8FeipTGI6xUuaoaR2XlOIbKbjIsIphn4GcK6K5H
	 HvH0wMXmFrxKSTl6+EBkpN6Tvri1HZJPG7RIbzR0SVCIXZLAe2DXEP7Xzm7j50VWUcmg7
	 mOsWWOgb8IvIk2atCu0Qd9AkGUC8QfYNSzXKIu98p7f46plp8zjI/nOjetpAQzHM4wFk7
	 F5nZoJK2ibG/jqGMiya+x5BQWjGLOAJ4N/NKYHQey6SAgyBtD1nA5CjkzYZOs3fwbWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oYH388mwmO8nek0Ej+CJLpAy9WcejyRXVXCYGDnSrqw=;
	b=Ad9Cg0JD9l1qcumqEfQoqMobk7x2Wgrc3nC63LUB2h44FJ29qBi3LOdzfrHV7f4Hhwje
	 MGkfgqk6h96qB4XLHJqvYiK6dYC/eIBTEOMvCSz7stjV8RZBJ8YFgszKuoZX26+dd08FN
	 VSduT58X258mfpYIlxV8Q82SnRJZXpRrdZ25YyVsK19/DQPzrai33GjE0tk5CFPxWMGYF
	 EP797Qal0NSGgRp3PM1LQrEPSXqlpJb8lHOpN3TBgqkRmnCwhtBHcwiIQSq49gnENaTDM
	 KgAoz2/4dFlKeSwujK8aUO+zAVPldLvh52OJSLjAd2tjSEYgWgJX0p4x6s70oLl9Brg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="Y/7BXFDF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC060A2638
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9DC060A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=Y/7BXFDF
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a210470b49so21924895e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 07:16:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795101360; cv=none;
        d=google.com; s=arc-20260327;
        b=Ex9fuJv8az0STS6xetfZlQSAX5k31HrrgirGWxBA0fnPUiSasOkj51DvEyshkJBeIF
         IjK0iXnnBzZp/r45jAuCxhDFwgVuQ1y0atWmafhCsEZMj3o49G87saBk6suwiBVRAEJw
         geD2wQFElNF+8exITbfM03malTU8e3t/FGfppyuMuRxu5UM+lfa4ek2QzL3GP4fcZo/O
         QEwViVR1eimyuVbVUSV+eUgeAG2FMd4JEPYZY4SXO3O8Mb6lfBLA2h1XXOiAtP6tCFOj
         KmIEjb+IwjQFdsRG6ov8NvwFtFxpOhAYRbd8lx6h7uE6Loy85mUKvkB48LZdmZQz3fT1
         XnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYH388mwmO8nek0Ej+CJLpAy9WcejyRXVXCYGDnSrqw=;
        fh=p0q5nC5rcRmoKyyXtVUB+pFcVZ/6dzZrN00S92GjwYs=;
        b=VBxr6jqQ7Ob+YS4pCx3wAmRdGBmSZ+wOR0kyncfkQB2kTJkfbTxzT9ZwyNgjolGkhb
         iSgmgqdluM5X1JFSuRPbjIEdeY2vAtN9NUmbG4QqL2HUMwqpz+UjeJLgLPGNgpJy3+JP
         zYQKka5b/lUp9uSQIPeqn6oqPau+xCTOOEFy23JHGCujgS07fP1eyW6NDDWE+bKuzPil
         lyohF3I1EESLqvfMlZfHlUDDLBHivGC65MKpXTq6R53vd7U4NETruYYXs985SsJQtaiw
         PZViMRYXbh5hnrVPlx+UBpLlIyjQHtxGgocMo7W1BGzUIiz8IgPidu08+WxManZboZGl
         mD7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795101360; x=1795706160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oYH388mwmO8nek0Ej+CJLpAy9WcejyRXVXCYGDnSrqw=;
        b=Y/7BXFDFr1bGIG2x4Lt3VSrQn3Y0/QVTTrA2wo/fUw2iVbTA3APTCRfT40/2q2iQh7
         25IfsocTo667Lsc5CQV/KUBrDZWxk549Zk5Xx71LQOjHZJ43Q6xKkm/C9XGf6MvEvLvH
         lkPsAJv33Gw+AR8f2GypSHuUCb6NWUOkI1KEOvDtA6s5vpg7bX42AmFtXMyTLwuDlztC
         8ORuCyUXOwQGwzMQRpFTPg5s81btq5BuiFpaHHQ9rOF2I3w+gC/FZuUd58+tfa/CELJ5
         McZUFyE+11VnhhxJ7eD0whTebuSxSWbSIlExg3BsbCtiOY4E8XH/UrTfqgCc8YfBLR7p
         d35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101360; x=1795706160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYH388mwmO8nek0Ej+CJLpAy9WcejyRXVXCYGDnSrqw=;
        b=mSPqwIDh2L5lkOjqGsR9N9VmTTTKO4j3d7J4Z0Gg9reKn/T7NGy/Qx8+3Pilpxy+St
         sTz6uB0jM5lTJ+H3tCop8TaWvUH2erCPx7Fy1SI0yr+Q4wPWMEpNfJ4D6sTwCmg+p+Fh
         SaUEfrwXnXuLcJoPQByt8MNvy2n28nEL6JFutyNJ3QblCPYZk+hc45vGB7LW6JDqKRZl
         Oiv/dxl282TNkdMZ71OzF92cWemhd2TIt59ds140GfxapZnIYe2YpjkAILWlp/zPdnYm
         Hug4Li6qX/Cphr4H59bZoup0JDQOVrNhrF8xGJfmE1RsyMcACP7iS0CCBUJcFxAzlXXS
         j7QA==
X-Forwarded-Encrypted: i=1; AL+hErHGpE1rdnlMHjgZy0A+MTlmL5S3K9xcKTLXO2HxImTFwC8YD2ZLgCxnpcc671lvVMUBxIw91zUIjrSxNDhNKT82@vger.kernel.org
X-Gm-Message-State: APuU4Z9ie3j94OCQmiJfXISrEjsUAWuye91ubmxrLEp7x4iWRsKU5TrG
	C+p/e4b+7dNzjTMmpXA806nA2XFrEhsopUmCcyp/3fZzeCwrRxNolBUpF32eLGRQw2XnDJxbmMb
	FYA3yfUL9LORMrexy1cNIBFO4PiwtSEJwXbL5HuzTyA==
X-Gm-Gg: AYBFou0sRSsu0+zRfiAHyfr8XCHqigde5aSzpjnD7eJ9f5flQSUbk+CDO2g4MbtCYv/
	I+/vGudEYlucEOwb8p8rIBcM/xhRhUboMxVBWwGg30Z19hYzd5SHAB/cFepC9/OtdoxMQWoReI5
	TkhXQLLLDUYx+rfy/TKEc7Q8ecYhB9XowT6Td5fomvbCGxES06yGdEVV4OlTTqSxgjCnkyIHAae
	l4VMcHD8Gdsd8Qm8GfdJdtNtrssMzHi2b8ZSraDlFvH2KQP0vmqinVRjk7YSJouKBS4I+kDk/Ae
	h8bM5MX8vKOTcLtVNQ+tiY4EQ1GZ2gHBamqfgDlvYKW09ACqbBXa4/XQqUNk/xQC3m48otIxJUz
	OqyUooLmREyvhg1x7LzTYMaRBeIL0lUMl2yo691h3Y7uiNCfZ9fmvHfc0Zvv2vK9XGgdFaRRzAn
	L7yUT4t8aBXTKgLRlNIq8u8w/ChQL6+B1hjJS563DkqqTnA/pjYLtONMMs7qWiz+xQqmXCXL3hj
	ZfR
X-Received: by 2002:a05:600c:c106:b0:4bb:87be:c138 with SMTP id
 5b1f17b1804b1-4bb87bec13fmr12856555e9.32.1795101360089; Thu, 19 Nov 2026
 07:16:00 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com> <20261118095053.3871267-2-vikram.singh3@oss.qualcomm.com>
In-Reply-To: <20261118095053.3871267-2-vikram.singh3@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 20:45:48 +0530
X-Gm-Features: Aa3M54riNYPYm1hR-WMNehgnqK1cKsrsmx9wlvpLX0ldc8qDneAu48N6AszDino
Message-ID: <CAAhSdy1QdF3rA3bkKsdOe-pPV+JekgUeFB2LOirCTf3L_qjK_Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] perf: Increase the maximum number of branches
 remove_loops() can process.
To: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atishp@rivosinc.com, anup.patel@oss.qualcomm.com, 
	will@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	beeman@rivosinc.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>, 
	devicetree@vger.kernel.org, Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 3:21=E2=80=AFPM Vikram Singh
<vikram.singh3@oss.qualcomm.com> wrote:
>
> RISCV CTR extension supports a maximum depth of 256 last branch records.
> Currently remove_loops() can only process 127 entries at max. This leads
> to samples with more than 127 entries being skipped. This change simply
> updates the remove_loops() logic to be able to process 256 entries.
>
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-2-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

I think you accidentally picked "Link:" and "Signed-off-by:" myself.
Please drop these lines from all patches.

Typically, the "Link:" and the following "Signed-off-by:" is added by
"b4 am -l -s" options so as a contributor don't use "-l -s" options
when using "b4 am".

> ---
>  tools/perf/util/machine.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 076d167380f2..f1efd1120a95 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2334,25 +2334,32 @@ static void save_iterations(struct iterations *it=
er,
>                 iter->cycles +=3D be[i].flags.cycles;
>  }
>
> -#define CHASHSZ 127
> -#define CHASHBITS 7
> -#define NO_ENTRY 0xff
> +#define CHASHBITS 8
> +#define NO_ENTRY 0xffU
>
> -#define PERF_MAX_BRANCH_DEPTH 127
> +#define PERF_MAX_BRANCH_DEPTH 256
>
>  /* Remove loops. */
> +/* Note: Last entry (i=3D=3Dff) will never be checked against NO_ENTRY
> + * so it's safe to have an unsigned char array to process 256 entries
> + * without causing clash between last entry and NO_ENTRY value.
> + */
>  static int remove_loops(struct branch_entry *l, int nr,
>                         struct iterations *iter)
>  {
>         int i, j, off;
> -       unsigned char chash[CHASHSZ];
> +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
>
>         memset(chash, NO_ENTRY, sizeof(chash));
>
> -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
>
>         for (i =3D 0; i < nr; i++) {
> -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ;
> +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is not
> +                * needed as hash_64 will anyway limit the hash
> +                * to CHASHBITS
> +                */
> +               int h =3D hash_64(l[i].from, CHASHBITS);
>
>                 /* no collision handling for now */
>                 if (chash[h] =3D=3D NO_ENTRY) {
> --
> 2.43.0
>

Otherwise, LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
