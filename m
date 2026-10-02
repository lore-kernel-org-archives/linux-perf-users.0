Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382073FCB37
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978946; cv=pass; b=d87/LMqdoaiWtIxwdcLDulqyHmYz2CavPdAy73XN3xdVlE/bTbzdbOXPuQgosTVEK/OlpFp0G7MBP0/R7Z2plSpLJa2P2QKUSDgg9nq1ClOcNF76tcS9/mlhgU3nnc+eTasuq4wQwWvqhef2Jbb00vjXkPJ5Q0iGVMI8FNP/9q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978946; c=relaxed/simple;
	bh=JZk2UO6J5xgak7V5AnZT7qjdKDdxO4rP82PfDzyfPBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEapadpLFdqH2HEbe3J77Ldy10o2RsMn97U5wAp9ilcKHf2i+ZvwQ9jghiHzyP7VgHJPm4UYz09/axP7njLeV7fgfddKW+kg27xqFdvHacam/s+SG4r/D6VPxfF31DkXCka94JY5DvF+2SjGh8uW28q00isP/JLjPr0BIspCk4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6NBe4vm; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6NBe4vm"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53113d72966so33881cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 15:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790978944; cv=none;
        d=google.com; s=arc-20260327;
        b=T3iqdKKjUf5kxFuMlPBCGRR05kW3Vr1n9qjgVsj3CUS1vocfBm7sIMWs6oXRVtpNq/
         alesDUePm9Q/gC8w+M+rXsS9S9geEXTKplZ3kAiA/BZSOEHiA50Inub52B0kHpjNS5ik
         FR/Ofy8eCitH2abSjy15Ob5DmV1ij8UV+bomK+ACMpMU0g0srTgdCB7BQOh2Pqb0qHHr
         JVKIkbvAD4A/0IwwNHZ2gelhiLW2UWgDgsJOgLfKO2s/7liXYbEusa812OhlQDNENNNK
         sFG5qmTGdUEQLes74UkTN0PSUeEdK1aZQEG08q07rCFi4gnixch527Nae8XBkvGvhgVg
         PcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZaKFiEEtQM47C9SdzRSWhAvUezyZKbHdFdy+4ktG94=;
        fh=JtvjVDD9ZolNvq7s+EtgW362WN1mBj5xdmLK0ag9OKk=;
        b=GyhY0OTQoIu63ofY7gkve5LJsiRFQErzAL5tHyOSoX8zK3r9Oql3GiW0w/78b96tvH
         QH21lnuVW7aySYyq7DNZ7QTeemNTtmtD5Hm0QQjzEKm6AVRQ2VIy7Pg8WpivN3G0Q9c8
         Tt0E6Axq9GivJFjrFPFB5yS9tF252oT+BqGrEA9JvQYu61q0GodBgMGkbgWw/XrmzX7y
         T0Xp/7tHsGXLOuSRBYS57eajYEm78GT1xjwEDywRm4ZKJDzh5ApXzF/yDCcpqviUeSSv
         YNRL5Nyy3/0xSFOSwAVjZ7g9xH1VEFSgXPrIRG1zPzuXs+XvJygYMU1jj+wI+zPgZJSC
         IGqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790978944; x=1791583744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZaKFiEEtQM47C9SdzRSWhAvUezyZKbHdFdy+4ktG94=;
        b=t6NBe4vmfSgFhv/18xa2mPKD8EiHmbbvpvL0YjHIU0qNgMxjw0OZYAvvqqT4Ndfk3w
         CTYgoHSBWz9FpxssN03TJp7ZTIMhaRs6HGFdwwUTwAg7kw//P9svvma2mJJwPM6XU19r
         nsa1FCr9p+yK2RgdTNEFJwe/Zlr8kocMh967nncIt28iM0DK0NbUT/T4XwjtseieA9ie
         2RLUDZ6TjvOG2I32IvilVS/S5IoHrlDH7RqdL5IJo6TOD0FXVzBzDrPfCO9ZZmBQZ5oX
         19r540xNs6MIW5cXQQOUf39tQxfqMXn2h9H1Mlq1i0vzR9qpj3lz0QojhFuQ8d8bd903
         qW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790978944; x=1791583744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZaKFiEEtQM47C9SdzRSWhAvUezyZKbHdFdy+4ktG94=;
        b=JucMlm2LD5AYGo3yveTmFyP3r6v/gjKIPdnNbi+EptLkifcg06kfT9YE1iYfF/KN/3
         SzlwcRNxQF6wDjkMgDHWl+oYxNpC6iupbby7/Qx3AHFdp/cB+oOcKSnUZRMtv15q8Q9b
         lImIKwBbJ4ENIlNJT8jnGg4ksr3hhdSepfwcEM0wYIOg/0RexSW7OYwrXQMk5UkRcWFF
         NjjMOjRe6Z8LE25aQ+61RVI6AaT6NIGYeWhvXzJRXnTTaNrguxzDA5fEmbjXC58jMkct
         ngHnHk/GRvtnf5jiw8QHYh9AEykMQxQQci3FLPw6SacQt3NigD30zGaGoB/vxyMmyRn9
         FRwA==
X-Forwarded-Encrypted: i=1; AKwUvBxXYovlM9bmiFrjlk6ypkM2AtDAITsU2CaadcLU4SZcafXyi8rOI8KPELIcUklzU7m7Mp/LjNC79Jc4d0IrW58V@vger.kernel.org
X-Gm-Message-State: AFuF++lBDyVvZC4EPZAylt/TWGLEtyKCfmdZipiSkvfaRDD8xkmWOrPQ
	u5nC5K+hoToGHArGOntzTnvns+FwZFHwF6jCqWLDPBsZfNgadm2ldjvqH2/hLT5UtiEkHptNPIa
	p41xkpPAt5vkWGldhgPfN/F0T47q+6qEV8uE6LzX7
X-Gm-Gg: AYBFou2vnvIubrQbaI0Wq7msKBN51Xr+MKjangtcqZt+4Nyjt9gFpPD/MfcTIrIjyQQ
	BYpurvZtxOjsE5mobK4WwwsE9cXTmmqPzQADyLW0ts9rUmTDXrKfue2iqsyONdCzpl4zbb0FcF8
	40GIk8wUghpHL/nJnzWkwgk8SKc/Nh2Numw+mn0PvOFBS1zhjHy749H/xDqo+m+ZxCxEjTWPu1G
	zI9DtljaCMstswd2My0aghIfLAuslscDNYfODqzMwL91076wbTo1uMMRn6VcG0gXDXiWH/MRv0c
	jE074xDpGSMNpXZwGopk+xP5bUzFdxy9sccJ9quKo2yDpF49kp5udmM=
X-Received: by 2002:ac8:7fd1:0:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-535143a7ee5mr762901cf.0.1790978943386; Fri, 02 Oct 2026
 15:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com> <20261002-perf-symbol-memory-send-v4-1-0a592bb2539e@uber.com>
In-Reply-To: <20261002-perf-symbol-memory-send-v4-1-0a592bb2539e@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Oct 2026 15:08:51 -0700
X-Gm-Features: AclHuK-nL6R11wMTAIMaK2Je6hNynjwS69wzUDTPehiav7g8rYtdEWMle8VAaj0
Message-ID: <CAP-5=fX97E5w_NZu4WSBkMM=Zf6upS_UjuzOR4hwRPmh0RGB3g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] perf symbols: Fix broken ELF_C_READ_MMAP fallback guard
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 11:46=E2=80=AFAM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
>
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
>
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection=
")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.h | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index d0bac824c79c..46b1649c64fc 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -57,15 +57,7 @@ static inline bool is_livepatch_symbol(const char *str=
)
>         return strstarts(str, KLP_SYM_PREFIX);
>  }
>
> -/*
> - * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
> - * for newer versions we can use mmap to reduce memory usage:
> - */
> -#ifdef ELF_C_READ_MMAP
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
> -#else
> -# define PERF_ELF_C_READ_MMAP ELF_C_READ
> -#endif
> +#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
>
>  #ifdef HAVE_LIBELF_SUPPORT
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>
> --
> Git-157)
>
>
