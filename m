Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3441E889
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Apr 2024 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517105; cv=none; b=UyNbFHQD7cu3AeV9wgHXQyr5aPqkXPZ+df7+ZgDs3YheWy554VzSP2XklekB4cIDsSVDV4YA+iKj+h2HJk1nthP4w7M4ra43diuCcaVm4oBZllwpah7b8VggjF6j/HxrUCngpRUMc/vNP7U1Q7Pn9OQQlG7iyltTVCown3K9xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517105; c=relaxed/simple;
	bh=5+ZSDJ1c1wayZpu3rSXMMx/gAZAOYnaNUAMMmnOCKrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4/wv7jS/6u3/0zDKkVrpb3kwl+kGQitVYGwio1vF+I0fRAFEUplCoJmPgIQGCjsWmvj91WC4D+T2HjNvOS2HJwY4mCI5/DangGebfYZq/4qO2BSv2JG3WKjcVpMDCLJuKXYJVOMbFMb8QtxlU8Q987njWrgy1GJimX7TGnGHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTKLukDG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTKLukDG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43477091797so180991cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Apr 2024 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712517103; x=1713121903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNNV1iViAab2iT4F4Gl3z4rLSdw9SuHLMYt6mT0uMl8=;
        b=fTKLukDGInZUB+fsQg3YPRTy9oXDUyPs1odEsay87TmR44G9qLwV5fwCxW8PlEyG2Y
         xxKX4HFnnEuVrtKLHT08eRxP5YnDkCrvxVQH+7b0eQzRE1M4/SYlenlaZelQMDx2uazL
         Kk7L1AJrxRL7qbojiqeXd7NovGDD3p/RYwHg36+8pRP37sZihDp/AYO/Vk8Z8b92j4Z5
         QXGWDgi0gQFxTVm4Cyi250lvduGLxOir+fVLW611JuqGWYSUiWiqoVOmnn/aHAyylvLU
         jeGkQ2HZaRwUG4/MucAuXA2OqPh9h3HBgD+3/aftJNHbdihvEpV3RauE/trzj9uU1RLV
         sUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712517103; x=1713121903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNNV1iViAab2iT4F4Gl3z4rLSdw9SuHLMYt6mT0uMl8=;
        b=byDFMsarNXBgcyQcXOw+UjYU91kMwDjeBm3Vlm8VQzz/SXK0Mjf1HYLGvDXAEX3LgV
         s7TugXYykYr83DUJhirRU/H68kVzZz1tUYaBT9bIB2ZeACkSBr0dNWSqq/6jdWvUHiYT
         8yHT823YJwIVZ3+SPRHuOLHloA+/3siD9JvHm/vClju6B1EXKcZm9Br8VNWJnyE7g4VG
         ZDkGBmFmnfcMkwCm3jGCgKmzU0/HnvfWi1XaJzhdM5QguELnP8nBp9JXVpMMYsQxFV0B
         bU1mlQXaI/QYvgxIFjhi1BlYQC5xdZLFlWGXMcBonKPv6B15rKvQi0S6GWK5X7VnAreY
         kPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZbSy7iHD1ngwTrz1VFv0BhsSCGTqilzUbBdyTI9qBHuqZANORh8SMgT1YihyyeEjnEweIq4S3/JuGXsCe1YKK4lqpyyGPVScLwVPvY2cJvQ==
X-Gm-Message-State: AOJu0Yw2kdEOMTw4xZlbsL4tITlX79jZWyX7ECBP5Jr6dr2zA2bJgY25
	5UEQKUzLJ/Hvy/AHBQEFX4oOk/tgg+vIHAToTFR0desy+GFb4ZLYvAlj8+RPn8K2q8coel5msup
	j1vsDF7g29IdOVnEDXK7l7XYTynfg6HMe9+ah
X-Google-Smtp-Source: AGHT+IEbVQ6rh/yVlB3vPD78DUbrZCMUoVH6z6E9ojPzKJf/d8f7GOzVNi588miJW/ClBy/V8n3f5DvHgoDRclWzJ3s=
X-Received: by 2002:a05:622a:4812:b0:434:7bb9:f231 with SMTP id
 fb18-20020a05622a481200b004347bb9f231mr176338qtb.12.1712517103175; Sun, 07
 Apr 2024 12:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406164727.577914-1-visitorckw@gmail.com> <20240406164727.577914-14-visitorckw@gmail.com>
In-Reply-To: <20240406164727.577914-14-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Apr 2024 12:11:31 -0700
Message-ID: <CAP-5=fXYVBeT0Egypq8Ja4DMX=csWBhMoKuuz=WQxsd7iPBAxw@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] lib min_heap: Update min_heap_push() to use min_heap_sift_up()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:48=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
>
> Update min_heap_push() to use min_heap_sift_up() rather than its origin
> inline version.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 3086612d7cd5..fe037eb5952e 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -190,7 +190,6 @@ bool __min_heap_push(min_heap_char *heap, const void =
*element, size_t elem_size,
>                 const struct min_heap_callbacks *func, void *args)
>  {
>         void *data =3D heap->data;
> -       void *child, *parent;
>         int pos;
>
>         if (WARN_ONCE(heap->nr >=3D heap->size, "Pushing on a full heap")=
)
> @@ -202,13 +201,7 @@ bool __min_heap_push(min_heap_char *heap, const void=
 *element, size_t elem_size,
>         heap->nr++;
>
>         /* Sift child at pos up. */
> -       for (; pos > 0; pos =3D (pos - 1) / 2) {
> -               child =3D data + (pos * elem_size);
> -               parent =3D data + ((pos - 1) / 2) * elem_size;
> -               if (func->less(parent, child, args))
> -                       break;
> -               func->swp(parent, child, args);
> -       }
> +       __min_heap_sift_up(heap, elem_size, pos, func, args);
>
>         return true;
>  }
> --
> 2.34.1
>
