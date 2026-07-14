Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16559423EB1
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071782; cv=pass; b=tTO82f+RlA3TgQQc74Tjy8TFI8Eisi1Fx9A1poZCeiZvUHo3sG62DJfb1f8sFv7pWT9/EyEK/eE6f6btTYM5aZyK5SJQKezMu0xleCaUPUOKzkFDKglBHQ/FWQcyrWLLEvPtLsy80062PqpVp+rYiEBgg+XmJazbXmvdxIMDaEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071782; c=relaxed/simple;
	bh=VI7F53F1lytouzE3MzPAFzdnxYopYLo7otLzhyZcvpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keHqu/FHhopG8yDPmRayWcuO8C6xZIDi7JefeBCNlhaheJMcsn7dPchHfeWuRAiaCApPqoLRDWnFKS1whoPfnqYH3atNZxKOR1RCQLA+uuUOsWvN2gOO5xitVUHMS4iAnHfWeVWVLyIgPOjXV7INZZ3FT84JN5ZRvpUOlcVMaqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PR2UfHk/; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PR2UfHk/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacef7d299so13135ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 16:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784071780; cv=none;
        d=google.com; s=arc-20260327;
        b=skIR7Y4pMLw10cD3kGgiwfBEUMregwmkOMGEjsmaU3VhnsVzT+n6Y1fNlqqa1pnuwh
         z7t0G6Vij4+j4DSMnGUKlivu2D9DbE7jVbH4qh+cEV2osQGDsFzmsd5vEkYMIPbKsmWO
         hqMkUJ5Dwhj3z5bNkEaoNywA/jZlefFqobp+vJ8AmlPSaKfKShEyeR61WuVP3eiFGh7X
         XlPExxg8T5aP62IoJRKvnKb7ypijekEY0yz7wpHtxa7rT2Ug5LgE6HQQ8p4joDe510+j
         2eNDpCGuRRwW2AKsENviJEspdAZPtKRG+006Iyx+8zE36ioWTMHayqmleNItWGIZ6qwS
         dGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SqIfu6TCYwwPWT+hZQw1ejGoSUvEQkgWBHvUnOnIjm8=;
        fh=FLVV3ojr9NVd2yxjScV/bk6OgOF1MsfKmkJbSxkFOIM=;
        b=P8vADKYvs4lclMTR679KnhXqY0vYkLcihmm8oyeZ+BRGDEsyKbcDZtKS+RS0dJh21x
         xHv14NNWJGg+J2kkDeUM8PLuDdVdlkvAwyBKMsQJlHw5X8G7OFmKPNZATyuZOXtyO0C9
         wOG4nl5O6u+IA9DojG5MfMxQLrwUiEA/vrEFEe1Ao1ctnqr6+frScfuB2kSNmCZBfYnS
         0vWkzbdjwWksaecrfJeI8uB/1lgmhF/ALrQBF1rLhCdHlojJqKb5AAAM4c42dLAKZurn
         09rIWK3Q94yZrcYBcyZPwwLmQAVVXyGWBtu8mR+UuqYGz+YYNLEFLIYsO0Ggnn2gapH4
         q2Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784071780; x=1784676580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SqIfu6TCYwwPWT+hZQw1ejGoSUvEQkgWBHvUnOnIjm8=;
        b=PR2UfHk/iSvb+C7ujxsPVefyQRmWh5ygSGVbE5mSCXg30Mnf1Nu7KBQC29DTH5oa9x
         iHy/rMd5BQgo8PWiz5gMP1UWSqtCHyD+KjMRdYdhU0aY1Y1jIU7nU2OKimqS+enDR8ZH
         ftFMhhOGJ37QbT4Yxzbc4Dnc1U1EsAwBb1sdZE0ocEkCc1cQpWiyS960Xxul+7ExF+w1
         7W2+iJDSi132W9XOhH8KoHr02Ydq4wxqBnq8p1RpkS4GlPdsKqyLTAyL39aektcBz3L4
         PHwsbnYlN4T0PtxVPXHOkIdQuULYlwNa3ahpS3UlMYYB/AfU4J/6SWBmTOhxCaGoEycB
         Xv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071780; x=1784676580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqIfu6TCYwwPWT+hZQw1ejGoSUvEQkgWBHvUnOnIjm8=;
        b=rdIt6BRLtgLQpFRjAJvisieuVgkxATAqRX75v+g9RA1FCKiX84Q3+SjPZ4KR5p/I1k
         I8areDlPkqt0CUPbTY25exQYRoivDMbmzgfUk2Y5KdedbUVZMyTkF5mAovxHS5C58gZM
         +CWd/opGrlEyDyZDxVycgYU3KFt20eG7kRugOqV31xnlTc1yePaMshWrEHMIYB9cOeyf
         uzmOadHJ5+iz/YLHXS0jxFFRYm+MiQOmuvU8TqGDotCUOeu1z9h9dCgHRosR844HJlLL
         7//S+Snet7c1fJJCaPvNSNiqlGR0s/FBF/2aULsHn44+Cx6PVJ+TM8IoDWdv5brHVLXK
         bK1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr/gXYQJqldmliK2yysEpS1B5dsYVT30Euv1D3k4+js20h/M4kfYJqpl2SUci8NvUd+XfUb9e1E/HX61vwsPh8y@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMTJViTHPrWOX99Td79yY1Ostecso54jlqzC7qlo1aUctSlZC
	3mqtdISkhewJ91WNBQ3NdA67FJozOH2Xbdei8t8ozRlX39oQyw9DjAR0wxxMOP88U5TCdFyg9xG
	N5ShVhbzBs7ViZEhnBM/VYsCM9SryiGuGUlJWNseL
X-Gm-Gg: AfdE7cnZXUSgA381iOqJiN+J727FeBgtEIJAInCgQBn3laCwerJSEbsd0kD1OU2lyuu
	q71gAEO/cHe9NT8fZRvKyFbrbGZNtDLcKDYTMjCU8AYtWl70zvoMih+3tW7ukNzwjs+vGeUFsOo
	zTbg5FMqRw3R/7i/AwTo8omcdHwyRA3GuOplCcSzCPMklD4kp4PAtDGA1xIoGw+y3ooEkZQkVkh
	2yL+NSl4v05d7QUpnV3ZZDrUbUnriN4YMI2/QKvLCSWtiPIbWqgr5Z1fIV3LdhB/2bU2KDxGg==
X-Received: by 2002:a17:903:3884:b0:2c7:df7a:859a with SMTP id
 d9443c01a7336-2cee1c0873emr7670375ad.15.1784071779849; Tue, 14 Jul 2026
 16:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com> <20260714204044.1952031-10-ctshao@google.com>
In-Reply-To: <20260714204044.1952031-10-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 Jul 2026 16:29:28 -0700
X-Gm-Features: AUfX_my4c-WsoKrxYXeaoOfL1ft8QKxzv-4VVUEC_ByYWadaMKQ_TgbZ8jSysyE
Message-ID: <CAP-5=fVc6tw3hfnvB7n_UZ3B5JF7vBpm7cnE8516t5HVUWwFNQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] perf vendor events intel: Add novalake v1.00 events
To: Chun-Tse Shao <ctshao@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:40=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
[snip]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index a15cd3280993..7bbb8b237b35 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -39,6 +39,7 @@ GenuineIntel-6-8[CD],v1.19,tigerlake,core
>  GenuineIntel-6-2C,v5,westmereep-dp,core
>  GenuineIntel-6-25,v4,westmereep-sp,core
>  GenuineIntel-6-2F,v4,westmereex,core
> +GenuineIntel-18-[13],v1.00,novalake,core

I think we should avoid editing the mapfile.csv and just use what
comes out of create_perf_json.py:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
To avoid the strings differing we can modify get_cpuid_str:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/header.c#n70
so that "%s-%u-%X-%X$" is "%s-%u-%02X-%X$" (the values are vendor,
family, model and stepping with the stepping being optional).
This ensures the model number is always 2 characters wide, zero-padded
if necessary. I don't believe this impacts any other x86 cpuid
strings.

Thanks,
Ian

>  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
>  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
>  AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core

> +        "Unit": "cpu_atom"
> +    }
> +]
> --
> 2.55.0.141.g00534a21ce-goog
>
