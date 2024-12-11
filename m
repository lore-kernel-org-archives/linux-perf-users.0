Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28020126B
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941261; cv=none; b=qJSQXz28ETaWq0H0G2zJTrj9aGKWBv6CWZuDj98MiiDdIZdwT/UWC4N9i9C7YUJ2S8bBybH0tkrkl4xF4DLVQBx7JFO3GrQ8APPkF/uHhad1R+3JIakjkA0GCbiELCq/mqbeneQGhAqlBBZLtFHr8TL/eD0d8iiFF3GlpcWAbko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941261; c=relaxed/simple;
	bh=RUcYMRvPEsfmFZKlhRBSD9gYC85bBzsiLbsIe6MbJ9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsM9JQ/qq5dTF8U6PoStWwhNwp7mgDLbopV2Q5FeJXQeiuGEgfkwTtbw2OzCeTKQ5AsVHJNEEDT/Dc4suaRyHAD0ZNGAz+qrqTbOF2NxLio/xf+5DWGGVFn6nxm5+PJ9dJgQ5WYHfKbOvCFzwH+t5f2tePuZK1ksmFOnKshVuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4v+bgjm7; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4v+bgjm7"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so10265ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 10:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733941258; x=1734546058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUcYMRvPEsfmFZKlhRBSD9gYC85bBzsiLbsIe6MbJ9U=;
        b=4v+bgjm7fE97/oik4TMRMHpxEyfUa2AO/GOz1oErguAuMsWkL49I48W49DGHxRoY0j
         v11f6u9AKs9+skN/E93wg9hSBV6JqPM5g85yMR07Zt+u+homTffgnoCwWOfd8hDPIsrd
         upvjod+5DEtvCjs90i7QQaE+/jG2AVJRo9b8vuIrTsRR165cuh/Ow+o1e07GAd0lWd9t
         zBZj1Agy58A+jS7WFqMpJMoajoFthymngR99qN6PgGO0vwoBkQrPeOShOmK4BDI/6cCx
         kQJUOpmclJc9FyJYDyeNWaVoaQdwaoCqLBcD+kWkoF96RV8ZtE+a0VChf3zwjvADt9Wh
         xdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941258; x=1734546058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUcYMRvPEsfmFZKlhRBSD9gYC85bBzsiLbsIe6MbJ9U=;
        b=kwKJqsaY//cTp25kng3bmCoYQJ1A8DNTxMwFa4V76tA1Pi5ANg5XbiJQTcfdc6X5ER
         IV2FwEr1IT1h3/YGPfkI8GoHIwtkHvTLBqpFhSbecBIvHPmEyuaNb5ht48YPaHppPzoF
         a8hxYpMtnXBZbuY3ivgk2yj5mKkToLFGZoOqdVCpTNKw7kP0Pc5uktop5gRbXFB5p8i+
         CGakFj58H3nGmdRkfVtabr4WAsmzMdZsEAnDzl6C4RHqSXd2LYDuvJvZnlmumaGYct0e
         kKLjRnpJmzvRcc/5wzZk2IwJWzhpxjCBqdKyLy4nVB1yzuuLnBDnxcSaWdwalWnESiDB
         kEoA==
X-Forwarded-Encrypted: i=1; AJvYcCWnuFcrojMSVdiwSrKHuYmhoyhYsTYLs8dPDQeRWXvAaLsXlk5kUVULFT1TaHTRaxzQIye17rCr6Kbvato+axY8@vger.kernel.org
X-Gm-Message-State: AOJu0YwobWVwlG7ex6JKTFeBjnl+cwHCspKiLFXxkbCYHKoE+cVstcsP
	xxTSs94ru6fBcy7l7RAy4QhYRU1Nj70wa6BwsfW2qIm8rsMz9aa/FtB2qV99srvnW97nn+smrFi
	QDzL6eSCriT3aHzt2dpCRZgfCdocBWOcht4eX
X-Gm-Gg: ASbGncs4pUOiiWHl29zYxPY7BZH4rx71k10l7/Cfa9sCYfIvLTNH32FHyZk7zlQd6IZ
	cbGztwkrCP2A9k58hsT0ZX2p5dQGAzM1n0j2i
X-Google-Smtp-Source: AGHT+IEH7xGnuwB5R4N7oSUzxwV3lX+RNiSYHCfuBO5RafixJNk8dHcTEvZ+XQLjfFmyaE6AXKcEIHsdxj+AUk6ztGY=
X-Received: by 2002:a05:6e02:3190:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3ac42aa7e8emr658465ab.5.1733941258447; Wed, 11 Dec 2024
 10:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210193554.93013-1-ak@linux.intel.com> <01513f7b-390c-4e2e-a6e8-54c268e8acf2@linaro.org>
 <c1e008c4-d2c2-4088-aad2-a86987099c35@linux.intel.com> <71775d41-bf73-48e3-b5a6-6bce46658931@linux.intel.com>
In-Reply-To: <71775d41-bf73-48e3-b5a6-6bce46658931@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 10:20:47 -0800
Message-ID: <CAP-5=fVx8GukBdDNe0Ckb1oPBVwsG4A4xGvj1s9VARQC4k3Dow@mail.gmail.com>
Subject: Re: [PATCH] Update perf tools topdown documentation
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:07=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
> > The RDPMC can automatically reset the perf metrics.
> > Maybe change it to "automatically resetting the perf metrics RDPMC"
> >
>
> The new post can be found at
> https://lore.kernel.org/lkml/20241211160318.235056-2-kan.liang@linux.inte=
l.com/
>
> I also added the reviewed-by in the new patch.
>
> Please let me know if there are more comments.

Hi Kan,

Vince Weaver posted to the list a related question on topdown + rdpmc + hyb=
rid:
https://lore.kernel.org/linux-perf-users/b0b0ae91-785e-64f6-348a-ca6edd448b=
74@maine.edu/
The topic of being rescheduled isn't part of the rdpmc documentation:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n610
In the testing we're only testing per-task mode and not per-CPU:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/tests/test-evsel.c?h=3Dperf-tools-next#n145
It isn't clear to me how per-CPU would work given rescheduling, you
could read a counter that doesn't match the mmap page unless you pin
everything to just 1 CPU. Given the issues with rdpmc, perhaps it is
safer in the documentation to cover cases without it.

Thanks,
Ian
