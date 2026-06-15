Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E152F413244
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543325; cv=pass; b=FC0cl0OsrazcvjP3mBsjxS8fwoU2v3q0Mfdob+DHX4WNNSExRaO93QBKeZSJz3XAf6GdCEdc1xetWoeq1lnMeRCMG1gBO9tEj6AlV24F22Nl97iwD/OSvOEfLQmASoUBux575X4YPcZt/+Z3u8nOrcyPHFcsKZDs0GZzllmcUuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543325; c=relaxed/simple;
	bh=vpMRjROsmvyVsk5PDbZXnNBKDfpK91rB8XVAGXCeD0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFVUMbFboh37s74HGGNnXdMsQpgyDDLsTMmK8RLkTnWamxxH13ejPKDdXTp+oWo0IzXgJVgytEeJDT7EAR1m0MubDi58NR30hJHgQXPWIGvpi+yr6L+K5zh3m45rW6WxUWT8Cjq0XSyJ70w2FPZ33RpZOo4aLz607gztLNShz88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvCIpnS6; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvCIpnS6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0b1a48855so3425ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543323; cv=none;
        d=google.com; s=arc-20240605;
        b=lQxb71WqxnVRQYj2EXHwfZHhL3Q9AfLZioIPYrvmJE58gRRUSX0h85TWjH72b/AgVI
         Sls4gwsGR8sXpOTfpry5gzXvWkETw2Kw5p8Q3wObTqjRRqmd9pW9UJ6BgYfOGwQO7DTg
         bCKTZklR47rBv6bD9qR45GZP1rj2ZVGbzlM/Fvv8DVGKuhNRkHBZDbedVShI9YbC2S1z
         blnPkGtArN7ttTSdqu+2RUo1iAe/LDD6cFpK9jU81JTqaea6Hvu25V0J6MwdKl0wvCy0
         5ZF2pOPAodbU7zDK4l1MRTMEkTqeXSEgB0T3LPkAOQaVwk7DPmwmB1AdvEj51wGCWXm5
         ar/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hRo3qHvIzeTwVFfj/toNv6rrQyFgWLgSt/UF0wIRUC4=;
        fh=hajCyDPHMAK4smWiqaiRNBzc6xvXy+HSIB04RXJkgz4=;
        b=k1L+6BF0hGarVcLTAil+yR+079VqxCxpYhegiCRWepFmjQxGT7qbf/MmA9Ek34zXaQ
         D6vwBEyCL0AIBSjHETW5obfBFRkCRVPSL+BIfzXgxoBPNc32ifjQgCXJT6rPxTOs+C/0
         31r0sd/Jq4kCw+nvJld2jbvVwU3XjaC68ujtUGJZZ6xTZLkuPfPjZG6Cf2QDx7R0o7dp
         E1QzQ8uSXHEUew9G4IIQvjwoHksMuBEbvkDkLdP9MY/ssJRhNXbOuIAuZHbu+e3TdB+G
         TtCyQmnDcbfyaDHNqgLrBSO99ksd1ME0gnMaIuZdAxhkjFGCx6TaR+25Y+YcKdRqM+UE
         G53A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543323; x=1782148123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRo3qHvIzeTwVFfj/toNv6rrQyFgWLgSt/UF0wIRUC4=;
        b=JvCIpnS6I51FJSfpQe1jR0DXjnXv3fbCFFIHxCGnH+4/pNQkB+30g+VLkCjsEqDeC3
         f9qnkaSARlBp/YofEtX/EoJ8QlIyxjvmgsrOlrz4jKQzFiQyBAbrdNVpDLY+jaF/vEns
         xVYGubYBPqq5yGXDfCxTCJcl/ZvsmpdORLjiCidhR7eWIyy6tY1g7d7uNqD505oSBTxN
         nAnlTgdJhX6o0LrAb3gufdjCD61f6+YzcbQa8ADRAQ6ValGkYdrl0OWjEtrOzRTZK6i0
         SgSad94wRkMJyY/fLpJ9lEJ4MrKG8SEv+NHCNxd/5fpmkLCrfuHY9xOnyuwHgF3YxodS
         n3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543323; x=1782148123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRo3qHvIzeTwVFfj/toNv6rrQyFgWLgSt/UF0wIRUC4=;
        b=cRRqzP+xhL/PId9ECD1gVSoCGJ/DjyDY9he57/5qc/sR4OzD7Dqi/2B64t26YZHyv1
         R5OZua6BuD3uLUSXyu5bjlC3PR+USDZXqmUnUsDjxvYN9Mj1dtuINaQ/abe9Ny8fO2C0
         xbuMhft08GBsQtKJxiIDjd232BkFK8vSAHlMc97Z680dzKvx50g/LfCFEAFka2YzvnRn
         6aVkmJP8h/ZjNNKKvRItZNA1miCpqj3HJhlYDAz7TpjUgteavv/CVF79sImoWo2O5hnI
         QytvgFOU8nwsq5uAFsZrMsiWLv8lklDSkVAx6hl83wg3+BQ8d7KNkj1sIAknQrqIsWGN
         J2lA==
X-Forwarded-Encrypted: i=1; AFNElJ/uzllwAmzeOmKimivclpRWqiu2sC4rJzTnX9o3ZvCEBjQg/5wIu/DTgFA6A1491Sr6kCXjfLClKcsv4u1zbugG@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaurI5nf6IFHJFTZv/9fKE0t5gC5g2SSfCq2zXK/g/TNFaXRm
	uDC8/NSQQTaKtdex4BDOl5GhEYYrLn8WNCgSdI+Sx4QqA5RfK3gOEv+LrCY4uj71CYQ9F8lH8nh
	AeQXCXgObF4WF/SpH1f3cQ9kbof7mm7yuwBjcR/Oi
X-Gm-Gg: Acq92OHtWWVOAsI79W/FRtRxp5y/kqS9PudVsxQnc9ZsdBu61rJydrwatHUwqFcfJK4
	neDyNzPoM+rKrO+8nCKvEi1/eL0kaI3xousXsA/jiHLuZXwigrCbV2yyeYAecsuw2u4hRiExmqE
	OzTP8DM5pZ5WRSjADGIptKjisXdVAbc9Xmco0b2c+xpIfj8q5b7wntDy28/Fki56AYEiEN5s5nJ
	YNxQYU1ih6aibW3jIds3KFS0Dtt45pR0WHq1XcRZgrUQ49FylgXiqCeBc2OBnQe1yLHn2zqQOHZ
	RdPLrFycKuzwIgaiCaueGAg+0RIaAp6h4bB+
X-Received: by 2002:a17:903:4b47:b0:2bf:3579:cdaa with SMTP id
 d9443c01a7336-2c69a2c716emr35195ad.10.1781543322662; Mon, 15 Jun 2026
 10:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-4-acme@kernel.org>
In-Reply-To: <20260612222413.40791-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:08:30 -0700
X-Gm-Features: AVVi8Cf38Sh5bBDqjXdD0R4plMw1SIDClyeobN8HZ22dxIsavYbgOKhXWWfkgwY
Message-ID: <CAP-5=fW46hfqMNPwyb9_Ai6fqqjJoMnwBtPkDfR3qV9kjqyAtQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] perf symbols: Break infinite loop on zero-filled
 notes in sysfs__read_build_id()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> sysfs__read_build_id() iterates ELF note headers from sysfs files in a
> while(1) loop.  If the file contains a zero-filled note header (both
> n_namesz and n_descsz are 0), the code computes n =3D namesz + descsz =3D=
 0
> and calls read(fd, bf, 0).  read() with count 0 returns 0, which
> matches the expected (ssize_t)n value, so the error check passes and
> the loop repeats =E2=80=94 reading the same zero bytes and spinning forev=
er.
>
> This can happen with corrupted or zero-padded sysfs pseudo-files.
>
> Add a check for n =3D=3D 0 before the read, since no valid ELF note has
> both name and description of zero length.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: f1617b40596cb341 ("perf symbols: Record the build_ids of kernel mo=
dules too")
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol-elf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index d84e2e031d430cf5..dc48e2d2763379b9 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -995,6 +995,9 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>                         } else {
>                                 n =3D namesz + descsz;
>                         }
> +                       /* no valid note has both namesz and descsz zero =
*/
> +                       if (n =3D=3D 0)
> +                               break;
>                         if (read(fd, bf, n) !=3D (ssize_t)n)
>                                 break;
>                 }
> --
> 2.54.0
>
