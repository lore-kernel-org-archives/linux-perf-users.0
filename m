Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C73ACEE9
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631242; cv=pass; b=EAXQvDA4L/tx/OUUOx/F7QJwpCZW4nAJQepkXmmSYvk8O5paHbBtnVSEICvoPPSepD87MAX+SS4vqGVeeZ6bcgn5jT+PL1VEDLyOROCjsYDhOykoV7DeXqXHmI5F1B/HUxszyI6hTBgVw2KtGFjsI6y+Lhx++WZxsThi7nZVPcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631242; c=relaxed/simple;
	bh=mvnwzhrAjkxMDQIccUyeWUTpXbWAVvfTvL0DsV5qTxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq6RLybRQAOJMJuI81oDS1QnMeUFVLRiC2ZB5hQlO+KXWOlGfGR4Hn4hOa/Z/vgZ76pronAuHhV1bOIrfuwhLBS1TJcpIqtu8fL3Bf5P9wjpOThU+lh7p4848WbkkmMzEcJwFy2RSdH+gTLPgFClx51S+83ppp2MakUp2yi8gMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbllXQMi; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbllXQMi"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53328262efbso108141cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 14:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790631237; cv=none;
        d=google.com; s=arc-20260327;
        b=hTZBLr7Oumyhn6TonGiUseasiP5FI07fa9+4sT9v1YnbaOJ29GplJClh9Gt+dgh1+h
         HUX4Rdt2HapmBGrfkRNcCoSaTWMBjXgg3up8oLxHrcBVSjjf12zB8BMHvjTwSYNEPMn4
         cetmKfYOtjjOeFtU2Xq5tQHDRsx+O6F39VxSeBs0sHcZliPZ3Onp4AZV1xM22xiDjndv
         fWGDeyIJuD+L0Y3WIyeo+CPUBpIalNJ1GnHapm/VVg22Q+Nn+3mLvX0gMmfJu+tP3SP8
         0Z2THTg33rz7/B3WUPShE69WsXZJHFVWDQ9M9siaQYTEJsPl678pamA2DUx6aSRSvdrf
         bM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8eEcchkIpkzuM/k/bywXXqMRJi4G2cjVVq0/v/CZCJo=;
        fh=az28TDS0mJ1xCPAAtk9k3L42xJraTAAC/kqoi3FTv/U=;
        b=AxrZXlTFnC9hbtGJUV8T9+J/daVvAlaj42i6nzxS8nFV/v03XvL/dp2ppt8Krxuikc
         YvyxZ9+kMrBKWhZC2gb5g0zkVThZEnKdLcjXsjA+0p7yfO+jJV9ZGyLnQ1M7mODbC1Ma
         gHv7ug/cTy0xRKRNqmvw2fWFcW0pxCc8Z9dm3EUzqqyfbegzYF1koSf3G86n+5tKNRek
         Fy0lNPdfwZxMmshtx9qNorw9u7ymx8hK75m5diCu6/UNky+D/30vxJ0ePdUhsncYf9M6
         mVMgiD6PNFEvGcAUpqRK+MaIWXMwT3Duh2Zts3fcY/JU8Do91UQsaPMIO6/v4DgPjW7t
         X60w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790631237; x=1791236037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8eEcchkIpkzuM/k/bywXXqMRJi4G2cjVVq0/v/CZCJo=;
        b=cbllXQMiWRgOBjxvlxCbIF4a26yBnHX1iIKioPDZJWQ2wKo/7LqE5gT3N3BwlgOv5S
         2UAIJkfPxk3VFbCnjVMAetepDGHLDLyy57grVbv5uTFLCLLTPFIGxckzxETU4SlexBNr
         cXaADWClQ2+fGKPZduCUdsdXNQO4053xfG5XoBYJtHs8V9TWOPH+SqAGvOTfDlKI2MBn
         RoGSbdMWdq9F4hK6Z5BKhVwqU9x2tThmRYh15dYCI0fiFRkHVRTUCAHPhAbyynpKJW8z
         eynbPyGx88uUERHces/CijfFTsf5SkUJ75VMHncF3THsMYPQoIX0qp2w7NPVAWXlkVK2
         YWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631237; x=1791236037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8eEcchkIpkzuM/k/bywXXqMRJi4G2cjVVq0/v/CZCJo=;
        b=ho1EYRdryp4bDD03GYnQqcBS0fYwOZDm426jsHCbAcYiydD0CfrOI26vu12UOq31qd
         rTfwR3Sm+7ibcQDKYhU0cRQo5cNI3s5X41nxLWLxjXw+zwtC4h1lzAQcCTu7/JWUImgM
         bEaO4IJ0bWCV8ud410aj+Wwrd+yddcrHlNlohl0qNQH0efNAVrHUdnZLhycTinuD98Y5
         A/kh2JPj05NwtaA7MaY50LLoB+o6eU1lGTcIxRze0hXDA/FxWCJ+MOuD2EvzXReXBRn7
         4hqUHgTxplR3YwB0xdwNR30XezV87Ges3Dmpwqzo3B27Olj9KTKmn9FqhRMJ/0K63I6C
         CYJg==
X-Forwarded-Encrypted: i=1; AKwUvBy4d+BkInz0Pd0EJDAnEjkJDvqfqNKMGKUDNcbVcWggJyLp78aL4vYvheRZr2NUFS/uJQwW5uS/gcNd+vU1P6vI@vger.kernel.org
X-Gm-Message-State: AFuF++kRH0bHdeRq5A3Sa9JWERIzPo5ixuCb52V7ex5/BZ1271tRy8dt
	y+5MSYWDq4gXGk2rVCLR63scEzHeT00g8jLPEpwlvZH4VKPtcUzmHOlBtZY/oNFTVjoDhrDt2jH
	kDZm94Hj+N34WrQSOA0Tm5kaKMS3wjS7EhKa5zHRy
X-Gm-Gg: AYBFou1jZQ94zsdpC71H8QJPevK13u/L9lUy/qQ/s1xscGbAhgyPhUANCZhy8BcH8YC
	xvPBJf6FiBaaLNwW1M919wUAxfAkX+7EDgnqshYbvFalFzESnEw1nvQRAIXjybl0/HRnUyfE+wH
	XAvHnH0KWBjpqKgUi7D16rpVysJiMXKQvKHBkyAv9Zvp7+K3zEC/EXV1Pm4/zb9eLTdt01xMhTL
	Sk6DRByOKacC0rZawdwgfLz8k6bPRJmBNDLUZz8p6381sGcNAj3LdU139WWodWoRT/xeugzphpz
	Bid1fZU0sVaEyncxaVHEZjpv2dUzq4fRkH7I+ujSohB8kazD20Skb8SfRvbwjVruJGRXMpfW3bE
	oC5U0xMPrMA==
X-Received: by 2002:ac8:5dca:0:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-5332017d9f6mr39094041cf.14.1790631236924; Mon, 28 Sep 2026
 14:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928010227.1903673-1-michalpl2003@gmail.com> <20260928010227.1903673-3-michalpl2003@gmail.com>
In-Reply-To: <20260928010227.1903673-3-michalpl2003@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 14:33:45 -0700
X-Gm-Features: AclHuK8tOhJaaF_R6BCpvZsdIDDniOhALvqDSFCbWhh5mpLbAdq-z3_Ao579OEI
Message-ID: <CAP-5=fUZZkagjaQy0wvme_L_+yif826nPXJzXNJ2YXuYZ6RW3A@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf symbol: Don't return an unterminated Rust
 demangle buffer
To: Michal Pluta <michalpl2003@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 6:02=E2=80=AFPM Michal Pluta <michalpl2003@gmail.co=
m> wrote:
>
> When dso__demangle_sym() runs out of retries or fails to grow the
> output buffer for a Rust v0 symbol, it returns the buffer and callers
> blindly use it as the demangled symbol name.  However,
> rust_demangle_display_demangle() doesn't NUL terminate its output when
> it reports OverflowOverflow, so the buffer isn't a string.
>
> Free the buffer and return NULL in both cases.  Callers already fall back
> to the mangled name when no demangled name is returned.
>
> Fixes: e20848c317b5 ("perf symbol-elf: Integrate rust-v0 demangling")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 163652f071c6..3cb42805a82f 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2762,17 +2762,16 @@ char *dso__demangle_sym(struct dso *dso, int kmod=
ule, const char *elf_name)
>                      buf_len < 1024 * 1024; buf_len +=3D 32) {
>                         char *tmp =3D realloc(demangled, buf_len);
>
> -                       if (!tmp) {
> -                               /* Failure to grow output buffer, return =
what is there. */
> -                               return demangled;
> -                       }
> +                       if (!tmp)
> +                               break;
>                         demangled =3D tmp;
>                         if (rust_demangle_display_demangle(&rust_demangle=
, demangled, buf_len,
>                                                            /*alternate=3D=
*/true) =3D=3D OverflowOk)
>                                 return demangled;
>                 }
> -               /* Buffer exceeded sensible bounds, return what is there.=
 */
> -               return demangled;
> +               /* Failure to grow output buffer or buffer exceeded sensi=
ble bounds. */
> +               free(demangled);
> +               return NULL;
>         }
>
>         demangled =3D cxx_demangle_sym(elf_name, verbose > 0, verbose > 0=
);
> --
> 2.43.0
>
