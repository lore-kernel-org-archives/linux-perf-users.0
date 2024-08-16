Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495726AC3
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777855; cv=none; b=FjCq85Tb8qQVZzq2za++L1TPfQlnQn2l9tt8undnxmqn6KgTTkjhzWD5jzPIVUjz2miZtTCnBjC3qs7VYP+LNq7hPssHUB6fI0oN7mK5Oq9PVMmYkmi4NSFH7A/GBZlGJOgZWOzGR2ye94b1KlpJmdq6IDf3Bk1R39Ds3z6Sqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777855; c=relaxed/simple;
	bh=pDkx8ngnUQRjIclWtfWHA39LO7XC/50Owe9Vmjxe8yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEXorpf29Wv/l5vz/cFwD3f5OrIEdbtL8hJegEv3kG8ejZYAF7jwnBXqMA5ljxVfYY3jf9ZYNha8Xtjc3qRlIDYnsyXAeYKiwcqpSJ3mWAizilinMEZDXemalACy0JUTueOdreHOXkrU8I6RjzBiJgdmjaXukl9vRTrmNlrVE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29V0ypQP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29V0ypQP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201fed75b38so29115ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 20:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723777853; x=1724382653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TksdukPAgZv3CISxfFNPNoWEfe+SnBkoBwJZG9NR5no=;
        b=29V0ypQPCK02vMOCwAzezmndAahVmclJuzQG1OmBOhVmjS8EBVVzfwYQf0RdHlgRvN
         H8a/8ruoukofjP4KKcpEF3uAGOsOw9rBUGav8O20xX7/7aMr1AbB6jn1S+q208UMCcYk
         27CCwjzweIKNvsyzX8KTgaIxH0f8uaCBtGZeAyeGESg+moO566xjbxaUkOXa7glYz7fE
         sreGy/cUPP15OVdQ6yGvergZ4jZ/46cSwcP8+BdMH+kEty5smDS/2zHCUmq9IosTnS2c
         vzVH0IpkZ2/JDfds8f6a8T559YPQ9VjXWHT6YqVf5wIL8NOrOWzo6SotO7Tpan9gKJos
         Tlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723777853; x=1724382653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TksdukPAgZv3CISxfFNPNoWEfe+SnBkoBwJZG9NR5no=;
        b=t4th+m0zFppbpbMLSGu19FZG2xFcQhPyH3dvb4L6dCGS218PKkejTBmUkrTazTQkk+
         cW/vFSYreQ335gsRMcYmQ7PTTBkxKHGOhjLjyAIjszShvEYUlFLnWJ/9yFLwSCfMEoZr
         RADzv7f+z9vhrU/DCQJOw7Gda9XAR+l4AJoOC1ZkqqJd1H5EmqPh1smqrLo0rM9ZJLKM
         tNxgnMMGgNndXQ/RKwOs8AR3TD0eVLYp4IfaJykA5vKTl9a9/RDy5KwCj00QR2ohHNq1
         rjP0yTidxWIz1iONqLON7+t/ikLf2Bje7Il5NdKXXb5H3yb1ywJdJlTG3mMz6s/nlV30
         dyNw==
X-Forwarded-Encrypted: i=1; AJvYcCXirOg1DVaNCb8c6YTYQCmYcklS1czxIhw0hC2xxGSk1auHPyRus0ezhj+ZQGkHofCnfEz4d94H7WtKTuuVLBnY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuk27jzvp+2Hnw5txUwOrpdM5Jm0RV6y3S4Wwg9vumA+0TmliJ
	ObtIwWthT8tDbt+ndm3Bk4J6YK66l34+TR5DsVrJQUs3L6Fc3hneZkNG7t9zyN/1TC8NYW/s27T
	zHiu+skBc8AOi9hYHsyhYGzGFOxSexPwl9nNm
X-Google-Smtp-Source: AGHT+IGZLeBKv3CMMAwWol2fV8fxptjq88r8Yrtm01DrODCf8SauDZd7ISG+PN303isiBbUK4suCZa1K107RgC107lI=
X-Received: by 2002:a17:902:e5d0:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-2020600ae4dmr794735ad.12.1723777852732; Thu, 15 Aug 2024
 20:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815142212.3834625-1-matt@readmodwrite.com>
In-Reply-To: <20240815142212.3834625-1-matt@readmodwrite.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 20:10:40 -0700
Message-ID: <CAP-5=fU4Lv76Yv5HdhPZz4woZuZ-WMemEC3vGpKJgKhwqrE_rg@mail.gmail.com>
Subject: Re: [PATCH] perf hist: Update hist symbol when updating maps
To: Matt Fleming <matt@readmodwrite.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kernel-team@cloudflare.com, 
	Namhyung Kim <namhyung@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 7:22=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> AddressSanitizer found a use-after-free bug in the symbol code which
> manifested as perf top segfaulting.
>
>   =3D=3D1238389=3D=3DERROR: AddressSanitizer: heap-use-after-free on addr=
ess 0x60b00c48844b at pc 0x5650d8035961 bp 0x7f751aaecc90 sp 0x7f751aaecc80
>   READ of size 1 at 0x60b00c48844b thread T193
>       #0 0x5650d8035960 in _sort__sym_cmp util/sort.c:310
>       #1 0x5650d8043744 in hist_entry__cmp util/hist.c:1286
>       #2 0x5650d8043951 in hists__findnew_entry util/hist.c:614
>       #3 0x5650d804568f in __hists__add_entry util/hist.c:754
>       #4 0x5650d8045bf9 in hists__add_entry util/hist.c:772
>       #5 0x5650d8045df1 in iter_add_single_normal_entry util/hist.c:997
>       #6 0x5650d8043326 in hist_entry_iter__add util/hist.c:1242
>       #7 0x5650d7ceeefe in perf_event__process_sample /home/matt/src/linu=
x/tools/perf/builtin-top.c:845
>       #8 0x5650d7ceeefe in deliver_event /home/matt/src/linux/tools/perf/=
builtin-top.c:1208
>       #9 0x5650d7fdb51b in do_flush util/ordered-events.c:245
>       #10 0x5650d7fdb51b in __ordered_events__flush util/ordered-events.c=
:324
>       #11 0x5650d7ced743 in process_thread /home/matt/src/linux/tools/per=
f/builtin-top.c:1120
>       #12 0x7f757ef1f133 in start_thread nptl/pthread_create.c:442
>       #13 0x7f757ef9f7db in clone3 ../sysdeps/unix/sysv/linux/x86_64/clon=
e3.S:81
>
> When updating hist maps it's also necessary to update the hist symbol
> reference because the old one gets freed in map__put().
>
> While this bug was probably introduced with 5c24b67aae72 ("perf tools:
> Replace map->referenced & maps->removed_maps with map->refcnt"), the
> symbol objects were leaked until c087e9480cf3 ("perf machine: Fix
> refcount usage when processing PERF_RECORD_KSYMBOL") was merged so the
> bug was masked.
>
> Fixes: c087e9480cf3 ("perf machine: Fix refcount usage when processing PE=
RF_RECORD_KSYMBOL")
> Signed-off-by: Matt Fleming (Cloudflare) <matt@readmodwrite.com>
> Reported-by: Yunzhao Li <yunzhao@cloudflare.com>
> Cc: stable@vger.kernel.org # v5.13+
> ---
>  tools/perf/util/hist.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0f554febf9a1..0f9ce2ee2c31 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -639,6 +639,11 @@ static struct hist_entry *hists__findnew_entry(struc=
t hists *hists,
>                          * the history counter to increment.
>                          */
>                         if (he->ms.map !=3D entry->ms.map) {
> +                               if (he->ms.sym) {
> +                                       u64 addr =3D he->ms.sym->start;

nit: we normally put a newline between a variable and the first
non-variable line of code.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +                                       he->ms.sym =3D map__find_symbol(e=
ntry->ms.map, addr);
> +                               }
> +
>                                 map__put(he->ms.map);
>                                 he->ms.map =3D map__get(entry->ms.map);
>                         }
> --
> 2.34.1
>
