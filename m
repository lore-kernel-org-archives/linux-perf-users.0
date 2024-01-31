Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44136E
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662738; cv=none; b=AI0Ob6GKdT10y3wf6O45HRnAKpewb7fw/Eyu11OeoNoi5t0Y4H1SDgvVzHjM9WNOaUi4KplbpnNBUWVuZnYY7+n/npo/JmALQ/gymHQ3sUZgfndANeYlsolk0RkY7gIlPuZ2yi/5ZkdLdal9omDbsdfIYL24gdZFw38KagCw1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662738; c=relaxed/simple;
	bh=jukf1qJEiaQpCr2oJgpuHgIktzRCOEL/zjYLzWJ+SwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqc67h0dX6l4HXKurVizntlFfyylx1pxOgLnOYleO9Q3nuwcvML5EOkvJSS+cMdGIcyXRQSAPEGOOYPuZox3y9aCq80FVOHc4IzPzsCxrqsn7Gden8R7KCUvtLjOy0AEVw0seud/tBfZs4rBjJPVl06/2Sb5ATtUqoKTO3v+1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aaBJeo3q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaBJeo3q"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8d08f9454so43185ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 16:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706662736; x=1707267536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBK5SqU1TpYjbkcqIZDOGnRteHGzHhaOnkrNvuaK/2E=;
        b=aaBJeo3q9WMScJghDL48nXjPUBUROFtMM+OXEEq/TnC1mqqrc4KSPjRMEjiDAJfodK
         YasRP39in+bSmQyjdIuRv3wiRG5IsvUx0SCduoPw/N9n0RGJlRS4GlKJfWlo8F58sEsX
         Q3oVtrL2akGJaFWhSsC685toH5f5Me+NE5vf6zWlGmBUccivvTBIXlFHhvHmBxCB0zX7
         ubzwnEEcL/rttjjY335skbF9Pjl+wfl7XLzp07biOL4ns3CVdX0tmZwWVVOcqXbxfsn4
         d+x0klhWg8XzLRZ8pi+zl5fqDVLefxSHCn4THhWJQXkzZkFb6wvYGwwsHr0HJfYmxVyu
         1Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662736; x=1707267536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBK5SqU1TpYjbkcqIZDOGnRteHGzHhaOnkrNvuaK/2E=;
        b=cyT18XFX+T1wB549TDrzpCTBFe3XyGUsU6zkFgLk8TdMuRuBIbQkgPN0+A912mmXHj
         UF/6Fog9xk3rYb+BO709S/c7q1ll47Hqhg4WFWPlj9FFreednORE9p4KyHpvGGj4Vdx9
         1TUu5eM2ziKdvLSHlaTP86pMxmWUJIfLPUFlBm6ztKkNjrERB/Ybh8mwFXs2br6nBPlp
         xiLJ1ksJhBIi8nVMCUqJ15sX2z5XWPn7DHPpSJN/SfLyhAye3ds1zkKQMiAZraEr/lwt
         dxXCnIlRBaz9H1kaoruY3AO04FLsV0qrp0miVrNHtigd47HmHmRJQztHa9R8RcrOQxkV
         j7qA==
X-Gm-Message-State: AOJu0Yzh5vgimtb9gZu9ZO2ykvEDSIqUAqVjII28mdZKng+f+aH/NMzV
	REPYMxXOBi7tBTr26LAi6hpEZ2McIv8x62DjrIjZyLuT8XedMDWRK2tHDCx/H/FBGA4qpnIhuhR
	P60+Y8bcZcUUNqFBKu7mTxLjgS5JKwGr7C2Md
X-Google-Smtp-Source: AGHT+IHQtez9ISc25L7y5s1XKhZxoc4EBvanOIxPtEFKElYLXy0LZmiyvc1/LJyifO+b7QahA3tbPMDrWOclS03NqiQ=
X-Received: by 2002:a17:902:e5c8:b0:1d8:da36:d0ae with SMTP id
 u8-20020a170902e5c800b001d8da36d0aemr371032plf.3.1706662735801; Tue, 30 Jan
 2024 16:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com>
In-Reply-To: <CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jan 2024 16:58:43 -0800
Message-ID: <CAP-5=fW9M3U2U5UXd3QfTjMe=kSe=x1_GC3DW3Mg7HTyHy1atg@mail.gmail.com>
Subject: Re: [Intel Alderlake CPUID issue]
To: Tingrun Chen <tchen168@asu.edu>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <rogers.email@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 4:35=E2=80=AFPM Tingrun Chen <tchen168@asu.edu> wro=
te:
>
> `perf test 7` fail on Alderlake virtual machine, The test is failing
> as #system_tsc_freq has a zero value.Below is the output of `./perf
> test 7 -vv`:
> ```
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> BPF maps, etc
>   7: Simple expression parser                                        :
> --- start ---
> test child forked, pid 82095
> Using CPUID GenuineIntel-6-BA-2
> parsing metric: 1+1
> parsing metric: FOO+BAR
> lookup(FOO): val 1.000000
> lookup(BAR): val 2.000000
> parsing metric: (BAR/2)%2
> lookup(BAR): val 2.000000
> parsing metric: 1 - -4
> parsing metric: (FOO-1)*2 + (BAR/2)%2 - -4
> lookup(FOO): val 1.000000
> lookup(BAR): val 2.000000
> parsing metric: 1-1 | 1
> parsing metric: 1-1 & 1
> parsing metric: min(1,2) + 1
> parsing metric: max(1,2) + 1
> parsing metric: 1+1 if 3*4 else 0
> parsing metric: 100 if 1 else 200 if 1 else 300
> parsing metric: 100 if 0 else 200 if 1 else 300
> parsing metric: 100 if 1 else 200 if 0 else 300
> parsing metric: 100 if 0 else 200 if 0 else 300
> parsing metric: 1.1 + 2.1
> parsing metric: .1 + 2.
> parsing metric: d_ratio(1, 2)
> parsing metric: d_ratio(2.5, 0)
> parsing metric: 1.1 < 2.2
> parsing metric: 2.2 > 1.1
> parsing metric: 1.1 < 1.1
> parsing metric: 2.2 > 2.2
> parsing metric: 2.2 < 1.1
> parsing metric: 1.1 > 2.2
> parsing metric: 1.1e10 < 1.1e100
> parsing metric: 1.1e2 > 1.1e-2
> parsing metric: FOO/0
> lookup(FOO): val 1.000000
> division by zero
> parsing metric: BAR/
> lookup(BAR): val 2.000000
> syntax error
> parsing metric: FOO + BAR + BAZ + BOZO
> parsing metric: EVENT1\,param\=3D?@ + EVENT2\,param\=3D?@
> parsing metric: dash\-event1 - dash\-event2
> parsing metric: EVENT1 if #smt_on else EVENT2
> literal: #smt_on =3D 0.000000
> parsing metric: EVENT1 if #core_wide else EVENT2
> literal: #core_wide =3D 0.000000
> parsing metric: 1.0 if EVENT1 > 100.0 else 1.0
> parsing metric: 0 & EVENT1 > 0
> parsing metric: EVENT1 > 0 & 0
> parsing metric: 1 & EVENT1 > 0
> parsing metric: EVENT1 > 0 & 1
> parsing metric: 1 | EVENT1 > 0
> parsing metric: EVENT1 > 0 | 1
> parsing metric: 0 | EVENT1 > 0
> parsing metric: EVENT1 > 0 | 0
> parsing metric: #num_cpus_online
> literal: #num_cpus_online =3D 8.000000
> parsing metric: #num_cpus
> literal: #num_cpus =3D 8.000000
> parsing metric: #num_cores
> literal: #num_cores =3D 8.000000
> parsing metric: #num_dies
> literal: #num_dies =3D 1.000000
> parsing metric: #num_packages
> literal: #num_packages =3D 1.000000
> parsing metric: #system_tsc_freq
> Failed to find TSC frequency in /proc/cpuinfoliteral: #system_tsc_freq
> =3D 0.000000
> FAILED tests/expr.c:249 #system_tsc_freq > 0
> test child finished with -1
> ---- end ----
> Simple expression parser: FAILED!
> ```
> The test can pass in my AlderLakephysical machine. So, in my physical
> machine it seems that in the `arch_get_tsc_freq`
> (https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git=
/tree/tools/perf/arch/x86/util/tsc.c?h=3Dperf-tools-next)
> function, the call to `get_cpuid_0` will read a valid value for lvl,
> then it will calculate the tsc using the information directly from the
> intel instruction `cpuid`; however, in the virtual machine, the lvl
> will be less than 0x15, then it will fall back to read `/proc/cpuinfo`
> and it does not contain something like `@ 3.0GHz`. Interestingly, the
> `model name` entry of `/proc/cpuinfo` in both my physical machine and
> the virtual machine does not contain the frequency information like `@
> 3.0GHz`.

+Kan Liang

Thanks Tingrun,

IIRC the "@ 3.0GHz" parsing approach was for older machines that
lacked the information in the cpuid. Could there be anything special
in your virtual machine set up that will cause the cpuid to look older
than it is? Kan, any thoughts and can we work around this?

Thanks,
Ian
