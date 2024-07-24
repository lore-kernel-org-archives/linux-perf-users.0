Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F915D5C4
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852994; cv=none; b=LOIzsETeIIMHQztcXf9rGK1/sZPxjec1UjPWhtPLmrXbGGecBu2GHXS0H7S0NkBK74BU2/W5cQ810M+/eCCHv2o/ctGGj7u1KwWF+uvE7gByp2EI4c6TEqdceihd1nAEHqXwMXQsR0t4WaKFrrIO7LpU/Gac8+rqKfKuy22ac8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852994; c=relaxed/simple;
	bh=pA24+GbwV04rY6/CuDYGVEIeoUL9GEcT3z3hubsKimg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmeBF5TPygBCs4oyNqDimO2RjEJSFPfbMKMKxFUZsGpbHgmrP1zfVF0HvRWi1UsMP0eXBgQlA+eUPrIcnMfEsl1qknb7oqFc00nhYnxsfn+qhLflZX91IZoRrQVeBWi1VlDFFn6zZ1mR3x6egFkRqKRsEVRJbOmP/w88QFO5cpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=go/g1b9D; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="go/g1b9D"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39a16fab332so30505ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721852992; x=1722457792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9vJ0nLE87mP9CS3SgjQNBOcAsIyv3Fr0rkOLSyy4t0=;
        b=go/g1b9DAQqU87uJwBt02EIYFD7AQl/Hdfp1gfsFBA7Y5yiErVNQq/YN37iiLf6AH+
         17MoJdDOZX5/pnVAELbfraId/yOfhel/aB4zp6MfAmJNQ46l0uz+MHCHmOZCzB4gJ6u3
         ucqShRQxZGoiVCS0MnWKeUx7fSGbosD/z+r3UFSahKzGFQYg4/4wo9K/b0gRjoB+pxGg
         P0mjJTOjWaZ1j9TC2e8nghMuK3CLAcBsji9FpsJ4DVtUXY5LiT8fhrEHCY949KM40PIe
         W+vb/Xv7Ke2clqBlU1jyY7XfPEaiRCK+mW/FPgF/LnkyoY7X23okyX+VsYQutcVQkZVa
         XkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721852992; x=1722457792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9vJ0nLE87mP9CS3SgjQNBOcAsIyv3Fr0rkOLSyy4t0=;
        b=qyjN/uzanfbY/+FUctttia+hO2BEOzy/9atTr4R3WZCHCdva7nBHtlMGur0eY5v+we
         /VG/MIp6t6sZv9VFTv6Bo9uRUQ9R7v6u1adEPOS6nMXTe02EY1p9Ems7+a/KfcBaiJTX
         KLMCFZU2Gx0ASUGoCu/62XLLfp9O8nAdmtzn9zRb1n2cNsBGOHBCauVSS+B2hyt9AKNP
         8FlIKRxuhhDnlWQdsGmWnleoGp0IaCpavFZNgZHDHMP3WrTXDW9wolHNkEddcMmvL+cd
         XNiqB4o/Cj5USfRAhDXDeSubmQ6BoqxgJDXBCOUcknGAOnLIy4UmrMB/cB/JdFV8UQc6
         /Ffg==
X-Gm-Message-State: AOJu0Yz4PxeLNaMAaKQBoiFNVTIS1F/QKXBU0ud7fiCf5h7mGuCW4erX
	KBxoF1GIlabpTo1qbxdsYORA7Kpekagkqo81LhJChawVzlDAV+S9IPDd4HQtXZ8rb2Po4yG4N6u
	GZF7Bfu91XQUEfPtwPX5GFNShqsXjiTv+pghihRPU75X/lAB8eQGN
X-Google-Smtp-Source: AGHT+IEzG9+NHqmNVAv3nJuzHBgsz03oLMw7q1H9eRj3FDvNA4zsqgMB56f9plo+B/qKnYwSKQigm/j8ZeXpfg4Eqpc=
X-Received: by 2002:a92:c545:0:b0:376:48d1:1764 with SMTP id
 e9e14a558f8ab-39a221befcfmr774345ab.17.1721852991952; Wed, 24 Jul 2024
 13:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724190137.3810429-1-ak@linux.intel.com>
In-Reply-To: <20240724190137.3810429-1-ak@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jul 2024 13:29:40 -0700
Message-ID: <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] Create source symlink in perf object dir
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:01=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> Create a source symlink to the original source in the objdir.
> This is similar to what the main kernel build script does.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

For all patches:
Acked-by: Ian Rogers <irogers@google.com>

For patch 3/4 the aggregation logic doesn't look to work well with the
patches I sent:
https://lore.kernel.org/lkml/20240720074552.1915993-1-irogers@google.com/
I'm not a fan of it, but I don't really understand the aggregation
metric logic here - periods of different samples from potentially
different CPUs being combined as if they are counts, zeroing of the
counts.. I'm not going to rebase my changes on these, and if later
code removes the hard coded metrics for json metrics then this code
will break at which point it is reasonable I think to disable the
test.

Thanks,
Ian


> ---
>  tools/perf/Makefile.perf | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 175e4c7898f0..d46892d8223b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -163,6 +163,8 @@ ifneq ($(OUTPUT),)
>  # for flex/bison parsers.
>  VPATH +=3D $(OUTPUT)
>  export VPATH
> +# create symlink to the original source
> +SOURCE :=3D $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
>  endif
>
>  ifeq ($(V),1)
> --
> 2.45.2
>
>
