Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1EF264604
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225193; cv=none; b=UJd130zyGizmzpzIRDvEVvC8UPd3glbBbHDb1utPbinih9A6P41YYvbamarFiyFbeHCKfHtp6/Hzdon7qAHAL/sXGCg5UkKYowmcjf1id/tMNvdYUa/bBWuPWCTIWfKESwEQpaZHo27PH+5dZB/+7dP/cUhMKt805KIbDjwZLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225193; c=relaxed/simple;
	bh=THdabyNrKHIr+V3Ysipng7wfjnbb0mAYrhDJOSeQsfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFLR6D8Tcn0wF2YVO1XFQbrDA817s8ueaENPoeUV6bK9OfamHR1HA+dLThm0q42AYiBOaHQnb8QiwGRzcKf2NvGVDanjxip+LjyMzzxzxXaeLheqfcPnZkGhse7zRQOyJ58QP5xjqhR3hPqWnDQiYUztuAvv193wr+3OZQg9TCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PxjBMIBp; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PxjBMIBp"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d05815e89dso14965ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739225190; x=1739829990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THdabyNrKHIr+V3Ysipng7wfjnbb0mAYrhDJOSeQsfQ=;
        b=PxjBMIBp4xyHRWGyHh/7cvP+TFtwQgw5NhmcW2SFZfyFKIGA1lO6QangHMlYlLOOlA
         ZgkIZZtIdo1EJnjH+BdsnE0A7xFU1u+IV/UnMixGQmAOFrkfxrK8y2utFqzgvbOXQKGx
         r9TZ2q5pbQsAey32RIGlF/YJAgQoxiP6giuGlvCfaW+5r++wXEtb1jViFbysiJCOUFpo
         9x4rW8lF9AWnlhCiUfHWwvSEHoKURPRwS3uw+3ktG45hGDeBGboSdrPTOGy8+E2KUDRv
         ACHVwWrMTqAYA6tTQ4MB2x3zMIQrxxr0kkztXWoLTrjyWMWSXWuu0+N8Ov54GbmbnOon
         8asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225190; x=1739829990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THdabyNrKHIr+V3Ysipng7wfjnbb0mAYrhDJOSeQsfQ=;
        b=PNbmoNKW0quLnttJsgtuF8GrPRamUTmeMyM+p4joug56ydlg5IzvTSVsYdFgCDmIZs
         W87L4j1R73GlTwl01+dmcNlpI2WGVNrs+3S3kmjxDYNzBlocNKc7lK4DlvKWGOWBhtii
         PQkaEcIv5X176BplT+h9FCjtjSW2Ds62ZeVEd7ssF4QdHlgfiY0yVKFrm0lhRV7r6TBs
         rq1YD9GFGjQ5dK8H3RX8J0R8cO1IEmoW4djNoFs+Rm/RH+gApWxyIfcARe6+6XPjdSXH
         mtKMMfcsMQZqUILd2wG/Hvknpsw92cKI9jT8y8KdzucwMeHQjquPWLU4fNbq3X807Mjt
         X3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWOUVUHhQZxNcIs4lXZ5pDBn12+MmXdTYR7z5XAUdmX/vpuFcKdjl0K7Z9gwdih2R62KSwcosvYVdyuESrqMA5M@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnUTALjdBrrAYmSh3OIVQonCn9Q4Z3jIatro1MD0y5pszpNjQ
	EF+R24Qd64Toadp+9X/oVR1DX8u6oUL5+eZYEvbjQqCY7GAdF0surfdgVKQJenmoQXK3OE6RuRc
	Dggo67sKoIjiM2M3dzN9A2WvDobYHTxe2Ne+T
X-Gm-Gg: ASbGncsG96Wj29iCrtYXjoVOBs2VaehF6ZbMBOMzisgnNIVEQ+KnAk3fmUIv4Dh/3/l
	2jeJrQmaohvxp4YR1hcsGzdCgzTD/VJB0Z28DqAr+DXNIMcSvlpBPO6ebZx75AJR5fhd+hKUJdr
	OfLWGlIK7NEUDNJBv/eKwLKXnB
X-Google-Smtp-Source: AGHT+IHbmaFsg0uQPoONiAHkOtoySaUgQ9K2OpFMnMHTj6dQRyAljGoHjrvfihITbTh3+H7DHH+dost7jlKkscY54Fk=
X-Received: by 2002:a05:6e02:b45:b0:3cf:a4e4:8f89 with SMTP id
 e9e14a558f8ab-3d16fde3fbdmr1033355ab.4.1739225190504; Mon, 10 Feb 2025
 14:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <Z6panMzNSm1op8Di@google.com>
In-Reply-To: <Z6panMzNSm1op8Di@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 14:06:18 -0800
X-Gm-Features: AWEUYZlOOA-fIoE8-LlW-53jmuF6Hg-u3vSRU9Gu28Ay0nhYmrBf7WlcZRy7N58
Message-ID: <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:59=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, Jan 11, 2025 at 11:01:33AM -0800, Ian Rogers wrote:
> > Rather than scanning /proc and skipping PIDs based on their UIDs, use
> > BPF filters for uid filtering. The /proc scanning in thread_map is
> > racy as the PID may exit before the perf_event_open causing perf to
> > abort. BPF UID filters are more robust as they avoid the race. Add a
> > helper for commands that support UID filtering and wire up. Remove the
> > non-BPF UID filtering support.
>
> Hmm.. then non-BPF build cannot use the UID filtering anymore, right?
> Also non-root users will be limited unless it pinned the BPF program in
> advance.
>
> I think you can keep the original behavior and convert to BPF only when
> it's available.

Using BPF when available would be limited progress. The issues I have
with not removing the existing approach are:

1) It is broken
Scanning /proc for pids and then doing perf_event_open means that any
time a process exits the perf_event_open fails.
Steps to reproduce:
This bug reproduces easily but if your machine is lightly loaded in
one terminal run `perf test`, in another terminal run `sudo perf top
-u $(id -u)` the perf top command will exit with:
```
Error:
The sys_perf_event_open() syscall returned with 3 (No such process)
for event (cycles:P).
/bin/dmesg | grep -i perf may provide additional information.
```

2) It is a work in progress that isn't progressing. Scanning /proc
will only tell you about started processes; it won't tell you about
processes that start during the profiling run, whether it be perf top
or perf record. Extra work would be necessary to make this most basic
of use-cases work, perhaps you could use tracepoints to capture
starting processes and then enable user profiling on those processes.
It would be horribly complicated, suffer from delays between observing
things happen and doing the perf_event_open, biases in the samples,
etc. I don't expect anyone to do it, especially when BPF filtering
already solves the problem better. There have been 13 years that
someone could have fixed it.

3) it adds significant useless complexity to the code base. Having
'user' in the target makes it look like perf_event_open can work on a
pid, system wide or user basis. The user basis doesn't exist so the
majority of the code base is just ignoring it - search for users of
uid_str on target. Those that do run into problems (1) and (2).

4) It is redundant and leads to confusion with BPF filtering. Having
the BPF filter on evsels is non-zero cost in terms of the code base
complexity, but it is something broadly useful. As user filtering has
never worked (see above) it isn't broadly used but is adding
complexity. If both approaches were wanted then it is unclear what the
code should be doing, presumably the mish-mash of BPF filtering and
/proc scanning that happens today and will be broken due to (1) and
(2). Putting everything into the BPF filter makes sense as you can
combine a BPF filter with an additional BPF filter on user.

5) It is untested and adding a test leads to an always broken test due
to testing being an example of where things break, see point 1 and its
example.

6) Nobody wants the non-BPF approach. As it was broken nobody used the
previous feature, maintaining it for no users is overhead. Let me know
if someone is using this option (I doubt it given points 1 and 2) and
they wouldn't be better served by BPF. People building perf today have
to explicitly opt-out of wanting BPF in their tooling. I posted this
change a month ago and nobody has jumped up saying please don't remove
the old approach.

7) The interaction with this feature and changes in behavior, say
ignoring events that fail to open, is non-obvious and not testable as
testing would be broken as the functionality itself is broken. Having
the broken feature hanging around and being untestable means that we
slow progress on new features, testing and other improvements.

Yes, we could try to fix all of that but why? Nobody has cared or
tried in 13 years and I would like the tech debt off our plate with a
better approach in its place.

Thanks,
Ian
