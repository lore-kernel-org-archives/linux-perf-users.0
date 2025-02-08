Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A817DE2D;
	Sat,  8 Feb 2025 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738992315; cv=none; b=XcPqhdvIUvqpAV3QDShFe4kSTS90og6dsi8gMMR6xxQ+WbItRY173pjy6cQAIZd03hfn1rdw5KpMn5LOo+C1ZAnz9re/U6sqWI8zDjhpJ1plZ7YQM0DHk9a5kOARK0t5qokQVellJK2bMc+G5/ZezkqoLjzTAJwYAVQxDhCLWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738992315; c=relaxed/simple;
	bh=dS+gHUB51Qy4KVng7tLl3ipMB2TdjJ74Rnq49bkQNVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elR3lyIhEkS2haWOEUni37NhdSPVRg2N+2KV8kemp6NAjXU7vep+sgyW2JwaOmPvF3cdcu63RK9KbiK+Rhqb2aa1V/pHEyi/CVWyzp6Gj1/speWugtzDdwFXOvlGpmZTxXVx7Bm/ebeQWytjJozard4TjPjp3RShBx826Zz/eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3qeqb0U; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3qeqb0U"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f6715734d9so25243267b3.3;
        Fri, 07 Feb 2025 21:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738992313; x=1739597113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ye5i7ngncVTyxZ/vrpkYP4Udn+2F4lFb54LtwSQHU=;
        b=F3qeqb0UKRsHCbLF4Ku5fzOQpQvPOu+RLACq4Z3aVAfRgkOZL7Pl5sg0t+DTtUr5/9
         v2IE3SuZ+XawkxnZ02feSfCKDU1ENyMCtv0jrYEfdaWypcP1Qi+at9AUp15XVYFenHd+
         yH3lEcSav3yJdJluJsTCAFUq7d1cf6pEpJbvHr5CQsf9HkLGDzyvra9lC6N6H/SFCsbg
         OKR883SVaFXKCcfohbX4CHAJsWlQhl/4I6giirh1dezwwEFxKBmuL+w2EFy6qU8ITKD6
         kGUWJ5bV6I1CvkF+yEfO20uxXbX62HB8O7lP6Erz5wyrLVOJBh8yelndGHrtNNhV7Bf3
         rn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738992313; x=1739597113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6ye5i7ngncVTyxZ/vrpkYP4Udn+2F4lFb54LtwSQHU=;
        b=a5tIDWOczXSKriMT+mJTpgSrB0L2wBgH8XpUOh99mO1Ph79QuLz0A2H0U0kVwewqPb
         rDHW26UEbj/z36rKKQbGUDpMw8bPhJOagbSqxhX4QpLPjcbC7gG0BBQjEAoRkMVDZOd4
         6RZoVVB7FiOHFyHHkYBIg03hNIOzZy7WUvv7db4z6V2DdtOasibQ3iKRKxH5u4sBjPNL
         0wikrOlunEyxIfPteRqLX11Im/METWDKQxBThAclYWccsJfTdPcTOu2PBEjg7QgZt6SV
         gGIr+r+2BzhhyLN0aUGAk3wKv/pMGKKOm4+a8ovdWmMxsGl8Ijow+27m8e0nfwzrE/U2
         YuDw==
X-Forwarded-Encrypted: i=1; AJvYcCV1EZziYTxTL7Z/zmKnCWgL5WOTiTKsXpJKukgunxazt+C7RpE5EEH9SFl0Eo0FBGueLklQWdo2azp1R3CYEn/RSg==@vger.kernel.org, AJvYcCVifYyNCq4CelUEyzAedesMyblD4tHoLp/B6LPz2POZVoTTXFYUisyNtmTcQ+EhVFFCIJ2imjm2Kyh6ewk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTb7w+fpczGsQubnL6vUOruGv1zxc4n3jBMcRN6GRqRkXFymda
	abN9W5pPlFmRFV/9QsBcrysMw++hsJmeWZbqskqqpt3b+rBE4eqVi6/YbXOvvkaav/TP1PdT5Jq
	rpr+PINceuicRb2fBf27W9PxhYPE=
X-Gm-Gg: ASbGncumVkiDpwwPUyNfEt0SK275fOoTZx9N47fq5FgTuYpmQpaApTW4GErYOxRAOnm
	CGk20A9uzyEfafL9wf4gQXto6VvpLmdtaWFAuPhhBhlev3YS6MB7eoL8hhAQ/vtpWQz6Hawk=
X-Google-Smtp-Source: AGHT+IHxC4/WuGPZSTqlSqH0jOLk9RROkA/zMyyTmOEzkL2qG2GFb8ZfppnL4/HJ931Y2HPzon3/OoVsQxVfCVZ1zsw=
X-Received: by 2002:a05:690c:6488:b0:6f9:aeee:8f10 with SMTP id
 00721157ae682-6f9b29e35bfmr48635197b3.24.1738992312948; Fri, 07 Feb 2025
 21:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205205443.1986408-1-namhyung@kernel.org>
In-Reply-To: <20250205205443.1986408-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 7 Feb 2025 21:25:02 -0800
X-Gm-Features: AWEUYZknLKCuyiuFJF9VAmJ_2TAsyVv31SlnJ0R8C1MZ3yfAlGRT44SqaGlUuJM
Message-ID: <CAH0uvoinT1ZH3Cifj_skJOjfKrvQ8jdbU_3gFp21eD4PwGOwkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] perf trace: Add --summary-mode option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Feb 5, 2025 at 12:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I've realized that perf trace shows system call summary at the end for
> each thread.  But sometimes users want to see the global whole system
> summary or statistics instead.
>
> So I've added --summary-mode option like below:
>
>     $ sudo ./perf trace -as --summary-mode=3Dtotal sleep 1
>
>      Summary of events:
>
>      total, 21580 events
>
>        syscall            calls  errors  total       min       avg       =
max       stddev
>                                          (msec)    (msec)    (msec)    (m=
sec)        (%)
>        --------------- --------  ------ -------- --------- --------- ----=
-----     ------
>        epoll_wait          1305      0 14716.712     0.000    11.277   55=
1.529      8.87%
>        futex               1256     89 13331.197     0.000    10.614   73=
3.722     15.49%
>        poll                 669      0  6806.618     0.000    10.174   45=
9.316     11.77%
>        ppoll                220      0  3968.797     0.000    18.040   51=
6.775     25.35%
>        clock_nanosleep        1      0  1000.027  1000.027  1000.027  100=
0.027      0.00%
>        epoll_pwait           21      0   592.783     0.000    28.228   52=
2.293     88.29%
>        nanosleep             16      0    60.515     0.000     3.782    1=
0.123     33.33%
>        ioctl                510      0     4.284     0.001     0.008     =
0.182      8.84%
>        recvmsg             1434    775     3.497     0.001     0.002     =
0.174      6.37%
>        write               1393      0     2.854     0.001     0.002     =
0.017      1.79%
>        read                1063    100     2.236     0.000     0.002     =
0.083      5.11%
>        ...
>
> Also it changes internal data structure to hash table to track
> statistics of syscalls.  And removes the rb_resort code.
>
> v3 changes)
> * Add Acked-by from Howard
> * Update commit messages  (Ian)

Sorry for the delay.

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
>
> v2 changes)
> * Rebase to current perf-tools-next
> * Fix some style issues  (Howard)
> * Rename to --summary-mode  (Howard)
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf trace: Allocate syscall stats only if summary is on
>   perf trace: Convert syscall_stats to hashmap
>   perf tools: Get rid of now-unused rb_resort.h
>   perf trace: Add --summary-mode option
>
>  tools/perf/Documentation/perf-trace.txt |   4 +
>  tools/perf/builtin-trace.c              | 247 +++++++++++++++++++-----
>  tools/perf/util/rb_resort.h             | 146 --------------
>  3 files changed, 203 insertions(+), 194 deletions(-)
>  delete mode 100644 tools/perf/util/rb_resort.h
>
> --
> 2.48.1.502.g6dc24dfdaf-goog
>
