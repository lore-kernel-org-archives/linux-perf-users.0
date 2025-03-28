Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861B4A21
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743135650; cv=none; b=jr4+pOOFh+um54mRefRq3zNd7MlzUB5FaNjljzMZOb1ZOt6n1+2xAOLO6SioYufGUggYZnNi2HoYDb0mjWSCwon3y160QRHQUrMTxvQDR8lVYGukcq92ry9p489kUFcBoBGdQPhj2Z2QWOcpvoNr0M7csLLlz3edGrRf1pxNtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743135650; c=relaxed/simple;
	bh=4VvG6x9EQmUnaPxos72iekLFHhrDTBgN8+Z3RX8VReY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiN8xqgjjzFIY06RZ1JZs9XCBObgnaOzCSkSQj9zCkA6TGgjU9L33lp1Oj3oM9JUXmDnXYs3HwJceFnug/a0p7rbKovlqaZhhw9aNaX//UkfA4qndI3CBrdmyVXpRv5l/Z2gax1Vb1vs1Yg6LIwlKXBMnXrECGgjO+mz7317s3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMt/zlAd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMt/zlAd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so136525ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 21:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743135648; x=1743740448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjI8M30yNl0TGEXappoLSH56B+TzI7ZNLtph3A+iHC0=;
        b=xMt/zlAdBdheORVJK5vhKWsABpJg3PfuMivCRVav+JcMFxeefcoNwy3LCMnvPg6wtH
         URboOSEgDZSF7gUhYfPyaTa9HnxNMWUC319yNP1uVk42zDk2gmcb9NTI+LIaI8Gvg+bs
         05be0x26cgRwd5g2fZspeY5rJR+a9yCE0ZDnXToHAsKt9Fwu3d4+x+nOxRsvWz7OEXeX
         4SXLt41Ugyktr+i2kDiJdcUFeKOVhFevteOSez4UXVtzaSPGVnSCkaMR6ezccSv27Sg/
         bAuGE6kEQ3VF4NN3eJnCacs+B+mywzykIS9YnVs6PWJK74+kdLc1sSqFxJK+ZCJAgQqo
         NIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743135648; x=1743740448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjI8M30yNl0TGEXappoLSH56B+TzI7ZNLtph3A+iHC0=;
        b=D+4ID3dUmagIhnqdh43jLyHL3LTdHMFoVxKuQxGAQ3hnU/U+LxlczNEK1LoD55aC3j
         sJQAgwPvFfUfBM/SOmkjNeFXkHcW2cmwcWD3yzPP8ax8qusCbHzKRhy/WmJaDRKN745j
         8acL2NQjU1+llyvt74qO13i5wM1gITnmOLxgqezimN1Swrq63IVc0y3pIY1tb0Joo19S
         sOJfHWP6/Je0bTUCyxXfXbUfYvN6YXJzsBVZdymCqnz+gORzW7diUHbjc9KTi5FdVg4N
         nt8OrZW22Uq3RzJ9pLiI0Hu5wOp9K/K6RMmMb3j7jzGVou+grxy2DQOiwyDIZOKm9s+E
         Butw==
X-Forwarded-Encrypted: i=1; AJvYcCUvVuw0MVYeGvj/y6mTeVqPp2/INLlStOWEikrPswfj6gWl9V5B/QZsB2Q0r/nEmfcsIXWY3hIuMCzA7wKZXgdj@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcLKS2gAdtNgC5JHqKCBE79uotwq7ZtXNHP7G/6CLAmvJbgtw
	dJFR3KkqylDIXYOa7ZGqP5nA4cn+EhxbOMftq6xB8PqBkuFqI8ad61zOHJo1DZFUxeVxPG2ldk+
	/2Uf+iWCz5Ro/NID6wD8el9omMRnqIcR3bAOT
X-Gm-Gg: ASbGncsD/nY+96UKonlnyLfz3ng5TO0XfX5yTtIi3GAyiPnKnjPbL2xluquElVZcV+h
	ZZw2xeIEibFk5xl3dJtuW2bz5Fs0lOr/uDsJWDzVLOp76Hk1qTnCrckql4437jAnAAeMR95/5+h
	XH2c8ExwEQpuh5LAHT4/JT4HvJljk=
X-Google-Smtp-Source: AGHT+IFm9BzGAaqh6rhMTsdvArk8QYfZ4BiD7DS9eqvAjwM3xXPk4D7Y8NsBIWa8UBrfMNcPdTlEOa2Co9SOW5Szdy4=
X-Received: by 2002:a17:902:ee02:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-22920ad2e6amr1747645ad.4.1743135647450; Thu, 27 Mar 2025
 21:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327225651.642965-1-ctshao@google.com>
In-Reply-To: <20250327225651.642965-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Mar 2025 21:20:36 -0700
X-Gm-Features: AQ5f1Jr-scFYaP9RajDzeU_599eda8QGvwnthEF_v8Ujb_R1wC0Ccyq38bdPe6s
Message-ID: <CAP-5=fWv4=8Uq8jDbqNR3O+JAw-T0OUGoj5o=pMHxyFKsbEDyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fix incorrect counts when count the same uncore
 event multiple times
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	yeoreum.yun@arm.com, linux@treblig.org, ak@linux.intel.com, 
	weilin.wang@intel.com, asmadeus@codewreck.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 3:56=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Let's take a look an example, the machine is SKX with 6 IMC devices.
>
>   perf stat -e clockticks,clockticks -I 1000
>   #           time             counts unit events
>        1.001127430      6,901,503,174      uncore_imc_0/clockticks/
>        1.001127430      3,940,896,301      uncore_imc_0/clockticks/
>        2.002649722        988,376,876      uncore_imc_0/clockticks/
>        2.002649722        988,376,141      uncore_imc_0/clockticks/
>        3.004071319      1,000,292,675      uncore_imc_0/clockticks/
>        3.004071319      1,000,294,160      uncore_imc_0/clockticks/
>
> 1) The events name should not be uniquified.
> 2) The initial count for the first `clockticks` is doubled.
> 3) Subsequent count only report for the first IMC device.
>
> The first patch fixes 1) and 3), and the second patch fixes 2).
>
> After these fix:
>
>   perf stat -e clockticks,clockticks -I 1000
>   #           time             counts unit events
>        1.001127586      4,126,938,857      clockticks
>        1.001127586      4,121,564,277      clockticks
>        2.001686014      3,953,806,350      clockticks
>        2.001686014      3,953,809,541      clockticks
>        3.003121403      4,137,750,252      clockticks
>        3.003121403      4,137,749,048      clockticks
>
> I also tested `-A`, `--per-socket`, `--per-die` and `--per-core`, all
> looks good.
>
> Ian tested `hybrid-merge` and `hwmon`, all looks good as well.
>
> Chun-Tse Shao (1):
>   perf test: Add stat uniquifying test
>
> Ian Rogers (2):
>   perf evlist: Make uniquifying counter names consistent
>   perf parse-events: Use wildcard processing to set an event to merge
>     into

Tested-by: Ian Rogers <irogers@google.com>

There could be minor conflict with this unreviewed series:
https://lore.kernel.org/lkml/20250318041442.321230-1-irogers@google.com/

Thanks,
Ian

>  tools/perf/builtin-record.c                   |   7 +-
>  tools/perf/builtin-top.c                      |   7 +-
>  .../tests/shell/stat+event_uniquifying.sh     |  69 ++++++++
>  tools/perf/util/evlist.c                      |  66 +++++---
>  tools/perf/util/evlist.h                      |   3 +-
>  tools/perf/util/evsel.c                       | 119 ++++++++++++-
>  tools/perf/util/evsel.h                       |  11 +-
>  tools/perf/util/parse-events.c                |  86 +++++++---
>  tools/perf/util/stat-display.c                | 160 ++----------------
>  tools/perf/util/stat.c                        |  40 +----
>  10 files changed, 329 insertions(+), 239 deletions(-)
>  create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
>
> --
> v2:
>   - Fixes for `hwmon` and `--hybrid-merge`.
>   - Add a test for event uniquifying.
>
> v1: lore.kernel.org/20250326234758.480431-1-ctshao@google.com
> 2.49.0.472.ge94155a9ec-goog
>
