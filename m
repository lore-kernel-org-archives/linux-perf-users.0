Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA05200123
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517722; cv=none; b=AshRx+tWGDdImh05FBrvtDhlWehloJF2NHCzl4BC6j8A7QLisS/Qf+XjgA6ZlJviMl/Ld707SEeNh3xj5Z4PVhhq5jWyvWXddBK60uyDPvf9EQPRiojB6/81N3v4JiFUqQ9LuQ63OqGf1X+HOqTQTFodu7Wk3MZpz2+AcaKzWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517722; c=relaxed/simple;
	bh=cQsGTZcrOBBUd6hSph+IuA54uYan2S+TEuuXq3VP3Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLr5kgIxJxaB+K/28bhiM2M5/3TKP/Gl9tu8teDFfunQyrcFgAIty6WmyRNXca9WtjrbIJ3wkBNLdu/aWWh9LcRZjIVeeBi2TJ1GHkDPdoZXGGxSaE/Mb026rSznyB1KZKVQ3YVKA/xU2Cnpzw7bGQb2Y/VlEvmH8Y4oewbOEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSciTCvF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSciTCvF"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a716d74c28so205675ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731517718; x=1732122518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efPx/rLhNWT0p7ckeK3W5qQ7h3QoMhdds0m323Mk+cg=;
        b=nSciTCvFF+DkbT9enNXgtMigcejg74P7K2Fj/n8xzPxzSqQlut4e3n/VrqB6mDRYtr
         oQRkTN0GsWGObU9WqvShEymLM6EMqlNgv3J2PAkrvuIfOyFCRQXvihwEqzNpamExjcfp
         Zwnc2t1f4jZhokUpInlV7QjU/Pdkp5Eb//PjfZTy5q2i6veykU5rYgHliAepL938Kxj/
         eLriH+FfGMsKdRNQxMKF8VR8WRsMjF47faJ6gUHVOh9IH78hZ2LevC0DPnfatyfBZYkj
         ShvLTVGCdLjs/aZ1ochmaoVnXNMhy3IhebOQZvm69WJ6vVfFVOAFstFHtW2x9xCBtUdH
         uD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517718; x=1732122518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efPx/rLhNWT0p7ckeK3W5qQ7h3QoMhdds0m323Mk+cg=;
        b=ZIUAGpOBJCbj0S2ehgUpBN2oOaTUojm4z+45Pe8D5lXDVX9KuLIyicDOUBnS5+LhNN
         h/X+vrltse6BQq2xSQBxdN0MaYpf4rJoct2Drb/ZyQQaZ1DNbbChOGz/J2TLR6uTI3mG
         SPVWilaf80EBhEUVAMMWgvjgySeyfb+xcgDnuJrXZEyHkJPMq/UTmrLcUk7Ny9hV9WJL
         t6mIP9BSdmKAa4uCHrP17+xzgxVcBaUhcBZPFzaOrhbaEWTFN2PkQg4aI5XGX+/amr57
         9PeF2CP6RKnF80cKo1UKQeG8/Fji5oWubQYgvVuGv4fKJEeRbMq+n909wkIux2y/Ade3
         IHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjHUmVTqM5+68x8hPEuFEBCq3qxvyW6Qlmqh30wYcNp1qHx40/wNOVJOQRR1d+5Uj+NJKIj18RvtTGtdVyZj7k@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YTaigW7bFxYywhN0UJJE/v31zBy0FuuUMp3Bpk1K6k/qxufR
	TLd9taXMIJNmEhwnds8Vjxha0chKIM3lkAhtsAVev3+Qf21B4UkypnPr3Fc30Xyne2nCLtOiOsU
	OgQLkwSdEc+n5XmnolwGSBmGfft6XlDmAzu4J
X-Gm-Gg: ASbGnctJNr0W4aeqvt6hfMRdPDm9I7xud+ESFb/Z2YSLUm17KQLfOc6F6nGzUvtT44X
	AyBLXM80fJNPyBZiTdIJlL4Qtb/wKV++FCPTFoc6F+7TvL9rKfxUUIZkGIZX/0w==
X-Google-Smtp-Source: AGHT+IENl/HhrSGg6ayb+SYQqQWEcvFTpM6KWv4E3CK00xq+RLT7X9+gY3HQZkVKedGyMwAxWPCNdzPB3i88SqunoAE=
X-Received: by 2002:a05:6e02:188c:b0:39a:fa27:f25 with SMTP id
 e9e14a558f8ab-3a715be708cmr4612425ab.22.1731517718370; Wed, 13 Nov 2024
 09:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113002818.3578645-1-howardchu95@gmail.com>
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 09:08:25 -0800
Message-ID: <CAP-5=fXCxSKgbe141mgo--taFa=-L=Oe9o7hHrjC4rj-eAP57w@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:28=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Changes in v8:
>  - Make this series bisectable
>  - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF)
>    to offcpu_thresh_ns for clarity.
>  - Add commit messages to 'perf evsel: Expose evsel__is_offcpu_event()
>    for future use' commit
>  - Correct spelling mistakes in the commit message (s/is should be/should=
 be/)
>  - Add kernel-doc comments to off_cpu_dump(), and comments to the empty
>    if block
>  - Add some comments to off-cpu test
>  - Delete an unused variable 'timestamp' in off_cpu_dump()

I spotted a few issues in v7, but v8 looks good to me.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

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
> v1:
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
>
> Howard Chu (10):
>   perf record --off-cpu: Add --off-cpu-thresh option
>   perf evsel: Expose evsel__is_offcpu_event() for future use
>   perf record --off-cpu: Parse off-cpu event
>   perf record --off-cpu: Preparation of off-cpu BPF program
>   perf record --off-cpu: Dump off-cpu samples in BPF
>   perf evsel: Assemble offcpu samples
>   perf record --off-cpu: Disable perf_event's callchain collection
>   perf script: Display off-cpu samples correctly
>   perf record --off-cpu: Dump the remaining samples in BPF's stack trace
>     map
>   perf test: Add direct off-cpu test
>
>  tools/perf/builtin-record.c             |  26 ++++++
>  tools/perf/builtin-script.c             |   4 +-
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/shell/record_offcpu.sh |  35 ++++++-
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/workloads/Build        |   1 +
>  tools/perf/tests/workloads/offcpu.c     |  16 ++++
>  tools/perf/util/bpf_off_cpu.c           | 117 ++++++++++++++----------
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  |  97 +++++++++++++++++++-
>  tools/perf/util/evsel.c                 |  34 ++++++-
>  tools/perf/util/evsel.h                 |   2 +
>  tools/perf/util/off_cpu.h               |   3 +-
>  tools/perf/util/record.h                |   1 +
>  13 files changed, 282 insertions(+), 56 deletions(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
>
> --
> 2.43.0
>
