Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811A34041B
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785975370; cv=pass; b=MCfLiV72V1t+WJh2wG9OTnyQcgkyM5czebJUccjq7qNGPsScY8QPh89T+9Jo7/73QanMXJxzMmnkk8DE9TUbfFdDLKe3AoMA04szCKFlcb3R+EHxGa5fiDzsxXgRqcQhBAo15zBtJDn33DoBWU8jUhxk98dmBqTfTyTBMVt9HnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785975370; c=relaxed/simple;
	bh=1d1lwssoXt/w5UuPQU/V3n6PBSQN2l8ZbVnAVXA8kxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORUt8nRGc0/VQO+dEcVmVYKk+/0dQ1ZksB9bj/azJ2iKz5u8ORRPW9ReZhoOdX5EKW97fG5zZ3cSgKem+BDZpigNbD+wF9jOa0g2TaCWOqTTxH+HLz5pJar9IP60HxIzNbPJ00V0v0MHyd5K8+iOMiJY+WAeNyS5pNhjYP/Vtp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU/hA32L; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU/hA32L"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c15a5b265so133151cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 17:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785975367; cv=none;
        d=google.com; s=arc-20260327;
        b=mpnM4Ptq2iaF6rkcsl6mjwGSGMEudNkJNHtiMIBqXpCcV3WGVYraFlPfmGNj1R4Eg4
         9t+W0k2naguG7jqwHXilZN9G7jxkGNKmVYaZO2cREji0vyHYZi8gcypvc3KhLQBvj+Ad
         NOw8K52NE+2nnCDPzcOpwkO+ormSFA6Wn/PbF5fnV3V/DIEpgmW1A53T5i01VzniK9fj
         yUNzkj+g7QDQYz5qyKmitswbzOf5TfOxA/BFg6rzcLpqEphYZRB/z3PtdTtKVuGEdD/9
         pSKY7ZVd0duHHTtwVW+viq1PKKlUiXGoJDUKHeEGZpWtx0KrB5l33M53fdK1/xa40F2b
         hy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bnWyP7WVZZFVkw6ro1iq5X3/hgo721ZOiHIybOUHuO8=;
        fh=ot9dwXDpPtDjzw7qNwMIN7TsK0PKk7dg+fPdGSFFrUA=;
        b=LY/A8FtYiOGlbkNcmzlPBU9U5h16KIt2v9CTPzJbde1wVAcNtfBr7L8K51WIccij0z
         1EaJwA+X7kSHydmNWq0ceECZ0ME9mizrI+SaxEF7HMNQoha3nWgFvO5lPt9jJ5jqjguW
         FySZrNvggbxZrzghhpgOCI5/ZGkGfnp03Qc3hgCnyfE+pmERkO5dX8ChFnVyWdDa62WH
         pK/WZ2Ruw7+5RhRxwomAZC/g2fYGb4Qi746hs4C7zHtn+wnJy2bfmwp2SmJ+Hur5j4No
         XYrEsVpHVHto2QpXHVVLiqiPooR0P+s6LbFhM6GrX4ggzMu4ngwCgCrfEK43bi2iI8W7
         Y/eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785975367; x=1786580167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bnWyP7WVZZFVkw6ro1iq5X3/hgo721ZOiHIybOUHuO8=;
        b=qU/hA32L3C69GylP3DjoklIxAkpiDzy2grFf9Dx4WUi0KDI6PIOxpcw2RWZSPb9BQo
         SH+YZcJvkvA2REHtBJTAn8HajF95cuSnHOMsGxZdMooMWf550vb2o8mnsgRj0qAG5/8+
         nZF/BCKzVQXTtvxna/Uw7RlO2D9qs2v0rtYfASus8zmslykfSiUgPiOXdGFQUH5WtaRR
         cwN7z09m9h6MVaIsply+MN9108TeCTPpKI6I6YvrLPohee70iJjf7s/qJ5VpozZ/ZTet
         lrN4ilXjW0trhp4HvsIfXUI6LTU/K3HM+ZkdruAves/GAwjBc87etQjIA3vsf+Wi/UFv
         folw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785975367; x=1786580167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnWyP7WVZZFVkw6ro1iq5X3/hgo721ZOiHIybOUHuO8=;
        b=ZrOaa0lTH5TJBHGZ2Q9wARKplLNlmmjfrfCMpB9ra6gHEjqwNWXbUhDSk4YpwMAmW+
         6ULv+Oj7KS7c++enY8+wrQuZ+aSP5hovSXS8ormmoeQZruyA+T/PVx2ysbiJRJcbYzDb
         4/VcjTLTcTEKJcI4Ey969CkxFwS+rxXTk+h1ZaxMP7/1pHameKgXHJOGxfDyhH/5lTEx
         43byAsUJWC6NgpCCZt2WhEzpHRWW2ZjnAiNLhv6t9Iio9QXLkYcOy/VseUJUEUwTtpKO
         x6qZruPujGa7XO9HGvyKAcxGNseQaRE5uf2+3/vzxYYJLokQaYVNl8Y+tt1vUcZcnHvy
         liGg==
X-Forwarded-Encrypted: i=1; AHgh+Rodwdbwqtw82ZQpCGN91MNFwnb9fml4qxdVqyKTrNMf1ypkKI+mOmdvOTWLL+KDheY4bm7XBOPxwLxdu7M8pWnK@vger.kernel.org
X-Gm-Message-State: AOJu0YyXf2sxQvTzAHWNqTjI86yc9JyT5Vw2Vi1xVY5H99FYyqJP+whz
	9FpKtRLJXZEyak1vf//k22ilAwOaOKux9WssYZnEiLo7xnDtb69QXzcUnYudbaGlwUX+ePteSaH
	4a/BAqsI92QZ/Sk2+/fMl5jBT7hKmpJEtfYv6kVKp
X-Gm-Gg: AR+sD11FbmnHaA+e59TdsRCp32GqHl4KAJkYm9U7auSECj6Bvg1mQz8KMTIEW3NWqYr
	EfFz8pYNiYu7OwFz2ov8m5D9dYwk10GLnJrkIvgxFeqd04Q9WalcWX1marN3nJ6j1pm4ID0xYKy
	2NVLQ6fkZCmFfeyPdaGz5OlKrRakSvsD+FU9GvV4dBslg1095Soedg6rUx8v9KAWRB6lJ7JXmXH
	am48wFmWWE20ura12YDU0u8t4+reF7Ukna7bQLHhW2NSqdZ6unq1NUeR5C7PeH5idfUr20HiNEj
	c43+TRFB23BuIAc9grVF7/tONe5plT/AjkfkGfv6zw0y8Dtz5yhw/tMOXg==
X-Received: by 2002:ac8:5a8e:0:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-52cfbf93393mr7508971cf.12.1785975366564; Wed, 05 Aug 2026
 17:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803145958.299956-1-tshah@linux.ibm.com> <20260803145958.299956-6-tshah@linux.ibm.com>
 <20260803151949.4AE511F000E9@smtp.kernel.org>
In-Reply-To: <20260803151949.4AE511F000E9@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 17:15:55 -0700
X-Gm-Features: AUfX_mzeNGmPjxUntgQr96gtXyWAyCXdz3ohPUmClKstehdq3XsFqbp4I_lbXmU
Message-ID: <CAP-5=fXdA1YvAoqp61DddxsW4VwjJdmULYOqxk_2e-UAA=E_sA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] perf test: Add test validating trace.dat
 generated by 'perf data convert --to-trace-dat'
To: sashiko-reviews@lists.linux.dev
Cc: Tanushree Shah <tshah@linux.ibm.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 9:50=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Deleting a securely created temporary file and reusing its path =
creates a race condition vulnerable to symlink attacks.
> - [Medium] The exit trap incorrectly overrides intentional test skips (ex=
it code 2), converting them into test failures (exit code 1).
> - [Medium] Hardcoding the 'cycles' hardware PMU event leads to brittle, s=
purious test failures on environments without hardware performance counters=
.
> - [Low] Stale output file verification due to incorrect cleanup ordering =
on error paths.
> - [Low] A temporary file may be leaked if a subsequent initialization ste=
p fails before the cleanup trap is registered.
> --
>
> --- Patch [5]: [RFC PATCH v3 5/5] perf test: Add test validating trace.da=
t generated by 'perf data convert --to-trace-dat' ---
> commit d717cd6622789cb3b2cd038490f59972dc4015dd
> Author: Tanushree Shah <tshah@linux.ibm.com>
>
> perf test: Add test validating trace.dat generated by 'perf data convert =
--to-trace-dat'
>
> Add a shell test covering perf data convert --to-trace-dat,
> alongside the existing --to-json and --to-ctf tests.
>
> > diff --git a/tools/perf/tests/shell/test_perf_data_converter_tracepoint=
s_trace_dat.sh b/tools/perf/tests/shell/test_perf_data_converter_tracepoint=
s_trace_dat.sh
> > new file mode 100755
> > index 0000000000000..9ca6432618cb2
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace=
_dat.sh
> > @@ -0,0 +1,169 @@
> > +#!/bin/bash
>
> [ ... ]
>
> > +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > +result=3D$(mktemp /tmp/__perf_test.output.trace.dat.XXXXX)
>
> [Severity: Low]
> Could a temporary file be leaked if an early initialization step fails?
>
> If the second mktemp fails, the script will exit immediately due to 'set =
-e'.
> Since the trap is not yet registered, the first temporary file allocated =
for
> $perfdata wouldn't be cleaned up.
>
> [ ... ]
>
> > +trap_cleanup()
> > +{
> > +     echo "Unexpected signal in ${FUNCNAME[1]}"
> > +     cleanup
> > +     exit 1
> > +}
> > +trap trap_cleanup exit term int
>
> [Severity: Medium]
> Does this trap handler unintentionally override test skips?
>
> When the script explicitly executes 'exit 2' for a skip condition (like
> missing libtraceevent), the EXIT trap is still active. This handler then
> executes 'exit 1', which converts the skip into a spurious test failure.
>
> [ ... ]
>
> > +test_trace_converter_command()
> > +{
> > +     echo "Testing Perf Data Conversion Command to trace.dat"
> > +
> > +     if ! perf record -e sched:sched_switch -o "$perfdata" -- sleep 0.=
1
> > +     then
> > +             echo "Failed to record perf data"
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     rm -f "$result"
>
> [Severity: High]
> Does removing the securely created file path here open a symlink race
> condition?
>
> The script uses mktemp to securely allocate the path for $result, but del=
etes
> it before passing it to the converter with the --force flag. This leaves
> a time window where a predictably named path is free. If run as root, thi=
s
> could potentially be replaced with a symlink, allowing an arbitrary file
> overwrite.
>
> [ ... ]
>
> > +test_trace_converter_pipe()
> > +{
> > +     echo "Testing Perf Data Conversion Command to trace.dat (Pipe mod=
e)"
> > +
> > +     rm -f "$result"
>
> [Severity: High]
> This test mode appears to have the same symlink race condition as above,
> since the securely allocated temporary file is removed prior to use.
>
> [ ... ]
>
> > +test_trace_converter_mixed_events()
> > +{
> > +     echo "Testing Perf Data Conversion with tracepoint and non-tracep=
oint events"
> > +
> > +     # Record both tracepoint and non-tracepoint events
> > +     if ! perf record -e sched:sched_switch,cycles -o "$perfdata" -- s=
leep 0.1
>
> [Severity: Medium]
> Could hardcoding the 'cycles' hardware PMU event cause spurious test fail=
ures
> on restricted environments?
>
> If the hardware 'cycles' event fails to open on virtual machines or
> unprivileged containers, perf record will return an error and fail the te=
st
> step instead of skipping it or falling back to a software event.

As the `perf record` lacks the `-a` flag this will just record events
for the sleep command and the number of cycles there will be limited.
I'd suggest making this:
perf record -e sched:sched_switch,cpu-clock -a -o "$perfdata" -- sleep 0.1
The cpu-clock is a perf event based on a timer interrupt and should
always exist whether the system be an S390 or a limited system such as
running in a hypervisor.

Thanks,
Ian

> > +     then
> > +             echo "Failed to record perf data (mixed events)"
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     rm -f "$result"
>
> [Severity: Low]
> Does this cleanup ordering leave stale data available for validation on e=
rror
> paths?
>
> If the 'perf record' command above fails, it returns early before this fi=
le
> is removed. When validate_trace_format() is later called in the global fl=
ow,
> it will check the $result file left over from the preceding
> test_trace_converter_pipe() execution, which might erroneously report suc=
cess
> for a failed command.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803145958.29=
9956-1-tshah@linux.ibm.com?part=3D5
>
