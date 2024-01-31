Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C6129A9C
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716187; cv=none; b=AofKdib93+ZVd9p3s4sziIpSGPCzJkkcVjVK5mK6yQ9iBxYipybmAj5as37mYr11n2tFNc616uA2/NSuRbtNwYRc1yVYQXvu7D8RtegCXJHjuJKLQUSLeQuEzhlJK7ZIddbhZQioTVkBGJwt8B/bCKXWCvp88C+Eop6aSBF/VG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716187; c=relaxed/simple;
	bh=vhBkkdsRedQWP+s9NDH1BnmxytKNmUgdpLK59r9a5VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vED07i5oWMwcnH0UkJjBCU9PoTrCZP/nuqfHsNpV6mUySRS5BH1gw+vake/CCHOGJ1Wh8o5gUT3POaB0VWMjH87TS8lQH2D/RrTEuxmIJ8JpOpYe06GNgKO8VPog9+MmR3vAbbJ4/1hDeofy9eeObBIcx+vPbnOqsphDkSHrMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDs40NMh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDs40NMh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d8d08f9454so150515ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706716185; x=1707320985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72Bwqf1WE0j95sBgDKZWQ6T7Bpltd02E1f/OStTK1qY=;
        b=qDs40NMhbgE6URVRWTSJ/NIt7hUx3WoenIyuc7Oq9CuaWsfyIq4QS7yCjQTixoA4+M
         jttSUyiABfg1+eN9Ia5ljjOo9W0TT++653pwzevButmOc6Qq6aGgNb7L5uuFJeeEo9iz
         7Ukq+1AfDRrhxvqHmmmqJeV6QWsPX+1yYazbP67iYLGuxtn20U6djG8NH7ZRFSbVoeLv
         AlrPE0eG/FD05KUHDLfFscXhLmRcILi6iUw6e3KRLFf11Jmc3Z/eJWL2F9zn4GvydGrz
         QAo1C+wgLMOdcb4ctvk7RP1X8qCvjnMsIyxOaKW2gkDlN07dcdenWjxU1zkCC/Jz+JPz
         tkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716185; x=1707320985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72Bwqf1WE0j95sBgDKZWQ6T7Bpltd02E1f/OStTK1qY=;
        b=KONBTz9LTR/bqw3cnD1OhvNADwQApDhTtyP9PkDUxjtxNJgwPaj9oAj2wQ/LCyojli
         SCSc7Ga5YZjBTFEzhyipwWBOsuic9bSnBddZ2jmriJmt/47jTiGSQDRPgPO5fZpc0NYx
         T3EgdlnaY1lybCCl64FEg371KfCwLerSw8D0nMXBZZha43iGqdP7ppU1Z6wZ+kKGSlKh
         KCBhmI7PL6ijO1uqPLkidtgzl9gRXZzxCZWcNgk+71hZmtFkOuXEqJM3JZK0Fpgimjjd
         yD+P5I1bvNj59zTxA0vD2pZhTbRViUTxemVTcVNefMmE1Etma8tciUaL6oxtWOcBwv6s
         vQag==
X-Gm-Message-State: AOJu0YzS7vrFbfRynmvfP3tsI69EW26Wmhm0atDAmv6mBbY7USVbpMMF
	eaPlwit+YoHqvlLGJ2DOMLKWjWRKX69nkU4knXb05TaGcJ3QKGHDlj6BfXzVhEkcGHKHLj74WWe
	ORNNoU0hztL0sHAqbIxBxhxTTiKwGFZfssL5mEu4NSmylSAOmXbvy
X-Google-Smtp-Source: AGHT+IGSszvSz1DRX8r2DHuxQ9zIies/XQsBBhDOIhHUBwWkW78kA8ErgvtRK396QdKhDjwJck79iGD0y08gSta0yvE=
X-Received: by 2002:a17:903:40c2:b0:1d8:cc13:f82e with SMTP id
 t2-20020a17090340c200b001d8cc13f82emr577178pld.4.1706716184920; Wed, 31 Jan
 2024 07:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com>
 <CAP-5=fW9M3U2U5UXd3QfTjMe=kSe=x1_GC3DW3Mg7HTyHy1atg@mail.gmail.com> <285ee22e-7908-4486-95eb-474b30b7cc8b@linux.intel.com>
In-Reply-To: <285ee22e-7908-4486-95eb-474b30b7cc8b@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jan 2024 07:49:33 -0800
Message-ID: <CAP-5=fXcXLoCxk6WZvjQsv5xEKA3+5KFc9Yh--R_wBQ+UVa++w@mail.gmail.com>
Subject: Re: [Intel Alderlake CPUID issue]
To: "Liang, Kan" <kan.liang@linux.intel.com>, "Wang, Weilin" <weilin.wang@intel.com>
Cc: Tingrun Chen <tchen168@asu.edu>, Kan Liang <kan.liang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:01=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-01-30 7:58 p.m., Ian Rogers wrote:
> > On Tue, Jan 30, 2024 at 4:35=E2=80=AFPM Tingrun Chen <tchen168@asu.edu>=
 wrote:
> >>
> >> `perf test 7` fail on Alderlake virtual machine, The test is failing
> >> as #system_tsc_freq has a zero value.Below is the output of `./perf
> >> test 7 -vv`:
> >> ```
> >> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> >> BPF maps, etc
> >>   7: Simple expression parser                                        :
> >> --- start ---
> >> test child forked, pid 82095
> >> Using CPUID GenuineIntel-6-BA-2
> >> parsing metric: 1+1
> >> parsing metric: FOO+BAR
> >> lookup(FOO): val 1.000000
> >> lookup(BAR): val 2.000000
> >> parsing metric: (BAR/2)%2
> >> lookup(BAR): val 2.000000
> >> parsing metric: 1 - -4
> >> parsing metric: (FOO-1)*2 + (BAR/2)%2 - -4
> >> lookup(FOO): val 1.000000
> >> lookup(BAR): val 2.000000
> >> parsing metric: 1-1 | 1
> >> parsing metric: 1-1 & 1
> >> parsing metric: min(1,2) + 1
> >> parsing metric: max(1,2) + 1
> >> parsing metric: 1+1 if 3*4 else 0
> >> parsing metric: 100 if 1 else 200 if 1 else 300
> >> parsing metric: 100 if 0 else 200 if 1 else 300
> >> parsing metric: 100 if 1 else 200 if 0 else 300
> >> parsing metric: 100 if 0 else 200 if 0 else 300
> >> parsing metric: 1.1 + 2.1
> >> parsing metric: .1 + 2.
> >> parsing metric: d_ratio(1, 2)
> >> parsing metric: d_ratio(2.5, 0)
> >> parsing metric: 1.1 < 2.2
> >> parsing metric: 2.2 > 1.1
> >> parsing metric: 1.1 < 1.1
> >> parsing metric: 2.2 > 2.2
> >> parsing metric: 2.2 < 1.1
> >> parsing metric: 1.1 > 2.2
> >> parsing metric: 1.1e10 < 1.1e100
> >> parsing metric: 1.1e2 > 1.1e-2
> >> parsing metric: FOO/0
> >> lookup(FOO): val 1.000000
> >> division by zero
> >> parsing metric: BAR/
> >> lookup(BAR): val 2.000000
> >> syntax error
> >> parsing metric: FOO + BAR + BAZ + BOZO
> >> parsing metric: EVENT1\,param\=3D?@ + EVENT2\,param\=3D?@
> >> parsing metric: dash\-event1 - dash\-event2
> >> parsing metric: EVENT1 if #smt_on else EVENT2
> >> literal: #smt_on =3D 0.000000
> >> parsing metric: EVENT1 if #core_wide else EVENT2
> >> literal: #core_wide =3D 0.000000
> >> parsing metric: 1.0 if EVENT1 > 100.0 else 1.0
> >> parsing metric: 0 & EVENT1 > 0
> >> parsing metric: EVENT1 > 0 & 0
> >> parsing metric: 1 & EVENT1 > 0
> >> parsing metric: EVENT1 > 0 & 1
> >> parsing metric: 1 | EVENT1 > 0
> >> parsing metric: EVENT1 > 0 | 1
> >> parsing metric: 0 | EVENT1 > 0
> >> parsing metric: EVENT1 > 0 | 0
> >> parsing metric: #num_cpus_online
> >> literal: #num_cpus_online =3D 8.000000
> >> parsing metric: #num_cpus
> >> literal: #num_cpus =3D 8.000000
> >> parsing metric: #num_cores
> >> literal: #num_cores =3D 8.000000
> >> parsing metric: #num_dies
> >> literal: #num_dies =3D 1.000000
> >> parsing metric: #num_packages
> >> literal: #num_packages =3D 1.000000
> >> parsing metric: #system_tsc_freq
> >> Failed to find TSC frequency in /proc/cpuinfoliteral: #system_tsc_freq
> >> =3D 0.000000
> >> FAILED tests/expr.c:249 #system_tsc_freq > 0
> >> test child finished with -1
> >> ---- end ----
> >> Simple expression parser: FAILED!
> >> ```
> >> The test can pass in my AlderLakephysical machine. So, in my physical
> >> machine it seems that in the `arch_get_tsc_freq`
> >> (https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/arch/x86/util/tsc.c?h=3Dperf-tools-next)
> >> function, the call to `get_cpuid_0` will read a valid value for lvl,
> >> then it will calculate the tsc using the information directly from the
> >> intel instruction `cpuid`; however, in the virtual machine, the lvl
> >> will be less than 0x15, then it will fall back to read `/proc/cpuinfo`
> >> and it does not contain something like `@ 3.0GHz`. Interestingly, the
> >> `model name` entry of `/proc/cpuinfo` in both my physical machine and
> >> the virtual machine does not contain the frequency information like `@
> >> 3.0GHz`.
> >
> > +Kan Liang
> >
> > Thanks Tingrun,
> >
> > IIRC the "@ 3.0GHz" parsing approach was for older machines that
> > lacked the information in the cpuid. Could there be anything special
> > in your virtual machine set up that will cause the cpuid to look older
> > than it is? Kan, any thoughts and can we work around this?
> >
>
> I don't have other way to get an accurate frequency.
>
> Do you think it is worth introducing a way (e.g. terms) to let the end
> user provide such information?
> For this case, the freq information is not available.
> In Weilin's TPEBS support, I think she is also looking for a way to set
> the period.

+Wang, Weilin

I think a term for an event or metric would be a bit unnatural, this
feels like a command line and/or config setting thing. I can draft a
patch.

Thanks,
Ian

> Thanks,
> Kan
