Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20D2063C0
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634965; cv=none; b=YsNkSVMa5p6vSZK6d0ve9oomK8T1tnOoQtLGoMZ4ovLS1EXEHX/zDklMztsli2gRbsmKR2PKMQeOyP3PvnEASxZNf1N021CjS9p93cxM+Yk3CZicJ6f59pZ21phzy0ssBF1LKZqfMaCI8PnjK3s1VuCvafjErlghHxC0OErmEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634965; c=relaxed/simple;
	bh=MUNIRlAyy6bZUgXwVYwjbDqYF5SDqilGQBQesFVrvfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F5VrV+cPqnlq+mhsn64SgY+WhZ9s38zbMeH3itfVOhNDthYKoaa5zHRd0hy3LS5A6GKdthsH2+5ihsEQiqN9t8uPl92Q96c/HbpLqhdZ/OiTDOi35/EE/xaH9HCdYPBL0YPQRInvTV9x9jjkRZb5Lpb7/APaUlZU23JgrGH2waQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVTQcO/B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVTQcO/B"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2212222d4cdso87675ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 21:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740634964; x=1741239764; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrrVETp2ZeRqDhmK60ciysHn19m9SG4Bj547yggW4HA=;
        b=tVTQcO/B6ZWSOYmJ1/2Wbryu7PwE2MBGgYS1Hei+663m0lHRaHlS0KsXLhWa6eWYdF
         VWgB+e6MftZI11qZlir2PnI1tk2vkJkEpkx+U9j+ym4aq8k6qvedVa2wdXDXkHVE1m7m
         d3SEaTPKH50NVl2G9S3BxZ63tJQECmLDuzRxO5RO6aFj5fOb29hqoEXGSw4fLFxQrANL
         PnL8ALARJhzrEKlzpw+RRtWI7EEiOFjizWbw7eYwmjdt8ysmrf9vq3fkIuCko3ilxeL5
         TtU2bqOrTe7vgyIdPeQ5iHlCHYJgnIMic/bzE1tSfYsgZFENmU15kAcx8lTo7Q5xbpbR
         IGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634964; x=1741239764;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrrVETp2ZeRqDhmK60ciysHn19m9SG4Bj547yggW4HA=;
        b=jAp6pvHl2PxASxceUPQvDat3MCU6Yypa8YLvetHe8MDCJ7+5To4+24Uw5hjeFbo+ln
         mQdewjAZP1jD2w4IopO8m+Ore5nRm0aDAElpZwJdn7QwGFcwvAWNjurLPJ12dKHglM0/
         cKvvsNYJtdiEiuUS4qw0PtpBFwwlIgqKlnIqIgro4IrwBMwtC4YmDw3Ddn7U1jKa7rbd
         XSdMBya3HkI5jekHYJOucdd0CfXC8Ciq2uQYzwLzzxZoK5den0CF4MvK+p+v3j7fkLId
         mE5nAUhPTe0j+CTRiXaKF4b4Xbr/7lsPA+aNhYcCj42MbOffaOVxL5fBfr3b2Ul+FPT6
         Zj1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/DlMFPaq/7b7Hqar/ccjT4CJw7gTlbeAkgzmuqdXdGSGdQpDsD1lAypm9Rk90E7ZN3CBKXma5SrDUp7k5EUuS@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwgI8yP7r6Kgdxpzh8K1tMkUis+g9SKvSFHXlsASg6j7Ijsr1
	JPhofaa9JmNQGdQk5cxZcWMTcn+dbKH164q4MyV4uLOR1Cb/Sw8YkxjYbdEDha4gyKRw12JxcKm
	oeJnLvbRI207M5xuX6j9izF1esv8ymi/mY9Fq
X-Gm-Gg: ASbGncsItmGFO7pFZsUY5rpXSLodymS5/gKDaijnn9YgxS0EnD03nkhFHg0mACY7V/L
	18gdXy8uD5zrf0GHaHEpAQtDUBONZjJuMsl9WIaIr9vYGV7YQoIiYfFsEbpxXP6rud594Awjm2K
	eTP25q4iNi
X-Google-Smtp-Source: AGHT+IE04Xn7gkFQ4lTa3BOx+GUDg6KhMeHEk+2UyoPHgNBqYihVtvNqHLJ/HNtT+Go+7kzEGupsFGRFghRLUbE0tuA=
X-Received: by 2002:a17:902:f802:b0:215:8232:5596 with SMTP id
 d9443c01a7336-2234d5c9a54mr1779645ad.16.1740634963259; Wed, 26 Feb 2025
 21:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226230109.314580-1-irogers@google.com>
In-Reply-To: <20250226230109.314580-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 21:42:31 -0800
X-Gm-Features: AQ5f1JrIXT55iplQ8LQBBQWS-GNKGsTuSVSa-F8OhWM3zjtUv21ewnDvV1RWzLM
Message-ID: <CAP-5=fUN7=cQ9X10tH1qpmzpJoSoqHH5CV5MVwhqXkQ8vkbwoA@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Fix data symbol test with LTO builds
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:01=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> With LTO builds, although regular builds could also see this as
> all the code is in one file, the datasym workload can realize the
> buf1.reserved data is never accessed. The compiler moves the
> variable to bss and only keeps the data1 and data2 parts as
> separate variables. This causes the symbol check to fail in the
> test. Make the variable volatile to disable the more aggressive
> optimization. Rename the variable to make which buf1 in perf is
> being referred to.
>
> Before:
> ```
> $ perf test -vv "data symbol"
> 126: Test data symbol:
> --- start ---
> test child forked, pid 299808
> perf does not have symbol 'buf1'
> perf is missing symbols - skipping test
> ---- end(-2) ----
> 126: Test data symbol                                                : Sk=
ip
> $ nm perf|grep buf1
> 0000000000a5fa40 b buf1.0
> 0000000000a5fa48 b buf1.1
> ```
>
> After:
> ```
> $ nm perf|grep buf1
> 0000000000a53a00 d buf1
> $ perf test -vv "data symbol"126: Test data symbol:
> --- start ---
> test child forked, pid 302166
>  a53a00-a53a39 l buf1
> perf does have symbol 'buf1'
> Recording workload...
> Waiting for "perf record has started" message
> OK
> Cleaning up files...
> ---- end(0) ----
> 126: Test data symbol                                                : Ok
> ```
>
> Fixes: 3dfc01fe9d12 ("perf test: Add 'datasym' test workload")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ah, I see we're trying to force -O0 and -fno-inline in the Makefile
(git.kernel.org is giving 403s):
https://github.com/torvalds/linux/blob/master/tools/perf/tests/workloads/Bu=
ild#L11
Which LTO later undoes. I'm not seeing LTO breakages for brstack.c and
the shell test "Check branch stack sampling". I think LTO is able to
optimize this case as it is a variable/struct being optimized, so the
"-O0" and "-fno-inline" mustn't be being made to apply. Not a wholly
satisfactory reason to add the volatile, but I'm short on
alternatives.

Thanks,
Ian



> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 17 +++++++++--------
>  tools/perf/tests/workloads/datasym.c       | 11 ++++++-----
>  2 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/test=
s/shell/test_data_symbol.sh
> index c86da0235059..7da606db97cb 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -18,7 +18,7 @@ skip_if_no_mem_event() {
>
>  skip_if_no_mem_event || exit 2
>
> -skip_test_missing_symbol buf1
> +skip_test_missing_symbol workload_datasym_buf1
>
>  TEST_PROGRAM=3D"perf test -w datasym"
>  PERF_DATA=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> @@ -26,18 +26,19 @@ ERR_FILE=3D$(mktemp /tmp/__perf_test.stderr.XXXXX)
>
>  check_result() {
>         # The memory report format is as below:
> -       #    99.92%  ...  [.] buf1+0x38
> +       #    99.92%  ...  [.] workload_datasym_buf1+0x38
>         result=3D$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&=
1 |
> -                awk '/buf1/ { print $4 }')
> +                awk '/workload_datasym_buf1/ { print $4 }')
>
> -       # Testing is failed if has no any sample for "buf1"
> +       # Testing is failed if has no any sample for "workload_datasym_bu=
f1"
>         [ -z "$result" ] && return 1
>
>         while IFS=3D read -r line; do
> -               # The "data1" and "data2" fields in structure "buf1" have
> -               # offset "0x0" and "0x38", returns failure if detect any
> -               # other offset value.
> -               if [ "$line" !=3D "buf1+0x0" ] && [ "$line" !=3D "buf1+0x=
38" ]; then
> +               # The "data1" and "data2" fields in structure
> +               # "workload_datasym_buf1" have offset "0x0" and "0x38", r=
eturns
> +               # failure if detect any other offset value.
> +               if [ "$line" !=3D "workload_datasym_buf1+0x0" ] && \
> +                  [ "$line" !=3D "workload_datasym_buf1+0x38" ]; then
>                         return 1
>                 fi
>         done <<< "$result"
> diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/work=
loads/datasym.c
> index 8e08fc75a973..5074b3439835 100644
> --- a/tools/perf/tests/workloads/datasym.c
> +++ b/tools/perf/tests/workloads/datasym.c
> @@ -7,7 +7,8 @@ typedef struct _buf {
>         char data2;
>  } buf __attribute__((aligned(64)));
>
> -static buf buf1 =3D {
> +/* volatile to try to avoid the compiler seeing reserved as unused. */
> +static volatile buf workload_datasym_buf1 =3D {
>         /* to have this in the data section */
>         .reserved[0] =3D 1,
>  };
> @@ -15,8 +16,8 @@ static buf buf1 =3D {
>  static int datasym(int argc __maybe_unused, const char **argv __maybe_un=
used)
>  {
>         for (;;) {
> -               buf1.data1++;
> -               if (buf1.data1 =3D=3D 123) {
> +               workload_datasym_buf1.data1++;
> +               if (workload_datasym_buf1.data1 =3D=3D 123) {
>                         /*
>                          * Add some 'noise' in the loop to work around er=
rata
>                          * 1694299 on Arm N1.
> @@ -30,9 +31,9 @@ static int datasym(int argc __maybe_unused, const char =
**argv __maybe_unused)
>                          * longer a continuous repeating pattern that int=
eracts
>                          * badly with the bias.
>                          */
> -                       buf1.data1++;
> +                       workload_datasym_buf1.data1++;
>                 }
> -               buf1.data2 +=3D buf1.data1;
> +               workload_datasym_buf1.data2 +=3D workload_datasym_buf1.da=
ta1;
>         }
>         return 0;
>  }
> --
> 2.48.1.711.g2feabab25a-goog
>
