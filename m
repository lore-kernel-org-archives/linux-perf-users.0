Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698337F01A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241327; cv=none; b=alfMwuFIsTSK3X0Yn6sp6kK6N5UC/ZZ/57GxsKrL+Hu3H8YvHCU/+OnCnmNnxRFtFbPD8APU9Zq9R5or/xS+EB7f6XE2hBsRbNREU1KTyaoCG9O75eiqoltUdU3drIPOcv9Uai9wZAy8R/3qH/o6e6Qj8DcmmgBRBTFBVnLhB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241327; c=relaxed/simple;
	bh=r1wWp3fkGroNzonilrTra32HgiQ2QdWgSEZY8i4lHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+HyyW7LJy0r0YESEgNobv0gOKG0h4hukmCUZmwV3rJbfs1WckuxW8tP44QDJBB1q9z3NOajQU+kNOj2JMc/reMicj/Aqvdb0zB8Km+1rynCmhu8peaWYoPtpDyEctRxMo/2soxjOT0kPv6eK9NreTNzmCvP+IaQ3sSGzBIBo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yw80bGLh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yw80bGLh"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c07a6520cafso25943866b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782241324; x=1782846124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vd8Ajacj3WcVz59MGw2qxobP6f3/ObeBgGVFRheq8bc=;
        b=Yw80bGLhahyDMsvYf5zISXjj8kYP6XFN0YMZSOV8fQwvnBBUJxQKXTnLfhQXt0m3IR
         60JFVSGmwazzzf4J6ZDkAxmcWpVNPBCGn+BYoSWeuz6OosmVo7nGuCiA8oAbLltN7ujT
         NFdcZaWKJhXTvdxt5fmtyODx993Xsn6RKk9vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241324; x=1782846124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd8Ajacj3WcVz59MGw2qxobP6f3/ObeBgGVFRheq8bc=;
        b=kco7JJ6QMeM2Pvdr1sMI/4zPP3hI1LQFo2f4gRNWH4mKAxWnYTjwrEGFWi/qV9f7Vt
         CypEcbXpFqiP2RftvPjx9/SowGaSZrAkm9WQYH3hGB7O66D8QBT7BVkKjVX6T/KgTzVQ
         TQAHRPxZCJMo3H2sNfEq+Oox9545Wf2EGXLG123JxlL04UH30pwSLR9ULPja3nDbz+wQ
         OnSnVmsKeC9zAAnymxssZnfu8z/AnU+xodo3yCV9afKRNky+yR91jz1IUNXKg4GLUnqq
         32wc4Z460UDaZXZAY7HcVKqJeN+vRWnN2AP/qQYvSirViF/NplZ1IGAqrEWaik+9G/Ye
         6Faw==
X-Forwarded-Encrypted: i=1; AFNElJ958RnGSrUdN6EbffxIEYH01iT1NMT94/3In6xq2IMQaYdu+t8GIvydNxbIQ6EW64cqQ4xNDX8YabYQRAVNrTnk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uKG7bfDGeYBmcMjOamJZKeSg7yxRt2s94dYtIkTPLnnCq5fk
	yMUjSZ/JOKO08q8bCxbpJnqksQUdB4y5mrDENmIerS9s60FOOmODwwkK0FTC25MfX7Isl/Oh5Nn
	m40iFMnM=
X-Gm-Gg: AfdE7clGy0kbeqh5rN5YKazzpXe3MO3T+N6sUa+qRnx7c2C1NSSZ8Dobq096mjup74K
	Q71H23vI9Hph1s/wjDkNCuaQbo3DBGqUFtZMk67NxPQOKdvU8nJXn9wvxpj2sqWxBK5zkKnK4Ya
	/illX3DhGDHB+jN14to0IV4Zspt8adrXDsGb+WH2aoP43UAQ7sxBPu6nEyDdooiWsNaWt/klbVn
	eQ/9NYWPzjnZiOTzYOd/bFNuoC5d9XgOKU8hX9AjpbUru+N3tj57lFAuo1BrlE5c1uVsuQQl4FX
	G+Y8Hd4plD62rHaG3rYSIxjNrUNT4RiocyTaKZZKBC+ylH3yY3E4+kO52BGzNxd3fIq0nfO6eJX
	aKfLhF8lij3J7ggsTubziSsIz+siOKvlMgL1ra+rXaajav+QtoIrnzRNCvATfgAuRMgmeP9p2Qk
	1wANbQ/p+ERnFdqn4ac2MSbq6mFKiFbXqLVveQhTS3nWdbnVB3IwRQmIxyFPTNG8Hw82iQiPe4
X-Received: by 2002:a17:907:96ab:b0:c07:e025:1549 with SMTP id a640c23a62f3a-c0c643a9396mr897267166b.15.1782241323890;
        Tue, 23 Jun 2026 12:02:03 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac80c8sm544862166b.40.2026.06.23.12.02.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 12:02:03 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697ebe536b6so291986a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 12:02:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ//CPXdi3B+QpI2ArC6418FOIvVhf4W4GRYis2iyPGAPfmOK5kHwB4BTqDFsDAYolU3JDJLbPmJvLDmIhOrPc/A@vger.kernel.org
X-Received: by 2002:a17:907:c0f:b0:bfb:13b8:2ac4 with SMTP id
 a640c23a62f3a-c0c643a9322mr824454966b.13.1782241323191; Tue, 23 Jun 2026
 12:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622192158.12927-1-acme@kernel.org>
In-Reply-To: <20260622192158.12927-1-acme@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jun 2026 12:01:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=P369M9juK_Q8nzzTAFXy31BdizDeVFx1RTGGzaTXHw@mail.gmail.com>
X-Gm-Features: AVVi8CdS9FzJEpG7mUN6EQ_PQPXCsgxDGaaZDt8ZP4jeqUNcw2t0WqZ-huKeF1Q
Message-ID: <CAHk-=wh=P369M9juK_Q8nzzTAFXy31BdizDeVFx1RTGGzaTXHw@mail.gmail.com>
Subject: Re: [PATCHES 000/343] perf tools improvements and fixes for v7.2
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 12:22, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.2-1-2026-06-22

This may be pre-existing and I just happened to notice now:

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
        tools/perf/bench/bpf_skel/bench_uprobe.skel.h

that's after a plain build.

I've pulled this, but you need to be more careful and fix the
.gitignore files for generated content.

Not just because it pollutes "git status", but because we have a
history of people carelessly committing stuff they shouldn't, and then
there's even more cleanup required.

            Linus
