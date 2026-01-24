Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198621C84CB
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Jan 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769283612; cv=pass; b=QWbV6AU9UFaY1TwmvBr+Q+S4cpvIpbgXV9U+1FHPw8nrpFL7Mb3M5OkQmyhhoMf5nSiyCqkLbAbuztciyYembg6iPw2Kf2KEQ2Fhms71FJ/GxExwL79Xr1cB4O5aPR3k/8bbpY7uqPKL9L2ArP5luvX4e8CSzYQwh25JFMdLKhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769283612; c=relaxed/simple;
	bh=xZtujagwiS9ta3o5Ex3w8VAX7xL7AStQvXilyTlTeSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9AbdML/xYvakZkbDGFhLhDM1eSoPxzUTNdRSEOcKl9PGLKkKmGXkCwtpZP5OZGdNOlm2pD/8WyyZSWSpR3kiwSkBc8saKurv1rzQDmtVMUyWoukhYGDyPC9VdAe0KqsJceZECI30cJGBida74GZbRf/GpHwyTyayVqVnZPx1HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aiIRLxhI; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aiIRLxhI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d06cfa93so48965ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 24 Jan 2026 11:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769283610; cv=none;
        d=google.com; s=arc-20240605;
        b=afqaM1Ned5w89whMfqbK/8js/Z2kmQmyqoY3W3qtD3K77RuV5DtIglqtEvh6kqSHKi
         lAaUfea5OB7U9kKQ5RuM+hP5NBcxaOCuis+zL7bXQEWZBp8j93cEkwD6doV4EaC2o0DJ
         yfkaqauzXDq3B3yY/wWowRVBLE9WXHNtFcK/7NE8wMmZILs9oNQvRURK0oTXT74ZpLOf
         6bOWPkzR8juciBJQCHoqUtf3nuA6iT2SCMXy/gF3mkwIylJaSMKQ30ibYLZpCZWXwL2K
         30P35i7DfjyrvhMvSjExawHut+BQOMghGCtGoFESqbFuf9Y0lTlpCpm+uwnJYBFsLnj9
         2iMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPyox+ciSZqKTvioIGP4mfFUSMhjRvHvlpanpML5ygo=;
        fh=gWos7Csw9yPL3F76WiSOCjc4ARrf4j5aVpTGx+bXLKk=;
        b=gmxELXqln7bdfx9Ymjm9bKrLhs+0eESoNoQxTb+A0ews5KEoNhOrBX+ub8pt3EbAN/
         q2gs4H+eE0n+gM+kO3q7xhT6Q9N1EsjqIbmkClHc4sHHiAvR0KMToPNQGwAIugMXCETd
         mV22D2EH1yRDQ5NhjBKIBc5K5pjPH2Dd4bIujOCsY3HmKsmlOiIBjJ63N3+kPeNk4YyW
         1Gxm/kxNn25p3RnRUXUrIUni5BmxwiUHuKO3ZEtanUJAP2zACxC2gohdwTfIHQ27912g
         2PSis3r8c6swEYHUgM/w2RtOdNgNQxYcZgVcWaQJ61bNUjtyd/tntuHhkLrwz4R3RQGG
         4Vlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769283610; x=1769888410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPyox+ciSZqKTvioIGP4mfFUSMhjRvHvlpanpML5ygo=;
        b=aiIRLxhIBE0TZsR41Vh6iWuH32fmWTwg+zJjwIEytw1b7rri3lEgB4Yz7mRuSaRJmz
         1BDSGKGU/T4+2rtZLOZcpIKvYroitoelmHGYFDKPl/KglMfE/t4ypM4in7+dJTqh5OrY
         heMmjed4ucUllmckCQlI8+eL88MxO3gh1cESmJFw5jx562f8yDVKogJzqKQ2egGjYPiW
         3nVdVSOjs7VgYy0rcXmcbD1BMYSJWPradAnhc+rsYA82e56k9aRWVRwsY/mMwlJKXozi
         IugCrkegZihz5Xdj1hBfQEb2tltQfw6Sj0FMYqKs8n/HdcZaQpoSH0Gdv3uv+iQu+fLF
         BdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769283610; x=1769888410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPyox+ciSZqKTvioIGP4mfFUSMhjRvHvlpanpML5ygo=;
        b=O1JC8G/7folWO+Z/8jOGh+bwY9XxkUrSuMx6tJxIaRriI8KNUsR5zSw3dqqZTgjEPm
         zoYtlb0kHv3TWU3AzP/amp6w/Bme9mUqm9Z9aaqwFwL3V4EhfoPSUiOnOkLaci784/FQ
         GlYa3EJhUovO7SpOa2JEfoKskSbj+RUm7BHBqoLgjo2Rh55ufb28WQkINHKFboe+GSJ6
         ilUBRK/2eZs68kk/cSuS/EYwWZ6WFJ2uYwfRew+Nj5EclXjs+IYZ3OokwfVR6cKMMvpk
         f+GPzR0MI8n2msniI3CF9k0gXEV3o75U/H9o5u8DtZqiyKBMdykfFKOn0WsCe/B70Htw
         5BBA==
X-Forwarded-Encrypted: i=1; AJvYcCUdwmozRm193xWR28cnH50HQ6YHt3IFFQ8zSMyiF+FY9HNDchAFpc/zvW8XFZpPT8+hV8FWsuM1ftqe3KbHcmUa@vger.kernel.org
X-Gm-Message-State: AOJu0YyYV4J/39RIXhdbYxhKMVrFydGWfsEeZREu74r5G/0XUAnnaWGA
	+UBLonFRvqRkjltT1qyh13qV1poyXYqt/gI7A/WKD+a/gQhuiscsvKIR1Us4RM9edDfzAxichwG
	sjqYPTNzjwCezvl8LnOOx4QTufJvESAqECoYuyoxl
X-Gm-Gg: AZuq6aLOa+0l/xqAuRc8wHI5rqw5CsaEX4R1YQX5wmWLYuW89Z0GU2v4GwbSjfRy6n7
	FYeKFw4Dvf3CvklyMD4eE9lYVRkjEg2a+f4d576PGa/jfTP4248UYUb+7F5tPIC05KDtKWdi3eV
	FMCa0Ilju0n1WaFfOg5m2zbfr5ItLwA7aI1qO1IvUuH6rPKoNZ3eYqwa8ukhvhKgfIzHQaFBkfl
	a9fAlI6BfrAUzScESzQRH385du4v/TzSAu41lXfCeXxPd326n1Z0v/o50yr9q2dzBd/SoD9
X-Received: by 2002:a17:903:2a84:b0:2a7:6ce1:17d8 with SMTP id
 d9443c01a7336-2a823c84be6mr2084075ad.0.1769283609871; Sat, 24 Jan 2026
 11:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com> <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
 <CAP-5=fWPpeLS2D_XgsyM5OYDvWkoTapSb0XfPu-K7ue31BCTCg@mail.gmail.com>
 <CAATMXfmz2BCAoRXFOgSMyLK+FEF=ac5g_ZabY2a8ie+ZYfHtrA@mail.gmail.com>
 <CAP-5=fXUsY7vypQ13d_ohcX35txfVf7sMu6KN8Rbz8=UUEA4bQ@mail.gmail.com> <CAATMXfnSp_O7+MPpVY3kXLTTJLLZos_TZzCmUaPimmyeyJnX-w@mail.gmail.com>
In-Reply-To: <CAATMXfnSp_O7+MPpVY3kXLTTJLLZos_TZzCmUaPimmyeyJnX-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 24 Jan 2026 11:39:58 -0800
X-Gm-Features: AZwV_QjRg_jHFFVrWgl2zE0oL8VOY3Ktsjaj2FYN4kkgMUBY3U0Pwmow9aimECo
Message-ID: <CAP-5=fW+a8om_NTFYobCnaw83j2_-AqcSPWgTbGuc0DtbgNbMw@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: Qiao Zhao <qzhao@redhat.com>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, namhyung@kernel.org, 
	mpetlan@redhat.com, acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 7:30=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Hi Ian,
>
> I stepped through the test in gdb as you suggested. The control flow matc=
hes your reasoning,
> but there are ARM-specific details that explain why rdpmc_supported ends =
up false.
>
> Here's what I observed in test_stat_user_read():
>  - Execution enters the saved_user_read_state =3D=3D USER_READ_UNKNOWN br=
anch
>  - In the failing cases, enabled is indeed USER_READ_ENABLED
>  - Execution reaches the line:
>    rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
>
> However, on this ARM system(Ampere, armv8_pmuv3_0), the perf_event_mmap_p=
age itself
> is not accessible from user space at runtime.
>
> Concretely, in gdb:
>  - pc is a non-NULL pointer (e.g. 0xfffff7ff3000)
>  - but attempts to read pc->cap_user_rdpmc or pc->index results in:
>    =E2=80=9CCannot access memory at address =E2=80=A6=E2=80=9D

Thanks for the detailed explanation again! I'm confused what, "Cannot
access memory at address ..." means. Is the program generating a
segfault, but then how is the value of pc->cap_user_rdpmc read? If the
mmap fails then the test should fail:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n281

Thanks,
Ian

>
> So although the kernel reports cap_user_rdpmc =3D 1 in the shared page la=
yout, the page backing "pc"
> is not actually readable by user space on this system. As a result, the e=
xpression pc->cap_user_rdpmc && pc->index
> effectively evaluates as false at runtime, and the test reports rdpmc as =
unsupported.
>
> This explains why the condition:
>   if (!rdpmc_supported && pc->cap_user_rdpmc)
> is reached, even though saved_user_read_state is USER_READ_UNKNOWN and en=
abled is USER_READ_ENABLED.
>
> In short, the mismatch seems to be between the reported rdpmc capability =
and the actual accessibility
> of the mmap page on ARM, rather than a control-flow issue in the test its=
elf.
>
> Please let me know if it would be useful for me to capture this with addi=
tional instrumentation.
>
> For reference, here are some gdb debug steps and outputs:
> ```
> ---- end ----
> 124.1: Read samples using the mmap interface                         : Ok
> --- start ---
> User space counter reading 1
> User space counter reading for PMU armv8_pmuv3_0
>
> Breakpoint 1, test_stat_user_read (event=3D1, enabled=3DUSER_READ_ENABLED=
) at tests/mmap-basic.c:298
> 298            if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> Missing rpms, try: dnf --enablerepo=3D'*debug*' install python3-libs-debu=
ginfo-3.12.12-2.el10_1.aarch64
> (gdb) continue
> Continuing.
> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsup=
ported counter access 1]
> ---- end ----
> 124.2: User space counter reading of instructions                    : FA=
ILED!
> --- start ---
> User space counter reading 0
> User space counter reading for PMU armv8_pmuv3_0
>
> Breakpoint 1, test_stat_user_read (event=3D0, enabled=3DUSER_READ_ENABLED=
) at tests/mmap-basic.c:298
> 298            if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> (gdb) n
> 299                rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
> (gdb) n
> 311                pr_err("User space counter reading for PMU %s [Failed =
unexpected unsupported counter access %d]\n",
> (gdb) info locals
> evsel =3D 0x930170
> err =3D 0
> rdpmc_supported =3D <optimized out>
> counts =3D {{{val =3D 0, ena =3D 0, run =3D 0, id =3D 0, lost =3D 0}, val=
ues =3D {0, 0, 0, 0, 0}}}
> saved_user_read_state =3D USER_READ_UNKNOWN
> attr =3D {type =3D 0, size =3D 0, config =3D 0, {sample_period =3D 0, sam=
ple_freq =3D 0}, sample_type =3D 0, read_format =3D 0, disabled =3D 0, inhe=
rit =3D 0, pinned =3D 0, exclusive =3D 0, exclude_user =3D 0, exclude_kerne=
l =3D 0,
>   exclude_hv =3D 0, exclude_idle =3D 0, mmap =3D 0, comm =3D 0, freq =3D =
0, inherit_stat =3D 0, enable_on_exec =3D 0, task =3D 0, watermark =3D 0, p=
recise_ip =3D 0, mmap_data =3D 0, sample_id_all =3D 0, exclude_host =3D 0,
>   exclude_guest =3D 0, exclude_callchain_kernel =3D 0, exclude_callchain_=
user =3D 0, mmap2 =3D 0, comm_exec =3D 0, use_clockid =3D 0, context_switch=
 =3D 0, write_backward =3D 0, namespaces =3D 0, ksymbol =3D 0, bpf_event =
=3D 0,
>   aux_output =3D 0, cgroup =3D 0, text_poke =3D 0, build_id =3D 0, inheri=
t_thread =3D 0, remove_on_exec =3D 0, sigtrap =3D 0, defer_callchain =3D 0,=
 defer_output =3D 0, __reserved_1 =3D 0, {wakeup_events =3D 0,
>     wakeup_watermark =3D 0}, bp_type =3D 0, {bp_addr =3D 2, kprobe_func =
=3D 2, uprobe_path =3D 2, config1 =3D 2}, {bp_len =3D 0, kprobe_addr =3D 0,=
 probe_offset =3D 0, config2 =3D 0}, branch_sample_type =3D 0, sample_regs_=
user =3D 0,
>   sample_stack_user =3D 0, clockid =3D 0, sample_regs_intr =3D 0, aux_wat=
ermark =3D 0, sample_max_stack =3D 0, __reserved_2 =3D 0, aux_sample_size =
=3D 0, {aux_action =3D 0, {aux_start_paused =3D 0, aux_pause =3D 0, aux_res=
ume =3D 0,
>       __reserved_3 =3D 0}}, sig_data =3D 0, config3 =3D 0, config4 =3D 0}
> pc =3D 0xfffff7ff3000
> mapped =3D true
> opened =3D true
> pmu =3D 0x923b50
> threads =3D 0x92c1d0
> ret =3D <optimized out>
> cleanup =3D <optimized out>
> (gdb) print saved_user_read_state
> $1 =3D USER_READ_UNKNOWN
> (gdb) print enabled
> $2 =3D USER_READ_ENABLED
> (gdb) print pc->cap_user_rdpmc
> Cannot access memory at address 0xfffff7ff3000
> (gdb) print pc->index
> Cannot access memory at address 0xfffff7ff300c
> (gdb) print rdpmc_supported
> $3 =3D <optimized out>
> (gdb) info args
> event =3D 0
> enabled =3D USER_READ_ENABLED
> ```
>
> Thanks,
> - Qiao
>
>
> On Sat, Jan 24, 2026 at 12:23=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
>>
>> On Fri, Jan 23, 2026 at 12:29=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wr=
ote:
>> >
>> > Hi Ian,
>> >
>> > Thanks for the follow-up questions. I've gathered some additional data
>> > from the affected ARM systems.
>> > Environment:
>> > - Architecture: ARM (aarch64)
>> > - CPU: Ampere(R) Altra(R) Processor Q80-30
>> > - Tested on both bare-metal and ARM KVM guests
>> > - Observed behavior is identical on bare-metal and KVM
>> > - This is not a heterogeneous / big.LITTLE system
>> > - perf version: 6.19.rc6.g053966c344db
>> >
>> > rdpmc sysfs:
>> > On these systems, there is no rdpmc attribute exposed under the PMU de=
vices:
>> > # grep . /sys/bus/event_source/devices/*/rdpmc
>> > grep: /sys/bus/event_source/devices/*/rdpmc: No such file or directory
>> >
>> > So the =E2=80=9Crestricted PMU access=E2=80=9D I referred to is not du=
e to toggling a
>> > visible rdpmc sysfs knob.
>> > From a user-space perspective, there is simply no rdpmc control file a=
vailable.
>> >
>> > PMU devices:
>> > The core PMU present is:
>> > # grep . /sys/bus/event_source/devices/*/type | grep armv8
>> > /sys/bus/event_source/devices/armv8_pmuv3_0/type:10
>> > (Other devices are DSU/CMN/DMC PMUs.)
>> >
>> > Virtualization:
>> > The same rdpmc behavior is observed when running under ARM KVM,
>> > so this does not appear to be virtualization-specific.
>> >
>> > Observed inconsistency:
>> > Even though perf_event_open() succeeds with .config1=3D0x2 on aarch64,
>> > and the mmap page report
>> > cap_user_rdpmc=3D1, user-space rdpmc access fails at runtime, which is
>> > what causes the test to treat
>> > rdpmc as unsupported.
>> >
>> > At this point, I agree the key issue seems to be the mismatch between
>> > the reported capability (cap_user_rdpmc)
>> > and the actual runtime behavior, rather than perf_event_open()
>> > failing. I don't yet have enough insight to say
>> > whether this is an ARM PMU driver capability-reporting issue or an
>> > incorrect test assumption, but hopefully the
>> > above data helps narrow it down.
>> >
>> > Please let me know if more details would be useful.
>>
>> That's pretty much every detail I could think to gather :-) I looked
>> on an Ampere machine and also noticed the rdpmc file is missing from
>> the  armv8_pmuv3_0 device. Perhaps James and Leo know about this?
>>
>> In the test we care about the values of rdpmc_supported and
>> pc->cap_user_rdpmc. The rdpmc_supported value comes from:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
.git/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n298
>> ```
>> if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
>> rdpmc_supported =3D pc->cap_user_rdpmc && pc->index;
>> else
>> rdpmc_supported =3D (enabled =3D=3D USER_READ_ENABLED);
>> ```
>> In the test in the commit message I believe enabled is
>> USER_READ_ENABLED and as the rdpmc file is missing I think
>> saved_user_read_state is USER_READ_UNKNOWN. That confuses me then as
>> "if (!rdpmc_supported && pc->cap_user_rdpmc) {" being true means that
>> rdpmc_supported should be false.
>>
>> Could you do me a favor and step through the test in gdb just to see
>> why rdpmc_supported is false?
>>
>> Thanks,
>> Ian
>>
>>  > Thanks,
>> > Qiao
>> >
>> > On Fri, Jan 23, 2026 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
>> > >
>> > > On Thu, Jan 22, 2026 at 7:11=E2=80=AFPM Qiao Zhao <qzhao@redhat.com>=
 wrote:
>> > > >
>> > > > Hi Kim, Ian,
>> > > >
>> > > > Do you mind reviewing this change?
>> > > >
>> > > > On Tue, Jan 20, 2026 at 5:05=E2=80=AFPM Qiao Zhao <qzhao@redhat.co=
m> wrote:
>> > > > >
>> > > > > On some platforms (e.g. ARM systems with restricted PMU access),=
 user space
>> > > > > PMU counters may be reported as supported but blocked at runtime=
. Failing
>> > > > > the mmap interface tests in this case is incorrect.
>> > > > >
>> > > > > [Test Log]
>> > > > > 124.2: User space counter reading of instructions               =
     : FAILED!
>> > > > > --- start ---
>> > > > > User space counter reading 0
>> > > > > User space counter reading for PMU armv8_pmuv3_0
>> > > > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpec=
ted unsupported counter access 1]
>> > > > > ---- end ----
>> > > > > 124.3: User space counter reading of cycles                     =
     : FAILED!
>> > > > > --- start ---
>> > > > > User space counter reading 1
>> > > > > User space counter reading for PMU armv8_pmuv3_0
>> > > > > User space counter reading for PMU armv8_pmuv3_0 [Failed unexpec=
ted unsupported counter access 1]
>> > > > > ---- end ----
>> > > > > [/Test Log]
>> > > > >
>> > > > > Skip the user counter mmap tests when runtime PMU access is not =
available,
>> > > > > while preserving failure for genuinely inconsistent states.
>> > > > >
>> > > > > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
>> > > > > ---
>> > > > >  tools/perf/tests/mmap-basic.c | 4 ++--
>> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > > > >
>> > > > > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mm=
ap-basic.c
>> > > > > index 3313c236104e..4881a641749b 100644
>> > > > > --- a/tools/perf/tests/mmap-basic.c
>> > > > > +++ b/tools/perf/tests/mmap-basic.c
>> > > > > @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, en=
um user_read_state enabled)
>> > > > >                 }
>> > > > >
>> > > > >                 if (!rdpmc_supported && pc->cap_user_rdpmc) {
>> > > > > -                       pr_err("User space counter reading for P=
MU %s [Failed unexpected unsupported counter access %d]\n",
>> > > > > +                       pr_debug("User space counter reading for=
 PMU %s is not supported (cap_user_rdpmc=3D%d), skipping!\n",
>> > > > >                                 pmu->name, pc->cap_user_rdpmc);
>> > > > > -                       ret =3D TEST_FAIL;
>> > > > > +                       ret =3D TEST_SKIP;
>> > >
>> > > Hi Qiao,
>> > >
>> > > It sounds like the ARM behavior is divergent from the Intel behavior=
,
>> > > but that said Intel hybrid rdpmc is known to be problematic. There's=
 a
>> > > fix for part of that which will hopefully land [1]. One weird thing =
on
>> > > Intel hybrid is that the rdpmc permission file within the PMU is kin=
d
>> > > of "shared" between all core PMUs, so disabling rdpmc on the e-core
>> > > PMU disables it on the p-core. In one iteration of this test tried t=
o
>> > > incorporate support for this. Anyway, ARM...
>> > >
>> > > So in the test we're doing:
>> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-=
next.git/tree/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n243
>> > > ```
>> > > #ifdef __aarch64__
>> > > .config1 =3D 0x2, /* Request user access */
>> > > #endif
>> > > ```
>> > > So 1 question is why the perf_event_open is succeeding with a reques=
t
>> > > user access bit set in the config in a system where this is blocked?
>> > >
>> > > I'm not sure on the support for the rdpmc file on ARM but it looks t=
o
>> > > be wired up:
>> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-=
next.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n324
>> > >
>> > > So in the test where you've changed it we've determined that rdpmc
>> > > shouldn't be supported but the shared page is saying the
>> > > cap_uesr_rdpmc is available. So is this an ARM PMU driver bug?
>> > > I wonder if the setting of cap_user_read:
>> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-=
next.git/tree/drivers/perf/arm_pmuv3.c?h=3Dperf-tools-next#n1615
>> > > should also be testing whether support has been disabled through the
>> > > rdpmc attribute? Hmm.. but x86 doesn't do that:
>> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-=
next.git/tree/arch/x86/events/core.c?h=3Dperf-tools-next#n2753
>> > >
>> > > So given that ARM and x86 look in sync, x86 doesn't have issues I'm
>> > > aware of, and it certainly looks like a failure inconsistency that t=
he
>> > > test thinks that user rdpmc support is disabled but the page says
>> > > otherwise. I could use more details to understand this, like what's
>> > > the contents of the rdpmc file? In your commit message, is the
>> > > restricted PMU access the rdpmc file or a different capability? Coul=
d
>> > > this be a weird hybrid/BIG.little issue like on x86?
>> > >
>> > > Thanks,
>> > > Ian
>> > >
>> > > [1] https://lore.kernel.org/lkml/24bc287a-a3e0-45f6-a8f1-20a34e2f9af=
2@linux.intel.com/
>> > >
>> > > > >                         goto cleanup;
>> > > > >                 }
>> > > > >
>> > > > > --
>> > > > > 2.49.0
>> > > > >
>> > > >
>> > >
>> >
>>
