Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBA1F5855
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753104; cv=none; b=J0qeMN1DsvUtTDiX8kR7/NiKToWb1DnYGp47wm2XmGpLl3ZovRLho6POQ6G24ZTl/b/qWeceYUdV3bDoyoTTLBgMrVt11aJC67bK2rqL0aOFfseTAURV4hZ/zJh3fZAhxXn+RtDaTbHmx1IQbGDCls4twY6/4BiwnGfHmoMrBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753104; c=relaxed/simple;
	bh=gBsANRIO/MtUpXMmcvpZvTAjfQFDrxxd019G/8JkFdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrWnz6y8a+G8cPVraWjhuMMTYYLc99nVHDu55lFuKOjhP3AjwSB3cUR5mkXlr4cXkVRYQmwRlQebg9YLXVqkvRqq9LrSgvpGiXqBfUJu+7cuQ9/SmiocYIBnhFWWSW5Va51YUED55c56apaQSOtJnTrlx3KhIIg6ms2pdqW3cVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMfIwLCz; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMfIwLCz"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso9655ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730753102; x=1731357902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He3P8aPu/Jm2CYhNDWEntlDA9h70vRKHNVKjtIl0OdM=;
        b=JMfIwLCzEGfWJaIjSEb/fdxnJWrlw6uutklXCQ5ncbpYP+I72FSbqDES+WfXkbWd3c
         KvjLjvKtSsXDZVGpBeiyxwNkjV+Jdi2r7AsHG3F+2b0dieqWOlk9xd1FW9PyED7BXqO2
         HSee9HfKEQ7ThbXtQQNffsEmubi15Ale27PkHqYrHQewHlxZzlBr8KKO+jW4wC4ZzZeG
         Gd5QnxtPL7nnFENGi821XMPIaL4HHJIoO8HnoCmNtTRMyXBZh28pZ/YBSig2BczzQtQs
         9KOdfAVhB9L/uPODkgxgDrNgXguwVOG6RQsMbWWr2HQZ7fjHW9JsSpo6nL70px1wg80T
         tZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753102; x=1731357902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He3P8aPu/Jm2CYhNDWEntlDA9h70vRKHNVKjtIl0OdM=;
        b=EfBYImV4iWz8G1AasvjeHZH+9XS4J80/8ETTYAs50cHT01VexARGGFGvrzckywonCL
         LhP2THj+g3i5hrITUe4wAXpXMi7NkaXxPEb9wOuw6dBe4uimtkAL8tkkCbPQwejHtyXh
         GY7PK1XoxMR42T6hmjEGCAU46CboQzV8fZdOL8oOzS67v0KDXw4NMBJIdbwPxz3G7caQ
         7IIVYvgN16XZE2W4l+JE5w0tduA//couqKTtSidobJjlP5jQT6ttrN69kal8HAk15gnv
         NckMJNMqfuwUG2OcgnDQCSYNyD/fFHtLATGA47r00XtvhWyIy6DHoIgZf3yfkMhaW+02
         E3ug==
X-Forwarded-Encrypted: i=1; AJvYcCX46briS24pLHvpsLpX5RGea7o2vIg9E2kXwUvZqMoukC1smLXSOtcnNNJv7/0iTrV2Bmsne9UfKEGUWehi/v3F@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0tEiRklEaZutuGRWHbt68f7/jiEm9NjdtqDmqczRKpw/yHBr
	tQNxpRYbV29Cq/IVB92hr16xjE3BdDRh21H+GikSjndOnURPO4V6mqj1lnSuC5u9dqdbo9jTblm
	X4Y51bZIY4CN9PpVnuoYAstOOYo7p50RrF4+L
X-Gm-Gg: ASbGncs0yPIV85E+vjw4EbsDsh4+eLFqwC1tJDsXlh7KmeqBM+/ndvy4/0ycXP7PyZh
	AJDMpo+xboIL7U3oo2RT5Fg86jnbFXfsjv2x+lcblQVkEUMCDmY23vqnf+wT72w==
X-Google-Smtp-Source: AGHT+IFfnbN9BAA2BakuIB2L/xKT1aGeT83pEF3lKubysgH7OYLfMygoLxxccfWtXB15UBsXLNUWr0QuSRdAoh5f9KU=
X-Received: by 2002:a05:6e02:154d:b0:377:1653:a1da with SMTP id
 e9e14a558f8ab-3a6daaa5be9mr713115ab.19.1730753101548; Mon, 04 Nov 2024
 12:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
 <ZyF2-XNUh38p_5Gg@google.com> <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
In-Reply-To: <B72F330F-2A56-41B0-ABED-FCA7DC9EE711@linux.vnet.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 12:44:50 -0800
Message-ID: <CAP-5=fXCYURva6Q8ktRVmnf2QCcsr-E3fPn327k0JRCw_9fn3A@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test only
 for intel
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, tmricht@linux.ibm.com, 
	acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 8:17=E2=80=AFPM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 30 Oct 2024, at 5:29=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
> >
> > Hello,
> >
> > On Tue, Oct 22, 2024 at 07:31:56PM +0530, Athira Rajeev wrote:
> >> The "Simple expression parser" test fails on powerpc
> >> as below:
> >>
> >> parsing metric: #system_tsc_freq
> >> Unrecognized literal '#system_tsc_freq'literal: #system_tsc_freq =3D n=
an
> >> syntax error
> >> FAILED tests/expr.c:247 #system_tsc_freq
> >> ---- end(-1) ----
> >> 7: Simple expression parser  : FAILED!
> >>
> >> In the test, system_tsc_freq is checked as below:
> >>
> >> if (is_intel)
> >>    TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> >> else
> >>
> >> But commit 609aa2667f67 ("perf tool_pmu: Switch to standard
> >> pmu functions and json descriptions")' changed condition in
> >
> > Probably need to put it as Fixes: tag.
> >
> >
> >> tool_pmu__skip_event so that system_tsc_freq event should
> >> only appear on x86
> >>
> >> +#if !defined(__i386__) && !defined(__x86_64__)
> >> +       /* The system_tsc_freq event should only appear on x86. */
> >> +       if (strcasecmp(name, "system_tsc_freq") =3D=3D 0)
> >> +               return true;
> >> +#endif
> >>
> >> After this commit, the testcase breaks for expr__parse of
> >> system_tsc_freq in powerpc case. Fix the testcase to have
> >> complete system_tsc_freq test within "is_intel" check.
> >
> > Ian, are you ok with this?
> >
> > Thanks,
> > Namhyung
> >
>
> Hi Ian
>
> If the change looks good to you, I will send a V2 with Fixes tag added. P=
lease share your review comments
>
> Hi James, Thomas
>
> Looking for help to test since in non-intel platform, this test will fail=
 without the patch


Hi Athira,

sorry for the breakage and thank you for the detailed explanation. As
the code will run on AMD I think your change will break that - . It is
probably safest to keep the ".. else { .." for this case but guard it
in the ifdef.

Thanks,
Ian

> Thanks
> Athira
>
> >>
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> tools/perf/tests/expr.c | 7 +++----
> >> 1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> >> index e3aa9d4fcf3a..eb3bd68fc4ce 100644
> >> --- a/tools/perf/tests/expr.c
> >> +++ b/tools/perf/tests/expr.c
> >> @@ -244,11 +244,10 @@ static int test__expr(struct test_suite *t __may=
be_unused, int subtest __maybe_u
> >> if (num_dies) // Some platforms do not have CPU die support, for examp=
le s390
> >> TEST_ASSERT_VAL("#num_dies >=3D #num_packages", num_dies >=3D num_pack=
ages);
> >>
> >> - TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_=
tsc_freq") =3D=3D 0);
> >> - if (is_intel)
> >> + if (is_intel) {
> >> + TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_=
tsc_freq") =3D=3D 0);
> >> TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
> >> - else
> >> - TEST_ASSERT_VAL("#system_tsc_freq =3D=3D 0", fpclassify(val) =3D=3D =
FP_ZERO);
> >> + }
> >>
> >> /*
> >>  * Source count returns the number of events aggregating in a leader
> >> --
> >> 2.43.5
>
>
