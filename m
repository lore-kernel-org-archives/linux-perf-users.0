Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCF2E5400
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813551; cv=none; b=j6zlIUQzongicRyAVca1rt87t6Xx2Fv/R6FIaBx9W72IPS9WP0UpO90gPGLnx7RsMfmcE9OihOl59vZ0MlUUK9o2PaiNIG6UXD/gyYpfFPIoqhDSNqke5w460bpNMK/4bsrduFTeiCerd9rYYentyQYqw1aTS2/eUFOob6ZB2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813551; c=relaxed/simple;
	bh=EB/Og+b+iGBdj3yiP+ao1ybCVJ+QxFP61rwkgwxjfZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfCQf4S5t4Y3mymb0uZXauuXzQYspz/IFVGMZoT78WsCFCh7h5KLtuy8Tw/fvZLSGhuZEWeKRMCPALgcRmp/cOJsXbgPP30i4xKF9CBq8lNs8YTXOL6cmk2ikfQyFci7QAGBJooH4ZBkPBehpb/aEsu+hkTziOQhF+S7j06omuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyQKFE7s; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyQKFE7s"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so424445ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758813550; x=1759418350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU3JGvSGpyxpYzs0mUzQDCmIqY2mfW9vcvUuf9tvqIc=;
        b=WyQKFE7sn1IvC+r1MGMMQYmiJR52EFsMA2ZplcpDT8B+Z8ygBpEjVXsybIKfNXs6CA
         Deu+USxcRK113IN7izPYoE9k1wD05o9WgZEuaeByqx/C/jfheXWhmFRetN7Z8Ulhl+6V
         kf8rADpVgpxZi83nLa6rGrlsiCwNQhQPdaFmk8WjXrjp4VN3V0LOict2m21v8O3SFqUt
         pIIvRuZMfay0TdZegZBmboUWnmoQtupdY40hHzSVXL9/O29fm5W/GUpSDG92YHxR6pFm
         1uuSdYFf+Ay7Xcl8/Qy314pbbC9OA3QDP8OdoUl0ch3jd7w7f1ObW/By1E7NcVvLwUu0
         ZhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813550; x=1759418350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU3JGvSGpyxpYzs0mUzQDCmIqY2mfW9vcvUuf9tvqIc=;
        b=lE938h1KPRS8cWPbPst+h8BamjKlHAHowrhHYRwho6A1xFxuhincAQsPiL1zS1xy4o
         DM8DEWoPc0fe+r/77mWy0BuYxldBzbz5tWOGLe9iUtaNF1II+PhtzuZ061YPty6/mEwy
         AI103W+bFoTLTWHoQP2JFyN29nOGqh5yybpPzgSj2PYGKmBvlz7qA3sJJlqvs/6hynXm
         ZXAwOiZlNBg6Hrc7/8Yi4iSL4jW2DZAItC+MZz2ZlKV55S0mkncorM7ImvIlulkKxiYc
         BDL8d+1isV+xLeERiZcdP425tjZXOgtWeVmM9Z7iYMWWwdvHq3yHeq/6hmYYcVTCVfmy
         +/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgYU6rk7ly4ZqmqESymcld050+mgUdgu38ETEKlkpB638qoAtqUEDT3yPl7ccjCKLX7o4D+N1AXaQ0B4hndaF2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mqKIpYzGpgEvYzfPJLQpFQERlsZMMKu6T2UpyDh2rDykXHdl
	dYx0v8cr3dan45s0RqHEC1VHd0XCHXXhy0A04QcZKyRPbVgVDuG6STG75Tf99AyF+x7hB/zJDQT
	EXyxfcn0/E03gbxiE0RIRypSnr9vc9Ul28X79Ua8N
X-Gm-Gg: ASbGncuHRv+A9vhsI88yQdsuVbpkLdwIpGyqbKwUcMDGCQNhGff3oyeqwSWexUBujpb
	FoYeD58hAv8oDI0rJwR1FBpYvlBOPYTF3wAnLHpG4wH+alA+eizjgVIE5tdmVJ09Frd34W9j87U
	9BpWAPig33SVMNS7/ljlayaeyVsD+0OYaS1QLOkXm3L4ZGjV+UShe2mki9jFSU+8ymYoKB8ksrC
	/pN49CgS/VTQw4nANXHuIqKyOgIwqdHLNT34a6FdPUzu0iZ5bqh
X-Google-Smtp-Source: AGHT+IGGL5fE/W5NbXgeUTpmEaMrB5ESy2RBa3qikd1fthwkw7Q1SE7y+sOgT/6eBODaZrn1GFR0hZtrZyq2JqZvysA=
X-Received: by 2002:a17:903:90c:b0:267:d7f8:4054 with SMTP id
 d9443c01a7336-27ed3fe68a4mr5269935ad.16.1758813549164; Thu, 25 Sep 2025
 08:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925112614.78061-1-m.heidelberg@cab.de>
In-Reply-To: <20250925112614.78061-1-m.heidelberg@cab.de>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Sep 2025 08:18:58 -0700
X-Gm-Features: AS18NWB00MrDrgFULezqEiwJlL7_KKyqX1CRRHQHckecyYPzcM1Cc0pyvFtw7eA
Message-ID: <CAP-5=fX3rdL6zrZozPNS8LiTpD8S2vfMs_3QPDQYdxk49t2VWw@mail.gmail.com>
Subject: Re: [PATCH] perf: fix duplicated words in documentation and comments
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:26=E2=80=AFAM Markus Heidelberg <m.heidelberg@cab=
.de> wrote:
>
> - "the the"
> - "in in"
> - "a a"
>
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-diff.txt | 2 +-
>  tools/perf/builtin-script.c            | 2 +-
>  tools/perf/util/hwmon_pmu.h            | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Document=
ation/perf-diff.txt
> index f3067a4af294..58efab72d2e5 100644
> --- a/tools/perf/Documentation/perf-diff.txt
> +++ b/tools/perf/Documentation/perf-diff.txt
> @@ -285,7 +285,7 @@ If specified the 'Weighted diff' column is displayed =
with value 'd' computed as:
>
>    - period being the hist entry period value
>
> -  - WEIGHT-A/WEIGHT-B being user supplied weights in the the '-c' option
> +  - WEIGHT-A/WEIGHT-B being user supplied weights in the '-c' option
>      behind ':' separator like '-c wdiff:1,2'.
>      - WEIGHT-A being the weight of the data file
>      - WEIGHT-B being the weight of the baseline data file
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d9fbdcf72f25..f731b6de7f23 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -223,7 +223,7 @@ enum {
>         OUTPUT_TYPE_MAX
>  };
>
> -// We need to refactor the evsel->priv use in in 'perf script' to allow =
for
> +// We need to refactor the evsel->priv use in 'perf script' to allow for
>  // using that area, that is being used only in some cases.
>  #define OUTPUT_TYPE_UNSET -1
>
> diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> index dc711b289ff5..d1e403c8b70b 100644
> --- a/tools/perf/util/hwmon_pmu.h
> +++ b/tools/perf/util/hwmon_pmu.h
> @@ -37,7 +37,7 @@ enum hwmon_type {
>  /**
>   * enum hwmon_item:
>   *
> - * Similar to enum hwmon_type but describes the item part of a a sysfs f=
ilename.
> + * Similar to enum hwmon_type but describes the item part of a sysfs fil=
ename.
>   *
>   * This enum is exposed for testing.
>   */
> --
> 2.43.0
>
