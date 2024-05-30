Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF823741;
	Thu, 30 May 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087456; cv=none; b=QkD2Gy+lnCvyUl25USI/kk2l6+FpUdMymr+CfjhdIRo9mAAbuDToro85I7K4GoC+rE+t1B3N4ma9SRWNYG+cscNu7XPHvqiteJc4LdJlYKt7eku10Q4ikT7pHhHD6XYGJfmA9xxyBwV5QEXzpNkHyMPE/tbFOTh453GAP3+jR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087456; c=relaxed/simple;
	bh=DErZGw60vY5VVok3vqsO3s4NbZA0aegd2r/sMDdVj8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3/iUga0Qrzzw0kvRUz5me6MWw+CC88aTKoRfp2wUmb4S5mzXt2c+pFS95a3IEIyiptOFZbkPFulCREA8/HgFSeMTuHrt+BINIQYgnsLBj6i4Ght2RvjrVXQI27D/tsfetbsN3SOkwESC8DGGM6NC3HWlCjzKE1BuHPvEDAkaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bf59b781d6so908976a91.0;
        Thu, 30 May 2024 09:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087454; x=1717692254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZDMlH3wwmcKVtEagfPCH0RxE62sWqc/UQQgjvFYOqg=;
        b=L7yAeD49JSEGcItP8/52NQxa+YFZdSGQHOyVfUqNN5KX2+dBk6mbZwcCWlOeBTrn4p
         868uzoPfQa21RKto8XOcSISash1a2/kQvZxz+BbVrU2wy8K+EnJcmn3SvxqGQYK223hT
         r2q613EeBkQfDZrE0jT7I/Blv+vImx3Wi8x9j3UQUXIhlzaktnenuUHUfMV8+FDx9wlS
         32yFaSTcG5LQIsCX9sA04gTLTdUsBAeqosV65PtsP/pnvrHBSHtxpcCU0ACJqNxd1700
         iE5WvLHfzlMQVmfC+O6+ZACYS/4HuCxLgxIdKJa5RyGJ09GkdI2EwMWdvFgY6CP0PajG
         QRQg==
X-Forwarded-Encrypted: i=1; AJvYcCWoTD4R5/A0O0yL0InuLWfzfNBPG8KTJwfR+apjxFw2Tfzl4bhaj1n0BsKncxQNzpUg1gUolCGRPR72K0h70uhG0AP7wxAZK9/r/fVN1E+csJVyRP2G1C3OM7c2C8ALV6jj4YD7ZLABVSUV77V1pA==
X-Gm-Message-State: AOJu0Yxbl3cyKmQHrINRtxZdSA5+m1HSnc1IsLwaNe/24sLB5X4CgzUu
	z9EXa9o4PoF7q/ezmahuQmtZHT4WPk7TFf38pk5dydA/6yjwpPvAbzlFYqDgFNLjVO4FV5oAcfb
	M1Z696JJJy0jASKWXbWGu8KeRUvD72Pa1
X-Google-Smtp-Source: AGHT+IEV6Z1GyPQC65et0ns8EenUP8n/Nn7bmvhurfzmdkcm8aYVGTKtHm8BBAO+hJCrQFmwVLAua91DtAutkmN9fTc=
X-Received: by 2002:a17:90a:b884:b0:2b3:28df:96b1 with SMTP id
 98e67ed59e1d1-2c1ab9ddda7mr2613497a91.7.1717087453788; Thu, 30 May 2024
 09:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519181716.4088459-1-irogers@google.com> <CAM9d7chxsyZ+vnPXj0gc-mbADzwzQYi3qUwUohW-7He5KwMvHg@mail.gmail.com>
 <CAP-5=fXME3cjNK-P9qk+kY0dA1Xkwvz6Su=99nY7CgcKrQTb2w@mail.gmail.com>
In-Reply-To: <CAP-5=fXME3cjNK-P9qk+kY0dA1Xkwvz6Su=99nY7CgcKrQTb2w@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 May 2024 09:44:02 -0700
Message-ID: <CAM9d7ch7GidVscUxQh+CZRuo1U1KiDiFiuOZN3FnqbrPDbaVNw@mail.gmail.com>
Subject: Re: [PATCH v1] tools api io: Move filling the io buffer to its own function
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:47=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, May 23, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Sun, May 19, 2024 at 11:17=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > In general a read fills 4kb so filling the buffer is a 1 in 4096
> > > operation, move it out of the io__get_char function to avoid some
> > > checking overhead and to better hint the function is good to inline.
> > >
> > > For perf's IO intensive internal (non-rigorous) benchmarks there's a
> > > near 8% improvement to kallsyms-parsing with a default build.
> >
> > Oh, is it just from removing the io->eof check?  Otherwise I don't
> > see any difference.
>
> I was hoping that by moving the code out-of-line then the hot part of
> the function could be inlined into things like reading the hex
> character. I didn't see that, presumably there are too many callers
> and so that made the inliner think sharing would be best even though
> the hot code is a compare, pointer dereference and an increment. I
> tried forcing inlining but it didn't seem to win over just having the
> code out-of-line. The eof check should be very well predicted. The
> out-of-line code was branched over forward, which should be 1
> mispredict but again not a huge deal. I didn't do a more thorough
> analysis as I still prefer to have the cold code out-of-line.

Ok, I don't see much difference with this change.  But the change itself
looks fine.

Thanks,
Namhyung


Before:

# Running internals/synthesize benchmark...
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 237.274 usec (+- 0.066 usec)
  Average num. events: 24.000 (+- 0.000)
  Average time per event 9.886 usec
  Average data synthesis took: 241.126 usec (+- 0.087 usec)
  Average num. events: 128.000 (+- 0.000)
  Average time per event 1.884 usec

# Running internals/kallsyms-parse benchmark...
  Average kallsyms__parse took: 184.374 ms (+- 0.022 ms)

# Running internals/inject-build-id benchmark...
  Average build-id injection took: 20.096 msec (+- 0.115 msec)
  Average time per event: 1.970 usec (+- 0.011 usec)
  Average memory usage: 11574 KB (+- 29 KB)
  Average build-id-all injection took: 13.477 msec (+- 0.100 msec)
  Average time per event: 1.321 usec (+- 0.010 usec)
  Average memory usage: 11160 KB (+- 0 KB)

# Running internals/evlist-open-close benchmark...
  Number of cpus:    64
  Number of threads:    1
  Number of events:    1 (64 fds)
  Number of iterations:    100
evlist__open: Permission denied

# Running internals/pmu-scan benchmark...
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 135.880 usec (+- 0.249 usec)
  Average PMU scanning took: 816.745 usec (+- 48.293 usec)


After:

# Running internals/synthesize benchmark...
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 235.711 usec (+- 0.067 usec)
  Average num. events: 24.000 (+- 0.000)
  Average time per event 9.821 usec
  Average data synthesis took: 240.992 usec (+- 0.058 usec)
  Average num. events: 128.000 (+- 0.000)
  Average time per event 1.883 usec

# Running internals/kallsyms-parse benchmark...
  Average kallsyms__parse took: 179.664 ms (+- 0.043 ms)

# Running internals/inject-build-id benchmark...
  Average build-id injection took: 19.901 msec (+- 0.117 msec)
  Average time per event: 1.951 usec (+- 0.011 usec)
  Average memory usage: 12163 KB (+- 10 KB)
  Average build-id-all injection took: 13.627 msec (+- 0.086 msec)
  Average time per event: 1.336 usec (+- 0.008 usec)
  Average memory usage: 11160 KB (+- 0 KB)

# Running internals/evlist-open-close benchmark...
  Number of cpus:    64
  Number of threads:    1
  Number of events:    1 (64 fds)
  Number of iterations:    100
evlist__open: Permission denied

# Running internals/pmu-scan benchmark...
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 136.540 usec (+- 0.294 usec)
  Average PMU scanning took: 819.415 usec (+- 48.437 usec)
