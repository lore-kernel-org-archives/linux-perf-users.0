Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DC1C3C1D
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426373; cv=none; b=qYv33SU1mjAZrpbL4lHV/vsWbbZllEWGnKCwEZMy6xzrlAGQQ1q50gCItd5kSoFutrW7hpV2wg0xkQMuG6G4fbyczLwiTtpSsbFNf7kzloKODEKszXGOO485b++q0hIcEnZ3Gz8y0DjBTU6hgb/Ilxb/CaW2aAipYpJb4zhKppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426373; c=relaxed/simple;
	bh=pWDy+G/FLFskjOChqfF5xxOtF+kpej0KMJdyHy1d2pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2nwsMNqOlp4f/ZVZeHUQ/Zl5h5PgVt0Gu51hE6uXrd0CsEcJRsPnZqEFLHRcLcQ2uRXhgeZhRw7gp93a8Pz8ItFgX887LbshgbFBMUkuONdjnAdTF/W0fRuOvoz6o2Ma10O02cW24m5pTJ+dMofCCqAAOw0EcD5j47VcjN2zlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPxU10qp; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPxU10qp"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so107255ab.0
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Feb 2025 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738426371; x=1739031171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQaWCOfcTD7adap/jkek4EJcOFfU4JZ7fPFMN3rMGUQ=;
        b=qPxU10qpZBTjdNJaV/n0WcNk6q6RfHgsNr9U1kcYSeHrXi7eLSLoQWWd1VIOipwoVx
         JX9fhpjZa2nm+Dwd4sL0wJZnoQUZTyzxGSSJeZ60EGwRanWEKpOxovgn4RXMXWqHBi/W
         p10H+cnf3w+B6cUSz1HzmoZ6tGSY7eoypXCZXzJa4DjaxX8+Ii7FofZkYMrMO++vtfAn
         rloHcgZA67cZuIO5DrbGp1S0bdQUx8Yz2rrl7gNwUP5aWKzw3BO2C1nOj+ys3ke3Fsl8
         xiMOODGosRZY4QSNkt5j6Jd1j7kJxhfRa5d5Eg89Y2bloLOfxLRRwf5MwBx5ujLM3Elx
         ZTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426371; x=1739031171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQaWCOfcTD7adap/jkek4EJcOFfU4JZ7fPFMN3rMGUQ=;
        b=ruzt1tAEdfIoRs9Airg8ONGUcycTHzLRSmi/Ww12Kiv755UMsWOaN67o1NkGOghGRq
         RmMwLNeQis+9nK8gqZTs4ZsOZcA7DF1XcDvcYcYWnuCykedffitGmlgxcuKDm7oYko7R
         eRLUEOdaYFBlpio2MQk0ELoHFh/58vQxk1AnoIal8Gc4TZf5y8w9kTVsf+RokpIKnupV
         +AmibjQz+0p5Z7CWcTBxxIrY+K6RIe6V6H2JeuvqqeT676fjir1wgCdEIbTx51G1Cdzm
         DRhdS01OdKA4yzSlNcq93WcnlFufV+owX9jVQAmiFs0J/hx6HhscYXKctBs2+WGwJ/1C
         2tCw==
X-Forwarded-Encrypted: i=1; AJvYcCWvQUpPORGggXy/F+ZLo9qazvCRKJQCdOPjlJrAWkmUZE9NS6N7oIBgNZlNKX4zO06u+lhlNJhU95ngKDw2T+ko@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3U8yYkS9NKj620km7zdoJ+UIwuaLHRtB9oBevDnxICx2P2Ht
	F9/aA+2Es2dpOfeyjvvgwr/fDvVdeNtiIniR7lMoecsrBkcxVDVWOHTW5zs++V0jWT5cnWlf227
	G05MD5NE/6Q5t2fJ4jzjsJMxyLmbfyc5TskTv
X-Gm-Gg: ASbGncshA8zI/q8cSNtxsSscd+Ch2xmRZgv4gKaONV6/FK0D6lXlXTuvh0ZRNJu7+U4
	C8AFZwj2WlXmQaZDlM1OKSqN58OrJ3x4cOUU0gpsSpdCkSi6p2/phzSlcG8VWOs0nmniR1zNn2w
	==
X-Google-Smtp-Source: AGHT+IF69bDr95smn4mmnZECR1b515k/xT3KInxWdsf6LEn1q52wgteTdkisoJ0CBgqKIxsr5onZsHFEdOuEee/fhVA=
X-Received: by 2002:a05:6e02:152f:b0:3ce:2f93:a02b with SMTP id
 e9e14a558f8ab-3d020178852mr2330315ab.12.1738426371027; Sat, 01 Feb 2025
 08:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131112400.568975-1-tmricht@linux.ibm.com> <20250201113406.4312a601@pumpkin>
In-Reply-To: <20250201113406.4312a601@pumpkin>
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 08:12:38 -0800
X-Gm-Features: AWEUYZlyxxB7qS1nrQjz_09CTMxeBkAZdRVUEc3B_GIHgRt9jOtoTPNp3J6x-Zg
Message-ID: <CAP-5=fUOS6ZmfVdzwNL6+5VfUr9fms0zE4FXW6vsRqSfS9F7sA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix perf test 11 hwmon endianess issue
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 3:34=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 31 Jan 2025 12:24:00 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> > perf test 11 hwmon fails on s390 with this error
> >
> >  # ./perf test -Fv 11
> >  --- start ---
> >  ---- end ----
> >  11.1: Basic parsing test             : Ok
> >  --- start ---
> >  Testing 'temp_test_hwmon_event1'
> >  Using CPUID IBM,3931,704,A01,3.7,002f
> >  temp_test_hwmon_event1 -> hwmon_a_test_hwmon_pmu/temp_test_hwmon_event=
1/
> >  FAILED tests/hwmon_pmu.c:189 Unexpected config for
> >     'temp_test_hwmon_event1', 292470092988416 !=3D 655361
> >  ---- end ----
> >  11.2: Parsing without PMU name       : FAILED!
> >  --- start ---
> >  Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
> >  FAILED tests/hwmon_pmu.c:189 Unexpected config for
> >     'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/',
> >     292470092988416 !=3D 655361
> >  ---- end ----
> >  11.3: Parsing with PMU name          : FAILED!
> >  #
> >
> > The root cause is in member test_event::config which is initialized
> > to 0xA0001 or 655361. During event parsing a long list event parsing
> > functions are called and end up with this gdb call stack:
> ...
> > However member key::type_and_num is defined as union and bit field:
> >
> >    union hwmon_pmu_event_key {
> >         long type_and_num;
> >         struct {
> >                 int num :16;
> >                 enum hwmon_type type :8;
> >         };
> >    };
>
> That is entirely horrid.

It also has the side-effect that if you initialize the struct bits in
the type_and_num will be undefined and sanitizers will try to trip you
up.

> I'm surprised this even compiles:
> static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __maybe_u=
nused)
> {
>         return ((union hwmon_pmu_event_key)key).type_and_num;
> }
> It has to be just 'return key', but I'm not sure what the hashmap code is=
 doing.
>
> AFAICT the code is just trying to generate a value for the hashmap to has=
h on?
> Why not just use (type << 16 | num) instead of 'trying to be clever' with=
 a union?

The purpose wasn't so much to be 'clever' as you say. Perf event
configs, which is where type_and_num lives in the events, have their
bitfields described either by convention or by files in
/sys/devices/<pmu>/format. On an Intel laptop:
```
$ cat /sys/devices/cpu/format/inv
config:23
```
So I can go:
```
$ perf stat -e 'inst_retired.any/inv=3D1/' true

Performance counter stats for 'true':

        1,069,756      inst_retired.any/inv=3D1/

      0.001539265 seconds time elapsed

      0.001719000 seconds user
      0.000000000 seconds sys
```
and the configuration of my inst_retired.any event now has bit 23 in
the config set. Just as the format files try to break down what the
bitfields within a config u64 are doing, the union was trying to do
similar. Making an attempt to have the value be intention revealing
which the shift and masking may lose, for example, by making it look
like bits in the num could overlap with and modify the type.

Thanks,
Ian
