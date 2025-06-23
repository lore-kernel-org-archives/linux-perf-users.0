Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F429CB2A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701229; cv=none; b=JiB1ubF+12G/mFgUKyU9qAGmdscFP3SICscAxXgyCy81EMd4jRYxUCpwm/YRaJKh1lAw711nPfZ4jpJA7bUIraaMNl2qT7qrGVEUNYBa3pJNuqngSpPDlkbytlFbe5upM3OsRmZHzDXYLdGFUkXqUFCLCx1R1kbG3daGNi7Nm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701229; c=relaxed/simple;
	bh=3QhJtzFP7oTRzX4HiLlB5ZhYEtFGRUp8DPuyNCN6c9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbk79XTxkrDK6rFvG3zYie1jiulzqEf2O7YFrVsf84cL0EMTNFv79akSvkIo9mZEVD8zTU+D2G8ny4LQR+jXXVPR3Rgdkvdao0gOQ8Z4l6TksgWVdpTbvlrPAgYE7VqLF6Le0j69j7OhLyIr84f30Szcn1p7j0t0RBoObYJNFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnA1bkWZ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnA1bkWZ"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so22025ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750701227; x=1751306027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfbdOGI6POgkEzM2U+zncQi7e79zC2DbeGl/tT1At+s=;
        b=UnA1bkWZs7ux1gGFGMGKyrDN4QC4IGpP5cM/D7FamcDRRbfJ8U5QgtzUH0OUQ83LvL
         3fUL5bbF/J6+RWocPnDf+yVQqy74SjHhC6YUte/j6BJ0uw8Y3tfom4cYEBWCPyCj9V5L
         hSdiasAxgRdVIbfXZ3yoXYMnO8UV4++wbyuWC7Aycy7KHi1OlKiHos6MvjDGT4L4jtew
         1StTDWqLpmsEsfA8ADSl6msqsySADOXdoWVWQ7J7I/yEyDeYXbMiSl99+xtb3I+Xl7ug
         wJVjGMF0pl+AnMgrK48KSpzKozulna0fVxcCMJGYnR8wCmol5ZsQAD6aQAiVms/et9I7
         gTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701227; x=1751306027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfbdOGI6POgkEzM2U+zncQi7e79zC2DbeGl/tT1At+s=;
        b=vXJ9yyOW4yB9JvmM/yhW7NZUgUlcInMMFjVk7xPZDcSAVTpBHVziCfYEKDIeX/o6p8
         6VfQhtCLWvbHFn51BGpO4f0LoK2NyXZAZWvsU0yg8xd/lHkpLEWqtvyRmdj2jrvbJtjs
         3RzaMMgTUq1QhXuz0JIMCpFgORf3sIYBsqZD5Kte4S8+b/fYMHAHE/W2/ynweclgrsgW
         mNJ0n5jvojudGsXloGL+Ng2s+hPh8raMADGy/p0hhI3qWvXvHGHtlthd1a0q080n4bUr
         QprLIazptLEVoLDozJ3C93pXu+BOKUkWslTHH7zCdnX51c7nUH7CRcnLKh/LJqUl2ULR
         Ghaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfaW40MHayuV/pWAUsNaEuyYui5+2ph/lrmUHhElmkPhq8/k2AmbORcto//YVbac5q68t0vYYJEuc42nzW9/LZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwKc1PgXNey+Gph1Pi/j2XbRy4WoOrBnWUurFJT/YEQuJ82xJsR
	xyiWKo23tyNxPjotsPV/LODKyFVoMJu3ZP4zlQ+g4CUybOn1X5d8zUHHQjEiJL7eprbnVf7DCxw
	Cv5OcjD7WnK6E3Or+PhtzqPJdvFZMkryS7S9+jS7P
X-Gm-Gg: ASbGncu1VQxYCaKPO5ZwGp1In0dyfXQrISHce3/zhKxU1dO/RHWTEFeBdXDhE87Du1E
	Hs1WnwEPz9R5hLeT+qMkuPX3UmzmnSKTQvDeA+bl+hOnagQ39MVX6iicq20K/nAPEDu6U6hWY6L
	ovh62kll9pmQ+Eylg2DiD6NXSMeVaxdclpTyf4dck2I6pz97HsixRXg1yz3+aM6vWl2TjOJtST
X-Google-Smtp-Source: AGHT+IG9Kq5uHE16PKPlpcy4O1JeDUSo9YlkwbbeoAcnIyRyfQbVBGQVhbRkTfyQSGrCunqluTUKIJxkTfad+mvP74E=
X-Received: by 2002:a05:6e02:3a04:b0:3dd:d664:7e0d with SMTP id
 e9e14a558f8ab-3df0da3ce15mr5927995ab.25.1750701226425; Mon, 23 Jun 2025
 10:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
In-Reply-To: <20250623132731.899525-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 10:53:34 -0700
X-Gm-Features: AX0GCFsCdOV-pfO9KZoCtwTrRPoKjKDvuzlbIOliBOG07bc30kwRiDQ7Fy8yOHc
Message-ID: <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
Subject: Re: [PATCH] perf list: Add IBM z17 event descriptions
To: Thomas Richter <tmricht@linux.ibm.com>, sumanthk@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:35=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Update IBM z17 counter description using document SA23-2260-08:
> "The Load-Program-Parameter and the CPU-Measurement Facilities"
> released in May 2025 to include counter definitions for IBM z17
> counter sets:
> * Basic counter set
> * Problem/user counter set
> * Crypto counter set.
>
> Use document SA23-2261-09:
> "The CPU-Measurement Facility Extended Counters Definition
>  for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15, z16 and z17"
> released on April 2025 to include counter definitions for IBM z17
> * Extended counter set
> * MT-Diagnostic counter set.
>
> Use document SA22-7832-14:
> "z/Architecture Principles of Operation."
> released in April 2025 to include counter definitions for IBM z17
> * PAI-Crypto counter set
> * PAI-Extention counter set.
>
> Use document
> "CPU MF Formulas and Updates April 2025"
> released in April 2025 to include metric calculations.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

[snip]

> +       {
> +               "Unit": "CPU-M-CF",
> +               "EventCode": "143",
> +               "EventName": "L1C_TLB2_MISSES",
> +               "BriefDescription": "L1C TLB2 Misses",
> +               "PublicDescription": "Increments by one for any cycle whe=
re a Level-1 cache or Level-2 TLB miss is in progress."
> +       },

[snip]

> +  {
> +    "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
> +    "MetricName": "finite_cpi",
> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_=
MISSES) else 0"
> +  },
> +  {
> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
> +    "MetricName": "est_cpi",
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(INSTRUCTIONS) else 0"
> +  },
> +  {
> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> +    "MetricName": "scpl1m",
> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) i=
f has_event(L1C_TLB2_MISSES) else 0"
> +  },

Just a quick check. If the PMU CPU-M-CF is always present then the
"has_event(L1C_TLB2_MISSES)" check will always be true as the event is
in json and not in sysfs. I'm guessing this is being done for the
benefit of hypervisors.

> +  {
> +    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
> +    "MetricName": "tlb_percent",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100 if has_event(=
CPU_CYCLES) else 0"
> +  },
> +  {
> +    "BriefDescription": "Estimated Cycles per TLB Miss",
> +    "MetricName": "tlb_miss",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) =
if has_event(DTLB2_MISSES) else 0"
> +  }

Similar here but with different events.

Thanks,
Ian
