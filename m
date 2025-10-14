Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29C2727F5
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407059; cv=none; b=cUIQugiUZzK6TQuZLDlKe208rVivfnsh84yQ07axko8QBIUyaYrcYEEsfwImjX7HuYbxpDHbxTxTnyKu3OEq5GbztNx8+YTjZkFpZa2tMYtwtJ0GdDFs+nBiT6sC+Hu3j3HMZr++MBbxgSTFc7xH24aoaJDTgURSjQzrmwDgHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407059; c=relaxed/simple;
	bh=OOTR6H6rE4EgVqvj12PYQGMkKkwblBI6CSm6QlAnD5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLEq9+LVNr0zU8UWPzmlK7WKyYRWW4pTbdEakH0QYJUCXI0ljdiiMpqV0Q6eBpf4izg4eqfCK9buAKqsXpg5GGf3CTTZesNnWXnbxzhB41TfOCS5uFq0fRYF6ibDR0UKDYkuzq2MJorGd8sQQ4ZH4hZzRKzL7SAEOpsy56QXue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ0+7vGr; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ0+7vGr"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-36295d53a10so38249771fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760407054; x=1761011854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwp5CrjdVG3aBeAI+F3QhhxogWoO/pXLHfY4OvEFmYw=;
        b=IQ0+7vGrrfbcSVzR9coCjC2axifLv0ZJ8tOY1GIZSRj5gVboH8D7MvtclV1GX5j3Pz
         5jw2BQU2HbZ2jyHdK+Q7Tc8f7eg0PaAZFKWvydmIn4Varex8N/xM1zbznOrS2hA68/Pn
         T85+KQRkWb3a6jGdELoGzHzl3PmZJYbAZCyuxcmQixIRAgVomC0mjjLmYrh6t+0lMAPx
         xJ9Bpe7hES64WnB3jZ5W9+1l2clcudXM5O9xydF6cWH+5rLgbe02hMGIWiy/QyWvrf09
         +YwFClRk93n+XcPjU8BwUe1SgQ7pZvUHvMyFtUZHnGF7zQEXT/udoJVE1JRcDAqg4faU
         yYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760407054; x=1761011854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwp5CrjdVG3aBeAI+F3QhhxogWoO/pXLHfY4OvEFmYw=;
        b=eBERz9CWsWwSXqqzPZeN376znFb3z4WSjdA9h5nOlRJEJyTHRCVpIG00QaXBR9E8KU
         +1yLGgNxDvyPm7Qt4dni8wMcJfqjxUspZh80jMZJp20S+SyLhjmQ3W3aO/8djU9iVReC
         bcVvc2VQyQ0nc0NqGl1mQjz4f4aPxZOXJnBcYqUUEVHP1re8JTvNt8gVCUMMUKKVvYQN
         8fqHhyw1Qr+/bt6JDV4Eu5uCqltwGlTw3F6lZ6PoNZnYW7OPh7qihjHEo7Vixxds4kBw
         FPfUjgWscIIHaH9ycuUpsbcLsG4L8XnOoc36IIx++9GiHwIMtTloqfcpz+n672KTymOZ
         GEag==
X-Forwarded-Encrypted: i=1; AJvYcCVFxm+EXch7jIVZSB/HvCTBm5/3B5I/7lfWoGZ+vXx7qQXfleQvsd444x/8PFQTbnkjYUxKdvIdolVbrnSGc9GF@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIeXH85OT9NLFN06aN8dPA5Hn4/ly+EmQ2z32amRoU3zclZyL
	ErO71KR7eSmd1BBSK1vRR99vtqDM/K/pBw0B2D9NlYB/HPqFHW2WjYQ/0GaBSYSMmNyNUJmI8aP
	G5p3rJSZ/tlC00CANcrJtTBOBixwy2T4=
X-Gm-Gg: ASbGncvvE0Ok6aGuaTbly6EmJPVeICLKU1/aMh9hApC/EogL/DcM33EDh9jhK2TOa3k
	g/tZUmbovo+qP128YIPyuzx+8bdt39PWft7GcUYDFWIUqQOa+p6dOv/HCJKN27g2PMcOnkbM1FB
	8JR++cMPvjoRj+HZR25ttPMhg/WU9uKVUxnO43X2noiuSDKjNHFPTSv8QOrS0m9ssVP2cRGu6JH
	p8/lT6Hs05FOmXDP20ESmjzDUM=
X-Google-Smtp-Source: AGHT+IFQvjrCENHDymi5ELE9Ce1X2qshEHiV18UvddhmumqfOHhO0xkbBHvFpg+eyabJPfVAQRjhe68InR0xoBL28h0=
X-Received: by 2002:a05:651c:54e:b0:336:df0e:f4ac with SMTP id
 38308e7fff4ca-37609e64b90mr55453661fa.25.1760407053269; Mon, 13 Oct 2025
 18:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
In-Reply-To: <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 14 Oct 2025 09:57:21 +0800
X-Gm-Features: AS18NWDdIM8Jz4xqJOYc2o6-4Tffmio45yh6BrtEiFfzLmytSx6MwmUvQ_ki7WQ
Message-ID: <CADHxFxR_S43zzrStKVvbFjwkqFFOjMY8xcFK41Fc1U2xYvYJmA@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi lan,
Thank you very much for your reply.

On Mon, Oct 13, 2025 at 11:46=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 1:08=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Maintainer,
> >
> > I encountered some issues while cross-compiling perf (ARCH=3Darm64),
> > particularly when enabling the BPF option. During the build, Clang
> > fails to compile BPF programs due to missing header files. The
> > relevant error messages are as follows:
>
> Thanks for reporting this issue! There has been some recent work in
> this area by Leo:
> https://lore.kernel.org/lkml/20251006-perf_build_android_ndk-v3-0-4305590=
795b2@arm.com/
> The patches are in Linux v6.18-rc1. Perhaps you could try repeating
> your build with this tree and reporting issues?
>

My local code is already updated to the latest version, and the
current commit is exactly at tag: v6.18-rc1:

commit 3a8660878839faadb4f1a6dd72c3179c1df56787 (tag: v6.18-rc1,
origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Oct 12 13:42:36 2025 -0700

    Linux 6.18-rc1

However, building with this version still gives the same error as
before =E2=80=94 when Clang tries to compile the BPF programs, it fails due=
 to
a missing asm/ioctl.h header file.

----------------------------------------------------------
  INSTALL libsubcmd_headers
  INSTALL libsymbol_headers
  SYSHDR  /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/arch/arm64/include/generated/uapi/asm/unistd_64.h
  INSTALL libapi_headers
  INSTALL libperf_headers
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/evsel.o
  INSTALL libbpf_headers
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_follower.bpf.o
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
11 error generated.
 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_leader.bpf.o]
Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bpf_prog_profiler.bpf.o]
Error 1
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_follower.bpf.o]
Error 1
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/libperf-in.o
  AR      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/libperf.a
make[2]: *** [Makefile.perf:289: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2
----------------------------------------------------------

However, when I apply the previous PATCH and explicitly specify the
sysroot of the cross toolchain via the EXTRA_CLANG_FLAGS setting, the
build succeeds:

    SYSROOT=3D$(${CROSS_COMPILE}gcc --print-sysroot)
    EXTRA_CLANG_FLAGS=3D"--sysroot=3D$SYSROOT"
    make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE
EXTRA_CLANG_FLAGS=3D"$EXTRA_CLANG_FLAGS"

Please let me know if you need any more details or testing.

Thanks,
hupu
