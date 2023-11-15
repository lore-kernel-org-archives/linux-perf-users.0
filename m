Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B12182AC
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3AAB;
	Wed, 15 Nov 2023 08:26:18 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso5441242a12.3;
        Wed, 15 Nov 2023 08:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065578; x=1700670378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XbGNtZYQzrg+K/86U5tkkq4BRBUIpICB/C0IOeiM6Q=;
        b=KLHUmA4/es8Rcr3QDHXNmJv6QrcaZJ6zXcIjGA37Vc8IBpFxjc4cm4LImrxbzwKuam
         4QDmDcQQirFOT+uEVJWEM9w0aTfW5ZFdqRbKFG4IOsDgNK547IhUWhyY5JZ5U4Xytqv4
         zvsQsbRoR1eAl1rTHgxS5kqWzbnldHIoC2+rYGqOQ5pv9C1jP5hqnpmaSVA18BQlwxsI
         wnJMF60cuoIaEogI7ALYTO+HC3igpkw4GAVNcn5RUMqD+FCEPtjnymn2ZqBZR6s0Tdol
         BoDgmuPGupBzVBvsZhbx+tyi/gnct9q8tFiW6QzNdJboJ1eBWSeWgHTSTbVPZoJfoZWf
         mMgA==
X-Gm-Message-State: AOJu0YwuXTOOK0har0fLWXRdvvMIzWNXl2l2K4KD5I4pYXUithxGU9Mr
	Z/aTJ+/dLaGlAG8VOUCGlwN8stRBmo6eG/K8fDY=
X-Google-Smtp-Source: AGHT+IF5g1wRBbrnBPwjzq/pQzH6gj1NY7XTcsRAlsqoLpnDnPN1IgoVgSxKIo3KkCbBz+xSQQapxKxtokP116cJH24=
X-Received: by 2002:a17:90b:2789:b0:283:2932:e912 with SMTP id
 pw9-20020a17090b278900b002832932e912mr14944255pjb.28.1700065577790; Wed, 15
 Nov 2023 08:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com> <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com> <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
 <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com>
In-Reply-To: <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 15 Nov 2023 08:26:06 -0800
Message-ID: <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed for
 aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
To: David Wang <00107082@163.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 8:12=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
>
> =E5=9C=A8 2023-11-15 23:48:33=EF=BC=8C"Namhyung Kim" <namhyung@kernel.org=
> =E5=86=99=E9=81=93=EF=BC=9A
> >On Wed, Nov 15, 2023 at 3:00=E2=80=AFAM David Wang <00107082@163.com> wr=
ote:
> >>
> >>
> >>
> >> At 2023-11-15 18:32:41, "Peter Zijlstra" <peterz@infradead.org> wrote:
> >> >
> >> >Namhyung, could you please take a look, you know how to operate this
> >> >cgroup stuff.
> >> >
> >>
> >> More information,  I run the profiling with 8cpu machine on a SSD with=
 ext4 filesystem :
> >>
> >> # mkdir /sys/fs/cgroup/mytest
> >> # echo $$ > /sys/fs/cgroup/mytest/cgroup.procs
> >> ## Start profiling targeting cgroup /sys/fs/cgroup/mytest   on another=
 terminal
> >> # fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --name=3Dtest =
 --bs=3D4k --iodepth=3D64 --size=3D1G --readwrite=3Drandrw  --runtime=3D600=
 --numjobs=3D4 --time_based=3D1
> >>
> >> I got a feeling that f06cc667f7990 would decrease total samples by 10%=
~20% when profiling IO benchmark within cgroup.
> >
> >Oh sorry, I missed this message.  Can you please share the
> >command line and the output?
> >
> I did not use perf..... This is the part where  it is not quite convincin=
g to report the change, I am using a profiling tool of my own as I mentione=
d in the first mail.....
> But I believe my profiling tools did detect some changes.

Oh.. ok.  You didn't use perf.

Then what is your profiling tool?  Where did you see
the 10%~20% drop in samples?

>
> I am not experienced with the perf-tool at all,   too complicated a tool =
for me.... But I think I can try it.

I feel sorry about that.  In most cases, just `perf record -a` and
then `perf report` would work well. :)

Thanks,
Namhyung
