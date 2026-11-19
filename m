Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795101815;
	b=xli9sAYFGaLumaHhUWEcioSnY76rWquOkeWdGOfOzGXHRx2e+bsAHnsqnA515hvK0hfw
	 4sYIBd+qvtCWt6CoeN2QRnr5WumrL5Utk0rAMiQPHW1Xm/vs+C+SmNgDM5Gc9Nf3DN73m
	 irH7QLkKvJ9VsfUsK/6P7OlnyFsma0t0pX0AAz6+8fG3Zq5tnDqfnQyrnY/7H9jgrbIFO
	 28a74hBm/NADoTFbdmU0o8s26qv520rLKPce0On+UytYrOr5AtSncIG2a7nozlZsnepoP
	 KNGRXzCI9TQQdU+rF3Bz3KF+sg2Pz/LjJqD0iAJmp7u+GsD0v3kQVk9kRvQUwC9ZxDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hLiIxvGF0pdJOfNUXCqh2sSExtWATR8tTZm0ydTCszg=;
	b=fSPD2Q2GweT6ze1PZ2i7aMvfYWvw0HcyB3atmVzUur0YHCYijR/XNp7S+Iko/+VRLeMV
	 fJzLGwREZVPHTO1PKQo2qBFuu2W9bmuE6WEE3pJSTuyHEWrGEGZ2NAkZVfE6hPemvLLuW
	 HJVyHwfao7MUSOlmIXtEAW6b1gUI0ovCa+FfeM43p7povbEHyf+keIiKALC0aEN2e/ydn
	 vrEGbDkjdskUK3RSiBQ5mdY/tlC6H3gpgYbwLHocjemCKkLfiJC7zE9d40ipmUlNVV7TU
	 5t48n+DpezLJzbXgZwl/1ZoSuSVBAPb8Vk3AIeF9e5Sb3EOadmERY8z6GqZby8aBbwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=PsKvSipo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C84606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 15:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C84606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=PsKvSipo
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae25c846edso18973761fa.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 07:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795101813; cv=none;
        d=google.com; s=arc-20260327;
        b=j4vR05xH9uRWElt7Bf1C1CDu1dhCAIQlthIehtsVZXlbqK6rTC827uAZTcn6Jd51SV
         5hsrVxnV9E0h101cDmP6927iWSZ5hfXEX6s5H0lNollXD4mN+S3G4KzV4j0pS0ZdwOwq
         kWBlEU+Fuu0bfd2u4pnJd3Gos3r2V3t1QrzEfAxX5Q8mYk7mz3t9So38PsFKyC2fYzSm
         tuoh3f03YfJESokYeDxcPMYWEg+r7vHhIKl/hgv/mAdf9RdPV1pIdLxOLl03N5MvjUjV
         LSjksfHt8PCKNzMGAlK1hfmtK5eDlcq7dSXz/Wh8tPZ+5QF8PakyxSO/LXZxmoVoBU2f
         bXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLiIxvGF0pdJOfNUXCqh2sSExtWATR8tTZm0ydTCszg=;
        fh=rdXATXLER9YdyDTGP5+V5fZxlRM4YXUOBlLyo1S0eNY=;
        b=d7yFlSm6PN1iRpKbJFnJ6mEyoxWNeZC7wY7PorrOdcXK18SLpnIkdRO6z2Nzd2ty/V
         CoHlkhdhNdYVyX6qIyseoR8/Vp8YwzngIbZHaLpwT/h4BXDhNNRePZaul5ZW/Mdlo8wN
         ExWveMzj/N+5jmLf6W+xCLVh+S/qrd0r1dBpHE00wXZtRevkccqFk6FZcHKwqZJuBact
         ysOHZ3fbG75PBUc6Bt+NrzxbVoC28afOky8sw0yUG0grQtwnYS0Bg6CuKSf1iD/cohXz
         oMRnzx2U56ut7kh4fpUBOEP2KoAoo9v8yEM2DsYgdmBzkzyPDybxzCnhLYZLdv21dUON
         rPvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795101813; x=1795706613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hLiIxvGF0pdJOfNUXCqh2sSExtWATR8tTZm0ydTCszg=;
        b=PsKvSipo4uwtGNDpuodh58qPWVhgfzyjHZK7Ju83zbKIRcDW6RBRLqDwxpgEQ3B0JS
         FO+hCtjaF8ylDWAgZxhOgWjeLdbCRH6PeIpfdDCJVR84Im3w3xATL2GCh0DkTY640PYx
         nC7Vg58Ij7lX60MSiWsikqTruxxW/QgyQDR+XKwC22zdqRyGBNofVjK6RrNnAxO81NhF
         SrUM+xGyAAZqEPFqJnDSKlZXzHn5Ilv3trNGXCYQk/ixaOifH0APmsKf6DJSsDkLf0nO
         4VZstfeQTsvNX+f9/2k5Y7Ign1Z9khBqS1wBn7xXpNy+7c0L5HNSbCzIbR7c0au51+K1
         Lh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101813; x=1795706613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLiIxvGF0pdJOfNUXCqh2sSExtWATR8tTZm0ydTCszg=;
        b=S5ZHfg/KaA7ovahWjnlJwXVmxrsuZmEFgsbqZ8UeEMOGe9nRKZE7CgiL/fzC+Ifn5c
         nY1yyWZcRVWBi3E/A3J3IYZwdw81b/lDx3Mthnz6jTHlR+PNpkLH/rfZzh/RTHbK6lil
         YPvdkMvRVcedwIMOmklOsZy65a0uS+W3x7Uvhdjv0AhA6mX2cHxR3FL+VSwpAkIEgeKj
         m2qQDtY56beCCq71XANvDfcQcdOBsIbhLiWSxnsuVWtQiR3ZF10De8u5ovl1NfyUzlVG
         CU0bqYwJKwG4wkDs/G9VOOiOhorhQXfDZAxb63vJE3Hk49aKD+FE6O6KqoKtpzDonMbQ
         2daA==
X-Forwarded-Encrypted: i=1; AL+hErEtKJGwqIhPZGHV6aZaWgsv0hwOrmaoEguyHnyiGt7yopRtQC4SfyPNhpAfFQNoCaIhhcoqq3wlbJ+vWXn37bsV@vger.kernel.org
X-Gm-Message-State: APuU4Z/YznHPjMngtfu0N/xEwryNF6wFHuIchcOdUqrncQC0547xc06G
	jH0BxXeN4g8yrURSDN0HC7I9FRZqbJG+sBaeIHcf/TjxKitYx7Tiik/Tk3IKFQ93H0+gyqlI183
	VOT2flb7OryqULtMzeEaS0mBmEJVJC4VOxXtR7Yr0bw==
X-Gm-Gg: AYBFou0ixp3csktdTs4ogMTvKVmQnxqxURfJ/LpGD1xBkNVuzEu60iAanUDY6axrTj8
	xLem+xeY6Ug/UgnWICvdTekR9IeuC8uAr5glaozkJY0hxA0SKIkk3+Bzxlrt0jx4Pdeqb7JnicA
	BCxSk4CysgncrmsS+GPoeIagZcDLsW8UInmrdVvMcoqifpTDU4wVTyfHNALW8nuK+Zkp4KLM6jK
	75xpF2WeJdjbeoM9qYwwp4uOryhGmC6dyLNrBb9Omuj6G6bjJ8i879bRQ3/n2dSHZH/rHQPbaPB
	V0nVXeOXdqCpJXL/AXuMwM7A8Gre/C6VmkRvYCo/2vd0D9+5zVF9wjEltEqsYpDQkSyRSks8zF7
	/YGZx7jBRiTaRAFrEr7Nq1s8/rcs08yX7HknqeI8GS2V/37SaFnykb7irTQm+YPhJ2I71wZnEdW
	HsD3WAPNsjXW6Q7orAs6iGG0MFAc/Hhn7TDa/ALW3U4Cwaju3MJueOMwY=
X-Received: by 2002:a2e:bd05:0:b0:3a6:6d05:7375 with SMTP id
 38308e7fff4ca-3ae7f9d5f2bmr884941fa.8.1795101813092; Thu, 19 Nov 2026
 07:23:33 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com> <20261118095053.3871267-4-vikram.singh3@oss.qualcomm.com>
In-Reply-To: <20261118095053.3871267-4-vikram.singh3@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 20:53:20 +0530
X-Gm-Features: AclHuK-bYeekeWya8STnw2Y8eECaMfbCySlAAK-yinBr0JM6XHZ34xL9AEfbGuQ
Message-ID: <CAAhSdy3TtQCE8Fa5FitihgSKewXLApPOOhWHU1QCw=6F-P_4=g@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] riscv: Add Control Transfer Records extension parsing
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
> Adding CTR extension in ISA extension map to lookup for extension
> availability.
>
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-4-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

As mentioned in PATCH1, drop the "Link:" and the subsequent
"Signed-off-by:" lines.

> ---
>  arch/riscv/include/asm/hwcap.h | 6 ++++++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index b5952db9259f..ee200d8cfccb 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -126,6 +126,10 @@
>  #define RISCV_ISA_EXT_ZIC64B           116
>  #define RISCV_ISA_EXT_SV48             117
>  #define RISCV_ISA_EXT_SV57             118
> +#define RISCV_ISA_EXT_SSPESA           119
> +#define RISCV_ISA_EXT_SSPLCOFI         120

These two does not belong in this patch.

> +#define RISCV_ISA_EXT_SMCTR            121
> +#define RISCV_ISA_EXT_SSCTR            122
>
>  #define RISCV_ISA_EXT_XLINUXENVCFG     127
>
> @@ -136,10 +140,12 @@
>  #define RISCV_ISA_EXT_SxAIA            RISCV_ISA_EXT_SMAIA
>  #define RISCV_ISA_EXT_SUPM             RISCV_ISA_EXT_SMNPM
>  #define RISCV_ISA_EXT_SxCSRIND         RISCV_ISA_EXT_SMCSRIND
> +#define RISCV_ISA_EXT_SxCTR            RISCV_ISA_EXT_SMCTR
>  #else
>  #define RISCV_ISA_EXT_SxAIA            RISCV_ISA_EXT_SSAIA
>  #define RISCV_ISA_EXT_SUPM             RISCV_ISA_EXT_SSNPM
>  #define RISCV_ISA_EXT_SxCSRIND         RISCV_ISA_EXT_SSCSRIND
> +#define RISCV_ISA_EXT_SxCTR            RISCV_ISA_EXT_SSCTR
>  #endif
>
>  #endif /* _ASM_RISCV_HWCAP_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 72bce616491f..b3e3c30f4c8b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -652,6 +652,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
>         __RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinux=
envcfg_exts),
>         __RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
> +       __RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
>         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>         __RISCV_ISA_EXT_DATA_VALIDATE(ssccfg, RISCV_ISA_EXT_SSCCFG, riscv=
_ext_ssccfg_validate),
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> @@ -659,6 +660,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinux=
envcfg_exts),
>         __RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
>         __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> +       __RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
>         __RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
>         __RISCV_ISA_EXT_DATA_VALIDATE(svadu, RISCV_ISA_EXT_SVADU, riscv_e=
xt_svadu_validate),
>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> --
> 2.43.0
>

Regards,
Anup
