Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10118D63E
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746112419; cv=none; b=J0VPEtONMyYiGDJdOba9SyeQ4lfqadq0hpaBxlR19cf+2ji5Djpc4WSGJwqwEajm6rD8ja9tJAaj8G/Cy1ZQCYZw/cFWXp6XXA1QJ5Mnu7iruVhIm1o1IIKcMoP08zl+wKVv86ruiwXxMpLqi66WGhQSqo/RrmtzX+E0f2ake74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746112419; c=relaxed/simple;
	bh=OzBrloBm/V4YW3Mg4aldVmjhnsv5beIgJRxQgna75gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxTNgBXHcs8m+6aHbmiKDMDBNMOlp8ZIpERDXD3uUemGdrSRtjqn9QiddEJrDL8OrBsYI0cDqoF1IQViYHodGMvycV7zXMuxqH/R9Tnh9/VvyRT2RIEKwOwRMBppnb2kbUQ9hgy6zINiaEr140mN5+PwXMgRLaQmqw2Y6l6Bnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cutb4Rp1; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cutb4Rp1"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so198385ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746112417; x=1746717217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85n8jESwrmid0ZkoomIHFt8MZy/m9sXudOknYqK+2nQ=;
        b=cutb4Rp1hOWIKsyuzdh8lkWLmPeXs7P1t3e6oj/kqOjq5thSkZ6Ua88RE+ijqlNw0q
         C/tfYHu8r59YBMeg/Q+q8ca/whRxjKsdKqcFwS355vh9s/Vf17ivDVlup8FUTUJ/Sl6C
         92ilnjmPCkwrk4XBvYlxAV/iDtvu/V3LLB7RNamgLqdmHma4HoWvlBuWPk3iONeljGZc
         QZON39XlMBejmvjHe6TQmCQo9IakhYFWJ1sjmFKgXqpqfehtvnl0gcHLIxLxLpZl0xmc
         3ZsWJ/w1C6GPfn0Ek3JW6plNWP0EA488BLQDnrN7ApF21DTebUciGrfnTnQO0DUE/CeP
         jlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746112417; x=1746717217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85n8jESwrmid0ZkoomIHFt8MZy/m9sXudOknYqK+2nQ=;
        b=Oq7jMG/6wFNgmncxkj+xIgp/hsTLN/U4VSY4Ji7e1I+Q4Ga+Jo4f59aBAIp70vdJMI
         LQdhxi7dqhwo7lfzAeWLJljsP0jNONZWp29J0SaLywYJyIe+d1rpC9NGCGEvWC1xQ4UX
         DK9A6Xr8ev9kER7b7wApb6nB2vsJ7rdbJmokf1Xc4S9LAPnbKiB4iRo7hwCJa5hahUd5
         Y+rP0+LUxIK0fy6c5tKEbT/tajG466P6RBsbCNFvaZPEEo45jAcilZX7IF/DTHdWUPdr
         0WmUd78mOQG3toe6Y6JvjFvIRq5Dy37IYcH0s2KCYiZTB2xplSeZimqeBGDVfOgOXpZE
         2Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCWPJ4k/ztX6w/pWImgu2fjdLJNBJE4+E0WhYYZ0RGPBn/snNPK5tpfWMveWexYObOQdYJ+aHdZjeE0pmvRoOhBK@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2tE1vDmT/eCKO6H2xTy32zOeqisgAAa/1AnGImO6pkeOhv3x
	f9/zZFXthXYJxerUGNvi4OdhBH/k6hRneDJ3Q/vyVgaIBrbxAhphoDukm6YZBhi7PWabo98+e3v
	COmMjcr2WNbFLlqziMjeNpijI/Es8jbNppblo
X-Gm-Gg: ASbGncuQBqL/A036yKe4nUn17HrdfU07ye8+rb+ZZuGDxcph9w8f7kh+xxDEydGQRUO
	gRkFGVOhL6tE5Ec538yFjdWMBtfISYuLEtaeT5E1T5GNuL2roJUSn7iTiKSAFzPDdaf3deM2fhr
	or/mH6H7Yba2uVEjXNARU5TY43fixZiyPbv+GD14GjUa6VxHZlew==
X-Google-Smtp-Source: AGHT+IH/g13hY6mqTd3V9Dy+QXZ9IB5wT6d8KsQH0XFcUwB04paWY/i6fjQ4kjZss6cp+maGmlgLVAnvbwLlEzuqRaM=
X-Received: by 2002:a05:6e02:2291:b0:3d3:d1f9:4ccd with SMTP id
 e9e14a558f8ab-3d970170975mr2263245ab.9.1746112416703; Thu, 01 May 2025
 08:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501022809.449767-1-howardchu95@gmail.com>
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 May 2025 08:13:25 -0700
X-Gm-Features: ATxdqUE--wiAak5qnAOvXKfkOPQBHA5JKIS-hip6kd_XcccmZxR4MlNxNOM__EY
Message-ID: <CAP-5=fVHo5sYSHoxzRgC7poszLS5x4H3Cy5NsUTB8tH+n3L6Ww@mail.gmail.com>
Subject: Re: [PATCH v16 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gautam@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 7:28=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
>
> Currently, off-cpu samples are dumped when perf record is exiting. This
> results in off-cpu samples being after the regular samples. This patch
> series makes possible dumping off-cpu samples on-the-fly, directly into
> perf ring buffer. And it dispatches those samples to the correct format
> for perf.data consumers.
>
> Before:
> ```
>      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  fff=
fffff90d2e8aa record_times+0xa ([kernel.kallsyms])
>             perf  770116 [001] 27981.041375:          1    cycles:P:  fff=
fffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041377:          1    cycles:P:  fff=
fffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041379:      51611    cycles:P:  fff=
fffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
>      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  fff=
fffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
>      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  fff=
fffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
>
> sshd  708098 [000] 18446744069.414584:     286392 offcpu-time:
>             79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
>             585690935cca [unknown] (/usr/bin/sshd)
> ```
>
> After:
> ```
>             perf  774767 [003] 28178.033444:        497           cycles:=
P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
>             perf  774767 [003] 28178.033445:     399440           cycles:=
P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
>          swapper       0 [001] 28178.036639:  376650973           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>          swapper       0 [003] 28178.182921:  348779378           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time:
>             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
>             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
>             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
>             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
>             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
>             7fff24e862d8 [unknown] ([unknown])
>
>
>     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time:
>             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
>             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
>             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
>             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
>             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
>             7fff24e862d8 [unknown] ([unknown])
>
>
>          swapper       0 [000] 28178.463253:  195945410           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>      dbus-broker     412 [002] 28178.464855:  376737008           cycles:=
P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> ```

Tested-by: Ian Rogers <irogers@google.com>

and in the process coming across:
https://lore.kernel.org/lkml/20250501070003.22251-1-irogers@google.com/

Thanks for persisting with this, we're past the 1 year milestone:
https://lore.kernel.org/linux-perf-users/20240424024805.144759-1-howardchu9=
5@gmail.com/

Thanks!
Ian

> Changes in v16:
>  - Add Tested-by from Gautam and Acked-by from Namhyung.
>  - Rebase on the perf-tools-next branch.
>  - Edit the commit message of patch 10.
>  - Fix a bug caused by the type change of struct perf_cpu.
>  - Rename test_offcpu_over_thresh() to test_offcpu_above_thresh().
>
> Changes in v15:
>  - Fix workload recording bug pointed out by Arnaldo.
>  - Rename struct stack to struct __stack as suggested by Arnaldo.
>  - Delete the extra offcpu workload now that recording workload is fixed,
>    use 'sleep 1' for testing instead.
>  - Add more tests for the off-cpu-thresh option.
>
> Changes in v14:
>  - Change the internal off_cpu_thresh_us to off_cpu_thresh_ns, i.e. use
>    nsec instead of usec
>
> Changes in v13:
>  - Move the definition of 'off_cpu_thresh_ns' to the same commit as
>    dumping off-cpu samples in BPF, and give off_cpu_thresh_ns a default
>    value before the --off-cpu-thresh option is parsed.
>
> Changes in v12:
>  - Restore patches' bisectability, because the ordering of patches has
>    changed.
>  - Change 'us =3D ms * 1000' to 'us =3D ms * USEC_PER_MSEC'
>
> Changes in v11:
>  - Modify the options used in the off-cpu tests, as I changed the unit
>    of the off-cpu threshold to milliseconds.
>
> Changes in v10:
>  - Move the commit "perf record --off-cpu: Add --off-cpu-thresh option"
>    to where the direct sample feature is completed.
>  - Make --off-cpu-thresh use milliseconds as the unit.
>
> Changes in v9:
>  - Add documentation for the new option '--off-cpu-thresh', and include
>    an example of its usage in the commit message
>  - Set inherit in evsel__config() to prevent future modifications
>  - Support off-cpu sample data collected by perf before this patch series
>
> Changes in v8:
>  - Make this series bisectable
>  - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF)
>    to offcpu_thresh_ns for clarity
>  - Add commit messages to 'perf evsel: Expose evsel__is_offcpu_event()
>    for future use' commit
>  - Correct spelling mistakes in the commit message (s/is should be/should=
 be/)
>  - Add kernel-doc comments to off_cpu_dump(), and comments to the empty
>    if block
>  - Add some comments to off-cpu test
>  - Delete an unused variable 'timestamp' in off_cpu_dump()
>
> Changes in v7:
>  - Make off-cpu event system-wide
>  - Use strtoull instead of strtoul
>  - Delete unused variable such as sample_id, and sample_type
>  - Use i as index to update BPF perf_event map
>  - MAX_OFFCPU_LEN 128 is too big, make it smaller.
>  - Delete some bound check as it's always guaranteed
>  - Do not set ip_pos in BPF
>  - Add a new field for storing stack traces in the tstamp map
>  - Dump the off-cpu sample directly or save it in the off_cpu map, not bo=
th
>  - Delete the sample_type_off_cpu check
>  - Use __set_off_cpu_sample() to parse samples instead of a two-pass pars=
ing
>
> Changes in v6:
>  - Make patches bisectable
>
> Changes in v5:
>  - Delete unnecessary copy in BPF program
>  - Remove sample_embed from perf header, hard code off-cpu stuff instead
>  - Move evsel__is_offcpu_event() to evsel.h
>  - Minor changes to the test
>  - Edit some comments
>
> Changes in v4:
>  - Minimize the size of data output by perf_event_output()
>  - Keep only one off-cpu event
>  - Change off-cpu threshold's unit to microseconds
>  - Set a default off-cpu threshold
>  - Print the correct error message for the field 'embed' in perf data hea=
der
>
> Changes in v3:
>  - Add off-cpu-thresh argument
>  - Process direct off-cpu samples in post
>
> Changes in v2:
>  - Remove unnecessary comments.
>  - Rename function off_cpu_change_type to off_cpu_prepare_parse
>
> Howard Chu (10):
>   perf evsel: Expose evsel__is_offcpu_event() for future use
>   perf record --off-cpu: Parse off-cpu event
>   perf record --off-cpu: Preparation of off-cpu BPF program
>   perf record --off-cpu: Dump off-cpu samples in BPF
>   perf evsel: Assemble offcpu samples
>   perf record --off-cpu: Disable perf_event's callchain collection
>   perf script: Display off-cpu samples correctly
>   perf record --off-cpu: Dump the remaining samples in BPF's stack trace
>     map
>   perf record --off-cpu: Add --off-cpu-thresh option
>   perf test: Add direct off-cpu tests
>
>  tools/perf/Documentation/perf-record.txt |   9 ++
>  tools/perf/builtin-record.c              |  33 +++++++
>  tools/perf/builtin-script.c              |   4 +-
>  tools/perf/tests/shell/record_offcpu.sh  |  71 ++++++++++++++
>  tools/perf/util/bpf_off_cpu.c            | 119 ++++++++++++++---------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c   |  98 ++++++++++++++++++-
>  tools/perf/util/evsel.c                  |  41 +++++++-
>  tools/perf/util/evsel.h                  |   2 +
>  tools/perf/util/off_cpu.h                |   3 +-
>  tools/perf/util/record.h                 |   1 +
>  10 files changed, 324 insertions(+), 57 deletions(-)
>
> --
> 2.45.2
>
