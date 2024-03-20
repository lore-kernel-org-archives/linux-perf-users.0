Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C969E16
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954922; cv=none; b=WrlVJc9AnJ0vGcQnse60nMYjN4ISdmSN8+Wjn2PPTuLmUFwnKqocveJWGAYaC+4aDYmsn67U9nZ8M38fur71Mp2+ZWsNYUGOkjDXEbuuX7BV++zGNf1c5PH2bk1jfmOezcFWnF4rJ5XATc+HRLhDx5DorJ/GeDDBW15FSpR+GiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954922; c=relaxed/simple;
	bh=XgLLe/0HidMplx5GiFezhsQrFnXrNoWbzeUa4QSU3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9jA/ibWOFSi2j2BqzO3yxOWz7QRi6az/QiH8LZaZZ48Y/Vu9OuhIEVGkGCZPLZcoY2IY0Pm9XNYXKRwIIPjVszROOoikMDXbDmcb/yP3CXGsnWgg8GHbnjDPOdSCpKK7LoOkBQuSUUz6/LWrdx/FeeK/iPzzx+6gjuZVIyp2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR69oNWA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR69oNWA"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1deddb82b43so8885ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710954920; x=1711559720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIp5RcXnXJ7qPYcrKHILUGb2p95lzF1Zlt+aRd98e2s=;
        b=pR69oNWAtkN+GiSMjWpsJnAJ72L/JqDjqlcqvtEKFJxR1JKCfVsKNCJS9ybu+cHC7Y
         hFnpoIkFoYFyiJpys7mnlZsgrHHVCDOeZ9hoZdlQvDNBne19YdrfTNqscdjsaZWdN+Ez
         1HptVFHo0/jvY8kfl+yNSj/7PiXCuNUsUdp5IgrS4BEWb11su4friYTSbsOiyaU+n6q3
         FBOj8wN6Tjy0uD3Tqcu05aztGo9MCs+TVM1SEaOo1m5BjfXqs641D/4atLLpVB0v0Bem
         GkkfymRISyVahaFYVB4PvATpEn6nnNkwQpHPCal8QyUMq+ZJs/eP9fYIHPFX+Ef+zZ1K
         oNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954920; x=1711559720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIp5RcXnXJ7qPYcrKHILUGb2p95lzF1Zlt+aRd98e2s=;
        b=tk+Ib7m1Ma+3DcTQmni/RyfdvEVWUZXOSX9OM/t48sQggQX7H1JNcZx7uVrKhxAT9+
         V7SLWEaYFW9nQcz8yDTke6Ey9BOdv4qkR/qOmejW1B/GE0GVSTulAk+/M02Mq/okYLjD
         nJGoZObt3MyaQFPe/SoluSCnMpkhRL8Y0CbSmVpmgPEhsxniZQug5Qqsd6DB27bguWqE
         KS1wXwsVFg1QtQrasAxYH88PrFb/2wnDi5FjzWcXgvtYALGGk2YuhrfOKcnK8/SHLL2C
         ReHgnGtaYZ8E3obWOWZxJ/jdH2KGdjqF/CuRICu8z9rvefdbJAsnH/aoTTxle6n4mIAs
         m70g==
X-Forwarded-Encrypted: i=1; AJvYcCWcsH2UwUT8QcSt+2nqUXmMYzfDzz2HyUhQC+iXgYUFB1QbnOAQZvYEJIYGLd/cabGIsjuf/JYXgGY7G3F73cuRpvz8tm52K5s0wzfvC6W4jQ==
X-Gm-Message-State: AOJu0Yy/6iGOfrjR2sEJrLnJUie3q8cUgkrMfQzw0dWfY6hfhCk6z6sj
	1+pyfFEYMbfQ9P0oASZ9gHQaqqxq32miaePhuWp+AkKQx8tekZiFrnZGvHLyvBl8Ie3W0PXFRkW
	Zsv5MB6dxTB0PNB9kYnpur0elRDV6hFyTn0Pt
X-Google-Smtp-Source: AGHT+IGD/YlWW3iEs0IrRWmm6hXwC9f92VNOJhCPilELzQoK/i7dejWld8froyLEaz/lQCnkq961NX8v3FntamPL7Gw=
X-Received: by 2002:a17:902:e74d:b0:1dd:9e99:f6b2 with SMTP id
 p13-20020a170902e74d00b001dd9e99f6b2mr306294plf.20.1710954919511; Wed, 20 Mar
 2024 10:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320145417.336208-1-visitorckw@gmail.com> <20240320145417.336208-10-visitorckw@gmail.com>
In-Reply-To: <20240320145417.336208-10-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 10:15:08 -0700
Message-ID: <CAP-5=fWAF33f+RnaXNQd6NNJUr=UQzNGAEo_-G07CD5q8Xmrow@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] lib min_heap: Add min_heap_sift_up()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, dm-devel@lists.linux.dev, 
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 7:55=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Add min_heap_sift_up() to sift up the element at index 'idx' in the
> heap.

Thanks, should min_heap_push be updated to use this sift up rather
than its inline version?

Ian

> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  include/linux/min_heap.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 36023e0be232..af12531474a4 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -194,6 +194,26 @@ void __min_heap_push(struct __min_heap *heap, const =
void *element, size_t elem_s
>  #define min_heap_push(_heap, _element, _func)  \
>         __min_heap_push(&(_heap)->heap, _element, __minheap_obj_size(_hea=
p), _func)
>
> +/* Sift up ith element from the heap, O(log2(nr)). */
> +static __always_inline
> +void __min_heap_sift_up(struct __min_heap *heap, size_t elem_size, size_=
t idx,
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
> +       __min_heap_sift_up(&(_heap)->heap, __minheap_obj_size(_heap), _id=
x, _func, _args)
> +
>  /* Remove ith element from the heap, O(log2(nr)). */
>  static __always_inline
>  bool __min_heap_del(struct __min_heap *heap, size_t elem_size, size_t id=
x,
> --
> 2.34.1
>
