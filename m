Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D22DEA95
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804216; cv=none; b=oiCFDM2ulmzr4Ok1tc2cRL+DQVdEzlnwECSKx0WPOw6vghbmeJcc9fLh4PNYodEfS5aUQMjtpv8cBXrdS9fCmvrpdzk6M44TYr/SDyHnzIjekJvO8nJjdZkE0jU1p6zyJdqj+8tJrIjeo/rKxOOVMKzliftsX22borBmbXeErTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804216; c=relaxed/simple;
	bh=q8eptC0mCpyZovfrvq+flR463WYjWc5ia1oqoR7e5IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QekTYMqoeeLyDXjjgBIuA7CuC2OE/CT8OaVaPs7ubv66/HW8jzCPTKkFJ+J0NQXaIFTLvCGUCG7d+3UMcpkOZrXV86WOWd32izcNucS7gsb+lmPxTolUoydkHn4Hc0V6OsfWGj1Svm4RU4jr1Yf/X5GI00hwv9ptlCACovz0Cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwDnDeH7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwDnDeH7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980343d9d1so31245ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 15:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764804213; x=1765409013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrYViI4DBwoYEnMM9nApvH/kNxvNE4iyiVXipxlPnkg=;
        b=WwDnDeH7hozs7vg2QWkRz7yCJm2igZLr+ycqroCRE2sVjt2LZAPnhuiW6a4jtgLKrn
         MZyomFaqB/lHSVhs70dhJ4fbSGN11vpbL5/FICTAfdinoPALPuB9LZWThEENzbQSgFpG
         hghllBmP7ay0iDddXRy0Hq7RChFkrTg0mEqKLHZC39zrVXPuyniSMZ7WeqGDzdCTbOr+
         1dCqiV+3/CBSjtNR90Q4MO9XcF462glZVTdKy3FvwIV4lLEMIXcfgdzsj2DoltcJNSyI
         hQ7j47pi6VvYT/36dnAVglNgYcQjhAuhg5CtmSPy02/EmnM15WvTKFBG/FWa68T806aH
         XkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764804213; x=1765409013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrYViI4DBwoYEnMM9nApvH/kNxvNE4iyiVXipxlPnkg=;
        b=LMR7O8DHOuy4dFoNFRc/U7+lisPN8DZTLRXruMh27rsunXapkaSIh+zWSaqKm4cZjz
         xLbQVJiLyGsETOfxvJpnNh15NPyt5nfwU1np+UMA0AodB+Y/yFVu/YdbkXNZfhkQOH0R
         HfDzTUJW9L7lx/0scNXcbRqBr8Pgk7lvrr6Vs6NQNrYOD30Mh+nJjUaFSk8QTVDHdc0k
         w23pB8aLKEdyiRaW6exsZQdMRzMgSg5p4uHH765jMFTrhCQv8IDl3QnU+MkYnBUpoSid
         l6TjMqRJvM0xPnqy6reCSAJ6JuuI8DV2tIrJGDXjsYUlurUqNPN4VNA2afWrnxa82bG+
         siGA==
X-Forwarded-Encrypted: i=1; AJvYcCXsWYqRA/qjpG2q+7/nOH+IdYaWLC2RyfIRcDJ3cJQv1FELFdHRMW3bJbJE5ZQy9MS4Hg//WPMmSaF67FuEcLds@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrWbVJz5rU0FZa9r2SqkL9NMWnpCXF96YYDr5I3xTcIwoXdsE
	xdLJqFSJ8X5N9C6haaVMxV48bFpLA7jOtawYEeiJULPv8/fOnwjfemPi5pFVtxicsBQtiGRGTGJ
	Z13aXV5x0LWmiwZfa65+vpaizKTAvEvybYXFUDCsi
X-Gm-Gg: ASbGncv8jaXZ3w/UdG60tpngNgYc/AyCyUJjAeEk4/xq06AOC3aoGGOTLukjMIbEi0y
	8S/qdYGpoFtZ7r4LcuCzneofvJEWfGnkwnoSO3np/mShcpRTO1QLcj6cSeZb/Q6rkAAX3IgWkLK
	kNT3OMYxz/kJSM035Nu+fi/bnkUY0tSZiUmcw/GNyRCNHwOkL77iXOif8nz0apBRehOwlgEojs9
	x1TYuw9GMNhPTb/nfp27toWeboPyuPQK9qArQM7opaYuH3PzBXx0D8A3zq9AcuACx03jDenrS0M
	CNN9NXo=
X-Google-Smtp-Source: AGHT+IG9Wd2D1kPF1sTVAXAqGPf5txVuLSYAj5AJILvijdfQ8TfOE3KxoifgQkRZtgRWELJVr+EnXRxGsHD8wXJMgA4=
X-Received: by 2002:a17:903:1c2:b0:295:5138:10f2 with SMTP id
 d9443c01a7336-29dacbe82c0mr432295ad.11.1764804212745; Wed, 03 Dec 2025
 15:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202180155.11147-1-manuel.hernandez@openchip.com>
In-Reply-To: <20251202180155.11147-1-manuel.hernandez@openchip.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 15:23:21 -0800
X-Gm-Features: AWmQ_bkJqkJE8sEUhOIXGcm78bzoB0-GB-t5zaEs-jdViAnz2TM2nfDC7as3_i4
Message-ID: <CAP-5=fWmyyp2HTwOtbcJbSR1OO3qCh+sqdua=QmwNa04k8sS6w@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events riscv: Add CVA6 JSON file
To: =?UTF-8?Q?Manuel_Hern=C3=A1ndez_=7C_OPENCHIP?= <manuel.hernandez@openchip.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Samuel Holland <samuel.holland@sifive.com>, Eric Lin <eric.lin@sifive.com>, 
	Inochi Amaoto <inochiama@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 10:04=E2=80=AFAM Manuel Hern=C3=A1ndez | OPENCHIP
<manuel.hernandez@openchip.com> wrote:
>
> From: Manuel Hern=C3=A1ndez M=C3=A9ndez <manuel.hernandez@openchip.com>
>
> This patch add the CVA6 JSON file.
>
> Signed-off-by: Manuel Hern=C3=A1ndez M=C3=A9ndez <manuel.hernandez@opench=
ip.com>
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
>  .../arch/riscv/openhwgroup/cva6/firmware.json | 68 +++++++++++++++++++
>  .../riscv/openhwgroup/cva6/instructions.json  | 42 ++++++++++++
>  .../arch/riscv/openhwgroup/cva6/memory.json   | 52 ++++++++++++++
>  .../riscv/openhwgroup/cva6/microarch.json     | 22 ++++++
>  5 files changed, 185 insertions(+)
>  create mode 100755 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/fir=
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
> new file mode 100755
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
> index 000000000000..3652970cde8b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json
> @@ -0,0 +1,42 @@
> +[
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
> +    "EventName": "BRANCH_INSTRUCTIONS",
> +    "EventCode": "0x9",
> +    "BriefDescription": "number of branch instructions encountered"
> +  },
> +  {
> +    "EventName": "CALL",
> +    "EventCode": "0xC",
> +    "BriefDescription": "number of call instructions"
> +  },
> +  {
> +    "EventName": "RETURN",
> +    "EventCode": "0xD",
> +    "BriefDescription": "number of return instructions"
> +  },
> +  {
> +    "EventName": "INSTRUCTION_FETCH_EMPTY",
> +    "EventCode": "0xF",
> +    "BriefDescription": "number of invalid instructions in IF"
> +  },
> +  {
> +    "EventName": "INTEGER_INSTRUCTIONS",
> +    "EventCode": "0x14",
> +    "BriefDescription": "number of integer instructions"
> +  },

Is this retired instructions or does it also include speculative
instructions? Perhaps you could add a little more detail to the
descriptions.

Thanks,
Ian

> +  {
> +    "EventName": "FLOATING_POINT_INSTRUCTIONS",
> +    "EventCode": "0x15",
> +    "BriefDescription": "number of floating point instructions"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.jso=
n b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> new file mode 100644
> index 000000000000..4509ecfc7bc0
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
> @@ -0,0 +1,52 @@
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
> +    "EventName": "LOAD_ACCESSES",
> +    "EventCode": "0x5",
> +    "BriefDescription": "number of data memory loads"
> +  },
> +  {
> +    "EventName": "STORE_ACCESSES",
> +    "EventCode": "0x6",
> +    "BriefDescription": "number of data memory stores"
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
> index 000000000000..58fe0d04133e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
> @@ -0,0 +1,22 @@
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
> +    "EventName": "PIPELINE_STALL",
> +    "EventCode": "0x16",
> +    "BriefDescription": "number of cycles the pipeline is stalled during=
 read operands"
> +  }
> +]
> --
> 2.34.1
>
