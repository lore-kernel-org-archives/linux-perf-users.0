Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9913A40B6E2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543835; cv=pass; b=CiQirLWPhqmdRx3Zd9XHZZsp7V0fOtMBZ0He2Q4iz8AS2BP4DIRGHLfP9+V0EzPFmvX69tHPItTFQzDaBSA0sO/UsC8u1KbWN5U4HFtBTi50WV7bhQqTFpSH2z0+whu9XYAniy9QsY+LwSW8xKABFb7c2tNLVZ2OsuAUgakFOys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543835; c=relaxed/simple;
	bh=HF1hOcVimeh8R5kre0DyP47e1VsT6976Ae7PNDA8K7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWUgYztUgCtyj/D/tvz3ZO9t97zBgkJBFbkXTANKNN+ZPtM1f1USLkuo8RhK/ToDrLCWa7QXo0d9ff/LK3vZVQSABnCHtluToIjIKQ9cR0F+zTpkMHx3EfEGwy0D8Ic81MkZ11pEhfrCO+jsGwUYKy3ewrLN23ytxeG9U6fieFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVxX9Tc+; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVxX9Tc+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22c18ad3so3515ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543833; cv=none;
        d=google.com; s=arc-20240605;
        b=WhVhOzfffXP5e/CEDXR7XBXtqHyCJVFHIwypkVKSssTHgTFK6wYFm+8qeITSq6/40K
         ymMyWfEY5zSnv06LZW2IsOdTk8U9VA0TPLUIAkPGd2iTemYTbdW3UMcsE8wyeQf64aVt
         WaIikcZQEsqqSBRZw0DEugvRBzeGIsiAU5tR3P0YymcoE2lYLN62gpMxOyhBjZWu2O0r
         dwwEjSYwxWVuIrltLddMWREssp9X8bCUfsscnv4LRVmMqzebya5C3KUHEeX0RyRTjxHI
         VSFegcc3QTYC2uWvO9pzzSem7m7z7Gw1I57w+EuNV1y/h03t0fjsvRffFe5jbX7OBNWL
         jubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ydD1ZG4KQsf0sVlfiUeoG2cZqJf+h9rhV1/rDd+jT5g=;
        fh=UyyqQZ8wMhQQqjPUIcXyJ1NTbVgZYMoukCnvYm9CzHk=;
        b=YkAOfNmRJCZNtVxYEIkCGEGFyymsqxcfTU40Wr0QtOteEVUULiYaYtLwnKaHBn4gZO
         ksA8SnUsjGAi0yfSP+8KRGnf4lNmOFLy6AOxoKPlQ178uBO+KS/9DXw7af/FeJgItGrK
         9wyCbLqTIJrY+0r0g9eRZmt3AIkp1Ib1vyMu7Y1AjH9zkkLw7exPIMqNCdWL4i6Z+m+s
         Wd2U42m4b4X3+Micy7+xkgKJMVuyUGeb17mkjQlBT5gh/kxHJDuWiuF5Pf/oM9Q1QkAe
         ZleQgITOwR6NFnTwf37/PwKb2JoLVpOgdJhIB/brnxBHPAyOpvK2kF1K2gLm/BdhBRxs
         aIkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543833; x=1782148633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydD1ZG4KQsf0sVlfiUeoG2cZqJf+h9rhV1/rDd+jT5g=;
        b=ZVxX9Tc+2sxxtJVzDH1N59w5mChOXNCoBtlDeIkZpnauahkica0DKsLLcMaaKT5YlT
         StECbat/hTZw9olfhsD4EJcHSJRUrtuFDWg7UF71Pwjmn8bk2hlJYjpV46O0Aneo4y8g
         D8n9Gf7GxEzOk5zM2Ohx2OXBoPimScJrmR+fLOrFIzCxK8H9tLdPOvixhD1b0NSfe53r
         3/QCIlXD3sJhFBqfUqG34kcPOGNn1g3yrNLsgwqxKBHR7mk8iS0OcbTqDGD+FBMwlLI+
         US27/x6TQIXcARXzTRlgKaK7oC0JTsN5y7VLEkTnUpTqwB0djP9eZKp8AqJdy9F0E7l5
         pdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543833; x=1782148633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ydD1ZG4KQsf0sVlfiUeoG2cZqJf+h9rhV1/rDd+jT5g=;
        b=gBFMmEADmKmFhM/2rnazGImhlQ1kwOoTpO3WECZsuQYM7MZ4pFUNZSyLR0HtIVF3T6
         UgyPJrrwSQqr3CH5aNxQBOVSKyyWLHxdGOJZolcQDoVe5dSV4skO/Yc3sue3yUTJjl2e
         lVNh/UrFJE1D1v54HBjKL2ebCTlpaSjGJY+IdshP8PaqAhTY8UyzqXPGnhIaOuxUNxOK
         RDFpjVgxSEDBsH9YPVs02Cy0/P0vfAwzNgsxcf9Xn+2W3HjVtCUTtCE+Pp3T67TjasN+
         3n2UaPqex9s84+7a0oyzLCniotjDskhbNFhU4nc8CQQ/6enPBEB21fz6lbBgDQWBtr0+
         mbrw==
X-Forwarded-Encrypted: i=1; AFNElJ/CBBVs/jq+1CeBPoxKhW/8K9DWavatSuKwVARiTq77v5mRx/mR8FGclKj2q8C00VpTblNelFHjCaN7J9VKXZUP@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcbTsBuVDabiVflufJWEtyKQV6qMq5u6mpyCaHxJlmgnovp/8
	1XJj+kMNRbeAuaX9If3vR0D4DrhK1y4cQ1Ex5KmdNcPD+kjsl8Gc1209SYwi98zfiOst/T2B/Hd
	fz6AEzyY2RVOB08yrgLDD7Kfao1hM10H/cnkKUIvC
X-Gm-Gg: Acq92OHPlc76TbLyeUrQRqwyx64prci0oXVw9orgdf6IcXrn5tBZveVkg2bn6lF43OZ
	RSFK59O2gJ0IjytJMPVvOwIfxlPNthXSUGBJ8ZbQlI5V1OpQnYn6lnPZOxdJCYcHK3dc9jWBbIv
	2Q5cjpJA4LcQeK6DhDW1NWeYePzccS7VZXuGuo1KDY7rei2JJKi6ZbIQoyeDoEGlsv7AnjiHBjv
	TOSSe52/DUk4qhUUVHAj/xvGu6oWUeJEziCBda8roaHGvZRCrHsrOrEOEybY0NQ/tZj8gPoadP4
	lQGzPzqu8JSdm8bDdXVrY+nyz8iJK9NCgWnZ
X-Received: by 2002:a17:902:eccf:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2c69a34e6f2mr53355ad.13.1781543832443; Mon, 15 Jun 2026
 10:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-11-acme@kernel.org>
In-Reply-To: <20260612222413.40791-11-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:17:00 -0700
X-Gm-Features: AVVi8CfHrpLu7EpqcrpqpaYsdrK8ihZflEmYXUayOYdEx4y-mcF93CrOYQFbh8I
Message-ID: <CAP-5=fWUZQ8XKsWHL-i81y1+oBX3VyP90CRsR5O4orDUEqWBGQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] perf bpf: Reject oversized BPF metadata events that
 truncate header.size
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Blake Jones <blakejones@google.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> bpf_metadata_alloc() computes event_size from the number of BPF metadata
> variables and stores it in header.size, which is __u16.  With 204 or
> more .rodata variables prefixed "bpf_metadata_", event_size exceeds
> 65535 and silently truncates.
>
> The truncated header.size causes synthesize_perf_record_bpf_metadata()
> to allocate a buffer sized by the truncated value, then memcpy the full
> event data into it =E2=80=94 a heap buffer overflow.
>
> Add a check that event_size fits in __u16 before proceeding.  BPF
> programs with that many metadata variables are exotic enough that
> silently dropping the metadata is acceptable.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: ab38e84ba9a80581 ("perf record: collect BPF metadata from existing=
 BPF programs")
> Cc: Blake Jones <blakejones@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf-event.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index fe6fbca508c5135c..57d53ba848359e12 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -369,6 +369,15 @@ static struct bpf_metadata *bpf_metadata_alloc(__u32=
 nr_prog_tags,
>
>         event_size =3D sizeof(metadata->event->bpf_metadata) +
>             nr_variables * sizeof(metadata->event->bpf_metadata.entries[0=
]);
> +       /*
> +        * header.size is __u16.  synthesize_perf_record_bpf_metadata()
> +        * adds machine->id_hdr_size (up to ~64 bytes) after this, so
> +        * leave headroom to prevent the final size from wrapping.
> +        */
> +       if (event_size > UINT16_MAX - 256) {
> +               bpf_metadata_free(metadata);
> +               return NULL;
> +       }
>         metadata->event =3D zalloc(event_size);
>         if (!metadata->event) {
>                 bpf_metadata_free(metadata);
> --
> 2.54.0
>
