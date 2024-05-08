Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AB1E89A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211653; cv=none; b=ED8XDcAY8W4D9ZqE4+Z13TVAxll1Lar3/2OyXSrv42V/cvLjXA4ElbnUeyr9qPIJWnJYNslQb460IoaPf30eHug8tynVUB5L7s3lsgC701a2leW3/eIsHC+8msKFyEBDAlzu8zTzmSdoPX2dbH+k3E//C8YfZEFd6T0Z2eg9ygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211653; c=relaxed/simple;
	bh=KwT+okHPi+W6VidpPKXRKh3Wp+ViBEdA4IHjwz/sFCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jsn62mrH03ZGgFnvqSRDdPSgYrxLAQlyqVuKkL3Q7i3pSjgtoAKjA8cl2B5C9oTzwwNfghzV7xq4bqRo886pUHs1+MtbiIlLilRsvW2qq+e0M9InIdG5YlJl4JBO6jTiI3gOOX6s8i0cPKQ0az2ZRa7baNE/CV8/MshkVpHrbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qi6LoIzC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qi6LoIzC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eed90a926fso62355ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715211651; x=1715816451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtBaK54I/OmT+ZzA/0tf7fwuvPPu1s0eLKsDcEO5LUU=;
        b=qi6LoIzCLq4SeYGvdiLFo91UPUgRc8VAjgYHRryxc7qIKku1C2lali1ZIXsdD6qFZ3
         kORy//kvHgYzx3VxXGWEX4oL9R4q8HBjrdO1e24gX8/DFAr57pfv28tjhn3EEJdyCORs
         3W5Zsjp2phod1fw0TkFLV+nOgcDwySyRng+lA6w2q36HbFnZZIne3EHE/4yTccKCJ0a/
         DnBuQ6lAfOPMnC4IoTQKdy1v78B/CXQuGBUzvZZlJ9VS3+T2GAtPMeyyH6logM9s6avI
         FoiKlQp8f4mjFh84v3w1F7DtNZctwT148nf0QYCoPmWOOnVMPn8wShJEngoIyx0eHjHP
         5TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211651; x=1715816451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtBaK54I/OmT+ZzA/0tf7fwuvPPu1s0eLKsDcEO5LUU=;
        b=NhB+cwLK/WrtZzfsU1DYOaGaZKzQDBL6KXay06jy7ylLiqF10Slk770fq3kbQ8I38j
         fTojFPFG/RhV7+6kmm+2I7Pk0NY6fRmCjPk26bfayjlLgn1AkQLlL+m+tFWNZkJ25b5q
         oTN41S0VyrTC1348Uj+y70uXVN7ZtRchutzajK0QDN8iqAEB1lYKrKHyneppyq2aEemn
         3c+BzJDAXRoCRt+KbVHb0x0HZx5qM41Gcvh3q7IL65KR6orQkjWPAVeZwApNf+jhK7GJ
         QIw/70AuDGP79p6WiDSkmW+P0Lj/cNdmizpt6AmEXLg6Rvu5M6PnxNiTghgigQBi7Y81
         +iRg==
X-Forwarded-Encrypted: i=1; AJvYcCX3qwA6Ci3PLFKCJaZvex3W3PgYoi1wGFWtb5eP6FQEotLdWmfJ2mPc2VXVH87fMO8f/PwbzHF5/HiBaYfX8D0955T2dnVfwzxljNmNfIsnBg==
X-Gm-Message-State: AOJu0YwNrU0l9fZIFd9Rid76c4GBs0ETXqj7Z5Mf4GL8GK0sdGqBkKcT
	qkGxt7aMH5gV0qXZVhjEuffqi7vSS2HvNGMuOg9nDNuhlOaWoKFSh0DkjRzr7LdLUKC+as9bN9A
	CuPBrnOcJZQUn6XOv+GNC6VkuOJWaxZyNq4bY
X-Google-Smtp-Source: AGHT+IE9rtUIKw/slmUwrF8lW9b8vFSRydp6eE79h5ko9MZ8atWirNMl5J/gF4jU3omSX5ix5Yu8yH27Id/RF3iiyMM=
X-Received: by 2002:a17:902:f605:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1ef005fa6fbmr1062665ad.12.1715211651249; Wed, 08 May 2024
 16:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zjmc5EiN6zmWZj4r@x1>
In-Reply-To: <Zjmc5EiN6zmWZj4r@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 16:40:40 -0700
Message-ID: <CAP-5=fV3T6G29Hrg3fGRnenjxUMjVfPK-zFGQgp9UgJn1JBA9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf kwork: Use zfree() to avoid possibly accessing
 dangling pointers
To: arnaldo.melo@gmail.com
Cc: Yang Jihong <yangjihong1@huawei.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:15=E2=80=AFPM <arnaldo.melo@gmail.com> wrote:
>
> When freeing a->b it is good practice to set a->b to NULL using
> zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
> pointer is kept somewhere, we can more quickly cause a segfault if some
> code tries to use a->b.
>
> Convert one such case in the 'perf kwork' codebase.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-kwork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 0092b9b39611d7e9..56e3f3a5e03a2d66 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2230,7 +2230,7 @@ static int perf_kwork__top(struct perf_kwork *kwork=
)
>         perf_kwork__top_report(kwork);
>
>  out:
> -       free(kwork->top_stat.cpus_runtime);
> +       zfree(&kwork->top_stat.cpus_runtime);
>         return ret;
>  }
>
> --
> 2.44.0
>
