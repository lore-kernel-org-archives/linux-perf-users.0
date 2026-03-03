Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B843368B9
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580717; cv=pass; b=U/W8jcmTQeEUp/UyeO3QaJFtzsSIHu5U8Oejclwvp1ogT5szSvgVTFNCiVXXOS0XYSnbTN1Q8LVPg7m9L1ps99BWvJHULrgY4AFzNbdraW2ile9XtEx+QTCSbvEStAAZX0PLO43Gl2M5pA6zHM2U/5lYLviIMbJMnsOVsRBm6L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580717; c=relaxed/simple;
	bh=bofI28OJ76B/B4IckMv6egQDwwMkWPATnXo6F3bO/UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJtSk48IPde9AIkJ2rNen33RShiE7OTVPoZorFfIvciIEqFbiFtWdwog+tDGzE/qL+yOLPl3zDeKfpvg5fdcCe1pPDWxuAGVNKXDLYj8Mx3AwftpFx/2hx75pyZtHXJkdMNpefWuB53L9Pwjn/mB1i22441OQMyhkBqh0Y4zH2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aPejDZ8; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aPejDZ8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae523d54d2so127205ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 15:31:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772580716; cv=none;
        d=google.com; s=arc-20240605;
        b=TerdnV+PEQXgMTlJtAp8OlJ/rj0sRgePbWIoYwp1qUxopwpYnKTpq1Pt4f+kcLORPg
         AVWcP6YUKlWrf+RONHCem+DxcuvVfajEbKd0DJu4Q+ix9RNBj09pzgJiMU7wnhinUOnt
         2nWHzITGhthSmE8ZlhEOqvmcen/Nx/bV+o06lQ1XBN95iotK9nerNLlJtGA4CGA0yAIA
         2COBnwp6AGPnBunRA4qocvcVMQb+ESx/4jreXrb2c1WaxgXtOuz/TthedNgNElxKclBN
         2P+zz3PXJfZmUq/WXHFG0z/uWqndNYR9Tb5ihoYvT8+QN06loMf12qB48zJs5YA4ZptU
         AJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZoP5lJCySjDFDGvNofXisL5k6RJclVDwCVopLRWlctE=;
        fh=NbsGwNG06/5qxXmzmQBXL6X0CMZZBJjJTNqLJWJKjvk=;
        b=AhvV2vKmV0KiTvj9TalC08x0pYU0ZDjxZADp15WfeQ4AMRrChHtER6rE00NeoYEkvl
         eS7QRniwEVb/gPgcak+FgrSfnJTlQKiFuKD/NE8WRn4R5/ylQPXz8rbVMeeia+stl3wi
         fRA2VGqseLaf2BX1ddqh45xDR1p+mwXqn1WR+kbMwLaKV4dX30u9cx6suKyGtDTYNp2N
         FTYfdAeTr9ec9gpjFs6Bzt6vbQZOH/VqmabEx5CvgzLEzsRVEVEH9yTv5RdpA4IZum9N
         m+JaRY2MgBcR9NwtDUjDGoQY8eFYYeO86TZpIXecLxPxbdo3Klb7LfZ2SaQBRdECUYmO
         aINw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772580716; x=1773185516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoP5lJCySjDFDGvNofXisL5k6RJclVDwCVopLRWlctE=;
        b=3aPejDZ8pdmyrm8MRuWuDe7kDraaG8+W92A2DeZTM2SpqYWkzq+5Z24dqDJsKNIlcz
         mmM2SfzC8uyW0vcchhg+bCKXBjr+bbGHL2t1O11EWaigQjxKfHNPgGogzQIdAKZrlOqO
         kHj4PuB/AuBguqGkiFv23LXQ4WmKST3ylZr5EqqF7ey1x9abG8x/FIeO93A75qlJv+k2
         Pv8WsbwmXeo+Mn9DRvxl9XKkf4xEUJlnFCi14C4DNYHgDlqXSaYE2XOTCVauC8IArGSF
         /SoQnGoenRu3D3ITD/0mi2gJfdRqaAEawdsxI1TTt4XJrSVFmNLIUjMTVwvFZFrzkSWb
         tnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580716; x=1773185516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZoP5lJCySjDFDGvNofXisL5k6RJclVDwCVopLRWlctE=;
        b=PyysaycEqt1nk+O5wPiI9cQRgwojjW7T+uymittXuJkv5lY0hbu1yFxryYAojwWhjU
         sB0P0dnri7W20kiX6cyT+ZrV2NtWnMIy7iRDGYZoXhwVMQoKBztr7fdAfJhlpSN0ULpf
         uOcqObOK9vU+2AOJbdtyk+55WrMxKRWhC78/CL3daRXYz84wcE2JPUeFrlVq5wt5Ua8n
         GXZXa3vvBvKh6bOfvNkJRROAPMAvHdYpik6w3cZ3Yuf4oeclZsEG++UWo68kU2sAzm81
         S0LGdmApR2u7CxrFlf+8e7d2e1OPaw3eTEaoDm2SDZGEge/JrURiQ3Zo4qbofPeHey7O
         TOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHaSYxNxzyUwnyvFQnsu+bovRsv3DtYHmtHHtGQkN+EawDwMMXXQ36u/qDQsZjQwesdj1Zi6TCTR5OV9akvpnn@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpkP3zEJuO1szjLz5xAnM997C3FIWnkayYDHDueIotPt/lRt1
	OBlCs7bOpWLs1Uagq9JN3osQ8X72GkYkScOaBMQzpgisRjpkgzF8qLDjma7y6IMrCXwGl0SSC9z
	XnJgZ1Yhbb1wCAMx4RUpLDirT0kKh4gQt+AIWjTXu
X-Gm-Gg: ATEYQzzY+GD83RWZvhQ18JeJpmmN1+xCYyivFLazxE0gRHtdjvLO7M1fGczsh+6uUQg
	9kHHeIQTLyBuYofEIoK+yUx4s340gyHtE7x/a8DKn3rp8vSmB9XLjRO+aL17BhpmEhdfGQa9F7T
	lFUNUBMgbMQR1/9tncOoshDMOa/kcYKg2DKR7LwcTplMSTvVrLRQYxq6IdSynCIbbqQ0I1yXXCZ
	kvnwCafuTW9CQkIWQgC0I/48bmQn8ool7+pukQX/UoFWf2ht9ft5C9Xza4GMP1C2yJpKLj3iaEw
	SkQ2BRS4kNfDQsYDxeGDIUkbUQlKQV40k/IdvA==
X-Received: by 2002:a17:903:244a:b0:2ae:51c1:7ee2 with SMTP id
 d9443c01a7336-2ae51c18afdmr5453565ad.24.1772580715265; Tue, 03 Mar 2026
 15:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303230056.2074898-1-pcc@google.com>
In-Reply-To: <20260303230056.2074898-1-pcc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Mar 2026 15:31:42 -0800
X-Gm-Features: AaiRm53SL-tyeSl7wCDJ6z9QW0IPppvtX-zGyhjceHAreaAvWIBmIxLfEmGkBIo
Message-ID: <CAP-5=fVUv7bJTfyJYheKqXcJFzz3f0-auXYFmOGYfjtCCQSA9A@mail.gmail.com>
Subject: Re: [PATCH] perf llvm: Specify features="+all" for aarch64
To: Peter Collingbourne <pcc@google.com>, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:01=E2=80=AFPM Peter Collingbourne <pcc@google.com>=
 wrote:
>
> This is consistent with what llvm-objdump does (see [1]) and allows
> the LLVM disassembler to disassemble instructions not in the base
> instruction set.
>
> [1] https://reviews.llvm.org/D127741
>
> Link: https://linux-review.googlesource.com/id/I52e4fef18d2e12b45f875231f=
a9d3efff2538fd4
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/llvm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index 87fceae8488a7..44eff99970fe2 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c
> @@ -153,11 +153,17 @@ int symbol__disassemble_llvm(const char *filename, =
struct symbol *sym,
>                                           /*get_op_info=3D*/NULL, symbol_=
lookup_callback);
>         } else {
>                 char triplet[64];
> +               const char *features =3D NULL;
>
>                 scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
>                           args->arch->name);
> -               disasm =3D LLVMCreateDisasm(triplet, &storage, /*tag_type=
=3D*/0,
> -                                         /*get_op_info=3D*/NULL, symbol_=
lookup_callback);
> +               if (args->arch->id.e_machine =3D=3D EM_AARCH64)
> +                       features =3D "+all";
> +               disasm =3D LLVMCreateDisasmCPUFeatures(triplet, /*cpu=3D*=
/"",
> +                                                    features, &storage,
> +                                                    /*tag_type=3D*/0,
> +                                                    /*get_op_info=3D*/NU=
LL,
> +                                                    symbol_lookup_callba=
ck);
>         }
>
>         if (disasm =3D=3D NULL)
> --
> 2.53.0.473.g4a7958ca14-goog
>
