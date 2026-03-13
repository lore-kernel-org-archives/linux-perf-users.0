Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152923CBE97
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422379; cv=none; b=gK+4paEsX+k3zsKGG8a8kpnUGr0U/idZPN+4mzlCzwYkYRYHqSDQEphgzQ8JWnE3EcclVWGD4Gs1Bonjdw1/vNUxlRCNT49kvF+MFXObYVQzFbYQLnmEtgxzQ5Xn/EV9CkFdl76ks7GS66rk4IpC8m7Fu4wJdXQoiVslhXO+ERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422379; c=relaxed/simple;
	bh=l5kq6v6qMxKQ/1I7hTyq7tFosVak24GuUuwL6BAAxh0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k+ZF4S0hpdEBR692vU1BQZbrrF7bJkz61AP2+bW4hJNPIpjJi1o0yiiPyPwd0hdkMcih/axAuoeXNsUMaHCeSHeIH2c9deOMynmw343llVg1J5NuGf5dVB8l9/hzzYiwJwgHd6gXKfuYbevIMTtUxs2dHY5LtdhQvHK4d5Pvgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmHeaaVx; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmHeaaVx"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso3712367c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773422376; x=1774027176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=16TtbDRHKAwzlXrsGEf+DFX7eu0OZ5PjQjE7wrl98x8=;
        b=RmHeaaVxb+5ijocq3z9QGL1H8pui9MDOLqzZPNKharz/F2OZNDSE0M2fdPdg5NHD7l
         k7uvYb5aNQ7LzT46w7smQNa726azCkCPnPXJVAXy7rtHLWJdswP7hRFbtaPu8Sp7rabu
         8pyJgb3BxwVR5lE3iWUs/OJEuLjo63AzjUM7OScSuOMYioWX/3ULM91Ez1q+rKkfvbNX
         pVC/Z46+7AUOAt2YHfMr9adh+smtKttCeG/muyFp0Z6VWOLgfYHPTkdBzjQhZi7LTcI2
         3U6iHwmxU2D4Iass9IEo+ZXh0sonIdooP2yHp3ehJsOmJCzjWiawmNQAGS7RN/qXTkh+
         kuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773422376; x=1774027176;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16TtbDRHKAwzlXrsGEf+DFX7eu0OZ5PjQjE7wrl98x8=;
        b=S2GHRaQ2xAFy+ONPNhYVy06aiyuyFt7tBSLrTA2hPSqnN9sKDzGkDDLzFR3n8ZcpR6
         zv/JZHyFbq+6oxI+qumrDeMiyOwMbXhtXyoYwid/pMKjNJ++fyQIL2YpiWyC7l+s+jtm
         hbDv8IJM2OMjTS0+73wGEDKUZONZ11L+Uk154KHef0UVET5bJMFqyM2R3j7Skf8c4Ohq
         t9QHGRX2G5IVt/NCN6aDilQBBklWqV9BFPbP8SGk3Glz2uBUgG3k4iTWNCtlaad1XPfX
         wDmblHe/8xi3PebmedXwjHmyMj0XtMpBgidtwab0lur8JK5+Hu6VevQOJXQE7cmw1JIb
         4OVA==
X-Forwarded-Encrypted: i=1; AJvYcCXyyp8HjenFKhffp8eF8hg4yF/4Q3FiMsdhUn8zLnapl/QioTDlUFpNh6S/Iu4HdZNbb5ER9INkcbXyeBMAXZUg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8B1lnC+PFPS7ERW7X/610ydM5UD3Ul0NqWaPtQepHes/D3m2l
	NnLjptaOUCS71sWr4n0IVsU+88uACR9dugrgyIHlaMyZS7GBihMCDn8N
X-Gm-Gg: ATEYQzxgm+uPRaq1ynA0B4HXzCZcQWN9eF4NQhpy643umiB+/JVZyjE1LHzqIW/8UtP
	lOKSFUHe2ScesLD778yA4A59k6FkN1Q4OFljRAIAy7lhGVq+1xrv3j1A6QnLWZYnrqDTDRhdt6T
	0NXbrKuzsUdoJ7vK+ub2SjLnKCD5YTc65P8wSjq+GmFtITF9wNeO4J5SJv1IQBU6mxuNGrd0jb5
	rUpmXeVvOAUPHtGtkPPBtSk+HfwrDOd8ffgGuwNBwyuq/zF06rh6NIWS2MAd6T7oyJk029EXIbU
	2rE7N2ZJP1o/8Wc8vOUzFdYuSpXot0+P6+2W++tAnHVjZ156/a5c+MRJYUGlzA6qahcHHHcyWtZ
	P06ggRJB6RpAhssLUOMxIIriS3CWOC6sqDGZJdmCH1b8feRK0FnS4ZCzjXMXrNSaUGujfH+KLZf
	8xOShd4wEb1nrLefDZ6HG+xgaYzkrQBwOY1Ju1tjDuaOA=
X-Received: by 2002:a05:7022:7a4:b0:128:d51a:5157 with SMTP id a92af1059eb24-128f3df1824mr1868306c88.33.1773422375807;
        Fri, 13 Mar 2026 10:19:35 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:389:4050:f2cd:0:2:1702:2701])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62af8desm2583615c88.6.2026.03.13.10.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 10:19:35 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:01:31 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Thomas Richter <tmricht@linux.ibm.com>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 Jan Polensky <japo@linux.ibm.com>
Subject: Re: perf stat issue with 7.0.0rc3
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fVxRd_byM2zZ_hLoZ36vPsN02nE4FozUuuwojXcJ3eODg@mail.gmail.com>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com> <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com> <D40D4E89-3F4E-482C-9EB8-DCFAC70095AB@gmail.com> <CAP-5=fVxRd_byM2zZ_hLoZ36vPsN02nE4FozUuuwojXcJ3eODg@mail.gmail.com>
Message-ID: <957241A0-E5C8-417C-98B7-B6E1EAFE19B1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 13, 2026 1:10:03 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> =
wrote:
>On Fri, Mar 13, 2026 at 8:56=E2=80=AFAM Arnaldo Melo <arnaldo=2Emelo@gmai=
l=2Ecom> wrote:
>>
>> On March 13, 2026 12:41:48 PM GMT-03:00, Ian Rogers <irogers@google=2Ec=
om> wrote:
>> >On Fri, Mar 13, 2026 at 8:19=E2=80=AFAM Arnaldo Carvalho de Melo
>> ><acme@kernel=2Eorg> wrote:
>> >>
>> >> On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
>> >> > Ian,
>> >> >
>> >> > I just discovered a strange behavior on linux 7=2E0=2E0rc3=2E
>> >> >
>> >> > I run these commands on my x86 virtual machine:
>> >> >
>> >> > bash-5=2E3# uname -m
>> >> > x86_64
>> >> > bash-5=2E3# perf -v
>> >> > perf version 6=2E18=2E13-200=2Efc43=2Ex86_64
>> >> > bash-5=2E3# perf stat -- true
>> >> >
>> >> >  Performance counter stats for 'true':
>> >> >
>> >> >          1=2E108=2E929      task-clock                       #    =
0,437 CPUs utilized
>> >> >                  0      context-switches                 #    0,00=
0 /sec
>> >> >                  0      cpu-migrations                   #    0,00=
0 /sec
>> >> >                 55      page-faults                      #   49,59=
7 K/sec
>> >> >    <not supported>      cycles
>> >> >
>> >> >        0,002536439 seconds time elapsed
>> >> >
>> >> >        0,001363000 seconds user
>> >> >        0,001393000 seconds sys
>> >> >
>> >> > bash-5=2E3#
>> >> >
>> >> > This is the epected output, however when I use the perf version 7=
=2E0=2E0rc3:
>> >> >
>> >> > bash-5=2E3# =2E/perf -v
>> >> > perf version 7=2E0=2Erc3=2Eg1f318b96cc84
>> >> > bash-5=2E3# =2E/perf stat -- true
>> >> > Error:
>> >> > No supported events found=2E
>> >> > trace=2Eargs_alignment
>> >>
>> >> And this last line is even stranger, in my case I get something else=
,
>> >> also on x86_64:
>> >>
>> >> root@number:~#  perf stat -- true
>> >> Error:
>> >> No supported events found=2E
>> >> addr2line=2Estyle
>> >> root@number:~#
>> >>
>> >> On an ARM machine:
>> >>
>> >> acme@raspberrypi:~/git/perf-tools $ perf stat -- true
>> >> Error:
>> >> No supported events found=2E
>> >>
>> >> acme@raspberrypi:~/git/perf-tools $ uname -a
>> >> Linux raspberrypi 6=2E12=2E62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6=
=2E12=2E62-1+rpt1 (2025-12-18) aarch64 GNU/Linux
>> >> acme@raspberrypi:~/git/perf-tools $
>> >>
>> >> I'll try to bisect this later, thanks for the report!
>> >
>> >Hi Arnaldo,
>> >
>> >Leo has pointed at the fix:
>> >https://web=2Egit=2Ekernel=2Eorg/pub/scm/linux/kernel/git/perf/perf-to=
ols-next=2Egit/commit/tools/perf/util/metricgroup=2Ec?h=3Dperf-tools-next&i=
d=3Dc5a244bf17caf2de22f9e100832b75f72b31d3e6
>> >This also showed up as missing for the LTS backports:
>> >https://lore=2Ekernel=2Eorg/lkml/ad95d781-7eb2-4c0c-a9e9-aaabae8eb602@=
kernel=2Eorg/
>> >so I thought it was flagged as a fix for the next PR=2E I don't see it=
 in there:
>> >https://lore=2Ekernel=2Eorg/lkml/20260313151434=2E1695228-1-acme@kerne=
l=2Eorg/
>> >Could we get it in?
>> >
>>
>> Sure, I'll process it for the next PR, thanks for pointing it to me, I'=
ll test it later,
>
>No worries, presumably if I'd been monitoring:
>https://web=2Egit=2Ekernel=2Eorg/pub/scm/linux/kernel/git/perf/perf-tools=
=2Egit/log/?h=3Dtmp=2Eperf-tools
>I'd have seen it was missing=2E Perhaps you can give a heads up to check
>for missing patches when assembling the PRs=2E I rarely look at
>perf-tools=2Egit as perf-tools-next=2Egit is where all the action is :-)
>Actually, I vibe coded a script that may work to automate this:
>```


Well, if those patches are ok for perf-tools, i=2Ee=2E are fixes for bugs =
introduced in the current merge window or urgent fixes for longstanding bug=
s, they shouldn't be in perf-tools-next, they should be in perf-tools to be=
 merger in the current merge window=2E=20

Coordination in triaging via an Acked-by/Reviewed-by pointing out it's som=
ething for the current merge window, something I do, is what we should stri=
ve to do=2E=20

When I notice something that's needed for the current window that's been p=
rocessed by Namhyung for perf-tools-next, I merge it as well (as will be in=
 this case and maybe in the others that you pointed out, thanks, I'll check=
 each one)=2E

No problem with that, better be in both branches than to get missed :-)

Thanks,=20

- Arnaldo


>#!/bin/bash
>
># Configuration
>STABLE_REMOTE=3D"perf-tools"
>STABLE_BRANCH=3D"perf-tools" # Adjust if your stable branch is named diff=
erently
>NEXT_REMOTE=3D"perf-tools-next"
>NEXT_BRANCH=3D"perf-tools-next"
>
>echo "Checking for fix candidates in $NEXT_REMOTE/$NEXT_BRANCH=2E=2E=2E"
>echo "Targeting stable release: $STABLE_REMOTE/$STABLE_BRANCH"
>echo "-------------------------------------------------------"
>
># 1=2E Get all commits in 'next' that aren't in 'stable'
># 2=2E Search their bodies for the "Fixes:" tag
># 3=2E Extract the SHA from the Fixes tag
>git log ${STABLE_REMOTE}/${STABLE_BRANCH}=2E=2E${NEXT_REMOTE}/${NEXT_BRAN=
CH}
>--format=3D"%H" | while read -r next_sha; do
>
>    # Extract the SHA mentioned in the Fixes: line
>    # Matches 'Fixes: <sha> ("subject")'
>    fixed_sha=3D$(git log -1 --format=3D"%b" "$next_sha" | grep -i
>"Fixes:" | sed -E 's/=2E*Fixes: ([a-f0-9]+)=2E*/\1/')
>
>    if [ -n "$fixed_sha" ]; then
>        # Check if the fixed_sha exists in the stable remote's history
>        if git merge-base --is-ancestor "$fixed_sha"
>${STABLE_REMOTE}/${STABLE_BRANCH} 2>/dev/null; then
>            subject=3D$(git log -1 --format=3D"%s" "$next_sha")
>            echo "Candidate: $next_sha"
>            echo "  Subject: $subject"
>            echo "  Fixes:   $fixed_sha (Found in $STABLE_REMOTE)"
>            echo "  Command: git cherry-pick -x $next_sha"
>            echo ""
>        fi
>    fi
>done
>```
>Running this showed:
>```
>Checking for fix candidates in perf-tools-next/perf-tools-next=2E=2E=2E
>Targeting stable release: perf-tools/perf-tools
>-------------------------------------------------------
>Candidate: 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b
>  Subject: perf test type profiling: Remote typedef on struct
>  Fixes:   335047109d7d (Found in perf-tools)
>  Command: git cherry-pick -x 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b
>
>Candidate: 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec
>  Subject: perf kvm stat: Fix relative paths for including headers
>  Fixes:   a724a8fce5e2 (Found in perf-tools)
>  Command: git cherry-pick -x 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec
>
>Candidate: 96f202eab8133f94479b14a32902c636e9bdf6af
>  Subject: perf trace: Fix IS_ERR() vs NULL check bug
>  Fixes:   ef2da619b132c6f74 (Found in perf-tools)
>  Command: git cherry-pick -x 96f202eab8133f94479b14a32902c636e9bdf6af
>
>Candidate: c5a244bf17caf2de22f9e100832b75f72b31d3e6
>  Subject: perf metricgroup: Fix metricgroup__has_metric_or_groups
>  Fixes:   cee275edcdb1 (Found in perf-tools)
>  Command: git cherry-pick -x c5a244bf17caf2de22f9e100832b75f72b31d3e6
>
>Candidate: aa6a6a2d16c1e2e27e986936369959d70316199f
>  Subject: perf parse-events: Fix big-endian 'overwrite' by writing
>correct union member
>  Fixes:   159ca97cd97c (Found in perf-tools)
>  Command: git cherry-pick -x aa6a6a2d16c1e2e27e986936369959d70316199f
>```
>
>Thanks,
>Ian
>
>> - Arnaldo
>>
>>
>> >Thanks,
>> >Ian
>> >
>> >
>> >
>> >> - Arnaldo
>> >>
>> >> > bash-5=2E3#
>> >> >
>> >> > Same happens on my s390 systems (LPAR and z/VM)=2E
>> >> > Is this a known already?
>> >> > I guess this is a perf tool issue, same result when you execute th=
is on a 7=2E0=2E0rc3
>> >> > kernel=2E
>> >> >
>> >> > Any ideas where to start debugging
>> >> > --
>> >> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen,=
 Germany
>> >> > --
>> >> > IBM Deutschland Research & Development GmbH
>> >> >
>> >> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>> >> >
>> >> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
>> >> >
>> >> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgeric=
ht Stuttgart, HRB 243294
>> >> >
>>
>> - Arnaldo

- Arnaldo 
