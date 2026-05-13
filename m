Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99CE56A
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632243; cv=pass; b=HmTlEjKEdZMdzWIAKIO+ADTw82SzWZq0O10i0sBWzcjxVzPHBL+ITEVbrwv9IS7HJXMf7svhyqUDc6G8ESOLeGzi9ImrrnKOwVpBEG3OXT6vLcIx2pKZQJJdJi/f3XQhOjPbmMWNrczh4qChHeXcge4a0appeN/+2HrKIr1na8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632243; c=relaxed/simple;
	bh=fKBPR49KEmZR/8JG+ViYCQO0cKS15mU85eUgS9dres8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLjLDQk/KR/8su3IvD6ZpM37CSl7VKxqgR+kZvnz2kTAIpHR1LKKnp7cn+c+jJWXqDJrZVzKaXX/JZ78oaBlSCygUUFl/qRg1vQD4ud8rVvUibgEos9JlFFclqyfimdUCqSNn9xkTU3pSxkXB3q878+QIDN0py9Y9P3dDWAoW0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eglousrI; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eglousrI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso175ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778632241; cv=none;
        d=google.com; s=arc-20240605;
        b=SChccRwa2zczMgfgteSr0JGExrowN7mff4OJcTd9XX55lKSqIyd2Rj3+be1C0J2h/A
         2GUM8PEC+gQVhKsuO0AHFwRj3s0hlBBmu6fL3VYJrMjmaK3/Zfz1/eAEDP1x6D38dWK1
         XTHyvOhkngBs3mLr9U0USExdar+nuCY+nrYMfMpBmSU/fZgGuVbBIgOsY5Ty1D16ADhs
         lDE8YeaDJlxAl3oraXhLatLjk6Ng8NB4MJAMbBKtYx/bvUgiqWH3WVOFLWcS5fxpE8YQ
         0g+3W+A3kUbBnzzdhdviGEXoA6lHaiPRejyQM/s1KA3S8TSBebh4rg5BlRPe8xkUd47x
         YaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uqLyfLShjIQvL/sKmdg8oOU4CXoLDFqqTc7l/SYnxuc=;
        fh=UI2auG9r+/oDiP/itu4nnON64oBW/f/mlP188OjIH3A=;
        b=OrcDdAI5KeoCS27rgvwolsboDMaAHDEY/wbAP8vD4spOwSNC0rks7TDu1yJ61h6CKI
         KSyAAJ21bcHXBkcQJC3d3Jt2fiPxGfuJeQ4ua5pmMopLNgqmBAI72fJRQJCgOg51o5XT
         ayvha2cYzI3Ta7alEasJEwdNH0qMB1CF5Eu7cTRl7wUpG7NfvJ0zpaHIZeG412CmLEZl
         ogXV2epq9mkPSAb9Blux7nHnFCKcc6L7jT0a3B9brA6GE1b5RROQ3iqlnq55BRklhENj
         pvF220sVF/bJvZzQqvP1w6wcNU6fw7xNfbu8ae0ewzxzWARUl5dUpEGWySNtR4Giyprm
         xa2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778632241; x=1779237041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqLyfLShjIQvL/sKmdg8oOU4CXoLDFqqTc7l/SYnxuc=;
        b=eglousrIv+jjpKuCKdNYU+uSQARxtMpLNOHqcZND1jTAI7wKd/06nxtNp5uwUd84ni
         u8O1NYiW9SnufGqBjRXBnFP7wfIFszO3JMFdSG46PALgjB1sEEr2LwCGpYRH8S16CHKb
         xK99QwuYUluxOZy8wMCscB4E1X9tz6xwu8/JCWlXWn+B/4srotD3vgUu9wzEQ+Qbowoa
         Z3J+ZVKq1OLinQWh6VjtSqe6QsJV+xAc8G3WLasNqVihCKeXpI4xuxgUFXbhZkk5FvoW
         EblE8mSZuu2ii/Bk4NkSmhkr9FguwlNSJPRW5j99J2LturkVV0hjPH0w7VxSyqFUCE2/
         h+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778632241; x=1779237041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqLyfLShjIQvL/sKmdg8oOU4CXoLDFqqTc7l/SYnxuc=;
        b=YzEHSz7YqxVWauHK4Z7L88OaQ5NAIYL0PKVX7aiBh+dMqyKsX75LWnjLmD5bm6sx1J
         NwNeFHVLsKAq9qFIJSsv50JuolZ1R1RHaoKqn8928r9CUsulH3Z4RjEUuw5KO60C3ZOI
         TjTftRev6tdUXgftGL0USyHAwhwGalspUWMnm/iEsWumOEofrGA9KRq4ok1F2Aala/+G
         9RNcT5nWUbsffAwpmecIJrE+ed7geNMaZCgJhqIRiPpkhkk3skURM56mRl+cR6cwstKH
         3rv+zGsgw7N73UY0Jdw3+Hx0tIx9pstfYGOTMhtWk0s1LsuhIuKWy9iovNhqkUAMhVXl
         xvhw==
X-Forwarded-Encrypted: i=1; AFNElJ9xZWpChFxZhHzO+GCJFODlC+j0BIrKy5+Ph+uLLyNDrLHhftrFsQxSfCLbg29+LEaub2fF5tSIUxh06HahT6NS@vger.kernel.org
X-Gm-Message-State: AOJu0YyO55YJC5kEgdUBumeEGiMU0eSV8wv5YWjtY8sLDccDCxlD+zzb
	UDG/8VoG+lRPofyop8DrJ1m4UtdndMEr27AOaCVwNY6J4Ar5c57DWyzu7AmN6vCyPDfRhV/PXSw
	uysCxI9Im5pfCAewcTQEB5DtgYnMkwdu5F+zRkgHK
X-Gm-Gg: Acq92OEb5heHQJghf+nBgHZCc2XzyOwFRkoW9HSijGAhIgVnjK2Ikv73/Hpgi/74J1r
	dc2xf56XSSvPzx0MOeg1fiuHHgHh96pbwmIVgXySi06FXVyCSDgekmLlkpL+JinpXt5w4HDMTyG
	4HGkGeH1S6pWta62kVbosEPdg7zH+M0gpiMWfriwxXO0Gbtg26SjCjSkyAOzyxtxYZqF1KOKy+w
	MEX+lAjX1qBmVM3NT8oILbCvyr71yaYkyguTJnFwInvLDz7wDiNBzKEeuv4eTJbJqWvzPUpNwK5
	8GXyZacy16SNnc7ei+A=
X-Received: by 2002:a17:902:d581:b0:2bd:a61:8536 with SMTP id
 d9443c01a7336-2bd26769d89mr1645715ad.6.1778632240685; Tue, 12 May 2026
 17:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512233048.9577-1-zide.chen@intel.com> <20260512233048.9577-4-zide.chen@intel.com>
In-Reply-To: <20260512233048.9577-4-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:30:29 -0700
X-Gm-Features: AVHnY4Ji1h-jKEb9PkDZETPf35km68RQMmpRRVpw1jYwjKAQqd1cJO4M7N9i98U
Message-ID: <CAP-5=fUa_VFBs_fKMTkCuGxZ1cO3JuZvz0iGiJMFVm3fjtHRoQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] perf/x86/intel/uncore: Keep PCI PMUs working when
 MMIO/MSR setup fails
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:39=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> uncore_event_cpu_online() returns -ENOMEM early when both the MSR and
> MMIO box allocations fail.  This also aborts PCI uncore setup, even
> though PCI PMUs are independent of the MSR/MMIO paths.
>
> Remove the early return so PCI uncore setup always runs regardless
> of whether MSR or MMIO box allocation succeeds.
>
> Fixes: 3da04b8a00dd ("perf/x86/intel/uncore: Support MMIO type uncore blo=
cks")
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 012a7e081014..8d5170788af2 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1632,8 +1632,6 @@ static int uncore_event_cpu_online(unsigned int cpu=
)
>         die =3D topology_logical_die_id(cpu);
>         msr_ret =3D uncore_box_ref(uncore_msr_uncores, die, cpu);
>         mmio_ret =3D uncore_box_ref(uncore_mmio_uncores, die, cpu);
> -       if (msr_ret && mmio_ret)
> -               return -ENOMEM;
>
>         /*
>          * Check if there is an online cpu in the package
> --
> 2.54.0
>
