Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9D3AE6F2
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040517; cv=pass; b=WTOctBuoJ0Q5rk6AOJb0bkuXU/u0AfWETW0NDRSUX+qFYbtGsGw+bEA66qh4KKQ/t3lRHxJp3rrOUOc/GdE6dbDAOsYVtv1n1ASmJo04OuKx/dmPJOdG1pnqcV+d/LNDrZO1Zkio0G6Yls4y0YXDyjzatykExDxG30/04veEsgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040517; c=relaxed/simple;
	bh=gNeUwRtEzJfDK8EVv2Zte2RaBIb8ANwFbdUm4BzTTlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh2sM4LWWE7CNDG/Jq56hMsxrBYleFwyQmoPnumema/GNBGC9HifGLj85oSlQuORcSLpxUn61tYBDYdBwM18GNtxzZbjc6z2iCUDEZmmYZiBym1pZHIXpSQ7BzZgIKlA/n1SXbT06cPvRs1lar8cI5KydoDhBWv11TueJzVzDnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWipjPeR; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWipjPeR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ada9e4ea32so106915ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 09:28:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772040515; cv=none;
        d=google.com; s=arc-20240605;
        b=Us6hD51NAAawr2v0w0lx7H7K7d6LUcNOfZMwJ54pdiAZtVRS2i0+v59P7bJ7BbsviX
         jBu+YAY1Yo3etQOL807yDE3qAF46bxTZASmI7Z+QQvoDmGoiXOZFqGq5aaPcf27O1C6l
         kUdflRVj5UR5pZvr1yGxSifJIesGiliibEzP+TJDks/uR8cNd6cZVTVC/fHJgewLlIl5
         aS3/hmre6B9CStrTGld8hmq/I+w0+Pg7U8CirpDxXfwxRucvr3XIxAT+fajoThyNY2V1
         85ArhOu7I4ZUgAmHdyssvdkw6AwwftldR77FOJiK0wNyUPpG3Iikke4oEFER55z6PGDu
         UcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJKejkddOi51Bi/7KdJgkXFKRZwkA+rI/IVTLltiqqs=;
        fh=t0NW+Imv742zALi7oMjO2uxqtEB3P2hCTp0x6p04TPU=;
        b=J9QHZa2PEPF7n/kDrzifPik0KCpeG9qsLd/NCZQBnsqavsBNgQsQR7aGvmdmWtvqdY
         iye4HvGOExSUm2in7sjkDzDN5jazRU0aEJ0EzZq36scfgNuNLYbdvkj8ROWje24Ejx08
         F812qUSKBeNN1wBH/890qimWpixgBziu2HJGnD7Hw67Gij3tCIofjMptwCz9ktFOuFSC
         aB3qhcTP7jydl25HSgD6Dc5lMng2tj83ORK4sISzyZjMmdhew8aYIUEL0ukKxcogU14A
         K5mdT6ZoD8jW4/Xa9HrfIQoUZQsaB0H1obRRi+UNV73y19hKtCHeR4KDHfW3Wf+slB9y
         Z9xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772040515; x=1772645315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJKejkddOi51Bi/7KdJgkXFKRZwkA+rI/IVTLltiqqs=;
        b=tWipjPeR76xW1IiHTPPGgEz/6ITsU5EutMFCG5q/9S+0A+XzE4g0EW8otkAoz75tOp
         s/hHCUHOW/maSG5M2yZSiTAcbnJWoHyHeNn9y3Z1t22z0A2F3jov3H2TqliqwPyg9c3o
         2LpUbVMctEq0ITVU/vBcWhnmXxJ8SPWLoaJUpztFE5rnD92zgK7cKuTACwp1DN/EDNxm
         DdjVWHtTbb5EV1GGZqx/KJzj0ik/KtxgTtkik3JpkDUH6HqLnHM6fsOGbqLG9MBq/P0V
         CFn6/664RGPq+TamA4kI7Ub1M948mPuiFJwn+1VHEeFCrcAt2ef7BI/28mIIzL9ECkpI
         42QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040515; x=1772645315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJKejkddOi51Bi/7KdJgkXFKRZwkA+rI/IVTLltiqqs=;
        b=iCrGduGdMw6TjrwUowRQMzahv5d0Q3beqZF69eX1e8+Vtw5bxlkSX5EyBGNNnCkkib
         KfuKny7h0q3XITDK82i0HpPdUZQ63vWUCRTO9FbQP4Fz8oCBP96fNjgtQxtTavcgZ/vl
         TC0G1qhCQPJnXj0BEPko4FSLhyAONlV5j4wDc9dJtMH16WS1Ha9gnJRneX/VfED4gktA
         ry3NoB7StNAmXec7kdqB7VYA/oYobEVnZ67zlab2CkNy3NTq37enSVUBHhhN+iywhiQF
         YiTtjcdlH20Ilf4PFCTjq78HByxab5Jdu52QGgP80Vq6lRaegzLNCGKS9K4tfTvhvS5E
         ObDg==
X-Gm-Message-State: AOJu0YwQOpntJJM+I7Xmz1OY1OEb2FlDGgN1oZ1cMoWGmq+O6ENjiIZi
	h+zWWIRDRU3GZND1NedPeS7mz0ecnH4qQPzSwQ7gYoOvUCtTNGx/znO3rbdlczAlcy/aFj+4/1c
	GuXR7UdjrSHl8vgzwh2J479Z+MYQAfJ3krjGbu2O1
X-Gm-Gg: ATEYQzxIx0Gi0ZI78FGA3BnNG3uIACdxFf/+3UHH6kSQ/SDZQqSay7ZqbYzg20ZQvyR
	uWLFYP/Ejgw6jEvASIHKZmhX2xstt4MW5Eo2360KIYj6XDx3e+9I3mbj+FDkmNZN/cWbQyYPhLp
	ScPwjRbJUeaNYT+CjMzDEHkF5NSiovMtK5M85eKEKJIZsGAQG96CtGiiiGVnE3O1WQ9KvfFoYsy
	0kCLxUeWH7xX2Jgy8O0fgKlTeCoTL927+4chxg4Xq9EvyzmwrLE5Npeb4kmWkrUN6qG5C2OTFbf
	mXl1klNYRAQUB7T3bfBES1gk/PrE1prN/Aw6Pw==
X-Received: by 2002:a17:902:f790:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2add1365131mr1968215ad.15.1772040514715; Wed, 25 Feb 2026
 09:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218014056.3454977-1-andi@firstfloor.org>
In-Reply-To: <20260218014056.3454977-1-andi@firstfloor.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Feb 2026 09:28:23 -0800
X-Gm-Features: AaiRm50jGLi2lJB0s9jVUemTIBP73ah3mB18F9OOVz5Xz_iqGkFUDQs93g8Leo0
Message-ID: <CAP-5=fWUr2QC0RRhjp11Cdci_QY3yHSfFU6=6OPgSEUFf_p-NA@mail.gmail.com>
Subject: Re: [PATCH] perf, script: Fix brcntr output with --xed
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 5:48=E2=80=AFPM Andi Kleen <andi@firstfloor.org> wr=
ote:
>
> brcntr in perf script brstack insn currently outputs
>
> $ perf record -j any,counter ...
> $ perf script -F +brcntr,+brstackinsn
> ...
>             BC1s 3450809 5665912.127194:     100127
> cpu_core/cycles/:      7f0475d6cc89 handle_intel.constprop.0+0x2b
> (/usr/lib64/ld-linux-
> x86-64.so.2)
>         intel_check_word.constprop.0+224:
>         00007f0475d6ca7e        insn: 00 4b db                  br_cntr: =
# PRED 21 cycles [21]
> ...
>
> This has two issues:
> - The description says no event is a single dash, but that is not what is=
 printed.
> - The b in brcntr is ambigious with the hex numbers in insns, which
>   breaks with --xed. It parses the b as another instruction byte and
> merges the instruction with a missing b and no space:
>
> $ perf script -F +brstackinsn,+brcntr --xed
> ...
>         00005618c6d683b5                        jnz 0x5618c6d683bdr_cntr:=
       # PRED 5 cycles [1396] 8.60 IPC
>
> This patches fixes these two problems. It moves the brcntr output into
> the "#" comment which also looks nicer and also fixes the no event case.
>
> $ perf script -F +brstackinsn,+brcntr --xed
> ...
>         00005618c6d6624f                        jnz 0x5618c6d65fb7 # br_c=
ntr: -  MISPRED 1 cycles [1398] 3.00 IPC
>
> Since the old broken format has shipped for a few releases there is a
> risk of breaking some existing parser, but since this is a obscure
> feature I hope they're not too common and can adapt.
>
> Signed-off-by: Andi Kleen <andi@firstfloor.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks.
Ian

> ---
>  tools/perf/builtin-script.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 62e43d3c5ad7..ac361aa51094 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1264,11 +1264,11 @@ static int ip__fprintf_jump(uint64_t ip, struct b=
ranch_entry *en,
>
>         if (PRINT_FIELD(BRCNTR)) {
>                 struct evsel *pos =3D evsel__leader(evsel);
> -               unsigned int i =3D 0, j, num, mask, width;
> +               unsigned int i =3D 0, j, num, mask, width, numprinted =3D=
 0;
>
>                 perf_env__find_br_cntr_info(evsel__env(evsel), NULL, &wid=
th);
>                 mask =3D (1L << width) - 1;
> -               printed +=3D fprintf(fp, "br_cntr: ");
> +               printed +=3D fprintf(fp, "\t# br_cntr: ");
>                 evlist__for_each_entry_from(evsel->evlist, pos) {
>                         if (!(pos->core.attr.branch_sample_type & PERF_SA=
MPLE_BRANCH_COUNTERS))
>                                 continue;
> @@ -1276,16 +1276,20 @@ static int ip__fprintf_jump(uint64_t ip, struct b=
ranch_entry *en,
>                                 break;
>
>                         num =3D (br_cntr >> (i++ * width)) & mask;
> +                       numprinted +=3D num;
>                         if (!verbose) {
>                                 for (j =3D 0; j < num; j++)
>                                         printed +=3D fprintf(fp, "%s", po=
s->abbr_name);
>                         } else
>                                 printed +=3D fprintf(fp, "%s %d ", pos->n=
ame, num);
>                 }
> -               printed +=3D fprintf(fp, "\t");
> +               if (numprinted =3D=3D 0 && !verbose)
> +                       fprintf(fp, "-");
> +               printed +=3D fprintf(fp, " ");
>         }
>
> -       printed +=3D fprintf(fp, "#%s%s%s%s",
> +       printed +=3D fprintf(fp, "%s%s%s%s%s",
> +                             !PRINT_FIELD(BRCNTR) ? "#" : "",
>                               en->flags.predicted ? " PRED" : "",
>                               en->flags.mispred ? " MISPRED" : "",
>                               en->flags.in_tx ? " INTX" : "",
> --
> 2.52.0
>
>
