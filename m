Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B054FB5
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614915; cv=none; b=XaoXpRoqu1beUTYzq1j3RSKAtwd0dsIvUaZeHcAtuZ8n3kS2IBNfjtfD2KNkyYQiT1oDeyjAONccm+Vls9Q57m3O2gtpuMW6iB2bV2i7Bd/WSRSOs2T5BazKke/NGF4OL4Ws7aAjgFTOXUCC6I6+rNmC+eGVPSpbs8oO9noapiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614915; c=relaxed/simple;
	bh=1Gz1fWo3YmskqisPfhyRkFPsuIcbAbaL0/5AgmQG+mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsojvLkmu103vvUuIcUDpGZrr5zN2p/lonGd5FsM5F0I+VjVpPA0AnEbG3vY2f3izvSuMAyDtPl4rz0n6lD0xnT6Cmu5Ikwyr2ILLDaUV+O7nsEz+KtZOjqjcbXI98qDho25hcEqKp0pWhjYCF+SwZPpWvLiEqxfij/hBLjilRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6cYtW78; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6cYtW78"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca03687fdso1975ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729614913; x=1730219713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rk55zFTxsd34yZyWk5FqwEG1HO5rWiSggBlow3srns=;
        b=K6cYtW78tfsoqYyejfSONQAr44KEo2x2+Mywbho/RWXJ3B4w839UpKvbTIhx5C2Xqx
         N8/jBKZazVBfKaFofh8DDXqSfHMwprszVg1PZfivS3w8cOVsI46t4lWaviY/bYUcobIW
         H7E7fQEexMgythncYVE3Ubl+PLQPsdunHENvW5sSNzPs7Qle6vWWnvFsf4n4x6u3muBM
         WtEIuxhZNG1uU6ezZnpJD8Q17XygkW0BIFTOyDSlPYLjduHDTL8TvbzYI2Yg4srxmnqp
         vkfs5LZDlL7WgzYH+sCp9SjdasvQcM999dSP4LWgtleMdNWOHbo6jsLzSiLVzSHGMqyt
         vqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614913; x=1730219713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rk55zFTxsd34yZyWk5FqwEG1HO5rWiSggBlow3srns=;
        b=J3upM1Sisq4yoTebo0dM4H6E+3hEIqH6QcFFV0dOeOZpGu5uR8qQhfPdceZOg92vtX
         gpJ/OOkz5CJ/YoYI49Q2JRRGG2zHx7Rtd5HgP8P1EGxrJxC2QxZOTAhQdj9/mzYAIZTM
         xuFQSki3g4h1rJZrDFwGMEe/ihZ59pvxB7poPNuO05gfrsONdlJwQ3PYGQKWz4SqXaXV
         W7yKOC4P5VQg5QJYVSLxvjJyQWjAZzM7IWAV+ccH+y+V7nzScjlIQVvMhnMIg8AX/7ni
         bw6B+JG6egiw5C12HtO+bMG8eW/rBLL01Xu+iUSj7pqtm5rs4LFZZP6PnMKbLZzNG2wF
         +SUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK3uf8GAuNJ227p1rpCt2gwkDirnLVo3HjqK9R88zkEdldfS4p6/NJN2KNKgEDsNxB0K7yNMDnJSFYLWq68iL1@vger.kernel.org
X-Gm-Message-State: AOJu0YzORcKMzYuBQpsRPl8AyOVgwhWTP4eVK1SkqMH7i2/RlTb2x7QU
	nG6Nn4IDbBvxp38sEDuXSI/z7VOppCRtjV2YPBqvJ44OeQ3qn4nJrwHXv53/plzw5G8dR5O+KXC
	JLR7dQAZkDykbSUkZjQ03jfSUCmAi3+OdUF8X
X-Google-Smtp-Source: AGHT+IEM79Unt4z+3n5XnYAuhS6UR6WxKhsPucZaXZ85ws1SpxaJfbbu58Y8JuhMkMCIPGjqD8Nx1FwHBSxIBOVN1Ok=
X-Received: by 2002:a17:902:e541:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20e97fbde77mr3506015ad.10.1729614913297; Tue, 22 Oct 2024
 09:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806220614.831914-1-irogers@google.com> <cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com>
In-Reply-To: <cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Oct 2024 09:34:59 -0700
Message-ID: <CAP-5=fVXvus+7PMO=WU+V3CnVNSboGgwS5EcPgXhJKb5MtRAWw@mail.gmail.com>
Subject: Re: [PATCH v3] perf cap: Tidy up and improve capability testing
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Leo Yan <leo.yan@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 6:56=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 7/08/24 01:06, Ian Rogers wrote:
> > Remove dependence on libcap. libcap is only used to query whether a
> > capability is supported, which is just 1 capget system call.
> >
> > If the capget system call fails, fall back on root permission
> > checking. Previously if libcap fails then the permission is assumed
> > not present which may be pessimistic/wrong.
> >
> > Add a used_root out argument to perf_cap__capable to say whether the
> > fall back root check was used. This allows the correct error message,
> > "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
> > be selected.
> >
> > Tidy uses of perf_cap__capable so that tests aren't repeated if capget
> > isn't supported.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> I find I need to revert this.  E.g.
>
> $ install-perf.sh
> $ perf record -e intel_pt//k uname
> WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
> check /proc/sys/kernel/kptr_restrict and
> /proc/sys/kernel/perf_event_paranoid.
>
> Samples in kernel functions may not be resolved if a suitable vmlinux
> file is not found in the buildid cache or in the vmlinux path.
>
> Samples in kernel modules won't be resolved at all.
>
> If some relocation was applied (e.g. kexec) symbols may be misresolved
> even with a suitable vmlinux or kallsyms file.
>
> Couldn't record kernel reference relocation symbol
> Symbol resolution may be skewed if relocation was used (e.g. kexec).
> Check /proc/kallsyms permission or run as root.
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.061 MB perf.data ]
> $ git revert e25ebda78e230283bf707ae3e9655270ff40a7f9
> Auto-merging tools/perf/Makefile.config
> Auto-merging tools/perf/builtin-ftrace.c
> Auto-merging tools/perf/util/Build
> Auto-merging tools/perf/util/symbol.c
> [master 752707588a700] Revert "perf cap: Tidy up and improve capability
> testing"
>  7 files changed, 70 insertions(+), 73 deletions(-)
> $ install-perf.sh
> $ perf record -e intel_pt//k uname
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.065 MB perf.data ]

Sorry for this. I couldn't immediately see a code path that should
impact `perf record` and the reproducer works for me without the
revert. Running your command under gdb looking for calls to
perf_cap__capable:

1)
```
#0  0x00005555557f7abe in symbol__read_kptr_restrict () at util/symbol.c:24=
29
#1  0x00005555557f759f in symbol__init (env=3D0x0) at util/symbol.c:2523
#2  0x00005555555e7ca3 in cmd_record (argc=3D1, argv=3D0x7fffffffe390) at
builtin-record.c:4114
#3  0x000055555569775f in run_builtin (p=3D0x5555560bda50
<commands+288>, argc=3D4,
   argv=3D0x7fffffffe390) at perf.c:351
#4  0x0000555555696e13 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffe390) at perf.c:404
#5  0x000055555569762f in run_argv (argcp=3D0x7fffffffe1dc,
argv=3D0x7fffffffe1d0) at perf.c:448
#6  0x0000555555696a74 in main (argc=3D4, argv=3D0x7fffffffe390) at perf.c:=
562
```
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-record.c?h=3Dperf-tools-next#n4108
```
/*
* Allow aliases to facilitate the lookup of symbols for address
* filters. Refer to auxtrace_parse_filters().
*/
symbol_conf.allow_aliases =3D true;

symbol__init(NULL);
```
I don't think this is the cause but it seems unfortunate we're
enabling symbols in perf record unconditionally.

2)
```
#0  perf_cap__capable (cap=3D21, used_root=3D0x7fffffffbd87) at util/cap.c:=
22
#1  0x0000555555878236 in perf_event_paranoid_check (max_level=3D-1) at
util/util.c:330
#2  0x00005555559574ba in intel_pt_recording_options
(itr=3D0x55555610ada0, evlist=3D0x5555560f36f0,
   opts=3D0x5555560b4818 <record+320>) at arch/x86/util/intel-pt.c:619
#3  0x00005555558a46ad in auxtrace_record__options
(itr=3D0x55555610ada0, evlist=3D0x5555560f36f0,
   opts=3D0x5555560b4818 <record+320>) at util/auxtrace.c:619
#4  0x00005555555e8139 in cmd_record (argc=3D1, argv=3D0x7fffffffe390) at
builtin-record.c:4206
#5  0x000055555569775f in run_builtin (p=3D0x5555560bda50
<commands+288>, argc=3D4,
   argv=3D0x7fffffffe390) at perf.c:351
#6  0x0000555555696e13 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffe390) at perf.c:404
#7  0x000055555569762f in run_argv (argcp=3D0x7fffffffe1dc,
argv=3D0x7fffffffe1d0) at perf.c:448
#8  0x0000555555696a74 in main (argc=3D4, argv=3D0x7fffffffe390) at perf.c:=
562
```
So this looks like the cause.

Would it be possible for you to trace (strace/gdb/perf trace) what's
happening in perf_cap__capable? I suspect the system call capget and
its interpretation are the source of the problem, but I can't eyeball
an issue in:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/cap.c?h=3Dperf-tools-next#n53

I'd prefer a fix to a revert but I'll leave that to others to decide.

Thanks,
Ian
