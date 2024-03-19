Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3793D0D2
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878144; cv=none; b=PU78f0IotZ1GWhh6iX9muJflxRdrBXCmEZSmya3iXYmSeOTY4+HJmwi1r7JL4xQGq5nr/MIuATDqoWSZze+YI5XyTYkduENQvRwEQLm7fRaYFDiCq9QLUrkToXe6k4bnQrdPy6Mc3g8c18eReQHKYFocRYyzPmMAQa2ieK5NflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878144; c=relaxed/simple;
	bh=DkGbf8h4XzzoSDefJIAK6ZrPjFFLGxuGgr6Oo7HhzqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzjb27lxqazaCBV1cMTDbVeIlEXOJ2+355HNDAJPvFoBIlxEvY4LpGD3Fb0wSMl2JO/TA6oFRuK2bZsB9sQeLtKpXxCJAAuIQga9aJitb+kjB4nNFiqX8LN+FBa9QTFkP0QJMPOD9b6fBfXs2G3X8GqkdcB1Q/Q9B8n+WfEYbyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTqdAJz4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTqdAJz4"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dee917abd5so2045ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Mar 2024 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710878141; x=1711482941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9w8PbtBRrbzy6fT9pf26bGDWwtthxushM9+09GU4ck=;
        b=aTqdAJz4KiB1qXGNpPBgbzon3aawnRnbnK2ZHbrSWlfvt6n8QrL9tDJq1UVpGWm1gZ
         p13knzchUDQrTNO5pwKXZhg51g0Ta1aKy0UN4TyjhWiyf53vmC1d92S06uugiUs8qdsp
         Y1G0i8dLmY0Ai9PPXEXyej5wI2UJzYzyW6ywcUlKvZTwN2wX1qbGc4q+XV+00tdJMndH
         IjdpacweP2V9iLDT6v72IAcBZO4oQ/mVt3HgUBCIZM5B8zv77iV1GpnEb6AdC1dGrtrD
         5Bvx1hFNMA2P5bqG0IxaMuY0AsHKJcxUa3hnJEiqTSXuKNQZDc7e/WQk4jgpNm9+FYpQ
         vmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878141; x=1711482941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9w8PbtBRrbzy6fT9pf26bGDWwtthxushM9+09GU4ck=;
        b=sxUsBa19f3x7Zpa5NqOjSxavNhYcX8AeWUQgQnfLmH5vvfXRVQGl+adUP3oazBUla2
         DNAknnPRaFygwJDCtHxHIheYgWsG0syhqCkpGAm+wCMShr1kMvyg3asp/Y6oTRmau+CU
         75YF8c66bRSrthrzcqZ5xpRUeTAL7r5I9jlIEsErmQBJAD7iPiV/lA9EPUWFf7Gclv3M
         9RO9jTWCaKHq7hzVdC2q8x6qCUDmoSCdzEVXNDSEdU0ke0HTTBKrWFyhtzv3v1dljMe6
         9Uhsnz5tY13O6Ag4CxcNSnp+iPrv6DfhQWlG80eIDUbSVU9ZQG2RsBXzxxZUZSJrQ+a5
         kAbg==
X-Forwarded-Encrypted: i=1; AJvYcCV4PQqAuWzpfHPlV9FmnYv52YSFUM5UQ770Hmzkh62bFatS91qTw1citG5Qe2FNTWJOeBt7eWhlKqAjjPPlumfY+J/k4PdpOs0LEIrreIxmtw==
X-Gm-Message-State: AOJu0YxncmlXrDh+NtgpZTo3cobl4qmSvvwBzMoLdwh6J7nGNdXwr4n3
	79cybpzUGh7AlPjk5QTyw1VHOaSYvTbXTW5W+R6g82/Sw8gTC1mE2hD9yo8XEBnOIlE12WvRMAQ
	H9WK7WdkrpTAgPVdN/dFT+eB+PdD1l22Ywm4j
X-Google-Smtp-Source: AGHT+IEGUy1g0mPuJa2436aZVsiZ+B76HSfqTt+3t0AHeyPnbMCc8H9EBOuwBFiT8UXAddUXwVGhHA/iEbGm+uJBvGU=
X-Received: by 2002:a17:902:db01:b0:1dd:9e68:d2f3 with SMTP id
 m1-20020a170902db0100b001dd9e68d2f3mr66983plx.10.1710878140831; Tue, 19 Mar
 2024 12:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-8-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-8-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 12:55:29 -0700
Message-ID: <CAP-5=fVhEg25ntnWaEHzTKa7E+Y6aYQ+9NUXiftSpaQ29avcZA@mail.gmail.com>
Subject: Re: [PATCH 07/13] lib min_heap: Add min_heap_full()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Add min_heap_full() which returns a boolean value indicating whether
> the heap has reached its maximum capacity.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I see there's coverage of these functions caused by later changes.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 7c1fd1ddc71a..b1d874f4d536 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -66,6 +66,16 @@ void *__min_heap_peek(struct __min_heap *heap)
>  #define min_heap_peek(_heap)   \
>         (__minheap_cast(_heap) __min_heap_peek(&(_heap)->heap))
>
> +/* Check if the heap is full. */
> +static __always_inline
> +bool __min_heap_full(struct __min_heap *heap)
> +{
> +       return heap->nr =3D=3D heap->size;
> +}
> +
> +#define min_heap_full(_heap)   \
> +       __min_heap_full(&(_heap)->heap)
> +
>  /* Sift the element at pos down the heap. */
>  static __always_inline
>  void __min_heapify(struct __min_heap *heap, int pos, size_t elem_size,
> --
> 2.34.1
>
