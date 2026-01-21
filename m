Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460F41325B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010751; cv=pass; b=dVLxZSojbThAcEeS71gCyrp7YUDIIcR6riaL2Wf1ADu2NCRii0tSjqYKFgRAEzxKavu/E2EZvqboGauZzw1AnejT8kKmwmF6TuwPOfM4h9b1rb/4rDkNWwh+mUO6ZTF+QjGqPyil5YLttApRamNUU7lotTzAKpfkbGOCdY3yNLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010751; c=relaxed/simple;
	bh=sp9lVOVgrCwa+GC2LA8cImW8uEZ8E+UM4nbD/5yMiis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTJc5cgslUTNoN/NhMTQlvlNHMJuw4gux736fgCzBfZx74CvnpbG7byIyc0Vkp1UAmeOsct7M2118YU5sKLsXCd7B2etDjIfbg7Lh1hjQEYzFSZJ1ak5wBncv03Eb+/a9d4ep4/RTfw4OWx61tDPeg89sOAgAvszSErREnicRMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsOpiSZP; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsOpiSZP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a76b39587aso99375ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 07:52:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769010748; cv=none;
        d=google.com; s=arc-20240605;
        b=ZfpcNPc6yx9xzUvLaHOSapoGyoPb2YUSlS3YzPpkaZQBKfrIrPO+4RulwwN5+Rl7tF
         qzx3yda1/CjiU6huhptwfgfSB/y7yrfUNlP4M3AYyCMNQrVVrdm2vcPEPeSJV7i1RS0m
         2wjT+wgcMYaAK1pVQHX47SKIm9kOpDiak5arz4CZtYVFIrvCGoo/NO+3gFL+ab2T1P54
         CMeZQUApDvbCeZ/+HTVItNlOTwUer+twV0YC9Tk+mYqSqcWcldNlgelyokJ39oNtDBvT
         KFyNKsDIQbv0UgBTU7apZq9b8JSOveUJTJcgyzXL0wAH4uchit6TUYhgY4sBfeb8+Isp
         aBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0O2fp8A64qYqm8pwFgzTtPg0CXEySON6wKIA5P4ADvE=;
        fh=9tWPIZ7GbRH6r9eyzuJMZ8GGmu5V85rPg0fqOjlg3RA=;
        b=RP+g0nuaKJ6oFfEmG9uvTluGSVKxqSGIq/mzjp4S5kYZyGQZSHTDorGbKXl753doK1
         XDlJa6wzoSUDzStJ72DTGe2AYUaraAcmMb/cwhsF9xbdOUJZt9OOu/GqjBd5Bvql3GO2
         Fx9JtuLZCE2AYbdlzlcex0EoPUl0mBWJzfRvXnT5Pp19OH5+HVVzEABcVWQ4QeL6uBHu
         /gaKi15mNpj33h+hYj8JL7z2IsMtKfAHk+RBi3m8+hH9nE8RjL68qBi/aZkcYVFSPwg5
         VDRrFSMIGgOD7x4puq2+FesaH/gxJzKx+pONbfddYoOVzMvTDe8W+g+5wKRCFlMv1700
         AM1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769010748; x=1769615548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O2fp8A64qYqm8pwFgzTtPg0CXEySON6wKIA5P4ADvE=;
        b=BsOpiSZP8UIBFWCMTtxQeOi0dzxRr3Moe64jQaE6Ll6Lc2ZikFRKBMyvhqyNKp/5NS
         KQV0NnTlrQpxAnppWVMfjFIQiutunKNNEQz+zHKJlR+x/Z6typsABGEKQecgaZG4sVOB
         aWn1S6IwGRPQ/ytxBpPasOMMWvnUsFtP/Xt9zVlykWIIY3WfiR2R8wzwvIQRyscaLtYJ
         TGseq8S4/SymjnQMOCI2/y2zIT6X3BDjdE05mFnzNBElIl499FRygQWMVpAjK32Wqmsm
         +56Of7+onkhLXqFtWzY83wekxkBntpFlR+dLtvpfHv7UcRj7bbCby9BbNVXsMqnFrXlg
         tLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010748; x=1769615548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0O2fp8A64qYqm8pwFgzTtPg0CXEySON6wKIA5P4ADvE=;
        b=uOImmjH8j66P2BviDL/ihXo4SPqrkYg42PL9cQhEbf/eqj5qxFDqjzFbBedG4NFciQ
         wG0YBnK2VI24DFWErBNWFe0IGoxMZcT2FO9cmPmMIa3s8Y/9eUE3Y/RrtPkclgCYdGYY
         EGanxkI8fp/mz3wjYavUw3LBTNrC27haDO27rIDbC+ES6h42YfTA+Zc0TT1pQ8lydJrm
         ludo/UAjEjdiakmTA8LfLtLiouCPLwbetcpdw2tiE2lPCuk7XYMTdL+3sHh1gg72PwMC
         8q1/NZIsm0cJobHQqlrs9z90Dc0Mt0EwNupKi94Jy2mP9WVMh65Npyrs1wpFQ2u158nx
         UcXA==
X-Forwarded-Encrypted: i=1; AJvYcCXwJbfodt81Kdyx+rTgmbfE+v5zB268T5R0uSyqPG/f7I6Hpfcqyftsh2Nc4CR7thitVEDZhCVU8GuDWUXnNQOa@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbS+XEKBHTAKKDIOmqbTraCJlaoTMazV2HMDCNrCHeKoeEGBV
	UvDj2NGD67y8Xzw4lmXqFyPJd1vMtXYhIVy/2xvp0cxrZZlZthVz3zf8EnfX6eLprtmnTZ3zh6B
	tcvOmANCFH8CjmP4ED0du1kq9SaHtMd3hfHAb91az
X-Gm-Gg: AZuq6aJRQ1tpASqoR9TFEjbwAJuh8//jqFGPXaK87lo64weam8nlV9VSobNoXFAyXSy
	1+6kSr0Q8/W5y1d2Gqhccss8k9UKXnnVK5vSkF6+QOvHe5omyaqq1tUXi2Z9lomhqcRIN81ZZhY
	FfdzEoCZXMtA8KTnqgwJzahjUd3twVJVvljPKVD6WLfeTgJY5aliBKGDEQc8sBfcPjyue9g4Lxc
	DffRBRlUIGPadhRMe+4wkR4nVdRHiqkTN894h3TWt6E/ujPNl9tCeHhQ+M8n2J7dTTiw/SkVSlo
	YNvQnbRQR72+G/dW8vEwc4tbNg==
X-Received: by 2002:a17:903:acd:b0:29e:27f4:bac0 with SMTP id
 d9443c01a7336-2a79a61d716mr3015795ad.16.1769010747897; Wed, 21 Jan 2026
 07:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202601201519.ce4c3ab3-lkp@intel.com>
In-Reply-To: <202601201519.ce4c3ab3-lkp@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 07:52:15 -0800
X-Gm-Features: AZwV_Qh98e04YDZFFaxkVB-W7l3tozUgfMUKiMM2Yyutk-HVwNDWVgfCxG7ECV8
Message-ID: <CAP-5=fVyGswdFrEw7=P8RGPJP+2wW3qQhzCfz1BoJ9Uvg4iKDg@mail.gmail.com>
Subject: Re: [linux-next:master] [perf test subcmd help] ef92c4351e: kmsg.sanitizer.indirect_leak/malloc/___interceptor_backtrace/child_test_sig_handler/raise/abort
To: kernel test robot <oliver.sang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Sri Jayaramappa <sjayaram@akamai.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:58=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "kmsg.sanitizer.indirect_leak/malloc/___interce=
ptor_backtrace/child_test_sig_handler/raise/abort" on:
>
> commit: ef92c4351ec75bcfb8a1cc3a88109b5339f296ef ("perf test subcmd help:=
 Add exclude disjoint subcmd names")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master d08c85ac8894995d4b0d8fb48d2f6a3e53cd79a=
b]
>
> in testcase: perf-sanity-tests
> version:
> with following parameters:
>
>         perf_compiler: clang
>         group: group-02
>
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202601201519.ce4c3ab3-lkp@intel.=
com
>
>
> --- start ---
> test child forked, pid 11710
> perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' f=
ailed.
>
> ---- unexpected signal (6) ----
>     #0 0x7f7688c77403 in ___interceptor_backtrace.part.0 sanitizer_common=
_interceptors.inc:4358
>     #1 0x55f34adb6c34 in child_test_sig_handler builtin-test.c:312
>     #2 0x7f767ea2bdf0 libc.so.6[3fdf0]
>     #3 0x7f767ea8095c libc.so.6[9495c]
>     #4 0x7f767ea2bcc2 in raise libc.so.6[3fcc2]
>     #5 0x7f767ea144ac in abort libc.so.6[284ac]
>     #6 0x7f767ea14420 in __assert_perror_fail libc.so.6[28420]
>     #7 0x55f34acf4e70 in exclude_cmds help.c:106
>     #8 0x55f34ae9a646 in test__exclude_cmdnames_no_overlap subcmd-help.c:=
112
>     #9 0x55f34adb74c5 in run_test_child builtin-test.c:340
>     #10 0x55f34ad08db3 in start_command run-command.c:128
>     #11 0x55f34adb99a1 in start_test builtin-test.c:546
>     #12 0x55f34adba90d in __cmd_test builtin-test.c:648
>     #13 0x55f34adbd2c0 in cmd_test builtin-test.c:850
>     #14 0x55f34acc2a45 in run_builtin perf.c:349
>     #15 0x55f34acc3336 in handle_internal_command perf.c:401
>     #16 0x55f34acc388c in run_argv perf.c:448
>     #17 0x55f34acc4033 in main perf.c:555
>     #18 0x7f767ea15ca8 libc.so.6[29ca8]
>     #19 0x7f767ea15d65 in __libc_start_main libc.so.6[29d65]
>     #20 0x55f34aa28241 in _start perf[102f241]

I believe this is resolved by:
https://lore.kernel.org/lkml/20260121082402.2311962-1-tmricht@linux.ibm.com=
/

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D11710=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 30952 byte(s) in 3 object(s) allocated from:
>     #0 0x7f7688ced610 in calloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:77
>     #1 0x7f7688ace808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>
> Indirect leak of 9280 byte(s) in 3 object(s) allocated from:
>     #0 0x7f7688cedc57 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
>     #1 0x7f7688ad6550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>
> Indirect leak of 1873 byte(s) in 3 object(s) allocated from:
>     #0 0x7f7688cedc57 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
>     #1 0x7f7688ad73fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildI=
d: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
>
> SUMMARY: AddressSanitizer: 42105 byte(s) leaked in 9 allocation(s).
>  68.4: Exclude disjoint subcmd names                                 : FA=
ILED!

To better diagnose these leaks could you disable the fast asan stack unwind=
er:
ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D0

Thanks,
Ian

> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260120/202601201519.ce4c3ab3-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
