Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B0E541;
	Fri,  2 Aug 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558311; cv=none; b=HAQ0NoNyDayPw8xwRcFCByZN6dbnrkmZ2aL9B6QQWk8cTLj1vh3bQZaqt2Dkuu4ZI1JuazIrN/GMiMFz/KVMIDdJ1wQJt/VLF/V4JvwWzp5rqh36ZKCDTUfzx5igtzt4fv/O9ioqxRZb6rfY0qD9r4sUInxxWMADnQcp32v4ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558311; c=relaxed/simple;
	bh=9biq2UadBfZ7zwF9uTZiJMx7UKuxa5hBvmzABIdXWRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9DzE2RIrTLX+qxVWnMiZndU9gLIMPdIExpG2c7X/C4waUvXul9gaJ/qy9914CZzhQJOzlG+BvZ9SJk9ALg0tpc+cSH/ct3ehToIBhNP8lllx5atogqpp40l9RaWmg9Vm2Lz28ZZuXQlpCiUpaHU5aYra7MILHcfh5hdRyMTTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d399da0b5so6532000b3a.3;
        Thu, 01 Aug 2024 17:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722558309; x=1723163109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV6RwPwdwLS97FXT5295OSHRXpAZlOhWy3lAKS8mG1I=;
        b=HZWxzAzynitiWVYoF7NXYvRs8506OhunVnrT5+nWrE1FJR2b/MDOaRj1zMvpbIaRGr
         LCsuCLbkM6/lRqKVsr8/FNlK/7Ne9f/0n2j75o4wQWcxnAbbHngTj0RoLAxCJ1+ZmlVs
         Wz+UfbkQZHIiZO2vXtiLQ23B0XPEPOlRudxM9j636WhGALYgqcJuUJtJtX233OYmDHmR
         D1k4XuhwFHRDrFIYtD72H3b07E+ptNeyRc+zY0PRQHchKjKg8ZSmCGqEgHC/+xa5ZVoV
         fjEUpbNeyrwZPF23096BLq6MWc0MnRvvBt7yxz//PoXk0iPTrBOVhApuU1KJYHJ/0dkT
         S0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUY8Vl/LJnbMF7KCX/xMS7cQFg8X5w/XexUDi7rbT0x7hNouNSDy/DXjjXPgL7W9bvFtxJ4an8knmviXNTndBcLSOoU6N3Rk6Ro26f02+ITSpO+MCVFd3eAQgIHf0dT4xnCJue4qTmF6qs4kq1/mg==
X-Gm-Message-State: AOJu0Yxu4PALOfgIBX99aQOZYNXs3fz9q/zQAGhSlVFWyCVL3xYvx4Vt
	FuwBJAF2AVkJru6rHy7hcUgLm2bmRKfqqbQeXi4Vp9m9tQsVujYgmR3RgRzPa6k/m9l27D9tQIP
	AYopqCnoM4FgAPHkJnHw72TtJzg4=
X-Google-Smtp-Source: AGHT+IEay6FGztYfE2qCHZyN+KVpz05C0vlPt5Ih3zDmHjBor++ktoeRMFCWXbrke/P6T1Q489xN0AuHPqRW5iMO6YU=
X-Received: by 2002:a05:6a21:6d8a:b0:1c4:8291:e94e with SMTP id
 adf61e73a8af0-1c69966b36dmr2828884637.45.1722558308588; Thu, 01 Aug 2024
 17:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731235505.710436-1-namhyung@kernel.org> <CAP-5=fX8Fg4jJDN=d2pHU1Xy3-A119c5gZYXtQu0b0Rwb0-ymQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX8Fg4jJDN=d2pHU1Xy3-A119c5gZYXtQu0b0Rwb0-ymQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 1 Aug 2024 17:24:57 -0700
Message-ID: <CAM9d7cg=xZAqp5RMfAVc6Oy15zFmn3GO6GGmja7pz22SSjuZnw@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf mem: Basic support for data type profiling (v1)
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 8:23=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jul 31, 2024 at 4:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > As we added data type profiling, 'perf mem report' should support that
> > as well.  This patches just added a couple of convenient options.
> >
> >   $ perf mem report -T -s mem
> >   # To display the perf.data header info, please use --header/--header-=
only options.
> >   #
> >   #
> >   # Total Lost Samples: 0
> >   #
> >   # Samples: 131  of event 'cpu/mem-loads,ldlat=3D30/P'
> >   # Total weight : 18561
> >   # Sort order   : mem,type
> >   #
> >   # Overhead       Samples  Memory access                            Da=
ta Type
> >   # ........  ............  .......................................  ..=
.......
> >   #
> >       14.84%            22  L1 hit                                   (u=
nknown)
> >       12.02%             8  RAM hit                                  (u=
nknown)
> >        7.68%             8  LFB/MAB hit                              (u=
nknown)
> >        6.29%            12  L1 hit                                   (s=
tack operation)
> >        3.97%             5  LFB/MAB hit                              st=
ruct psi_group_cpu
> >        3.69%             3  L1 hit                                   st=
ruct
> >        3.18%             3  LFB/MAB hit                              (s=
tack operation)
> >        2.89%             5  L3 hit                                   (u=
nknown)
> >        2.58%             3  L1 hit                                   un=
signed int
> >        2.31%             2  L1 hit                                   st=
ruct psi_group_cpu
> >        2.21%             2  LFB/MAB hit                              st=
ruct cfs_rq
> >        2.19%             2  RAM hit                                  st=
ruct sched_entity
> >        2.16%             1  L1 hit                                   st=
ruct task_struct
> >        1.85%             3  L1 hit                                   st=
ruct pcpu_hot
> >        1.78%             1  RAM hit                                  st=
ruct tss_struct
> >        1.72%             1  LFB/MAB hit                              st=
ruct mm_struct
> >        1.62%             2  L1 hit                                   st=
ruct psi_group
> >        ...
> >
> >
> > The code is also available at 'perf/mem-type-v1' branch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (6):
> >   perf hist: Correct hist_entry->mem_info refcounts
> >   perf mem: Free the allocated sort string
> >   perf mem: Rework command option handling
> >   perf tools: Add mode argument to sort_help()
> >   perf mem: Add -s/--sort option
> >   perf mem: Add -T/--data-type option to report subcommand
> >
> >  tools/perf/builtin-mem.c     | 100 ++++++++++++++++++++++-------------
> >  tools/perf/builtin-report.c  |   4 +-
> >  tools/perf/util/hist.c       |  14 ++---
> >  tools/perf/util/map_symbol.c |  18 +++++++
> >  tools/perf/util/map_symbol.h |   3 ++
> >  tools/perf/util/mem-info.c   |  13 +++++
> >  tools/perf/util/mem-info.h   |   1 +
> >  tools/perf/util/sort.c       |  12 +++--
> >  tools/perf/util/sort.h       |   2 +-
> >  9 files changed, 116 insertions(+), 51 deletions(-)
>
> Lgtm, man page updates?

Thanks for your review, I'll update the documentation.
Namhyung
