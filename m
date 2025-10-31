Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DA30649A
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938609; cv=none; b=AXwfPYmfV9Z7UJDFzK8pk9gQQfUcl5hO2nbgq9IiXO3pMIjPwjM8oF60iRiLcVsAyhA/QjUBP06GOQI2BLSt0NnXikUqeSn9bORxMCqO5oUd9DGfm2wd+l9ojRT6oVjK71dRFcHDBvuoCzg5c5feDVj+hghtQ6F5dm3aw7L/mVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938609; c=relaxed/simple;
	bh=98sMOk36bEiTkJqPUejuSeS16LmRjswKpJO4aGrBN68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enoSp0AYoGBaC8UD2+CpL/IRXUUtC7hAtJw8cGJ8vnFuRocluoMx/5lGKpnaZXiwJPwXbIX70RIBdXUHuRb3Mgykj/MzC4QSRg+B50wFiKyNvRxMSWztr8nk0bsUYXAwWdhPb+mGLxmvJBK4N55AnRbF+9D3STkM2oyGVF6+3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAN4ybN7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAN4ybN7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eeafd4882so40435ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938607; x=1762543407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXK1A+cAcvbFw2dcEkcMoG7O+GJGRMloCbdVxTk8N40=;
        b=jAN4ybN7irnbBieoADmecVHfzAhLvkKz0Md3WMSMJBsWVB+s5pYiQgUC7s8XdcHuG+
         oVEmTW9v0ArEp8Qf6XPdj8zQ/agNB/hVzmyBMXNOaAiYyn3i7Z9x3uJGKEi8Mnr9Wuhq
         pZ5kVD/7IckIbZPsWudm4+YxYKttrhejqk776pufIl1USy4bjGt/T8dGw1//4H1GryzR
         htonk/LE9LTNtbotlY9tU4gF3mT2S70ppCl5rdP8KNCVyG+NZRrmMroHg2rKgzIjWwAa
         XoMahUeMtX5fVs9kYdM1AC/8TvS6BecekbLAD/wEbk2/GgdbqFH9u8afCvVOHzl2Gkz/
         Ac8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938607; x=1762543407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXK1A+cAcvbFw2dcEkcMoG7O+GJGRMloCbdVxTk8N40=;
        b=VtxtkMiKaenVUhmjbkoZZAXh3huUUpyqYIDiN8oJGvrcA3/IE+j8wfFuHSLIQVhkez
         7S5FDrQpB/CZurMt7/ZXwD22AtahJduBGbE+qKFsqww+tU4ZHeTJrOEnp65Ldp7y0dNS
         MGGoelV5PBPfBg+DuGiwVIxnh+aXZ/wFcs+t2JP1A7qSpiZrorsY0wOUgvzgY171rZEy
         Z7goBlnMge3zpTzdW8M6k8C+p2HaojHKIUReyelvsZG9Q1YfnaIdMh5BxDo4891XQCxT
         AW0XAkWBbVxUSGEZiWGOmtKQSGgtZamZoE7oMoJEFdRfxLU7qeVXoB6/AOTbZVzB0xqq
         E22A==
X-Forwarded-Encrypted: i=1; AJvYcCU5PUHx27Gf5Y5342ZAzZRZ4jXSu7LC98fV54/k8yFHAJXZcdyGNV11WNggQz/660HTkgb4lf9+wMyIwHLQoi+L@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvDxXmgs40SDmbhmJPYFRi0UYXQoXVMDsni4uCKBYK83QTI9d
	siIAq7Svyp7yk1AeZa4DkdLbEKMG3ESbeNxgAY9oclsegaL2Lf9GkPgb/vGh/H+77+efUJ+xtl4
	Jbzh2gJ7j9jdo64lnDeyUkgRqNkjbKF5o/6ApmRSw
X-Gm-Gg: ASbGncuIhfG96egGCBc/OmsKGIJ3EssYieSov7IHyiz2duPc5LCT7EQm9ZMnOOxzcrF
	9Drz1OlgdefnsiwB0vezW/IoOpOeb0a9MxAxeDfm66cIn+kN550/Hemn9sWh4DPAe7ACNez3cDw
	sunh4LPc0eX/s75vTzwFbUO0hJgeh7MQY+rFmC0V9oloUZDpHG/IbPMweZNJwDD0qfj9sadh7D7
	zUqG/LkzlBvqBIqKUBpghHOxPoqen07YXkUZ0ybcR8g/KZ1xDAR5uOWj8XTl+DqgvRa52PrGhuB
	rf0EuvkkDBrIEVlxA7Ms4iDLEw==
X-Google-Smtp-Source: AGHT+IFJhawpF3FYqhwNdDqrcKQkXOv8MTliTU/flAGjUIHpZLOQnWTHNCZyJFui5XD1MSl1IPvv52qxkDojdyU3HW4=
X-Received: by 2002:a17:902:fc48:b0:295:5405:46be with SMTP id
 d9443c01a7336-29554c8de12mr975975ad.1.1761938606549; Fri, 31 Oct 2025
 12:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
 <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
 <fc75b170-86c1-49b6-a321-7dca56ad824a@linux.alibaba.com> <eed27aaf-fd0a-4609-a30b-68e7c5c11890@linux.alibaba.com>
 <CAP-5=fVLGRsn7icH1cgmb==f5_D6Vr2CbzirAv7DY4Afjm4O2A@mail.gmail.com>
 <5a06462a-697d-47b6-b51e-6438005b6130@linux.alibaba.com> <CAP-5=fUvwokP=MYmS7kZqjCk+ZYs8A-9G+i3zt-zvjdZA6E_Jg@mail.gmail.com>
 <aQUHXotIjne3vHm_@google.com>
In-Reply-To: <aQUHXotIjne3vHm_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 12:23:15 -0700
X-Gm-Features: AWmQ_bm7RhqdKLrPXhUYOnh5tvV7zqkSFRz8mn-xXj2nPo9M1QX8UnuUcUm750Q
Message-ID: <CAP-5=fWecBQXzrPmoxZbggdhtzGh+BKm73heaiqH3tAV8obWyg@mail.gmail.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Namhyung Kim <namhyung@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, alexander.shishkin@linux.intel.com, 
	peterz@infradead.org, james.clark@arm.com, leo.yan@linaro.org, 
	mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org, 
	mark.rutland@arm.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Fri, Oct 31, 2025 at 09:04:38AM -0700, Ian Rogers wrote:
> > On Thu, Oct 30, 2025 at 7:36=E2=80=AFPM Shuai Xue <xueshuai@linux.aliba=
ba.com> wrote:
> > >
> > > =E5=9C=A8 2025/10/31 01:32, Ian Rogers =E5=86=99=E9=81=93:
> > > > On Wed, Oct 29, 2025 at 5:55=E2=80=AFAM Shuai Xue <xueshuai@linux.a=
libaba.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> =E5=9C=A8 2025/10/24 10:45, Shuai Xue =E5=86=99=E9=81=93:
> > > >>>
> > > >>>
> > > >>> =E5=9C=A8 2025/10/24 00:08, Ian Rogers =E5=86=99=E9=81=93:
> > > >>>> On Wed, Oct 22, 2025 at 6:50=E2=80=AFPM Shuai Xue <xueshuai@linu=
x.alibaba.com> wrote:
> > > >>>>>
> > > >>>>> When using perf record with the `--overwrite` option, a segment=
ation fault
> > > >>>>> occurs if an event fails to open. For example:
> > > >>>>>
> > > >>>>>     perf record -e cycles-ct -F 1000 -a --overwrite
> > > >>>>>     Error:
> > > >>>>>     cycles-ct:H: PMU Hardware doesn't support sampling/overflow=
-interrupts. Try 'perf stat'
> > > >>>>>     perf: Segmentation fault
> > > >>>>>         #0 0x6466b6 in dump_stack debug.c:366
> > > >>>>>         #1 0x646729 in sighandler_dump_stack debug.c:378
> > > >>>>>         #2 0x453fd1 in sigsegv_handler builtin-record.c:722
> > > >>>>>         #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
> > > >>>>>         #4 0x6c5671 in __perf_event__synthesize_id_index synthe=
tic-events.c:1862
> > > >>>>>         #5 0x6c5ac0 in perf_event__synthesize_id_index syntheti=
c-events.c:1943
> > > >>>>>         #6 0x458090 in record__synthesize builtin-record.c:2075
> > > >>>>>         #7 0x45a85a in __cmd_record builtin-record.c:2888
> > > >>>>>         #8 0x45deb6 in cmd_record builtin-record.c:4374
> > > >>>>>         #9 0x4e5e33 in run_builtin perf.c:349
> > > >>>>>         #10 0x4e60bf in handle_internal_command perf.c:401
> > > >>>>>         #11 0x4e6215 in run_argv perf.c:448
> > > >>>>>         #12 0x4e653a in main perf.c:555
> > > >>>>>         #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3e=
a72]
> > > >>>>>         #14 0x43a3ee in _start ??:0
> > > >>>>>
> > > >>>>> The --overwrite option implies --tail-synthesize, which collect=
s non-sample
> > > >>>>> events reflecting the system status when recording finishes. Ho=
wever, when
> > > >>>>> evsel opening fails (e.g., unsupported event 'cycles-ct'), sess=
ion->evlist
> > > >>>>> is not initialized and remains NULL. The code unconditionally c=
alls
> > > >>>>> record__synthesize() in the error path, which iterates through =
the NULL
> > > >>>>> evlist pointer and causes a segfault.
> > > >>>>>
> > > >>>>> To fix it, move the record__synthesize() call inside the error =
check block, so
> > > >>>>> it's only called when there was no error during recording, ensu=
ring that evlist
> > > >>>>> is properly initialized.
> > > >>>>>
> > > >>>>> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option=
")
> > > >>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > > >>>>
> > > >>>> This looks great! I wonder if we can add a test, perhaps here:
> > > >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-to=
ols-next.git/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n435
> > > >>>> something like:
> > > >>>> ```
> > > >>>> $ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- s=
leep 0.1
> > > >>>> ```
> > > >>>> in a new test subsection for test_overwrite? foobar would be an =
event
> > > >>>> that we could assume isn't present. Could you help with a test
> > > >>>> covering the problems you've uncovered and perhaps related flags=
?
> > > >>>>
> > > >>>
> > > >>> Hi, Ian,
> > > >>>
> > > >>> Good suggestion, I'd like to add a test. But foobar may not a goo=
d case.
> > > >>>
> > > >>> Regarding your example:
> > > >>>
> > > >>>     perf record -e foobar -a --overwrite -o /dev/null -- sleep 0.=
1
> > > >>>     event syntax error: 'foobar'
> > > >>>                          \___ Bad event name
> > > >>>
> > > >>>     Unable to find event on a PMU of 'foobar'
> > > >>>     Run 'perf list' for a list of valid events
> > > >>>
> > > >>>      Usage: perf record [<options>] [<command>]
> > > >>>         or: perf record [<options>] -- <command> [<options>]
> > > >>>
> > > >>>         -e, --event <event>   event selector. use 'perf list' to =
list available events
> > > >>>
> > > >>>
> > > >>> The issue with using foobar is that it's an invalid event name, a=
nd the
> > > >>> perf parser will reject it much earlier. This means the test woul=
d exit
> > > >>> before reaching the part of the code path we want to verify (wher=
e
> > > >>> record__synthesize() could be called).
> > > >>>
> > > >>> A potential alternative could be testing an error case such as EA=
CCES:
> > > >>>
> > > >>>     perf record -e cycles -C 0 --overwrite -o /dev/null -- sleep =
0.1
> > > >>>
> > > >>> This could reproduce the scenario of a failure when attempting to=
 access
> > > >>> a valid event, such as due to permission restrictions. However, t=
he
> > > >>> limitation here is that users may override
> > > >>> /proc/sys/kernel/perf_event_paranoid, which affects whether or no=
t this
> > > >>> test would succeed in triggering an EACCES error.
> > > >>>
> > > >>>
> > > >>> If you have any other suggestions or ideas for a better way to si=
mulate
> > > >>> this situation, I'd love to hear them.
> > > >>>
> > > >>> Thanks.
> > > >>> Shuai
> > > >>
> > > >> Hi, Ian,
> > > >>
> > > >> Gentle ping.
> > > >
> > > > Sorry, for the delay. I was trying to think of a better way given t=
he
> > > > problems you mention and then got distracted. I wonder if a legacy
> > > > event that core PMUs never implement would be a good candidate to
> > > > test. For example, the event "node-prefetch-misses" is for "Local
> > > > memory prefetch misses" but the memory controller tends to be a
> > > > separate PMU and this event is never implemented to my knowledge.
> > > > Running this locally I see:
> > > >
> > > > ```
> > > > $ perf record -e node-prefetch-misses -a --overwrite -o /dev/null -=
- sleep 0.1
> > > > Lowering default frequency rate from 4000 to 1750.
> > > > Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rat=
e.
> > > > Error:
> > > > Failure to open event 'cpu_atom/node-prefetch-misses/' on PMU
> > > > 'cpu_atom' which will be removed.
> > > > No fallback found for 'cpu_atom/node-prefetch-misses/' for error 2
> > > > Error:
> > > > Failure to open event 'cpu_core/node-prefetch-misses/' on PMU
> > > > 'cpu_core' which will be removed.
> > > > No fallback found for 'cpu_core/node-prefetch-misses/' for error 2
> > > > Error:
> > > > Failure to open any events for recording.
> > > > perf: Segmentation fault
> > > >     #0 0x55a487ad8b87 in dump_stack debug.c:366
> > > >     #1 0x55a487ad8bfd in sighandler_dump_stack debug.c:378
> > > >     #2 0x55a4878c6f94 in sigsegv_handler builtin-record.c:722
> > > >     #3 0x7f72aae49df0 in __restore_rt libc_sigaction.c:0
> > > >     #4 0x55a487b57ef8 in __perf_event__synthesize_id_index
> > > > synthetic-events.c:1862
> > > >     #5 0x55a487b58346 in perf_event__synthesize_id_index synthetic-=
events.c:1943
> > > >     #6 0x55a4878cb2a3 in record__synthesize builtin-record.c:2150
> > > >     #7 0x55a4878cdada in __cmd_record builtin-record.c:2963
> > > >     #8 0x55a4878d11ca in cmd_record builtin-record.c:4453
> > > >     #9 0x55a48795b3cc in run_builtin perf.c:349
> > > >     #10 0x55a48795b664 in handle_internal_command perf.c:401
> > > >     #11 0x55a48795b7bd in run_argv perf.c:448
> > > >     #12 0x55a48795bb06 in main perf.c:555
> > > >     #13 0x7f72aae33ca8 in __libc_start_call_main libc_start_call_ma=
in.h:74
> > > >     #14 0x7f72aae33d65 in __libc_start_main_alias_2 libc-start.c:12=
8
> > > >     #15 0x55a4878acf41 in _start perf[52f41]
> > > > Segmentation fault
> > > > ```
> > >
> > >
> > > Hi, Ian=EF=BC=8C
> > >
> > > Is node-prefetch-misses a platform specific event? Running it on ARM =
Yitian 710
> > > and Intel SPR platform, I see:
> > >
> > > $sudo perf record -e node-prefetch-misses
> > > Error:
> > > The node-prefetch-misses event is not supported.
> >
> > Hi Shuai,
> >
> > So node-prefetch-misses is a legacy event. Perf has a notion of events
> > that are inbuilt to the kernel/PMU driver and get special fixed
> > encodings. That said, the PMU driver in the kernel can just fail to
> > support the events and I think that's uniformly the case for
> > node-prefetch-misses. As shown by my reproduction of the crash, which
> > I hope this suffices for a test - i.e. it is an event that parses but
> > one that is never supported.
>
> Maybe it's platform dependent.  I have no idea what's the best for this
> test.  Any uncore event would work as well but it's not standardized.

I wonder pmu->is_uncore will be true for PMUs like IBS.

Thanks,
Ian

> I'll merge this fix first.
>
> Thanks,
> Namhyung
>
