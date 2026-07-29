Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60383BED42
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311299; cv=pass; b=DIRXF3GZiDMbVt7YIXi79+P6m77rfLguZEMpJlGReVRe4Ia2OmxSStyIvygDn78aDdtbOenxjyZEPSZEHeaxQTLytjus080KBZdZjvSl4joDNN/M/gtXOhwzT/17n1EojzwjjU/MqYdHHMb92XvDFSkrnfzHIGuCmBMM4OgDJB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311299; c=relaxed/simple;
	bh=CZj/NhH52N9RNIvHTBwwKz3b5P0nT1hKmjiXvDk4TTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGFiR7moaZXyDdXfcNZtYvEk7D8uwwSdJm42pVVoZcSAH9+APb39HXIyNjFuBBZqM5WDLZx2aOqe7U43/jVq33YuftLgJmNQpZyV//TfBkvZ2CYEkwXDG1rHXm5X2F2HDaTRa+ZLsU2XLOyNsv7QP9KB4JSfTfLtQo77i0MtuW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzFiKmFq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EyGaR6EA; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzFiKmFq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EyGaR6EA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7fCwU1390275
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 07:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKolMC5fA33kz/eUm1kp5MZFAMmOTbwvrUG4Fb8sqR0=; b=dzFiKmFqK3m31laN
	8DPJKO+RLEuR2+zGIyRwkFWoYyKU5EyG6JFlQGQPmmg9sFwouS0SbNQV3U2EeKLF
	k9eCDtvdRi/8gU/EtHnNPFwC236kqPq4mmDgfb2dRxXFTzviSw457h1uforM+Zes
	XfFenLYKbQ9aZLQEulVoOfC/N9cC1Fk7Xj9q0Ltv1C6b8KC8h6p5jMf0ZKYYHCW+
	ewIg5B86D8vzuajOFCJmjrPTuxEAbiUuzc38VnWsiAVK73MX30F+N8vr+h1YRE7M
	EThSz9t9jmjIN8I/b3HCC7ZoWXygnNSQdLbwhMSyBR0FyRyfvONFLtpzQwwSLI1X
	qSRwig==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbmxrevt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 07:48:03 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4519ef1babeso279217fac.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 00:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311282; cv=none;
        d=google.com; s=arc-20260327;
        b=ceYgTWTz7Yy8fHv9KfXcOOE2jY5/GtcbY0dRr1dJpXN7uWDPM02NoW1RYgq0O13lab
         kIz3+XbzYmkUBn3sdGxevepBj8Ia9FV5oG4UQEK2qXPRooJgHvB+ovuJY92OrfGQqClu
         fHUcy/M5z1HcR8VZL5LSh38bL86mkBgUZVsOWPyTjOoCGpYdJVP9SEzccxhiJNhgkTC5
         WcQjYMRXUtz0vHAhZa5qsO74Gy6/LlV1paBACa7q23E9/iTNJz7jZwtnQBSMjCb0ziMS
         yUvenXXCiWoxp6WKkIec0XmiURhOFsFCgEgLchnf7zdxIV/gaPerow2cNPFUyO8+JXWX
         6/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FKolMC5fA33kz/eUm1kp5MZFAMmOTbwvrUG4Fb8sqR0=;
        fh=fqlAtCtOEy9esVQjXiHiic8lZ60PO3JUPWNn0KkpXLk=;
        b=YF2n1LEp/6UOxPq3uhEO7seJrDgeZmjALUxs4Wc4nWQ37eTdVFZ71T7Zf70Rt3Dptx
         AqU54SK5qeZMuEEUGldICahea4qZ5C0NPoS6OaRKqKdowCKzejcsMcgo1IjtR3vAVcfT
         19FNh+8pNmBb33b4wRr/NhD+n5OYCQb62xqEXYOJboaEXcRJe/MnYYbpY2DQfhBBXKAd
         rdi0HptT/rE5ipWESjlrouyRwb/vK1w5zj/lVfYfHJSeGcN82BAFx2Z1pw0478NYVSZZ
         HlfE353DLnHjY6+KwNS93vdV2dWyFGP0QXSS6L/7TjOni63Y8+XHsXJYHakVKwe7yPTj
         6c5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785311282; x=1785916082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FKolMC5fA33kz/eUm1kp5MZFAMmOTbwvrUG4Fb8sqR0=;
        b=EyGaR6EAhxuxCTk9vWZo3PlkMyw3yXfViox45a2itKMyimnT/kEQrb35y5gXmhVIKU
         tWkk0c40X08Ekk1t6imEu9tMy+715J+KuSxHzkkYaWVhwId7i7aYk0wdutIySt1wKW+O
         oiM2ThlSaNh0M1038dF97NC7T8PIb8xgw50TwB0xGJrqhqLwDgVM//eyyWmS0JYGm64A
         vRmqnZzn7cXWDdwe0So5bKOE+dW24wVZIY8h9DJBhizX9g68eCFDIb1OOm7CAsW+2JlK
         wXtQMc4p6lw+4qtUii0VJaR+JjZ0uK/jCgsL9KmzE6aBPGG9Xo8kxy9l8lhofxdAJrPN
         1gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311282; x=1785916082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKolMC5fA33kz/eUm1kp5MZFAMmOTbwvrUG4Fb8sqR0=;
        b=kGq1dkv7PDIQzOgdYrM5kRSOnBZMLVarq4rzianXAYmFfTv2YFK3u8mqp25PjBq7IV
         1L3SBPOCx8lAlsmLw68xvZIq8PYBqwy7CnOHa/xphGzpeRYollmBsK0BHTToSAdKNYLL
         qGG9aaR13WfJjKIOqqE18BXxr5DLL7e0uRnM/oIjPgwiK3bOC8w5oa2keAO+dIDaMFme
         eVg2FXwr7xayIAiJs/neaEkPLyf60/i65YFD+rLf0waHVFbcrRRXcRyedWnkb17LDH6y
         ZAa0TXzQA8tiUjc4cWmT7kxqmcEZ1adc09jLkSX7TDrJb9JkuWnA5wajQEgWrA8rRDWg
         PKZA==
X-Forwarded-Encrypted: i=1; AHgh+RpwY7BmMvmvWekqljGdM3lsRXASluZU6jD4RxHVJa/OTu7fTa0alT4nHEgN2pgNpPlyeMRHlTSew9/XZ2xEQc+B@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nu/S+PK2sea1/Lw6+KfdwenGj/mxXai2g1dQTMneIJ9SCYjC
	l4ISEU62pmn+m/+zMGyaM4Dm+IoGWeHGatr3co1kZ3bX/iFRC6Eeqqm1vBUhWOkDeVnaJw1KyMV
	f1J2SZ5G6+x/kBpirZ5HkcDXyWiuqMeq2Lv7sTE6WFg7yDuENiqMAHN6y571+iSO37JwYLO0HlJ
	PMVugILpmlCXBgaseuqeZGQ+CuF1tyYl0v5fJqaNoGGYv5tsA=
X-Gm-Gg: AR+sD12U7p5IvlNGEcfKrXQfPyTvxo8j9jGf1QeEB4YY6iP/btaEY+TjyCatE4Gw7K9
	IYFkEWCI2ufLCbMmGy6Moc7qSpyxwtekumm1REmGXwcd23HDyokBuzEs1mEb60xSuDO5WeM6Hvo
	ZOccI1OfRJp4ThSJRpWz8rNVkCzQfbhgp5QrR50Vz176Zgp3FVrepACNrmUA==
X-Received: by 2002:a05:6870:a495:b0:447:7db4:d287 with SMTP id 586e51a60fabf-4586ccabff3mr3174372fac.16.1785311282214;
        Wed, 29 Jul 2026 00:48:02 -0700 (PDT)
X-Received: by 2002:a05:6870:a495:b0:447:7db4:d287 with SMTP id
 586e51a60fabf-4586ccabff3mr3174347fac.16.1785311281645; Wed, 29 Jul 2026
 00:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com> <45918ddc68df98ec25ac93c0bbab7da90a4ecbf9.1778331862.2.git.zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <45918ddc68df98ec25ac93c0bbab7da90a4ecbf9.1778331862.2.git.zhangzhanpeng.jasper@bytedance.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 13:17:49 +0530
X-Gm-Features: AUfX_myS4pMpcUUMRYzKBZIreiBhcf4CMhJYGs4hSkcjp62q_v5hhBDdYkd-IHE
Message-ID: <CA+Ht8=b59YDH+7jrea8PcFq3HtFaSk81O8oyQAQ1+ZP3aCb0QQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] riscv: add support for SBI Supervisor Software
 Events extension
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Himanshu Chauhan <himanshu@thechauhan.dev>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Shuah Khan <shuah@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
        Zhu Yuan <yuanzhu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2MSBTYWx0ZWRfX954fU/eDLMhL
 s7y6j5xrz3ijNQ59/2CUMf21Qbf1oylK0dIUBZ8RdVs7sRYYWXmPz0CxU7wiAl74sTOM/5EdMnA
 qJKm3jWeETmOSnUf+5rxV0+ksS6LZNOcRWRrPeakxA85DNITGZ/fZgUfoFnIoqgQjhPw5MEJL0k
 7rPXwBw9SLbgIzE0SYsy0jdrpsGquA6KfJr8ZMgAlaKK32JCirXlJXqKQe4a6Y9VeHmQbIPw/dA
 Bmu1VvzVimvFbj8jCv0Pjcm0besCafT3q1Z72PClMCCSAjfFM/QFpLuZevWVeCPMl0TgP7B67JO
 TzVUSYM7WkNbVIQTTfh+ebhQ0a140sV21wM+YVWN2VsjKZW5pbdDL62OuqMP7p7kuvNV4f8z5kg
 LV4WPCI4LZuJ94FRZIEG6Ae+sJX+ZsI86C1+5Te5rPTq1pvztFtat6hxH0J3JSuiMVLs/+MtA50
 aB7KG+Ga10DWH3IWmOA==
X-Proofpoint-ORIG-GUID: 6xhAvddphZjBKmNcTXFg0l7xFTHew9EM
X-Proofpoint-GUID: 6xhAvddphZjBKmNcTXFg0l7xFTHew9EM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2MSBTYWx0ZWRfXy3U9vMsGB0yb
 Mt0eHih/qkEHO9zALH3mnWoIwkRZtw+vmv6ZlEijD7mLPjOATGrf395fqXqtr/RD62HrtBjpiTu
 IOixahlGUAq2PN0kdJKkBQTVVjPz6vI=
X-Authority-Analysis: v=2.4 cv=fLIJG5ae c=1 sm=1 tr=0 ts=6a69b033 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=968KyxNXAAAA:8 a=h0uksLzaAAAA:8
 a=6FyGoESsRhbTB4LYef0A:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290061

Hi Zhanpeng,

This patch seems to be broken when I pull the complete patch set (b4
or git am with mutt).


On Sat, May 9, 2026 at 6:40=E2=80=AFPM Zhanpeng Zhang
<zhangzhanpeng.jasper@bytedance.com> wrote:
>
> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>
> The SBI SSE extension allows the supervisor software to be notified by
> the SBI of specific events that are not maskable. The context switch is
> handled partially by the firmware which will save registers a6 and a7.
> When entering kernel we can rely on these 2 registers to setup the stack
> and save all the registers.
>
> Since SSE events can be delivered at any time to the kernel, including
> during exception handling, we need a way to locate the current_task for
> context tracking. On RISC-V, it is stored in scratch when in user space
> or tp when in kernel space (in which case SSCRATCH is zero). But at the
> beginning of exception handling, SSCRATCH is used to swap tp and
> check the origin of the exception. If interrupted at that point, then,
> there is no way to reliably know where is located the current
> task_struct. Even checking the interruption location won't work as SSE
> event can be nested on top of each other so the original interruption
> site might be lost at some point. In order to retrieve it reliably,
> store the current task in an additional __sse_entry_task per_cpu array.
> This array is then used to retrieve the current task based on the
> hart ID that is passed to the SSE event handler in a6.
>
> That being said, the way the current task struct is stored should
> probably be reworked to find a better reliable alternative.
>
> Since each event (and each CPU for local events) have their own
> context and can preempt each other, allocate a stack (and a shadow stack
> if needed) for each of them (and for each cpu for local events).
>
> The SSE handler runs as a synthetic handler episode, but completion must
> resume the context that was interrupted by the SSE event.  Preserve stvec
> and, when the hypervisor extension is present, hstatus across do_sse() so
> the handler episode does not leak trap-vector or virtualization state int=
o
> the interrupted context.
>
> When completing the event, if we were coming from kernel with interrupts
> disabled, simply return there. If coming from userspace or kernel with
> interrupts enabled, simulate an interrupt exception by setting IE_SIE in
> CSR_IP to allow delivery of signals to user task. For instance this can
> happen when a RAS event has been generated by a user application and a
> SIGBUS has been sent to a task.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  arch/riscv/include/asm/asm.h         |  14 +-
>  arch/riscv/include/asm/scs.h         |   7 +
>  arch/riscv/include/asm/sse.h         |  47 +++++++
>  arch/riscv/include/asm/switch_to.h   |  14 ++
>  arch/riscv/include/asm/thread_info.h |   1 +
>  arch/riscv/kernel/Makefile           |   1 +
>  arch/riscv/kernel/asm-offsets.c      |  14 ++
>  arch/riscv/kernel/sbi_sse.c          | 162 +++++++++++++++++++++++
>  arch/riscv/kernel/sbi_sse_entry.S    | 187 +++++++++++++++++++++++++++
>  9 files changed, 444 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sse.h
>  create mode 100644 arch/riscv/kernel/sbi_sse.c
>  create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index e9e8ba83e632..50bace00053c 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -90,16 +90,24 @@
>  .endm
>
>  #ifdef CONFIG_SMP
> -.macro asm_per_cpu dst sym tmp
> -       lw    \tmp, TASK_TI_CPU_NUM(tp)
> -       slli  \tmp, \tmp, RISCV_LGPTR
> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
> +       slli  \tmp, \cpu, RISCV_LGPTR
>         la    \dst, __per_cpu_offset
>         add   \dst, \dst, \tmp
>         REG_L \tmp, 0(\dst)
>         la    \dst, \sym
>         add   \dst, \dst, \tmp
>  .endm
> +
> +.macro asm_per_cpu dst sym tmp
> +       lw \tmp, TASK_TI_CPU_NUM(tp)
> +       asm_per_cpu_with_cpu \dst \sym \tmp \tmp
> +.endm
>  #else /* CONFIG_SMP */
> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
> +       la    \dst, \sym
> +.endm
> +
>  .macro asm_per_cpu dst sym tmp
>         la    \dst, \sym
>  .endm
> diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
> index 023a412fe38d..0d70a35bc01a 100644
> --- a/arch/riscv/include/asm/scs.h
> +++ b/arch/riscv/include/asm/scs.h
> @@ -17,6 +17,11 @@
>         load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
>  .endm
>
> +/* Load the per-CPU IRQ shadow call stack to gp. */
> +.macro scs_load_sse_stack reg_evt
> +       REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
> +.endm
> +
>  /* Load task_scs_sp(current) to gp. */
>  .macro scs_load_current
>         REG_L   gp, TASK_TI_SCS_SP(tp)
> @@ -40,6 +45,8 @@
>  .endm
>  .macro scs_load_irq_stack tmp
>  .endm
> +.macro scs_load_sse_stack reg_evt
> +.endm
>  .macro scs_load_current
>  .endm
>  .macro scs_load_current_if_task_changed prev
> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
> new file mode 100644
> index 000000000000..d3ce8c2b5221
> --- /dev/null
> +++ b/arch/riscv/include/asm/sse.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +#ifndef __ASM_SSE_H
> +#define __ASM_SSE_H
> +
> +#include <asm/sbi.h>
> +
> +#ifdef CONFIG_RISCV_SBI_SSE
> +
> +struct sse_event_interrupted_state {
> +       unsigned long a6;
> +       unsigned long a7;
> +};
> +
> +struct sse_event_arch_data {
> +       void *stack;
> +       void *shadow_stack;
> +       unsigned long tmp;
> +       struct sse_event_interrupted_state interrupted;
> +       unsigned long interrupted_phys;
> +       u32 evt_id;
> +       unsigned int hart_id;
> +       unsigned int cpu_id;
> +};
> +
> +static inline bool sse_event_is_global(u32 evt)
> +{
> +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
> +}
> +
> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int=
 cpu);
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id=
,
> +                       int cpu);
> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
> +
> +void sse_handle_event(struct sse_event_arch_data *arch_evt,
> +                     struct pt_regs *regs);
> +asmlinkage void handle_sse(void);
> +asmlinkage void do_sse(struct sse_event_arch_data *arch_evt,
> +                      struct pt_regs *reg);
> +
> +#endif
> +
> +#endif
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920..ded8dc440b12 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -88,6 +88,19 @@ static inline void __switch_to_envcfg(struct task_stru=
ct *next)
>                         :: "r" (next->thread.envcfg) : "memory");
>  }
>
> +#ifdef CONFIG_RISCV_SBI_SSE
> +DECLARE_PER_CPU(struct task_struct *, __sbi_sse_entry_task);
> +
> +static inline void __switch_sbi_sse_entry_task(struct task_struct *next)
> +{
> +       __this_cpu_write(__sbi_sse_entry_task, next);
> +}
> +#else
> +static inline void __switch_sbi_sse_entry_task(struct task_struct *next)
> +{
> +}
> +#endif
> +
>  extern struct task_struct *__switch_to(struct task_struct *,
>                                        struct task_struct *);
>
> @@ -122,6 +135,7 @@ do {                                                 =
       \
>         if (switch_to_should_flush_icache(__next))      \
>                 local_flush_icache_all();               \
>         __switch_to_envcfg(__next);                     \
> +       __switch_sbi_sse_entry_task(__next);            \
>         ((last) =3D __switch_to(__prev, __next));         \
>  } while (0)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 55019fdfa9ec..d14b45610c73 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -36,6 +36,7 @@
>  #define OVERFLOW_STACK_SIZE     SZ_4K
>
>  #define IRQ_STACK_SIZE         THREAD_SIZE
> +#define SSE_STACK_SIZE         THREAD_SIZE
>
>  #ifndef __ASSEMBLER__
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index cabb99cadfb6..8d4aed6368a6 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)        +=3D mcount-dyn.o
>  obj-$(CONFIG_PERF_EVENTS)      +=3D perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   +=3D perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                +=3D sbi.o sbi_ecall.o
> +obj-$(CONFIG_RISCV_SBI_SSE)    +=3D sbi_sse.o sbi_sse_entry.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP)              +=3D sbi-ipi.o
>  obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index af827448a609..7cc03f5a0673 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -15,6 +15,8 @@
>  #include <asm/ptrace.h>
>  #include <asm/cpu_ops_sbi.h>
>  #include <asm/stacktrace.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
>  #include <asm/suspend.h>
>
>  void asm_offsets(void);
> @@ -533,6 +535,18 @@ void asm_offsets(void)
>         DEFINE(FREGS_A6,            offsetof(struct __arch_ftrace_regs, a=
6));
>         DEFINE(FREGS_A7,            offsetof(struct __arch_ftrace_regs, a=
7));
>  #endif
> +
> +#ifdef CONFIG_RISCV_SBI_SSE
> +       OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
> +       OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stac=
k);
> +       OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
> +       OFFSET(SSE_REG_HART_ID, sse_event_arch_data, hart_id);
> +       OFFSET(SSE_REG_CPU_ID, sse_event_arch_data, cpu_id);
> +
> +       DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
> +       DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
> +       DEFINE(ASM_NR_CPUS, CONFIG_NR_CPUS);
> +#endif
>  #ifdef CONFIG_RISCV_SBI
>         DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>         DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
> diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
> new file mode 100644
> index 000000000000..f30ae9ff77c9
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Rivos Inc.
> + */
> +#include <linux/nmi.h>
> +#include <linux/scs.h>
> +#include <linux/bitfield.h>
> +#include <linux/percpu-defs.h>
> +
> +#include <asm/asm-prototypes.h>
> +#include <asm/switch_to.h>
> +#include <asm/irq_stack.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> +
> +DEFINE_PER_CPU(struct task_struct *, __sbi_sse_entry_task);
> +
> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, struc=
t pt_regs *regs)
> +{
> +}
> +
> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
> +{
> +       nmi_enter();
> +
> +       /* Retrieve missing GPRs from SBI */
> +       sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
> +                 SBI_SSE_ATTR_INTERRUPTED_A6,
> +                 (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED=
_A6) + 1,
> +                 arch_evt->interrupted_phys, 0, 0);
> +
> +       memcpy(&regs->a6, &arch_evt->interrupted, sizeof(arch_evt->interr=
upted));
> +
> +       sse_handle_event(arch_evt, regs);
> +
> +       nmi_exit();
> +}
> +
> +static void *alloc_to_stack_pointer(void *alloc)
> +{
> +       return alloc ? alloc + SSE_STACK_SIZE : NULL;
> +}
> +
> +static void *stack_pointer_to_alloc(void *stack)
> +{
> +       return stack - SSE_STACK_SIZE;
> +}
> +
> +#ifdef CONFIG_VMAP_STACK
> +static void *sse_stack_alloc(unsigned int cpu)
> +{
> +       void *stack =3D arch_alloc_vmap_stack(SSE_STACK_SIZE, cpu_to_node=
(cpu));
> +
> +       return alloc_to_stack_pointer(stack);
> +}
> +
> +static void sse_stack_free(void *stack)
> +{
> +       vfree(stack_pointer_to_alloc(stack));
> +}
> +
> +static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_evt=
)
> +{
> +       void *p_stack =3D arch_evt->stack;
> +       unsigned long stack =3D (unsigned long)stack_pointer_to_alloc(p_s=
tack);
> +       unsigned long stack_end =3D stack + SSE_STACK_SIZE;
> +
> +       /*
> +        * Flush the tlb to avoid taking any exception when accessing the
> +        * vmapped stack inside the SSE handler
> +        */
> +       if (sse_event_is_global(arch_evt->evt_id))
> +               flush_tlb_kernel_range(stack, stack_end);
> +       else
> +               local_flush_tlb_kernel_range(stack, stack_end);
> +}
> +#else /* CONFIG_VMAP_STACK */
> +static void *sse_stack_alloc(unsigned int cpu)
> +{
> +       void *stack =3D kmalloc(SSE_STACK_SIZE, GFP_KERNEL);
> +
> +       return alloc_to_stack_pointer(stack);
> +}
> +
> +static void sse_stack_free(void *stack)
> +{
> +       kfree(stack_pointer_to_alloc(stack));
> +}
> +
> +static void arch_sse_stack_cpu_sync(struct sse_event_arch_data *arch_evt=
) {}
> +#endif /* CONFIG_VMAP_STACK */
> +
> +static int sse_init_scs(int cpu, struct sse_event_arch_data *arch_evt)
> +{
> +       void *stack;
> +
> +       if (!scs_is_enabled())
> +               return 0;
> +
> +       stack =3D scs_alloc(cpu_to_node(cpu));
> +       if (!stack)
> +               return -ENOMEM;
> +
> +       arch_evt->shadow_stack =3D stack;
> +
> +       return 0;
> +}
> +
> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int=
 cpu)
> +{
> +       arch_evt->cpu_id =3D cpu;
> +       arch_evt->hart_id =3D cpuid_to_hartid_map(cpu);
> +}
> +
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id=
,
> +                       int cpu)
> +{
> +       void *stack;
> +
> +       arch_evt->evt_id =3D evt_id;
> +       stack =3D sse_stack_alloc(cpu);
> +       if (!stack)
> +               return -ENOMEM;
> +
> +       arch_evt->stack =3D stack;
> +
> +       if (sse_init_scs(cpu, arch_evt)) {
> +               sse_stack_free(arch_evt->stack);
> +               return -ENOMEM;
> +       }
> +
> +       if (sse_event_is_global(evt_id)) {
> +               arch_evt->interrupted_phys =3D
> +                                       virt_to_phys(&arch_evt->interrupt=
ed);
> +       } else {
> +               arch_evt->interrupted_phys =3D
> +                               per_cpu_ptr_to_phys(&arch_evt->interrupte=
d);
> +       }
> +
> +       arch_sse_event_update_cpu(arch_evt, cpu);
> +
> +       return 0;
> +}
> +
> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
> +{
> +       scs_free(arch_evt->shadow_stack);
> +       sse_stack_free(arch_evt->stack);
> +}
> +
> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
> +{
> +       struct sbiret sret;
> +
> +       arch_sse_stack_cpu_sync(arch_evt);
> +
> +       sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, arch_evt-=
>evt_id,
> +                        (unsigned long)handle_sse, (unsigned long)arch_e=
vt, 0,
> +                        0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
> diff --git a/arch/riscv/kernel/sbi_sse_entry.S b/arch/riscv/kernel/sbi_ss=
e_entry.S
> new file mode 100644
> index 000000000000..6086751e6644
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse_entry.S
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025 Rivos Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +
> +#include <asm/alternative-macros.h>
> +#include <asm/asm.h>
> +#include <asm/csr.h>
> +#include <asm/hwcap.h>
> +#include <asm/scs.h>
> +
> +/* When entering handle_sse, the following registers are set:
> + * a6: contains the hartid
> + * a7: contains a sse_event_arch_data struct pointer
> + */
> +SYM_CODE_START(handle_sse)
> +       /* Save stack temporarily */
> +       REG_S sp, SSE_REG_EVT_TMP(a7)
> +       /* Set entry stack */
> +       REG_L sp, SSE_REG_EVT_STACK(a7)
> +
> +       addi sp, sp, -(PT_SIZE_ON_STACK)
> +       REG_S ra, PT_RA(sp)
> +       REG_S s0, PT_S0(sp)
> +       REG_S s1, PT_S1(sp)
> +       REG_S s2, PT_S2(sp)
> +       REG_S s3, PT_S3(sp)
> +       REG_S s4, PT_S4(sp)
> +       REG_S s5, PT_S5(sp)
> +       REG_S s6, PT_S6(sp)
> +       REG_S s7, PT_S7(sp)
> +       REG_S s8, PT_S8(sp)
> +       REG_S s9, PT_S9(sp)
> +       REG_S s10, PT_S10(sp)
> +       REG_S s11, PT_S11(sp)
> +       REG_S tp, PT_TP(sp)
> +       REG_S t0, PT_T0(sp)
> +       REG_S t1, PT_T1(sp)
> +       REG_S t2, PT_T2(sp)
> +       REG_S t3, PT_T3(sp)
> +       REG_S t4, PT_T4(sp)
> +       REG_S t5, PT_T5(sp)
> +       REG_S t6, PT_T6(sp)
> +       REG_S gp, PT_GP(sp)
> +       REG_S a0, PT_A0(sp)
> +       REG_S a1, PT_A1(sp)
> +       REG_S a2, PT_A2(sp)
> +       REG_S a3, PT_A3(sp)
> +       REG_S a4, PT_A4(sp)
> +       REG_S a5, PT_A5(sp)
> +
> +       /* Retrieve entry sp */
> +       REG_L a4, SSE_REG_EVT_TMP(a7)
> +       /* Save CSRs */
> +       csrr a0, CSR_EPC
> +       csrr a1, CSR_SSTATUS
> +       csrr a2, CSR_STVAL
> +       csrr a3, CSR_SCAUSE
> +
> +       REG_S a0, PT_EPC(sp)
> +       REG_S a1, PT_STATUS(sp)
> +       REG_S a2, PT_BADADDR(sp)
> +       REG_S a3, PT_CAUSE(sp)
> +       REG_S a4, PT_SP(sp)
> +
> +       /* Disable user memory access and floating/vector computing */
> +       li t0, SR_SUM | SR_FS_VS
> +       csrc CSR_STATUS, t0
> +
> +       load_global_pointer
> +       scs_load_sse_stack a7
> +
> +#ifdef CONFIG_SMP
> +       lw t4, SSE_REG_HART_ID(a7)
> +       lw t3, SSE_REG_CPU_ID(a7)
> +
> +       bne t4, a6, .Lfind_hart_id_slowpath
> +
> +.Lcpu_id_found:
> +#else
> +       mv t3, zero
> +#endif
> +
> +       asm_per_cpu_with_cpu t2 __sbi_sse_entry_task t1 t3
> +       REG_L tp, 0(t2)
> +
> +       mv a1, sp /* pt_regs on stack */
> +
> +       /*
> +        * Run the SSE handler with the normal exception vector, but rest=
ore the
> +        * interrupted stvec before completing the event. SSE can arrive =
while
> +        * the kernel is using a temporary trap vector in a sensitive ent=
ry path.
> +        */
> +       csrr s3, CSR_STVEC
> +       la t0, handle_exception
> +       csrw CSR_STVEC, t0
> +
> +       /*
> +        * Preserve the full HS-mode virtualization state across the hand=
ler.
> +        * hstatus is live supervisor state rather than an SSE interrupte=
d
> +        * attribute, and OpenSBI consumes hstatus.SPV during event compl=
etion.
> +        * Saving the whole CSR keeps the handler episode transparent to =
KVM and
> +        * avoids having to infer which hstatus bits may matter to a gues=
t resume.
> +        */
> +       ALTERNATIVE("nop", "csrr s5, hstatus", 0, RISCV_ISA_EXT_h, 1)
> +
> +       /*
> +        * Save sscratch for restoration since we might have interrupted =
the
> +        * kernel in early exception path and thus, we don't know the con=
tent of
> +        * sscratch.
> +        */
> +       csrrw s4, CSR_SSCRATCH, x0
> +
> +       mv a0, a7
> +
> +       call do_sse
> +
> +       csrw CSR_SSCRATCH, s4
> +       ALTERNATIVE("nop", "csrw hstatus, s5", 0, RISCV_ISA_EXT_h, 1)
> +       csrw CSR_STVEC, s3
> +
> +       REG_L a0, PT_STATUS(sp)
> +       REG_L a1, PT_EPC(sp)
> +       REG_L a2, PT_BADADDR(sp)
> +       REG_L a3, PT_CAUSE(sp)
> +       csrw CSR_SSTATUS, a0
> +       csrw CSR_EPC, a1
> +       csrw CSR_STVAL, a2
> +       csrw CSR_SCAUSE, a3
> +
> +       REG_L ra, PT_RA(sp)
> +       REG_L s0, PT_S0(sp)
> +       REG_L s1, PT_S1(sp)
> +       REG_L s2, PT_S2(sp)
> +       REG_L s3, PT_S3(sp)
> +       REG_L s4, PT_S4(sp)
> +       REG_L s5, PT_S5(sp)
> +       REG_L s6, PT_S6(sp)
> +       REG_L s7, PT_S7(sp)
> +       REG_L s8, PT_S8(sp)
> +       REG_L s9, PT_S9(sp)
> +       REG_L s10, PT_S10(sp)
> +       REG_L s11, PT_S11(sp)
> +       REG_L tp, PT_TP(sp)
> +       REG_L t0, PT_T0(sp)
> +       REG_L t1, PT_T1(sp)
> +       REG_L t2, PT_T2(sp)
> +       REG_L t3, PT_T3(sp)
> +       REG_L t4, PT_T4(sp)
> +       REG_L t5, PT_T5(sp)
> +       REG_L t6, PT_T6(sp)
> +       REG_L gp, PT_GP(sp)
> +       REG_L a0, PT_A0(sp)
> +       REG_L a1, PT_A1(sp)
> +       REG_L a2, PT_A2(sp)
> +       REG_L a3, PT_A3(sp)
> +       REG_L a4, PT_A4(sp)
> +       REG_L a5, PT_A5(sp)
> +
> +       REG_L sp, PT_SP(sp)
> +
> +       li a7, SBI_EXT_SSE
> +       li a6, SBI_SSE_EVENT_COMPLETE
> +       ecall
> +
> +#ifdef CONFIG_SMP
> +.Lfind_hart_id_slowpath:
> +
> +       /* Restore current task struct from __sbi_sse_entry_task */
> +       li t1, ASM_NR_CPUS
> +       /* Slowpath to find the CPU id associated to the hart id */
> +       la t0, __cpuid_to_hartid_map
> +
> +.Lhart_id_loop:
> +       REG_L t2, 0(t0)
> +       beq t2, a6, .Lcpu_id_found
> +
> +       /* Increment pointer and CPU number */
> +       addi t3, t3, 1
> +       addi t0, t0, RISCV_SZPTR
> +       bltu t3, t1, .Lhart_id_loop
> +
> +       /*
> +        * This should never happen since we expect the hart_id to match =
one
The code following goes missing in this file.

> +        * of our CPU, but better be safe than sorry
> +        */
> +       la tp, init_task
> +       la a0, sse_hart_id_panic_string
> +       la t0, panic
> +       jalr t0
> +#endif
> +
> +SYM_CODE_END(handle_sse)
> +
> +SYM_DATA_START_LOCAL(sse_hart_id_panic_string)
> +    .ascii "Unable to match hart_id with cpu\0"
> +SYM_DATA_END(sse_hart_id_panic_string)

Regards
Himanshu
> --
> 2.50.1 (Apple Git-155)
>
