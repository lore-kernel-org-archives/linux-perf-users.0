Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5803DB630
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956357; cv=pass; b=MK+XEzrthF0CXv2j51vnQOz2yC/7TqFb0uA/ViSFm3k5lklPqzYiUxB3QBi6chBbt+ouIt9ZHbXgaIBXnE2h6RQEf1TVROydRLYug7d9qODsYWP4HFr4D2+79JeaKqNbhLvgjmpr70xXhM1vr2tZzP06YAIgdJWNMrx+oe1mkIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956357; c=relaxed/simple;
	bh=FEkGRoQetSCJjp2RP6SZagIXQ+219RPkBUNbdwu/uYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUB3dY3oGRARYQPWH1HgMK7PmsXmL6/oMoXpJnydHdX7FvphfesQu87RttiWuHL04kxjuO6rlzuuso/2wZtV2sejGCYc+TlgaiuALkCQmhYi0/HS9vLSwaifv2TLNKCRTsUe0mhqdcCoJ4bVcT7KHxZ2IrBxyHxK4l3D8Z3itio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdEgIVzv; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdEgIVzv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10e86e52so41981cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 11:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956355; cv=none;
        d=google.com; s=arc-20260327;
        b=IJTYhtj4DgVA1EJuy0p05glFgnHDecSqBCxv2jkWG14HVGp4pdbns/GL4nSAJwGkLq
         pZRuI1eIVeuho1SM9NOZ2Cl8ZeqXIBLjpBn4VvDJ3p2or4KzuzgEqGHFKTPQGa96grSf
         UtTsglsdGHeTD0ArmLVY+KjRVyarJ3XLSMwQbKOA1pwKWOJ04A9hJNZ/subGJIAIbAE3
         mcGDSJgnxnsqEDqEpdmAAQ0ZN9EVjsdlPnCYJ50EnxuB8YAl6IAJic/le6mLoH7ABzsJ
         CXhTVyr8giAtujuzIH62rVjuwoZkUrdqawiMi/KmjLYZ6Vs3B9Jcs5dRKudnCE2ivyqQ
         QNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qlxfLXrxRYKkQ834/BUlQBxgx0s8w6RXQKm3MPt1F6o=;
        fh=3NDtMM1hJZ2FT8Xu0CsLCZ29pizyCG5oBbfb7DD0QFE=;
        b=nTVw35KJlSPD3ZS3yEwG7bMFbol36PN5l825YLyhui9eOTKZ2wa4PLTKsRhX632QC0
         YvbYlpD6LP8R5SkP3Rb9lXWw9VF+KtO1QNgYoWzLZ6J/aJbf7RgKerMsRRaAuIg7zg1m
         iggh5OV1xeyPJ5V7ZcT2I3Lvl6oaq2aanUward6MSrk+auwdfyc7RXN+ESzECLHNzOOC
         L4buCQ/z4qC7MZ1mLmtOtg0Kwla2UmkpEt6V0hWWG74WZEXlEHN7OTfyCLR5DyyWR+l1
         8ftmuvefpxKgUrP4Z6p0advFx9UYF7kuc1fB3FR99L7z92mbSXYOvMqMHAROYwVqBYzK
         T22w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785956355; x=1786561155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qlxfLXrxRYKkQ834/BUlQBxgx0s8w6RXQKm3MPt1F6o=;
        b=NdEgIVzvkR57con5IA0Si2IfIKjci5XudSanU3Q9Ww+cChbR5pg+bPfGOujCmk94Qx
         3ylHIusUNxnciO5ygBeXYMCOl7fY3P8SQVGYEWgvx8xS8J7Kk40l/uiW4fxG6CEJr+JI
         Jdb3eiRaRQoBSiOYFKGJV9RrXJiQcv8WGhJxlA3fqY/KWvhfx6Dfpo9iZOHud7eOtAPr
         leRjpmVyAoTGlrfI1pPDbmqyChLCIsdsXgR1d1GPmTzlSOOLK78V/PpzuOvUmX1aENQG
         1dBJt/gI5Yg6nBEu8+vdRINRwnw2OHxuADMxaEKDit3EH8Kj6eyzdmJKzI9gs8sgSSmM
         1oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956355; x=1786561155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlxfLXrxRYKkQ834/BUlQBxgx0s8w6RXQKm3MPt1F6o=;
        b=iRsNcGMqvep4788tyn0k5qXDsD8F9vVNMV4XNam/A5/1nTyWDoAuGFL5kT5GlQSnzy
         50moYOS/6EXAEHnBfFmTek7lMGN9b23UmGlrcO1WQVxOiKLCy3giDaNb0x9692wll28s
         1DMc5/1Q6jIBsP8LIcKxVuWHW8qEs5X6/rZwOFU+SY2bY7Mj/aex1+n9GyRwH7YNH1rg
         gmIOB7w25DJ+8dgVKnRJzvO5D4JcstGE3rwh3+p54kBBcWAzcPY2cBXxrM8CU2QEcvh1
         SArXvaqIuqyRkILR/+Ii9S2FYK+Eabzl7RwR/oOGiCWIMCC9qsYQvSu/RRy738YcTxK9
         EVeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHByUyzwGtCwD+/ffb2ExMkck/CuhPo5JhSbpGg3c/IQcDY0x7tfIlQzDApejV0FfXYBGmi0cDK7QuE/mqZqj9@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeC7C+zU8kb+LfxjxOs1w8UPZepiQPjlltTzaYNHxqgUGD/Ks
	NUa/AGuToOw+fmE0BqOHLiOHs5P2AGyal4Nyt6tFNqoGDrPKzKC2JSGekeb6D1oSmzluYDXyccg
	dgo2667asspyTJ9zjvwkw9NRkttICxWO5exzy7evt
X-Gm-Gg: AR+sD10ixKmEzoY/jKhE/peX81dRt4v5EX59pjihYRW+pzyi4Qde8mqTD2iiOusS5Pi
	EKZux2SSL2PWS40aEflyfLjot/l5EuAk+USqKc5pNxqIAQlqsCdwsfzJZZLFTXe6D06KVvse1v1
	L4qWCNgEfH6ouqsfxE7q4Y+F/80AAz9fB6jjwKON9zRBd3ywrpAG/Ua5ziqlxlUDhCIo5kdGPRy
	GuMZ6m83ybwIBFHbJNjd9+tqfToOm3hVLHWGH/iDB3kp8tHGOZnzNJEkQ7/FijI4dvbl72qvl3a
	b+2uAHfW3M1RPKTlSEuNHAq83Mq5pAITzQ/jc9IKalj9dfRmPxbXN/oD
X-Received: by 2002:a05:622a:90a:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-52cfc137f24mr1790061cf.11.1785956354318; Wed, 05 Aug 2026
 11:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-4-acme@kernel.org>
In-Reply-To: <20260805133013.235016-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 11:59:02 -0700
X-Gm-Features: AUfX_mxLaH5WSmrDZNeijv54tM49IFltAE6TFUCGf0uB2C1QtZbTzte0wOWYvtM
Message-ID: <CAP-5=fXSEFmmVf7iU_gBFpO=S8psEL9k0cf3qQhGoDJSrdUKXw@mail.gmail.com>
Subject: Re: [PATCH 03/12] perf jitdump: Prevent integer underflow in debug
 info size calculation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>, 
	Stefano Sanfilippo <ssanfilippo@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_debug_info() and jit_repipe_unwinding_info() compute payload
> sizes by subtracting the fixed header size from total_size:
>
>   sz =3D jr->prefix.total_size - sizeof(jr->info);
>
> When total_size is smaller than the header struct (from a truncated or
> corrupted jitdump record), the subtraction underflows to a massive
> value, causing an oversized allocation followed by an OOB memcpy.
>
> Validate that total_size covers at least the fixed header before the
> subtraction in both functions.
>
> Fixes: 598b7c6919c7 ("perf jit: add source line info support")
> Fixes: 0284fecd13b6 ("perf jit: Add unwinding support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 3195f94187164066..787f8a03dae87908 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -669,6 +669,10 @@ static int jit_repipe_debug_info(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>         if (!(jd && jr))
>                 return -1;
>
> +       /* total_size must cover at least the fixed header */
> +       if (jr->prefix.total_size < sizeof(jr->info))
> +               return -1;
> +
>         sz  =3D jr->prefix.total_size - sizeof(jr->info);
>         data =3D malloc(sz);
>         if (!data)
> @@ -696,6 +700,10 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, u=
nion jr_entry *jr)
>         if (!(jd && jr))
>                 return -1;
>
> +       /* total_size must cover at least the fixed header */
> +       if (jr->prefix.total_size < sizeof(jr->unwinding))
> +               return -1;
> +
>         unwinding_data_size  =3D jr->prefix.total_size - sizeof(jr->unwin=
ding);
>         unwinding_data =3D malloc(unwinding_data_size);
>         if (!unwinding_data)
> --
> 2.55.0
>
