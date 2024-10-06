Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C7184F
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Oct 2024 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728173198; cv=none; b=biRbHpnMbB8rRDSqqwGK3utdGU/YGu+buqe8vwB+2gSYK5NnUBWuGvqVBrEYRzl9+v0hbTYSh80hgRCPxNaC3rB6gvvlT+uAY+mmuNgOwSmFwP7Cys4/072gISJ2cZBvb+wgH/uFgST+e8KQJJao6J5Jgf2a6MbWSMTONWLhdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728173198; c=relaxed/simple;
	bh=7PhV7mSmrjXdm322I5AhDI6uiC32DXT2Ek81VrbJ7rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVdHlZAVJdD7ejw8ZdK/SFYrCGClxBpAi9q0jsHLtuXVlJNgnjHMhJPwfQnpkxqQ2X8ZiaGrBwnc+qHftQAJNrnxnVF8nuywXG6i+9PoxzGcBOYXwjyRg6a9c2Wdmgnhw3+PZDs3efwrZ5qrpdgZzhw6f/Wabnz/HZIIxjFRG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XAohLs7h; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XAohLs7h"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a993302fa02so129343566b.0
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728173195; x=1728777995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwWtZnU6O3CUnR/7Ge8+NpuQOrJwSLSqT8+8zcDG8JI=;
        b=XAohLs7hwRZz98IaPh4Q1tIFM26yhJH4A/sdPLoySvUfTh8rD0wWZDy1w5By3Y09pu
         hqYrnGxxW/nMeeBTCuj739dL4JFnJsQsJRmkE8SN2wFjoq9IZDl3h7RQKEc/s/tRSvsk
         mmanNeF7iPNfc9oNJSNGmlTOdmA54ANDMD45g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728173195; x=1728777995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwWtZnU6O3CUnR/7Ge8+NpuQOrJwSLSqT8+8zcDG8JI=;
        b=AN65Expfdn0NbEFZedCG7HIInBfFhVKlzif+DiRwzkqZd+cYNBDH3mBqHecf62oqX2
         fztK61VpmPlPEfmAu433jI5RKysxVagZiuetXPsh8yv/VtGhMi5Xn1XfMdADtgPAwT4R
         8mpPo3239VLpDjwyOg9DrhalvV9Vg9AL824D2EKckKzXKc4+AFp10Hbdh0uYKsHYniaN
         9YnGNOL4vAc4dD7WQD7wnzNJa7NkpBche6ea4Jt2yyLKLXONf9hdF4/OYMKy6XKl7CYI
         WyZ0atvSPLEs4DLb5/gICDyQlXOI/5n8S3I+mqdsdg7bsybugmcGOq8Ks77pEPSzaKz4
         cmnw==
X-Forwarded-Encrypted: i=1; AJvYcCVzkXc3XV1iAyyMt+qCHU83oxrC3Pq1lavLZQXtdpdM6XEvN+57PSSjjiAgPhwS/aMtToz91AqIVihe9VpzvztS@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfTNvRQHNmWF4cXuoDDTDiUd1+sk2KnaKYhS9RlqnsrjFMnLE
	f+F6c9Pc2AGHBlWABKRdaaJDiNXpr1PPaNO3v5U1M0zXhaBCeYml0Gk+dEUAPDjSV+OtYQOvLas
	SM+og5A==
X-Google-Smtp-Source: AGHT+IG3P+YFci/aX7BXvNJWhgcrw/lH4VmfNUHdTCKL8s88Ozo9KefxTPOIXlMKlat4BWpK8/fmqA==
X-Received: by 2002:a17:907:9484:b0:a8d:35cf:85f6 with SMTP id a640c23a62f3a-a991c00ededmr769269266b.57.1728173195281;
        Sat, 05 Oct 2024 17:06:35 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994c2cca71sm27435666b.119.2024.10.05.17.06.34
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 17:06:34 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a993f6916daso94656466b.1
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 17:06:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF+7vo15OA5Uo463Q5KOIyAB0MnViHzvjM2IaCZtlqnWHfw3E1jE4aGqM6LaHCQAjawm1S5nLTQw6m897rpK73@vger.kernel.org
X-Received: by 2002:a17:907:9693:b0:a99:3d93:c8bc with SMTP id
 a640c23a62f3a-a993d93cc22mr339286866b.13.1728172818387; Sat, 05 Oct 2024
 17:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
 <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
In-Reply-To: <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 17:00:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
Message-ID: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 16:37, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Sadly, that is not correct; neither gcc nor clang uses lea:

Looking around, this may be intentional. At least according to Agner,
several cores do better at "mov immediate" compared to "lea".

Eg a RIP-relative LEA on Zen 2 gets a throughput of two per cycle, but
a "MOV r,i" gets four. That got fixed in Zen 3 and later, but
apparently Intel had similar issues (Ivy Bridge: 1 LEA per cycle, vs 3
"mov i,r". Haswell is 1:4).

Of course, Agner's tables are good, but not necessarily always the
whole story. There are other instruction tables on the internet (eg
uops.info) with possibly more info.

And in reality, I would expect it to be a complete non-issue with any
OoO engine and real code, because you are very seldom ALU limited
particularly when there aren't any data dependencies.

But a RIP-relative LEA does seem to put a *bit* more pressure on the
core resources, so the compilers are may be right to pick a "mov".

               Linus
