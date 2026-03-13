Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50B35F5EC
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418217; cv=pass; b=tKkGiW72NnxNarv/0KeO+wpebstaOfqdr2K2An1CZLifxp3cPSbf5luEJ0UE0h/j/erWQDFRFyIpnBHRbKopdNRWibivN2u06NuwnRkdS81WsNksE51h+c/FpmIVazeg4ImvGwlxl69M2vS/mOf6PMz86Vxe9jMQ9deO7jk//Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418217; c=relaxed/simple;
	bh=D4aznZnKhg3vcwwMP7QsnFKZ15SCJqtN99hmN3ppdOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=php9Y294OHM5Ubx59iy6VCWl+cC2W2m36C1y+Zq3dwqKgV26IeQMYTgQcycMXoDQU+4wPnCIAT3xk73OXPit+giO7kA5dlTxrI1JfscTduhcSbuV1ezloPOjlJ5eU5uwdl/8r4mfP8psNT1crmOt8np5RI+bNT28wNpogDONdS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvUFgafp; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvUFgafp"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae3f822163so110075ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 09:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773418215; cv=none;
        d=google.com; s=arc-20240605;
        b=jB4K0G1WeUylJN7I4Pxm+78DuCFVZ2iOo+IUaILEtIMbwbQBr0dcBNOXDs320ZSo9C
         FfIWqit+U8kJU6AdJHruuioch3aXq89M+eozq7Mr70DHhIW+J1+HJPOUm1B1SQT6EF6g
         SLH+6XdTCoob+rXsYGCODvbsBMNJd1Cj9qauLcqnv2IpU8gD8AVU8TeLX9NzIXV4KD1Q
         Oa82GHLdxqQjpK/sCDZSE7d3BvjwL4syr6dXSx3c734Azc9/HeyEaXlYDpvO5hu3wl/x
         y/GeX2a80PvxtZgBrcmqQyQ5+OE0Zu8ftapQlnrG1riJSENt6w7WkirquVGNb/5hM45r
         rtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5jNpwuSW4bj9NOZEcZ+L0IUbrl4iyp3XE/AdI0AXzso=;
        fh=MdMhNGSVlAtATStE3OaALMmZLbzam/j5ECXb5tLdf4A=;
        b=C+DekXd0tRV8eC9cLK53g9ZjO7zpTE+RqneSNPGcz3Rf9b3I0jpdoEu1v5wfKOTQMw
         1hxFsD6W9rLcy1Vf0Sao0qnf8YjZQyqEGDrPj5hD178o7nxX1N8RgUjCPBRAWkVrOMkm
         +/C4zPWJ2iMziNLw/Gq47bw8AxxD7ryN7ulJXFneqviaElAskhggY913abzLCZ0DDCIB
         voQsdgyPe+fcP8tO5B5mSGTGHHL/pmNkIyvBg4It4vCu7XzumaishpJ/v6gDlub5sJc5
         eue+1z5Ca1PCF+AHpbtsHOkTkj3Sm50rnWVBX2ApAEjLFKk1lxmI/m0tbrVAoIUU2ufu
         ZIiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773418215; x=1774023015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jNpwuSW4bj9NOZEcZ+L0IUbrl4iyp3XE/AdI0AXzso=;
        b=QvUFgafpcR5jBqRZxNlZit9cOUXxsFsCJEsA1E0NGZds8be7LeIocvRbUiavdgMo0X
         MHJFjb0RfRpw9I1kt0Ww+h2woVuFSc1eTk00pdF9aSiVaxrA1sTbcRW/5kMbw4ixut5e
         Rea7oKIMfCQ8fezngQYo6RYim4VfkmGnWcwX9jlESBq5try/QWi6YI68zUKinxuwB/Rc
         1YZoU7NsK2hUXzHKPu4Uham23QYmHvTXc+ohbfCj5XcjEex3ITXdGvUNDff6Dmt3A5em
         0fHIlplRHcAqlIIMZNTJiNUsufukXGWdBx1Sa9UXK073d4ahm+p1a6TLuUSs1AiuQSpZ
         5vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418215; x=1774023015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5jNpwuSW4bj9NOZEcZ+L0IUbrl4iyp3XE/AdI0AXzso=;
        b=M7LRvNyCvMkkw1VCaCYlzGQB6qLkmh2/aCzd0Lk4Yw3LteegrRouDzQPkXcL22jLa1
         yplC/k3EZ/r8WJ/56rncm92m/LkaCViEQRgKTi0x10v6is22jPBUodkMQeTd1OUHGDMt
         O0uu5U7KGl+loCBqYnkNSlwCILw/20Z1rRAlPFV7UOrCp33Hn4vYUEJfh6z9uvNuK0K5
         e/PfTzGnDLD3lqPNG/Y8t0OiEhtv4k4/rJmBDZ0EGUV9KfGPi4K/KcXPIEMqAjAByVp6
         djpyGWgJStzbboC0hhosBkk5/GTMlpodc5qM9lDv2fb0pc9ChI6rWxisgTgID30YKdCe
         M7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRA2VuWbLodF8et3U/6RSLU4nbB65ZhfgZkCxAKxICFcByDgCy4+YHmscfZtdQFMdryFJTDO++tzGAr9ikSTXv@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdOLZlhpLmso2RjHjagrno/CHb5mepOjr8tuaQ2GuduYKLq9v
	xkxkUuJu9W5bDoA1H74ilcbp8aePWuZvqcRgsQCoUcwQx5Qg7CyXhWPztuh4QPAns6OKRo9sog3
	4vgouOlZ5u9cNY3pU0HYjG2vD9aw1SFrQ4WwJD04A3Ias8OnMRgTADJZYCX5N4A==
X-Gm-Gg: ATEYQzyE8+5Zz2S3x5XrJ7K6U/Ey1KRbpbOS6v2Ol/9ang4BbbAOKDFQNMsYqwyA7ey
	YqkkShP7QjbrwH4vwsluVXi5xSuRahcNnj2uT3F7vhGuNdxiRbE84+TDHXMTxv1qGzgDjVDihQi
	k6+ARLgT4162HqSLDj4bxiMKXuF9CabCZcdAp87acBabyjrSAm6Xki8xvDCCZMHDAcbK/mBwS2c
	L5bGMC1M1UPdvzyTQ8WR/1189L8Dtm8+dlUvr7IzqI3E1eThxOIsYqPxdTCOHajJnqpiUY6xLgZ
	80bYuTl3Ua1sZY3cMjlz4fKy2Sr/hNl73G8M
X-Received: by 2002:a17:902:c945:b0:2ae:4572:50e8 with SMTP id
 d9443c01a7336-2aecb5aacf1mr3216265ad.8.1773418214743; Fri, 13 Mar 2026
 09:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <D40D4E89-3F4E-482C-9EB8-DCFAC70095AB@gmail.com>
In-Reply-To: <D40D4E89-3F4E-482C-9EB8-DCFAC70095AB@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Mar 2026 09:10:03 -0700
X-Gm-Features: AaiRm52rgai0ZEFVyj0Wwyj-0EQP-aVs-46bC5q7rOGoeO5NIW_GB-FBhppzQe0
Message-ID: <CAP-5=fVxRd_byM2zZ_hLoZ36vPsN02nE4FozUuuwojXcJ3eODg@mail.gmail.com>
Subject: Re: perf stat issue with 7.0.0rc3
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:56=E2=80=AFAM Arnaldo Melo <arnaldo.melo@gmail.co=
m> wrote:
>
> On March 13, 2026 12:41:48 PM GMT-03:00, Ian Rogers <irogers@google.com> =
wrote:
> >On Fri, Mar 13, 2026 at 8:19=E2=80=AFAM Arnaldo Carvalho de Melo
> ><acme@kernel.org> wrote:
> >>
> >> On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
> >> > Ian,
> >> >
> >> > I just discovered a strange behavior on linux 7.0.0rc3.
> >> >
> >> > I run these commands on my x86 virtual machine:
> >> >
> >> > bash-5.3# uname -m
> >> > x86_64
> >> > bash-5.3# perf -v
> >> > perf version 6.18.13-200.fc43.x86_64
> >> > bash-5.3# perf stat -- true
> >> >
> >> >  Performance counter stats for 'true':
> >> >
> >> >          1.108.929      task-clock                       #    0,437 =
CPUs utilized
> >> >                  0      context-switches                 #    0,000 =
/sec
> >> >                  0      cpu-migrations                   #    0,000 =
/sec
> >> >                 55      page-faults                      #   49,597 =
K/sec
> >> >    <not supported>      cycles
> >> >
> >> >        0,002536439 seconds time elapsed
> >> >
> >> >        0,001363000 seconds user
> >> >        0,001393000 seconds sys
> >> >
> >> > bash-5.3#
> >> >
> >> > This is the epected output, however when I use the perf version 7.0.=
0rc3:
> >> >
> >> > bash-5.3# ./perf -v
> >> > perf version 7.0.rc3.g1f318b96cc84
> >> > bash-5.3# ./perf stat -- true
> >> > Error:
> >> > No supported events found.
> >> > trace.args_alignment
> >>
> >> And this last line is even stranger, in my case I get something else,
> >> also on x86_64:
> >>
> >> root@number:~#  perf stat -- true
> >> Error:
> >> No supported events found.
> >> addr2line.style
> >> root@number:~#
> >>
> >> On an ARM machine:
> >>
> >> acme@raspberrypi:~/git/perf-tools $ perf stat -- true
> >> Error:
> >> No supported events found.
> >>
> >> acme@raspberrypi:~/git/perf-tools $ uname -a
> >> Linux raspberrypi 6.12.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.62=
-1+rpt1 (2025-12-18) aarch64 GNU/Linux
> >> acme@raspberrypi:~/git/perf-tools $
> >>
> >> I'll try to bisect this later, thanks for the report!
> >
> >Hi Arnaldo,
> >
> >Leo has pointed at the fix:
> >https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
.git/commit/tools/perf/util/metricgroup.c?h=3Dperf-tools-next&id=3Dc5a244bf=
17caf2de22f9e100832b75f72b31d3e6
> >This also showed up as missing for the LTS backports:
> >https://lore.kernel.org/lkml/ad95d781-7eb2-4c0c-a9e9-aaabae8eb602@kernel=
.org/
> >so I thought it was flagged as a fix for the next PR. I don't see it in =
there:
> >https://lore.kernel.org/lkml/20260313151434.1695228-1-acme@kernel.org/
> >Could we get it in?
> >
>
> Sure, I'll process it for the next PR, thanks for pointing it to me, I'll=
 test it later,

No worries, presumably if I'd been monitoring:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/log=
/?h=3Dtmp.perf-tools
I'd have seen it was missing. Perhaps you can give a heads up to check
for missing patches when assembling the PRs. I rarely look at
perf-tools.git as perf-tools-next.git is where all the action is :-)
Actually, I vibe coded a script that may work to automate this:
```
#!/bin/bash

# Configuration
STABLE_REMOTE=3D"perf-tools"
STABLE_BRANCH=3D"perf-tools" # Adjust if your stable branch is named differ=
ently
NEXT_REMOTE=3D"perf-tools-next"
NEXT_BRANCH=3D"perf-tools-next"

echo "Checking for fix candidates in $NEXT_REMOTE/$NEXT_BRANCH..."
echo "Targeting stable release: $STABLE_REMOTE/$STABLE_BRANCH"
echo "-------------------------------------------------------"

# 1. Get all commits in 'next' that aren't in 'stable'
# 2. Search their bodies for the "Fixes:" tag
# 3. Extract the SHA from the Fixes tag
git log ${STABLE_REMOTE}/${STABLE_BRANCH}..${NEXT_REMOTE}/${NEXT_BRANCH}
--format=3D"%H" | while read -r next_sha; do

    # Extract the SHA mentioned in the Fixes: line
    # Matches 'Fixes: <sha> ("subject")'
    fixed_sha=3D$(git log -1 --format=3D"%b" "$next_sha" | grep -i
"Fixes:" | sed -E 's/.*Fixes: ([a-f0-9]+).*/\1/')

    if [ -n "$fixed_sha" ]; then
        # Check if the fixed_sha exists in the stable remote's history
        if git merge-base --is-ancestor "$fixed_sha"
${STABLE_REMOTE}/${STABLE_BRANCH} 2>/dev/null; then
            subject=3D$(git log -1 --format=3D"%s" "$next_sha")
            echo "Candidate: $next_sha"
            echo "  Subject: $subject"
            echo "  Fixes:   $fixed_sha (Found in $STABLE_REMOTE)"
            echo "  Command: git cherry-pick -x $next_sha"
            echo ""
        fi
    fi
done
```
Running this showed:
```
Checking for fix candidates in perf-tools-next/perf-tools-next...
Targeting stable release: perf-tools/perf-tools
-------------------------------------------------------
Candidate: 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b
  Subject: perf test type profiling: Remote typedef on struct
  Fixes:   335047109d7d (Found in perf-tools)
  Command: git cherry-pick -x 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b

Candidate: 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec
  Subject: perf kvm stat: Fix relative paths for including headers
  Fixes:   a724a8fce5e2 (Found in perf-tools)
  Command: git cherry-pick -x 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec

Candidate: 96f202eab8133f94479b14a32902c636e9bdf6af
  Subject: perf trace: Fix IS_ERR() vs NULL check bug
  Fixes:   ef2da619b132c6f74 (Found in perf-tools)
  Command: git cherry-pick -x 96f202eab8133f94479b14a32902c636e9bdf6af

Candidate: c5a244bf17caf2de22f9e100832b75f72b31d3e6
  Subject: perf metricgroup: Fix metricgroup__has_metric_or_groups
  Fixes:   cee275edcdb1 (Found in perf-tools)
  Command: git cherry-pick -x c5a244bf17caf2de22f9e100832b75f72b31d3e6

Candidate: aa6a6a2d16c1e2e27e986936369959d70316199f
  Subject: perf parse-events: Fix big-endian 'overwrite' by writing
correct union member
  Fixes:   159ca97cd97c (Found in perf-tools)
  Command: git cherry-pick -x aa6a6a2d16c1e2e27e986936369959d70316199f
```

Thanks,
Ian

> - Arnaldo
>
>
> >Thanks,
> >Ian
> >
> >
> >
> >> - Arnaldo
> >>
> >> > bash-5.3#
> >> >
> >> > Same happens on my s390 systems (LPAR and z/VM).
> >> > Is this a known already?
> >> > I guess this is a perf tool issue, same result when you execute this=
 on a 7.0.0rc3
> >> > kernel.
> >> >
> >> > Any ideas where to start debugging
> >> > --
> >> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, G=
ermany
> >> > --
> >> > IBM Deutschland Research & Development GmbH
> >> >
> >> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> >> >
> >> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
> >> >
> >> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht=
 Stuttgart, HRB 243294
> >> >
>
> - Arnaldo
