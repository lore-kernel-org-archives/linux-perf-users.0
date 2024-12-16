Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5981D5143;
	Mon, 16 Dec 2024 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382179; cv=none; b=qBd7efNshVigLBe72Sb0U67PjlqaTzNC5gzvMUpip3EcRSAq39IoItgr9FZhXQhO8JpYNBIScYRJJ/SJGJ4/1BaiUkgMFyPoFba3/XZKw/r+3PZnuOLh5DvQKlwtdFUSyCoFsBeLb5b/1MgK4tQM5ZBO19a7ncT9I2TjEEiOwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382179; c=relaxed/simple;
	bh=n9ulvsmUC9k5IJkZLqvZDBDU4H6agLNQgyvQeaCXdm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPOMoiYarl2O37ExdBqMTxxnAC3bq4reWUBuXdc6IF9m+XesncMwLA+w78L4mEuL0XeQbbXKVvlTDGOND3kMsFJp4SvBU3LoXxi0kBPABUxcMSQTUkrCCmbe5kRpcYS5pqV5nfbuCjzX2YRtGiCjYjNaspGOFzf5ZBAnocurKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2u0NqiQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2u0NqiQ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso3409299276.1;
        Mon, 16 Dec 2024 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734382177; x=1734986977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7oTAHMQvZbjU7SvZjb0cVf1Hc0rvlKq0NXnplaF0UQ=;
        b=P2u0NqiQQH1wDLjNr4yDkdk+8FbqTBb4f0ti75cvjhh1yBzYHngqZK1HqC9WAX/o03
         UeCz7Yhlt7X2+KSksgrBbCvKlqFNBMK/4Nd/zyGxFPJNOvFf+V5b4MpVziubmSUlmLL1
         7+hw1AZA7rw8u7ffya7dkiXvHTqyhtHCi/h3wTic+WE/fNAEIOhu17/W3sp+E5n7KzB/
         HmjQiJU+rWVAA+dllqVa85Gq0Zc2S2kizF9jSkDyCsHc8Y4RufWTGyri2o9d6cCGSHFc
         EbRs8xsODcZMApDI8YacHWsgOzp5RhQ+cuWWVsTBRhB877Ohr1kw4vnPg8UmXwAiHpEU
         lBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382177; x=1734986977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7oTAHMQvZbjU7SvZjb0cVf1Hc0rvlKq0NXnplaF0UQ=;
        b=B0Ks17NUv2vZirLh9BlROTWVzAbB6XHJFdwd2xsW4yfKO2XoE+I6AD3YLPK2lX+cKR
         RzeGzAt2kPyv5nrDKtzjp7MxKjTI27kSCy5VRa14MHhghgDY+UoS9CDd/BOAOf42RlWi
         7k8cVWsC9F10KQCKvaKkULTMr99vpd+jnhceu16ffTb6DMwHLQOfSFrVRRmJLS+c70m1
         dNwvk1TrPBQs+PpcEKnIilECd5zcxZRa4Qcnut61Rh1FTx+dcv/5b2LGC/7Dq3AfeVG+
         Qv9QP4D6JL7RW58IzvbPbZXLjTzSm7JmbcVcz0028FH8Jbe2woSbC++FDJsOt4CJ99JP
         F9mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9tZjyKFYlDgnqRo/+ADJwW1GAdVCfPiSQmiIn+/y+CncLKsu4N4CElxyE5nQMjL6rHEm2eaq48olyX6k=@vger.kernel.org, AJvYcCWFdYmZHgtIIw3VLrZePmWBJogQLZzsNPwfRwYeaCuyFwfOwVq5gce5hULciUm3NzS337RKKHekdboEyuLroOgfeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymgYw5dHE63pbkbQvkPrJ4QgjWJ7g/TLsMFhLahKCmKJeOIM0s
	/oMh4HiZDFXxD4qx6zdP4PBEYb9P9K03BQsEySwCXHg0tcB2Yjh89Pp9V1UsT1Cl228GaNrBUZL
	VbmnLXELT4jcEbdGZ/FlIsmG1aMeMmzAAOio=
X-Gm-Gg: ASbGnctZLT6tKNGIq58SAmWnNIBsqf9uxBMXMtwM0oCvS4fe4j4bvyPfTNjeX70dRcR
	PYHLV/fcuoHnE/12vIAcxtafTBK4PZGhd/TkL
X-Google-Smtp-Source: AGHT+IHegVfZHCkodYAn/J51+94oBonHbt1sV8uWfubd2SSByxXctDPh3v0JvJC0v3+WOrSXkLUm/mDvQ+ZpOrzUHS0=
X-Received: by 2002:a05:6902:2081:b0:e4a:9ab:6ac7 with SMTP id
 3f1490d57ef6-e4a09ab70c3mr7237981276.41.1734382177058; Mon, 16 Dec 2024
 12:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215181220.754822-1-howardchu95@gmail.com> <Z2CJW0vFT005gmIe@google.com>
In-Reply-To: <Z2CJW0vFT005gmIe@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 16 Dec 2024 12:49:26 -0800
Message-ID: <CAH0uvogp4GB6ZkB=79wCNVtOhsGw-aofzGmW6nPc--b=g-D9OQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Mon, Dec 16, 2024 at 12:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sun, Dec 15, 2024 at 10:12:10AM -0800, Howard Chu wrote:
> > Changes in v14:
> >  - Change the internal off_cpu_thresh_us to off_cpu_thresh_ns, i.e. use
> >    nsec instead of usec
> >
> > Changes in v13:
> >  - Move the definition of 'off_cpu_thresh_ns' to the same commit as
> >    dumping off-cpu samples in BPF, and give off_cpu_thresh_ns a default
> >    value before the --off-cpu-thresh option is parsed.
> >
> > Changes in v12:
> >  - Restore patches' bisectability, because the ordering of patches has
> >    changed.
> >  - Change 'us =3D ms * 1000' to 'us =3D ms * USEC_PER_MSEC'
> >
> > Changes in v11:
> >  - Modify the options used in the off-cpu tests, as I changed the unit
> >    of the off-cpu threshold to milliseconds.
> >
> > Changes in v10:
> >  - Move the commit "perf record --off-cpu: Add --off-cpu-thresh option"
> >    to where the direct sample feature is completed.
> >  - Make --off-cpu-thresh use milliseconds as the unit.
> >
> > Changes in v9:
> >  - Add documentation for the new option '--off-cpu-thresh', and include
> >    an example of its usage in the commit message
> >  - Set inherit in evsel__config() to prevent future modifications
> >  - Support off-cpu sample data collected by perf before this patch seri=
es
> >
> > Changes in v8:
> >  - Make this series bisectable
> >  - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF=
)
> >    to offcpu_thresh_ns for clarity
> >  - Add commit messages to 'perf evsel: Expose evsel__is_offcpu_event()
> >    for future use' commit
> >  - Correct spelling mistakes in the commit message (s/is should be/shou=
ld be/)
> >  - Add kernel-doc comments to off_cpu_dump(), and comments to the empty
> >    if block
> >  - Add some comments to off-cpu test
> >  - Delete an unused variable 'timestamp' in off_cpu_dump()
> >
> > Changes in v7:
> >  - Make off-cpu event system-wide
> >  - Use strtoull instead of strtoul
> >  - Delete unused variable such as sample_id, and sample_type
> >  - Use i as index to update BPF perf_event map
> >  - MAX_OFFCPU_LEN 128 is too big, make it smaller.
> >  - Delete some bound check as it's always guaranteed
> >  - Do not set ip_pos in BPF
> >  - Add a new field for storing stack traces in the tstamp map
> >  - Dump the off-cpu sample directly or save it in the off_cpu map, not =
both
> >  - Delete the sample_type_off_cpu check
> >  - Use __set_off_cpu_sample() to parse samples instead of a two-pass pa=
rsing
> >
> > Changes in v6:
> >  - Make patches bisectable
> >
> > Changes in v5:
> >  - Delete unnecessary copy in BPF program
> >  - Remove sample_embed from perf header, hard code off-cpu stuff instea=
d
> >  - Move evsel__is_offcpu_event() to evsel.h
> >  - Minor changes to the test
> >  - Edit some comments
> >
> > Changes in v4:
> >  - Minimize the size of data output by perf_event_output()
> >  - Keep only one off-cpu event
> >  - Change off-cpu threshold's unit to microseconds
> >  - Set a default off-cpu threshold
> >  - Print the correct error message for the field 'embed' in perf data h=
eader
> >
> > Changes in v3:
> >  - Add off-cpu-thresh argument
> >  - Process direct off-cpu samples in post
> >
> > Changes in v2:
> >  - Remove unnecessary comments.
> >  - Rename function off_cpu_change_type to off_cpu_prepare_parse
> >
> > v1:
> >
> > As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
> >
> > Currently, off-cpu samples are dumped when perf record is exiting. This
> > results in off-cpu samples being after the regular samples. This patch
> > series makes possible dumping off-cpu samples on-the-fly, directly into
> > perf ring buffer. And it dispatches those samples to the correct format
> > for perf.data consumers.
> >
> > Before:
> > ```
> >      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  f=
fffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041375:          1    cycles:P:  f=
fffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041377:          1    cycles:P:  f=
fffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
> >             perf  770116 [001] 27981.041379:      51611    cycles:P:  f=
fffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
> >      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  f=
fffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
> >      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  f=
fffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
> >
> > sshd  708098 [000] 18446744069.414584:     286392 offcpu-time:
> >           79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
> >           585690935cca [unknown] (/usr/bin/sshd)
> > ```
> >
> > After:
> > ```
> >             perf  774767 [003] 28178.033444:        497           cycle=
s:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
> >             perf  774767 [003] 28178.033445:     399440           cycle=
s:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
> >          swapper       0 [001] 28178.036639:  376650973           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >          swapper       0 [003] 28178.182921:  348779378           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time:
> >           7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> >           7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> >           7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
> >           7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
> >           7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> >           7fff24e862d8 [unknown] ([unknown])
> >
> >
> >     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time:
> >           7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
> >           7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
> >           7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
> >           7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
> >           7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
> >           7fff24e862d8 [unknown] ([unknown])
> >
> >
> >          swapper       0 [000] 28178.463253:  195945410           cycle=
s:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
> >      dbus-broker     412 [002] 28178.464855:  376737008           cycle=
s:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> > ```
> >
> > Howard Chu (10):
> >   perf evsel: Expose evsel__is_offcpu_event() for future use
> >   perf record --off-cpu: Parse off-cpu event
> >   perf record --off-cpu: Preparation of off-cpu BPF program
> >   perf record --off-cpu: Dump off-cpu samples in BPF
> >   perf evsel: Assemble offcpu samples
> >   perf record --off-cpu: Disable perf_event's callchain collection
> >   perf script: Display off-cpu samples correctly
> >   perf record --off-cpu: Dump the remaining samples in BPF's stack trac=
e
> >     map
> >   perf record --off-cpu: Add --off-cpu-thresh option
> >   perf test: Add direct off-cpu test
>
> Thanks for your work and the persistence.

I think you misspelled 'procrastination' :). All jokes aside, thank
you for the reviews=E2=80=94it=E2=80=99s much harder on your side.

Thanks,
Howard

>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
