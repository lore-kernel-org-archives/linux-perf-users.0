Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3F3612EE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417426; cv=none; b=f8zdQl4r9+LAy2qWIhgVgYA7udmbFPaQdx/Cap/wgWYSaa9izbmu/aXeWMRxtB9SZe+hfgdp+Vdp6mTTctv/9LXgoqL/tOXlD7F+1C9lB7tBDt/6kncMYZKiFvC9K6Fl+FTXmBlBf2qVOxCq2LFirebsr2ELdBoohu4bDLKf1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417426; c=relaxed/simple;
	bh=/JBwGz+UR4Zpa72oZxAW8Iq2qDyN2MAt9o/6fLNtG8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZVjsnp4u0smPDjo9wdDz2Oo/rys4GPf8Lp8+cZKNBNuEEU7vSy/qO2ZCDg1gSC+xWOWUEnm/3vsm900z3WHkgf5Fe+LvuzrIHLnG3UwSgmEpVD2sHw2lsGJLb6pPsDBA+QYApQduZO/i54yr+JoZOe23HCyvaB9P7sOd/z41Etg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDJFCRH7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDJFCRH7"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7991db3dc98so23265247b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773417416; x=1774022216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ic47jz+nYy5HOEArK+8BjIGomtF8jNUgPYJh5UNV36o=;
        b=GDJFCRH7Ws2eA7lYe8YvY4LVy4SaqyuhS8hHu1ZC0kmusvbLGzkRhxiE9UWli/ZINz
         4i+HdlwIorIGgkOxUKbSI4UOtCqCucBusJHY3YJc6YU/FQqH4SbuvvZsF3/7XiIsC8j6
         HUxuMk0x1efEmr8YGO38AwzZApBLtWmghNuSWx1U/Z91GCWbc+AIIFYvc/DzMU4EbooF
         VuLhMrh/POWACYEeeDFO6n3nc0zmNv7QNAOOZaNSg5dYSMeUjcgWOtFxn8u97rYNFkzN
         IFibDxf+msnxLCAscVgakAKCJN525J7360vX24krSGzC+efQIkQH26+/Kr9mSD5RxLjs
         So/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417416; x=1774022216;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic47jz+nYy5HOEArK+8BjIGomtF8jNUgPYJh5UNV36o=;
        b=hQMHA/4+RdlgMC0HI4r2IgXVBvJyz/+XyQlC0YsKCZvmOrRxVRkcXWdUfhwQ5BnPIQ
         TpdoKdpnkaWaqhVL73gJiNJOQ/nXGv2tetjgrcwVWJwMvFcMIde8h75iYcsD5SEP39Lf
         iO+P/ObuafR4HuiJbXELTMox+yzbTzEke6zPdy2jbqlfWLwWgFzVeHzzYt98/Cwq5etX
         eAlFCb78vkyFD8wKREBOwM/Z8/NFhyYADlQQ98AX1PW8OJMQCryAH/GGb6R5lhamnEQx
         5vqdU4z7yomcvK3VO9FVEoXyBm6ADY4J1aDOqXSK5h246Q9bdkwpCCBHN0hAfR8+abfk
         dfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl6zWNFWMLn1473pRv8FyxHi8GilIH3ErBg5ddc8JdZ3hkTkk1LWE1aBbtscaIe+ZgWlgeDx3xa4V5XRUT+DxK@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZGGwYDgTr+XnsswEjwxYNrG1NcuXKkiaQ/M23zGUJmLUnGnH
	Bf6dCXwuWkFUPCfWrwNcKmGbC5lYT9c07r63/tlW/cjHHsTm7gvX/q8O1yzXpA==
X-Gm-Gg: ATEYQzyhqcuqQCmT0n7Z94BRVUKV88SVqgUBEsbsyjrfBjYYsQbrOiG28MczZ1pUlV7
	wNTxDqWmvsgfCeEu0VWxqJOhWlKPfZh52LFpD7qZKVj2YAtRhmIcA0DoRyHRPVAqyCVA/rS8gsB
	RReMyNcazHwbQ7GArMNOTydVxz/vfovZjQCAp0IcqbXyqR490I+BuJ9dlYqDzLBg2EFKiatF1XV
	Pdb+Hh/vAv4YcjprA4uPY8Ua3LBgbeKNb3PpDd3kg1BXnqqlmWzErhlBd0zUZmG4UfBf1Z4BhTg
	OicatGBHMBQZExC/bFMAmTQHeW/kOw7r18kHLxBrfYgS7eh+dnS6JjLNHvDy41GvXMdmzdZ9Per
	zyp0A46R+ERKfz9BWyIryEGgeml4gTPANxIhAWO1KWpduhjL4hcyQQjAMGuQlAYZqDSb5CXIE5m
	JgfXvP1dgQ2mDEa+VC21UlzMWBCWD7N7Ip
X-Received: by 2002:a05:690c:d91:b0:798:68c0:d9fc with SMTP id 00721157ae682-79a1c1bfe96mr39015277b3.49.1773417416519;
        Fri, 13 Mar 2026 08:56:56 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:389:4050:f2cd:0:2:1702:2701])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f08134sm48081127b3.36.2026.03.13.08.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 08:56:56 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:56:52 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Thomas Richter <tmricht@linux.ibm.com>,
 "linux-perf-use." <linux-perf-users@vger.kernel.org>,
 Jan Polensky <japo@linux.ibm.com>
Subject: Re: perf stat issue with 7.0.0rc3
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com> <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
Message-ID: <D40D4E89-3F4E-482C-9EB8-DCFAC70095AB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 13, 2026 12:41:48 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom>=
 wrote:
>On Fri, Mar 13, 2026 at 8:19=E2=80=AFAM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
>> > Ian,
>> >
>> > I just discovered a strange behavior on linux 7=2E0=2E0rc3=2E
>> >
>> > I run these commands on my x86 virtual machine:
>> >
>> > bash-5=2E3# uname -m
>> > x86_64
>> > bash-5=2E3# perf -v
>> > perf version 6=2E18=2E13-200=2Efc43=2Ex86_64
>> > bash-5=2E3# perf stat -- true
>> >
>> >  Performance counter stats for 'true':
>> >
>> >          1=2E108=2E929      task-clock                       #    0,4=
37 CPUs utilized
>> >                  0      context-switches                 #    0,000 /=
sec
>> >                  0      cpu-migrations                   #    0,000 /=
sec
>> >                 55      page-faults                      #   49,597 K=
/sec
>> >    <not supported>      cycles
>> >
>> >        0,002536439 seconds time elapsed
>> >
>> >        0,001363000 seconds user
>> >        0,001393000 seconds sys
>> >
>> > bash-5=2E3#
>> >
>> > This is the epected output, however when I use the perf version 7=2E0=
=2E0rc3:
>> >
>> > bash-5=2E3# =2E/perf -v
>> > perf version 7=2E0=2Erc3=2Eg1f318b96cc84
>> > bash-5=2E3# =2E/perf stat -- true
>> > Error:
>> > No supported events found=2E
>> > trace=2Eargs_alignment
>>
>> And this last line is even stranger, in my case I get something else,
>> also on x86_64:
>>
>> root@number:~#  perf stat -- true
>> Error:
>> No supported events found=2E
>> addr2line=2Estyle
>> root@number:~#
>>
>> On an ARM machine:
>>
>> acme@raspberrypi:~/git/perf-tools $ perf stat -- true
>> Error:
>> No supported events found=2E
>>
>> acme@raspberrypi:~/git/perf-tools $ uname -a
>> Linux raspberrypi 6=2E12=2E62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6=2E=
12=2E62-1+rpt1 (2025-12-18) aarch64 GNU/Linux
>> acme@raspberrypi:~/git/perf-tools $
>>
>> I'll try to bisect this later, thanks for the report!
>
>Hi Arnaldo,
>
>Leo has pointed at the fix:
>https://web=2Egit=2Ekernel=2Eorg/pub/scm/linux/kernel/git/perf/perf-tools=
-next=2Egit/commit/tools/perf/util/metricgroup=2Ec?h=3Dperf-tools-next&id=
=3Dc5a244bf17caf2de22f9e100832b75f72b31d3e6
>This also showed up as missing for the LTS backports:
>https://lore=2Ekernel=2Eorg/lkml/ad95d781-7eb2-4c0c-a9e9-aaabae8eb602@ker=
nel=2Eorg/
>so I thought it was flagged as a fix for the next PR=2E I don't see it in=
 there:
>https://lore=2Ekernel=2Eorg/lkml/20260313151434=2E1695228-1-acme@kernel=
=2Eorg/
>Could we get it in?
>

Sure, I'll process it for the next PR, thanks for pointing it to me, I'll =
test it later,=20

- Arnaldo


>Thanks,
>Ian
>
>
>
>> - Arnaldo
>>
>> > bash-5=2E3#
>> >
>> > Same happens on my s390 systems (LPAR and z/VM)=2E
>> > Is this a known already?
>> > I guess this is a perf tool issue, same result when you execute this =
on a 7=2E0=2E0rc3
>> > kernel=2E
>> >
>> > Any ideas where to start debugging
>> > --
>> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Ge=
rmany
>> > --
>> > IBM Deutschland Research & Development GmbH
>> >
>> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>> >
>> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
>> >
>> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht =
Stuttgart, HRB 243294
>> >

- Arnaldo 
