Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5263A4F5A
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109554; cv=pass; b=GbKRxS2TY1lzCD0AthUq5tL5vpJjgBeSz0C4ZyIlbu/TrZ2x4fF/FIe/aliQiD+96vh5ViKGpYGZJ1G10jP6fiYJl7wq0s95Z5aF69iM94dObhWnl7wybE7D8dmA/JmJCPpf53nBZvQsvvDOgil+JWNjkvfh+RvvZBJQdJ7ffMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109554; c=relaxed/simple;
	bh=p64YFp+dfmEmhDaHotVfRaxfJG9FnU5vQjtNZ+89mEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzs7fFO3x0e8fc1B/zYRYDJifO9xwpvVs1XyhfjDzuJXqyWYA4Pqay6O7KQcmCUldFYDLlxcVmMKivUDDAvSymVHThcdzR21dXls06CuBNi5LRmy5LVElRsNrPM8mx4m9WbT3PdR8jQXUSma67R/4JtRIPiz5QEn7+f2ba7NbDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkaZ+uGe; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkaZ+uGe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso145735ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 12:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776109552; cv=none;
        d=google.com; s=arc-20240605;
        b=SmNLDivReBYfq+9RGGCfX2eCBFr8Dm3j/rqwNnTfga9sr9ZM2qYwD9RjdORjnV74g0
         AMGXHvUqgIzBE40Ez7CgW77Ya/SEKB3qQAh9l1+2c9Bsoh8jigL4p5aEH5rsPE+f/TRE
         FJF58FFlkhQ3AcSeKJFKz8hcmQ6wjlg4w4d+ehx3PBF8vHaXSACHHcqnkWG9ovpI/ED2
         /+ICO+qmmf0s25UH7k8k4iU6XzS9Pfmyj4m3J5l5MLlf0kMKFm4+XzLB7W/YEzeKzGXW
         rCgTshvBGJQM7tHKFx5R8GAEqSwR35zZUnQf/FURHqANqmcVIBNbTQtwrPJnlid4BKgp
         WYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9gV6Gp+J9cn3VxGJTowleis/PLD6erds42ASMvYeXgU=;
        fh=GU0T4iyjr1pzZD30i0ie5azXQq85sveHBxksAxLc27o=;
        b=ddZqmuNhfy0n71rjzGxlVQ/Ajf+9sTGob274tZzSfshPmHjbS5wF2VGbMDclMoECx8
         /nTxqpaVrnqhMIeaPbPTn3GOLJgvRKShOpI4UjngQvh6ilTQkAON2GjHTPDpjEuLXDJZ
         NLAgxhcBbt2NjzpkNofgm638lJo8qg3Ko678hCM/i04gdCBb1Yxrp9Fdww/BeLnB1UsW
         5hiIqovX1Y+J3mvfV1VqIRqZ+cqH+vgxm1AtFEXNPbxbky4NMYE3GUxtBNAmxhwcogXg
         MeSZAdSkJNP0rM682Dwb9UpsKqP9AGTgxIlEE3c/YdZHzUtzGzZbJB7rCB48kAMtNkjY
         5uhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776109552; x=1776714352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gV6Gp+J9cn3VxGJTowleis/PLD6erds42ASMvYeXgU=;
        b=BkaZ+uGecmEH12FX/ehQErY1+4Zrfn+TutN7Q/GuwSl8nSC/v8eCnWfi5TsTyVE54V
         TaKP7kpuyuo5klQvBkjPUnKyD9NQj8/bULAflm4Fwl9J6ltzbQmB1neIcVwjH1HJgroW
         dvucVED3YJ8QWK6Va4nzKtuaASstMpnwZbFi9Jjt/6+6zU2ukVjxjjG6BU8yo9uNLbUw
         6uAy0aa9yCvH25+XKahI9LNhfzzEf20s6Mi4dGa3S1fDqdEoiRcpXH11pEiYBdEr4O2/
         EFjQLhKkG0H8YsyKwCgB38J1wLT7j6KgZpDJzPOKJgfrSuEhpXmAvt98DfK6clTR+om/
         dqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109552; x=1776714352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9gV6Gp+J9cn3VxGJTowleis/PLD6erds42ASMvYeXgU=;
        b=YO4mXDN/05g/OIJyz2+/dRcZ4nlH3DmkBWD25/2wH1a1jxv2gVKjepuE3Wp9dnulvG
         KUJgMRa8NhSTYQ+IIWs89KVBEvgbBVFtsC8eHjnYmUrHoop5aenf5t/RBWMbyHmfQHxx
         Ys0EayIVsrpOm+1Rl+YK4viMBzxyjQTFqna5dKfrw6wn1AL6lNq+pH+/fcP4LRY+iXde
         NSm4Wmv4UOQurNK4K5sRo4Q56NjFMboEAy0iAN7pT1EVsFyNgKwXOrMPjbjRTTEf/BAY
         T8syBi9NyBgbdQ+RLCH7SGQtqEOPWUOdUiARycNJ9lFtAogHFXf+EBvnYTRdVnXTqzMk
         1gsg==
X-Forwarded-Encrypted: i=1; AFNElJ9r0B923V9+owwCIA8tTMcWnwMJBq5TlsE2b2wPgKHmJ9kOyAx9GXUlvUihYZhLbyyAzwHoaDbAox0iGtqV7ULg@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsav+mIBRcFV93FTpukhlVdAduGTwKhIOcksBKlwZ3k4RIYoX
	hV2y6Smxr2lbWIZnKy0dcUhVSTw/X4W4tWQqn6QVuftlPFS98h1EAtiZkCquogiDP2cArgU/mZy
	9PT7yVx7u/4UE+GdyPAzE7qnKch4Kxb6YE49ZiBcz
X-Gm-Gg: AeBDievZlqJmWhS7F8aq0nbVnI0Dkuvr51wWSXu2mzf25Z59THH/czvGa20S77a+iOp
	zUwyW2ly1EMfWkutsQXt6MDQLc7/HwJvj3ScBBgVpHQDlnoIf3s7gDJ2d/D+NuqDvoIvzfKzVV2
	yXRbWDgtmQQRD2PoO4PGPT8hMX1wxIV4QMKIWrqlDN8EmS9gcLAQCzJfSXM0JkF0bdjX5wMUZiM
	r4IxKtngJFEmmEBZXj3pvtbaUB9TLTNu7DcmrDEG8zmrK0E4OhJMCc39JUDzoj73o/NIQ5oy69y
	ON+XHEVjy9LyxAhoHyZeuy+ICVRB9rsYnEptRsr6Uuhtd6QLrWETQtzObrk7yxjETyUkDQ==
X-Received: by 2002:a17:902:d642:b0:2b2:70ba:304b with SMTP id
 d9443c01a7336-2b2c79eaf7cmr8424765ad.10.1776109551763; Mon, 13 Apr 2026
 12:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUgSTa1+m6PXLm6JSxTcvEbZymwwDKqiV_X+OwcKXga9A@mail.gmail.com>
 <20260409000216.196083-1-irogers@google.com> <1d6da8c9-c8e2-4edf-adee-7eac2f832c51@linaro.org>
In-Reply-To: <1d6da8c9-c8e2-4edf-adee-7eac2f832c51@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Apr 2026 12:45:40 -0700
X-Gm-Features: AQROBzDE5VkH6gOFd3XJpTdmx21qLJk0oVgNrWyddTVgXmPyalqnrOXqPtLUP8o
Message-ID: <CAP-5=fV9HuiZmo6yKPZ3JugCU5DXkEM6dxo-OZpK2MnB5BCn2g@mail.gmail.com>
Subject: Re: [PATCH v4] perf test: Fixes for check branch stack sampling
To: James Clark <james.clark@linaro.org>, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	german.gomez@arm.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 1:23=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 09/04/2026 1:02 am, Ian Rogers wrote:
> > When filtering branch stack samples on user events they sample in user
> > land but may have come from the kernel. Aarch64 avoids leaking the
> > kernel address for kaslr reasons but other platforms, for now,
> > don't. Be more permissive in allowing kernel addresses in the source
> > of user branch stacks.
> >
> > When filtering branch stack samples on kernel events they sample in
> > kernel land but may have come from user land. Avoid the target being a
> > user address but allow the source to be in user land. Aarch64 may not
> > leak the user land addresses (making them 0) but other platforms
> > do. As the kernel address sampling implies privelege, just allow this.
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
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks James, hopefully this will be included in the merge window.

Ian

> > ---
> > v4: Address feedback from James Clark.
> > v2,v3: Address Sashiko feedback.
> > ---
> >   tools/perf/tests/shell/test_brstack.sh | 146 ++++++++++++++++--------=
-
> >   1 file changed, 96 insertions(+), 50 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/=
shell/test_brstack.sh
> > index 85233d435be6..eb5837f82e39 100755
> > --- a/tools/perf/tests/shell/test_brstack.sh
> > +++ b/tools/perf/tests/shell/test_brstack.sh
> > @@ -38,9 +38,13 @@ is_arm64() {
> >       [ "$(uname -m)" =3D "aarch64" ];
> >   }
> >
> > +has_kaslr_bug() {
> > +     [ "$(uname -m)" !=3D "aarch64" ];
> > +}
> > +
> >   check_branches() {
> >       if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"=
; then
> > -             echo "Branches missing $1"
> > +             echo "ERROR: Branches missing $1"
> >               err=3D1
> >       fi
> >   }
> > @@ -48,6 +52,8 @@ check_branches() {
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
> > @@ -73,59 +79,88 @@ test_user_branches() {
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
> > +     local regex=3D"0x[89a-f][0-9a-f]{15}"
> > +     if has_kaslr_bug; then
> > +             # If the system has a kaslr bug that may leak kernel addr=
esses
> > +             # in the source of something like an ERET/SYSRET. Make th=
e regex
> > +             # more specific and just check the target address is in u=
ser
> > +             # code.
> > +             regex=3D"^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/"
> > +     fi
> > +     if grep -q -E -m1 "$regex" $TMPDIR/perf.script; then
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
> > +     # address that must be in the kernel.
> > +
> > +     # Look for source addresses with top bit set
> > +     if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script;=
 then
> > +             echo "Testing kernel branch sampling [Failed kernel branc=
hes missing]"
> > +             err=3D1
> > +     fi
> > +     # Look for no target addresses without top bit set
> > +     if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" $TMP=
DIR/perf.script; then
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
> > @@ -136,14 +171,15 @@ test_filter() {
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
> > @@ -154,26 +190,36 @@ test_filter() {
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
>
