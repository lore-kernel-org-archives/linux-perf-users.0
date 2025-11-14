Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE6340A72
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141623; cv=none; b=YgUON9DfbV+vkEr2xGS5/Zf1vXG4co+j9xYI5e+oWyTySXOxU6fEI8kfZoHf3Bq+ETNpCb0A5NOZhe7UNd7EXm3Zw1/j5R4gGuvm3qqjTFM2tDPYzP99nH9iQt30FtY6r+3zCIQ7j/PeBDl0+hYMd6V7YQ48efsQxSvVYEHpDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141623; c=relaxed/simple;
	bh=gGileaG1AX7Ihjv6/HnVsi7prhVBiNNGXIYm3d8VwbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqZamxDeFvMPr+ce7WrnmcifyvS6V/AiFrTJlta3iwd21mAU3fs2naHf35OXM1fbzXnOcfYrVJLnJmPRqJSRi+JVlPixsUEXziFGPI85EuROUIKev+CpS744St9kmZsPqeDpvE9pLVQJiju747lTCyXIAKk/QdlIlqPdBvxfxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBSA1Vkd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBSA1Vkd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso211635ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 09:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763141621; x=1763746421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj+Ic345dILi3hlGEqPGHr8Xlg/dmuYQDDUF90jTm7Y=;
        b=WBSA1VkdTxqhl25kAlw2q3/yyTv0YO7btvHR+zU/UNHYbTcZV7sPS7cjk5k5voyjeh
         vLDYr3ZYkE/dIk99y2geYMMoo+KTlfq+ezXV2AwA5kKH6KIM8JS4dswBU7APqckSK5jR
         HpI46bH7+keUBzgXqUzlOc8l/4LrvE9Tfr/ogzWZlr/rnaqPTKHGSfEYwCONYNjgkA0N
         U/63MQYAO0LkjIKipxZF6nG0NQBwJ+MUH1ukYqjats0s+g9vwNLB84Ok0zJNioAm2Pz7
         bWI02utu/Vbnb5/EPzF9UDlBEchK6k0zZgPOsF9h/Pgw5Adwv5CDEsWlg2QcBCuZgl31
         tKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141621; x=1763746421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yj+Ic345dILi3hlGEqPGHr8Xlg/dmuYQDDUF90jTm7Y=;
        b=CmY3wcnK7Eeyf51CgepliV0DtejqWNyQquOdAZaZ8tl5a75blUPZUhT7oRyDQqV04c
         HPbGtgN+NJLwaediM0D9imdvAiq8D0RPw77k17qG0gMCAFbDCGE3GVrmjPxMpDT3RHaE
         4PqUaJeNmzb5pgOxTAF2KbbGsi4CSUoMWxN+x1Alp/v1/Z5/jyPVe/rZTe69wJP1+aL/
         9YpFn6qsjuUeuWUG0t5FfkAw3uFlhXbIXsrn5dN7htANp5cVsMqAiE6LWfVzCiU3usXD
         S0w+mqIeKUecNx8YZSWiGLkkhGLbK2nM1P+lpmRVqfGXYx7UOpnryKE4ttTDAK+Be6FL
         7Q8g==
X-Forwarded-Encrypted: i=1; AJvYcCUbi3d2reHT+ISG1UsJTohM/9l8UTbMKgibiL6ZHpxeWKVlH00PvkL3zCv2qctR5okSs22+V0RHBTpY8YdY1MFn@vger.kernel.org
X-Gm-Message-State: AOJu0YwVggAAXLUx1hadWPt+fm07lf4bxX9xrOQ9XeKXqdCMDtKN7nuY
	IHtBmsH2NMc2XRGXlleW6fkjucLP3poarAPYOxmuez7JX1/ncvfQONT5qVkhdX1qB8T8U4kWLPe
	YAAmPnNb15T0KCZa602gXKC4YxsB9y7KitOGYRRY6
X-Gm-Gg: ASbGncsR72DbblGM6dhx8PCpdmMdbcxHUBIY2ROEznkhtInMm5O9PJ1yZl3xqP209Lz
	6zy659BOm3+/OqBMRCvQDQCVSVl0Qz40Y/Fz1dJ4yugTZuB5sCTi+spBoVwcrUa0/Q7fKLmtfMQ
	sR01UJVSdHrOBiGJxqxCMDF3+MG+uIkWfuxybXKSIiqgCciPn90ZKyvi/inXzhCXRU8My7M+0wF
	KjILQr03LFspUB7fUK0n6okjwkB98dVcQkCBi3tJ6qgdykIoz9zE5h+zvDsfdbApOKKzeLpWOp2
	xHRQahWkvYgkkZxzgzM=
X-Google-Smtp-Source: AGHT+IELp7ZRooM8gY81nyqC9mBy4GtxqJRdv2X7VY+TzqNT5unOyVSJFmlPRE2QWxUje2hG1cMb8LDX7cySpmNT1Fo=
X-Received: by 2002:a17:902:c18b:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-29869ac0921mr3421355ad.2.1763141620897; Fri, 14 Nov 2025
 09:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org>
In-Reply-To: <20251114092914.217533-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 09:33:29 -0800
X-Gm-Features: AWmQ_bnR95Ixqill4rwjmnJ0yYbUCkxnkzfe7zyr1WnRSq5r7ZJcqAxrtgVKEHo
Message-ID: <CAP-5=fWsFLkYGFFyzSrpZNdRLpjaTZAuW7-YVUr-zMVH5dk8eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf jitdump: Add load_addr to build-ID generation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Pablo Galindo <pablogsal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It was reported that python backtrace with JIT dump was broken after the
> change to built-in SHA-1 implementation.  It seems python generates the
> same JIT code for each function.  They will become separate DSOs but the
> contents are the same.  Only difference is in the symbol name.
>
> But this caused a problem that every JIT'ed DSOs will have the same
> build-ID which makes perf confused.  And it resulted in no python
> symbols (from JIT) in the output.

The lookup of a DSO involves the build ID and the filename. I'm
confused as to why things weren't deduplicated and why no symbols
rather than repeatedly the same symbol?

> Looking back at the original code before the conversion, it used the
> load_addr as well as the code section to distinguish each DSO.  I think
> we should do the same or use symbol table as an additional input for
> SHA-1.

Hmm.. the build ID for the contents of the code should be a constant.
As the build ID is a note for the entire ELF file then something is
wrong with the filename handling it seems.

Thanks,
Ian

> This patch is a quick-and-dirty fix just to add each byte of the
> load_addr to the first 8 bytes of SHA-1 result.  Probably we need to add
> sha1_update() or similar to update the existing hash value and use it
> here.  I'd like something that can be backported to the stable trees
> easily.
>
> Fixes: e3f612c1d8f3945b ("perf genelf: Remove libcrypto dependency and us=
e built-in sha1()")
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Pablo Galindo <pablogsal@gmail.com>
> Link: https://github.com/python/cpython/issues/139544
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/genelf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index 591548b10e34ef6a..a412e6faf70e37f3 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -395,6 +395,15 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unu=
sed, const char *sym,
>          * build-id generation
>          */
>         sha1(code, csize, bnote.build_id);
> +       /* FIXME: update the SHA-1 hash using additional contents */
> +       bnote.build_id[0] +=3D (load_addr >> 0) & 0xff;
> +       bnote.build_id[1] +=3D (load_addr >> 8) & 0xff;
> +       bnote.build_id[2] +=3D (load_addr >> 16) & 0xff;
> +       bnote.build_id[3] +=3D (load_addr >> 24) & 0xff;
> +       bnote.build_id[4] +=3D (load_addr >> 32) & 0xff;
> +       bnote.build_id[5] +=3D (load_addr >> 40) & 0xff;
> +       bnote.build_id[6] +=3D (load_addr >> 48) & 0xff;
> +       bnote.build_id[7] +=3D (load_addr >> 56) & 0xff;
>         bnote.desc.namesz =3D sizeof(bnote.name); /* must include 0 termi=
nation */
>         bnote.desc.descsz =3D sizeof(bnote.build_id);
>         bnote.desc.type   =3D NT_GNU_BUILD_ID;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
