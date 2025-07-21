Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF91221DB3
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127184; cv=none; b=JWq31Kyup/cdCDquC3nS9Z7liesZKvIf8xCWii7OLRd1GUS41EGAVLCMHrC+Hc+7Uz35hgaB7a3D6DtvkvOSn5v2w79DBNeJmDKkstyAtzHzq5uD0LQsEVyzC/px1nzKzP2nQ/TTfXJ2cU66tUSw0xUfc6EKhdwfSjcUKRLeXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127184; c=relaxed/simple;
	bh=OCCA2OePrlmcRF/xBqFGX6YXxLDqU4+rRl13cKcR96M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRAKP/npiRLuoT4pzvkF6WCv6Up1/GnfODwj2+WFGSCYYffzFG/DOkOIlFKK3rKFU9G+iZ56J8/6BPidqLw28jSKoD/0pbvxq/5wB8DaqiXpfe2qLJSZBk0V/JlRLwm6uEIZwtuw6/6YQHagI6ygYy+vGdiqd5YcMGw2Kqb45Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmwRmBH7; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmwRmBH7"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e283b2d065so6645ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753127182; x=1753731982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQDEXDXKmdV5IP4AodSflXFuGgzgMY/Xh3i1A4GNBYA=;
        b=pmwRmBH72QxWoOwWIO9szyqnnytsB/f+0SGJUftyP3hXFV77EzSHoHwIVXQNKvs+8K
         ybcIFNOs0B/AxjGRsLUeyDn+de/UQipFNcKlhhl5MthZGiNiWh+es+rvryKOvMVd/wAF
         TcuWYRoFBPZTJodeq0IOMG+KH7Bb5oG2+jL51NBGyGZMfM+jpnmA+ZEYtvgQmuSvNXRd
         6DXq50JRT+OsO3jFXKddxxgr7gS3YsqeQyJAKJF6t/se6qQ4mg3c35ohEDc9qO/8FSvI
         kQh04pxCPLSF2U7TPipjKfSpxyFjw1P+bohVeWdymYpBj1AmuyL4Oi3SBYijrkHHsQIE
         v1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127182; x=1753731982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQDEXDXKmdV5IP4AodSflXFuGgzgMY/Xh3i1A4GNBYA=;
        b=MNk+MhLCN5VqlqtVbKC00ySIxN9NfnwsVtVD0x7+ZNV3CvcEK+8igXqO8Xo8Hm9VcO
         uagfK/eWC3NUvfdhvy3YYcye3ubcyIagoqHhdtw+2mJtbbzYiD46t92MUrCceLjm/HMC
         +2nPbFs2+2DoRb8QuZAL96enLHXUwvAT7UWcH8taK4ADnT3YH4A9mCXlbojg5JjeeaQi
         WJ742Jl/TS4NiBCXkeWDBr2vWhbdiMeT/4z13UDrdFalv2NhbxEggWpWvBt0y7TY2HwX
         Q2RfKRb5CK8mzGryQB9/5yn/3hUtugxNoO602Q4Mgz/sNIWB97LLBd4VN6K0G7lsBj1g
         uTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwgQJhgJ8ibg2BbM49rvXA86meJb8jnTgYeZdJKXYH2ALUYXWwChHbk6aa/IQwvifxUXW+L/LxUsbUHvgReUe3@vger.kernel.org
X-Gm-Message-State: AOJu0YzacUvMOv5NV+AKX8sSDkPjdrd9/gjnfXZIRL5ZpmZhpZJex/IU
	ezrI2h3GuojduAWf2Yt9QwnQtE4oUI8HVbBbeCzyOtb2YCnt7X3tPtl20gFFDxv83gSkYgqIRUW
	t8IpbyfKPSipTLU945qwca7v8m3nH+n7pQyp2+IL+
X-Gm-Gg: ASbGncuFWe1+52x4zb857IOl6U5Yt7Tp2U2deazT5PKnVQ/0Dh2WL3qbwLyz2/04fPD
	Vmh5Ocv7wlFGexLAhRlP7V2gSHH4G7KKBu9hpPRKp89odXcU4rVFBU9jum7fHvPQDGrqCDo04p5
	sr+klaE4bUHq7KX1TXdUx8Rh2QbJOIuqXxmijuSfAo8HpSwDQz5Aj0xUiFvsQxUJAFRp8dBEFoz
	PeMqMolMHpF8iy6SWj9Am6uXvOTg89J1qTH
X-Google-Smtp-Source: AGHT+IHnWEPpAhGRltmPLJChNju2fUKMLP4KrnPBjRcwnDV4TKzMg3V0EgD62yD91tp8A9RYydSMyzGy4AbdEtPU/Fk=
X-Received: by 2002:a05:6e02:1a8a:b0:3e2:966f:8f3 with SMTP id
 e9e14a558f8ab-3e2bf1a59b7mr802365ab.22.1753127181326; Mon, 21 Jul 2025
 12:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113182605.130719-1-vmolnaro@redhat.com> <20250721132642.40906-1-jbrnak@redhat.com>
 <20250721132642.40906-8-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-8-jbrnak@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 12:46:09 -0700
X-Gm-Features: Ac12FXwLCaCfoEOmZN_eeaN2bVyYFYlVMbn-efcVpHrtrhhOsHLY6Mj6qfUw2io
Message-ID: <CAP-5=fWxB-aV2RUnYs1mCMe4q-z5Wn4S6vkF6JuHn3BVM_hLQg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] perf test: Remove perftool drivers
To: Jakub Brnak <jbrnak@redhat.com>
Cc: vmolnaro@redhat.com, acme@kernel.org, acme@redhat.com, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:27=E2=80=AFAM Jakub Brnak <jbrnak@redhat.com> wro=
te:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> The perf now provides all of the features required for running the
> perftool test cases, such as creating log directories, running setup scri=
pts
> and the tests are structured by the base_ directories.
>
> Remove the drivers as they are no longer necessary together with
> the condition of skipping the base_ directories and run the
> test cases by the default perf test structure.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>

Awesome work! I'm very happy with the improvement this will make to
testing. I'd like to test it and I noted some nits, but thanks for
pushing on this!

Ian

> ---
>  .../tests/shell/perftool-testsuite_probe.sh   | 24 -------------------
>  .../tests/shell/perftool-testsuite_report.sh  | 23 ------------------
>  tools/perf/tests/tests-scripts.c              |  2 --
>  3 files changed, 49 deletions(-)
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
>  delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
>
> diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/p=
erf/tests/shell/perftool-testsuite_probe.sh
> deleted file mode 100755
> index 3863df16c19b..000000000000
> --- a/tools/perf/tests/shell/perftool-testsuite_probe.sh
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -#!/bin/bash
> -# perftool-testsuite_probe (exclusive)
> -# SPDX-License-Identifier: GPL-2.0
> -
> -[ "$(id -u)" =3D 0 ] || exit 2
> -test -d "$(dirname "$0")/base_probe" || exit 2
> -cd "$(dirname "$0")/base_probe" || exit 2
> -status=3D0
> -
> -PERFSUITE_RUN_DIR=3D$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
> -export PERFSUITE_RUN_DIR
> -
> -for testcase in setup.sh test_*; do                  # skip setup.sh if =
not present or not executable
> -     test -x "$testcase" || continue
> -     ./"$testcase"
> -     (( status +=3D $? ))
> -done
> -
> -if ! [ "$PERFTEST_KEEP_LOGS" =3D "y" ]; then
> -       rm -rf "$PERFSUITE_RUN_DIR"
> -fi
> -
> -test $status -ne 0 && exit 1
> -exit 0
> diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/=
perf/tests/shell/perftool-testsuite_report.sh
> deleted file mode 100755
> index a8cf75b4e77e..000000000000
> --- a/tools/perf/tests/shell/perftool-testsuite_report.sh
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -#!/bin/bash
> -# perftool-testsuite_report (exclusive)
> -# SPDX-License-Identifier: GPL-2.0
> -
> -test -d "$(dirname "$0")/base_report" || exit 2
> -cd "$(dirname "$0")/base_report" || exit 2
> -status=3D0
> -
> -PERFSUITE_RUN_DIR=3D$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
> -export PERFSUITE_RUN_DIR
> -
> -for testcase in setup.sh test_*; do                  # skip setup.sh if =
not present or not executable
> -     test -x "$testcase" || continue
> -     ./"$testcase"
> -     (( status +=3D $? ))
> -done
> -
> -if ! [ "$PERFTEST_KEEP_LOGS" =3D "y" ]; then
> -       rm -rf "$PERFSUITE_RUN_DIR"
> -fi
> -
> -test $status -ne 0 && exit 1
> -exit 0
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index d4e382898a30..79b75b83a4bf 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -413,8 +413,6 @@ static void append_suits_in_dir(int dir_fd,
>                         if (!S_ISDIR(st.st_mode))
>                                 continue;
>                 }
> -               if (strncmp(ent->d_name, "base_", 5) =3D=3D 0)
> -                       continue; /* Skip scripts that have a separate dr=
iver. */
>
>                 /* Scan subdir for test cases*/
>                 fd =3D openat(dir_fd, ent->d_name, O_PATH);
> --
> 2.50.1
>
