Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EC1925AC;
	Tue, 27 Aug 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779544; cv=none; b=nfzkWMZUMFWrV+kjFMfqj1LVA4jKcC8rUdHTYJyTHNKOB9xzkLAXTDM1RnPhoIVzEB8eCqhufwvVwSjGFYYrC9EJqYEUMe2Eg/bTTWnvQ7Eks79ZmnOSib1Cya+MFgKzqih+7/IOuSfBj/EaO9YVudswc1mTsika2tmjpo6thSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779544; c=relaxed/simple;
	bh=l0i2x2J04KlBpLZUKn+lGYk4Y4yNBRD/5ZeIZGZzjP4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NfvpcBgZArWhsM7XyfIx7xoiCAZfUw34OQOkUe84vaDWaDDQk/kRvaMJmitfmCvmK6ktDqNQi5IpjCfMORLEK0JxeYX8KSXQB3ZoVcqYNQTp26O685ZeJ0PwoJMd+pXFhGx/5nLoyHqY/4y69jxQoq90Z2HewRS10mUUXbafu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS1UvprV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS1UvprV"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1633202008so5670137276.2;
        Tue, 27 Aug 2024 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724779541; x=1725384341; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l0i2x2J04KlBpLZUKn+lGYk4Y4yNBRD/5ZeIZGZzjP4=;
        b=mS1UvprVI5ewBbVXomvQfoVW//6E2ml51Hc3ciq9O9y5js1JexbKHxtM+ru/+5U+vc
         5LKjcflYf0vJPGNyQ0I8rK9tzEj+vxgk3aLvsKSr1cfA1HjS/4vZ5DD5+o0cKsRkQoaD
         KxbqaARJLsiLlif1wt71PgElz/yrzK4m6XMzMZsXNiV3i2XfooQ5LZmYyMhn70VrCgxq
         WQkd3/7jUjwPhvemeJQ/31EWrUXAysWPF0e3yz5vVTUg5ehNoB4pne8qQO/TrPGQgn9K
         oPXGtXZW53C7d8zTQxUmfIGSyvlSqDWwmZmHb6LZ+GipUjBErY4IYaR7v2PIVUQJaA5n
         aI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779541; x=1725384341;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0i2x2J04KlBpLZUKn+lGYk4Y4yNBRD/5ZeIZGZzjP4=;
        b=CZmPCvAeVJLRMEyfifuQ0iVowWexKwM5OPkTfdf5iizq64oXjFgBm54eYNijpbf54F
         OTBj7P+oYhZx43w0UZKlR8kPIIf/0zI3X8y2gJu/jo9SRWEA51fGwKyw+VhWP6mNYT+q
         XT8iyfvBJhjKQIS5WEvEuWYyVQ6leosJ9f1JpvlNKev91Mr71i6etj715CYwGbe2xvLl
         7BAg4O7hgl542GS+bNwh/FAUt/T3/38d7monEbqrpssI1X59YdybOpAZENMNZxY/mhlP
         e1avbdbwU/p2Sf8NMczxOOfK3A9ISJairTlwIbSoRoZABLeEEfX3wRx2DzWM2FvmIFZr
         uXMg==
X-Forwarded-Encrypted: i=1; AJvYcCWP0Q0IKn41AG6JpyD5r2SgOqPNYRu1Ms1jOVzhpgAKXQr/Dk8Bo0QYUK/axzevHsQoIfWBnSk4EsFMUGA=@vger.kernel.org, AJvYcCXUd1k3FmyYpgk9TZfGfZJYc+6qgWP+vjXpaw+tp/UM6f2sP+lVC1yd9SoyDTk1VFnwHUXm+p/5hvVcumSL8vVa/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyunxfbZuz/jJKFTeiNBbNQ6v9hu/zJZ1hZ2HzofX+oNcfBcy6
	IQapEnvP7nerVR0blg4rOpVd0Vbd7ET0YTSWzzagYXpX0BsPDPhUrRak/pSzKRzz28TwF0HCw2a
	59LW/jXpr7KnujL97Mz8ANHVjy+neB8K/ex4=
X-Google-Smtp-Source: AGHT+IFsx2KgVmMj8H7ybXIhg6noJiGcK4xumNmnyx1E4HyX4U3BhJVGm30AzZFnzoAYW86PaSgaNvdlpat6VxRVfH0=
X-Received: by 2002:a05:6902:1b8d:b0:e11:5ff3:2327 with SMTP id
 3f1490d57ef6-e1a2a7efedcmr3095037276.31.1724779541171; Tue, 27 Aug 2024
 10:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 28 Aug 2024 01:25:30 +0800
Message-ID: <CAH0uvohVui=31tMSD=J-qshtsKHg2__4c7XEQWWXa6Ycf0Umaw@mail.gmail.com>
Subject: [GSoC] perf trace and BTF: Final Report
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

This is the final report for my project "perf trace and BTF".

This project aims to enhance perf trace by utilizing BTF (BPF Type
Format) information from the Linux kernel to collect and pretty-print
system call arguments more effectively. This includes data collection
and pretty printing of struct pointers, buffers, strings, and enum
arguments, which we refer to as syscall augmentation.

I have completed the goals mentioned above during the GSoC period, and
test scripts have been created to validate the new features.
Currently, the patch series for struct, buffer, and string pointers
augmentation is at v3 and under review.

One of my mentors, Arnaldo, wants to convert the integer flags to a
detached BTF object, which is what I=E2=80=99ll be working on after the GSo=
C
period. Additionally, I will focus on landing the perf record
--off-cpu patch series, incorporating feedback from my mentors Ian and
Namhyung on off-cpu v4.

I would like to express my thanks to my mentors Arnaldo Carvalho de
Melo, Ian Rogers, and Namhyung Kim. Their important guidance and
feedback have been invaluable to my work. I am grateful to acme for
making excellent revisions to my code, to Ian Rogers for organizing
weekly meetings and offering professional advice, and to Namhyung Kim
for his crucial insights into key issues and bugs.

Thank you,
Howard
---

Patches sent:
[PATCH v1 0/2] perf trace: Better -p support
[PATCH v1 1/2] perf trace: Collect data only for certain pids
[PATCH v1 2/2] perf trace: Use pid to index perf_event in BPF
Link: https://lore.kernel.org/linux-perf-users/20240827092013.1596-1-howard=
chu95@gmail.com/

perf trace: Enhanced augmentation for pointer arguments
[PATCH v3 1/8] perf trace: Fix perf trace -p <PID>
[PATCH v3 2/8] perf trace: Add trace__bpf_sys_enter_beauty_map() to
prepare for fetching data in BPF
[PATCH v3 3/8] perf trace: Pass the richer 'struct syscall_arg'
pointer to trace__btf_scnprintf()
[PATCH v3 4/8] perf trace: Pretty print struct data
[PATCH v3 5/8] perf trace: Pretty print buffer data
[PATCH v3 6/8] perf trace: Collect augmented data using BPF
[PATCH v3 7/8] perf trace: Add --force-btf for debugging
[PATCH v3 8/8] perf trace: Add general tests for augmented syscalls
Link: https://lore.kernel.org/linux-perf-users/20240824163322.60796-1-howar=
dchu95@gmail.com/

perf record --off-cpu: Dump off-cpu samples directly
[PATCH v4 1/9] perf evsel: Set BPF output to system-wide
[PATCH v4 2/9] perf record --off-cpu: Add --off-cpu-thresh
[PATCH v4 3/9] perf record --off-cpu: Parse offcpu-time event
[PATCH v4 4/9] perf record off-cpu: Dump direct off-cpu samples in BPF
[PATCH v4 5/9] perf record --off-cpu: Dump total off-cpu time at the end
[PATCH v4 6/9] perf evsel: Delete unnecessary =3D 0
[PATCH v4 7/9] perf record --off-cpu: Parse BPF output embedded data
[PATCH v4 8/9] perf header: Add field 'embed'
[PATCH v4 9/9] perf test: Add direct off-cpu dumping test
Link: https://lore.kernel.org/linux-perf-users/20240807153843.3231451-1-how=
ardchu95@gmail.com/

Patches merged:
[PATCH v5 0/8] perf trace: Augment enum arguments with BTF
[PATCH v5 1/8] perf trace: Fix iteration of syscall ids in syscalltbl->entr=
ies
[PATCH v5 2/8] perf trace: BTF-based enum pretty printing for syscall args
[PATCH v5 3/8] perf trace: Augment non-syscall tracepoints with enum
arguments with BTF
[PATCH v5 4/8] perf trace: Filter enum arguments with enum names
[PATCH v5 5/8] perf test: Add landlock workload
[PATCH v5 6/8] perf test trace_btf_enum: Add regression test for the
BTF augmentation of enums in 'perf trace'
[PATCH v5 7/8] perf trace: Introduce trace__btf_scnprintf()
[PATCH v5 8/8] perf trace: Remove arg_fmt->is_enum, we can get that
from the BTF type
Link: https://lore.kernel.org/linux-perf-users/20240705132059.853205-1-howa=
rdchu95@gmail.com/

[PATCH] perf record: Fix comment misspellings
Link: https://lore.kernel.org/linux-perf-users/20240425060427.1800663-1-how=
ardchu95@gmail.com/

Blog posts:
perf trace: Add support for enum arguments
Link: https://sberm.cn/blog/perf-trace-enum

How to contribute to perf
Link: https://sberm.cn/blog/how-to-contrib-perf
