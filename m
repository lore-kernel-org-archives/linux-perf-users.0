Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE6194089
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495071; cv=none; b=g3UUfr+GQ14EkPjQlwvGyAxaeUPzIGE5+JrAxm8Kr/i6Azhc15idny9ElxhWaQSCjZXKNc5ssZOxuFfZXbCVRW0dCg2ernN5legoxOceVnogmTge53FMu8dOhp07QTtruE4tDveYeHEahoFyUNQ0+U4qBycxi6tUBUCbSlRnPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495071; c=relaxed/simple;
	bh=o3pPC6oxhFHhBHNUVWgNOSTBHybiNc6Bsno294B961k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACWRJGysi8D9P0/ZIVfd2MMO6z0XpUM7i1flOXSBbdisSMrH21rVFkPBk6kUmFOGG+CrUj20erG84kwphaxaXsp120GKbCohD4lOenZGqRIFewvTZaqdibSaF4we8mNxBg9mZEpNMKXsHVdjDAysM/PUxOK8iXK2FqJIARGXzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNO7994i; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNO7994i"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4518d9fa2f4so49101cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495068; x=1724099868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhQLFGtPpa4fkDkFPqrRhGxerNFpGi2RBLTu5Q1d7Ug=;
        b=rNO7994iZxNI+hyHdPBccN9XEf/aebT7qNQcDWl4REuld3vTzSIpE3+gB59+NDdswe
         eYKqCFu/g1NPlCVQFyGGZwywRTjkJpt8ecqWqtCfewbuhFlwkNNViE10Yv57haWNHbc4
         NtDNtfW0jPPg/8+jNnmYwCEsW+2Y7E1YqoyrkCyhBUcE5NSqNS3pGIavO0oDGHnvHOv7
         KIjldYzaQ87qe73jz7A36KuOuuJBxOK/clJfKCr4HUpfVGFhBMcU8pIsrvzJHjycC7N2
         oKkkYgldStJDCO1JN5m1NU/dWOUdSHIg7ANByYojbxU3jsbrQMCwEB8/d2KJ9qWzAIbv
         u0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495068; x=1724099868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhQLFGtPpa4fkDkFPqrRhGxerNFpGi2RBLTu5Q1d7Ug=;
        b=rW7CqFiainq/V5DYoHkbg/2kBo0SSVgPU8NmniDjmHku/Btt/aJjeBwgEdy6jUSpiP
         Lg0nIlhtILkbYkVnzNV2dD0nUgEvwXHFIhBhoJ+vgXTx5RWJkveB/f1+w96QMpx2CBm1
         i0pg8TFcRCNFNJxcG1gQXXtsyBTnihDZEAr0i20xTysuFlecukANZJSkbsWVF0qwYcYx
         3hJlTA3GvYcXZ1Y8iI74tAUXEavn+JuS/DUEFimJ+x9TKz2TPqwu278EmOh/Fn7ljFku
         Yb72d0/76PIHHovBuSHKAYDFDTDzzpx4oOQk9X9cPSrWP/5PQMBt35VcvLiTS37qW4QV
         W76Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbooxVPyybRi6w8QmkdTo2wOKha0X9akg9QqFvbk9fWEAH+TodTF4aJNRzc0FPdYhRLGQMJYyrl+4Jzdi4W94crBe0mH9NUCOyOXZHOXlhPg==
X-Gm-Message-State: AOJu0YzlrcPRJ47JS1JahJsy7hWhjMPIwifCiNfFsEvM0Vw5QvY1FrQN
	DtnpAGu3idBETGLYMEGAE9QwlMo1O85/41BeioZ/K5MUK9ktarGuiRZH4GIqnYDduNOQyl0JKue
	bZRzICaoQmHP8/pmnbrgdoI248l7aOUfZa4mX
X-Google-Smtp-Source: AGHT+IE/oLvVW+JfCZbUbvDSDLApx8BS80z+MWxLz1J9Qqcs9fvtsckCTdwJpoTBuiOIwbUNk8Fqo4E9Ng20fSrH3Ak=
X-Received: by 2002:ac8:5a86:0:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-4534fa1ccf6mr7081cf.29.1723495068095; Mon, 12 Aug 2024 13:37:48
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729220620.2957754-1-irogers@google.com> <ZqqAkcz4xOto_sK5@google.com>
In-Reply-To: <ZqqAkcz4xOto_sK5@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 13:37:36 -0700
Message-ID: <CAP-5=fXN4y++hD-TzVToobrmH73V_h1fbGq+DuZxmgi=jF5NWQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf inject: Fix leader sampling inserting additional samples
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Mon, Jul 29, 2024 at 03:06:20PM -0700, Ian Rogers wrote:
> > The processing of leader samples would turn an individual sample with
> > a group of read values into multiple samples. Perf inject would pass
> > through the additional samples increasing the output data file size:
> >
> > ```
> > $ perf record -g -e "{instructions,cycles}:S" -o perf.orig.data true
> > $ perf script -D -i perf.orig.data | sed -e 's/perf.orig.data/perf.data=
/g' > orig.txt
> > $ perf inject -i perf.orig.data -o perf.new.data
> > $ perf script -D -i perf.new.data | sed -e 's/perf.new.data/perf.data/g=
' > new.txt
> > $ diff -u orig.txt new.txt
> > --- orig.txt    2024-07-29 14:29:40.606576769 -0700
> > +++ new.txt     2024-07-29 14:30:04.142737434 -0700
> > ...
> > -0xc550@perf.data [0x30]: event: 3
> > +0xc550@perf.data [0xd0]: event: 9
> > +.
> > +. ... raw event: size 208 bytes
> > +.  0000:  09 00 00 00 01 00 d0 00 fc 72 01 86 ff ff ff ff  .........r.=
.....
> > +.  0010:  74 7d 2c 00 74 7d 2c 00 fb c3 79 f9 ba d5 05 00  t},.t},...y=
.....
> > +.  0020:  e6 cb 1a 00 00 00 00 00 01 00 00 00 00 00 00 00  ...........=
.....
> > +.  0030:  02 00 00 00 00 00 00 00 76 01 00 00 00 00 00 00  ........v..=
.....
> > +.  0040:  e6 cb 1a 00 00 00 00 00 00 00 00 00 00 00 00 00  ...........=
.....
> > +.  0050:  62 18 00 00 00 00 00 00 f6 cb 1a 00 00 00 00 00  b..........=
.....
> > +.  0060:  00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00  ...........=
.....
> > +.  0070:  80 ff ff ff ff ff ff ff fc 72 01 86 ff ff ff ff  .........r.=
.....
> > +.  0080:  f3 0e 6e 85 ff ff ff ff 0c cb 7f 85 ff ff ff ff  ..n........=
.....
> > +.  0090:  bc f2 87 85 ff ff ff ff 44 af 7f 85 ff ff ff ff  ........D..=
.....
> > +.  00a0:  bd be 7f 85 ff ff ff ff 26 d0 7f 85 ff ff ff ff  ........&..=
.....
> > +.  00b0:  6d a4 ff 85 ff ff ff ff ea 00 20 86 ff ff ff ff  m......... =
.....
> > +.  00c0:  00 fe ff ff ff ff ff ff 57 14 4f 43 fc 7e 00 00  ........W.O=
C.~..
> > +
> > +1642373909693435 0xc550 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 2915700/2=
915700: 0xffffffff860172fc period: 1 addr: 0
> > +... FP chain: nr:12
> > +.....  0: ffffffffffffff80
> > +.....  1: ffffffff860172fc
> > +.....  2: ffffffff856e0ef3
> > +.....  3: ffffffff857fcb0c
> > +.....  4: ffffffff8587f2bc
> > +.....  5: ffffffff857faf44
> > +.....  6: ffffffff857fbebd
> > +.....  7: ffffffff857fd026
> > +.....  8: ffffffff85ffa46d
> > +.....  9: ffffffff862000ea
> > +..... 10: fffffffffffffe00
> > +..... 11: 00007efc434f1457
> > +... sample_read:
> > +.... group nr 2
> > +..... id 00000000001acbe6, value 0000000000000176, lost 0
> > +..... id 00000000001acbf6, value 0000000000001862, lost 0
> > +
> > +0xc620@perf.data [0x30]: event: 3
> > ...
> > ```
> >
> > This behavior is incorrect as in the case above perf inject should
> > have done nothing. Fix this behavior by disabling separating samples
> > for a tool that requests it. Only request this for `perf inject` so as
> > to not affect other perf tools. With the patch and the test above
> > there are no differences between the orig.txt and new.txt.
> >
> > Fixes: e4caec0d1af3 ("perf evsel: Add PERF_SAMPLE_READ sample related p=
rocessing")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Ping.

Thanks,
Ian
