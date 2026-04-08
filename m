Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215E3537DE
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685746; cv=pass; b=JFcbIB7wfvExzq+zXaCYEIROehVgTTetnzjSoakUYSVTU51hxdz4od1s9OlNMMwFGdSAnBU+b12DwRsPXOK6rPWO2jW6Z2lj7vsJjsFAxAht87ydSRTbqziYu3onhB6zT0A3bMgCAGsiTW7lAJTunFRdcq/VsQorK6LVklRT/MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685746; c=relaxed/simple;
	bh=rj497NBUieKP3frpgMmUZiK0lxrGDfgfMFJsaaVRG60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsFoMF7QI76y6tq2IoM0oMQbolhGlct8ICxBz46GruBKQc45gRYIrNOYKnth/BvUW3KYrfwf71BZI43NDGbgytzbmrSWtcpJpt3P8hau7YEQwMR7kpb+46/2cY7YZk/uQPaUzO9GBHoHIrrW3yBtCt4ih5EaSCbWY42CqOGWxS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIz/fEda; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIz/fEda"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0b260d309so23145ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 15:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775685734; cv=none;
        d=google.com; s=arc-20240605;
        b=QiRHWV24oF8uLv6wVNCn4Wl6+X+XlkxBNx3eJDsGKssaLgepeUcVSlbMpYScqPaugX
         +YNlkiMftMXU2hkwRQ1OifF27yV66WaxQtFmiL+q1g54Y2AT/10lxeueVP0lNVY7BzWt
         mPcxKIdjwvuEopHiM6i5XJKK3XudxzY+7oIqTCoUQ+2WfTngHLcw7KHlfsxZGwgAy+Bo
         xwj2AYyTezubCU+x0hjMEcInIZ5NQ9mjOmW9wgPtkARdIjv5VwEQ6GFmms26kTylGczy
         uceCAIUAt8TA8u1r2H+zCDHvn1FfAJR4qUgVR3lKOuHBvjN6obKr3evzZA3vKaAz4Bdj
         Nh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SWOajSgr8hG1ODX0MoM73LM/tZkfS720NNB404mSsE=;
        fh=tEHirGepMVBtE/RDKVAMJKWI6X65jjajufurQcBIA7Y=;
        b=FKKSPNvBEi9JPqIZwFF2JnsWfuMhKMB1V4PgBFZ34ypSt32x6ZR5FdZnrxcFz27Alx
         AnGC6SR89C7qn+eIKB+vGN7JUeQkH0bxm8kM3BO2ntosYEVO0R5tsTalrWZHfYrWSo6q
         qssUaZSL0TtPMSLI5PEZdQrWjNFKDRNvBG7SmM6bzxLpxwte6E1O/QKo6H5l38k8uVpf
         MOO3aBZkm7JZu151kxYD1PQUmB1o0VKmlUfdD4xTK2NXCXITjasCEZgb/zNELM3JMu2O
         dOKmQfJE2MU3uIDpOcvO3KXyz+vG1iZCgUwEemnOVNsT3EYaENz+L/X2mJads9gBGCuJ
         MPiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775685734; x=1776290534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SWOajSgr8hG1ODX0MoM73LM/tZkfS720NNB404mSsE=;
        b=AIz/fEdaT71qUv0zQ8hgF97qXP6nfd5CI1VY6cTCQIWyl929eaw0wEj+VIfTfcWZSl
         p5klXPR4K1CEhxWjbXKK0tUECSQwB727Vrtrq3pzkJXyK2nmmsfQGN5JatTEDxn7uw7D
         q3q8tcgwTT5vYYnMMPG45b9RW7YhUUQA78oCGNLOyUMylmn8d+8mWI+69dgIaZEJ46ZP
         b5Hyx/LsOlbDpj+a1FMYLYUF/q0Oer/PBLH2mU9QAEF8hrwo1gwQVdczbpyxjQCF98Ev
         m8CxsE8mAuMfFAwC1kPhHXUH9M+CkdPqTU+N+Pli/xyWKuSw9v2j5Yx9/rMLTSDohb/B
         Sj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775685734; x=1776290534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SWOajSgr8hG1ODX0MoM73LM/tZkfS720NNB404mSsE=;
        b=lpr2PXQcZpYmewgtR0r/ZnZ9ZzsHsPDGLKPrUjmHS4LQKoN5pPBG41iSRTSIZ0nAl4
         jq73OhKb/BgW1FNLaK0Ozj3HftxV3AlPkTEoKjFeo+//+/IbR6GrzdQlQuFBzFYoeDi2
         aiiR2iMRfUcY89114GpL83kdHCZbozzXSIsPt9ZB7RX503TUBU+huRgBKFUJ2XSEZaue
         ggn6lKliT6IG8yBFvmTEjLPo+zZ/9O19HmtPTIfLHR9rvCrmU1XGI4XAriHELLxBriUu
         nVW/4nNFuOXEb/WE8YCj4bJdqSytJq9JjFmMCbU0DBnRLIy27fSM2Fxjd9h9+Sny471q
         pQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXUtfIN+t4xDyNAAE6TrvIOcQWjYBcL/tdXyBfBGDtF3eH0bPzQfC7jN883sYbUIyn1O+Dqz/hwp/Am5Q31hUlq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsFO4EV3/fFAVtsfucysdUcOU7Y4FaZkxRVD696zOxVkKDIK8
	240vekm6n4B+etVYnWlFb2nOJ9vLdhEPVbNT2vX1mcWXkLXL5orM0ILYhix14X8dswNKNYF7ojB
	q9IXoUt5/yh6xdXzc5p5n5CzUa3byEoXnXVdPKgHA
X-Gm-Gg: AeBDievNE2PpaRwmqV8CLZsnTFmyE19zpBU4fHbx2DZPWNKo6cdlP4gCd/mmkiEZOew
	MRfoigTnaCyaHx6cFJ2p8k2XbKn0utJHyrDrWuT/bbiKJQY373n8ReAfMsOjaNISSrx/RANeUuS
	mId5aJODd3Mqenu/lcLoAwFkWMxjbwWVHgAPWtmqchUgy/X6j9rfnjUMyJA7X0a5cIvhkr+CPOC
	Hy2DwpNu5FEVuMwkriF0Gpk/Yhz/5e099BzloNzK+Ln5/w/hlcRHKQvCBnlTyGITMSC2pBXegMe
	ktaYL6X2hJSCZ2nIbs4pWlYOjPlrs5a4jsnSbA==
X-Received: by 2002:a17:903:1b4f:b0:2b0:d1f4:f601 with SMTP id
 d9443c01a7336-2b2c8c8586cmr492015ad.15.1775685733595; Wed, 08 Apr 2026
 15:02:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408062048.61252-1-irogers@google.com> <20260408065841.165393-1-irogers@google.com>
 <2bcc84ca-87fd-4111-88ad-225d2e7b2bd9@linaro.org>
In-Reply-To: <2bcc84ca-87fd-4111-88ad-225d2e7b2bd9@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Apr 2026 15:02:02 -0700
X-Gm-Features: AQROBzAxG6zGb0MQs8u39V9phm6hbirW7QrA2b8Ky-49vV8ZqtVkvls0oI-dn_4
Message-ID: <CAP-5=fUgSTa1+m6PXLm6JSxTcvEbZymwwDKqiV_X+OwcKXga9A@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Fixes for check branch stack sampling
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, German Gomez <german.gomez@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:37=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 08/04/2026 7:58 am, Ian Rogers wrote:
> > When filtering branch stack samples on user events they sample in user
> > land but may have come from the kernel. Avoid the target address being
> > a kernel address but allow the source to be the kernel.
>
> Doesn't that leak kernel pointers then? I thought they were supposed to
> be semi secret to not break KASLR? With /u on Arm64 all kernel branch
> addresses are filtered out or zeroed. I think it might be worth adding
> an architecture condition with a different test for Intel if the
> behavior is different. Otherwise we could start leaking pointers on Arm
> and the test would not detect it.

On x86, the filter applies to the LBR target, suggesting a KASLR leak
for LBR sources in the kernel. Wrt the test we could say the test
fails on x86 due to this, but this is kind of annoying at the moment.
I suppose having some kind of flag to say broken sources are allowed
and then setting it on x86 would be best.

> >
> > When filtering branch stack samples on kernel events they sample in
> > kernel land but may have come from user land. Avoid the target being a
> > user address but allow the source to be in user land.
> >
> > Increase the duration of the system call sampling test to make the
> > likelihood of sampling a system call higher (increased from 1000 to
> > 8000 loops - a number found through experimentation on an Intel
> > Tigerlake laptop), also make the period of the event a prime number.
> >
> > Put unneeded perf record output into a temporary file so that the test
> > output isn't cluttered. More clearly state which test is running and
> > the pass, fail or skipped result of the test.
> >
> > These changes make the test on an Intel tigerlake laptop reliably pass
> > rather than reliably fail.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/shell/test_brstack.sh | 134 ++++++++++++++++--------=
-
> >   1 file changed, 84 insertions(+), 50 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/=
shell/test_brstack.sh
> > index 85233d435be6..025ed9d3d110 100755
> > --- a/tools/perf/tests/shell/test_brstack.sh
> > +++ b/tools/perf/tests/shell/test_brstack.sh
> > @@ -40,7 +40,7 @@ is_arm64() {
> >
> >   check_branches() {
> >       if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"=
; then
> > -             echo "Branches missing $1"
> > +             echo "ERROR: Branches missing $1"
> >               err=3D1
> >       fi
> >   }
> > @@ -48,6 +48,8 @@ check_branches() {
> >   test_user_branches() {
> >       echo "Testing user branch stack sampling"
> >
> > +     start_err=3D$err
> > +     err=3D0
> >       perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,=
u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
> >       perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR=
/perf.script"
> >
> > @@ -73,59 +75,80 @@ test_user_branches() {
> >       perf script -i "$TMPDIR/perf.data" --fields brstack | \
> >               tr ' ' '\n' > "$TMPDIR/perf.script"
> >
> > -     # There should be no kernel addresses with the u option, in eithe=
r
> > -     # source or target addresses.
> > -     if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> > -             echo "ERROR: Kernel address found in user mode"
> > +     # There should be no kernel addresses in the target with the u op=
tion.
> > +     if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/" $TMP=
DIR/perf.script; then
> > +             echo "Testing user branch stack sampling [Failed kernel a=
ddress found in user mode]"
> >               err=3D1
> >       fi
> >       # some branch types are still not being tested:
> >       # IND COND_CALL COND_RET SYSRET SERROR NO_TX
> > +     if [ $err -eq 0 ]; then
> > +             echo "Testing user branch stack sampling [Passed]"
> > +             err=3D$start_err
> > +     else
> > +             echo "Testing user branch stack sampling [Failed]"
> > +     fi
> >   }
> >
> >   test_trap_eret_branches() {
> >       echo "Testing trap & eret branches"
> > +
> >       if ! is_arm64; then
> > -             echo "skip: not arm64"
> > +             echo "Testing trap & eret branches [Skipped not arm64]"
> > +             return
> > +     fi
> > +     start_err=3D$err
> > +     err=3D0
> > +     perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,=
k -- \
> > +             perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
> > +     perf script -i $TMPDIR/perf.data --fields brstacksym | \
> > +             tr ' ' '\n' > $TMPDIR/perf.script
> > +
> > +     # BRBINF<n>.TYPE =3D=3D TRAP are mapped to PERF_BR_IRQ by the BRB=
E driver
> > +     check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> > +     check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> > +     if [ $err -eq 0 ]; then
> > +             echo "Testing trap & eret branches [Passed]"
> > +             err=3D$start_err
> >       else
> > -             perf record -o $TMPDIR/perf.data --branch-filter any,save=
_type,u,k -- \
> > -                     perf test -w traploop 1000
> > -             perf script -i $TMPDIR/perf.data --fields brstacksym | \
> > -                     tr ' ' '\n' > $TMPDIR/perf.script
> > -
> > -             # BRBINF<n>.TYPE =3D=3D TRAP are mapped to PERF_BR_IRQ by=
 the BRBE driver
> > -             check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> > -             check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> > +             echo "Testing trap & eret branches [Failed]"
> >       fi
> >   }
> >
> >   test_kernel_branches() {
> > -     echo "Testing that k option only includes kernel source addresses=
"
> > +     echo "Testing kernel branch sampling"
> >
> > -     if ! perf record --branch-filter any,k -o- -- true > /dev/null; t=
hen
> > -             echo "skip: not enough privileges"
> > +     if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/rec=
ord.txt" 2>&1; then
> > +             echo "Testing that k option [Skipped not enough privilege=
s]"
> > +             return
> > +     fi
> > +     start_err=3D$err
> > +     err=3D0
> > +     perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> > +             perf bench syscall basic --loop 1000 > "$TMPDIR/record.tx=
t" 2>&1
> > +     perf script -i $TMPDIR/perf.data --fields brstack | \
> > +             tr ' ' '\n' > $TMPDIR/perf.script
> > +
> > +     # Example of branch entries:
> > +     #       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> > +     # Source addresses come first in user or kernel code. Next is the=
 target
> > +        # address that must be in the kernel.
> > +
> > +     # Look for source addresses with top bit set
> > +     if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script;=
 then
> > +             echo "Testing kernel branch sampling [Failed kernel branc=
hes missing]"
> > +             err=3D1
> > +     fi
> > +     # Look for no target addresses without top bit set
> > +     if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMP=
DIR/perf.script; then
>
> Target can be "0x0" for jumps from the kernel back to userspace with
> only kernel branches turned on. Before we were only looking at source
> addresses but now it looks at targets the test fails on 0x0 targets on Ar=
m.
>
> I suppose we could special case 0x0? It starts to get a bit horrible to
> do in bash with regexes though.

I wonder, then, if the target should require two numbers, like this:
```
if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/"
$TMPDIR/perf.script; then
```

> The rest of the changes look good.

Thanks,
Ian

> > +             echo "Testing kernel branch sampling [Failed user branche=
s found]"
> > +             err=3D1
> > +     fi
> > +     if [ $err -eq 0 ]; then
> > +             echo "Testing kernel branch sampling [Passed]"
> > +             err=3D$start_err
> >       else
> > -             perf record -o $TMPDIR/perf.data --branch-filter any,k --=
 \
> > -                     perf bench syscall basic --loop 1000
> > -             perf script -i $TMPDIR/perf.data --fields brstack | \
> > -                     tr ' ' '\n' > $TMPDIR/perf.script
> > -
> > -             # Example of branch entries:
> > -             #       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> > -             # Source addresses come first and target address can be e=
ither
> > -             # userspace or kernel even with k option, as long as the =
source
> > -             # is in kernel.
> > -
> > -             #Look for source addresses with top bit set
> > -             if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.sc=
ript; then
> > -                     echo "ERROR: Kernel branches missing"
> > -                     err=3D1
> > -             fi
> > -             # Look for no source addresses without top bit set
> > -             if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.scri=
pt; then
> > -                     echo "ERROR: User branches found with kernel filt=
er"
> > -                     err=3D1
> > -             fi
> > +             echo "Testing kernel branch sampling [Failed]"
> >       fi
> >   }
> >
> > @@ -136,14 +159,15 @@ test_filter() {
> >       test_filter_expect=3D$2
> >
> >       echo "Testing branch stack filtering permutation ($test_filter_fi=
lter,$test_filter_expect)"
> > -     perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_=
filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
> > +     perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_=
filter,save_type,u" -- \
> > +             ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
> >       perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/pe=
rf.script"
> >
> >       # fail if we find any branch type that doesn't match any of the e=
xpected ones
> >       # also consider UNKNOWN branch types (-)
> >       if [ ! -s "$TMPDIR/perf.script" ]
> >       then
> > -             echo "Empty script output"
> > +             echo "Testing branch stack filtering [Failed empty script=
 output]"
> >               err=3D1
> >               return
> >       fi
> > @@ -154,26 +178,36 @@ test_filter() {
> >         > "$TMPDIR/perf.script-filtered" || true
> >       if [ -s "$TMPDIR/perf.script-filtered" ]
> >       then
> > -             echo "Unexpected branch filter in script output"
> > +             echo "Testing branch stack filtering [Failed unexpected b=
ranch filter]"
> >               cat "$TMPDIR/perf.script"
> >               err=3D1
> >               return
> >       fi
> > +     echo "Testing branch stack filtering [Passed]"
> >   }
> >
> >   test_syscall() {
> >       echo "Testing syscalls"
> >       # skip if perf doesn't have enough privileges
> > -     if ! perf record --branch-filter any,k -o- -- true > /dev/null; t=
hen
> > -             echo "skip: not enough privileges"
> > +     if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/rec=
ord.txt" 2>&1; then
> > +             echo "Testing syscalls [Skipped: not enough privileges]"
> > +             return
> > +     fi
> > +     start_err=3D$err
> > +     err=3D0
> > +     perf record -o $TMPDIR/perf.data --branch-filter \
> > +             any_call,save_type,u,k -c 10007 -- \
> > +             perf bench syscall basic --loop 8000  > "$TMPDIR/record.t=
xt" 2>&1
> > +     perf script -i $TMPDIR/perf.data --fields brstacksym | \
> > +             tr ' ' '\n' > $TMPDIR/perf.script
> > +
> > +     check_branches "getppid[^ ]*/SYSCALL/"
> > +
> > +     if [ $err -eq 0 ]; then
> > +             echo "Testing syscalls [Passed]"
> > +             err=3D$start_err
> >       else
> > -             perf record -o $TMPDIR/perf.data --branch-filter \
> > -                     any_call,save_type,u,k -c 10000 -- \
> > -                     perf bench syscall basic --loop 1000
> > -             perf script -i $TMPDIR/perf.data --fields brstacksym | \
> > -                     tr ' ' '\n' > $TMPDIR/perf.script
> > -
> > -             check_branches "getppid[^ ]*/SYSCALL/"
> > +             echo "Testing syscalls [Failed]"
> >       fi
> >   }
> >   set -e
>
