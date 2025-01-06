Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E461D5CF4
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193965; cv=none; b=IUeAk/QhjTRlDnk9qmLUdrp/OE+codZO96VN/wWRuNVOYPKu5QxgxxsXhNAHlE54Vc4jKB2erD3vMGgkLkrDqKMsBR4AEuYCIogADrDWbh0tRZFzkeZjWdvQr5u/9+tN+aP2pUB1M/lfttv1uZcjQbvImtCEqWP+wf4JtrA8Gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193965; c=relaxed/simple;
	bh=0y1e3gtN4uMu/FqHv0tN/QNvmxvsOx5MFQ+M0bKJWTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLiTk+5hGgnwBFSP+ZF/6EdCu+XFKSyEF/zwkkm9d0UEnz192AubPk8ay3FqaK3hq/uaUAM/QMszoPg9s20n1/sNgmWm6gqcgEObzKi2ZtbVYwGg5CBwyuKGpJ8irD7CloEzPKTHYKZjB5tgBhhGQf8SyEWl217JqlmClFBArgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZeBN4YW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZeBN4YW"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so17045ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736193963; x=1736798763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89rhBgQRnXcKMVrwWMHxN9A0BmutKC2XU/2aaVYlH08=;
        b=wZeBN4YWi/7x5Vv8bVowPb2YQ/MhDgjwi4pcuHoGUdPOd7Ld+dgEwEBVxPfK5wRR9x
         Ae61k3dBzdkwCaBjt+x2TSRY8Jc+DBJBrkXNCMucYrATTqA3HCt+h3VmGmPURhVLquef
         w+TTzt7eXxKSplpLNOhnFX2anbpyE2R/mbch6Wfxv70qI1gnBufy+SF17TWI4SsEbZuu
         QBpG7MmIhsXyC4t9Z2CZsZZmyjt3tMln7iN1FJ9mTECH5K7Nw5fOD0ubN6Qxva5atJaA
         7dizQ9jgo4u+hiI/600lZQf/mhzLi44xaFoAJUhb2WxO6AHkxDW4p3U4m4U7VvZxgIgH
         LEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736193963; x=1736798763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89rhBgQRnXcKMVrwWMHxN9A0BmutKC2XU/2aaVYlH08=;
        b=eQNb6YTM4WsYcHZs/mJMSUabiN/vEoNudFTEfMyArr7c616oYYl4jZNUXgPG4FxnWr
         bRcG7zNq2HI4npTMO63aXJUV67WhJNj0I2DrF7STjYrIkW1cyOAIrvNJ75Hu7NtVr0/A
         tFjeyvriClBXIf/+3+UM3IzT6kfDb6vCsYyizc/sfHOh1KEvx4WP+nKrpbxwDkaAOTes
         w8JZmL1zyLOoQarqqL/jRCfMeWK3rYc5CliPBMtdNpq8FQKKCcVrjKgIOjveCtnIGqjU
         fRfuoOjULZKLD3OqQEwvHIVdL/6cKCkZNlUwu+qjAy4YTGpF+Idj0Zk+s3UGQIT5QJtU
         Xc8w==
X-Forwarded-Encrypted: i=1; AJvYcCVm8J/71W1mk0AUBUH17goH85e4So0As5C20gCPq2Ed2p+YQPKt52+agsFQs8Dts0FRZ5Dx1B1s2yiP6siU3rBl@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKVjpEl2fZZB80xmRypuIroTjVbEaBt+nUg37BGvCC0OLz4yp
	ExbXa2kHeNIvxJwgdNPBWCS8zd+csKTscJQSKqlRWDzjavwqyLORjkzZ51ZBuza5cTPepglktGb
	h53sLNdkdowSOsNBOGENYmCqB4KlJ0ZAHSw/9
X-Gm-Gg: ASbGnct6zPmfBTSSeOKkV0GPT+7fmcwjqFh4K1MCIx9mTtN5krcVma0/UW1aicrhXD+
	l1r4LukxBotL9cBmJsD7/F3SkEwK1Q2+O8TKJ1JvyQQxaHi7VNBJoUOuOz12iOxUyD1mC
X-Google-Smtp-Source: AGHT+IGLsDBrotQ8nYPvuMsyL75xnUrfiLQrTOomCApfYA934d/pM85xLj/qkn+OogjKmro8tOx+xHZtdXaJ9M7nvYE=
X-Received: by 2002:a92:cac9:0:b0:3a7:91c2:c28d with SMTP id
 e9e14a558f8ab-3ce32470286mr383485ab.28.1736193962916; Mon, 06 Jan 2025
 12:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jan 2025 12:05:51 -0800
Message-ID: <CAP-5=fWVHaVpJbDf=afn5MhZ972uEq=sGEmsULoD=LRff2Vouw@mail.gmail.com>
Subject: Re: [PATCH] libperf: Add back guard on MAX_NR_CPUS
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 11:38=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Building perf with EXTRA_CFLAGS=3D"-DMAX_NR_CPUS=3D1" fails:
>
>           CC      /home/chleroy/linux-powerpc/tools/perf/libperf/cpumap.o
>         cpumap.c:16: error: "MAX_NR_CPUS" redefined [-Werror]
>            16 | #define MAX_NR_CPUS 4096
>               |
>         <command-line>: note: this is the location of the previous defini=
tion
>
> Commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
> moved definition of MAX_NR_CPUS from lib/perf/include/internal/cpumap.h
> to lib/perf/cpumap.c but the guard surrounding that definition got lost
> in the move.
>
> See commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
> compile time") to see why it is needed.
>
> Note that MAX_NR_CPUS was initialy defined in perf/perf.h and a
> redundant definition was added by commit 9c3516d1b850 ("libperf:
> Add perf_cpu_map__new()/perf_cpu_map__read() functions").
>
> A cleaner fix would be to remove that duplicate but for the time
> being fix the problem by bringing back the guard for when MAX_NR_CPUS
> is already defined.
>
> Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Hello,

I believe this change might be unnecessary. The only use of
MAX_NR_CPUS is in a warning message within perf_cpu_map__new, which
takes a string and produces a perf_cpu_map. Other similar functions
like cpu_map__new_sysconf don't check MAX_NR_CPUS. Therefore,
specifying a -DMAX_NR_CPUS value on the build command line has little
effect=E2=80=94it only impacts a warning message for certain kinds of
perf_cpu_map creation. It's also unclear what the intended outcome is
on the build command line.

Given that specifying the value doesn't seem to have a clear purpose,
allowing the build to break might be the best option. This would alert
the person building perf that they are doing something that doesn't
make sense.

Thanks,
Ian
