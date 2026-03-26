Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605C34AB1D
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567053; cv=pass; b=iFjl472cs7g+zwiY4a/KrcbvtzBnteotR6NQXw2HoKShGnovaCyQ+ItX/KbwfRZisN88Pnh57+WplG1es9cOIx9SB8XpacTZ58cHSn+61PMQ1EwK0RcFgichvncz7mAjHXOVpo/ZyHdzEl+fOjW/X4INs4h5GdyCZedzRpHjpI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567053; c=relaxed/simple;
	bh=PL5pOMRzbV/0Pt0Gb8PF2GBDbraxA+xbtu9NTzYfELY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cd8idVepMJpuZ++NYNm32peC6wtGOPSp3MWoMwoGfjBEGedg76FCwQxmdMt5TSB1Vi7oLdXEZepbayj7G9VPuVuTFtfw8o6UOx4/Bz0cEWvi3f7R7cWuKBvoJqm0mEXmtbj3ws+ak+XhU6yU6EuHbw2r2+M576CNL67LKX6pLAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPpiA+7m; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPpiA+7m"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0c12be0ecso39595ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 16:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774567051; cv=none;
        d=google.com; s=arc-20240605;
        b=IHAztkFq+QG5yrOLZY9w2gyaAGCQjZ0CI8X0YQTNlVFfsgt9q9LxewrliPHoBzmrYA
         w/fmfNc0J4iME+mAU34hWt+hzmbOvBVDei1LSnER5V4zhwQykmchXH+S2U+iXwyElBf5
         ilJgJiAYnfzcnOrLkokHDFVx7RAlQ703Woz+UmIJBHbNUCr4xEZzIFsSfnROqnJpoQ10
         glwPiZ1znhPL3wXlKwT6gUyHC0dwK/3ToaFej/aGab21zIG50H/JKjthdpExqaeQgQlX
         zuy22edAZ6f/rhqvm3Qsw7l5QQmmA9bRzy3qQSkEDuCWVNWu+qne7/Ec1oQL4OePIG20
         oHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mV5QqxNzRGWrKqI1MsAp3Y+lpwQOnKfxH9lIamOXgM4=;
        fh=xp6/fO/Dyi4nrKIXqcHnbv3P7jYK7ZQrRErLMwXelLs=;
        b=kSofmFcq+yxuXDRBV3IEjdqcTewjh3SsgJ55NmartR72jyQprU8I5bEK3nqu+6AkTf
         sCJ0uF3BWaF/oCaKbFTwJRzdUDrbJYhYRlIW3BUclKMi3URuSpS3EHOstq4gvIo5WJRK
         sPaCCE37uVpU76eKfawLk/hOxzD6AwuZMQa0aIM07cURlulhwMPI4gv0Mvbx6LpJkekL
         otfYA4wqm/6mbgqXD7B6IgQlC12nbTo5NwXIARbVuBI1EOElkxybWo56Ua9KPYxifGm0
         pKB/PvS1uRVHB2cOcjrSvWb7wKm0fHUMNqz+7DKso0EQ1YKeHbsPFmNmM0yhHnk86Anr
         hWag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774567051; x=1775171851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV5QqxNzRGWrKqI1MsAp3Y+lpwQOnKfxH9lIamOXgM4=;
        b=nPpiA+7mfEzZubArp0lcaX/yg5KeuObH/ZPgL/kww2kNaxI9VB7prmOh34a7FT0tS4
         2Zd4sFCsdp9TmJNrt1x3nmPCqW5QkT3gmae3ZnMa4lKe5oaMIWGi2kznrH6DUTDs+TDr
         ablhevc5XbhrYeQh4vr2DFPNJfLE5BIFONgednmxdxAoaBq2/x8yx4TWI8DeE+NZ00vj
         tpfyJj3MU0FtOZ+w8+iwytJnSZ7xwSmSK7JaDWEgKVHe/iDso73n3jsUrcA+1e88j1SX
         mGPtd3noLiDb73kUt59T3bw2F1gAsvEYyU/PmPNOJBIEz9ja5EEXbcxNIh6GKH79SGxD
         m3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567051; x=1775171851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mV5QqxNzRGWrKqI1MsAp3Y+lpwQOnKfxH9lIamOXgM4=;
        b=n4qL+IOXSxU0ZKDVd9jVXD167YZfIxRA/ha1uXFE0uj2EJ0+scrIU/BExGOhDLsRBy
         rs/WNqPZodyKSkmZmRiqSs0TfOO/9T1iZjz3x6IgWPRQjnqw2QH0NrVs5l3UP8pGuIEM
         Yu7XNnehsFHgj3MxMvTzgTQrmqOXeh16O6FTYy91XMd46mVFC/BTCOYGnzCNaUPicrxF
         QPPUJChPKqGZ6GptrW8jXr8NwhejiV0V/Y3HGuyG1EPYiG1iu4aXEGGtZQfN+FrmHWXm
         5W7nX7AeEM2FgyW6Wqrlbdlx/ZYO4OlWmhswlt9LfwXi6v1tDIYpUrkGOEIpcBdep3xW
         DXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT5POqx1OxV9UA0GNinQJM/kfB1eKyAScIu7dGzK8+waeoEP87WX7hkWHJjO2qMfcqs4B6xo07zKZmoPNm0x5s@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjGuXQmDiiaBjMkNmSmZrVtt6SrDGApK+bm8iG1iSj5s4AXql
	QL67aRyXx+pSe4hMQ2+b73xAn9wXYfvXtvGingig3gkLBtB9ERsKZEvIcm4G7AN6YeJYVLA2I3S
	Oc7P6c9iLv9ImdriZUW9Z7dzta4v1aPqHiGII0urz
X-Gm-Gg: ATEYQzzXnTOsIilEE8SpLrAcpRO78k5McDcaYA6RYqQ3KqEmqQSa67IiRJkbdTiJ67K
	zQ7LnfN8lyYHloa7wyIdC2a81PJ3IC+vzb0JjSrcBpWHBTGbtrWJoyIGfrmTfi9fKYzIdRBb6uM
	oxrrnzdHGMMneLTXSd3COR/c9wyC9+sqgorVc4NYY8UR7j5Gkxl4OWg9iHSGjGuED2QoOeiCyeQ
	N7dy9LYGzYKXxbUu5tgXPzyVDGsS9L0hBZe0NpKCfT7KwNCjqBTmbDUzFS4nzqV8MIAzKhlayjU
	Fe2C/IM=
X-Received: by 2002:a17:903:2352:b0:2ae:c7c8:f46 with SMTP id
 d9443c01a7336-2b0cc39fd5dmr1316765ad.18.1774567050592; Thu, 26 Mar 2026
 16:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321061624.811157-1-irogers@google.com> <acW1KYl5x8W8SUO0@google.com>
In-Reply-To: <acW1KYl5x8W8SUO0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 16:17:18 -0700
X-Gm-Features: AQROBzA7S5V0WlKvDZcolktKTC5mIvY85dkhrxNDneQguIbT4-ZM0cPlLYeZU_4
Message-ID: <CAP-5=fUJb+a4s45p4aL8_qf-nC3EdTxL9oey1xh6ax=1rjUr=A@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests task-analyzer: Write all test files to tmpdir
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Mar 20, 2026 at 11:16:24PM -0700, Ian Rogers wrote:
> > Writing to the test output files in the current working directory can
> > fail in various contexts such as continual test. Other tests write to
> > a mktemp-ed file, make the "perf script task-analyszer tests" follow
> > this convention too. Currently this isn't possible for the perf.data
> > file due to a lack of perf script support.
>
> I don't know what you mean by the last sentence.
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/test_task_analyzer.sh | 37 +++++++++++---------
> >  1 file changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/=
tests/shell/test_task_analyzer.sh
> > index e194fcf61df3..cc74b03477fe 100755
> > --- a/tools/perf/tests/shell/test_task_analyzer.sh
> > +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> > @@ -3,6 +3,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  tmpdir=3D$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
> > +# perf script report only supports input from the perf.data file.
> > +perfdata=3D"perf.data"
>
> I thought you want to use a different file name.  What's the point of
> adding a variable here?

Let me cleanup the commit message in v2. The variable's purpose is to
allow us to update it when perf script supports the -i flag with
script files.

Thanks,
Ian

>
> > +csv=3D"$tmpdir/csv"
> > +csvsummary=3D"$tmpdir/csvsummary"
> >  err=3D0
> >
> >  # set PERF_EXEC_PATH to find scripts in the source directory
> > @@ -15,11 +19,10 @@ fi
> >  export ASAN_OPTIONS=3Ddetect_leaks=3D0
> >
> >  cleanup() {
> > -  rm -f perf.data
> > -  rm -f perf.data.old
> > -  rm -f csv
> > -  rm -f csvsummary
> > +  rm -f "${perfdata}"
> > +  rm -f "${perfdata}".old
> >    rm -rf "$tmpdir"
> > +
> >    trap - exit term int
> >  }
> >
> > @@ -61,7 +64,7 @@ skip_no_probe_record_support() {
> >
> >  prepare_perf_data() {
> >       # 1s should be sufficient to catch at least some switches
> > -     perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
> > +     perf record -e sched:sched_switch -a -o "${perfdata}" -- sleep 1 =
> /dev/null 2>&1
>
> I'm not sure why it's needed.
>
> Thanks,
> Namhyung
>
>
> >       # check if perf data file got created in above step.
> >       if [ ! -e "perf.data" ]; then
> >               printf "FAIL: perf record failed to create \"perf.data\" =
\n"
> > @@ -130,28 +133,28 @@ test_extended_times_summary_ns() {
> >  }
> >
> >  test_csv() {
> > -     perf script report task-analyzer --csv csv > /dev/null
> > -     check_exec_0 "perf script report task-analyzer --csv csv"
> > -     find_str_or_fail "Comm;" csv "${FUNCNAME[0]}"
> > +     perf script report task-analyzer --csv "${csv}" > /dev/null
> > +     check_exec_0 "perf script report task-analyzer --csv ${csv}"
> > +     find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
> >  }
> >
> >  test_csv_extended_times() {
> > -     perf script report task-analyzer --csv csv --extended-times > /de=
v/null
> > -     check_exec_0 "perf script report task-analyzer --csv csv --extend=
ed-times"
> > -     find_str_or_fail "Out-Out;" csv "${FUNCNAME[0]}"
> > +     perf script report task-analyzer --csv "${csv}" --extended-times =
> /dev/null
> > +     check_exec_0 "perf script report task-analyzer --csv ${csv} --ext=
ended-times"
> > +     find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
> >  }
> >
> >  test_csvsummary() {
> > -     perf script report task-analyzer --csv-summary csvsummary > /dev/=
null
> > -     check_exec_0 "perf script report task-analyzer --csv-summary csvs=
ummary"
> > -     find_str_or_fail "Comm;" csvsummary "${FUNCNAME[0]}"
> > +     perf script report task-analyzer --csv-summary "${csvsummary}" > =
/dev/null
> > +     check_exec_0 "perf script report task-analyzer --csv-summary ${cs=
vsummary}"
> > +     find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
> >  }
> >
> >  test_csvsummary_extended() {
> > -     perf script report task-analyzer --csv-summary csvsummary --summa=
ry-extended \
> > +     perf script report task-analyzer --csv-summary "${csvsummary}" --=
summary-extended \
> >       >/dev/null
> > -     check_exec_0 "perf script report task-analyzer --csv-summary csvs=
ummary --summary-extended"
> > -     find_str_or_fail "Out-Out;" csvsummary "${FUNCNAME[0]}"
> > +     check_exec_0 "perf script report task-analyzer --csv-summary ${cs=
vsummary} --summary-extended"
> > +     find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
> >  }
> >
> >  skip_no_probe_record_support
> > --
> > 2.53.0.959.g497ff81fa9-goog
> >
