Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86858286881
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786252878; cv=pass; b=D2tY3ewg5ggfBeVZqPvVl98mP3nMs3kOkYGnv4yjsqfASTHz/rmo4+08CBg4wqe2N6mssj1M9zJXd7LuqSsgahfbXGQDkySVoHfzuwle8SLZVQUvPtWCnTTLYzCIZiurE9+iLqGbsjs5AhuSzeXcAWYdv02i+gjdOkp3/+2SYmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786252878; c=relaxed/simple;
	bh=Up62g65QngbTFUToYaMap56tTZF4Y5cVjJybkDeVFj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYVYZYpJUKjmbGBcjJdnFFeSiHMit/svJA02/5eSTBjkLrRaAC0SaMTA7zoQQBtZexqcjHFgXNz3apnS0CyzBPqEIWx6xTtbTJpmAwBiShAL3R5TWV8CwEbWsctNJeoekV6RUDA1eXqeGCTL9rMyLxHP67S4nNQWTh/nBPdUWFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRMWx7J8; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRMWx7J8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c10e86e52so143491cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 22:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786252875; cv=none;
        d=google.com; s=arc-20260327;
        b=C1oBwUnGui6JkAPsUdLae9uWFX0XxogwKLlJmt3QPHhZAAdRm158X2cEyA5hkeHFHx
         D/dhOTCxVLySaOj6x15pafXXA9v/k/llQjjUgWBbFwivaDle1mpDaMlA7jNekwhyPS+0
         edUYvmfnvoN5An5wJSHVsNsJ6RZReMR105gwmJOqCecCVEYR4cy0/5Cy6jbIpqjB4PRk
         UPPWqdUcy91D3zSXEVJc7U7elM0iVILjuCFz9mQ3wq+UfUf6bcAHg2JqSuiz4NnzHezi
         Jci8fdBwIw4ftiRGAmGBhxNuMwC36P6dRYx+HkR4uLyIzaHYkbL2d4kjptMDfq7COHG4
         76iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aH3H7G4QWymfQdzerN5raWOzOxXk5MCNv5nHwL0GVcI=;
        fh=8O3QLuUl0xmWmXbUNLztzdmlnruGMxBNTY4qY9M3XtA=;
        b=Xzo5mReb4KaSR/HKxcQIMhPCe/wkBXMmJYzsFbYdSrVjrQTqvrmgiYI8ZlOcBa1QSX
         kAcHL6bnmzd2iR2L/934qwHnG7SjJstQfMqenGDk9zduApjxQKI3jJjPi69DNJZSs4m9
         OoMzXuw2kfbPeNSFOxMt1wUHKCUcL68d2/qLK0mDLPXuoHu56z3RVlPDD3gweyWYdKtm
         +g1FXV9ouDaCjRHlNShM05PelE49au62j3qABOCTRob1HWbUsLAZGiDlcXimsytoSIye
         MCJkdDLb1Y5JsDUq2jmj0x6xmU2jwCJ2Bq7qXjtvphOJUOaXuLsyJ/qi/tUEKBUg0LiD
         9BlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786252875; x=1786857675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aH3H7G4QWymfQdzerN5raWOzOxXk5MCNv5nHwL0GVcI=;
        b=BRMWx7J838vn1D2D2c16BAsDzUcYb6d0zCu6Z7zp6eEWCkN+MuAf7ntswmagjmB4zF
         1tZ8Kb7f/QIN+YQNVmyIShHSKk9XyMS54jV8pBAtYoKSTxJLlQXC5ti9V1wsX28FM8uU
         6ibLK8dNCLD4Hx9J3H6MXg4bbu5GIh+bVbuwmT/g9ErdRr26QBPHG1zXJbOza8c2pyZZ
         YFscZvv2cPK8zvcEf1RIwxUG6A+9jJ+xmbQin9cMJahfrcGRmrSL2XZVBbvWe6bWj/YE
         yGxU8IKTxTF0+DXKLK5B65dSWtpaTVyrAbUhx8vXtEOLEtgHViY2aBDsymjro7RWbiK2
         RkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786252875; x=1786857675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aH3H7G4QWymfQdzerN5raWOzOxXk5MCNv5nHwL0GVcI=;
        b=rSkYSL+WRp0xOQ3arrgFcIgv5n+Sd2XiHDvVppenGotNXN2WIx2oNgH4VYnEPE/FnO
         lseTKsaUhwDVnkGY6oUtaK33ikNthuTz/1FaSOonttIvk/iaAJszmwBaU4IKn1+UKV2O
         /dotvPxsPL1z4nFc1CsWxyLVQtFvPNEhNZtp+we92BoYxVIauHEbuI2/Lmeq7nClx2Ta
         asn+rA8VAu2Re5ymNhteDBUUF6grrUUPn3d+RF6XXmaxvTzqq9Pr6AqxeskOH2M8+byX
         6sRxOjQInECVjeYms2bZK3oWSEFxqPCDEzKLd9b6EwhC73i14Xex1VCTNqUH0NSMRFj8
         PPaA==
X-Forwarded-Encrypted: i=1; AHgh+RqqTHOGUr9JZbpq+SjMEh3bbBIXVvqK2jLsZJ3PUvdX8xkXe+MVF+lx+vJu0pyoez/lYwvnpY+Ceu4GzcCYaD9p@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQucZtt8agDgDtzIZ+sZ2DqAJhNjG456uHdZ30jjx5FcOGUFw
	GmexUTk0vx/yfYdpAUjXyRth0MENdp1zxfCtghgUWXuGz+ymx7/T1E2zNuLdnHF+Q0FcDm1QNIB
	R2mU2kFxRVGXajzN2zqdSZMx//2ziYlsQ5/QYjJyn
X-Gm-Gg: AR+sD102gKRvo+kTeTCBRYoJBf6WEf/BKyMnRj4CgqlaMGDyWbDIkd/+PgdGY25Czq3
	EGS87MTPYphqv3/Ukgj8wKwgc+fDwrfb0klvpEh2ozIMxuTxQ36GEN6r9Ilr5Mckn3waU1x7y/8
	EDyO3/tiISiZ3CiEGFobFBDIDUEMi5JlyLyDVcwj6/1yEwFjKBTyIbjFZ2kF+bs+Cu72ElqcJzT
	+zKLSrJRGS65UjTzXzYaBqJRLJMKF8By0yO4bVteG4cRS5mC4hOKfkLNCCRZrYvcVwpPt9MJf1e
	mg9CL7S3CScA/xTmNLFTx+Kf63CAGF6FOYyFDwWGu0dhxtwWW088tWkh
X-Received: by 2002:a05:622a:7901:20b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-52d28101332mr11783831cf.7.1786252874873; Sat, 08 Aug 2026
 22:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808065743.2328212-1-irogers@google.com> <20260809041638.2402705-1-irogers@google.com>
 <20260809041638.2402705-3-irogers@google.com>
In-Reply-To: <20260809041638.2402705-3-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 8 Aug 2026 22:21:02 -0700
X-Gm-Features: AUfX_mypwZz3BRhQv8xAA60gGyTbYyEGHjaTnZgY6BA5hubq5d9woymRWq1vbxs
Message-ID: <CAP-5=fWoWEa-zuzMHTP1bL7ww6zcHPQra3vt_-4TxN27C0sqtA@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Fixes for check branch stack sampling
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 9:16=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> When filtering branch stack samples on user events they sample in user
> land but may have come from the kernel. Avoid the target address being
> a kernel address but allow the source to be the kernel.
>
> When filtering branch stack samples on kernel events they sample in
> kernel land but may have come from user land. Avoid the target being a
> user address but allow the source to be in user land.
>
> Increase the duration of the system call sampling test to make the
> likelihood of sampling a system call higher (increased from 1000 to
> 8000 loops - a number found through experimentation on an Intel
> Tigerlake laptop), also make the period of the event a prime number.
>
> Put unneeded perf record output into a temporary file so that the test
> output isn't cluttered. More clearly state which test is running and
> the pass, fail or skipped result of the test.
>
> These changes make the test on an Intel tigerlake laptop reliably pass
> rather than reliably fail.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sorry, sent in error. This change is already merged.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_brstack.sh | 134 ++++++++++++++++---------
>  1 file changed, 84 insertions(+), 50 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> index 85233d435be6..025ed9d3d110 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -40,7 +40,7 @@ is_arm64() {
>
>  check_branches() {
>         if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$1"=
; then
> -               echo "Branches missing $1"
> +               echo "ERROR: Branches missing $1"
>                 err=3D1
>         fi
>  }
> @@ -48,6 +48,8 @@ check_branches() {
>  test_user_branches() {
>         echo "Testing user branch stack sampling"
>
> +       start_err=3D$err
> +       err=3D0
>         perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,=
u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
>         perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR=
/perf.script"
>
> @@ -73,59 +75,80 @@ test_user_branches() {
>         perf script -i "$TMPDIR/perf.data" --fields brstack | \
>                 tr ' ' '\n' > "$TMPDIR/perf.script"
>
> -       # There should be no kernel addresses with the u option, in eithe=
r
> -       # source or target addresses.
> -       if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -               echo "ERROR: Kernel address found in user mode"
> +       # There should be no kernel addresses in the target with the u op=
tion.
> +       if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[89a-f][0-9a-f]{15}/" $TMP=
DIR/perf.script; then
> +               echo "Testing user branch stack sampling [Failed kernel a=
ddress found in user mode]"
>                 err=3D1
>         fi
>         # some branch types are still not being tested:
>         # IND COND_CALL COND_RET SYSRET SERROR NO_TX
> +       if [ $err -eq 0 ]; then
> +               echo "Testing user branch stack sampling [Passed]"
> +               err=3D$start_err
> +       else
> +               echo "Testing user branch stack sampling [Failed]"
> +       fi
>  }
>
>  test_trap_eret_branches() {
>         echo "Testing trap & eret branches"
> +
>         if ! is_arm64; then
> -               echo "skip: not arm64"
> +               echo "Testing trap & eret branches [Skipped not arm64]"
> +               return
> +       fi
> +       start_err=3D$err
> +       err=3D0
> +       perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,=
k -- \
> +               perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
> +       perf script -i $TMPDIR/perf.data --fields brstacksym | \
> +               tr ' ' '\n' > $TMPDIR/perf.script
> +
> +       # BRBINF<n>.TYPE =3D=3D TRAP are mapped to PERF_BR_IRQ by the BRB=
E driver
> +       check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> +       check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> +       if [ $err -eq 0 ]; then
> +               echo "Testing trap & eret branches [Passed]"
> +               err=3D$start_err
>         else
> -               perf record -o $TMPDIR/perf.data --branch-filter any,save=
_type,u,k -- \
> -                       perf test -w traploop 1000
> -               perf script -i $TMPDIR/perf.data --fields brstacksym | \
> -                       tr ' ' '\n' > $TMPDIR/perf.script
> -
> -               # BRBINF<n>.TYPE =3D=3D TRAP are mapped to PERF_BR_IRQ by=
 the BRBE driver
> -               check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> -               check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> +               echo "Testing trap & eret branches [Failed]"
>         fi
>  }
>
>  test_kernel_branches() {
> -       echo "Testing that k option only includes kernel source addresses=
"
> +       echo "Testing kernel branch sampling"
>
> -       if ! perf record --branch-filter any,k -o- -- true > /dev/null; t=
hen
> -               echo "skip: not enough privileges"
> +       if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/rec=
ord.txt" 2>&1; then
> +               echo "Testing that k option [Skipped not enough privilege=
s]"
> +               return
> +       fi
> +       start_err=3D$err
> +       err=3D0
> +       perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> +               perf bench syscall basic --loop 1000 > "$TMPDIR/record.tx=
t" 2>&1
> +       perf script -i $TMPDIR/perf.data --fields brstack | \
> +               tr ' ' '\n' > $TMPDIR/perf.script
> +
> +       # Example of branch entries:
> +       #       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> +       # Source addresses come first in user or kernel code. Next is the=
 target
> +        # address that must be in the kernel.
> +
> +       # Look for source addresses with top bit set
> +       if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script;=
 then
> +               echo "Testing kernel branch sampling [Failed kernel branc=
hes missing]"
> +               err=3D1
> +       fi
> +       # Look for no target addresses without top bit set
> +       if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMP=
DIR/perf.script; then
> +               echo "Testing kernel branch sampling [Failed user branche=
s found]"
> +               err=3D1
> +       fi
> +       if [ $err -eq 0 ]; then
> +               echo "Testing kernel branch sampling [Passed]"
> +               err=3D$start_err
>         else
> -               perf record -o $TMPDIR/perf.data --branch-filter any,k --=
 \
> -                       perf bench syscall basic --loop 1000
> -               perf script -i $TMPDIR/perf.data --fields brstack | \
> -                       tr ' ' '\n' > $TMPDIR/perf.script
> -
> -               # Example of branch entries:
> -               #       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> -               # Source addresses come first and target address can be e=
ither
> -               # userspace or kernel even with k option, as long as the =
source
> -               # is in kernel.
> -
> -               #Look for source addresses with top bit set
> -               if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.sc=
ript; then
> -                       echo "ERROR: Kernel branches missing"
> -                       err=3D1
> -               fi
> -               # Look for no source addresses without top bit set
> -               if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.scri=
pt; then
> -                       echo "ERROR: User branches found with kernel filt=
er"
> -                       err=3D1
> -               fi
> +               echo "Testing kernel branch sampling [Failed]"
>         fi
>  }
>
> @@ -136,14 +159,15 @@ test_filter() {
>         test_filter_expect=3D$2
>
>         echo "Testing branch stack filtering permutation ($test_filter_fi=
lter,$test_filter_expect)"
> -       perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_=
filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
> +       perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_=
filter,save_type,u" -- \
> +               ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
>         perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/pe=
rf.script"
>
>         # fail if we find any branch type that doesn't match any of the e=
xpected ones
>         # also consider UNKNOWN branch types (-)
>         if [ ! -s "$TMPDIR/perf.script" ]
>         then
> -               echo "Empty script output"
> +               echo "Testing branch stack filtering [Failed empty script=
 output]"
>                 err=3D1
>                 return
>         fi
> @@ -154,26 +178,36 @@ test_filter() {
>           > "$TMPDIR/perf.script-filtered" || true
>         if [ -s "$TMPDIR/perf.script-filtered" ]
>         then
> -               echo "Unexpected branch filter in script output"
> +               echo "Testing branch stack filtering [Failed unexpected b=
ranch filter]"
>                 cat "$TMPDIR/perf.script"
>                 err=3D1
>                 return
>         fi
> +       echo "Testing branch stack filtering [Passed]"
>  }
>
>  test_syscall() {
>         echo "Testing syscalls"
>         # skip if perf doesn't have enough privileges
> -       if ! perf record --branch-filter any,k -o- -- true > /dev/null; t=
hen
> -               echo "skip: not enough privileges"
> +       if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/rec=
ord.txt" 2>&1; then
> +               echo "Testing syscalls [Skipped: not enough privileges]"
> +               return
> +       fi
> +       start_err=3D$err
> +       err=3D0
> +       perf record -o $TMPDIR/perf.data --branch-filter \
> +               any_call,save_type,u,k -c 10007 -- \
> +               perf bench syscall basic --loop 8000  > "$TMPDIR/record.t=
xt" 2>&1
> +       perf script -i $TMPDIR/perf.data --fields brstacksym | \
> +               tr ' ' '\n' > $TMPDIR/perf.script
> +
> +       check_branches "getppid[^ ]*/SYSCALL/"
> +
> +       if [ $err -eq 0 ]; then
> +               echo "Testing syscalls [Passed]"
> +               err=3D$start_err
>         else
> -               perf record -o $TMPDIR/perf.data --branch-filter \
> -                       any_call,save_type,u,k -c 10000 -- \
> -                       perf bench syscall basic --loop 1000
> -               perf script -i $TMPDIR/perf.data --fields brstacksym | \
> -                       tr ' ' '\n' > $TMPDIR/perf.script
> -
> -               check_branches "getppid[^ ]*/SYSCALL/"
> +               echo "Testing syscalls [Failed]"
>         fi
>  }
>  set -e
> --
> 2.53.0.1213.gd9a14994de-goog
>
