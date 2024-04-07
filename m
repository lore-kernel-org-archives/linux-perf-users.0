Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302471E889
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Apr 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517055; cv=none; b=GVLaJ01N0ivwK1GyQT6e8ChyCGvnlSKcrTRhp1T6NBcO0V0l3vsBNrEFdrQHtEg21FlCmK7iE4d66Qa7XTD6osueRbUkG641jMbtotHyD/uH5dODXERGpL+gjfwwpwf9UKc14AYceUqL70GVUbRtigMWsctTtZMMJeK9OY+k5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517055; c=relaxed/simple;
	bh=70HHBEd6cxrXlLkgbwjfvu3LYrWt/mT4YkQDDZ2MPi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKO+uU1sg1ZjopsIBD7QWydAENv2Zvhwf33210yTAZiwv2pac52A3u6zongRSlLr+fnFhbzQ3XF/1+IK/oupqNZ1eVDGFVFnxLWniSN23yfB6M/+bB+AWQYG5QbQf4J7vrIj0Bus83u1f1XF0KIEXzKkImYO6Osz5IaeZWhKeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twdFLsYO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twdFLsYO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e062f3a47bso123675ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Apr 2024 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712517053; x=1713121853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6EUWLXyMd/QrPrA543Vnpb+tkAZZfWHn9rSEQeDI00=;
        b=twdFLsYOYbDEG5VMd/NJt3yra0CScuu6rLvDlvzD0/UcM3ccsSLLWrFRme5S+Qw4tc
         4AY8PNP5cS4iwCjKeWSUZvUbK4MwXP6J37sY0+2ec0UvZFPji/4xxe/VoNNkX6mhwJLC
         hu1+sVaI9v8ro30Kh9TSdyJCvVyrAnB4tSZd6oDpmHx+P1UgL64ssFvTGjV6VdDe3Bwl
         NIIrwkY261Swzjqh5E3Jxh64m+RJzck+Y3HdCqlFgX+7BqC7cVE8eB5tnujEwkgKkqEG
         wOJ+UEfcVumZZ8F5KdDvPayNoa3ekqecmz9NsZiJeQ4n/MsY3l99qQ8MMohBqtBzuUby
         QHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712517053; x=1713121853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6EUWLXyMd/QrPrA543Vnpb+tkAZZfWHn9rSEQeDI00=;
        b=d7tCgro0iuYyT/UKUYrF3IayGNzXpxUWymKYV7SL9I+JsutYGHOZ1uTr1/NjFcWFZN
         L4coc7ZcZ7fLhfRid+FGSu2fpdbJUrKyEdD+vHWj/la85HGh+RlWVF63dN950ZMQ8nb7
         t/0bmuQhnxgk/wGKtLEoHSsniEIdc8MtXMci2IbBGFK/3PUjHIrw0xTCeWjTlvgJlWqm
         wWtJ/NF4wGeys2tHZ2mxbzUIre5BviF/fFzDjVtXgQb521dadztMagMfs8jlklZVqgJj
         0Vf2PjPDeFBjExh4SXDdIkBLRvHWxaZFttmX7CMjYL/sHI7CEzqcqNX1tTbAsYFxy0+Q
         21IA==
X-Forwarded-Encrypted: i=1; AJvYcCWiUhKE6jrAWA+UIaCirl7OT4KK5pJR5xzO5iBCcCUlGB34h+3T2ZTCOt8Oyu2jb9iylELEk10uOZLcFER7d6+7Maqsuqk5dKNAEx8eQ66Ukg==
X-Gm-Message-State: AOJu0YyfYpqm6xyIY/Npp8fzzgF/H/yPldPUpCIf45bZvbR3Bae9rG57
	QkhaalKX+qFhITL2MwYKS7fIUa37gh0I8crmXIutMtNohtewNbjMP0QzpRX1VKQPeqJ3yOhRkcy
	tPGlBD9vItuRMqBgG8Lb/cFc44TlT7unsyBtG
X-Google-Smtp-Source: AGHT+IF3K6r9xbBJkilZy6HGKb6dlLXRf6FqatUAZbCIWOQ+wDqVm5LXVF61yEKWVnLToUGV3EtmibzNbcvolpkp1/g=
X-Received: by 2002:a17:903:32c9:b0:1e3:c1a9:ed7e with SMTP id
 i9-20020a17090332c900b001e3c1a9ed7emr176673plr.25.1712517053266; Sun, 07 Apr
 2024 12:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406164727.577914-1-visitorckw@gmail.com> <20240406164727.577914-10-visitorckw@gmail.com>
In-Reply-To: <20240406164727.577914-10-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Apr 2024 12:10:42 -0700
Message-ID: <CAP-5=fWb3eNe3mufRJjPAc=jcHFiHYpPqLuK2H8YiijHu0rLZw@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] lib min_heap: Add min_heap_sift_up()
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
> Add min_heap_sift_up() to sift up the element at index 'idx' in the
> heap.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 9391f7cc9da9..201f59cb3558 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -111,6 +111,26 @@ void __min_heapify(min_heap_char *heap, int pos, siz=
e_t elem_size,
>  #define min_heapify(_heap, _pos, _func, _args) \
>         __min_heapify((min_heap_char *)_heap, _pos, __minheap_obj_size(_h=
eap), _func, _args)
>
> +/* Sift up ith element from the heap, O(log2(nr)). */
> +static __always_inline
> +void __min_heap_sift_up(min_heap_char *heap, size_t elem_size, size_t id=
x,
> +               const struct min_heap_callbacks *func, void *args)
> +{
> +       void *data =3D heap->data;
> +       size_t parent;
> +
> +       while (idx) {
> +               parent =3D (idx - 1) / 2;
> +               if (func->less(data + parent * elem_size, data + idx * el=
em_size, args))
> +                       break;
> +               func->swp(data + parent * elem_size, data + idx * elem_si=
ze, args);
> +               idx =3D parent;
> +       }
> +}
> +
> +#define min_heap_sift_up(_heap, _idx, _func, _args)    \
> +       __min_heap_sift_up((min_heap_char *)_heap, __minheap_obj_size(_he=
ap), _idx, _func, _args)
> +
>  /* Floyd's approach to heapification that is O(nr). */
>  static __always_inline
>  void __min_heapify_all(min_heap_char *heap, size_t elem_size,
> --
> 2.34.1
>
