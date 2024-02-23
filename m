Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFA1353EA
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Feb 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709745; cv=none; b=jvRd5hStcQ8/g3I39lrwsKmmeLDqlmYMQf3sgM75jHfUIxk8X012df4gqqF5+YJrov3dOzZhVKHXh4rmgNt7eG4OMJOwW8jCtE//o5QDHz0HRaiMmq7nfUwpMVpKf1zzJkQOkfQifpd3zJ5hAwLnyA5lP2ZMJAm7ORp2Rco59yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709745; c=relaxed/simple;
	bh=IkzSUsW28OdScgPZ3xaWRx9AYrLQrDS+wnNZDYXn/yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWFS6KlU4T97WjMZqnHtCj3ts7b0aOFlhT2X1CmgTCn5S6jnQTT+sFlCyrA5Fgi5iqY+f2MGKbMXgJSmOFirjT/VmIrFS2rmD48yhIHiILnSgdmmkudjHn9wmtoYW8R0nZvD8uSWp2h4gSvHgTU87VguQHTaKR5vHSpBXENQlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=B0PlCaAi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="B0PlCaAi"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso953931a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Feb 2024 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1708709741; x=1709314541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bG6kltsE57imWHJ/FJvS+n3D4X4xNnJDjhhmpS9a2A=;
        b=B0PlCaAiMFeZDoUtT4Hu8ReNQVb0cLbUWLBBtItUExe3yZ6oOMQow/KS+DHP6t4Xgg
         TUnw2Xh9QnvBLuHv/zL70szeA9E9vsc0f8rHqxpWYSqeWvzx6mOw39HWfd34GUCQsdqA
         smG5yQ/4wgJxVpF3HoOKr/wnePb+JoaONNNllsUi9wm645/Yzhq5V8PY+l0o72Mj+7ga
         iTtIsagk2LOqSzBPUMXHXxZv33cE8yev+zJE54NWDGuyEIcQpYaNtD4rzNojKrc2GxeQ
         hYxG2M1pBy/0TBixAy/ZxE3y727L8w6SPIyFC9lSiKpcwtcPLsebYv19qgmwtuUXaL6n
         rMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709741; x=1709314541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bG6kltsE57imWHJ/FJvS+n3D4X4xNnJDjhhmpS9a2A=;
        b=hdH0UMxrzKSd3LH+bWL+cJkK0If2c8uivX8gkdOToCC4brHB7WqeeZT8pHKACHlm6M
         pPmz1PaNfESEeEpdPu/e6fdiYErTetjZaBFE4tgv4f++jGvQ0duKz5UpNtqGyP8j81+P
         8pliN7w+iVbaSzmM1Z1URTccKONvOjis5i3LKqcFaRZogCwihBPcLqjXS1e+8dNsWSW3
         X2TiWLN3/7CTe/s0mM9fwKeLU9fYIXkZzZTN65oRXQrOfIaj0b2oGGQu8P6sBXYj/pV9
         zN/PqkMxJRbNwAaoDKGdR1CXfOPGCB5soOIDwb6dORwrSIFGUsVEQUHxDIA2E7FYGixI
         R2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9tOGYB54BkQAHz4m8fJEA1ZsUFl4qOKSijspYFTaZ3T6oG8ongNI9NJTMisCLhcN5SvEpBX0oWETyN+jlqgCwAqbdrW8qVijY5uWDTrpmQ==
X-Gm-Message-State: AOJu0YyzpgzOab4wt/vNzbk3m36m3tTjLkqTRaZMYRuy1DxUskgwxcSG
	8NidwY5l/Z4KNTw2vtylhwIjdPIF2lTSfH0JbTFtbF4IW2aV8DE+XtfGb9Nj1QjEW2FiYdSy0Q5
	lcRwwF+cIqgc/NVz2c2WUanJzBO1gmeeV1nHT
X-Google-Smtp-Source: AGHT+IEom2vLpZpTDGtlXwNKqRKxmXkYeFwCXGhP9GJXkL7HeeJ5jS1c/OHixG0hSAsCBqKPRs7V/AGztdjxXjostL8=
X-Received: by 2002:aa7:c318:0:b0:565:eb8:ed47 with SMTP id
 l24-20020aa7c318000000b005650eb8ed47mr293420edq.35.1708709741110; Fri, 23 Feb
 2024 09:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221175210.19936-1-khuey@kylehuey.com> <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com> <ZdemibZepMqWvv6U@x1>
In-Reply-To: <ZdemibZepMqWvv6U@x1>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 23 Feb 2024 09:35:29 -0800
Message-ID: <CAP045Aqc6woHGYKJG4d=x4gPd0=PmrLeFv25Rkts1a8xFuocOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kyle Huey <khuey@kylehuey.com>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:54=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Feb 22, 2024 at 09:55:36AM -0800, Kyle Huey wrote:
> > On Wed, Feb 21, 2024 at 10:36=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > > On Wed, Feb 21, 2024 at 9:52=E2=80=AFAM Kyle Huey <me@kylehuey.com> w=
rote:
> > > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > > +               goto cleanup;
> > > > +       }
>
> > > Thanks for the work! The perf tool and perf test should run on older
> > > kernels ideally without failure. I'm assuming this would fail on an
> > > older kernel. Could we make the return value skip in that case?
>
> > Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> > yes. It's not possible to distinguish between an older kernel and a
> > kernel where this fix broke (at least not without hardcoding in an
> > expected good kernel version, which seems undesirable), so that would
>
> Take a look at:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/tools/perf/tests/sigtrap.c?id=3D650e0bde43f35bb675e87e30f679a57cfa22e0e5
>
> To see how introspecting using BTF can be used to figure out if internal
> data structures have what is needed, or if functions with some specific
> arguments are present, etc, for sigtrap we have, in the patch above:
>
> -       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_TH=
READS * ctx.iterate_on);
> +       expected_sigtraps =3D NUM_THREADS * ctx.iterate_on;
> +
> +       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepable=
_spinlocks()) {
> +               pr_debug("Expected %d sigtraps, got %d, running on a kern=
el with sleepable spinlocks.\n",
> +                        expected_sigtraps, ctx.signal_count);
> +               pr_debug("See https://lore.kernel.org/all/e368f2c848d77fb=
c8d259f44e2055fe469c219cf.camel@gmx.de/\n");
> +               return TEST_SKIP;
> +       } else
> +               TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count=
, expected_sigtraps);
>
> And then:
>
> +static bool kernel_with_sleepable_spinlocks(void)
> +{
> +       const struct btf_member *member;
> +       const struct btf_type *type;
> +       const char *type_name;
> +       int id;
> +
> +       if (!btf__available())
> +               return false;
> +
> +       id =3D btf__find_by_name_kind(btf, "spinlock", BTF_KIND_STRUCT);
> +       if (id < 0)
> +               return false;
> +
> +       // Only RT has a "lock" member for "struct spinlock"
> +       member =3D __btf_type__find_member_by_name(id, "lock");
> +       if (member =3D=3D NULL)
> +               return false;
> +
> +       // But check its type as well
> +       type =3D btf__type_by_id(btf, member->type);
> +       if (!type || !btf_is_struct(type))
> +               return false;
> +
> +       type_name =3D btf__name_by_offset(btf, type->name_off);
> +       return type_name && !strcmp(type_name, "rt_mutex_base");
> +}
>
> > mean the test would always return ok or skip, not ok or fail. Is that
> > ok?
>
> It should return:
>
> Ok if the kernel has what is needed and the test passes
> Skip if the test fails and the kernel doesn't have what is needed
> FAIL if the test fails and the kernel HAS what is needed.
>
> 'perf test sigtrap' also checks for the presence of the feature it
> requires:
>
> static bool attr_has_sigtrap(void)
> {
>         int id;
>
>         if (!btf__available()) {
>                 /* should be an old kernel */
>                 return false;
>         }
>
>         id =3D btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_ST=
RUCT);
>         if (id < 0)
>                 return false;
>
>         return __btf_type__find_member_by_name(id, "sigtrap") !=3D NULL;
> }
>
>         fd =3D sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloe=
xec_flag());
>         if (fd < 0) {
>                 if (attr_has_sigtrap()) {
>                         pr_debug("FAILED sys_perf_event_open(): %s\n",
>                                  str_error_r(errno, sbuf, sizeof(sbuf)));
>                 } else {
>                         pr_debug("perf_event_attr doesn't have sigtrap\n"=
);
>                         ret =3D TEST_SKIP;
>                 }
>                 goto out_restore_sigaction;
>         }
>
> - Arnaldo

I think perhaps I'm barking up the wrong tree here. This seems like a
ton of work just to write a regression test. Maybe I should be doing
this in tools/testing/selftests instead?

- Kyle
