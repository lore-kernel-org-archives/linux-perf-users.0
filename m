Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D3200B2
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081AF101;
	Wed, 15 Nov 2023 07:48:45 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5b980391d7cso4399869a12.0;
        Wed, 15 Nov 2023 07:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063324; x=1700668124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s12ncDJyYBjbloau2hqKY3l51l8J95ntKc21brrMHWk=;
        b=JTzAkZWWif28ou269nxN2gjUZpODn48PGCy8ryAaeq4khORLum9MxX3XHZFiqqGqQX
         WCW1koDNS+d/5+60yPsUhZsdxNJ9uP10EZjCW4rc0tHyThAJj5oRuWq4BrBTAnWPO3S1
         gdSUhNIS/JPd4VGrmQ904SZ8+BgeplOWlQmntLqFrKZNjN/mJUfSjHEKI3zcUvNqO1W/
         +isEg4rzGEWLSPXXq9ujVeF47O8nifiouUVa+0Q5WXtVIeTrCSgGjGPd/I3S44Z41s4z
         csKjaIla+qVvmBxEew01vA4G8ccX979S29pA5WLPdYm49srepLpHQiNXF9DG8QE86vgt
         FFRg==
X-Gm-Message-State: AOJu0YyMnmIxfSw1TJcuMi0BGKrFfFNdV/ASspI8Q7FB/PuX/voIrJfS
	MnDvyuztWIH9rb40DXT8hamNy/sAoeFXZ/s9mVpIJPXC
X-Google-Smtp-Source: AGHT+IHMHtFlPPJC84HxBvE2A3+UnswOmZf3CXlHH3EuX8+wNQSNfn/YuI2EWDNXPjf9K9O9Wit7EJA0tpzYWgXPxGk=
X-Received: by 2002:a17:90a:cb95:b0:27c:f1f8:261f with SMTP id
 a21-20020a17090acb9500b0027cf1f8261fmr9728656pju.20.1700063324412; Wed, 15
 Nov 2023 07:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com> <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
In-Reply-To: <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 15 Nov 2023 07:48:33 -0800
Message-ID: <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed for
 aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
To: David Wang <00107082@163.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 3:00=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
>
>
> At 2023-11-15 18:32:41, "Peter Zijlstra" <peterz@infradead.org> wrote:
> >
> >Namhyung, could you please take a look, you know how to operate this
> >cgroup stuff.
> >
>
> More information,  I run the profiling with 8cpu machine on a SSD with ex=
t4 filesystem :
>
> # mkdir /sys/fs/cgroup/mytest
> # echo $$ > /sys/fs/cgroup/mytest/cgroup.procs
> ## Start profiling targeting cgroup /sys/fs/cgroup/mytest   on another te=
rminal
> # fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --name=3Dtest  --=
bs=3D4k --iodepth=3D64 --size=3D1G --readwrite=3Drandrw  --runtime=3D600 --=
numjobs=3D4 --time_based=3D1
>
> I got a feeling that f06cc667f7990 would decrease total samples by 10%~20=
% when profiling IO benchmark within cgroup.

Oh sorry, I missed this message.  Can you please share the
command line and the output?

Thanks,
Namhyung
