Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4D257D
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077490; cv=none; b=cdoc2ONhfIunuN5BFPLKEkrq9iTS98KmTxJb36le+esg0Hypx7yKCUtF6WJFL50E1Z4g8myhBwqIwQZtRhSvDCewFILtzv+p5HMcRW4yYFOGPsudpUrpT8m+/H8nSudtHiLY1By5qvRoj6IazDGncIcVm0guaHSOk/rt//blJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077490; c=relaxed/simple;
	bh=AslO4hlSXLLAR6ZVW0kXbJX1cco53316K46hLXXdMCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkEVb4rEUZHc6vcPfpUQmbVwbkCT1HRtXMC7OeW6b7xAPT0TCmWOQ2JnQDF0YLsDC8JA82YmDip2NfVGDwjLqwMlsYARIHq6hGC3jwp6f6WJ2zr5pWOzBJUVh4lhAKG+7iI/gsBKUXHywrLs6zeym3j46jh8sMrG5JgEG6OQrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1mRL6Abh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1mRL6Abh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22117c396baso16665ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740077488; x=1740682288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhJ69vRwG4/Ip9gplTFM8NFvquX+cS64MkbgZEIwj+E=;
        b=1mRL6AbhCxIQpdEgv2WzfQysad2qAnzvQyBQl/jrb/jytIB+bv6Se1aRr2YpCzxWzG
         be7MyRR248MLsJyCrAoiO/wkFD6Wmfqvgj9Qjduwo4OHRXaO3tTP3SfHKcjW9+FdRSMI
         68Z3j+DCJCohIjCHrd3VVH2N/P3jvVB7LEs1td3oERlhYUhaRzGx9gTrYjwkurXKfCSO
         RtwGV2AzAlFDt4xMCGXkulh/mJYMTkVw7svN+z0ZaKFJCEBAo8v1Uqv204vdYZwjbQ2Q
         +AKHdoQ/j3jiEGr6SSvhndsFPlzjXLsKUx6tfBNG9T9JCotjuMW6rFaCPKB3H6UED0k9
         Ol9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077488; x=1740682288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhJ69vRwG4/Ip9gplTFM8NFvquX+cS64MkbgZEIwj+E=;
        b=j2jsejMAg5z00yjReepOwDFu9kAyQVPdfxoPM8rQNNrz+QwTAeQPeUAfOOcg/ATAfG
         YOYnDhn7adpKg1ZMgd0F1JwDCT4DdJcE+S5jwsXo3KyqymYT+Bjq5FT73vtsZrrc5hRM
         nwfJS6hTqSYX6zfx1v6SHYhOVgQpyz3O8Io982iqXftxM1AwmxQ4TIPiCdgvouvtBcIt
         8P1VIU+I3X4j5lLKdFlWfbACYW41xFRIegTyCHPBequMPUv004kCv5xrt5I9w/gBL68o
         SqKQgQ5hBeZweRnykyhIhn0/AppOTnrlc3JfV+QGfmhUBRjnqIjOxJx/V4Ui4qM1Pr8e
         KVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuxBX2+2RnJLST68XHzZ4pO9sw2SsFAzRgf01ltxGXIkNRYY0kr1cqw3k+g8lh+ft3+F6mWxLrPXcrSWz/jv/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GHmTYr7kL/2t5LBXHKVSR/8I7zhU9s2MQWgwFBwnO5Rc9vwV
	Qneea8ROhot316sLk2MIZC9LxXBrjjejr1NSDC4Jzqsuh5fY4QBczc+nM9xIiD44cztg4AyIutp
	eZ6ekPJjg0vWqWGaIXSivcIbJg21EC+ErOLUh
X-Gm-Gg: ASbGnctUEWRW0nJR9fzOEO29NXkevfs8rOGJqWaNOD6hC5UfAAzYYnqIUbjpMidleyM
	8ld3unCR++JAxH8u2StJYa80lqrXbgBdkZsIloWn6AbmksZ5MFmguRZa+crtAj23/gVMV0Mg1GR
	Qlp9AArP2Z2Wkllqe+KMvn4y/C
X-Google-Smtp-Source: AGHT+IECDW8S7YlQj87u+f2jRjQ5P9mRH/NzvGozxEWj9dWUJDrgvBXpzR2jzfN1lFZ0KlbMW6x/Z8AGWqTHbzkEko8=
X-Received: by 2002:a17:902:d483:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-221a04180f4mr119475ad.12.1740077487831; Thu, 20 Feb 2025
 10:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116230955.867152-1-rkanwal@rivosinc.com> <20250116230955.867152-2-rkanwal@rivosinc.com>
In-Reply-To: <20250116230955.867152-2-rkanwal@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Feb 2025 10:51:16 -0800
X-Gm-Features: AWEUYZmHbSjeW8HzHoyYmG869PxyzHFXRgpXexLbuZp2OsvcdU8Dmp28AKsYjrs
Message-ID: <CAP-5=fU9ovvb-JopPqQfNaj6xtL=u_WZO-b56RdhBmUw4mY0ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] perf: Increase the maximum number of samples to 256.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com, 
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com, 
	beeman@rivosinc.com, brauner@kernel.org, conor@kernel.org, heiko@sntech.de, 
	mingo@redhat.com, james.clark@arm.com, renyu.zj@linux.alibaba.com, 
	jolsa@kernel.org, jisheng.teoh@starfivetech.com, palmer@dabbelt.com, 
	will@kernel.org, kaiwenxue1@gmail.com, vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:10=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> RISCV CTR extension support a maximum depth of 256 last branch records.
> The 127 entries limit results in corrupting CTR entries for RISC-V if
> configured to be 256 entries. This will not impact any other architecture=
s
> as it is just increasing maximum limit of possible entries.

I wonder if rather than a constant this code should just use the auto
resizing hashmap code?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/hashmap.h

I assume the value of 127 comes from perf_event.h's PERF_MAX_STACK_DEPTH:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/perf_event.h#n1252

Perhaps these constants shouldn't exist. The perf-record man page mentions:
sysctl.kernel.perf_event_max_stack
which I believe gets a value from
/proc/sys/kernel/perf_event_max_stack, so maybe these should be
runtime determined constants rather than compile time.

Thanks,
Ian

> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  tools/perf/util/machine.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 27d5345d2b30..f2eb3c20274e 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2174,25 +2174,32 @@ static void save_iterations(struct iterations *it=
er,
>                 iter->cycles +=3D be[i].flags.cycles;
>  }
>
> -#define CHASHSZ 127
> -#define CHASHBITS 7
> -#define NO_ENTRY 0xff
> +#define CHASHBITS 8
> +#define NO_ENTRY 0xffU
>
> -#define PERF_MAX_BRANCH_DEPTH 127
> +#define PERF_MAX_BRANCH_DEPTH 256
>
>  /* Remove loops. */
> +/* Note: Last entry (i=3D=3Dff) will never be checked against NO_ENTRY
> + * so it's safe to have an unsigned char array to process 256 entries
> + * without causing clash between last entry and NO_ENTRY value.
> + */
>  static int remove_loops(struct branch_entry *l, int nr,
>                         struct iterations *iter)
>  {
>         int i, j, off;
> -       unsigned char chash[CHASHSZ];
> +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
>
>         memset(chash, NO_ENTRY, sizeof(chash));
>
> -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
>
>         for (i =3D 0; i < nr; i++) {
> -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ;
> +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is not
> +                * needed as hash_64 will anyway limit the hash
> +                * to CHASHBITS
> +                */
> +               int h =3D hash_64(l[i].from, CHASHBITS);
>
>                 /* no collision handling for now */
>                 if (chash[h] =3D=3D NO_ENTRY) {
> --
> 2.34.1
>
