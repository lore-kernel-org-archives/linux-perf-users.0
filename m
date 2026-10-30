Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793376082;
	b=Cn8ir1x6y549UmoHX2evDK4ucpzRjWD+U1Nw7BSOlP3mxzPz1/xh73FpMlOXkTAc+CQx
	 Q8KvOeuApwDq05twAuYfCHD2G+W5Ddj81UMj1oTkiaypeisQWzKiNr3JdtOudappsGHx2
	 EOnIrfT/MqrUMULUVgheNrr1gfhOLPe4bzTaqogCbo1wX4YQQo30mX93Y5KQaQLZV4BwR
	 zSd4KfGedlmbhxcUcY1PbnQTyJEnNNW8sOYQSyvySEuW/vdFzgE0rgt4VQgP8qwVdyaYq
	 SI/38N+SykuJoFKZc0J6Xj6f6z59+gA8sP7grbjHaW2IvavhPzqrVVJKVeR8oGtNjPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o/+lnKpZS8UOplQCz0t2aWM1C9+hCFPPGrsM343ScB8=;
	b=EHR/j2HSL2LvvCY3sxjWxueGThAuUYrBZSWfQhRm0znzLHwvXZ+beE3zf9d27hqYm4gQ
	 NNl2CP9OdFIJu8lszM+hOBwmYlVmI5i03sM8MflNpZ7B5VMAJvCOA6/ifP+x66CqqOq+U
	 k0BtP7WLChB70aceeUCCr7em81SUJdBWjR31Ahm31/ftHpYXR3J+lIzf/EvyNRqooYsDa
	 LG7pGcnzcawA8y5POS2qYG/HnXsiP9xKKzL52oVvvqv75c/scXs75gjBZB/moU9XBzajH
	 5RIb8eYsSsKEu0O2oSGccsDYj6PmiP2UQOnpSR8JZEKv/dyMqdV1IJigHPDdFXX6DBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DdVpOj+U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9F606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 16:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB9F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DdVpOj+U
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337c7b9937so355301cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 09:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793376081; cv=none;
        d=google.com; s=arc-20260327;
        b=EDBNwAgBzuXwwu6067wQN0I0woWfIvQXrR2hlxl+xWSULv1vT9yQPcsDfgSlQvbmqo
         kjgM2999JcIhgmizzpdrF9XtBoPrqhz8wxI/7KbYzc/vRKtAGgwzqZqeAsZwckamIPfr
         67glPXe6JCyVANC8SuZnlDj84DwVpa7skM6Z7gFoe/Su6e6SwgDcNYkq6PJLwqWJmQ+J
         XHyeoIgJ81NbSKjhFlcF0+WLrlg3QZd7Vtg5nucfL8fSUAlzm5fb24N+bLMsNWUGBj6/
         J5Emw11NTPJIs95aaeXS1eO9py9gt3ikTLqZAUzxmAlXL5Gdk3OiUanhzQyzki/Sy/GH
         4K5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o/+lnKpZS8UOplQCz0t2aWM1C9+hCFPPGrsM343ScB8=;
        fh=opAmms6jqPZcpAMCiS+/mKgfuWG4JtfM2Jo96thiX/8=;
        b=HnEhJEi4v6TzMGg/5lfKyxMKDb5USbbOhaxnlrXHDnfkPndxZZ4rw8d9zJd7B6GGlq
         4zDqmtMaDJHrwvOBNiAJfx4EOr3kHFaI3h9dkhn1zPe4XVU9mA/1mbSB7OF2NlKQnR6e
         NuQSg5W6u/GJdzqpRH4zzZyd1XyY5CFkXtVTuii9dnqV66pyQcMepKB0yDP2Zp8efe9c
         OE8Cja4ghrjXjxx6eIVW7/TjxZBJO/dZjqdOB+pacI7XPMMSNL2jWG6hRQo5PxqMFSxX
         FEwcplWWHVI6ORALUldWR0lQ0htlQKCiQBzgQXUZbUER6obTC/yfVkr4jR5eIaGNQ/66
         YhWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793376081; x=1793980881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o/+lnKpZS8UOplQCz0t2aWM1C9+hCFPPGrsM343ScB8=;
        b=DdVpOj+UcZY2Ucue4kSHwhXkoHV1K6ECGDJIYP6NeL2tZomqO9uf3VixD2XdhZATcJ
         /8+qKFa+k4YUOx9y8tIzk/Pr8xAIjSbNU9IDIfR9qZTIsgfqNrQv/WwYfzEgVt0p0aP7
         BRtL+QQ7QLLqBTrFgXnX/xTtA8wda/dKHj6EjF7mssh15y12jN2FA5nXKYbd5zTiF5aD
         OUS6VvCLSzbxDN3Ccu7FqvHMMjYIkNHRjtS28MtI8xWlfI2Hif9Con9n8cPI2KlpM7mX
         oVPcO0YhaJYzOtoM2hAf3q11e5YCdDyiTUouY92sXgzCPu3hOj+C2uxUgmI2Pk/2Veng
         9fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793376081; x=1793980881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/+lnKpZS8UOplQCz0t2aWM1C9+hCFPPGrsM343ScB8=;
        b=ZpSEuzPs+L5eSH8CIu8OT2YLOfQxDGtoszSYATCZDfugkwyia7qufBI4ez/iGPvYIz
         OGoRR++2zL8eyijGLheWQt7w5oRzlo4pCg6+tcBWkTp53VIMOJDYTWrhaswmnt8pn+Cv
         zC0q7d6oNb87XC2cB0b8o8dvrj1rd+p+6OT9lDgthW7w0VPceg+6M8AMP4DDOq5FXjdj
         cnMx+x1cuR/IPfgJycoNBScttfNrM2ft3suW+AH8qulQzVM7Hzg9P2w4O/fZIivboeI6
         vOksqxF/SJFnWNkGlh0US+0/ffSIv909xWvNkp641B1bP2w/BB+OhmtkZJIqqtEMocVr
         37VA==
X-Forwarded-Encrypted: i=1; AKwUvBzcCHblwWUT565Powjis0VVqAc3aG6YwsNRC2oHvohObij1r/HSdABMaiZ8sfUvElDkD+GY9yplok0CB1OZFlVR@vger.kernel.org
X-Gm-Message-State: AFq9FYKcId86j0wlCC8fQzaurxwe6CHEpML+uLaTgmLlbcmfsZGy1Lo5
	3U4f5PjoE6ftiAQZ9SVxmlIp8Wc299B76jeb+Wc13Zjhy8B1Vo2wxUJn9aYge9WTip/GWhgm6YI
	1EnNxqfhTMBgCo5a75Ga3ojehcHJHqPDki4jGvAOS
X-Gm-Gg: AYBFou2HOa1qaBkaRT4S/wGiOhvW3iYMJwO1m8O/FSxAauHjLYhstkIGb9jI/K83k4Y
	SOaH9EI19Oxj3nMPvaqDjX43Y4IjPLepPilDLscIMEH/aYnM3IfVx/bCtQ6arukwi6Z5y/sIyvi
	DVPvlwMxTQ82QR2IoMDe0oMeDgMsw4TMtsiZgVjLAMw7glrTUaeh5NYfqmsfyJIFB1T6U1jsM4V
	C2Q3+xeR32iCkxRauxEmoy/Va2Pq66zdYVl7C/OqL5KeP6oNK788ee7I07vdaWLJ7RqC6pKsp8D
	VqfMd+lLyGsacUsoQpEtJvFyJVbc498uvz3SqkPguO+397eBPGUuJYanRfhs3KjFnUSzkCqGLv8
	Lnwfh5PRjKs7ou/w+z21BGtBtt7XXzHUoohd9GkOVerwkvmzmtdUJ1OH6SOz1y/3HMiSHFSpMyy
	5vYML6GKIDdNXi
X-Received: by 2002:a05:622a:c01:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-5414efcb679mr42769651cf.12.1793376079865; Fri, 30 Oct 2026
 09:01:19 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com> <20261028-perf-symbol-memory-send-v6-5-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-5-7e90415f0101@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Oct 2026 09:01:07 -0700
X-Gm-Features: AclHuK_OjeqjZwBPO4snTGJFrMD46uy3rLYf52KHdKqpHrAUmO5Zup9dkdYM0mc
Message-ID: <CAP-5=fXFjno1Rrya6HBkBwBoSoa=68VFNUWXn32j9ehbR+9QkQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] perf test: Test lazy symbol name loading
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:42=E2=80=AFPM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> Add a "Lazy symbol loading" unit test suite:
>
> - "Duplicate selection without names" checks which pairs of symbols
>   symbol__choice_needs_names() leaves to their names.
> - "Lazy symbol names" looks up lazy symbols whose names take one, two
>   and three reads, and two whose names cannot be read: one with no NUL
>   before the end of the file and one past the end. Lookups do not
>   return those, and dso__sort_by_name() keeps them, named "[unknown]".
> - "Lazy symbol names loaded concurrently" looks up the same lazy
>   symbols, some of them with names that cannot be read, from several
>   threads while another walks them with dso__for_each_symbol(), and
>   checks every name.
> - "Lazy and eager symbol parity" loads a DSO (perf itself, or the one
>   given with --dso) eagerly and lazily. Lookups of the first and last
>   address of each eager symbol must find the same symbol before and
>   after every lazy name is loaded, and then the ranges and names of all
>   symbols must match.
>
> Run the parity test from a shell test on four hand-built binaries:
>
>   - a split-debuginfo binary whose function section is NOBITS in the
>     debug file and has no PT_LOAD in the runtime file, so both loaders
>     must fall back to the runtime section header;
>   - a shared library with symbols present only in .dynsym, one of them
>     an alias that duplicate selection prefers over its .symtab twin;
>   - a stripped shared library whose local symbols are in .gnu_debugdata,
>     one of them an alias of a .dynsym symbol, which must load eagerly;
>   - on x86_64, a binary with an IRELATIVE PLT slot whose IFUNC loses
>     duplicate selection to an alias that loses to another one in turn,
>     so the PLT symbol name depends on how the IFUNC mark is passed on.
>
> Add a perf script shell test for --lazy-load-symbols. Record a small
> callchain fixture, require evidence that the perf binary was loaded with
> lazy names, check that the controlled test_loop symbol resolves, and
> compare the eager and lazy output. When run as root, also profile perf
> in a private mount namespace whose build-id cache directory is hidden by
> a tmpfs, so that names must be read from the build-id cache in perf's
> own namespace. The test reports a skip only if neither case can run, for
> example when libelf is missing or recording is not supported.
>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Huge fan of testing, and Sashiko can be a pain about corner cases.
Thanks for working on this! I'm happy to add a tag when Sashiko is
more happy.

Ian
