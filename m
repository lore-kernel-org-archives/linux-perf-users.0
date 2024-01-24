Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4812BEB0
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120695; cv=none; b=uoxxoGtYePtZuw6YYrikVuHzm6UkA1/B7zJArJeA5z/ceIP8tHfjT6bx4UbTCnhFsmB8QyNDYmr7XMIfbdmz5FN1jnohOcbbuESQCzLnY5LWktz7iV/Gz6XjYZns6uvs7NrDiFqVTBNV1xSF3Md90VJARIxfoYJOPXy8j4ubQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120695; c=relaxed/simple;
	bh=7MnZiWjiZNSA+2oL+dWWgGoCKkMueb2MkjrlB6aUd3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBUMvQvDIYeJmDM/8MRf2ObLSDaG8ehMggWDGwGtKm9Ed7Clz+6QFL9s8OmaS8N7ZTo/zjm1ZsFG2Kcxqx0cmoeHF/wvqOgq9HSFMA43qhMXlzXh3xtIeMIv58vcYcglZz0a0/nEi4LeNXscV72fmo626bJcSFrD6iNZRMLEx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+B1rDBl; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+B1rDBl"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-361b24d1a9eso7845ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706120692; x=1706725492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRruUIVbFxxKKkU5wcaDpYZHLYv7MyzY0CJbOKyUNKQ=;
        b=L+B1rDBlkYFhrKH/qdMy8CP5pEJb5Lj9LnOb+p3kwiIfFeNYcR9g31yHW+/rlHfsCj
         7DnXqNmOz/dTfwVyz0Mo1UIKukl9L59jbM2zMEcY1v91st8w/UWuexa3OlsAlLedJy9x
         tQapNagbU/AZnukrixKg8nwlUmHRyvplSZDNkQL5VNwuyZHbIN0Po/PoWCQPtWlQaxE3
         hvLv2F6sskbyXjkvpx2njTXo9C36Y6o4UkDeyF38vq8CVF82m0mS3fhwmBc/OIt5ZgJc
         sRiPCI+Q+nob0BDI6hC7OHhh4iigiO8Wgdnqndg9Xwl01vWN8yzd0qFxgggrHkXPw7np
         pKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120692; x=1706725492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRruUIVbFxxKKkU5wcaDpYZHLYv7MyzY0CJbOKyUNKQ=;
        b=uxPi89R5FkC1i/si04bh5AfDvwVP+Qr7chVoG3BMN6KCyHEaNXXtE/Me6Ao7977XGD
         HW0Bzj42VXwrwbR6D64XWNr6MNh95kE0Et+8oZxU7LtDVIHvMzmxcHIPudWmqE7v+Fy4
         W9HQNmbu9TPSq+PsyB/ACZwrkB0Vt8odCD9Gj/y3jlLjfitthWrWPcr8lU86/GXX1HBA
         SRs+pmNyKFG3JPuI2/Ma6A90oL6uC/QFv7e9KPUaLFPtNmq7Te9+VXwqAf2ElPQib693
         FAbTCO7eO9Es6EpvjBYyS5KlKhukw3UWJdMtGkYJc+XDSIUt0lVsEStdeMs4ZRCE82lk
         8zJQ==
X-Gm-Message-State: AOJu0YwbsvR8Mu2M1WAVh7R6dr7tJQj5rCvagb9R6w8zrOMGIFkIeGT0
	oZH69FFv9WHAwmJK0ot9Z+5lubtd1WFs5wBg1sCumms6OdtIYJSAHyxMqqFcdTpcCStt6YwGrOa
	dDM20uh+NAlLS6q0YltIhJZevn/xYyrX9Q6dq
X-Google-Smtp-Source: AGHT+IEZJES0btr1lDHyyGuujn1l/uy1z9lgIem+254rw7jS5t2Kb6zvl+fPKGDI/dv4i+sx3FcjFgxNx8zqu+tZzxU=
X-Received: by 2002:a92:c108:0:b0:35c:e232:f6d8 with SMTP id
 p8-20020a92c108000000b0035ce232f6d8mr21129ile.0.1706120692450; Wed, 24 Jan
 2024 10:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123185036.3461837-1-kan.liang@linux.intel.com>
In-Reply-To: <20240123185036.3461837-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Jan 2024 10:24:41 -0800
Message-ID: <CAP-5=fWuUJHUMb4mq2oPo+eVH32cLrrzYrKVuMymkkrYqMAYFw@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] Clean up perf mem
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com, 
	mike.leach@linaro.org, leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com, 
	renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com, ravi.bangoria@amd.com, 
	atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:51=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V3:
> - Fix the powerPC building error (Kajol Jain)
> - The s390 does not support perf mem. Remove the code. (Thomas)
> - Add reviewed-by and tested-by from Kajol Jain for patch 1 and 2
> - Add tested-by from Leo
>
> Changes since V2:
> - Fix the Arm64 building error (Leo)
> - Add two new patches to clean up perf_mem_events__record_args()
>   and perf_pmus__num_mem_pmus() (Leo)
>
> Changes since V1:
> - Fix strcmp of PMU name checking (Ravi)
> - Fix "/," typo (Ian)
> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
> - Fold the header removal patch into the patch where the cleanups made.
>   (Arnaldo)
> - Add reviewed-by and tested-by from Ian and Ravi
>
> As discussed in the below thread, the patch set is to clean up perf mem.
> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.i=
ntel.com/
>
> Introduce generic functions perf_mem_events__ptr(),
> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> ARCH specific ones.
> Simplify the perf_mem_event__supported().
>
> Only keeps the ARCH-specific perf_mem_events array in the corresponding
> mem-events.c for each ARCH.
>
> There is no functional change.
>
> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> etc. But I can only test it on two Intel platforms.
> Please give it try, if you have machines with other ARCHs.
>
> Here are the test results:
> Intel hybrid machine:
>
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
>
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e cpu_atom/mem-loads,ldlat=3D50/P -e cpu_core/mem-loads,=
ldlat=3D50/P
>
> $perf mem record -v
> calling: record -e cpu_atom/mem-loads,ldlat=3D30/P -e cpu_atom/mem-stores=
/P -e cpu_core/mem-loads,ldlat=3D30/P -e cpu_core/mem-stores/P
>
> $perf mem record -t store -v
> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
>
>
> Intel SPR:
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
>
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D50/}:P
>
> $perf mem record -v
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=3D30/}:P -e cp=
u/mem-stores/P
>
> $perf mem record -t store -v
> calling: record -e cpu/mem-stores/P
>
> Kan Liang (7):
>   perf mem: Add mem_events into the supported perf_pmu
>   perf mem: Clean up perf_mem_events__ptr()
>   perf mem: Clean up perf_mem_events__name()
>   perf mem: Clean up perf_mem_event__supported()
>   perf mem: Clean up is_mem_loads_aux_event()
>   perf mem: Clean up perf_mem_events__record_args()
>   perf mem: Clean up perf_pmus__num_mem_pmus()

I think this is ready to land in perf-tools-next, multiple Tested-by
or Reviewed-by.

Thanks,
Ian

>  tools/perf/arch/arm/util/pmu.c            |   3 +
>  tools/perf/arch/arm64/util/mem-events.c   |  39 +---
>  tools/perf/arch/arm64/util/mem-events.h   |   7 +
>  tools/perf/arch/powerpc/util/Build        |   1 +
>  tools/perf/arch/powerpc/util/mem-events.c |  16 +-
>  tools/perf/arch/powerpc/util/mem-events.h |   7 +
>  tools/perf/arch/powerpc/util/pmu.c        |  12 ++
>  tools/perf/arch/x86/util/mem-events.c     |  99 ++--------
>  tools/perf/arch/x86/util/mem-events.h     |  10 +
>  tools/perf/arch/x86/util/pmu.c            |  19 +-
>  tools/perf/builtin-c2c.c                  |  45 ++---
>  tools/perf/builtin-mem.c                  |  48 ++---
>  tools/perf/util/mem-events.c              | 217 +++++++++++++---------
>  tools/perf/util/mem-events.h              |  19 +-
>  tools/perf/util/pmu.c                     |   4 +-
>  tools/perf/util/pmu.h                     |   7 +
>  tools/perf/util/pmus.c                    |   6 -
>  tools/perf/util/pmus.h                    |   1 -
>  18 files changed, 279 insertions(+), 281 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
>
> --
> 2.35.1
>
