Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D264C7C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136648; cv=none; b=BtTvNOt6cS9xasUKI8FjF22iWxoENg/rJbrrx/GhQTb1s8kFkpeThJgqWftjpTDeyh65KFaV9o001QX9tSL2zJBLwncIPdH9hSvGC1BRFemC0luL5iNMLzgtbVoMSM91fRV6QYjLPih4IS/2qzpox7fBe3keFYQ7hid+YrcXi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136648; c=relaxed/simple;
	bh=77c/I/O9ypPcVoUiTPxlcXfWBWvCeOg6jo/pvVdkiHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsKu9Dm13z7eit8OZfVD2c7caCVoNVV4c6vE3lDK5tG8dOD2wVaXYhpEBq571nJ7s84tC7Y17sOkoRySlQxFQ9kUfY4q+z0UJacKSz4usEFLXfhy8gY0dlK6qZtIvcB0zGbp6ezASrf79PJA0vvMxVkTOdbO/ST+7xOHIawZh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/ZV4KC4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/ZV4KC4"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so166025ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136646; x=1721741446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUFB2OkpxowXE7d1mjPyXdQnAb7sHtoIxKD0VjG4/Zk=;
        b=Y/ZV4KC4pPGGYM8EARkDwf9gt1uw6Iw1v/F+KxsQ7i3DqLrrFGtZHGN5eI4xqOKbSW
         8/SMyW2bPVzoVnmkSG+HwGsRDW1C1rPpGg40HZAQOneZDp9VTs4ZTre6TogBRqNW05UU
         OUsOIJm6MQGsOwBUwKCvUwVHSD6XRnJ23vanBhH31jUDrYs3QrEkcODK9whYhhzGeTCM
         yDOWljj7UrhIjk79JLMGrdatpktO85sWAs/yLaCvH0XlG9UW2uj/nAIudz5RjU2g3noj
         C7heGKHdGlmPRDOTHa2qS/boTY2E/FzWWxtAwgGLnESghztPzTWGpgrhDgQBALKnBgL5
         gy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136646; x=1721741446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUFB2OkpxowXE7d1mjPyXdQnAb7sHtoIxKD0VjG4/Zk=;
        b=vgSKIOk4zCy1PmKivAR3IUg+ruH6MaV3lOn4JqOATnXLu6jeBHToVDQcMzCvOgEX2d
         +l3hPUikbddAqZUBC1FPTDp5EL/bDls9XdwnDLkBz4ldiJVsGMxSxhXjZQj6hELWOEJD
         BMN8W0H2qT6XRR9NQAATW1r8Joc98i6e43tO9TOGjtOINd5B9ntPEpvHb13S0rvbYAKT
         gubhoHapnX8YZQh8ydBm0NN6x2rCdtyfuD0jwgAzYAws9MdZ8drzPr/B+iDZSea6WPFp
         Qpou/B5on3gTmp6ge9/uDhCQlR2tnUNrt8+bJVhZMjknrxLqLSUkfIYGFaomxapYbTzI
         QvfA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCUg1mkiejRhQHzCVW0R3ldY1+Y903I7rdhHqWQeZclITzUB8J3CSsRn/rPQdJI8aaalP/0fnNfJHSYKsVX5h4Nb0BRU537n3X45fW7+TVA==
X-Gm-Message-State: AOJu0YymVoOwK6lCKVWkXz+OHgJ/0+XkQdBH5hqtgYI/9B3dHybDkuaG
	PuKpDJ1PWTfKimLpsSl3srnrGRUgwp8HdHVHEtG3rCYTBkzqJ41yjIC7MFzQJdRwlYb614wo5zO
	r6+D4cOewTl39bal2u7z98b/OLeNMwbwQUAzL
X-Google-Smtp-Source: AGHT+IH+7PFoZHCpF0Hnak0mBX4nEsVu7wcSexmapZjJE7r70AVdcoJORgk6ypafcqH/vaYNfDgZjfs5Ph4nOk61umM=
X-Received: by 2002:a05:6e02:1b08:b0:375:cd76:1602 with SMTP id
 e9e14a558f8ab-393c1e1f3a7mr2935705ab.28.1721136645373; Tue, 16 Jul 2024
 06:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com> <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com> <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
 <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
 <f316e3ce-e1e3-45f0-ac78-9af590b58706@arm.com> <CAP-5=fU=LguHNi861L4gmgZWXrrgZtG1w5cdw7hXDxnfWyJyMQ@mail.gmail.com>
 <a17e6701-4195-4132-8518-fe4b10403f7e@arm.com>
In-Reply-To: <a17e6701-4195-4132-8518-fe4b10403f7e@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:30:31 -0700
Message-ID: <CAP-5=fVi8RJVokVBQtin8xSAq7uxN=GB7zcC4OiT=SzqWB+V0w@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>, clang-built-linux <clang-built-linux@googlegroups.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:06=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
>
>
> On 7/15/24 22:21, Ian Rogers wrote:
>
> [...]
>
> > Hmm.. I can repro but I don't see where the string comes from and my
> > build is definitely using clang:
> > ```
> > $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/perf
> > O=3D/tmp/perf NO_LIBELF=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBPYTHON=3D1 CC=3D=
clang
> > CXX=3Dclang++ V=3D1
> > ...
> > clang --target=3Daarch64-linux-gnu -fintegrated-as  -Wbad-function-cast
> > -Wdeclaration-after-statement -Wformat-security -Wformat-y2k
> > -Winit-self -Wmissing-declarations -Wmissing-prototypes
> > -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls
> > -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef
> > -Wwrite-strings -Wformat -Wno-type-limits -Wshadow -Wthread-safety
> > -DHAVE_SYSCALL_TABLE_SUPPORT -I/tmp/perf/arch/arm64/include/generated
> > -DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -DNDEBUG=3D1 -O3
> > -fno-omit-frame-pointer -Wall -Wextra -std=3Dgnu11 -fstack-protector-al=
l
> > -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -D_LARGEFILE64_SOURCE
> > -D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -I~/src/tools/perf/util/include
> > -I~/src/tools/perf/arch/arm64/include -I~/src/tools/include/
> > -I~/src/tools/arch/arm64/include/uapi -I~/src/tools/include/uapi
> > -I~/src/tools/arch/arm64/include/ -I~/src/tools/arch/arm64/
> > -I/tmp/perf//util -I/tmp/perf/ -I~/src/tools/perf/util
> > -I~/src/tools/perf -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
> > -DHAVE_PTHREAD_BARRIER -DHAVE_EVENTFD_SUPPORT
> > -DHAVE_GET_CURRENT_DIR_NAME -DHAVE_GETTID -DHAVE_FILE_HANDLE
> > -DHAVE_AIO_SUPPORT -DHAVE_SCANDIRAT_SUPPORT
> > -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT -DNO_LIBPERL
> > -DHAVE_TIMERFD_SUPPORT -DNO_LIBPYTHON -DHAVE_BACKTRACE_SUPPORT
> > -DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT
> > -I/tmp/perf/libapi/include -I/tmp/perf/libsubcmd/include
> > -I/tmp/perf/libsymbol/include -I/tmp/perf/libperf/include -I/tmp/perf/
> > -Wl,-z,noexecstack \
> >          /tmp/perf/perf-in.o -Wl,--whole-archive
> > /tmp/perf/libapi/libapi.a /tmp/perf/libperf/libperf.a
> > /tmp/perf/libsubcmd/libsubcmd.a /tmp/perf/libsymbol/libsymbol.a
> > /tmp/perf/libperf-bench.a /tmp/perf/libperf-test.a
> > /tmp/perf/libperf-ui.a /tmp/perf/libperf-util.a
> > /tmp/perf/libpmu-events.a  -Wl,--no-whole-archive -Wl,--start-group
> > -lpthread -lrt -lm -ldl -Wl,--end-group -o /tmp/perf/perf
> > $ strings /tmp/perf/perf|grep GCC
> > GCC: (Debian 13.2.0-13) 13.2.0
> > $ find /tmp/perf -name '*.[oa]' -exec sh -c "strings {} | grep GCC" \; =
-print
> > GCC: (Debian 13.2.0-13) 13.2.0
> > /tmp/perf/fixdep.o
> > GCC: (Debian 13.2.0-13) 13.2.0
> > /tmp/perf/fixdep-in.o
> > ```
> > fixdep is being compiled with HOSTCC which isn't clang. Some more diggi=
ng:
> > ```
> > $ aarch64-linux-gnu-readelf -p .comment /tmp/perf/perf
> >
> > String dump of section '.comment':
> >   [     0]  GCC: (Debian 13.2.0-13) 13.2.0
> >   [    1f]  Debian clang version 16.0.6 (20+build1)
> > ```
> > So I suspect that the GCC is coming from crt0.o and that the binary
> > was built with clang.
>
> Thanks for correcting. Now I even can build successfully with the Clang
> from Android NDK with an additional flag 'NO_DEMANGLE=3D1'. Though we sti=
ll
> need to disable several modules for passing the building, but we are on t=
he
> right way.
>
> Would you like to continue a formal fixing or you want me to follow up?

+clang-built-linux

If you could follow up it would be great! I'm not sure how we detect
in the build that we're using clang, I suspect there is an approach in
a different kernel Makefile/Build that already tackles this but my
quick searching didn't yield anything - perhaps the change would be
better suited to the location the CROSS_COMPILE prefix is added to
gcc. The only thing the change to Makefile.config is doing is
injecting the --target option. I'm not sure anything more is not
working for me on my laptop with this approach compared to cross
compiling with gcc, but as you say going in the right direction is
worth it anyway.

Thanks,
Ian
