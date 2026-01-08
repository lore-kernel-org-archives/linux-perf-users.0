Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4032EC0A3
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895444; cv=pass; b=SybhBlOe8jeQAv5dhULH22AbiLgLCos39javslrzzHFpjNjCnHHY4YulXZL6fgPAmCGAQxMRhxwlS62Hfrcy+uE4jlTcF48+KKYfYfLP7B9MPrnpNXwcghXYwAHeIral8WLFA2Reg40EPMvZFkmYf+NPLwrkQtdZqrFuPxD+b+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895444; c=relaxed/simple;
	bh=VZ2DjiQsZGuUb/ZcBUBBrG+r3ZRoipQdQv++S/T0Ikc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8zztV8fB7j1IHKUTEuxywACEL4y6ZNSN5er+pZBG4kdIJkEuHRIOTtpIo/Zi5a4DrJmd3jKZxF8K9NQHazOiDIYvfFQbxWcKvDZQzYzGIhcc0sNRioNsyLwYesd7kBExUFWHlgSeVdOEbAEc3VXaxMUZW1eThZ1TwDckqRfUWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofKH3H+Z; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofKH3H+Z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a1462573caso6125ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 10:04:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767895442; cv=none;
        d=google.com; s=arc-20240605;
        b=eyo8JHkCYBkNMjp7jYaF1n/Lj9UbG8+OvmDVJRVS1XdA01sBWQTm+Y/oTnKB9SlznN
         4xTRmIZW9eyiElVNVk+QXpInnbnFf293sFfb3EHVz7lu3BjomVJbffD8+lkVq5sZY2aF
         9deaj7ex7qKm9rny+cSU5wpjVeuxk6VWbxnVj8p3OsBy9GqvochSfg55szE/dAXoh6fF
         6+ogvRh69KVQAVEYhBLKiYc0HCG6IRn4tMBouKMsdY90oK+1/jgQeUFRCpIgFGvNE/xe
         ZxZQFlYMQ28dTHumzgRXhHkaJa9HFktarSu59oNAcQOaI8RF04Ug57CS9KnYDLvKvVCT
         TuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xB2hmbes5dQGHgTZxw13vcsiDHM35738AWE1OHV2fUU=;
        fh=fuDTxRP9ooNs7Nb5gavLPG6UfgCt5U6PbvDO/2+4yso=;
        b=HDyLyJbtZpKZzbdxZWdIVhs01RvZtmn9eA0OMcCeeqbEY7lgaqUoN7YnJJIK8rCXzV
         kXTWFqneT0TOgaaI21l6tQgZbWpymd36NZei4yinZvEM/A7m8M9Nad4dIlyvyqFRnnW8
         uzb2fI0ca8L7vsAQWwdamqx8yCQ505FcHq6NnBQMLep0ZnLMKMPmfv9pZiphcZ87iZ+7
         HvJOrePI2N/joVfitMuL0Bi/C7bO8/Ok8NZwgIHok9ouBenGTjendBAIM0RfJnWvQ5/p
         +cpeYDGQWIDPeI1gDcc9LtRiOyjVPx0gwP3Zq+A3t+vvmxUJQN9ayQjHurMJ4FPfkJWz
         G1IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767895442; x=1768500242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB2hmbes5dQGHgTZxw13vcsiDHM35738AWE1OHV2fUU=;
        b=ofKH3H+ZNMX/WA+j2xtFRltaemwK25CTpLOyBQ5aENt1+WF+KCSx80yb47hKL3Yjdx
         oXnwgKC0koz7gAgOS49RHB4Y0JD3ziZPevRRTN+TZKE+FmPgd+WBlkFb0DZbcGrKdt14
         6dLQICDyY8W/8NHMaJhFtrtk/s8JwD0PRrMYykh9plm93jQiYPGbxeuG49eyI9vlSDG8
         lxe3jl0iBQ6auNT//YV7ePXkaeBwPh3CgXgjaN0j0pkHuc8yqo1pjFRJDCvkbBTBwe7l
         B+E1h3vD8xqb4QlamORvff6AWclAQCeqb8ItN6byWiF7Vb3gjsMxXEr8NlSTojCF0QF2
         7YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895442; x=1768500242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xB2hmbes5dQGHgTZxw13vcsiDHM35738AWE1OHV2fUU=;
        b=vPfJzrdY7xWRuzdn+dTffKn/BX1QgcKo2EM7lm22T58MFuF4+ffY8X1Y5KMv2/hqaS
         G629Yus4hSQf9+yy0ZGXW/Aamz8AK32Xn1M1NVsbIp9cltKxr0QzMs1i888l9Du1mS/G
         VMLUxl2MueF8N789ekIaD0tRNxomTLU9JA4c/yN7KceE3k8sEhnhXZ2h7lle3Qzga0p0
         nc/etwGXBJ56mmu6W6TocuLUWWl63LpiBihI09NJdyMmSaRKBIscBICsEinanBPGjcz9
         lmpYRoobj5QQQdlCkXbhGfhPkZDgDw+AY2hfcQhHuTmCg+5DRkQeK1G0Kcs0NrMKo5tJ
         n5IA==
X-Forwarded-Encrypted: i=1; AJvYcCXvyrDZvJkXueuu9w3mmdI01ds1UW2Sr0QuuJcDiAPFjhgxJeJvXQJBpO0NQqNBUJFqhA0mxX1vIodFlQ+bSgLZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6skx92jXz8vPJJ3OYI5ibnrcHiTqVbcWtbC/i8Y+m/H4f7Mp
	ARhgvC1oN84H7bdZKMu571iFCCVqHSSuAQMWFM9jCXpKjqKVZ8Do9JPGV6AKiKTTPIeeWYdpYS0
	CJh6DBIECUihyljHO6v0K4qqu0dtgxL30WiBkbmLR
X-Gm-Gg: AY/fxX7QQPMEph1+rKvyHjd3dJHbcgoUq/s0oecIBJGCvsI+F61VZmKtl0DBZPZ3Yvj
	9R+PazfOizwB9yEmXqHAMWsDNY+oMWnuJDJMF3V54rkzwRSETBod1YL/GXQooTUMOmJgjR7hSRw
	/WGp9z/WpCS143QIB3KvX9GVPOF4zpyfXwQSzW9APkOYNQX7Yaq9XokgtT5FhFEJPRtZ3S0rAEZ
	WCpvoDZVqwjLunu0JbAz94k8QZQdYsI/wWjmeAGV9LKBv7UbWRJAkALvZzqzU5O1/FaBYSC8u1G
	XV5D3ZuFOTK/WbuSFLwoF0Rqh5nwdmA+ibI=
X-Received: by 2002:a17:903:1666:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-2a409b56f30mr175475ad.15.1767895441406; Thu, 08 Jan 2026
 10:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107133216.2070400-1-tmricht@linux.ibm.com> <eca46457-0e1a-43b8-b6ac-bd61a7a273f1@linaro.org>
In-Reply-To: <eca46457-0e1a-43b8-b6ac-bd61a7a273f1@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 10:03:49 -0800
X-Gm-Features: AQt7F2oJUhjubWBuwt_7LuW7SItCz3ByEUNTTrbbNopPlLHSpC1d6luidvPPvUM
Message-ID: <CAP-5=fUrqq5fH9DRtXM0KvYhG5LWzWMf0E4r+62=kAQgbzDHAA@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Fix test perf stat tests for virtualized machines
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:30=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 07/01/2026 1:32 pm, Thomas Richter wrote:
> > V1 --> V2: Add correct Fixes: tag, suggested by James Clark
> >
> > On s390 perf test 'perf stat tests', subtest test_hybrid fails
> > for z/VM systems.
> > The root cause is this statement:
> >
> >    $(perf stat -a -- sleep 0.1 2>&1 |\
> >                    grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)
> >
> > The perf stat output on a s390 z/VM system is
> >
> >   # perf stat -a -- sleep 0.1 2>&1
> >   Performance counter stats for 'system wide':
> >
> >         56      context-switches  #     46.3 cs/sec  cs_per_second
> >   1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
> >         12      cpu-migrations    #      9.9 migrations/sec ...
> >         81      page-faults       #     66.9 faults/sec ...
> >
> >         0.100891009 seconds time elapsed
> >
> > The grep command does not match any single line and exits with error
> > code 1. As the bash script is executed with set -e, it aborts with the
> > first error code being non-zero.
> >
> > Fix this and use wc -l to count matching lines instead of grep ... -c.
> >
> > Output before:
> >   # perf test 102
> >   102: perf stat tests                      : FAILED!
> >   #
> > Output after:
> >   # perf test 102
> >   102: perf stat tests                      : Ok
> >   #
> >
> > Fixes: bb6e7cb11d97c ("perf tools: Add fallback for exclude_guest")
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> >   tools/perf/tests/shell/stat.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > index 0b2f0f88ca16..792a0b79f6b8 100755
> > --- a/tools/perf/tests/shell/stat.sh
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -233,7 +233,7 @@ test_hybrid() {
> >     fi
> >
> >     # Run default Perf stat
> > -  cycles_events=3D$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cyc=
les/[uH]*|  cpu-cycles[:uH]*  " -c)
> > +  cycles_events=3D$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cyc=
les/[uH]*|  cpu-cycles[:uH]*  "  | wc -l)
> >
> >     # The expectation is that default output will have a cycles events =
on each
> >     # hybrid PMU. In situations with no cycles PMU events, like virtual=
ized, this
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
