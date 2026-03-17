Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E32DA769
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763502; cv=pass; b=oFanpe3NlooCWI1yNo62O7+JwmU1sdRnEqL92uednvTbIcjhw0YKkOXpv4ZBEE+PQoJmwHtHxaJA45MljoEhEbFKVWNZotAWlTIHh7ZidarJNdRE5J7QYUNE1zSmRJ0xQThK+3ughYbQ8VNU8wZ4pl/XX030OrRvrs8wDzseu9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763502; c=relaxed/simple;
	bh=R6gnAz6ztgGMrGhNoMEtTglq0jnKcNeYRifcvhCgvNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWFOmeLaXLdonjzkDC6J0SJFQ9J2vxgDEqsIOjiJu/hrES/20oPh47CYMO8HKsC8gbmR+XZAdqO3QBU8sXv2D+/20QLiNyFs6TU0Ek8RTUsgoxp4Kfo4Q2b8Kpui4A5rwXj4QI6em4Io6c0XMb5cehAZdqd8yIMl3myPZa2SaXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wqbr0qQc; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wqbr0qQc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aeab6ff148so94835ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 09:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763501; cv=none;
        d=google.com; s=arc-20240605;
        b=R38gMXlSpOO8RgouzTYCuySA3UQQofay4S/GGllhrSvq8X043QtFW4JBU0JG7GEnlK
         +J+lJHlP6Y5sHbzJLopKVM/ndunIBw8W2QD8oXCaZTlrvzoDWesbTbCaBPBKRBgrOm+Z
         sdmdAZ2alGLZoOkzoS22b9Mi56lePLxTVSzmvJkPMaBb9Xhm8a+9r0cHeNQNdBzQSI5S
         C+V0B/w1zHYR1CNZV6XQbP7TeAVJxutswJvLrdznEeFcrMfXzkreNlbRLbjliWjjG9mT
         CIXqyhKnDzevwYSiLf3weG8AEdybr5zeDh9epTdlKD3lLqIYLO1XtzRkqYMhFAP0uTY/
         KHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
        fh=q48FdaYLKoDeqZUK1LKtJgKPmfL+ojphVNg+HdZU1ds=;
        b=A0b/M5bqaEnWb9NotFm6osz6PA1DnhJ8pslkLtAmfPvzVqQvuYlzdBPNmDyz0GrtRB
         f9zWfAlKj3V9FPg0IhP7hNwjYT1yS9fhq12QES3N4+e9vGynm9KJH1TUNYSpQ3UF3N5d
         hiRXsXgDRf3knM3IS1w8syBwO2EHRzHTMSPA4c6x50t/Tq+MnKQD195ZZonLcTXX04+i
         t9XWJf2d1oWbmFjJEuvq5QiJgNcBpUOsRsXEfc34/nyvr2ey3O9C0zy0flmrjAWK4X4x
         MwdCJlkxmHi94Dzy8YdXMUhMpHavvJeS/O97n/JrVZ8ybCEsfbHh8UdRxi8M989OB0dY
         TPUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763501; x=1774368301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
        b=Wqbr0qQcBUL+9mGeuvgAAIQIQQmMfw1rdUw1BfEVfJltCs0i5roU/yc6wwpYhGwIso
         3QOJ22K88OtEYw1TthZF/8OK/o+AuPfT1cslfUg4fX9lPfTbDsj7ScVEubF+RbxTgvdt
         MYp/QvKieNq/uxKXYx3Z04imgaBk2bJgjpwbU9Df6zNDqmUyQpQOhr6QB8DFpzpjxnzt
         1Re8J50VxPjwXPV6feYGZ5HeArB6oDuyJH8MdFNViCokWv8iz8jzrLkK+cfR5nKtSCx4
         ydVHonvbhH72WJLt+BPBDEUWljbFLZtK1ZwbNgW32tRv+u9b1Y6rTfw5dC2+SX3kJkOz
         rb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763501; x=1774368301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cphgzUVxFTizMLis/z4Nd9WdAtFNCPpiUECCCXUPz8=;
        b=W64EWqw9lBzCvkX+KNDsTkBtwiXQ5/Zj9Q21STR/G56aqjwIdkRuWDWQYdP1RCu9/X
         iaIoxYNwngPs1faHp/PLHTQS4YPDpNOUJH/9MCEpDM2JxYeixMe4ADwHhihzmsxvBiqr
         QGEa2Ak98yuNL5Zo6BtfqEKYv/rPBkeNi8eme7h24torn1LMR9rtV1Bb9TNPeZZZCAup
         5uusi1SNV8DhvQpwUU+GA4V0fYtHEwW+B5AVdHdpHcUWGG76tMaOfWUH+qIT1jn46xUA
         wx46PnRf5lHzveK41sB7WvVRZ0pBGMjZY/bTkbasQTK+36wXeUBHjV8oQqvcuilYBxzG
         PH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqIJ5vbHWW4Noqdsyr1fMzKNhKCK2NXOSD0tjbOCTMFXblpqrha4T9FcP2QT3zMHhRiO8CBKzHmOp6qadokJXW@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNa9Bdk2oH1pXOL69+UTWqkqX2ytrTMglu0p0C9kxkzSm8fhT
	N6F3ubXLOudvBGWTqLVnQU/zHBkhr1HIjo64ppCmDHc2ff8nVyZJBQgs1iw1UokzsMIPmG9JgTN
	Uq+pgg1p96kQu0ZqKhsZ3ZTi5G0dKV+nc0kdHiKzC
X-Gm-Gg: ATEYQzya8ENWJ99feiRl0I3dmsEeZ4QiqftaOFmefxU5AxCnNBAWGnmyWRq9JCVhx0w
	EGuF8HBGMSzwgL0ps2nceNObMmrjUOX+jT7d4sz124Sbt+R8a14KRayhRCGOCH7rrlIPV/f4swl
	kTMfZIUQ1FhKHh6mUZYtekNsjXrnnVWOU0zQ1CPtgUks0SA3EyGx7q4gvwkOJyL1au+lH3k2MlG
	n+JuwaLAzqvY+hFBsy+OFPKc/DFvnof1L2NPsIvuQvAc94yBjxorIMSSgAw3KPu21l2qcJA1IKg
	d7rGT5tTavpfAjVT2Wc=
X-Received: by 2002:a17:902:e802:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b0659d8d7emr2625595ad.15.1773763500133; Tue, 17 Mar 2026
 09:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314083722.76728-1-atrajeev@linux.ibm.com>
In-Reply-To: <20260314083722.76728-1-atrajeev@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 09:04:48 -0700
X-Gm-Features: AaiRm5340p5_SgfiTHi2ZB8zSueLw5aT-HV6NIG-oe-Lp6xH-35Td8lvxVkdaBk
Message-ID: <CAP-5=fU8VojUXB9oD1u713WeHQ9oLBn0fQ0=Kif0XetxMg7MGw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Update debuginfo check in skip_if_no_debuginfo
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	jbrnak@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 1:37=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
> Perf test perftool-testsuite_probe fails as below:
>
>  Regexp not found: "\s*probe:inode_permission(?:_\d+)?\s+\(on inode_permi=
ssion(?:[:\+][0-9A-Fa-f]+)?@.+\)"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :=
: perf probe -l (output regexp parsing)
>  -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple pro=
bes
>  Regexp not found: "probe:vfs_mknod"
>  Regexp not found: "probe:vfs_create"
>  Regexp not found: "probe:vfs_rmdir"
>  Regexp not found: "probe:vfs_link"
>  Regexp not found: "probe:vfs_write"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding suppo=
rt (command exitcode + output regexp parsing)
>  Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongoreven=
longertoexceed64"
>  Regexp not found: "in this function|at this address"
>  -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable=
 (output regexp parsing)
>  ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures fo=
und
>
> Further analysing, the failed testcase is for "test_adding_kernel".
> If the kernel debuginfo is missing, perf probe fails as below:
>
> perf probe -nf --max-probes=3D512 -a 'vfs_* $params'
> Failed to find the path for the kernel: No such file or directory
>   Error: Failed to add events.
>
> skip_if_no_debuginfo has check to handle whether debuginfo is present
> and the testcase checks for debuginfo since this :
> commit 90d32e92011e ("tools/perf: Handle perftool-testsuite_probe
> testcases fail when kernel debuginfo is not present")
>
> Recently a change got added in "tests/shell/lib/probe_vfs_getname.sh"
> via this another fix:
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected")
> Since this commit, first add_probe_vfs_getname is used to prevent false
> failures. And based on return code of add_probe_vfs_getname, skip_if_no_d=
ebuginfo
> is used to skip testcase if debuginfo is present. And this modified other
> testcases to call add_probe_vfs_getname first and invoke
> skip_if_no_debuginfo based on return value.
>
> The tests in test_adding_kernel.sh which depends on presence of
> debuginfo are:
> 1. probe add for inode_permission
> 2. probe max-probes option using 'vfs_* $params'
> 3. non-existing variable probing
>
> For these tests, probe check for specific line is not required.
> So call skip_if_no_debuginfo with argument to say if line check is
> needed. This is to convey to skip_if_no_debuginfo() function
> that test only needs to check for debuginfo, and not specifically
> line number. Update skip_if_no_debuginfo to use simple "perf probe"
> check if test only needs to check for debuginfo. And for other
> tests which rely on line number, use add_probe_vfs_getname()
>
> With the change, verified that only three which required debuginfo only
> is skipped and others ran successfully. Also tested with debuginfo
> to make sure tests are not skipped.
>
> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks for taking the time to improve the test pass rate! I'm sure you
saw Venkat's comments, but for the change itself:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../tests/shell/base_probe/test_adding_kernel.sh  | 15 ++++++++++++++-
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh   | 13 ++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/to=
ols/perf/tests/shell/base_probe/test_adding_kernel.sh
> index 555a825d55f2..f3db125c8669 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -23,10 +23,23 @@ TEST_RESULT=3D0
>  . "$DIR_PATH/../lib/probe_vfs_getname.sh"
>
>  TEST_PROBE=3D${TEST_PROBE:-"inode_permission"}
> +PROBE_NO_LINE_CHECK=3D1
>
>  # set NO_DEBUGINFO to skip testcase if debuginfo is not present
>  # skip_if_no_debuginfo returns 2 if debuginfo is not present
> -skip_if_no_debuginfo
> +#
> +# The perf probe checks which depends on presence of debuginfo and
> +# used in this testcase are:
> +# 1. probe add for inode_permission
> +# 2. probe max-probes option using 'vfs_* $params'
> +# 3. non-existing variable probing
> +#
> +# For these tests, probe check for specific line is not
> +# required ( add_probe_vfs_getname does that ). So call
> +# skip_if_no_debuginfo with argument as 1. This is to convey
> +# that test only needs to check for debuginfo, and not specifically
> +# line number
> +skip_if_no_debuginfo $PROBE_NO_LINE_CHECK
>  if [ $? -eq 2 ]; then
>         NO_DEBUGINFO=3D1
>  fi
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf=
/tests/shell/lib/probe_vfs_getname.sh
> index 88cd0e26d5f6..8584ec76f041 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -39,7 +39,18 @@ add_probe_vfs_getname() {
>  }
>
>  skip_if_no_debuginfo() {
> -       add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the =
path for the kernel|Debuginfo-analysis is not supported)|(file has no debug=
 information)" && return 2
> +       no_line_check=3D$1
> +       debug_str=3D"^(Failed to find the path for the kernel|Debuginfo-a=
nalysis is not supported)|(file has no debug information)"
> +
> +       # search for debug_str using simple perf probe if the
> +       # test only needs to check for debuginfo, and not specifically
> +       # line number.
> +       if [ $no_line_check -eq 1 ]; then
> +               perf probe -v -L getname_flags 2>&1 | grep -E -q "$debug_=
str" && return 2
> +       else
> +               add_probe_vfs_getname -v 2>&1 | grep -E -q "$debug_str" &=
& return 2
> +       fi
> +
>         return 1
>  }
>
> --
> 2.47.3
>
