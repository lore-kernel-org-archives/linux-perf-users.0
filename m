Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041E224DF
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BFBE;
	Fri, 13 Oct 2023 15:57:39 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-27d104fa285so2039182a91.2;
        Fri, 13 Oct 2023 15:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237859; x=1697842659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rQJT81/yzbQzjWsAaHq+5H9Y0QP+lwQhpZXPD22nck=;
        b=pEcGRGcVIjcJY5VD9AAiE56TZLRWvi9RBPtwHE02ktWKDxsjFJSOT8+xKSHn1b6Oc2
         ibmfI/Bkt2HMA1Fv41F8RvjbtiH97tyPdK2VX0Hh4aQxWqV6envjP0syMx71b+PXqvCd
         RWY9jnWQyPl6RNOB2mOthYNPVHjvyBJLa6RfH/FbwX6TIXe3raCoNx2pXqgcX9ayvjrp
         vZ7mNf05kg3KSEeVpuhmPRVqa3XdByP3mSozKSFILlUoVNfShBaz4pTGytgLBSvsizXl
         H9ViiakTkMxuCK1PPR99q425J2jtMUMyZDOWsl3CYF4IEPEJ6rUVSqiTh3jWXM8hS8by
         V2Yg==
X-Gm-Message-State: AOJu0Yy3/zqYlkwxb6IrQq3PypzLmI6HOoyEUBnZ6yzgTzfnXtpQdghm
	exyScHed5m/b8Ym7XMLdcH8DUZhxaKJfEFaX/8Z0z4WLpZw=
X-Google-Smtp-Source: AGHT+IG6RY+Y0DCmrkpCgAxzPt2hRky+SZdvagZZco+YP/UpdQT8IE1gzOfM1HKV1WYgWFiPFjBiVSJ76om3xfS8vwo=
X-Received: by 2002:a17:90a:1089:b0:274:4161:b9dc with SMTP id
 c9-20020a17090a108900b002744161b9dcmr27158941pja.31.1697237858654; Fri, 13
 Oct 2023 15:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004204741.985422-1-namhyung@kernel.org> <ZSnHek1HlQTkfjhG@kernel.org>
In-Reply-To: <ZSnHek1HlQTkfjhG@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 13 Oct 2023 15:57:27 -0700
Message-ID: <CAM9d7cip5qmPRhWF37JH_21Q8SjKQCTBVyF_PLE-ytTFOwpasg@mail.gmail.com>
Subject: Re: [PATCH] perf bench sched pipe: Add -G/--cgroups option
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arnaldo,

On Fri, Oct 13, 2023 at 3:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Oct 04, 2023 at 01:47:41PM -0700, Namhyung Kim escreveu:
> > The -G/--cgroups option is to put sender and receiver in different
> > cgroups in order to measure cgroup context switch overheads.
> >
> > Users need to make sure the cgroups exist and accessible.
> >
> >   # perf stat -e context-switches,cgroup-switches \
> >   > taskset -c 0 perf bench sched pipe -l 10000 > /dev/null
> >
> >    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l=
 10000':
> >
> >               20,001      context-switches
> >                    2      cgroup-switches
> >
> >          0.053449651 seconds time elapsed
> >
> >          0.011286000 seconds user
> >          0.041869000 seconds sys
> >
> >   # perf stat -e context-switches,cgroup-switches \
> >   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
> >
> >    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l=
 10000 -G AAA,BBB':
> >
> >               20,001      context-switches
> >               20,001      cgroup-switches
> >
> >          0.052768627 seconds time elapsed
>
> So I tried with:
>
> [root@quaco ~]# perf bench sched pipe -G system.slice,user.slice
> # Running 'sched/pipe' benchmark:
> cannot enter to cgroup: system.slice
> cannot enter to cgroup: user.slice
> # Executed 1000000 pipe operations between two processes
>
>      Total time: 6.301 [sec]
>
>        6.301478 usecs/op
>          158692 ops/sec
> [root@quaco ~]#
>
> Should't it bail out when not managing to enter the cgroups?

Hmm.. right.  Will fix.

>
> Also:
>
> [root@quaco ~]# mkdir /sys/fs/cgroup/AAA
> [root@quaco ~]# mkdir /sys/fs/cgroup/BBB
> [root@quaco ~]#
> [root@quaco ~]# perf bench sched pipe -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> cannot enter to cgroup: AAA
> cannot enter to cgroup: BBB
> # Executed 1000000 pipe operations between two processes
>
>      Total time: 6.397 [sec]
>
>        6.397830 usecs/op
>          156302 ops/sec
> [root@quaco ~]#
>
> -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.procs
> [root@quaco ~]# ls -la /sys/fs/cgroup/AAA/cgroup.threads
> -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.threads
> [root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.threads
> -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.threads
> [root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.procs
> -rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.procs
> [root@quaco ~]#
>
> [root@quaco ~]# perf bench sched pipe -G AAA,BBB
> # Running 'sched/pipe' benchmark:
> cannot enter to cgroup: AAA (written=3D-1, len=3D6, errno=3DOperation not=
 supported)
> cannot enter to cgroup: BBB (written=3D-1, len=3D6, errno=3DOperation not=
 supported)
> # Executed 1000000 pipe operations between two processes
>
>      Total time: 6.303 [sec]
>
>        6.303221 usecs/op
>          158649 ops/sec
> [root@quaco ~]#
>
> I'm certainly missing something here :-\

Try to enable some cgroup controllers first.  Like

  # echo +cpu > /sys/fs/cgroup/AAA/cgroup.subtree_control
  # echo +cpu > /sys/fs/cgroup/BBB/cgroup.subtree_control

Thanks,
Namhyung
