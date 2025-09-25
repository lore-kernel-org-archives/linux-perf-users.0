Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F331E111
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829131; cv=none; b=oMsSAJv6OYUoK9GoOkdOnsKBFZny2dSK0Puq9M2qRKduX5/+aTmLd4zGkWd3xad9uF6dWaQ6OjvVOFegnVl9v9M7STQ0leM/6cQ2iHwJ1C853TgU+6VakH27i1Cei5K8zj/XHFJFYFqmBujVxi5UXQDDue70dgzT4uD9plZXgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829131; c=relaxed/simple;
	bh=MdI2AHIvRAIXfAa0D0cIiFe+/emKPsfH4wCzSWvwGLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDfeCfFG/2Yzi1kaumW1OzTO9xNtT52c94Wjyv+qskQBFwrifYTwJ75w/Ef4ajnS9+9xBjq6vhGXFEKutAnKLTC0lVrr7qUWo83WhXflDqccEpNrl3KDguCDoFsBYoB1W3vzlTnzrxbPiv+8Cc1STu/Al0DqrNzoYNStCQryMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoGGZRSY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoGGZRSY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so51335ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758829128; x=1759433928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmXLeoRNYxQ/q9eeZjkA7V0DrLfH4gyiTpN84frRQQg=;
        b=LoGGZRSYBfrpzhI7/tkXFKICfNLL3tJ3rGrnGl234J45k77luqdswaH4VrL0njMdOe
         iYwRhkjHRyL+M9wAbBD2t/8NB3QwOzAQkUrBKV4pWYIwtJ4+ard6h8NEyb3i8OtlkNvk
         1J26wmYZ6x4OETcYT/UQW9FsOX8rBGlPFpVA/+RIEse091Ho0VFIavvlmtLYSmjb9A7k
         XANFRwhIbz8XWlKeE5vFIHq6EGoIuWq+qKAruXOEtxjjqR+Act6CRDiXxbsHuHTH/KtA
         /F3RdI1kyEcL5UB5KYW6sMR0fSxOvBD1M6HsrA6Q6SBEDJNQmKcl3mN/vXlIPJECKmoA
         vhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829128; x=1759433928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmXLeoRNYxQ/q9eeZjkA7V0DrLfH4gyiTpN84frRQQg=;
        b=oTcqDsmY6hKUgfm0gd0AfcPN+CUQJP5ondglBRiiUgnnM+5Ll4Oox0t6Vroq+iPgcS
         BhDpytQ007EWsUgxftfNgm/HJ9es1VBKx0M+f9jyBjJJQ5quCOGMjjqgVXYFBsWGbWve
         K3j+1jzBM/xlTirthe46ZTBdB+cTQLZG1yU6oS0ioAZQ8GZyIQP5PDvwsSZ1zQRRbfTi
         AU4McbQNWBDbE32KutzQoeW3iqxMqrO2Aun1QL0Q/B9Q3M5ZDjcxT/idMKQ1cQi438iX
         L4Ukp8P+hEWBCygJ4n47BTIDy3DbtBaSVfAEdRdus8ubzw/mb4w1HkeXbb4id4URAav+
         sdCA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5CdMuRENiw29uoFqhfUnYFKNFutxknh7GQoFC+rsWatN9mxxKT+mfUB6chs3qHegCqZTYg+Q9Uru+8s9BVgi@vger.kernel.org
X-Gm-Message-State: AOJu0YxoftvB8bY0+QzbUy/AcIjTBfpJK5HDAEnVatC+IIVGwbIXwJhX
	IK/eQVz6HHhp40ePG9Kbl8Fb/88Rvi1MFFXrUwHsooe8Gm1vBeck7CtujfW9t6SYbQto5+vPGaH
	a+9s/eMb1m0xyiTRfpQaTRr3GahqNVDernw710pG8
X-Gm-Gg: ASbGncsfqjzNsm6vIWvLCkRUwrVNC7wJ1jbvINaVZSA4NJgLzN+YXEioZwtV3wScX/z
	z/blfFphFiuPYjqsi/XGtwZdd7WhzB1r//WPEXldwvKHqjGiy7oIZi09HGhRYTnKMREy9rR1I97
	e0sbxJF2ZEw5MdXd24DtAlqDIdGSM1FaFQxy/+GMv8LN97bRkb0Xtxa2vPE1Eu895qGG5gn9T4i
	zW/OAUC2PQRqm5lbEpEvrPPU5E8U8kFkjI/WDzEfg==
X-Google-Smtp-Source: AGHT+IHlWDsv5W+Cnz3QpzSjCLsjC6JqkFfJnw0PQrGoFuGfCPLIcdnOMx84aEiFui77lbyr4nxAshVX71wahiIYeqA=
X-Received: by 2002:a17:903:4b46:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-27eecd5abf5mr876475ad.6.1758829127934; Thu, 25 Sep 2025
 12:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com> <20250925-perf_build_android_ndk-v1-4-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-4-8b35aadde3dc@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Sep 2025 12:38:36 -0700
X-Gm-Features: AS18NWArHaslRBdqbnMECGDnT24X9gvQ1wcAN-wPei7OArHIVhWE7ff1fDEiDAU
Message-ID: <CAP-5=fWGKgXV52_9E7n9yDX1uNLF8qWT9XTFK8eKtc_LRCW5wg@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf test coresight: Dismiss clang warning for memcpy thread
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Quentin Monnet <qmo@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:26=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> clang-18.1.3 on Ubuntu 24.04.2 reports warning:
>
>   memcpy_thread.c:30:1: warning: non-void function does not return a valu=
e in all control paths [-Wreturn-type]
>      30 | }
>         | ^
>
> Dismiss the warning with returning NULL from the thread function.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

lgtm, should this be moved into being a perf test workload as in
tools/perf/tests/workloads/ ?
There doesn't seem to be anything overly arch specific in the test and
being a workload avoids a cc dependency in the test, as well as
meaning we test with our usual compiler flags, etc.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread=
.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> index 5f886cd09e6b3a62b5690dade94f1f8cae3279d2..7e879217be30a86431989dbf1=
f36d2134ef259cc 100644
> --- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> +++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> @@ -27,6 +27,8 @@ static void *thrfn(void *arg)
>         }
>         for (i =3D 0; i < len; i++)
>                 memcpy(dst, src, a->size * 1024);
> +
> +       return NULL;
>  }
>
>  static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>
> --
> 2.34.1
>
