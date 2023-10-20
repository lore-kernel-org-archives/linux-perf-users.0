Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3FC8FD
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C19EA3
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 23:33:31 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-27d4372322aso400730a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 23:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783611; x=1698388411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAVEObAMuCIGspLrHXxE29eV73XuLxrGxunihE5n6rU=;
        b=UGlBMdCU5fvfCOmje+14DdhvAd5m0QMBBh95gMD2vBVf6jItSwwIzRk85zGuQZbOnA
         R7XzXiqHHsc+vgMRfw+FYzPhgOP5E4qBrX+usQuFiR+e7sKl+pkncMWJSENQiphwN1li
         YXZUw6+nVDsYo0rBISWqI6meocYkfxZ1vrVYcTXm7Y/P1xmMwW9XVVJPHhyJL5bpIc7W
         HjOPs6eIFJU6Kjynkv4mpnXEAqPADJ+e1l1GB/dHaDrEeO0RTHkVLVclyAZBJtH/TLS4
         CVhYs1ECMofwT3fDRFKnpgYWHL6/fAuh3OOkpuU68w8TYR5EF+ivoZqSt14WSFSFHgob
         LW9A==
X-Gm-Message-State: AOJu0YwmBAHF5DrNJgNJ+qFotp0m3stMncSHOL9iDCuUAlWkQqCS0q/z
	kKrtW6RBl8cMlVmOvKdoZUOu3WvcS/HDnw5whII6OXqwM8o=
X-Google-Smtp-Source: AGHT+IElVuVCqcAuKx5OEvhVsubxsAwJgefl0nwAF8ah72enYf99yFj0Y8OCw03qU1EqrGnCnKf2RPXYM3prfwowWQA=
X-Received: by 2002:a17:90a:3d45:b0:27d:86a1:ae04 with SMTP id
 o5-20020a17090a3d4500b0027d86a1ae04mr1038339pjf.15.1697783610764; Thu, 19 Oct
 2023 23:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.LRH.2.20.2310191027320.11297@Diego>
In-Reply-To: <alpine.LRH.2.20.2310191027320.11297@Diego>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 19 Oct 2023 23:33:19 -0700
Message-ID: <CAM9d7cgxWY3ymyz93h+stWXW7UTdKN6V+T7ZyWZ2wn0j1oi1vw@mail.gmail.com>
Subject: Re: perf sampling count/freq/period strange bahavior
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 19, 2023 at 1:28=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> Hello all...
>
> We have encountered a strange behavior related to sampling. Generally
> said, the number of samples is usually much lower than it should be.
>
> Let's say, for load L, `perf stat -e instructions -- L` shows around
> 250,000 event hits. If I understand the concept of `-c` option for
> `perf record`, with `-c 250` it should make the counter overflow and
> generate a sample for every 250th event hit, so, it should result into
> ~1000 samples.
>
> Instead I am getting something like ~62-150 samples, for example 124.
> I have checked in dmesg that kernel has not throttled anything. When
> running `perf report --stdio`, I see in the header that there were 0
> samples lost (so the buffer was consumed fast enough). Additionally,
> `perf report --stdio` tries to estimate the actual event count:
>
>   Event count (approx.): 31000
>
> (Which is because 250 * 124 =3D 31000, so perf itself considers this
> formula (n_of_samples * sampling_rate =3D n_of_events) valid.)
>
> But in reality, this is not the case, `perf stat`, as said, never
> shows that low number of events for the same load.
>
> What else is involved in the sampling rates and why the number of
> samples is so much lower than it should be?
>
> Thank you for ideas!

I don't know but it seems PMU has some internal limit
on the period and ignores lower values.

On my Intel machine,

$ perf stat -e instructions:u true

 Performance counter stats for 'true':

           120,024      instructions:u

       0.002002822 seconds time elapsed

       0.002040000 seconds user
       0.000000000 seconds sys


$ perf record -e instructions:u -c 10000 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (12 samples) ]

$ perf record -e instructions:u -c 5000 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (24 samples) ]

$ perf record -e instructions:u -c 4000 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (30 samples) ]

$ perf record -e instructions:u -c 3000 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (40 samples) ]

$ perf record -e instructions:u -c 2000 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.003 MB perf.data (51 samples) ]

$ perf record -e instructions:u -c 1000 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.003 MB perf.data (51 samples) ]

$ perf record -e instructions:u -c 500 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.003 MB perf.data (51 samples) ]
