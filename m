Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835026CE39
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782950; cv=none; b=ArNJrU6X5zDFAD0CQ5LWZwgbc2/Ioz6MtSJMtaJ59ozo08ZkRiaholrGrIGkici52bntjMTR0o/Z/GVtHbeMuVpi3iFqAkMRnFzODrk5CFqee4APVldwYkw/n/Avc6to8S4hUbBei0xpoC3EIiRk1TonZsj8/MFUs7R3Px55fIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782950; c=relaxed/simple;
	bh=4vxf2RnJkdS/KWtDA/fpCooWg6P8QPnBazpuG4AQsaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx3/URYwanR39Td1D8ZqHf5Tb+9v+XUfAzLpMcObNNtZl3v4XTEINVmIN9pzajHL1RUENNZsjS2EQPBD+TzPmZCm+qYKld96rREuqWt7/wDwam1I/yheW0enx+xU+DLEl4VGERF8bue4JfKwmdE/ZzRCrsdJKXGUAOngLRrRvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4n12iIZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4n12iIZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso194405ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764782948; x=1765387748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MOEgxX0K1GDs91IK9KfGyysh+LDNkvthzxYy9neBS8=;
        b=B4n12iIZ0aleVlkX7EIa9FOLDR7atwEYOFGSYPYcbXsMoG6FVd/pWH6/6yH9Eaoic6
         GLYkInxzkMwf9Rp33QSOU7w364EhFDNUjYJ7zdbP981Lzmg7ihkJD90oczvC85wp35kq
         ZArPmeCgVkOm/5LJObPf4yNixV4pouNhrjXmMAy67VCGOYw+asABlEv912MdJlNc14FY
         Nqb3fqqEJ8ze1tKRrtSviMnUuEo6auxZvmTVLevp+jzoFxoJjdH001jtxBfzgjWweAUL
         2fQLUHxUkdRAUnnVeSYlypNjTTGFKFDZ4P/KdK9lo0yeEK+dhJ04ZbeyGqNYBVxHZ5L+
         8fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764782948; x=1765387748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MOEgxX0K1GDs91IK9KfGyysh+LDNkvthzxYy9neBS8=;
        b=NBAK8awyZnQC3jl+MIss0MFyqGxHOr8zdI1T3k/MKpc0ZkXnCLlITnmNU7q6XXP0jL
         XVH5Fd4WK65zE6W3u2HcG8/55uCOTJ9p1zdTS1+I73LKRN8+ttUiYPmnoSvcsWtXJZLu
         w1ABxbPAaP+LI4phTAEZndB7bqxy99pe+edxmhBvI80duVhdumusUfFRxCF+N6Pchfjw
         cEHeHR7D7vePnVLX3D7z5ZF3JSlqoTY/G87kbDrUBXokJUalOaeQE+NlgcD+pLIP8c4u
         OZo8PSKpxrbL4GfgH2GqP10sd0pW3KHmfOS7v83rB6SPzH8i17y+DH1IEEgCUMS+2BlA
         Xjfg==
X-Forwarded-Encrypted: i=1; AJvYcCXWIPxrFFDz6VEz3NGGC4z/FksLKCYykFouyeXqV6+c9EFdrEH9rveiMYMPS5r+zZgmzm/hm4wWwFkqukprp2QE@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfFqe401smoC2Drnsfbi764oIKjhIVoTEiHstDtQ8fkeH1ggY
	ToQkTvzUM8ZsXwhElmuT/iv0yZ/SehdMgXjNt1wm8a1WX5aQmhV5lTPSyt4Ovga9QWHugOLLm3/
	GMgSs1Nhj/XgmPwuSzQUslWv5U2Z+UNGLQiwrvh7M
X-Gm-Gg: ASbGnctA9hwJilmWj3rl9WD92lhVOBB4knHRHCP1wUYLxFw2o4IkA10X4OcNgEXzJDb
	HlBGS/9LDRCQAyWic/sTTTOJoKqcOZUaQhCNy8+aaW9OAE5mxBeBDPePYX93ReHJeL/W9LD1+ft
	UTZFUKeY75hGwC6QOmoyBQv8qHC7bhyui8t4waUc2TScIkWVlWIpaUcU0ZZuiN8iEufXeTsglzT
	W25wgbUAc2dtDhLhg7Q0VlvzdEOWbDkN9VXJc33L9u3k9zGdsq+mcumndfeb8PvLbwsrPTJ
X-Google-Smtp-Source: AGHT+IHcyPccJCIE/sjt6rkm0szFx9GeMxP90fWQbNQJcY7Har0URFT74QTMY3jyL63rOIueCdvDic3W+KsuT7Dg18w=
X-Received: by 2002:a17:903:2290:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-29d6fe3cc1fmr1867725ad.5.1764782947469; Wed, 03 Dec 2025
 09:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTBOG7H7OAST04iB@x1>
In-Reply-To: <aTBOG7H7OAST04iB@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 09:28:56 -0800
X-Gm-Features: AWmQ_bn9Mrpvnxjv4LA0cDCdaDihCFLrxNsnViJ9pXt4qMb8pZkgaLT5mFajEBQ
Message-ID: <CAP-5=fXgypbv6qdDV8nZXZySgebhAHXH1a1J7A8Wv91ko-+Qxw@mail.gmail.com>
Subject: Re: [PATCH v6.19-rc1 1/1] perf auxtrace: Include sys/types.h for pid_t
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 6:50=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> In 754187ad73b73bcb ("perf build: Remove NO_AUXTRACE build option")
> sys/types.h was removed, which broke the build in all Alpine Linux
> releases, as musl libc has pid_t defined via sys/types.h, add it back.
>
> Fixes: 754187ad73b73bcb ("perf build: Remove NO_AUXTRACE build option")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/auxtrace.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index eee2c11f76668348..6947f3f284c02928 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -7,6 +7,7 @@
>  #ifndef __PERF_AUXTRACE_H
>  #define __PERF_AUXTRACE_H
>
> +#include <sys/types.h>
>  #include <stdio.h> // FILE
>  #include <linux/perf_event.h>
>  #include <linux/types.h>
> --
> 2.52.0
>
