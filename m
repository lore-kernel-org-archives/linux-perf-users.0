Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB536124;
	Sun, 15 Dec 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734245883; cv=none; b=bS4ujgV0z4RvMPep3bB1Fes76TorRIf5OggJiVsOgQA8nnBvzpdOhEOhMHaK+nkWSE2qskIR8Zkplfe2w+82tBRaJrUUfPrjsQrbuNV07UmX0hwwZFdpu7AauvcybdZ0211FtYrtoqtzDpnl0dDQDdpNZc1sSmwO0WhpYgf1Rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734245883; c=relaxed/simple;
	bh=2OQZzP6BRxlJYJzS8PsQUtm8TeLwGOvv+YfaY6raTQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slKamIyUHvJfQg2Rywo+7wIxEXvR48hoOHCUhzYDyLACvk4Pz5p3ci0XatKRnfJ1E4iDXJsFqUo0eOX53y6vvEyq3wCMWxfAIfdCWDlB8ClBMN56Ove6Hwk1RAp+54xq5xZBGlyGnT6fx5gynbJ0VPAaqKQIliaO6ZCPjmu5BvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOTCF9fK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOTCF9fK"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e39f43344c5so2344224276.1;
        Sat, 14 Dec 2024 22:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734245881; x=1734850681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQu56XW3Qsw5N6RW3n2l+4Gl0SaTByF3QhLogoOv0F8=;
        b=JOTCF9fKcEOYZ32mfaGFIH7+sOXFkhGQioReUS5bL7GCGZF+FXyhISKPOlCk7F7RaQ
         WQ/yxi3f0kV+Pgel5+8jD8dmruuz+mVWV4oogzmZwEVOExkBcsL3bJw2O19pIK/jl3PY
         EpTwELptBURrAYSfZZF324Ly50oWJ3K1h4vnrynvrR9xS/6ZSJ5v3U0n+N80/BDPcLbo
         FgpmTGunviOz3R5IN/8G4LyuvqFepBlaHxokwVrg1rAUr3iwqwJ7+iUsI0NTdQhA1QD6
         C3dviqNUi/yMPmI2EjCuxZBUOpjNlX2dMc6aus6uEfl4k7Vjlc+M0MEoYobs3+u3RQzG
         ApmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734245881; x=1734850681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQu56XW3Qsw5N6RW3n2l+4Gl0SaTByF3QhLogoOv0F8=;
        b=mqn635AIBVDv8G4FlY4hKzVoc0e18y0ahLd8N9ZvUIdteSA0tk2TlrDCfGX73f3JtB
         UQnc1ptgk8kxbmkNPgPygUBe/rlmthb8meTMq9BVzyS2hR/wJwICrknipLGeUYc7uUi8
         +q2GrU9h1QiDnVrnLcUCqNDNCAd6BLandbFgcGjjd0nb4CRxQpE7vnSN7AaMJpL8eL86
         UuWrG85joVAO0uYtHjMtiZSPas0X1WtZuel0+fT6jl27Ze9aPff0rISXB7EuPIhgAhWv
         k1L3XVpH6SXWDUFMT1w+wEtio2s+dYvXu3U5kMU98bUywtdajymsbbeGJTFwWtSyRXaX
         yzPw==
X-Forwarded-Encrypted: i=1; AJvYcCXI3zMxXhIcCd5YBxGLUTIK6IG9Nq0wTIOkDgqnJYMZtDnd1XE/7NZlZT4hmHgdbnhycomJdJCykU3QgUo=@vger.kernel.org, AJvYcCXrJXRdX/lcT4hoh4grtp/G0J1cGkxXmZCbINR3Hn609OrWm8x/lE1acrUNUbrn4XQn87uTlPYu4inxqPDE/HKR8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwExIKQi4alYAif4kkpreJ9vLzxXRC1G2T6q9sfaT+KzIP6shV
	b5Zx94lr9hPCL38jR3/8lNJJJQ2um0a97f679auYhCU4kl8ejnayc7hd4ZUAQxeuIDXm8RQXRk2
	wlXMYdbOFCoo/csp65obJ/guVNEA=
X-Gm-Gg: ASbGnct98MOEzInu9tiN7nFdvANdNMbu2Inzkwgb2j0uogRG/FS2rHysL+vhw/3v2MG
	VhKp8S8toefVOeJKnIz2daHgF2/UMDw1YQoWc
X-Google-Smtp-Source: AGHT+IGDbk6ZDT+lS4COZTbrFJ3E1SI1tPL361VV3BBfCYfnXlofaMeqIbGEmW9Ohwc9LArDwzQrKGfDfQqBiPtLleE=
X-Received: by 2002:a05:6902:1b09:b0:e39:772b:4bae with SMTP id
 3f1490d57ef6-e4348d24c16mr6620973276.6.1734245881206; Sat, 14 Dec 2024
 22:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211224927.968483-1-howardchu95@gmail.com>
 <20241211224927.968483-2-howardchu95@gmail.com> <Z1zUW5itJzHI89gP@google.com>
In-Reply-To: <Z1zUW5itJzHI89gP@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 14 Dec 2024 22:57:50 -0800
Message-ID: <CAH0uvojcL+DL6WLJA1VhzysxeRY0=P9hAYm7Gng-skaoKLPHKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf trace: Add tests for BTF general augmentation
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, Dec 13, 2024 at 4:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Howard,
>
> On Wed, Dec 11, 2024 at 02:49:26PM -0800, Howard Chu wrote:
> > Currently, we only have perf trace augmentation tests for enum
> > arguments. This patch adds tests for more general syscall arguments,
> > such as struct pointers, strings, and buffers.
> >
> > These tests utilize the perf config system to configure the perf trace
> > output, as suggested by Arnaldo Carvalho de Melo <acme@kernel.org>
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/t=
ests/shell/trace_btf_general.sh
> > new file mode 100755
> > index 000000000000..bef07bad42bb
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_btf_general.sh
> > @@ -0,0 +1,93 @@
> > +#!/bin/bash
> > +# perf trace BTF general tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +set -e
> > +
> > +. "$(dirname $0)"/lib/probe.sh
> > +
> > +file1=3D$(mktemp /tmp/file1_XXXX)
> > +file2=3D$(echo $file1 | sed 's/file1/file2/g')
> > +
> > +buffer=3D"buffer content"
> > +perf_config_tmp=3D$(mktemp /tmp/.perfconfig_XXXXX)
> > +
> > +trap cleanup EXIT TERM INT HUP
> > +
> > +check_vmlinux() {
> > +  echo "Checking if vmlinux BTF exists"
> > +  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
>
> Normally we do
>
>   if [ ! -f /sys/kernel/btf/vmlinux ]

Sure, I'll change the check to this.

>
> > +  then
> > +    echo "Skipped due to missing vmlinux BTF"
> > +    err=3D2
>
> This can be overwritten by trace_test_string.

Oops my bad sorry.

>
>
> > +  fi
> > +}
> > +
> > +trace_test_string() {
> > +  echo "Testing perf trace's string augmentation"
> > +  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2=
} 2>&1 | \
> > +    grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${fil=
e2}\", .*\) +=3D +[0-9]+$"
>
> Does this work without BTF support?

Yes, this works without BTF with Arnaldo's patch adding
sys_enter_renameat2. Before the patch, it wouldn't work because the
second filename would not be displayed properly. I understand this may
seem redundant, but now in perf trace all the data is collected
through the BTF general collector (if BTF is present), so this
trace_test_string() tests the new code path that uses BTF information
to pretty-print string arguments, since all data collection goes
through it.

Thanks,
Howard
