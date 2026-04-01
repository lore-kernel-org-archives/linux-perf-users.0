Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2023C13E9
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080046; cv=none; b=Y15gkRg9vvTa5EnXfPGYRusOi7+Aec0HIEG78Q1IgEXWdi6858hpg4m8zb38RcTNBslqOxSzjAJdWo2YjVmyTAKNYug19Z1La3IA1u9EuM/yH6USkM2b7TgnKOeweNLZUhETafZ9+yescUDJcR/87Yv7ghN2tUCrF3WSVQS8L/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080046; c=relaxed/simple;
	bh=mS4skdqdF42MJBxE5wzVp6JmLbGMbhhQoxsJdyhVlss=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CGYrfgdSLVYqfwJdeFSpOTZKhgJyrAUZLfnHNljCvtP63LZDnMiJjrxOkZJ5aCyEzMUgRGJWyOK0mSdBUZs6pZwwylQ3AYdrHeS36vsA/VJR5Y4yefXgxsxMkjMjSHb1/UKujJ/iioWdHgY+1wYrG44w7gbDZmVlAzWB0zQyW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5awwqSP; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5awwqSP"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso252933e0c.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775080044; x=1775684844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+32eYL2YM86TP+WDcoQ2ZnnlrwW2TcQiBmwchRAWAA=;
        b=r5awwqSPfynlx90z3zVuPFWZro88OX6fJNvK2VBahbB3kZe+cdKOK0VQ5WeWd+JX0q
         M4WOM73ws06q+L6IeUqR8dP2A4TM3C8d3iShd52lkFMjY6sVz4pHbQGkfBTv09KtBxnM
         CAfEkSc2Ej5OnRxutNAlv3M/nNEZDWcl9iJeI23Vb9hyEs0QrIZgGxsPY7plP45PPQ/b
         ZpVL3ps4XGlv4uuBhuje+MOQbglg8rR0F6PtzC279H03MpU+RUId0i+Zs1xNWBZG/smL
         PvmsdF8kqS8bglDq0UDswvfVI+zbzCVUJJwS5I59gdGwYPxeP77mgGb8yD/OjCPsV2YZ
         uMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775080044; x=1775684844;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+32eYL2YM86TP+WDcoQ2ZnnlrwW2TcQiBmwchRAWAA=;
        b=ZmaZ3fvZtnzVmmL34WuKBY9bmSYQQHskVw9O0W5Esjp6fKTgudq0gfHOqGIfxa5SCT
         t8/4AKNpyZNdY5ycSZmsrBWUiOWIUkwHrGsAN2Mftq3FLwmuIRBK3ScWhdVQubTU4li3
         wK3SRisJL7YYRvCYeYO1LGqrksqt3Fee1EpV2NOLA7McEgdoSlIeM/Jj8VGt5LPj2Chz
         MwRbnvf4DFqEPA+OMfWhkvxWdDCRQfLGfRs8knj5NF+R+kEZ+QgAxGmDjg8ToZqod/lS
         wCm6AQNufW6ZN2v6qEhKjfX8wKXXccE7WKBOKcPLQtwT1LqNfWrJiibsPTQQEh7z2yxk
         zJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHSn70a0L91Mtn/aRSgxvHkHAhT7V3own8pB/90gxsSsH/Gz0yr+K25tbEWR0KB0ffJx2QoZDNbH3uA+nAJ06g@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzr7rnxLYjhLIphSSa/6YslrdnK5VUx3K2ff9lCRMqKnak6rX
	uwQY0uinmDE1V7sBVHIhbsZdprx4KTnnxHxxEDdrJp7psi3qELK6e9pI
X-Gm-Gg: ATEYQzxHNh0eGfcCkRL0c+/P6W3KoxcLM6A67oC5o4o/mOVK0h0Nfwm1COZCxS5vJMO
	f+q0C9rJUHDEo3wm8O3OBZVeOSpgBFDj638Sh7b0nh/0UY9tM9C5PXYswCNhUGcy66AyipvHR5f
	SpEQiZaWUCK+Wr0qroZYfNVqHTCL6UBuSJ963CdudzRwnVhaH8G2L5gTYRu+Vt2UKf4Dfb3WEgD
	fz4r840tqVKJ4fW7SgIE8smkpqLkrUY19XWbEisLOYy4tzuv8BAlA8HsZ+y4zS2HsiK0TsCwLkd
	5C2E2pKv9IxJ9k2G3lvInxMg4TrG8h4mEvcOBIvcuam2T39KiIW5xpkF5vExnzCc6s3bhRoACx1
	rESOVWzaM7hB3EXxDTxoBaUkZ4QWXd4dsQ+QeIwxGagAa9Dn5n+Kh4mTNC9i/F+HpHuoi4uIFNk
	hrzZiJgJXIVEM6YtGIHq+J87aLQEln8Icw/FiVf4w=
X-Received: by 2002:a05:6122:1807:b0:567:433b:e903 with SMTP id 71dfb90a1353d-56d8a83d458mr2549754e0c.6.1775080043986;
        Wed, 01 Apr 2026 14:47:23 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:646e:2006:2117:971])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9b8d22b4sm1215795e0c.0.2026.04.01.14.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 14:47:23 -0700 (PDT)
Date: Wed, 01 Apr 2026 18:41:28 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/4=5D_perf_symbol=3A_Add_missing_l?=
 =?US-ASCII?Q?ibgen=2Eh_include_to_get_basename=28=29_prototype?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fXEVn8BBcQBfXSWwWYPfWV50Xk6FAgm1gCBxu=qqxoJpw@mail.gmail.com>
References: <20260401210203.2150651-1-acme@kernel.org> <20260401210203.2150651-7-acme@kernel.org> <CAP-5=fXEVn8BBcQBfXSWwWYPfWV50Xk6FAgm1gCBxu=qqxoJpw@mail.gmail.com>
Message-ID: <39DC6936-48D7-4284-9EA3-F3C31192A12C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 1, 2026 6:08:16 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> w=
rote:
>On Wed, Apr 1, 2026 at 2:02=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ker=
nel=2Eorg> wrote:
>>
>> From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>>
>> This works in some places because there are tricks to prefer a GNU
>> version instead of the XPG version, but started breaking in some musl
>> libc systems due to some unrelated change that made libgen=2Eh stop bei=
ng
>> included by chance=2E
>>
>> Since symbol=2Eh is using basename(), make it include libgen=2Eh=2E
>>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---
>>  tools/perf/tests/make    | 2 +-
>>  tools/perf/util/symbol=2Eh | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
>> index 6587dc326d1b272e=2E=2Ee12ff6397077806e 100644
>> --- a/tools/perf/tests/make
>> +++ b/tools/perf/tests/make
>> @@ -148,7 +148,7 @@ run +=3D make_extra_tests
>>  run +=3D make_no_jevents
>>  run +=3D make_jevents_all
>>  run +=3D make_no_bpf_skel
>> -run +=3D make_gen_vmlinux_h
>> +#run +=3D make_gen_vmlinux_h
>
>This looks like something removed during testing that you meant to put ba=
ck=2E


Yeah, unrelated, I'll send a v2 removing the header dir move that was alre=
ady merged, as you noted=2E

This gen vmlinux test is failing and I still need to figure out, seems lik=
e a newer clang is complaining about some struct forward declarations I'm v=
mlinux=2Eh=2E

- Arnaldo=20

>Thanks,
>Ian
>
>>  run +=3D make_libperl
>>  run +=3D make_no_libpython
>>  run +=3D make_no_scripts
>> diff --git a/tools/perf/util/symbol=2Eh b/tools/perf/util/symbol=2Eh
>> index c67814d6d6d6f64a=2E=2Eb37ecc2e90f77efe 100644
>> --- a/tools/perf/util/symbol=2Eh
>> +++ b/tools/perf/util/symbol=2Eh
>> @@ -10,6 +10,7 @@
>>  #include <linux/rbtree=2Eh>
>>  #include <stdio=2Eh>
>>  #include <errno=2Eh>
>> +#include <libgen=2Eh>
>>  #include "addr_location=2Eh"
>>  #include "path=2Eh"
>>  #include "symbol_conf=2Eh"
>> --
>> 2=2E53=2E0
>>
>

- Arnaldo 
