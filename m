Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792817397;
	b=jvoPeGgSmNiWrnO1Hl4AmIEwCujVP276NVRxc3XK9e1bTpqQkEuOm5TokC5TjG1/ODqn
	 9U+wbes3CvyVXkIeprBGEwzQyAD4qhBXELCTLi/U1tPbi4ItgZcBAmwr9GfeVWkOnZPx1
	 9L1koTAN85AFUJiCMN9frgVh5etE41liaUjkc4VdmvhmTn7RDLcuq43DMJ9lYDg05vETR
	 GQeTFYQq1GE2FeLOu3N6kdRtBo9FOmV9DHZJk3eHfVPgV25t4OPjYiHg339A+4X7YsNEg
	 HxvP1XPc1xLxZTsNbmnRs31QMBqVuOMXhRB0itRYGUUNpMic11BTsJY9EJFFP3blvTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792817397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YxBmcqUyq+7y7gmZ9dBOvMilScJYMeNzGz+wY+G2j1M=;
	b=iQhAk7PrDgiPN2XukdSqFJ26B5a34MIv9Dy9uRkJSY9tEMuA44hZQikYWsYMv/YJxMAT
	 shS+Zu2PcAgMynwwihQE4qnb1kXAA4USNn4+ITzM5HQi+pN06LZsHcsmM3RzxpeuIsV5d
	 m322wRBz2oNm/SlU5xZ0d3r2rSOHrhXhvblTVvtRY3YeBsLqP4NLX0iCj2ISLN60t+X55
	 tg2w2OX65acn7SpvZGB7NsadeE7Au5Zdi/fEv6sQu0W5KQJQL9px5+2BF0PwpDH+slBhT
	 TJaVT6nLOjHGBR/iStmgtX3tg5ZSDNT+o4vfbWv5SAh3lS05y8P3f+Q3LelaeyEMNZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="dHk/WJ7n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58E606A31F
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 04:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A58E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=dHk/WJ7n
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so9883245e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 21:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792817396; cv=none;
        d=google.com; s=arc-20260327;
        b=kXvjqygPhHR2ZxKo8UxHJ8nxxBbmNrbO4saEKH2RHUbydRopL8MBESuqH5+3YBWQYR
         gbuHgCQrlwspEntuIR8DRDPq9Cy0f1ZmnVHJgEld259kMVSYQ1IuwERIK4ULmqpbykof
         9OnhJPxNTpYXFqlelXaa2/cfj1Gjv/CM5PRENTyoaohdlY5T6xDDlN84qE7+E7DFUaYe
         w01PhxsRcd/8IGI4JEq3z82Ck5/v0GmkpRD98QcQSWU5T7nQHeyVGxRS92/LSbGlgd1m
         g7BbKia3ryKRB/2xBacU/UHUlfoDMOGMWuAiqIvO7qWCmB3vngeG7hX0b+MZVazp7CVE
         ijNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YxBmcqUyq+7y7gmZ9dBOvMilScJYMeNzGz+wY+G2j1M=;
        fh=UB2vEr3Z6m0uhcb1B3+d/8cJYRDcw6cIdVn2hEPIV3c=;
        b=K3Q19+mbLwb49xc7LMUfZb/5mU2N/5eaWoBMthlD8U+PG83oiSg76QAQTGAORpQyY8
         777QyPleNtpZYywva4uxymEI5h0qrfyOCBpTOkKRfG8MmYTOuM8BRgICsAzQyfCCESH1
         /XZLaFt28GsaDqEu9V91vDGZCxTo7fHYGxJaxcWq0HNcn3C1oTXay+Lqc8TEykJikRFA
         TDqlGVyG4RxE+mYoE/P/3/joSSCKV8cgrWWH6QbHPkS1XTPi0q/p2yHoY1IuPy+PEgE/
         PTDluzF+044e78XB8YucaHGfvmTUta3p6S32wQKycC4lgS9gsP7f1weo4jafFlYtXh/w
         DmyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792817396; x=1793422196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YxBmcqUyq+7y7gmZ9dBOvMilScJYMeNzGz+wY+G2j1M=;
        b=dHk/WJ7nuF4n6s5fi4NtyAD5I7nCSnSZIyyz3kynKii5OHyKDjuTV/+X4jpJky+Nac
         ia5LLsmnz3Br4W0QsB94Sd6cmdKL0RdNt5OGWpwv9MD0gtv51sH4VIYfm8c10yjRuf8S
         4/TQeWGGnjzQkplrHGNtnKdEGeCEk1RptYAiaTycXpSyF8nB67iDdCHPbk9gJIOjoj/u
         r3y85Stzb+OM312MlQJeV4AJo4FAWIX9OpPLcGumaCgefPg8DNgW6EGsJIfpnHu+TW0x
         CVaa9QDHVJ7zOp388zvtY5CGTpzEnjpFTOuEe30TIgg1SaIeNR1yNerUZB5be/qCW5j4
         To4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792817396; x=1793422196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxBmcqUyq+7y7gmZ9dBOvMilScJYMeNzGz+wY+G2j1M=;
        b=jvA6b7ouZz4Az6c60fGOg/rmxXGB0zMbX2eGaNk6eCrP/EA/FIuKOT2uO4DtmIjUcA
         8f3tRHPb9brTUjSUOTTZoRXBr5xO13K8PED1xRFj2uqun7QG+G3KtRlXfzePiETsPb6E
         XQmCJTHvVXhHs8MFa+3DedNSZjy1HyzKDxQvsdhacJUkKR02ij5AT/mAwhXaatH7xzEk
         jm2+gR0XXYNSoaaU8BbtKZLxQGMHaGQijSsw0sNw9qN0I2LKX3jEsTKYh8LCblA7fpcI
         tDPkkFkIN3dV/W16yA/IgtroZ2MCEIrxhqZztUY5RjQLHYIKcFLGq86McOV7tCRqiA+e
         v6TA==
X-Forwarded-Encrypted: i=1; AKwUvBw1McKvJ5pHcI7/vd/JpjRlfHCF8L2C9uMoJSBqhBWNcsxal6GKw3cZ2Nqg6vGiTyEuz9PyiQp8BFrCOwzjYiP5@vger.kernel.org
X-Gm-Message-State: AFq9FYL+JZzTxBf9MEF/1EAqf8gYMuEX6Gq6B3xofASfbZTxnX3ZPKBO
	nH/Sk3y8CY9Gfn9YCMyQ4fN89xQ2+jviD+sCyYyIFa6vP5v5UxZoEMjjd5yANXy4zUZ4BAMJiah
	ZdK1l7Wse1k1N+HT5JKQuswuwCtjsAXTNVrrJydvWsA==
X-Gm-Gg: AYBFou2G0RY9bUF24qMaQIK38227Qk6PxV0kt59IaUQpEL4JLnX/LDqVbGxE0jDyxfr
	kH3YE//NaRiQVVg2gusGVfHQes+JWB4+Hu3bX50RH/tO7060+0SlxGuWat8W+HGFM0UKCtMsENz
	Q/bdP3NcFb5OGvCRo95ti9nOpD8VWDIbR5omV175yENjmEjPzhA3ithU6QAQbFq1xUffZWD/Vof
	fkfJTp2J9dqYkl+F8oqe/YRgrz8b+i8qjzH/QVID99ByT/6ywTc5Ey9F+8k5bolcOchTZq+OMNQ
	8B5o7zR4WDQqobhYkbrHupYHKQc3s5Wrr/JVYF2HhfjDM1AxOpDSQQZwu5yO0rY8bUEeC9QGJRT
	73p/Usts2EXJ0WxtW2IU0mYLmP89ASDowd588a2QsDeATHMZS0EHKoMx0ndh3aZwzzKyynEotwJ
	lZu9/n97nxnCbmMZTLOkqXgSI4hoxWxkaSkcezOZHJfN9DnCnHUMhq2CE=
X-Received: by 2002:a05:600c:3e10:b0:4a1:e01e:1927 with SMTP id
 5b1f17b1804b1-4a35ac8d939mr12203795e9.5.1792817395557; Fri, 23 Oct 2026
 21:49:55 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
In-Reply-To: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 24 Oct 2026 10:19:44 +0530
X-Gm-Features: AclHuK-rwyUpMrCtlF-8OzUUpfS51mxj7irl2dKCroJ9WfO9LDr7DIESO4VEff8
Message-ID: <CAAhSdy1UwajY2P2ca_h0NUd2v00TR18go0gGNwRTxd66HQxS_Q@mail.gmail.com>
Subject: Re: [PATCH] perf/riscv: clear snapshot setup state when a CPU goes offline
To: Pengpeng Hou <hppiscas@163.com>
Cc: Atish Patra <atish.patra@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 9:58=E2=80=AFAM Pengpeng Hou <hppiscas@163.com> wrot=
e:
>
> pmu_sbi_dying_cpu() disables the calling hart's SBI PMU snapshot shared
> memory but leaves snapshot_set_done set. When the CPU comes back online,
> pmu_sbi_snapshot_setup() returns early without registering the shared
> memory again.
>
> Snapshot operations on that hart can then fail because the firmware no
> longer has a snapshot area, while the driver still follows its snapshot
> paths.
>
> Clear the per-CPU setup flag after snapshot disable succeeds. Retain the
> flag and the existing error return if disable fails, so a failed teardown
> does not claim that the firmware registration has been removed.
>
> Fixes: a8625217a054 ("drivers/perf: riscv: Implement SBI PMU snapshot fun=
ction")
> Assisted-by: GPT-5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
> The issue was found by our static-analysis tool and manually reviewed.
>
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 50220f7b..f38a64c7 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1175,6 +1175,10 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, =
struct hlist_node *node)
>
>  static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
>  {
> +       struct riscv_pmu *pmu =3D hlist_entry_safe(node, struct riscv_pmu=
, node);
> +       struct cpu_hw_events *cpu_hw_evt =3D per_cpu_ptr(pmu->hw_events, =
cpu);
> +       int ret;
> +
>         if (riscv_pmu_use_irq) {
>                 disable_percpu_irq(riscv_pmu_irq);
>         }
> @@ -1182,8 +1186,12 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, str=
uct hlist_node *node)
>         /* Disable all counters access for user mode now */
>         csr_write(CSR_SCOUNTEREN, 0x0);
>
> -       if (sbi_pmu_snapshot_available())
> -               return pmu_sbi_snapshot_disable();
> +       if (sbi_pmu_snapshot_available()) {
> +               ret =3D pmu_sbi_snapshot_disable();
> +               if (ret)
> +                       return ret;
> +               cpu_hw_evt->snapshot_set_done =3D false;
> +       }
>
>         return 0;
>  }
>
> base-commit: 4d7d9486c04d917265f64c55bd23b2cc4fe7749c
>
