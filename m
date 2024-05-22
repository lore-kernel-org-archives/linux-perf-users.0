Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6182B9C3;
	Wed, 22 May 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398840; cv=none; b=CgmdfmxnsV42fmXUTCwthQ7aAQYfxGmxtbPGZTulSsM2A76kAVJfQgHRjrrYD7q0JSJfL8GefvDTgfXDN4m0YBg9VNYG3/0JjQggFwZc7F2/kQ3yleZcBGQPsIHYB+4YDqNqAULIdiI8AeSdaUZD8tYDU/R3IYnjwMrnB662TA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398840; c=relaxed/simple;
	bh=isyLFE4nn9JkPj3yuYJLcuNMQfnvsjEH3eMkyQFFqJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDPH0wZYEiHzjnzCmsNL/JE32HBq/59Ra0XaTXnbVuQejw7lXD/ucyq7vHQiaA3HOE4JQAy2LlxwvZxxG2YtrB2buWKYbdyLdJve0Mh4ZGMpVe3SoER3zK/mn3pJnMcEwh3oAEZxJ6kEG3ZUl37Cl786jZ39RWHuqzgmzUt/6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f6bddf57f6so1865449b3a.0;
        Wed, 22 May 2024 10:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398838; x=1717003638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6RZqGC/IieWl5jEMbER/7byAZJN8EBKfaX/pw1gzjI=;
        b=I7ytUdy7XtBHVAeRNEHcPDcrSXQG7gIWDYxva+XB0qqpXv6wDi6SmyqItIIKJzSs4P
         a7RhOwr2U9Don2NyldSA+qG/rG33/HpATEHshcpUhnQjpW67STabglsnJS2l25Xyn0IC
         wZDH6HecZvtNkFMRxAAZ4d4lW2u4WPKNanBhH8/XNP6l+dYgNpQCNYcdnpVg5ID2bQRc
         RgftFha9NvUKa25iva1dWIkffatKTuQmXd1tSAZyhaGapJUvDqZfJq+JeqALW5aVhH4r
         PT7zePdLR48qJ0YPg/Xl/euD80PMY5AeRhVsTa1xqXm5g0AGfG7WJyZrUNoAj9y/O/Hy
         NFVg==
X-Forwarded-Encrypted: i=1; AJvYcCXT41XD81lBWYxbgCYemG/wGT7DoDSzgcpqPRvnwXYrxoWTcSU8eDLaOk35vrWv/LTfLgmPnEVgGOvj5s5mpPRPMQStYmxFhWHDoXux5lVAIxgH31zKh9oUzl69wd+buT4Rb8GsphO+g8shksSIfg==
X-Gm-Message-State: AOJu0Yz7QTDaqo8bhBw2YjsrLis/C99KAIy+vX+OnqTPNEVAAi3u58A4
	hsdcooXrQNmCjhRfewAA71JGfN1wc8jaQb3ZrRcw39fQAUi7yB97YKmqCav3mY7Q7gO54w+QSbc
	yIPxn6NtQNr75QAv+lqc+MorbUg8=
X-Google-Smtp-Source: AGHT+IH388lysTpiWY9ZpiHOtOthmG/5+kBxu8TK1z21CE5unFX2giv7x8Pxm6u55KapP2L9XGL01sjIoWN23mXp7OI=
X-Received: by 2002:a17:90a:df10:b0:2ad:e004:76e6 with SMTP id
 98e67ed59e1d1-2bd9f456db5mr2800809a91.7.1716398838039; Wed, 22 May 2024
 10:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520083048.322863-1-sesse@google.com>
In-Reply-To: <20240520083048.322863-1-sesse@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 10:27:06 -0700
Message-ID: <CAM9d7cgBZVfur8S3QC2woUA2C6O3Dme0YHP8PbFcwc_o0k-dWg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks a lot for the patches!

On Mon, May 20, 2024 at 1:31=E2=80=AFAM Steinar H. Gunderson <sesse@google.=
com> wrote:
>
> In addition to the existing support for libbfd and calling out to
> an external addr2line command, add support for using libllvm directly.
> This is both faster than libbfd, and can be enabled in distro builds
> (the LLVM license has an explicit provision for GPLv2 compatibility).
> Thus, it is set as the primary choice if available.
>
> As an example, running perf report on a medium-size profile with
> DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
> libbfd, 153 seconds with external llvm-addr2line, and I got tired
> and aborted the test after waiting for 55 minutes with external
> bfd addr2line (which is the default for perf as compiled by distributions
> today). Evidently, for this case, the bfd addr2line process needs
> 18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
> hits the 1-second timeout and gets killed during initialization,
> getting restarted anew every time. Having an in-process addr2line
> makes this much more robust.
>
> As future extensions, libllvm can be used in many other places where
> we currently use libbfd or other libraries:
>
>  - Symbol enumeration (in particular, for PE binaries).
>  - Demangling (including non-Itanium demangling, e.g. Microsoft
>    or Rust).
>  - Disassembling (perf annotate).

I think it should support other DWARF use cases like
unwinding and type info?

>
> However, these are much less pressing; most people don't profile
> PE binaries, and perf has non-bfd paths for ELF. The same with
> demangling; the default _cxa_demangle path works fine for most
> users. Disassembling is coming in a later patch in the series;
> however do note that while bfd objdump can be slow on large binaries,
> it is possible to use --objdump=3Dllvm-objdump to get the speed benefits.

I remember bfd objdump is sometimes faster than llvm-objdump
especially when no line numbers are requested IIRC.


> (It appears LLVM-based demangling is very simple, should we want
> that.)
>
> Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.

Anyway, nice work.  Maybe we can implement other use cases
using LLVM and reduce the dependencies.

Thanks,
Namhyung

>
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
