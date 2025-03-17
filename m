Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01C248895
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225938; cv=none; b=YumIHDF+n1kEvYse7VUWbqKB4VAbyz5qDR2gZKV11cHeyoPnQg9mH04MPk8E+6oVzxvERLZ3H1xZh50wThxodoTMpTxYadUYLvJ7zPYmokVJTAQNmw1XtyuvSA6Q2V80LCeXtFmZoiDpLC4agHBDbbGKfCyvo7eT9iodoOs+dKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225938; c=relaxed/simple;
	bh=aXdbkkq2W+1zWRXsr9HiUFXu2toowMxmufs/pM82+WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lejvRIcQZLxu4WIwwznJugs4X1sw5tNLK/Hl9/5ZBZz8vdnizwHmnPx+FFBLbEn7JAJdHzjY3gI/gpZTOWDpOXig+HKWFZfnuNPNN/SdzC5yLwmw2qh+2I5Yc1N/YNTApPpHt4xTHfNV3maJHn1zCzF2hChro/nK3HNwXCDeRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9lGMruy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9lGMruy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240aad70f2so36695ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742225935; x=1742830735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibewGAo/J2qRa30YAt10KaER6uAGQ3UTarCl0s1LQn8=;
        b=j9lGMruy3OVVo2lUSg8oEpsJfVlYaWogriZ/QxeO2V03zTyTaJ/hzQWFK4f4JYb2YA
         46IgEcugmVglxjhnmYpZJuRU4QlfYcNyWo5IJGxouTN5RhUyz7ntcf4k8jQXcH4lzG/0
         ePTXMziMc6gj0r+5HhNU1IxZSOgNkX5bC4Ma1UhijfXJ2052gvZEyF3rLS0qNVIUnNRT
         ZWCKwmKM6lBLt458DV5xvd/4KXhJM5NdSUIbJWlzbYNTqsSIPRTSgVW9c5T7hAO1HV/d
         mlKjZA5daOc1pzbSjjLXJbIFHAY0opboGoqB2riawjAg9UYtLECyMoYXt/YCgOPHbbnm
         gqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225935; x=1742830735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibewGAo/J2qRa30YAt10KaER6uAGQ3UTarCl0s1LQn8=;
        b=VTPi69iGjei/3s3SMQm24Jd8PW1EkFuFc1Iiv9h5c6flJT1DxaQKCoujcMQBmKnDfE
         ARTORbYp+70RopUGPap2Co0bjnyKm9eRFl4lCHaK2Ae5TmhPvQ7/ScXNyU8677UtUpkr
         4LjTaMYTEanQ3lbLxCuTq31BOsbziz3iX7ezNgLeUzgd3Ks2PXCyqt8mYuSZ0QTrDk4i
         IgjAxTDew69zdFYUtJROJ5c0NQNzsz3yDkEKjwm0WWZBLIJmIgmfhegQ4NGTnLsrnE6W
         XzozprWZRQImyW1o2ZywDqKGk1ziAiefuFwFwBSfan9sar8ZEtfASGGdQBqIy7srhU3F
         eghA==
X-Forwarded-Encrypted: i=1; AJvYcCWaZhLMQinV5ZABYxqd8/Lgt0Q7+kmcay1JJY6824mLlohXTKgxXEhSIF3wDbcTSc0fdIExY/pANsjiPgF3WdDY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcq/iv4hvrplCTkhURTvCnxRK9gFihYvwezptjg3uFFq5XgdSX
	AqgdDUShbJzFqrAPCydS7Gk92qUMHR7uiLF09WYX6tL5UHxmqcfwD8nn/JaofSBG10H0nmJ2ESi
	NS0keEUeml8ST1b/qMYj1qvcgwpPKcz8p/jqE
X-Gm-Gg: ASbGncuDcQdMnfFrib5x9OXCU52k1jsb6RqAMUqiN2CFqvSagwrCs0uYDBpgGZPgA8v
	vuSkJW+atVkme6dQWWnnkSHTXWNZ4KCmDERWZyZkQQY6+p8lPADKYuTZwxsqhMPtm1zZDXOtjPe
	WVtR+Zxqb7y9tf/EW7WhlrSvgDaLFfUu9KTV/+GYw2dtHOxQP8Zu0/LbU=
X-Google-Smtp-Source: AGHT+IFmuAire14rm2C35T4pBPTkpwXnhmqypP81Y8wUqO9DVsSx/lXQTrcMGKQYhWRrXY2V7IZoaC+BrdPT5mr0tQI=
X-Received: by 2002:a17:903:906:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-225f374426dmr4632695ad.0.1742225935292; Mon, 17 Mar 2025
 08:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312055846.671522-1-irogers@google.com> <20250312105450.GN9682@e132581.arm.com>
 <Z9M9gK4VS199CRKh@google.com> <20250314091314.GV9682@e132581.arm.com>
In-Reply-To: <20250314091314.GV9682@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 08:38:44 -0700
X-Gm-Features: AQ5f1JqqPslmU7qwiaXwbGhMZe0hBOK2_y6dneuYZ8SwG4h2LXyZ6LgALAdOUn0
Message-ID: <CAP-5=fWM2hqu02nNyBUBgLu01AC=C7mwxayezzs7frCyAsirPg@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Harden branch stack sampling test
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	German Gomez <german.gomez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 2:13=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Namhyung,
>
> On Thu, Mar 13, 2025 at 01:18:08PM -0700, Namhyung Kim wrote:
>
> [...]
>
> > > >  test_user_branches() {
> > > >   echo "Testing user branch stack sampling"
> > > >
> > > > - perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u =
-- ${TESTPROG} > /dev/null 2>&1
> > > > - perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' =
'\n' > $TMPDIR/perf.script
> > > > + perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,=
u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
> > > > + perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR=
/perf.script"
> > > >
> > > >   # example of branch entries:
> > > >   #       brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> > > >
> > > > - set -x
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*=
$"     $TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"   $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$" $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$" $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"     =
       $TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"  $=
TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"=
       $TMPDIR/perf.script
> > > > - grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"         $=
TMPDIR/perf.script
> > > > - set +x
> > > > -
> > > > + expected=3D(
> > > > +         "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
> > > > +         "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > > > +         "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
> > > > +         "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
> > > > +         "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
> > > > +         "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
> > > > +         "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
> > > > +         "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
> > > > + )
> > > > + for x in "${expected[@]}"
> > > > + do
> > > > +         if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1=
 -q "$x"
> > > > +         then
> > > > +                 echo "Branches missing $x"
> > > > +                 if [ "x$err" =3D=3D "x0" ]
> > > > +                 then
> > > > +                         err=3D2
> > >
> > > Here it sets "err=3D2", as a result, if any grep command fails, the s=
cript
> > > exits while reporting to skip the test.  This seems incorrect to me.
> > >
> > > My understanding is the regular expressions above are mandatory to be
> > > matched, otherwise, it must be something is wrong.  We should not ski=
p
> > > the test in this case.
> > >
> > > I can understand that 'perf record' cannot record all branch types, i=
f
> > > this is the case, maybe we can improve the recording quality rather
> > > than reporting skip?  E.g.,
> > >
> > >   cat <<EOF > "$TMPDIR/loop.sh"
> > >   for run in {1..5}; do perf test -w brstack; done
> > >   EOF
> > >
> > >   perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u
> > >     -- sh $TMPDIR/loop.sh
> > >
> > > If we run the test for 5 times, should this can allow us to ensure th=
e
> > > branch samples are recorded?
> >
> > The brstack (and other workload programs) can take an argument to
> > control its duration.  For brstack, it's the number of loop iteration
> > and default is 999999.
>
> Sorry I did not dig into the brstack workload program.
>
> If the workload has run for a large number of loops, the question is:
> why isn't the test capturing the expected branch stacks?

On our testing skipped =3D=3D failed, I can change 2 to 1 above but I'd
made it 2 as it wasn't clear to me all branch filter types would be
supported by perf record and skipping/2 was a less terrible error
message.
I'm keen to land the pulling apart of the perf command from the
tr/grep as if we hit say an asan error currently that is hidden by
code like:
```
perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u --
${TESTPROG} > /dev/null 2>&1
```
where all the output is sent to /dev/null but the asan error code will
cause the "set -e" to fail. If this code fails with asan then
currently the first thing to do is start pulling apart the
expressions.

Code like:
```
perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' |
grep '.' > $TMPDIR/perf.script
```
is problematic as again we lose the asan like errors. Running the previous:
```
 if grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$"
$TMPDIR/perf.script; then
```
could fail because of an unexpected branch filter type, but was
failing for me just because there were blank or similar lines in the
output. The new code doesn't change this but allows the output to be
dumped for later diagnostics. The '|| true' in the expression means we
get to dumping the diagnostics and dump just fail because some
sub-command mismatched its input.

Thanks,
Ian
