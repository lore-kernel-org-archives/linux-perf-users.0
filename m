Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDE3FFD;
	Sat, 14 Jun 2025 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749874600; cv=none; b=Civbb2q0OfQ3UaoL1vVyF/0LlbtNj06kRYbZfUH38e2RXy2MHAHm7srKVoW35yGSfiu+u/9cbGJR+ojg8g5buNYuU9q9JzRCI9asUUIODOuQZvYwOLKRhd06jPsolPDzRTjR0MJwkVSpr80E0yryEjXgU4q1go8/oQ/UR4hCU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749874600; c=relaxed/simple;
	bh=m+KR5noHEiciaVpPiKU8xLKT0J23+CxeKqvtA8rKrJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd379lTImQ64hDMy0HTXFvl7RT0o4l3t8YsfKf+Qggt2rdyFi0IUj+WDeAgG9/pMzvLo3q2YBgxBvef5oK3p370CkYwBYgfnjTvxs4BvPENxEKj0sxyeReYu0mtD3XauJgjGTSaHMEN/uWyYKfKV8Zvl/LVI1diBOtMJQ8+fwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnrDX1Mr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnrDX1Mr"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70f862dbeaeso28077707b3.1;
        Fri, 13 Jun 2025 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749874597; x=1750479397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEqRCn0bK13sCXBYjTgFbWsSoj1rywXvpJYlD//fcpQ=;
        b=hnrDX1MrNyAGQG7A/WmqrX4lK+kvEBzmbFw/OvrvdkMgLDL+Ufh059mvWQnrfXABU1
         EaedqLoPVViD+1FIvZxpCrlf/PeU9ADSTGAOjZT8KhIXm7uWvTLi36VdQ6c3SMo5UuWL
         vhzaql7m+PeaCA5El2peMeH7xqCpqJHRtIncet/avHAf60HHsiwVSAs0WxUQeXIqCx33
         r/vk1H4xIFtmC7KJFpmc9MR59qDXe9YAvSbEMinDALk076oU6muhj6YVy0zzKBRc35Ah
         roBV6127G6K3N69i/lrsDzhC0Qlwk9Xu8q0CkHDiYirov7iO6BTrkSeRkQ0LkVr2Ddb0
         mRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749874597; x=1750479397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEqRCn0bK13sCXBYjTgFbWsSoj1rywXvpJYlD//fcpQ=;
        b=Xe6Zo0xVxPfvJWanle1XSSlJHQF6zPhXSOXtYTuCwgT/sGYgu2deLr23/dVvLLuF5S
         CojD48qPOOCBEFwGzq/KR/YC/hZLDR8cTXvXlxNxNfh65vkt9UvHfqCNN/bJB07WWWXf
         Qfljz9JsX6Lm3kKvKzeUBl9ADSIMToA0b7Atzczo4RgOZkdXtH4orNok9bMUFSipbF2W
         jvO7POUx+klYRkbmkbFznKhkcqaHDSFh68IhAD8Kmj5kK4C4fbskht49qI18X0KM+9hk
         UmktiSCbmBek3VusM6F3NB2IQpS82nsJz9npTBY988yY2KoCmETcSlhGPQL7ohbPLUV1
         X4wA==
X-Forwarded-Encrypted: i=1; AJvYcCVWo/42j3oYGG/sYHWaaWkXXE7X+hwQ6J6B6XUX+DswQQYqN0Hp358aJtez4uNJzUFEKFsP2a6v+JKhkREgfW8UrQ==@vger.kernel.org, AJvYcCXLIUZW+jmtINtxvTOrlpxsB1gSEK1GKtWDycdCfXCLTOvea3apkRoCEV9CEPSp6uIJ2MggsMtq1BCYOV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVBioQQz62pJTa/nz9Tc7x/6yOuml5cGQtFQNjlf+3b6lSLDy
	i3aqHXT959PKORzYXVKH1+xRd27frvijwpX7DL1nXqgGaCcr2lYFnVxTlewawXY6sqIEfy5NsDF
	ucFufqD6NRtrkANdsOkIrsx6aYY2tm2k=
X-Gm-Gg: ASbGncusTB3uMuyuw4vxFm37q5NxIudkSh6IE80WB8boWG1e6KeJDj4B2OXggRQWxEU
	UlfGBcJKILkEDeOTfFNn/XPIOtiup2b2jewoYym9TfqaOfwlXH7c1TvsPZWGxb4YnOYPzjQgLpm
	4Ae4H1psMUm14GDp54/PnHzs6MpzWmphHSB9GfJwAFrw==
X-Google-Smtp-Source: AGHT+IFybRlrb6IOvNn95HyjV7TRv+zq6LzZ23f+sKrbydMHRyLoBTqn0FaCddrmC0uKWYvQ4Q3/NvyCQj+XUpdF/qU=
X-Received: by 2002:a05:690c:9a07:b0:703:b3b8:1ca1 with SMTP id
 00721157ae682-7117536e5f3mr23673627b3.5.1749874597304; Fri, 13 Jun 2025
 21:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com> <20250614004108.1650988-3-irogers@google.com>
In-Reply-To: <20250614004108.1650988-3-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 13 Jun 2025 21:16:26 -0700
X-Gm-Features: AX0GCFvZdQX9PXK28NKk2Jj5Ppi7rE_0y6bB3X8ZBDx-JeIRZ74VhUwGhNzgZRw
Message-ID: <CAH0uvojjfOcoZmxPL+bG5NEid8xcAVth7UxOUc=aYjgF5nqs2A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf trace: Add missed freeing of ordered events
 and thread
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

before:
~~~
$ sudo valgrind --leak-check=3Dfull /tmp/perf/perf trace --sort-events
-e openat* --max-events=3D1 -- echo 1
=3D=3D248676=3D=3D Memcheck, a memory error detector
=3D=3D248676=3D=3D Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward=
 et al.
=3D=3D248676=3D=3D Using Valgrind-3.23.0 and LibVEX; rerun with -h for copy=
right info
=3D=3D248676=3D=3D Command: /tmp/perf/perf trace --sort-events -e openat*
--max-events=3D1 -- echo 1
...
=3D=3D248676=3D=3D 3,842 (256 direct, 3,586 indirect) bytes in 1 blocks are
definitely lost in loss record 2,773 of 2,808
=3D=3D248676=3D=3D    at 0x484FBE3: calloc (in
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D248676=3D=3D    by 0x3634E1: thread__new (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x363BBE: threads__findnew (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x34DAB6: machine__findnew_thread (in /tmp/perf/pe=
rf)
=3D=3D248676=3D=3D    by 0x34E655: machine__process_comm_event (in /tmp/per=
f/perf)
=3D=3D248676=3D=3D    by 0x2071B1: __trace__deliver_event.isra.0 (in /tmp/p=
erf/perf)
=3D=3D248676=3D=3D    by 0x2072EA: ordered_events__deliver_event (in /tmp/p=
erf/perf)
=3D=3D248676=3D=3D    by 0x3608D2: __ordered_events__flush (in /tmp/perf/pe=
rf)
=3D=3D248676=3D=3D    by 0x20CB19: trace__run (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x21183D: cmd_trace (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x215E6F: run_builtin (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x21618A: handle_internal_command (in /tmp/perf/pe=
rf)
...
=3D=3D248676=3D=3D 4,992 bytes in 16 blocks are definitely lost in loss rec=
ord
2,776 of 2,808
=3D=3D248676=3D=3D    at 0x484FE10: realloc (in
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D248676=3D=3D    by 0x57CCBCD: __vasprintf_internal (vasprintf.c:123)
=3D=3D248676=3D=3D    by 0x5878152: __asprintf_chk (asprintf_chk.c:34)
=3D=3D248676=3D=3D    by 0x31ED18: parse_events_formats_error_string (in /t=
mp/perf/perf)
=3D=3D248676=3D=3D    by 0x36DCA7: perf_pmu__config_terms (in /tmp/perf/per=
f)
=3D=3D248676=3D=3D    by 0x370CD8: perf_pmu__name_from_config (in /tmp/perf=
/perf)
=3D=3D248676=3D=3D    by 0x43216A: arch_is_topdown_metrics (in /tmp/perf/pe=
rf)
=3D=3D248676=3D=3D    by 0x432AD7: arch_evsel__must_be_in_group (in /tmp/pe=
rf/perf)
=3D=3D248676=3D=3D    by 0x31C657: __parse_events (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x31CD1E: parse_event (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x3A2D76: perf_can_comm_exec (in /tmp/perf/perf)
=3D=3D248676=3D=3D    by 0x3A374F: evlist__config (in /tmp/perf/perf)
...
=3D=3D248676=3D=3D
=3D=3D248676=3D=3D LEAK SUMMARY:
=3D=3D248676=3D=3D    definitely lost: 5,248 bytes in 17 blocks
=3D=3D248676=3D=3D    indirectly lost: 3,586 bytes in 12 blocks
=3D=3D248676=3D=3D      possibly lost: 311,943 bytes in 5,292 blocks
=3D=3D248676=3D=3D    still reachable: 740,220 bytes in 21,186 blocks
=3D=3D248676=3D=3D         suppressed: 0 bytes in 0 blocks
=3D=3D248676=3D=3D Reachable blocks (those to which a pointer was found) ar=
e not shown.
=3D=3D248676=3D=3D To see them, rerun with: --leak-check=3Dfull --show-leak=
-kinds=3Dall
=3D=3D248676=3D=3D
=3D=3D248676=3D=3D For lists of detected and suppressed errors, rerun with:=
 -s
=3D=3D248676=3D=3D ERROR SUMMARY: 56 errors from 56 contexts (suppressed: 0=
 from 0)
~~~

after:
~~~
$ sudo valgrind --leak-check=3Dfull /tmp/perf/perf trace --sort-events
-e openat* --max-events=3D1 -- echo 1
=3D=3D245044=3D=3D Memcheck, a memory error detector
=3D=3D245044=3D=3D Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward=
 et al.
=3D=3D245044=3D=3D Using Valgrind-3.23.0 and LibVEX; rerun with -h for copy=
right info
=3D=3D245044=3D=3D Command: /tmp/perf/perf trace --sort-events -e openat*
--max-events=3D1 -- echo 1
=3D=3D245044=3D=3D
--245044-- WARNING: unhandled eBPF command 36
--245044-- WARNING: unhandled eBPF command 28
--245044-- WARNING: unhandled eBPF command 28
--245044-- WARNING: unhandled eBPF command 28
--245044-- WARNING: unhandled eBPF command 28
--245044-- WARNING: unhandled eBPF command 28
libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
libbpf: failed to read kernel BTF from '/sys/kernel/btf/vmlinux': -ENODEV
...
=3D=3D245044=3D=3D 4,992 bytes in 16 blocks are definitely lost in loss rec=
ord
2,763 of 2,794
=3D=3D245044=3D=3D    at 0x484FE10: realloc (in
/usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D245044=3D=3D    by 0x57CCBCD: __vasprintf_internal (vasprintf.c:123)
=3D=3D245044=3D=3D    by 0x5878152: __asprintf_chk (asprintf_chk.c:34)
=3D=3D245044=3D=3D    by 0x31ED98: parse_events_formats_error_string (in /t=
mp/perf/perf)
=3D=3D245044=3D=3D    by 0x36DD27: perf_pmu__config_terms (in /tmp/perf/per=
f)
=3D=3D245044=3D=3D    by 0x370D58: perf_pmu__name_from_config (in /tmp/perf=
/perf)
=3D=3D245044=3D=3D    by 0x4321EA: arch_is_topdown_metrics (in /tmp/perf/pe=
rf)
=3D=3D245044=3D=3D    by 0x432B57: arch_evsel__must_be_in_group (in /tmp/pe=
rf/perf)
=3D=3D245044=3D=3D    by 0x31C6D7: __parse_events (in /tmp/perf/perf)
=3D=3D245044=3D=3D    by 0x31CD9E: parse_event (in /tmp/perf/perf)
=3D=3D245044=3D=3D    by 0x3A2DF6: perf_can_comm_exec (in /tmp/perf/perf)
=3D=3D245044=3D=3D    by 0x3A37CF: evlist__config (in /tmp/perf/perf)
...
=3D=3D245044=3D=3D LEAK SUMMARY:
=3D=3D245044=3D=3D    definitely lost: 4,992 bytes in 16 blocks
=3D=3D245044=3D=3D    indirectly lost: 0 bytes in 0 blocks
=3D=3D245044=3D=3D      possibly lost: 245,988 bytes in 5,288 blocks
=3D=3D245044=3D=3D    still reachable: 740,211 bytes in 21,185 blocks
=3D=3D245044=3D=3D         suppressed: 0 bytes in 0 blocks
=3D=3D245044=3D=3D Reachable blocks (those to which a pointer was found) ar=
e not shown.
=3D=3D245044=3D=3D To see them, rerun with: --leak-check=3Dfull --show-leak=
-kinds=3Dall
=3D=3D245044=3D=3D
=3D=3D245044=3D=3D For lists of detected and suppressed errors, rerun with:=
 -s
=3D=3D245044=3D=3D ERROR SUMMARY: 51 errors from 51 contexts (suppressed: 0=
 from 0)
~~~

TL;DR: (definitely lost: 5,248 bytes in 17 blocks, 3,586 bytes in 12
blocks) -> (definitely lost: 4,992 bytes in 16 blocks, indirectly
lost: 0 bytes in 0 blocks), the leak of thread__new() is fixed.

Thank you so much for fixing this.

On Fri, Jun 13, 2025 at 5:41=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Caught by leak sanitizer running "perf trace BTF general tests".
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
