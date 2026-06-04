Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2443C3BEE
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606081; cv=pass; b=Baf88uJuNvf93ndSpITwU5CMbrsc0Bol8ghqFncAPVA4HivgXxxAY11crbfkliqa2aNAP1wfMati9nZIQ2tO4eGeB3peJi+FJXmttEV+OLlA83OlKiVDj+rpwzsp5Axtkbm7t6WCbCNj1ZPzZg8gCnsJZ+9YF7uCntJgVjvL2gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606081; c=relaxed/simple;
	bh=FXUJ39ArpIEdKOADEqs3qIS31ifM9DkxGZ29VaHn5Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKItAhu1qeH8AMAntjOKPwi80CH1OwgUtcoWIUf7XocCVHXzEzXTkN6PL6xN+Ar9XQtrZ33H2o9rRtpbQpJ5UTYA5sANmlKScBudbEJyq+esYDg1SlLHHkDVJOBunmIpPGBilXqCN5secodZGUHD1ll2jttHmxSv+anoA1Nupkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kujFNSa8; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kujFNSa8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2911f93cso10715ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 13:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780606080; cv=none;
        d=google.com; s=arc-20240605;
        b=LkSjVZFXwHCbYOceQGmkv7KFlr+7GUY815Oo19g/Ls3y51UJl7oKslZEUvAIPtHe8m
         ya1c+yo/J4eYuJzmgCku4ZnlPqMyKBeTRXqr8M+5Grv7559IKI/hJOm7d+bQ0OHf+pup
         4KoP/MN0VjkTlhT3w5rU6DUV1aLUW0lKFBZH1bCc5cYLLdHs3hZuAE37cLr8mt2Pcs/j
         Q9wE8cE7PBZVpCPBRhEmC9KdFWYXYRgTbNkSRTQ2n21tCTEU28VMFPr7QD2MIsy3Qmr/
         rUxWEDh1Ie2EvvXmjG27C7lRkOQPCyKLwd8Q0CeEKtk+HlSq57ekI4ho7ElCodKuqqWm
         IClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/kYbQP6lXXIzhEzx/6SmBVOwkh3SmfI0Cn2kMz3F0bE=;
        fh=CFFPbkj43Up6+xST8qdM6mCV6NKZQfwZu4O3B6KU9HQ=;
        b=P8NdFO6aW+NTduJLWKXUdMV0XU7XtdHcjfcJadsBpnMi4VplLS/uFfNtOPiJiuKmy3
         xdNvOomvgHnwK85dP8dY68Jf5b8wS75hNBtDkg4uk7ZNws4lJuIbEoBoVPB+rQvTUvhK
         6fyg8e97be/WyUZYVh/IU3+WCnkTOB1nVdxXYyKmB/g7ONZnVDze1EaaKkxuucNxEbC7
         4DnAYMDAX3bf/NRPnN38ZiFwbkqgzbrX8MuwWBeOGpaQDV/OGTTX3oe4wqAVQhoY2xH5
         hX9rAZxap8CNw4t6dOpdltEga2gH02ibdNNDNFezakWHNT7PG9fd9IJjDZjqtPLukfeu
         fbsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780606080; x=1781210880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kYbQP6lXXIzhEzx/6SmBVOwkh3SmfI0Cn2kMz3F0bE=;
        b=kujFNSa8bEBhni2Vdz4vI+Km75hfDTIAscakJFvxAoKZplr1xpKIQudul5sjSm+ile
         uUFh+KgWMJs0I+sTJAi8m4nbtnxhTwvXqfBhqT85q5aPWbJGK1l1syLn/DPR6jaPLVMR
         HVWkdIN8HIaJ4dWAyyh1Gmw1deNw3avy6qSt8pGATWvuY3w2hM/omrDGMZqCTGLvaErS
         E8Kf8caev7Dk3k/g8rQ6y8hP/i6McDPgQHyAmV45gWdQ92nRXIHs2AW7sfd4B3kKueEf
         /sikI0x1ALTCPg4D9DvGt1dOWC7AZzAt88ELT4eUowoPlAUesaszx4duvRyVrAlhuR+N
         I8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780606080; x=1781210880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kYbQP6lXXIzhEzx/6SmBVOwkh3SmfI0Cn2kMz3F0bE=;
        b=sdEmP71DJ+iXPuJVgsZkrBZLnjK2aU84w25C5O+9WoYA9EwRuRyz+0aRZd7PGcmkjQ
         yQwhwUOD9AZcV8ozy9F14AdhhJmSm60ETbtVEqk3EhoIG8ir+ISlukhqnqss066knILi
         OP0cKR5QSUCmc4rBGdcEH3HJq8c3pLYwL0smqSVkYtTVa8b3INcwwrF6wdiacOJW52xD
         EkqDcQgAEryhbEm2v9qAzcOwq1hyOxkaSOSUENQ147w2GSom6YIoqcUj7z2nJ0c6vlIS
         uUTVMhks92ys0Q5nN6Y+XnLkpMcM4rwWo14O7EAZRtVq4YTfEp7rnGA8lXdO3wFeKk6C
         hJ3g==
X-Forwarded-Encrypted: i=1; AFNElJ9190o0MgsIfpXDBMud2e8y3PIfWt0WUmNWvtcXBtmLTj5RRYlSGpwN6T88GOUhdifcZL0reaKVSdFgOAx9Q3q7@vger.kernel.org
X-Gm-Message-State: AOJu0YywBlYdV82p/dmXKo84AURKt9zLcB9jzjJuKs1I1sdmBsaHdQxc
	s42hdFDHQpVrGYRpfR5tl5XEsKXfS6XylUDYVC3u+oqBNlSbcdEDyteqmSjFVAtejZtKQ3NhhXK
	sp5BV7M6q4WSK5z2KGii7catUJerjxwshTrS42uTf
X-Gm-Gg: Acq92OGUMWf/zJ72ezv+YrOxffvmqEqXN4+m1qm1pSkK/b/u4TKoOu7FOu5A6grd0Sk
	Bml+3fkHCBPZOCOfv+Ll4Hsv6kM+bb0FLfftcw5YcaImmE5f3BTKdAP922kr2N0LFdxJMldwmxk
	cy/XLtDLPmug+bEHe5SiDdLhNe0kOXhBoNm1/uq3X+0G5P+J5L4VqbOt8qj0grxc+84ylAGWvHk
	39J/58AUeVCm8h38u5Y09oJgZReEQbACVvXEs2qGssZ+DfgiSxvvtgQ4MOdBmedu2O5JIc193Uw
	o54dyke/C7VWDhecGesXQWYOLm5YZuwEaBzPI5CnQ8rtxYw=
X-Received: by 2002:a17:903:1a10:b0:2bd:6727:d689 with SMTP id
 d9443c01a7336-2c1e8b49209mr112025ad.12.1780606079156; Thu, 04 Jun 2026
 13:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602174129.3192312-1-irogers@google.com> <20260604163627.501078-1-irogers@google.com>
 <20260604163627.501078-3-irogers@google.com> <aiHfhrRBrLojzOA8@x1>
In-Reply-To: <aiHfhrRBrLojzOA8@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Jun 2026 13:47:48 -0700
X-Gm-Features: AVHnY4J9CgdB6Ap2CA_cjL09XJUVR3cuQ63H6qpT1uRCXogECBudZ8lL72_2mow
Message-ID: <CAP-5=fWtK6tGzJaWRz4SZ8_sK=tz39+-5im64Yzt47B0e+X_PA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] perf test: Truncate printed test descriptions
 dynamically to avoid terminal wrapping
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:26=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Thu, Jun 04, 2026 at 09:36:27AM -0700, Ian Rogers wrote:
> > When test descriptions are extremely long (e.g., the truncated perf.dat=
a
> > graceful handling test is 103 characters long), they wrap across termin=
al
> > boundaries.
> >
> > Because the ANSI escape code to delete the line (PERF_COLOR_DELETE_LINE=
)
> > only clears a single terminal line, visual wrapping leaves orphan
> > wrapped lines on the screen, which results in the test description bein=
g
> > printed multiple times.
>
>   CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
> tests/builtin-test.c: In function =E2=80=98print_test_result.isra=E2=80=
=99:
> tests/builtin-test.c:427:40: error: =E2=80=98%-*s=E2=80=99 directive outp=
ut may be truncated writing between 20 and 65507 bytes into a region of siz=
e 256 [-Werror=3Dformat-truncation=3D]
>   427 |                 snprintf(buf, buf_sz, "%-*s", width, desc);
>       |                                        ^~~~
> In file included from /usr/include/stdio.h:974,
>                  from /home/acme/git/perf-tools-next/tools/include/linux/=
panic.h:6,
>                  from /home/acme/git/perf-tools-next/tools/include/linux/=
kernel.h:11,
>                  from /home/acme/git/perf-tools-next/tools/include/linux/=
list.h:7,
>                  from /home/acme/git/perf-tools-next/tools/perf/util/conf=
ig.h:6,
>                  from tests/builtin-test.c:26:
> In function =E2=80=98snprintf=E2=80=99,
>     inlined from =E2=80=98format_test_description=E2=80=99 at tests/built=
in-test.c:427:3,
>     inlined from =E2=80=98print_test_result.isra=E2=80=99 at tests/builti=
n-test.c:473:3:
> /usr/include/bits/stdio2.h:68:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 21 and 65508 bytes into a destination of size 256
>    68 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL =
- 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>    69 |                                    __glibc_objsize (__s), __fmt,
>       |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    70 |                                    __va_arg_pack ());
>       |                                    ~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:9=
5: /tmp/build/perf-tools-next/tests/builtin-test.o] Error 1
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
58: tests] Error 2
> make[2]: *** [Makefile.perf:566: /tmp/build/perf-tools-next/perf-test-in.=
o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
>   LD      /tmp/build/perf-tools-next/perf-util-in.o
> make[1]: *** [Makefile.perf:288: sub-make] Error 2
> make: *** [Makefile:122: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
>
> I thought you had fixed this one?

I thought so too with the clipped local variable. Let me look again,
sorry for the churn.

Thanks,
Ian

> The first patch is applied, testing with it now.
>
> - Arnaldo
