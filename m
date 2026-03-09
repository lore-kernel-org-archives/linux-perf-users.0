Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CD2D248B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080607; cv=pass; b=n+bhXYeI7TMqzCt7Qj/BTPyqBHTtS+tDO+1ar5tUmaoVvpUM7ibsjNTWP18FOJyns7XPgI7uQgauFY1SgA4UH3Qmd8cMURzb/qOe96eehAxSryNRtj1VlBmXCizGYdkppwnhxEBqVXTTLGlsY3V5QMA4nFzRVXa9CXiuGo8bCGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080607; c=relaxed/simple;
	bh=49MH/dl7Pu+0YfuTu7r73+4s1hcaPvDpvudwlguIM+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgUAdefp2j+qaOcSiuuaeHzOyzdq12dO317KzHMR8KGME6Ev8FP+qe6AbclbkN3CrgCT//2OglRG0n2lLLuvHWBUyLPRHvFW1ctotdK80QLrWpZnrHVFzDF79xhJ9rz0PLXq7oN0uZTdaanRrJJOFkmCw9Kg0FiEa8QFS7fYhvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIETwARL; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIETwARL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae49120e97so20105ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080605; cv=none;
        d=google.com; s=arc-20240605;
        b=bgrL3nseLbbotBsvectqKnW9R89H95YP53rTplXq9h/jHhuxsH1WUzeVx1chAPqNeg
         vcVtlDdi5oxwQw4P+o8n8nS/0oZW59406147fnscE4gaz9db3NNfAIRXrFDfKj5BuP+N
         OXX2tmvaIcWZO8PBYFEp11vfgHc7tvrLf5VoGC2dJZX4zYDmWqqqkLH7+Ovv6LxuNEzN
         MlWWeQ/7tVuyxUDDOTzPvKWQcCqNA9w+0cnZ7D1h637IW/Yo2G/dal9oUnh/+vn7qYss
         CkSoB2k69mEVIvsM7FftVxYt8fNermQVwrPrR/ySD4XfYqmoxBX5Wxu19Uo7y2Vg9NAk
         q6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4gsXgEaUq96wmy6ZcJy/P6D42c4wamtor4UbyR6ZyU=;
        fh=uzvMeuCPxD800fGhhudLk14v0H/OBldpjR5tGNn1EVw=;
        b=ZMsZoeDrQEHHauGnW+nkLPPpx0XTOG5FYJ1aH6v5LNr5rXtp+bDLcuWj502R6KrZ9H
         AkfvUnzfshBI26pIrEFzQBYKFO2KIw2tXnxolDfV8xELqkx8rJlbRu8f20JypLUl5rAi
         cOshcT3YUBb0iKtn/x0kp2qnxVbD3U6+MvXCoSIJAIzhlA0bMp8gCXUcv0BT6y3EcFyS
         +dsTtbMdXK1dreqNceEPxfQZyLxnBQ/QREo0JMKIdIyAXVOLazOf1JzDLKwTLB7mdWcv
         Ve7yKYokVXCTgoThDtiZLtshfUvKtShbkQGidrJCUPYFhXZYrXcNqBc0fDrvWx/SCniD
         H6Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773080605; x=1773685405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4gsXgEaUq96wmy6ZcJy/P6D42c4wamtor4UbyR6ZyU=;
        b=pIETwARLHdo18ScfqYI0v55OhxLUm1CfQrDa0ItK4CbgZr2/hFe7ryQkVy7g5TM/qz
         NjK6SGulJFlr+jU7FCWP+Z7PZozLUc6yIo1n27z0oupxsTl349Bh0ffVehpq+jkxuApb
         twV1d8rJYRccHw9kQ5aPoan4c/41cf4WJsDW7gERCr0pjNoh3iV1v8P0ndzvZQxNmKfC
         TNGJcUO1JZFXMOfzNy/wmnI9R11jIl/b5YHYE4WJVKUwIrbBVlVlL05MK5lhscNhZwWx
         0DEPB19XSvSkr1E2a2OqPJ65nk/vZXXWExjiw/M+ZKGSoB0tO5Du2A1EAeA0zwPDAAT2
         mmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080605; x=1773685405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4gsXgEaUq96wmy6ZcJy/P6D42c4wamtor4UbyR6ZyU=;
        b=mM8XM7SY1qu8ZJWoU+dMSQzviK5zFRbXGXqmPS+zdq2XO19+NAu04EFDsbzzQRypKr
         iEIhpCke/z6GG8MiYFswtoiazWsnFx6K/rVBcohTpbCQFiVcIG+XWVnqZuthMzdhZM3N
         QTmS0N+AL/WT+Oqd3Uo/0eLLnt92Pms29muKEpGNOiM1kmkMDZ8+PEcAVCI87Oc283go
         Fs8+Ehfgwj+/Z/DJ890cd3jLEngaarheQB7wvhaHOFrcQU+VDDH1Ly10WWDHiYARH49z
         ZeoB4nTVHYaQhlyjyuxY6JQFJ3clVeW6SaUd+lYhEvVTOwgKClX2JGHjxjsXZg1fBsVf
         60Pw==
X-Gm-Message-State: AOJu0YxBI09a2rVx/rIfxbcZ3BpPJKl5jevuNJRJ+1Yo0l4FQRB2Y2iP
	oFQxzlwnXLxzwoWHsI2U3glktMiRLAEa1n9gjRkAXF5Kv6BjAhQc5kp+dn1lggrJ3DJHf+ht00K
	3VDShtEOwnAcETw5gcK+ZyKb9HDRnyHrUSL2albbFGaLDu+A+3IH/u6ZwaXmBWA==
X-Gm-Gg: ATEYQzzI43OM+5kNGxGLcy/Ut3EDP6WTtuEOEKD50cUR5eiqRo0kcaBVpiINjNs5QZc
	PKMU5ERzlcKzkV/hZ9ZXiJ78njfz540iOquH05RFr/8sSuKC4u66kTSe7FIEv4GtawuGbgdw9MU
	PADWvVNpkXq/JHKzDfnp7dIGisgy0pGGtkQQ3v4R1FRrBFegdOMp+r4bdfhDx6c+KbzT2S6GWYZ
	spaQ0kJjz3JAsFGqJruYn5tFRIXm5+Rm1vPY4LF8XAjdkBEvyFCe6R0IwDWeCRkuz8al9qV39YH
	iIXneSTprXo/gNrMtyTb9ZVm6YXeFTQV5P4=
X-Received: by 2002:a17:903:98d:b0:2a0:867c:60e2 with SMTP id
 d9443c01a7336-2aea32933ffmr288075ad.19.1773080605052; Mon, 09 Mar 2026
 11:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61a60089-c0a1-47d8-91c7-c1fe68d19f5e@linux.ibm.com>
In-Reply-To: <61a60089-c0a1-47d8-91c7-c1fe68d19f5e@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:23:13 -0700
X-Gm-Features: AaiRm53ELie6Ggl3aR72KXdyQ4GJ-4CXceYxevkzcyF5yyjl6emImvgjd6vKA4U
Message-ID: <CAP-5=fUOizFadGmSnLLPv2m+-a0sR4eg8kqBAMeE5k0wpvQ8ag@mail.gmail.com>
Subject: Re: Test case '105: perf stat tests' fails for s390.
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:04=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Ian,
>
> test case '105: perf stat tests' fails for s390 (linux 7.0.0rc2) . It boi=
ls down to this command
>  # ./perf stat -C 0-31 -a true
>  Error:
>  No supported events found.
>
> The first bad commit is this one:
> commit cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID tabl=
e exists")
>
> Before this commit the output of above command is:
> Output before that commit:
> ./perf stat -C 0-31 -a true
>
>  Performance counter stats for 'system wide':
>
>        105      context-switches   #   3579.8 cs/sec  cs_per_second
>      29.33 msec cpu-clock          #      7.8 CPUs  CPUs_utilized
>         34      cpu-migrations     #   1159.2 migrations/sec  migrations_=
per_second
>         52      page-faults        #   1772.9 faults/sec  page_faults_per=
_second
>  5,026,832      cpu-cycles         #      0.2 GHz  cycles_frequency
>  3,029,266      instructions       #      0.6 instructions  insn_per_cycl=
e
>
> 0.000851608 seconds time elapsed
>
> Since this is executed on an s390 LPAR, hardware event CPU_CYCLES is avai=
lable, so it
> should be used. This is something I will look into.
>
> Also some other test cases fail after the bad commit:
>  ./perf test 2>&1 | grep  FAILED
>  99: perf stat CSV output linter                                     : FA=
ILED!
> 102: perf stat JSON output linter                                    : FA=
ILED!
> 104: perf stat STD output linter                                     : FA=
ILED!
> 105: perf stat tests                                                 : FA=
ILED!
> 133: perftool-testsuite_report                                       : FA=
ILED!
>
> Before the bad commit the output is
>  ./perf test 2>&1 | grep FAILED
> 133: perftool-testsuite_report                                       : FA=
ILED!
>
> Any ideas where to look too narrow down the debuggung are very welcome.

Hi Thomas, sorry for the breakage! I think the issue is a missed
commit in the v7.0 PR, specifically:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/util/metricgroup.c?h=3Dperf-tools-next&id=3Dc5a244bf17c=
af2de22f9e100832b75f72b31d3e6
This has also shown up as breaking stable backports:
https://lore.kernel.org/lkml/072e2a07-5c6f-47b5-9695-0a3ffe854ac8@kernel.or=
g/

Thanks,
Ian



> Thanks a lot.
>
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
