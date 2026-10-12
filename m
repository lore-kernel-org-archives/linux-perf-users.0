Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C938C406
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838857; cv=pass; b=DkAdxRNvmofChUUW9Fa+WwWLiMj9zAhWK+X0XllHWlLM3lRSNTXa15C1Zim/tRG1OwlgKKIU/c7JHTbO8tqpAMkrQo1VoPFn8RfD+l4vEpuXujNjOMY8+fq+1O5zl89O5hGwdqqZ1pH/Cq/cXI6ZHVIFZoyWdKNw9HHWzc5KHhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838857; c=relaxed/simple;
	bh=RPWn2ag572L5mE8SLg4IzDataxoyag1Rmk6FWVBoUgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrzcc2Sr903fWmM+UXuro8hwLBBy15GTMKPHNDiHGwv5EdYUq91P7moMm/uHooiRowtJVmrfmM7ZTdaF+va+/mmQ1xjEINF7RQcwFJL5Oa938uRXMQCoo4GbApe8xFQIgbQzHQ8vimlCLj4nmutyawtSc2MhivXioV0toPl+eVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKIOnrTj; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKIOnrTj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53584e7c349so548781cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791838854; cv=none;
        d=google.com; s=arc-20260327;
        b=SGH2YCfTWxOprtrhRdXYMBIsEpBkuMFCpuHy/hua3O0HkhNqFYkaHcwAEyYhz+Rth9
         kESowpJPaAfWZYCrAIY8gAddtcK0Xdn8dsnlxuVW17Z6iAdK9/ly89RwnxocEd+FRIkX
         1Y/+27D9mqjYDT7NUvupC5c4EqDTpc25LC7GJpi81ixwixe7K01NBJ9oilSw/smMZLnc
         ydy5JYVzXtojJzKKC/57ls9vRed1qwJBs0vamTQNuypGwOZcdKpnAFvXYn623Qz1gmHb
         TFTWG8K1Y9J/N0rV8d4VaikHeTUfs+ZlQqOrHTaz9poVqDHWyxIOMLOnM33rQNb7pXeK
         pJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clWRW9vCkWtW4QnqRq5GkeFZYURlC39kF4dyGW5O0So=;
        fh=BUXYNYcqz53siR8XyFuqfoDkY3onrkaY9gbDrXE+R+w=;
        b=Uzz3P0rsSTRuNrrYBdqPGdnMpKpbpGLhY9vgcqR/0ShzIR9rjigeQgkiApWWWKgXpy
         ICTBM6rW3HNdEs9DJoGJxY+0AufsQ3KojupuMytDGn23EAgvRBSPsaj9hgtAYxz5Ap3n
         pQLBhW5YHo030oa6tQldzy3At3LbthUTuZivDNr6EA4YJzfjYwlTLNsj3MMX6XymlVWv
         UxhnQQie0t952hH5h3tTXBTP4cV8csneUNYEpcU/d9hAYMxs5AHQulFlHx/4nsnfHEnR
         6zGqxS8cjF1Y5W2PCcWR/XqeMV8yPheGbWzNveI6iBCN+c4GyooTkv/MsoJpOMPBkgTw
         hobw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791838854; x=1792443654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clWRW9vCkWtW4QnqRq5GkeFZYURlC39kF4dyGW5O0So=;
        b=fKIOnrTjP6jCQF1JZu/2cHlt3bL5cn1FbJgakxda5336Xu9UiqGbX9FaL5BWqNLYWb
         E14Jl1yUxKI9G9T3RyHZLXuErX6CQjyhUVpUAHeT1zoTX5aH41AP1NIKo9M8x8zRK8fv
         OZtRvVVwj0OiiPMgLVNNvyQEdiB/STxgkpyP4rpMTgSATHKtS5VrqwRh8jzOom5+mGdp
         Fgp16Au4LckcpWgnJT/WHK7F1/QIdFjnT1yHbMXeNXUXj+FqJhvSJjAYzvAVl/cKVZ9I
         Pm2UO5W4j4BzVVi9wteg8qk8YVJkOTfbGjsYNkwWwpE/cCpxZRA73FuHLvNbE29gMG+f
         YaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838854; x=1792443654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clWRW9vCkWtW4QnqRq5GkeFZYURlC39kF4dyGW5O0So=;
        b=nO6e1BUwbOohtxCIJc9UyKx+rzEWh8veL5WRaodtvJLFRbLwVrQu8fDbwuSdEI7D9h
         DDFuC/o0SyxLnI2xfGxYOiONtf8NYJukzw1mCaxaQffhiqgde1ZMyMUunqzrqB44rwrR
         ALDXkJp2Kcqdsmu7NfvjyU4t9w6OVAJx1kdslT+/8E6dDFISFwga3ntEGjLwOiBJ7zfh
         20kjZ3+UAuJyTxLvKhj5JrOC5cYrI/ChCHp/J8Md6zk1DLNAR3guVynvYxrp/nP/6ppV
         bM9eIIvdPQfMAbCeAhQ3X/2Pl3vOtyJT8HgTdhZEoKifZILFiBqQTIiUZdRBMxYBfHDx
         kLaA==
X-Gm-Message-State: AFq9FYKy41XR3BCkUfliRjYokXS7Yj7iGCUJVEo5vZ7vvU8D6V+LtTpH
	mYE6d4exBE08yskA2exjD0TbmiXQx37GF9xEaCrQbhZkLlefDcpoKbVi7NOHJmfmcjT//DRayR+
	GRBwz/S5sE+amsHzPja4U3NngoqKT1HcXSqin0nlZ
X-Gm-Gg: AYBFou2Md6CtBIDm5ZYLGWe9t/4jeH3LBRVEJ8VZ97L+WtCEPvzdJZw/ydBbpiIS8rV
	MAd07yjLFiQ0Ud5VP/vIMOxs39LH9E/reCx8B/UBsULGm7AIdc7Ar9UgJdIiaVIwDXLBEJYgvI/
	Ypsfo5aZWRLIYspgUKmqM0iZBkSE7rDE/A6url03atvH+Vj5+t0cpN3PhxPrpPsppVVKWab0cIC
	L94v8+rMX+8QM8foKD2/NYTB4Ux7nKe8Yh4M7c8nZ4dy40xWATZCJ7DsDM4r2R/17/Dk+Lc5uNZ
	fC9AvGIO3AYTLO1jvRQfEgeDCJ4jtqPoX0SsmfENoLfX8BQhq7ho0BFSUK0BL2uL2GJvK7fXo67
	QJTEbGneerA==
X-Received: by 2002:a05:622a:413:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-535b325f8d9mr39764741cf.5.1791838853558; Mon, 12 Oct 2026
 14:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791791463.git.sandipan.das@amd.com>
In-Reply-To: <cover.1791791463.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:00:42 -0700
X-Gm-Features: AclHuK9NIwJE_wp5nropDNhRmE-lrZW-ykVRU2dyouDnk3qNOnHZwmVvrdG_4VU
Message-ID: <CAP-5=fV5523WDsHvzAXcjk+-H3ANbFm-nNTxvooJr+fJY2T8kw@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: Add Zen 6 data fabric events
 and metrics
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 12:55=E2=80=AFAM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Add data fabric events and metrics sourced from Volume 3 of the
> Processor Programming Reference (PPR) for AMD Family 1Ah Model 51h
> Revision B0 processors, available at the link below.
> https://bugzilla.kernel.org/attachment.cgi?id=3D311021
>
> While at it, also clean up redundant attributes for other metrics.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> Sandipan Das (3):
>   perf vendor events amd: Add Zen 6 data fabric events
>   perf vendor events amd: Add Zen 6 data fabric metrics
>   perf vendor events amd: Remove "PerPkg" from Zen 6 memory controller
>     metrics
>
>  .../arch/x86/amdzen6/data-fabric.json         | 1542 +++++++++++++++++
>  .../arch/x86/amdzen6/recommended.json         |  107 +-
>  2 files changed, 1640 insertions(+), 9 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/data-fabric.js=
on
>
> --
> 2.53.0
>
