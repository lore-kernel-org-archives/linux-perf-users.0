Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A3215041
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Mar 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021034; cv=none; b=bGUeK0zxChnbhsJxrGgGmNFP7xURCZKyKB1y5itBBIFrG/v5WwINbh5TY6ZcF+PgdjYSrJotMfK5j+7OfDuuxCBoq8qdnfhZS4fWXO0DyxBONaeeYACyxMKGRs6Sdw8rpgjbp5uJPG1FC28m4WZITwHwRdhEZLi4sclnVCf/o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021034; c=relaxed/simple;
	bh=m6fUzgBOSYI+fGh8QMIaAwQeaobQrX0g/0L9iYjGmK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYOcRQPn5Bd2o4azwoOmqsNQcdeHCAOlB4/OLnSIaOPOQD1HljCeHLG7wRAJNWI45e9wnfaEcy/Lz2PHLTROxLPBYMB2ZF6JoFbjA+8FiKjzdi5jjTO8jUmAbKLAyO5Ye37uu3vc7htjouqd/NJwUYILRtrHgm6xMx1FkIDMCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGlXgtgn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGlXgtgn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223a0da61easo224395ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741021032; x=1741625832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qW1Nf8vyw1Q2PuqtIij4cH7ngvXGYVEQckqGs7r7yU=;
        b=ZGlXgtgnwqphkjuZTxqBSSVBA+Op8+lAXRPDVDPuIrEs65Oux/cenNlYSbUFRtfhaZ
         WBpCXyv98vRhNe2IGs/x/h9TpybDEir02T4HTuTnbT+9BADXgiFLXcIHJ1lXKFH3Ydnb
         sHGNsvJaiLa/PlK4RUfj0spJN6qeTbSXtaLXC32K4/OZMw5wrPT1KBHyLNZ3Kugaw0Fw
         EXBfzrKesYLDR+lbl9/orZpaCi9JNSiBdZCD69vDUfOQZ9Np8RbtxDCV86yI+ltoc3Eu
         LXYf+16i38lR8QtOdnIkujJhGjZ9h57hj6jupC9mg5Q9MzueUmpE6Vvkw2CnChgujAlG
         SVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021032; x=1741625832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qW1Nf8vyw1Q2PuqtIij4cH7ngvXGYVEQckqGs7r7yU=;
        b=LT19yadNXbJqZl78mrk3Ipf5/iSyyDWg9V9DrCnAMfpclBSM+lgPOsJMUEjkFn2KNQ
         PKxyXbYihndKp2/YruD0NZfjsJfy3OqXOucftb+IZV/eA1i/AveUezdevy13WbK7+2oW
         lUcF04ZC245yOoM40qR/TjaxhDdjY9X9tjuZnjCOSCo7dJtlFO87wXzfQqDO7A0j2NL9
         K3iskbqfWdVP/uwKu/rG8SNKXrbuFkEipYaLsdgBdle32BzDjpdP4f2c3RD7CT0PMZVZ
         onqd8bRCD8n1YsIuXm9zRMV4XulTExny6l7Uu0hTCwW4oZspkKucW1o87XiokTOW25Jn
         eaEQ==
X-Gm-Message-State: AOJu0YzAXonMOOqcBQpZYN1QlWS90w/oaJX0ao3jOzxYntSMJj+IrREZ
	EH2UHUmvxyI+/lDwyRsuYfpjzc12k4CO0ZF3u3hEfqzkstZIviNJeUveaIJ0wNJnGyRnCaAx7C+
	RqSevD7+FBLnooP1cjwFQDVQKt/wbdKWYjbfE
X-Gm-Gg: ASbGncvOdEJ32EVCm+cAGqtGCH57LPEKSIyHkwbxANKJswZxCPDAF7hgT9xsJ6NwfRu
	B1g7O7a9kH9sgA4jnYfC8yqVbAgiOjmLiiMBMVkKGTm2TpPHQ23CnWx4jqbUiXPbA7/uJhEfTAm
	opWQc+MtwbAai61Tg/fXqzKszdR21APEMWLgq47ZutYrN9pj7yCwk=
X-Google-Smtp-Source: AGHT+IFt/KQhUWp/Hhr2+QiGaV0zuzG7HlI9Hd4D1SNZXjdSOzw9RCONCtYfELcuUjqzUigB4yp++nhlgDa5v3LCVIY=
X-Received: by 2002:a17:903:32c8:b0:216:5e53:d055 with SMTP id
 d9443c01a7336-22385a1a1ffmr3934335ad.9.1741021032216; Mon, 03 Mar 2025
 08:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303092451.1862862-1-skb99@linux.ibm.com>
In-Reply-To: <20250303092451.1862862-1-skb99@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Mar 2025 08:56:59 -0800
X-Gm-Features: AQ5f1Jrb9HWfgPlxW--MQZMpi50Q5zGWsUn-FeWGkwkjPk2WShOPYuioINvUVlQ
Message-ID: <CAP-5=fXKDPBZkXa=uBEQHM2AFYE2mP7_pA6qKAAHyXkk2OCoHA@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: Return EOPNOTSUPP for unsupported
 breakpoint type
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, hbathini@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 1:25=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
> Currently, __reserve_bp_slot() returns -ENOSPC for unsupported
> breakpoint types on the architecture. For example, powerpc
> does not support hardware instruction breakpoints. This causes
> the perf_skip BPF selftest to fail, as neither ENOENT nor
> EOPNOTSUPP is returned by perf_event_open for unsupported
> breakpoint types. As a result, the test that should be skipped
> for this arch is not correctly identified.
>
> To resolve this, hw_breakpoint_event_init() should exit early by
> checking for unsupported breakpoint types using
> hw_breakpoint_slots_cached() and return the appropriate error
> (-EOPNOTSUPP).

Hi Saket,

This looks good to me! Did you happen to run "perf test" as there are
a couple of tests there covering breakpoint behavior and I wonder if
we may need to update them? Particularly there are some comments about
PowerPC just not working:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/tests/bp_account.c#n24

Thanks,
Ian

> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>  kernel/events/hw_breakpoint.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.=
c
> index bc4a61029b6d..8ec2cb688903 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -950,9 +950,10 @@ static int hw_breakpoint_event_init(struct perf_even=
t *bp)
>                 return -ENOENT;
>
>         /*
> -        * no branch sampling for breakpoint events
> +        * Check if breakpoint type is supported before proceeding.
> +        * Also, no branch sampling for breakpoint events.
>          */
> -       if (has_branch_stack(bp))
> +       if (!hw_breakpoint_slots_cached(find_slot_idx(bp->attr.bp_type)) =
|| has_branch_stack(bp))
>                 return -EOPNOTSUPP;
>
>         err =3D register_perf_hw_breakpoint(bp);
> --
> 2.43.5
>
