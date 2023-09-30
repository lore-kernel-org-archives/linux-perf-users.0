Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1717EF
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 06:32:13 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576311A7
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:32:12 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79faf4210b2so412174639f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696055531; x=1696660331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5ipF69/Ebwaux7stRusr0oeQfM271w9vxjAqkqGNbE=;
        b=X8mU+XkOWuwEUc6/vjKTq57/fKPPzJ9c/M8kXolZHLzCjij/6nmO4vcaeQz+2oZ1K8
         oXjnHSyQMfjpKHOyvmMncAkcTwB6ZmkHrOajH3AX6zvyaucW2TMtc/eVcEkfwPADRjwA
         QnrpLPJLK68i5E9SQjInF7tAe668B7cmQ8LJ5pNEVPeZm7ZMwm3MEhwBU0HUcF0J+Q/3
         b9eWs6v23V/SlDF313pUZ7NbRcT1mMBPyAOUJKKiveUdDfIfAY30QpJl9VaUCVj0x5T4
         SioueL0QOZPQeO6E+XuEfjxUN6YjpwjcDgFNIqz+eLFYnR0F8B02FUkiZeWzi1pcaanu
         HmyQ==
X-Gm-Message-State: AOJu0YxiWSKQNu+9o4OUeZGhWsuOawokTM57Frr+MD8YF2UDS0VOkZAv
	u2Gi164JS9J7edtPcFCL1Isf0c2LB4UxbqPnYGWpKcj4
X-Google-Smtp-Source: AGHT+IEZfAJjmj5nsemRVOcDlaLRPIkm1WSKlw4p0D/pIQUlaOsPKYYHPjSCjo7eahXh+fGcaVgjgyiHZMSxooAk17U=
X-Received: by 2002:a6b:db08:0:b0:79d:8708:4d24 with SMTP id
 t8-20020a6bdb08000000b0079d87084d24mr6434797ioc.15.1696055531466; Fri, 29 Sep
 2023 23:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a212e80-b00b-f44b-3d2c-6e221d8cc1ac@linux.ibm.com>
In-Reply-To: <3a212e80-b00b-f44b-3d2c-6e221d8cc1ac@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 29 Sep 2023 23:32:00 -0700
Message-ID: <CAM9d7cjTRE6D8hHfCrmFWE3fDfds+RAMYevuCNM2t_c3S5-T3A@mail.gmail.com>
Subject: Re: Question to perf record command
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Fri, Sep 29, 2023 at 2:56=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> I have a question regarding command perf record.
>
> Command ./perf record -R -e cycles -vvv -C0 -- true
> sets up perf_event_open system call with CPU =3D=3D 0 and PID =3D=3D -1.
>
> According to the documentation, this applies to all processes on CPU 0
> and not just the process named true.
>
> Is this indended? I thought process true should be traced when running on
> CPU 0. Shouldn't the perf_event_open() system call in called with
> CPU set to 0 and PID set to PID of process true?

It's intended.  When you specify CPU targets (-a or -C options),
it'd profile ALL processes on those CPUs.  The command line
task just controls when it terminates the sampling.  For example,
we often use sleep command to profile all processes for the
specified time.

  $ perf record -a -- sleep 1

Thanks,
Namhyung

>
> Tracing output:
> # ./perf record -R -e cycles -vvv -C0 -- true
> DEBUGINFOD_URLS=3D
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> perf record opening and mmapping events
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|ID|CPU|PERIOD|RAW
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   freq                             1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 5
> ....
>
>
> When command invocation is
> # ./perf record -R -e cycles -vvv -- true
>
> the forked process named true (PID 13092) is traced on all CPUs:
> [root@a35lp67 perf]# ./perf record -R -e cycles -vvv  -- true
> DEBUGINFOD_URLS=3D
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> perf record opening and mmapping events
> Opening: cycles
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD|RAW
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   mmap                             1
>   comm                             1
>   freq                             1
>   enable_on_exec                   1
>   task                             1
>   sample_id_all                    1
>   exclude_guest                    1
>   mmap2                            1
>   comm_exec                        1
>   ksymbol                          1
>   bpf_event                        1
> ------------------------------------------------------------
> sys_perf_event_open: pid 13092  cpu 0  group_fd -1  flags 0x8 =3D 5
> sys_perf_event_open: pid 13092  cpu 1  group_fd -1  flags 0x8 =3D 6
> sys_perf_event_open: pid 13092  cpu 2  group_fd -1  flags 0x8 =3D 7
> sys_perf_event_open: pid 13092  cpu 3  group_fd -1  flags 0x8 =3D 9
> sys_perf_event_open: pid 13092  cpu 4  group_fd -1  flags 0x8 =3D 10
> sys_perf_event_open: pid 13092  cpu 5  group_fd -1  flags 0x8 =3D 11
> sys_perf_event_open: pid 13092  cpu 6  group_fd -1  flags 0x8 =3D 12
> sys_perf_event_open: pid 13092  cpu 7  group_fd -1  flags 0x8 =3D 13
> mmap size 528384B
> ....
>
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
