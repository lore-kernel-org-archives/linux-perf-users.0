Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425683A18
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804788; cv=none; b=a2sc3Siv26XcGAhjo26p+gFTbaiq65Q3PMsi3imzeg6CbDdNYAGEZ6/FyWw2m+YG+CL0O0WssBH08xg03SeiHEzcd9US2vR5Q4kqbzdJlRGeIBe/pcmFfuX3K59k/Yw+FuwmimOf3q7Wo6ip/0SBhlOwNnc2x4JE+VpAabn0VEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804788; c=relaxed/simple;
	bh=9F/toJpxNElR3PbDbEoXx82+WfuM9bJIRnpAzhuQT1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKJ5UQxkH3Lk2+eExop3BUTMYaO/+mfvvmYOa2ZwS4pLc3QwMm4OrxczrxvOoTuu9lyRL37JUkhwXV7uXnGK5X2NRpx6/Ou/LB7+hpGQQS3uM4geGoZ3v3hxMOCHodsRuvCKQJYmmEcmFWscIAEVr82IzJV821d5FilSEd2cN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjZ3DBoh; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjZ3DBoh"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a1a662a633so15865ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727804785; x=1728409585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZy9/QIAL7I1WICx12bXOxFmW8cOAQaIYW0jgY3fIUQ=;
        b=SjZ3DBoh/uHcydJVuxvLx/ClT1xTwTZX/wju2gKnhFEFohzpy2bPB5HD1gi1seehmP
         aVqJLxy6AR3+1wRJTm4ihP81pEK7n88dCYoYhPC4B93S13DukCF8mZ/JyPv7LTDjvQeD
         RMUPLZtdxzvB7RTHWEFVkiaS+UEr6euqJAMnrIRRpCW2AdVHeVDXZwzip6MRUykaqIhr
         1HXXWINRvCVr/0pioe5qF3pLyzE0YLrsL+XgIxo/e91U67Z5oOLF86wayZjWvT71j+fw
         ONIt1qIyv8l4qStBE+joJCd/jJR+wccsRvhAxwjwxwUmxRR384h21SgacLR4l8AzVJHz
         e+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804785; x=1728409585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZy9/QIAL7I1WICx12bXOxFmW8cOAQaIYW0jgY3fIUQ=;
        b=E2YcU9TaPS+JG+oYg9eBoYeqIDTSBRhgHi+qrNYLaJUcgVMWae2HZr90WBIZuChg23
         JEtYMhjeDVLUwLHPSvIIBqb232uHtId6YzcpJyPVDsBpWxNc08YfXT1kC5VlqpIKiCGO
         NyM5OM3f7B5FAFTUw3NzPY7yhl/5wGpRGcfHq/bvo2oyzli5ehB/26lHOlDxMZspQI4o
         NYQNhxJ6itSAPjPwo510FovPAWM+hHwPy4CHFMKyP4rqsZJ2t4ka70vjNswzIALjUWNi
         cN/lcnvaktHUXJ+Tf04ry2tvMBHwRCihhJITM7yMpAmGm2Axs4OOQViCKGYXUdcbrTSH
         E5qg==
X-Forwarded-Encrypted: i=1; AJvYcCXJZtEmmwUa2V99JygTbWaUnAKrMlbkr5g9jc5skZwd5uC2r2PKaT2sPUpC9p3t3CSpodk6psFK/+5qukDEIIP2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wSn8Wg5nFOVkhXG1uxKEfR0GCzcHk3Fo4/UTpLNyQoEQHEVZ
	ldwQi3Ud82BLWqQyfEyYEs2CuSlAGM5PA02U0hUbnooVFzXT4ejBZNaTe3K+CdPQ+OYNXDFmFih
	oQSXehEkEX6IrNpVZDwmV192Xc8zQznyI7aoy
X-Google-Smtp-Source: AGHT+IFa9K5O/7IzOLYui9Qt8ZjI7hzNrMV704sAFF8kngD20Uuy2o50O1AHDRE6+pfOXKsSOTlPnt3NNwyZ6wontb8=
X-Received: by 2002:a05:6e02:160f:b0:3a0:7212:94b5 with SMTP id
 e9e14a558f8ab-3a36636ecd1mr8925ab.25.1727804785411; Tue, 01 Oct 2024 10:46:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-5-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 10:46:14 -0700
Message-ID: <CAP-5=fXZF8tweCFV28zMeSH3A6Wqh+7R4FQ+efcU7BC-z1=iQw@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf tools: Do not set exclude_guest for precise_ip
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It seems perf sets the exclude_guest bit because of Intel PEBS
> implementation which uses a virtual address.  IIUC now kernel disables
> PEBS when it goes to the guest mode regardless of this bit so we don't
> need to set it explicitly.  At least for the other archs/vendors.
>
> I found the commit 1342798cc13e set the exclude_guest for precise_ip
> in the tool and the commit 20b279ddb38c added kernel side enforcement
> which was reverted by commit a706d965dcfd later.
>
> Actually it doesn't set the exclude_guest for the default event
> (cycles:P) already.
>
>   $ grep -m1 vendor /proc/cpuinfo
>   vendor_id     : GenuineIntel
>
>   $ perf record -e cycles:P true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]
>
>   $ perf evlist -v | tr ',' '\n' | grep -e exclude -e precise
>    precise_ip: 3
>
> But having lower 'p' modifier set the bit for some reason.
>
>   $ perf record -e cycles:pp true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]
>
>   $ perf evlist -v | tr ',' '\n' | grep -e exclude -e precise
>    precise_ip: 2
>    exclude_guest: 1
>
> Actually AMD IBS suffers from this because it doesn't support excludes
> and having this bit effectively disables new features in the current
> implementation (due to the missing feature check).
>
>   $ grep -m1 vendor /proc/cpuinfo
>   vendor_id     : AuthenticAMD
>
>   $ perf record -W -e cycles:p -vv true 2>&1 | grep switching
>   switching off PERF_FORMAT_LOST support
>   switching off weight struct support
>   switching off bpf_event
>   switching off ksymbol
>   switching off cloexec flag
>   switching off mmap2
>   switching off exclude_guest, exclude_host
>
> By not setting exclude_guest, we can fix this inconsistency and the
> troubles.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c | 12 ++++--------
>  tools/perf/util/parse-events.c  |  4 ----
>  2 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 727683f249f66f5a..82a19674a38f774e 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -898,8 +898,7 @@ static int test__group1(struct evlist *evlist)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> -               /* use of precise requires exclude_guest */
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.prec=
ise_ip =3D=3D 2);
>                 TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> @@ -1016,9 +1015,8 @@ static int test__group3(struct evlist *evlist __may=
be_unused)
>                                 TEST_ASSERT_VAL("wrong exclude_kernel",
>                                                 !evsel->core.attr.exclude=
_kernel);
>                                 TEST_ASSERT_VAL("wrong exclude_hv", evsel=
->core.attr.exclude_hv);
> -                               /* use of precise requires exclude_guest =
*/
>                                 TEST_ASSERT_VAL("wrong exclude guest",
> -                                               evsel->core.attr.exclude_=
guest);
> +                                               !evsel->core.attr.exclude=
_guest);
>                                 TEST_ASSERT_VAL("wrong exclude host",
>                                                 !evsel->core.attr.exclude=
_host);
>                                 TEST_ASSERT_VAL("wrong precise_ip",
> @@ -1103,8 +1101,7 @@ static int test__group4(struct evlist *evlist __may=
be_unused)
>                 TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> -               /* use of precise requires exclude_guest */
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.prec=
ise_ip =3D=3D 1);
>                 TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1122,8 +1119,7 @@ static int test__group4(struct evlist *evlist __may=
be_unused)
>                 TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.ex=
clude_user);
>                 TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr=
.exclude_kernel);
>                 TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> -               /* use of precise requires exclude_guest */
> -               TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.e=
xclude_guest);
> +               TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.=
exclude_guest);
>                 TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.e=
xclude_host);
>                 TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.prec=
ise_ip =3D=3D 2);
>                 TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, =
leader));
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index ff67213d6e887169..63da105ba914ef29 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1769,10 +1769,6 @@ static int parse_events__modifier_list(struct pars=
e_events_state *parse_state,
>                 int exclude =3D eu | ek | eh;
>                 int exclude_GH =3D group ? evsel->exclude_GH : 0;
>
> -               if (mod.precise) {
> -                       /* use of precise requires exclude_guest */
> -                       eG =3D 1;
> -               }
>                 if (mod.user) {
>                         if (!exclude)
>                                 exclude =3D eu =3D ek =3D eh =3D 1;
> --
> 2.46.1.824.gd892dcdcdd-goog
>
