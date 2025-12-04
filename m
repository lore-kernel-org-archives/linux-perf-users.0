Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B527EFEF
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866652; cv=none; b=YsRX96Twl/qBOHZFNNwJkzZTsUP9PMBDbp9tueeaspip/rwa/VX05vdCBI4BzU/JTQNDoKZ+m4B/f8FOJRGSOO1Ma+XYcKKWycESj93FSkoep8E+PS63SfjuOG/C2Cu3XgA7UrvotsmquH45gNuGbK1LP0zaV1N/6QjVQssXspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866652; c=relaxed/simple;
	bh=I28XvMKx5296h2iheKTKDIlReycSGXnXL1TXZyk3NLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R43ZWRoOcGc9EZcqbw2r7B1zjOOyieo7z1ByM///grpy0O7HCOD6IZ5wDgks3KSnQb9aGj4tq8fJLKgYJpwksMzDZKQwZWRLS92C6xOnmH5DeLIx5J2RuV7nAZsqVVfUq1fhKkPKmDI+LGYaR7gnMg+NxbLtGmJi7+qWvRlIWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+Uxsy1Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+Uxsy1Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295c64cb951so254445ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764866644; x=1765471444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM8GkFgzaQVqiFh+0L0yqWT4yDmfZL4wkVkkjBN6EHA=;
        b=n+Uxsy1Q7GiQei6d9H+pSJGshwcL12DZ+OB5WcnIfbd75UDale1Ugw+6duRgp7XHfP
         FGNMNDL0qh98fZM7xXxdCbv45aA0gEqBa8Em72Q4BTwJ+VJk2m2wFqNk++sLh1kg6MPl
         zevwa9A7IcPm4mhawWxiRh01sSmmm+U4ujezBa9yxnaX0zO0iiBJHCsWTuAVeGcMba0Z
         uBCOsjyGL99VhNqNfg3dEiEGoIECylGKZ6f7jChRT2212KZ9rHT9dQ2twAe+ucBJMQ9r
         t+AS4ZPyB51lqzDzeFrNmpKsaAQNC/ZSjuYp5mmw+++DBiUxeaAY6RzzAm7nCq3Fk7PN
         liCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866644; x=1765471444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UM8GkFgzaQVqiFh+0L0yqWT4yDmfZL4wkVkkjBN6EHA=;
        b=vw22ATFG6tsdnMQmiGenZMEL6CwyDnJ9T+nBWtYifI+FYlFldMG71Mbs4qt5dvmY+P
         HpEPFJdjIasC/sB7FH6l69B7/WtfugQzys3kZsvdyadkoISAq9muBF0kpGmSFvy/XMer
         3qSaNzSzl9x3u3cltSt+OXfO4h37Ch/fqlecCUo85ncVUpGqJ9/QAUGeeGESnzjnUiHH
         fLBuyoscajCS64nIECMos3YcyxKl+eD888lbdRFzRgA6htgztrYICR7QIvMX1GyfKDKR
         SqjcVaphuUimO068wziEY4gAv8RME96ZMsVGoWIGH/yBOBVTzLDI8J0hg9lqr9jJdQVS
         URDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrudZdyezvxQ55KcxzlkHTY0tLr0ZxvOqiLGBThw3dQIhRLHILG8qL8Qj5eJxJXx1Y1SX+dyL7bRlQrlFizqeR@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYP5kGn1tyfg+COsW9E8YMwZSYIPiCyGrAxP8vzk9NjS+a6SW
	svHREKk4chwzCGH39bq6hKRJa1ZbGvsbXmclQVrnDHJlqd+NnMKRbHG3fWI+4zFuupLBs4GR9Qo
	Ze1bqChuaRBAA3AkbHNabGwIw7+G9CkACm/7coF1Z
X-Gm-Gg: ASbGnctDAtZtGuUKShzweGSL1ht8pIj6q7ahzhabJ4ztWkaX6rhCOKRWHyeaEyPs1MF
	c90+HGe+k00IfzoCgrvEFGBCCDJhKSl5lurmH5fQKPHeXel75362cLUvgaFyCjse4Pt5tWhQGRg
	jy3loT1H8JIbNvHelEc3VkHZ7MNGQ351YyAPPMY9c0FDnqaWn1MlKepuPx3yDiZfbfmXhI1Of5c
	bFp3hToe0RlCyv/lmk9QLGGSg16qAIKHig0xNn/IN3YiPtg8aJCupSsyfmM/8uxIUATl/7MQ/E5
	q71acXFT62mfAF/sSimyQyw9zQ==
X-Google-Smtp-Source: AGHT+IEQZ/DeQL3nn1owYEn2J2DTkPKjpgeczBEP8SmPfdGq6MUYn/n/D69VnkDhAoY/SN12eJPxfecwonp+PnaeO8o=
X-Received: by 2002:a17:902:ea11:b0:29d:7b9e:6df8 with SMTP id
 d9443c01a7336-29dbd14d7ddmr907325ad.2.1764866643413; Thu, 04 Dec 2025
 08:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWmyyp2HTwOtbcJbSR1OO3qCh+sqdua=QmwNa04k8sS6w@mail.gmail.com>
 <20251204163854.10318-1-manuel.hernandez@openchip.com>
In-Reply-To: <20251204163854.10318-1-manuel.hernandez@openchip.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Dec 2025 08:43:51 -0800
X-Gm-Features: AWmQ_bkFBeznu5CBmvgIgAG6edEn0SixHDibFK-y7s1_AeYqcjwdFjNsF_U-uwA
Message-ID: <CAP-5=fUKnepwqKm+9kk+NQZYe8jsaKZuYgxhVUKGrFMimUE6pA@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events riscv: Add CVA6 JSON file
To: =?UTF-8?Q?Manuel_Hern=C3=A1ndez_=7C_OPENCHIP?= <manuel.hernandez@openchip.com>
Cc: "acme@kernel.org" <acme@kernel.org>, "acme@redhat.com" <acme@redhat.com>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "alex@ghiti.fr" <alex@ghiti.fr>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "eric.lin@sifive.com" <eric.lin@sifive.com>, 
	"inochiama@gmail.com" <inochiama@gmail.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "pjw@kernel.org" <pjw@kernel.org>, 
	"samuel.holland@sifive.com" <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 8:40=E2=80=AFAM Manuel Hern=C3=A1ndez | OPENCHIP
<manuel.hernandez@openchip.com> wrote:
>
> From: Manuel Hern=C3=A1ndez M=C3=A9ndez <manuel.hernandez@openchip.com>
>
> This patch add the CVA6 JSON file.
>
> Signed-off-by: Manuel Hern=C3=A1ndez M=C3=A9ndez <manuel.hernandez@opench=
ip.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Hi Ian, thanks for the review.
>
> This is the second version of the patch, following a review of the
> CVA6 core PMU implementation.
>
> Thanks!
> Manuel
> ---
> Changes in v2:
> - Added a clarification about retired instructions in name and
>   description fields
> - Moved and renamed LOAD_ACCESSES and STORE_ACCESSES events from
>   memory.json to instructions.json
> - Moved INSTRUCTION_FETCH_EMPTY event from instructions.json to
>   microarch.json
> - Changed mode from 755 to 644 in firmware.json file
>
> v1:
> https://lore.kernel.org/all/20251202180155.11147-1-manuel.hernandez@openc=
hip.com/
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
>  .../arch/riscv/openhwgroup/cva6/firmware.json | 68 +++++++++++++++++++
>  .../riscv/openhwgroup/cva6/instructions.json  | 47 +++++++++++++
>  .../arch/riscv/openhwgroup/cva6/memory.json   | 42 ++++++++++++
>  .../riscv/openhwgroup/cva6/microarch.json     | 27 ++++++++
>  5 files changed, 185 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/fir=
mware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/ins=
tructions.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/mem=
ory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/mic=
roarch.json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> index d5eea7f9aa9a..87cfb0e0849f 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -21,5 +21,6 @@
>  0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
>  0x5b7-0x0-0x0,v1,thead/c900-legacy,core
>  0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
> +0x602-0x3-0x0,v1,openhwgroup/cva6,core
>  0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
>  0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.j=
son b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json
> new file mode 100644
> index 000000000000..7149caec4f80
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json
> @@ -0,0 +1,68 @@
> +[
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ILLEGAL_INSN"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SET_TIMER"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructio=
ns.json b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.js=
on
> new file mode 100644
> index 000000000000..c38f6c97cf1f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json
> @@ -0,0 +1,47 @@
> +[
> +  {
> +    "EventName": "LOAD_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0x5",
> +    "BriefDescription": "number of data memory load instructions retired=
"
> +  },
> +  {
> +    "EventName": "STORE_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0x6",
> +    "BriefDescription": "number of data memory store instructions retire=
d"
> +  },
> +  {
> +    "EventName": "EXCEPTIONS",
> +    "EventCode": "0x7",
> +    "BriefDescription": "valid exceptions encountered"
> +  },
> +  {
> +    "EventName": "EXCEPTION_HANDLER_RETURNS",
> +    "EventCode": "0x8",
> +    "BriefDescription": "return from an exception"
> +  },
> +  {
> +    "EventName": "BRANCH_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0x9",
> +    "BriefDescription": "number of branch instructions encountered retir=
ed"
> +  },
> +  {
> +    "EventName": "CALL_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0xC",
> +    "BriefDescription": "number of call instructions retired"
> +  },
> +  {
> +    "EventName": "RETURN_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0xD",
> +    "BriefDescription": "number of return instructions retired"
> +  },
> +  {
> +    "EventName": "INTEGER_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0x14",
> +    "BriefDescription": "number of integer instructions retired"
> +  },
> +  {
> +    "EventName": "FLOATING_POINT_INSTRUCTIONS_RETIRED",
> +    "EventCode": "0x15",
> +    "BriefDescription": "number of floating point instructions retired"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.jso=
n b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> new file mode 100644
> index 000000000000..c4f376a0ee4e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> @@ -0,0 +1,42 @@
> +[
> +  {
> +    "EventName": "L1_I_CACHE_MISSES",
> +    "EventCode": "0x1",
> +    "BriefDescription": "number of misses in L1 I-Cache"
> +  },
> +  {
> +    "EventName": "L1_D_CACHE_MISSES",
> +    "EventCode": "0x2",
> +    "BriefDescription": "number of misses in L1 D-Cache"
> +  },
> +  {
> +    "EventName": "ITLB_MISSES",
> +    "EventCode": "0x3",
> +    "BriefDescription": "number of misses in ITLB"
> +  },
> +  {
> +    "EventName": "DTLB_MISSES",
> +    "EventCode": "0x4",
> +    "BriefDescription": "number of misses in DTLB"
> +  },
> +  {
> +    "EventName": "L1_I_CACHE_ACCESSES",
> +    "EventCode": "0x10",
> +    "BriefDescription": "number of accesses to instruction cache"
> +  },
> +  {
> +    "EventName": "L1_D_CACHE_ACCESSES",
> +    "EventCode": "0x11",
> +    "BriefDescription": "number of accesses to data cache"
> +  },
> +  {
> +    "EventName": "L1_CACHE_LINE_EVICTION",
> +    "EventCode": "0x12",
> +    "BriefDescription": "number of data cache line eviction"
> +  },
> +  {
> +    "EventName": "ITLB_FLUSH",
> +    "EventCode": "0x13",
> +    "BriefDescription": "number of ITLB flushes"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.=
json b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
> new file mode 100644
> index 000000000000..104e6e8197da
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
> @@ -0,0 +1,27 @@
> +[
> +  {
> +    "EventName": "BRANCH_MISPREDICTS",
> +    "EventCode": "0xA",
> +    "BriefDescription": "number of branch mispredictions"
> +  },
> +  {
> +    "EventName": "BRANCH_EXCEPTIONS",
> +    "EventCode": "0xB",
> +    "BriefDescription": "number of valid branch exceptions"
> +  },
> +  {
> +    "EventName": "MSB_FULL",
> +    "EventCode": "0xE",
> +    "BriefDescription": "scoreboard is full"
> +  },
> +  {
> +    "EventName": "INSTRUCTION_FETCH_EMPTY",
> +    "EventCode": "0xF",
> +    "BriefDescription": "number of invalid instructions in IF stage"
> +  },
> +  {
> +    "EventName": "PIPELINE_STALL",
> +    "EventCode": "0x16",
> +    "BriefDescription": "number of cycles the pipeline is stalled during=
 read operands"
> +  }
> +]
> --
> 2.34.1
>
