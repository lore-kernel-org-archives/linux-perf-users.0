Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1E47A6B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201944; cv=pass; b=RotRdqDaofoR2Y8dU74fO21pYqbGfUbetC6mZpyk7MYijIWpdsCCMN4vOnOgIAZS59G2bdvr3U+jzdpjJDqSd0colOQslMYDhk+9EyzawY2wPEHRj/ZltY6JZ4v91jrOFoNoes3iX0u5CpDh5jX5AmHaH6/teUICGGxWnMTKPls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201944; c=relaxed/simple;
	bh=IJfPs48j+QxK2Ler0wcVXBPXEds0T+mwHPLjoGB8/AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=No7aNfFo5TxWZn/Mipm/zgtrN32KYQHjxu3/pzA9QCRVAiFjBZDEjmAM90oWEJ15Lfk+1Xn4PtR7nhqngkiHiocnfHL9jEmwDQ5OJEedj+bGD7YsqfOVXqgyQPvM/49v1ncWe3RPMDlaD2QTxakUbe0DQYHia9ebkNuH+gVqoIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Lfseq+MK; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Lfseq+MK"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662f54771dcso2052648eaf.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 02:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201943; cv=none;
        d=google.com; s=arc-20240605;
        b=VA/3jGRGvptYIfa4G3OTS6igbE+soZusA2/HJgqbkQwknav8OY9TtyhN+e4spJfoyU
         Q1K3FVu6qyfK3dL7zA/wYhxnz6GhySOMI2IoN71ejSescUhx+vrTVvNmt/EccqWpoUSW
         JrqDvuIdhmYRsugWJ3PRz/NZrHzDsXmPcoduQ0WErwnAIpAbzVrE0KUYTRRcQzNPq35S
         JVKumB0DmY0KiDdURFzfDZVAN8oNZsVTfG+hDuBo97C5/z5uqRfUx2Wl8NWvEvG0nMm+
         RqmJKJ3L4pv4pmYIzqfU/d+zsugKQjk9HPKvI/JxHph5dDLhHlSJ5M7y/dtnLb62rFeB
         y6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxBI3Px7yFYe/I8uXtDTSK/tYhQEb2S2RBT2z3tyr+o=;
        fh=AFXzFl7P1Is4A/Vu20D4XI1KBXXSKM+6J8VdpP/42PM=;
        b=R/SaEsdN/HWkK5DufbE2ggb+g+LQKQZHO1e2WEQJPl6kkLObB/5wbu9mKlKQSOD31M
         Q491ZqMwWUrmgoxx2ibDB55o6o4H+Y/ndTem92sFhOk0vwb78lzm7sr/ND9zg+afk4dL
         MJ5BZFOhCg8g20nw5ASRljFkun4Kjmjsxy617pWsJ9sq5uWvBQoKwl+e7xlnAJrczugs
         2tlxct9t95Sa4H1x9tG6U2PoeSdr1Ok7UGEg71EEaaEGy1vroLW/QbBNoWnRj+Y1LAJk
         vNtyXE4i9UP/euF3WSaF9COvC+V8JmR6xMDHcBT+W8mq0VnVwT2OCeb2J5nqIgo6IRw8
         SPeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1770201943; x=1770806743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxBI3Px7yFYe/I8uXtDTSK/tYhQEb2S2RBT2z3tyr+o=;
        b=Lfseq+MKDa1vEgRWNIyIVVwUuPVq7EHpBoT/5gbbHSeF94vDlENpSoaKdbKezkEBeM
         NQN0Uk/5u9ihZ+Pza1qCKdAtD0SLcytiQOlVXAP97UamtQA5w865SvyDZkMJUn3jleBR
         sdDcw2LGI0XmSiCy4vKPp6jXRWifXmg65HGQ1vn37EQtLU81568pzb8nC9J52e7bjMLQ
         vCjtlX0+TnxWVF0eCgL22p0tGA0k0A9BnUVDakzXsYuiQc8JGQSnxBjBjY4mOpWZ0bm3
         SdXYZmoN1pnL4H5mrdM64kDwZY2nKhskE5e8w4V1pruE52K2lNEp4UpPvN+5cX+pBTZM
         EUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201943; x=1770806743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxBI3Px7yFYe/I8uXtDTSK/tYhQEb2S2RBT2z3tyr+o=;
        b=CbN+RsyxcRvTviZ8YupvfNL4rgQmv7hg/WH+jr5UJjPGLKjLtgRs46poozGOGHyJPI
         yjnDgXZPoTQGkJZ1NjYdhhMsgh8c+uzdiYGqxiJvcTYkbRPmmUS7uXWtmwi3s9OjJ8rj
         dNREv55O1oxYLqQFI/0dOZBIwvJz7JkBtIgjjVcWDXoZbz08wxQLWpLaIhNJAmJLApt7
         JzrZImhS/96FqtFF6U+Impai1PMZBHz7EOqdVwad4325+FTMME6x+LAym4XfdRXER5MS
         83hY4XZuex/CCuF8OsBBHcDbNIQR8oKgoQujfzvtD7VS/N1cWg5BFM8/2lYcXmVlxWT2
         Xj6A==
X-Forwarded-Encrypted: i=1; AJvYcCVx3L7UkI13kmJmjRiTf6a8j1mvklMSKKGNY9aKBxvvS+eQWZklFuMll99yvoLq9ljOlWYscK3ACiX0FMPKd/Vn@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMeIuLak6xYSUrwpaT0V88cKbmc1CvMK94w/9EkcB6h8/VVqp
	5FiRgkBr7u+27vqoas/HV6WqRxefMVpp2RHq3nxPlmCtYMCTVb6o2PSVP8WsqlIady2wYuXXxEr
	YP9U6NqgJFJP7/6+VChy4e6G908uzrehDfKIWd/1as66Smz7SkHvZ
X-Gm-Gg: AZuq6aL73Nr8U+FpjrjI6hLE9OUBaXOMXoIoEl/O6C7idLWsNxJn2w19nIpq0X8Q0qM
	MIEq9PLpc46CvWOaEYJhHX+U0rQDvHGQlc7i9x8jp9zgkzaW3r1PTh8N5xiP47BXQVCJGBf9JEK
	hKLgpgvfAlrVffXF0qyTf6DdtcCph7oXLvNpxHX4tlFBNaQARj8pFLdslNCTLN1gzhGotRV6QoK
	t/Drsn+Y0shyl2Dz0TJ9FtnvBRf8A7OauJ10SBje7M0OTWPuSEdniLtBdaLEIOaf8fQaYdNTK/f
	K6Bin9y3JJ5pMcHyrzC7MrNckdmZMJsustuO8IvYmd4X2Z/iE8Png+ipSw==
X-Received: by 2002:a05:6820:2d08:b0:668:d715:108f with SMTP id
 006d021491bc7-66a2390a170mr1139399eaf.73.1770201943318; Wed, 04 Feb 2026
 02:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111728.4067036-1-qingwei.hu@bytedance.com>
In-Reply-To: <20260202111728.4067036-1-qingwei.hu@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 4 Feb 2026 16:15:32 +0530
X-Gm-Features: AZwV_Qjv3CycWr9Nq6vgpbjHaX6Q3jzdVxmyiQUktF1pv6KohqSpje4QgNfRJcY
Message-ID: <CAAhSdy3DnWVT1z1C5VvyFQq7mFEf5rD5pt4Eq3WbyRjSLjmAsw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Skip stopping cycle counter
To: "qingwei.hu" <qingwei.hu@bytedance.com>
Cc: atish.patra@linux.dev, will@kernel.org, mark.rutland@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 4:48=E2=80=AFPM qingwei.hu <qingwei.hu@bytedance.com=
> wrote:
>
> From: Qingwei Hu <qingwei.hu@bytedance.com>
>
> In the riscv_pmu_sbi driver, pmu_sbi_stop_all() is intended to stop
> all available counters. However, counter 0 (the cycle counter) should
> be excluded from this operation because the counter may be used in
> user mode by rdcycle.
>
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 7dd282da67ce..2bc0050dabd2 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -900,11 +900,15 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned l=
ong *mask)
>  static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  {
>         /*
> -        * No need to check the error because we are disabling all the co=
unters
> -        * which may include counters that are not enabled yet.
> +        * No need to check the error because we are disabling all availa=
ble
> +        * counters (except the cycle counter) which may include counters
> +        * that are not enabled yet.
> +        *
> +        * Cycle counter is excluded because it might be accessed by user
> +        * mode via rdcycle.
>          */
>         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> -                 0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> +                 0, pmu->cmask & ~BIT(0), SBI_PMU_STOP_FLAG_RESET, 0, 0,=
 0);

NAK to this patch.

Disabling all counters (including cycle and instret counters) is intentiona=
l.
Please refer to past discussions.

Regards,
Anup

>  }
>
>  static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> --
> 2.39.5
>
