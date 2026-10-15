Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7064C9E06
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096991; cv=pass; b=KmuXYKRhs/Ng/x8DGm1lbiC6uiY7wah4MfU1PKzTTUeGgvu1fIeLe7htVkZ4IDi7PBuRvR/AWx4WNAEXcP+ZoGsXzRWTAzwzxgB7AaOU/9e8xq9CWl2v7xTDv0JuRKtx76JBdj+Ozwz0fPFNKfJCIR5yXpUnY4dwjZ2YQGo70dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096991; c=relaxed/simple;
	bh=fpQgL7zqW+wNr1zIyUSG2tROxfP1ReOgDcM5sZbvmzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB69jeEujwUVwMiFGZDnqF46Zyr3+lWNoGDR5rowMF0zr/KHbSaXUF/CCfChwDhS3s8KgNvXHv5NyFzycrT16kdWMzaHFbTaJB6YPANnGJQ+4BNsxPkaugt08L/w/nUyIGI9/O7TCv5Gl9K1nUwCjFrjEHdSixwKM3tb3cCiTdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJzmuXgH; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJzmuXgH"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so25101cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 13:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792096988; cv=none;
        d=google.com; s=arc-20260327;
        b=Pvuf9maj9429pVvbxPJndwktFNwUPNPnml/vUm7FVReYpOxCrWW15FKugYuzySbHi9
         9aes9BUC2+SdY8fcfWoqOugjSwq/0djqZoUIPl0dqzHLq/G/kfP2xHCQBp/mtqt6Tl05
         OmyGBtgwOS8+a04rxXDR0KE7C829z7HhZgVeTzdmxOghXZZRmke9HA6EGu5wIWCIlxMG
         Zm0DABPISaWBqb2i4p3sAlmFU4qm3xKFU2K0cEOFEYEi6gKk5Z063TW4Z/XNqaO2qRF8
         cqGFhIwPrt0mm+qpUU4a+/SB/tw7c+On6jPYq01vJpVYR/NJ2kVeXiVReP+r8znJUpBd
         kI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAB5wPUHGamwdatU6DxOtAu/ueiZHFunUW7sP3JUzxI=;
        fh=iImiLdKM2pLRhIGwB0mWNZH5HQ496L/OMNmlFmKqwPc=;
        b=WWoqCtK50Rq0HQrCbmAoIoqx/mmzsbZB0wpT9ciDH1e5+4qYP9u+vl0tr1bl7gU3Vv
         KHJoZSUA/4TQSIa5UJYUJvjE2otjXCy8fH5RhzeYaDHuLekDP2wzklU4ho6o1Z34bROB
         e9VEz7qw9MgwFUW+6+G2nhjGeBsFCr+TNpk6xowdLdi9S0/U/KjOwnxsjYrf5IG1BfRd
         px7HcaBfHxCLa1jrHNs0/UBRFg1q+gO9gny70xcm3nWSkbXAFJ//IJcIi11CopDQFRGJ
         PNHiaORt6LxeO98bTVhTj2VG7YvwUOX7qzg3XFChtiFO8EIJNpEXW5KHzqXYzN7ExP+7
         3ViA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792096988; x=1792701788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAB5wPUHGamwdatU6DxOtAu/ueiZHFunUW7sP3JUzxI=;
        b=eJzmuXgHVsVJWdEzr6eJY1f1yEEfSevLZHYDp3A6vdFEhxjxqgGVO6HDf28uwgoEAl
         DkRxf24y8sSBFCE8pIZlKvisz+HjHv1pjhhCzMgjN98hD8gHdeRTMo//qkDGK9KE4B7r
         ulMruHgZLnaADzPO+3OOt/RWEVUxKctd0W4M3oYvWsagZNsCSKaVrJbhH6LSI0+Nq4Yt
         ulwookpra3JOSg47L5HbRdDVa8ujGQP437KqZgF98Niu16ddhkqnJ4AW8MOlV8oacTSS
         jmxcHZ/RAetb5PCSAw2+mwb02+HLdKOIbEidOA4Hty6+opEyMdzSjff86AwVIwzvzOv+
         HACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096988; x=1792701788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAB5wPUHGamwdatU6DxOtAu/ueiZHFunUW7sP3JUzxI=;
        b=Acy89WAfMB7KDDSEj5qu4f+1UbUCHa1cSfn/qw5xOr4OS05JG3PbL+RCr+IYPoKJQb
         e0ZaewzxEIyeOIoUKmLzEPrPwkjftanVUuk5+GvdQYKmk7UidnjYPpLu5V7AROI2U+1W
         yWKPTaiS0va9PlBpw779jcYCF4grk0InwvnjvOqM27nir5WudHelOYpYJBhErnAgdDCP
         1adNcKGPqTMy8O5jJT8/0MS2k7b4nQISxRxfLWw8hlHHmmLJIDHTpnbUgqFi/fS6X2X7
         HpLr9bIOKcU3Lj3fakodj8A4lwsupWtE1NpzgNwkzEj7ATQ9m7UsaZQHskJA13TCNAF9
         fcXA==
X-Forwarded-Encrypted: i=1; AKwUvBxaOaiSVU5M43hqWFqH6QgyNITfE2BoOWVo+7LMwJlr+bPuDOb3Zpmmd7yGD/e1tKXQ/SkvR6DbGixSZ/YegyWJ@vger.kernel.org
X-Gm-Message-State: AFq9FYKsEIBLNGZs0toLa8whNXgUzJHuhFvQUwbKnQVldY4CGamgzz6D
	1lWtUj39jZ/9lQULu7EuEUu+BioAx9vHR26aZtINT0r/CDcxqBUl+yeXWt6tlKsEQCDBP5t6sHS
	lcldnJwNPLORCkHJXZEYlD3CjvrqeBXgnYM2Qli5t
X-Gm-Gg: AYBFou3hIB3vASbPHWB7hwt6OMigu7b6zFUjIc4dwSxOf4KQgBBMkjzO59fra09eI9u
	+20BjGCdtRrWTlGdYQTETj3Y4krvrs+ZOICUj6CFQOp0Rufw1rBW8bR5rPTd515/SBa1OT4DIyb
	Fjyj4qs8ibKO6LK/e3+1Kw+pqC3ygChuvBlfbnoKmrb2MStr8Q3Y4WVpkfCjFWEmkHXIGLWrJwo
	wIvc62qFbpem+4ShyWZ5EPgnCKVo+0hQDZ2KwAiAt4jnfoZ4ZaAJzj3BlYoCiK00TW1ZykMbeTj
	KXPXRPeh2hk/HsBOHHS7XpqKDvaAdhm0jbaiQi1KCtUpf0N9fstg3GIn
X-Received: by 2002:a05:622b:da:10b0:532:9003:35b1 with SMTP id
 d75a77b69052e-536296751d7mr3921681cf.2.1792096987506; Thu, 15 Oct 2026
 13:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015060430.5877-1-ravi.bangoria@amd.com> <20261015060430.5877-3-ravi.bangoria@amd.com>
In-Reply-To: <20261015060430.5877-3-ravi.bangoria@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 13:42:51 -0700
X-Gm-Features: AclHuK-iC84TxLC2NgPzRKp_ipyKQ7WfTjp-m6hssJeqnP_I8D-Eg3EHFWYlDEQ
Message-ID: <CALMp9eR7BFGU0zOwTmLF571t-ZcuY5NjkD2nNXWNJoa=cEitTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/amd/ibs: Fix kernel address leak via REGS_USER
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jayapal Ashwin Nair <janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Santosh Shukla <santosh.shukla@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> IBS hardware captures a sample and raises an NMI. Since the NMI can be
> delivered with a delay, a privilege change may occur between sample
> capture and NMI delivery. Because IBS only provides the sample RIP, the
> kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
> if a privilege switch occurred in the interim. This can leak kernel
> addresses to unprivileged users through PERF_SAMPLE_REGS_USER.
>
> Fix this by discarding samples where the NMI arrives in kernel mode and
> the user has set exclude_kernel.

This will systematically under-sample instructions just before a
transition to the kernel. For this special case, perhaps the GPRs
could be obtained from task_pt_regs(current) instead of the NMI
pt_regs?

> Reported-by: Jayapal Ashwin Nair <janair@amd.com>
> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD=
 IBS")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index bfb51f8e184f..3cb46c775eaa 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1373,12 +1373,15 @@ static bool perf_ibs_is_kernel_br_target(struct p=
erf_event *event,
>  }
>
>  static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct pe=
rf_event *event,
> -                                   struct pt_regs *regs, struct perf_ibs=
_data *ibs_data,
> -                                   int br_target_idx)
> +                                   struct pt_regs *regs, struct pt_regs =
*iregs,
> +                                   struct perf_ibs_data *ibs_data, int b=
r_target_idx)
>  {
>         if (perf_exclude_event(event, regs))
>                 return true;
>
> +       if (perf_exclude_event(event, iregs))
> +               return true;

This excludes events with an NMI skid past a privilege change in both
directions. Do you want to omit a kernel sample taken just before
returning to userspace if the NMI arrives in userspace and
exclude_user is set?
