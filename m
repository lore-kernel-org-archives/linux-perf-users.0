Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614912DDAE
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121063; cv=none; b=aYQm8kJrqb86zm1pjIGfVtP/Z8MdEyR1rMY82I3MLkmWHnzRgSlWbMfVbToO6X8pOx5uFbUvw+sZAK3wNN3+KahM0SYyMfBt0/ECQ+KChOBP9W3Xpmq6WTO65yfVj8qTrcx8LCKRoM9/H7U2z6tbvd3T/xqvA01qQWNTvlPKfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121063; c=relaxed/simple;
	bh=P0nzUp0PvO8mm5HPDJlWk9SceYUCT/eyYnvv5nDCvDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW8zELxChyHyrmqHrO6TKezxAT9ML/+daXTZC3c5EfEqQR0DJKqp5hasD6L7nL3PpQqmpJ/aIgIB3JQTkpj1KOSCkZsmakASnEpHNbPd/YlON80MR8NoHF8sa9mJhkB/QeqYUDPMYVMayTqAbO4JzqMuv+VmWJyUzf0eO3XNvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Eh03j/+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Eh03j/+"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3600b2c43a8so9355ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 10:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706121043; x=1706725843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awu7x77B+bOCRQBjAJIZUBeYxB3ax7vYrRZ3HCTLFHA=;
        b=3Eh03j/+t/viyE0uk9aMiRJsVjcFvBf0ElftPl98m6KT9HrEWdz7OjMaqTfYR8rBo8
         DaGwlFtTdqMP3dBOcDEyiSTn7taXRYzCA7A1PVypzqrc8fFpHdHSvhEwckG2Wtcol3Fh
         3feFxyBZcGfw414b7kn+WnNsZGha35PEj1hVJGiGSKjuuT6lTYmv4cQYMNd6YpDcSGfB
         Ppp+V2/1HjwO0yM34bH7uFa+m/5y/O/ccm1cm63Ruyp48CijTDrpl8ptY+7BPc4Ml+G2
         30uU5OXTg+lVJHhGZbEnUA8IHOK+j8x46deUvllxhjkVzixbuFKHGw5DheoW/SRL++DF
         6roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121043; x=1706725843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awu7x77B+bOCRQBjAJIZUBeYxB3ax7vYrRZ3HCTLFHA=;
        b=PquQhz8X6RqIcW3IvsGK0HFxEWPwsZ3xyfXDT3+erEZe4tYTEVmai3VsW8p1KZt17i
         2RGaFcfZk/2cmt4uWPrS1m/XVuW7B4NeWQ0EGAbW4iD/ztoE7I2wCc2MY5qQ4XfqZwrn
         jUaRiAymAMpYv+7TGuBz79GoH613VsKiZZYNLZa3e+PUtn+dj0T80WQ2gFhgU6tYF2ir
         cHUSzeWCiR9E3uCCbwKgw7Un5J1THpRJo4Qp+rx2cCfqnlVtuPPcCOTwXp8XftGftWEj
         +a4dmoqZg131SKPbJsC3fCH/SQe3amSG/stexGBekTDtnNqJ12mfaGoPUAluGJm81H68
         ZZ9g==
X-Gm-Message-State: AOJu0YwxY0VwYaPei+FSdyYg4K6Lsq7zNCxZo/7AzKqFW9x4ATGJiyQI
	DvxkODcEw+P6vAoC5xvgPuEgRlXkHYdLNSUrKybzKwEMs5FRsj+0Tgw/oquez2kFFAEix6dFQFD
	oYXh/LqHctvu5wCJl/NlwpX0+D/tO0jSPg/OC
X-Google-Smtp-Source: AGHT+IGreWbUhtTvW+9Ga/OKnLbooNk4a5Iwt7NwGJpE8zRFyvmFj3idijd5lXxo3w4ouUVDvMSVHo93vSPjfKgoMAM=
X-Received: by 2002:a05:6e02:3207:b0:35f:dab8:1152 with SMTP id
 cd7-20020a056e02320700b0035fdab81152mr15036ilb.3.1706121043449; Wed, 24 Jan
 2024 10:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123163903.350306-1-james.clark@arm.com> <20240123163903.350306-3-james.clark@arm.com>
 <CAP-5=fX4QQYNzEY7-6GyqWJTuH-RQxxc3jB5B1k8HZtDZCHmFw@mail.gmail.com> <faba2e97-7e88-9dcc-756d-f256a6304836@arm.com>
In-Reply-To: <faba2e97-7e88-9dcc-756d-f256a6304836@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:30:32 -0800
Message-ID: <CAP-5=fUfY0weHXpDaz-oABsspnUyUdaF8ZYDUBFwFOCyiH80sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding
 isn't built in
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Spoorthy S <spoorts2@in.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:24=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 23/01/2024 17:41, Ian Rogers wrote:
> > On Tue, Jan 23, 2024 at 8:39=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> >>
> >> Even though this is a frame pointer unwind test, it's testing that a
> >> frame pointer stack can be augmented correctly with a partial
> >> Dwarf unwind. So add a feature check so that this test skips instead o=
f
> >> fails if Dwarf unwinding isn't present.
> >
> > Hi James,
> >
> > Is there value in testing without the partial Dwarf unwind? Presumably
>
> Yeah I think we could add a test for just --call-graph=3Dfp, I don't thin=
k
> there is one. But that would be separate to this test, and would be
> redundant if the tests are run with a dwarf unwinder present because
> this test already requires the frame pointer unwinder to be correct.
>
> > that is covered by the existing dwarf unwind test?
>
> There is no overlap, this test test is for --call-graph=3Dfp, and the
> dwarf test is for --call-graph=3Ddwarf
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/dwarf-unwind.c?h=3Dperf-tools-next
> > If the issue is inlined functions I'm surprised addr2line isn't doing
> > the job properly. Is there an addr2line perf script issue here?
> >
>
> The issue isn't inlined functions, it's when the leaf frame doesn't
> insert a frame pointer. In that case we use the link register to see
> what the parent function of the leaf frame was and insert it into the
> frame pointer stack.
>
> Dwarf is only used in this case to confirm if the link register was
> valid at that instruction.
>
> See commit b9f6fbb for more info. Long story short this test was only
> added for that feature and it requires a dwarf unwinder to pass despite
> being called test_arm_callgraph_fp

Ok, not directly seeing b9f6fbb being dependent on
HAVE_DWARF_UNWIND_SUPPORT. I'll assume I'm ignorant and the fix here
is obviously a workaround.

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > Thanks,
> > Ian
> >
>
>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/p=
erf/tests/shell/test_arm_callgraph_fp.sh
> >> index e342e6c8aa50..83b53591b1ea 100755
> >> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> >> @@ -8,6 +8,12 @@ shelldir=3D$(dirname "$0")
> >>
> >>  lscpu | grep -q "aarch64" || exit 2
> >>
> >> +if perf version --build-options | grep HAVE_DWARF_UNWIND_SUPPORT | gr=
ep -q OFF
> >> +then
> >> +  echo "Skipping, no dwarf unwind support"
> >> +  exit 2
> >> +fi
> >> +
> >>  skip_test_missing_symbol leafloop
> >>
> >>  PERF_DATA=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >> --
> >> 2.34.1
> >>
