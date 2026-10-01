Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F73E1683
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871635; cv=pass; b=KlYbCaYn05LucOAEwA00VJX0688hAw9sONfJbud+M3cnZLB2OuPFaQGqMdZgmVMZm7Ql5xK57ZzAeYpe8ABcc5zu5IQaziImxupy31gAPnVnuXbKQkM2e6WLdfMLkhOhPVD6P3M9c652Z8Mg4UgkYNzL1KiA+GF+XkuJwID6MnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871635; c=relaxed/simple;
	bh=Qa+5hWTznTrNX5yYAyqwHt/uL7jqwnxHvtU+t8XbxdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC9reNcoxAPx1LudQHv/2oND6PjvXZnJjdD9sDm0kzKElJY/PbcVsK3NmcGADCl/A5DeiorHKMB37CB5b5o9PCK4OhgtQkgEn+LUTjv9b2pnUvTG5Uq14WGwnmGu9OL4pxwjl9SrmbPBdTI+9Nat1S+cu36+iA/bqEcTMDiwqzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1GrSLHY; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1GrSLHY"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so399481cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 09:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790871633; cv=none;
        d=google.com; s=arc-20260327;
        b=LcWWBP22qOY18fb6BsNDutVsLiPyOjoDUfFv2QN9vBkzEqTy2eKn6g/I1PPlBSeD7O
         wceYD3cno6/VgV3ECsHXRsmZz0FAqJctrOw55AzuuE3L/HM6NsoJ1hxYygzgXnjEOawx
         CTedeoKW5FKKoM95bprdFWLg7EBJslieoJu4IIMB1beSDAoYmDi3B3AjXRzLDxPDUYH6
         6ME+Wamr7pGv7WYdOboVCjBMBP9mtBV7to1+M0LwNA7dDRaMZiuYN3yyHelUpMk5jWJr
         Us45btawOl/xWdw6i5tyeqM9mrdwTalgq31P9V1GrvikH8rzoZqM2v+MxjgfMkekW0rO
         7uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sQEDjtk6s8Jnt1sf6zxyPM70VlZQFrTlfpc8yCXSOY=;
        fh=6UW8l9fhdnakyMtbaC4g7jpvMc9gotQtc7PSZ+UfI3k=;
        b=kFIn2SkPmdBeDBP7xmcd4HJGkfrLmVpkV8Vw2O6uTEhZdY2LphClDsamR6ojTHZLWO
         ZHD9KpTjdRUvw8TDxnX3+Q1EjIYMLoEOLNy/FtPFpkebJ38rCPRK5kNK6e0l3bQ79smA
         tg+j4Ao/HysOfAtv6Kfj9H3JuWslhwzTVOyJdDa6G+JdGbWt1M05uH1IvDP/qmqdpOCi
         Aq9ih2dtcyqEPgw3sw8g9WAWxUJNZg3TdYusSHX58du7tyBYB9OelCEZ4BM288d/qUCD
         Ouy4eruKQBQv+LaG0oxu5yyBpe1NANfHFxCI2lVDkfByMg/G1cd5jivbBGBAfVZNog8I
         yM9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790871633; x=1791476433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sQEDjtk6s8Jnt1sf6zxyPM70VlZQFrTlfpc8yCXSOY=;
        b=h1GrSLHYmx5Accc8KQ6kIWiljurkIi246+6nz0i/mcYRl5rcE7PmKoIMTMGEbPAlFf
         0Jbr5d5wjLVXWZOxx3du5Sln9aaVp8WCkHyAO1UthPrrFUr3Bw8RKppTc0rCuy181Shh
         Gv+Y4b4BYWpCZT5vPEOZ1KFvfSgBQJqmE+wXGbMfZfFF0fZlEJMZ5px0rCY+1yrYarvv
         EBdUhEIxmQyjJLlK9KTBUeSmt16LyMm2/+p//rhJnOWi8RaKRHSFyW+CSi7/J2nhOGFx
         79W9YSrUdzh4hYdirHf09q5H1KmDp10jr0kS9ez+CGs6/uwGEWvQBR2fvw//CgkSZCPK
         Ihcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871633; x=1791476433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sQEDjtk6s8Jnt1sf6zxyPM70VlZQFrTlfpc8yCXSOY=;
        b=dsOP8sgz5XZLkFGwZMZA+Y0c+UpRJKGH26uEv0nOzXhZhZAv5bkJhqXes5nTtn8gAt
         xJ0VfiT+jTUrZlPfMgnRdHbAkxFyRenIe0Hdil/Dzju0+NaMkNIJyCryQNd15XIJnX6J
         Ij5/xWcWJljeF//AJQma0VKfLqdZnDoVUhQjXVpuYlwnRf9Tpb5l7YJAD3OiARcqaQb2
         apsXDsYxVAZ9IzticbVmj+dR60zingB2deNcBoKEenENa7z5ZUuvSExTURABEAeeo3JY
         1iuU6Il2OZIr/haSV2c1y6KQ7EzIQWtNXVkTCVlPAAzS74clQ+UBnlJiiXUe8xD0LETc
         bXFw==
X-Forwarded-Encrypted: i=1; AKwUvByRn6H1etYLzLmFXnmmJo8uKpKw+Avd+K5tBr8GFlbhtRZfroJAoLU8cLJaH/pekj1tHxypXxeZW+sSGr+Yfgaz@vger.kernel.org
X-Gm-Message-State: AFuF++m1r8Sc/wYQt81794DnEkgnOMjL8pW7nKBKejxHs6bxDXE4SLeG
	dPk5N2vbkjdiq3wvfEJDoWD5Ifb5njuCie31A6cQjmYJOmshB38bb981M6j5cOF3XM6a8Qn6Zsy
	aBs3w5neLsG9Rmw84pHfseNo7yIsyNxdA1Z6Cdhr0
X-Gm-Gg: AYBFou0/CjuXstb+9rcTdPVswojtRPvGr1nEzZ3OUCxc+IwLp7IjjwysYeHBDTqJ7Ph
	bmneRc8ZLRO+zxU/XVQNrKvK+2Gy7zZ73xZuBboykBMRfs8DGYqIpL3MBCnUjfC3Ml/7XDT/hAs
	KS5AnX1Om+SP8Dp9tzPTRbHQipPHmQnBDei4Da4F+plRF5JEzfS/ob7eYA06hjM+csa18/qcaer
	0OMIKAlAnsnFDUMnlWgclA5OJOCz88GxyN2WTcQ4ttzx7BzguhCoNshRHdROM3YhNJkhg0bpeqz
	+QkR0ME+l4qWDBJR9d1r68oqK6FAOlCUeTOJO9roB65UfxjAx7i+FA==
X-Received: by 2002:ac8:5fcf:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-53388e439ffmr13627671cf.11.1790871632162; Thu, 01 Oct 2026
 09:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com>
In-Reply-To: <20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 09:20:20 -0700
X-Gm-Features: AclHuK-RqhHjCopnuIND1a7CQY4YSiIJ5E7S7Fp-2060jJ08nrkt19QGpjVcENc
Message-ID: <CAP-5=fUKDL6yDs0-7h7zz43BJ1uwC6Y-CiS5TMh+=F=iNc=7Jw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Replace optparse with argparse in attr.py
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 8:52=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Depending on the Python and pylint versions, pylint can report that
> optparse is deprecated and fail the lint check. Use argparse to avoid
> this potential warning.
>
> Preserve the existing options and defaults, and let argparse handle
> help and unexpected positional arguments.
>
> Tested with:
>
>   # ./perf test -v 'Perf attribute expectations test'
>   78: Perf attribute expectations test              : Ok
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Hi Leo, thanks for the fix! I see Arnaldo already took this equivalent chan=
ge:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dtmp.perf-tools-next&id=3Dcd116fcbc0bec7340a659e62210b963c49f93c1e

Sorry for the extra work, but again thanks!
Ian

> ---
>  tools/perf/tests/shell/lib/attr.py | 37 ++++++++++++++------------------=
-----
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index 7f3d5b64b00dd7de45baff4f7d9baff89e003147..68f06df9565a081174c788b96=
4a5b051fdedf626 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py
> @@ -4,7 +4,7 @@ import configparser
>  import os
>  import sys
>  import glob
> -import optparse
> +import argparse
>  import platform
>  import tempfile
>  import logging
> @@ -426,29 +426,20 @@ def setup_log(verbose):
>      ch.setFormatter(formatter)
>      log.addHandler(ch)
>
> -USAGE =3D '''%s [OPTIONS]
> -  -d dir  # tests dir
> -  -p path # perf binary
> -  -t test # single test
> -  -v      # verbose level
> -''' % sys.argv[0]
> -
>  def main():
> -    parser =3D optparse.OptionParser(usage=3DUSAGE)
> -
> -    parser.add_option("-t", "--test",
> -                      action=3D"store", type=3D"string", dest=3D"test")
> -    parser.add_option("-d", "--test-dir",
> -                      action=3D"store", type=3D"string", dest=3D"test_di=
r")
> -    parser.add_option("-p", "--perf",
> -                      action=3D"store", type=3D"string", dest=3D"perf")
> -    parser.add_option("-v", "--verbose",
> -                      default=3D0, action=3D"count", dest=3D"verbose")
> -
> -    options, args =3D parser.parse_args()
> -    if args:
> -        parser.error('FAILED wrong arguments %s' %  ' '.join(args))
> -        return -1
> +    parser =3D argparse.ArgumentParser()
> +
> +    parser.add_argument("-t", "--test",
> +                        action=3D"store", dest=3D"test", help=3D"single =
test")
> +    parser.add_argument("-d", "--test-dir",
> +                        action=3D"store", dest=3D"test_dir", help=3D"tes=
ts dir")
> +    parser.add_argument("-p", "--perf",
> +                        action=3D"store", dest=3D"perf", help=3D"perf bi=
nary")
> +    parser.add_argument("-v", "--verbose",
> +                        default=3D0, action=3D"count", dest=3D"verbose",
> +                        help=3D"verbose level")
> +
> +    options =3D parser.parse_args()
>
>      setup_log(options.verbose)
>
>
> ---
> base-commit: 705da5b15ab89ba97b11eedbe507c2fd83d31cb9
> change-id: 20261001-perf_replace_optparse_with_argparse-e7f51849a08c
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>
