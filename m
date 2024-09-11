Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123401AE84D;
	Wed, 11 Sep 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070186; cv=none; b=DeXKcwJQ7Y7PG6F1/fl6lFcdYXa+iUsUjCJg1bK8SZoRH4CY+CwgukVxm1voodMFDLiAH4n3NioydMsobfWT9Tj+xFwekUpMZs7E5woCJ7RaJMGAfJK1hDQS3+lVSIbEIfztv0XdkYPI4Q52v2/pA4qfNWDNMI2D8zIU3Y2AI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070186; c=relaxed/simple;
	bh=Dxod+zYmhRxDadQPuCZp+2EDvtcNQw3ZAxVfQZkt2TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/MN0jQa+u4M0WYRILAkLKa0eis8WFL6L97bdDtD2PR/mTvMQ5K8nWNP+G52RcrHUF1avcmLRKZ0wAiCFqs/58RdZgBrRhEBFbihGEOZPuWw4ts4QfUVUwfwTxKv8m6lOcopKZhsYPpMI4qV1iflpor0YhToTG8ZxZtwJkkMJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1P7TMwJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1P7TMwJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-717911ef035so5361037b3a.3;
        Wed, 11 Sep 2024 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070184; x=1726674984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jljrGYOdYNtWhSCPWEj0dAzhk8I277dPvpWRqGcz7w4=;
        b=P1P7TMwJZ6T0ZkWm7OTjWOFDcwqncJ4V8Ectj5JEY8XAsZsLqRrK78nCupo3QExeVq
         Z0749tIMh1kisLzJTxcjdGEzFQTSTFmn8wMr0NY8MtDzKd+K0ODxhmcEn/Ep+unuKKBW
         CxPJUwPidmVNi5ds/q+0tuJqwlyi9XhHO6A7ZhelyhgLGoKcCdnfOhPDOVfYLrHyAmG4
         GfWsT8ybLT/oWtCbmJEJZjhjHiHgrXUl+e/iDF6y+WWw+Hseu2SmRqGE8mTZG4+gWgHg
         EEjt4TumjXDhW3xlHoKA5PjQM+DK7eDGQ7crkDvP/mpd/qsB4B16Se8wPHczP0QvB99n
         pA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070184; x=1726674984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jljrGYOdYNtWhSCPWEj0dAzhk8I277dPvpWRqGcz7w4=;
        b=K6uICjBjk+oKNXh5EVUn7bOBvCNRgEqlwJon+zGcsGUW5wr+/rASR7n1gT9yQnDOEa
         Jrzel7YUXySnJuavz922h5PAAPKYCWrxWVz1HdmprAFmhFoyV5PWy5m9hahG1eCVmofa
         Be5m76yCkDwf9uCFrYRC4vm8fDqKMdvIFgCvrPX+QrDtNylZu1hOg6ZWbKmP0Uq+nkKX
         m5yHWlGizOX+YuhYrhpPxSJ64bLmxGBGklw3nbZW1CnOu4cbd/s0wV76Jfyg+EVz9Jb/
         85OHUc7ELzlq2XSQqLAXU2y9yDg8tAqnuvnfcYGZa08xf5k9an2YRzB0aYdW64hsw7E2
         aB9w==
X-Forwarded-Encrypted: i=1; AJvYcCUe/PrWpY2MEoBtNEKp6mrmp3/zH9qCKKLNQHVwFmzxmK4feiI0Fj9YQ/YzfMSi6mcJgqeGG+yiv15+iIc=@vger.kernel.org, AJvYcCX+p2BUsEjwcdvXs+R05wNIstNtX0FZnNzVw6hNQWdLGCI07FC6F+GDyRenZKHBRJoqNwHlnB8RBjZkrrrISOdN6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFVAx1u6NJw6YV813Q2ZvOErwbEfJUVdco0uKQWUJJvfU9S+T
	1PHJfQpTFCmC5HCL89NzpxHWA8v+wR/6Ucb9pYKyCrQ+bppcKn2R1ZkbxdfQUHZst0g+y4hTX3m
	6DuxuT9XtpId+hL1mL7pUbkaLCGk=
X-Google-Smtp-Source: AGHT+IGC7L1OFokQK9VoCCn4nPJx/6KFr122GwJ9dQE8hx9Mhb36sXjrE5JVsdVSMMQE0+6RpFj6xHYNV6lbGIOcOlo=
X-Received: by 2002:a05:6a21:1796:b0:1cf:3177:54 with SMTP id
 adf61e73a8af0-1cf5e176fbcmr6792708637.42.1726070184198; Wed, 11 Sep 2024
 08:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
In-Reply-To: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Wed, 11 Sep 2024 17:55:46 +0200
Message-ID: <CAHaCkmejAaxvx_N9L1_uS5JpToLfBXPzGqs3C=8-Diy__=1sJA@mail.gmail.com>
Subject: Re: [PATCH] tools: drop nonsensical -O6
To: Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Looks good to me.
Reviewed-by: Jesper Juhl <jesperjuhl76@gmail.com>

On Sun, 8 Sept 2024 at 20:47, Sam James <sam@gentoo.org> wrote:
>
> -O6 is very much not-a-thing. Really, this should've been dropped
> entirely in 49b3cd306e60b9d889c775cb2ebb709f80dd8ae9 instead of just
> passing it for not-Clang.
>
> Just collapse it down to -O3, instead of "-O6 unless Clang, in which case
> -O3".
>
> GCC interprets > -O3 as -O3. It doesn't even interpret > -O3 as -Ofast,
> which is a good thing, given -Ofast has specific (non-)requirements for
> code built using it. So, this does nothing except look a bit daft.
>
> Remove the silliness and also save a few lines in the Makefiles accordingly.
>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> I promise I'm not completely humourless, but given it's caused
> actual workarounds to be added for Clang, I don't think this is worth keeping.
>
> Plus it sort of propagates a silly myth that -O6 does anything.
>
>  tools/lib/api/Makefile     | 4 ----
>  tools/lib/subcmd/Makefile  | 4 +---
>  tools/lib/symbol/Makefile  | 4 ----
>  tools/perf/Makefile.config | 6 +-----
>  4 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index 044860ac1ed1c..7f6396087b467 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -31,11 +31,7 @@ CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
>  CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -fPIC
>
>  ifeq ($(DEBUG),0)
> -ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
> -else
> -  CFLAGS += -O6
> -endif
>  endif
>
>  ifeq ($(DEBUG),0)
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index b87213263a5e0..6717b82fc5876 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -38,10 +38,8 @@ endif
>
>  ifeq ($(DEBUG),1)
>    CFLAGS += -O0
> -else ifeq ($(CC_NO_CLANG), 0)
> -  CFLAGS += -O3
>  else
> -  CFLAGS += -O6
> +  CFLAGS += -O3
>  endif
>
>  # Treat warnings as errors unless directed not to
> diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
> index 13d43c6f92b4a..426b845edfacc 100644
> --- a/tools/lib/symbol/Makefile
> +++ b/tools/lib/symbol/Makefile
> @@ -31,11 +31,7 @@ CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
>  CFLAGS += -ggdb3 -Wall -Wextra -std=gnu11 -U_FORTIFY_SOURCE -fPIC
>
>  ifeq ($(DEBUG),0)
> -ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
> -else
> -  CFLAGS += -O6
> -endif
>  endif
>
>  ifeq ($(DEBUG),0)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fa679db61f622..5d6b08a896150 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -238,11 +238,7 @@ endif
>
>  ifeq ($(DEBUG),0)
>  CORE_CFLAGS += -DNDEBUG=1
> -ifeq ($(CC_NO_CLANG), 0)
> -  CORE_CFLAGS += -O3
> -else
> -  CORE_CFLAGS += -O6
> -endif
> +CORE_CFLAGS += -O3
>  else
>    CORE_CFLAGS += -g
>    CXXFLAGS += -g
> --
> 2.46.0
>
>
