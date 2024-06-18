Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6120568A;
	Tue, 18 Jun 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733616; cv=none; b=Vc9Zo2w+A/0QiK3efdpU/7xBQ6NOAZv2on6SNs6BhcfzT+zkQhYrgnMQtjLAkjp5GuOxc3AnhbLjP1fj4MgpQNEdHhGAUK/udbEzfRL4YYCbRnp9a/zIoEcOPatBFGzIvxPzXuVKThCFYH+iFvd0R8X7iuwk1dGYZE4x2n+iI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733616; c=relaxed/simple;
	bh=KoisqEEAwC5KHBeT019VH5WRg7wFOQwflG0Clz6S4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beMsaV74PBuGSR2vp9GasVHuqgNwXlBRzGjHPQpIFBbCbiZc4M0YsgTQaABFxlRBpjmmb/ZH+oCYdrXOj1YaWEgmRa23X+0NbIVEBzmIoBVLmZGyRrh+S6zW0LPo/BYwqx4BbsmVO7LiOA9SuUG4PLqH6WSjN1QNYt+xH6Yz3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWiSAIm3; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWiSAIm3"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-632843cff4fso41968437b3.3;
        Tue, 18 Jun 2024 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718733613; x=1719338413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywIyigSdpQlgMm2FiMND9yZ2xLjYHN/KA2Cy3RkcZ6A=;
        b=VWiSAIm3uqZaktM4y+uK9VdO4unNCzrVq5ZLtbcRVm0zR58REJnLlJ93ZXyGjWWuQM
         Yc7RJDTZVg5WoGx4ev/HvH/OOG9K5LBRo9cvP7pG0woBCHCsgCsP6itdmI3wCuJYvp37
         9xhTF49/yvhX+P81cxW9eqBDfFPGoMsmpmC/olMRNu3U6Zd9bwCDYg1f0UjTdncvo49P
         7F0L9lALsoCaRQpPi6Iu1AsrhUJm4sJb1knPFIEUGhM5hUDg6XoiGileDrRLilxHSImW
         GFtZJVkepeGECtgOdr19vRAGbDGfIPksiqJ5ps7nOZ9fE5MtqqKdzQUAqphCko/2l/VH
         woEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718733613; x=1719338413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywIyigSdpQlgMm2FiMND9yZ2xLjYHN/KA2Cy3RkcZ6A=;
        b=wMLQz+HnX9XZunMhpdC6PXxj4B0Kky3JPWqBbE5F9H1zcjE17j0M8hrZ6RxXhT3pto
         OOJx4R5KDd/vp4+tNIRJdnxvb3g/DmJohzsD89+Z+Mma+jqxXmuvrlCEm+pfLGa1wNzL
         HiO9wSBRW3NZ7nApU/d1IvPjOoC1XDoxAESW4jYWHQgzvdQ7AgeJcFWRMgYCqV3eW1bK
         lVbEH8Q+dZvIvOJvTp0lszN27cPEzZtqkw2Q/k01Wdh2UduFB/5oNkyfYySpfjpVAiOw
         C96EFGtxS9vWFiwmLTk4lR0sxYsxBofyHW98BCtgmhICez6hJjf+2IoMW8zlGIeFNsdl
         bwIA==
X-Forwarded-Encrypted: i=1; AJvYcCV63v/pWoC/s6/fXqzuAxFz7ZNwwy/6H0bDRqFy60QuB6KMhr/W5mczLbIqMa7adnzledP/fRGkNCfgVmnhDrZkCh68Z/kZFBfMkgCwiT5uLgrT1xGvRsUKTH5TfCv5P8mKR1UwdaDFQ5DVeexBvg==
X-Gm-Message-State: AOJu0Yz+gJ44SqPn33YTMiZqqKwjeLgFVIyv07moKrbYhPax3bIXLoFv
	jyg2Tk2p/BJ18RBUeggLxOOX3hQMjDKIMflFUM41u1ZxKGmXRUq08jf355/WAC5/LcjDmu5iNIU
	wNGqH0KMcZdP2ZZC1bCy8vg7i0Xw=
X-Google-Smtp-Source: AGHT+IHv5PYBGNsJryUqGTJt9i7VT0jkJjIiDn9KH/LoW9fy3x8NSnYzs4iKVYuuJ9z0NcZztZLQ/aD/FaaglfyYMd8=
X-Received: by 2002:a81:9184:0:b0:62f:ee76:c697 with SMTP id
 00721157ae682-63a8af51b66mr6792187b3.0.1718733612117; Tue, 18 Jun 2024
 11:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618152652.3446472-1-howardchu95@gmail.com>
 <20240618152652.3446472-6-howardchu95@gmail.com> <ZnHKOKFgJSaJA9UI@x1>
In-Reply-To: <ZnHKOKFgJSaJA9UI@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 19 Jun 2024 02:00:01 +0800
Message-ID: <CAH0uvohbwWM9Xhe4SzfF85S0qe3bnka0ULO-mX-whBd5s5yMNA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf trace: Add test for enum augmentation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Arnaldo, on it.

Thanks,
Howard

On Wed, Jun 19, 2024 at 1:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jun 18, 2024 at 11:26:52PM +0800, Howard Chu wrote:
> > Check for vmlinux's existence in sysfs as prerequisite.
>
> That is good, well done, but then we need to check if gcc is installed,
> and it may not be and we want to test this feature even so.
>
> So please take a look at git log tools/perf/tests/workloads/, then add a
> tools/perf/tests/workloads/landlock_add_rule.c and finally you'll be
> able to replace the inline landlock .c file + gcc to build it and
> instead use:
>
>   perf test -w landlock_add_rule
>
> As your workload.
>
> Then you update the last patch in your series, test it all and resend
> the whole series with a v2, with the description of v1 and v2 in the
> cover letter.
>
> Thanks,
>
> - Arnaldo
>
> > Compile and run a script which calls landlock_add_rule syscall,
> > trace the syscall to judge if the output is desirable.
> >
> > Trace the non-syscall tracepoint 'timer:hrtimer_init' and
> > 'timer:hrtimer_start', see if the 'mode' argument is augmented,
> > the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
> > in its name.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/tests/shell/trace_btf_enum.sh | 104 +++++++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/test=
s/shell/trace_btf_enum.sh
> > new file mode 100755
> > index 000000000000..14c73b0b594d
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> > @@ -0,0 +1,104 @@
> > +#!/bin/sh
> > +# perf trace enum augmentation tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +set -e
> > +
> > +syscall=3D"landlock_add_rule"
> > +non_syscall=3D"timer:hrtimer_init,timer:hrtimer_start"
> > +
> > +landlock_script=3D$(mktemp /tmp/landlock-XXXXX.c)
> > +landlock_ex=3D$(echo $landlock_script | sed -E 's/(.*).c$/\1/g')
> > +
> > +landlock_fd=3D24
> > +landlock_flags=3D25
> > +
> > +. "$(dirname $0)"/lib/probe.sh
> > +skip_if_no_perf_trace || exit 2
> > +
> > +enum_aug_prereq() {
> > +  echo "Checking perf trace enum augmentation prerequisites"
> > +  if ! ls /sys/kernel/btf/vmlinux 1>/dev/null 2>&1
> > +  then
> > +    echo "trace+enum test [Skipped missing vmlinux BTF support]"
> > +    err=3D2
> > +    return
> > +  fi
> > +}
> > +
> > +prepare_landlock_script() {
> > +  echo "Preparing script for ${syscall} syscall"
> > +
> > +  cat > $landlock_script << EOF
> > +#define _GNU_SOURCE
> > +#include <unistd.h>
> > +#include <linux/landlock.h>
> > +#include <sys/syscall.h>
> > +
> > +int main()
> > +{
> > +     int fd =3D ${landlock_fd};
> > +     int flags =3D ${landlock_flags};
> > +     struct landlock_path_beneath_attr path_beneath_attr =3D {
> > +         .allowed_access =3D LANDLOCK_ACCESS_FS_READ_FILE,
> > +     };
> > +     struct landlock_net_port_attr net_port_attr =3D {
> > +         .allowed_access =3D LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > +         .port =3D 443,
> > +     };
> > +
> > +     syscall(SYS_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
> > +             &path_beneath_attr, flags);
> > +
> > +     syscall(SYS_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
> > +             &net_port_attr, flags);
> > +
> > +     return 0;
> > +}
> > +EOF
> > +
> > +  gcc $landlock_script -o $landlock_ex
> > +}
> > +
> > +trace_landlock() {
> > +  echo "Tracing syscall ${syscall}"
> > +  if perf trace -e $syscall $landlock_ex 2>&1 | \
> > +     grep -q -E ".*landlock_add_rule\(ruleset_fd: ${landlock_fd}, rule=
_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a=
-f0-9]+, flags: ${landlock_flags}\) =3D -1.*"
> > +  then
> > +    err=3D0
> > +  else
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +trace_non_syscall() {
> > +  echo "Tracing non-syscall tracepoint ${non-syscall}"
> > +  if perf trace -e $non_syscall --max-events=3D1 2>&1 | \
> > +     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
> > +  then
> > +    err=3D0
> > +  else
> > +    err=3D1
> > +  fi
> > +}
> > +
> > +cleanup() {
> > +  rm -f $landlock_script $landlock_ex
> > +}
> > +
> > +enum_aug_prereq
> > +
> > +prepare_landlock_script
> > +
> > +if [ $err =3D 0 ]; then
> > +  trace_landlock
> > +fi
> > +
> > +if [ $err =3D 0 ]; then
> > +  trace_non_syscall
> > +fi
> > +
> > +cleanup
> > +
> > +exit $err
> > --
> > 2.45.2
> >
