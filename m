Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E999352C4F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786652122; cv=none; b=KBhrR/Mg+H2bcT9K3ANd7vOvq5E/S215V0iMY+NwBM3zzw8mcGnepEokwKAlLEnKltCBApnwJmuhg7B2EXgiFaMBXwb8QgSqea6bmcG1gr6dYQtcvFzURekT1UUOH8slgW14tb/6YUOX9S/Rb8B4F5SBV+J5GGcqr4Ykq++ZpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786652122; c=relaxed/simple;
	bh=f+5LyIKmrO/cS+5dVF4j7KVYt7zVS3wfi5aQQ7bKMMM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nfY1ELwwrqqPaJskSYnBz1HXmgaWDslI5H/CM+znsC3eEn0v1Z97bzGFF9FC5dVSvZWW3hOp/+D2KxeffQbC5RZjwMXOj1ZCx0cy+43HxQxFWK+BQ8IfnbDf/h3I29YIECXoP4i+0bzbTXBCp0jcUaeQ6xWHYx0SFMGvpVj8S2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAbjCXAE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAbjCXAE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-496b7622a83so2329805e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786652119; x=1787256919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=13u0YxCZPSlV9ZE2sP+na+gkKwKP5lmIOhs/9lTvroI=;
        b=AAbjCXAEqGwY1rteN4fBI+uCAA8k4dePCbzapovYtvQ/tHu0AbdJBofYnP4Dz1pmNb
         vZ0zdy7G2GugfUowVEv9DOD43T5IIdvS/miSQ2QMJgVmZiz3ABBPE6bN5A3GoFTS/HP+
         wHnZCgSzOET/9gkHUVY0FcFVrrTasxqFa5aEI5W1kcMiLZKfW8Isw3VKwJFSs8pKfqOl
         5surOj5JPH93eMdjfominRgruwEmudf0ML19m4aVlmvP4rygnV6DtQdCGtdrlcy6tYVn
         9pcQzO+U2knsfxslaJwnipXrDaJCQdL8Zq9FrjOeM1RPX/k/P0qdjaHQ8qsmebCfafYE
         G2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786652119; x=1787256919;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13u0YxCZPSlV9ZE2sP+na+gkKwKP5lmIOhs/9lTvroI=;
        b=IgQAni92/+r9OsHEvce8CeblzEUBYa5SX4Y2Yumpz5jyOiwyExGRvWIwm/DLgeE/gP
         wN9fwG3TeccyOoUuzNEbM5wL+FoAeRtVv2pPVodxMy+FFGpyyzbsLPRoW8I2hlHU85Md
         vEwEA3byhGbeEikfisOTMsy6zSNMkKghVQAiQ4IFtfupMS2GWpBNfwc6ahc6Z8z7NiSb
         PMjnZISwkek0hHMxkLx4CQeIur8PNm7irkv6dsmHOXNCUmyxJ7uyjyTyAr1YVPLMzMBA
         OVSc70XX53mMCnRDAYNuisqD+8gbFN+37cB+2DelxQi5Jbmh+HWilrveP2OtANXx1ZKK
         hb+g==
X-Gm-Message-State: AOJu0YyWMJzZm/DX4RIFbAPAGlzf3MXktkiPDphMmcwVCAjhpo0unrK5
	Ksvk1DXDzSl24IQfIEjgZl/UvUq4H1tANKe8O1cmCd24p6Q8FXKCI0l0
X-Gm-Gg: AR+sD12OKVgBCE62dw7pIjdkeLAwI6cmZBE3N1lSKjUwUHlaRMJeL31J1CzWjZvkueE
	JAMTEzdEEafg6p721DKnz5JnihOUibsK9z4NFwMpkrG1pjjlqmtD11EpbKTs+OGVMBwivlabqit
	0yzG+vEVyJJHt/CIK1T29TLl6LSFm1kiNiKn3QCxwenoA0hebJo7pJqhmJumZfkWuMlG8JPznqN
	LO9tBNu0/EeoVSXa+tqc4X9AIkyPsWRFSkbh5PSCJFiYoFrgGqRW4QzKC7wKp851ojzz9qC8cA5
	Sj36C6X4vACDGpxecp/jodhvWk78jKGFMyCizjAyJbtZgVwibtzLS5LHQl+ppi/gnUihztcNFXn
	HDIk1cFfdjoO3z8iLd5K2ixZkjVsSXIIHfsm4w8B5FHyGNEyPUKe1k5J76PjfbAdBgiC+ym3nJs
	k5ULFBAWWTriKFY3iE3oFzeg8++1sPk/k9jUBSNi1Jucz2mIwGBseesRP1BwRFcrfqCW99F8Tip
	tEIlyWI4TPQLepeGXnVT8C+lCvbJ/yn2GnuW1fCoBsbZhKxk3QiWN7948L2T6iZGZ10unXDn6P8
	daxNe0pAP56l6B/h1zlZTgfbEdQJra+IlyPu9KMK/Hez7u4eMREl9zF/p6VMRhV3mQESrI6tKrG
	gDm6Fk0Hj
X-Received: by 2002:a05:600c:3acf:b0:499:728c:4704 with SMTP id 5b1f17b1804b1-49987979c41mr13378855e9.12.1786652118957;
        Thu, 13 Aug 2026 13:15:18 -0700 (PDT)
Received: from ehlo.thunderbird.net (adsl-89.91.140.29.tellas.gr. [91.140.29.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b5823fsm90924295e9.11.2026.08.13.13.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 13:15:18 -0700 (PDT)
Date: Thu, 13 Aug 2026 22:15:05 +0200
From: Michalis Niarchos <michael.niarchos@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>
CC: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf kvm: Fix memory leaks
User-Agent: Thunderbird for Android
In-Reply-To: <178656887896.4021779.4825437848306350814.b4-ty@kernel.org>
References: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com> <178656887896.4021779.4825437848306350814.b4-ty@kernel.org>
Message-ID: <6C786771-AFE9-4DB9-A5A2-DC3D024488B5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 12, 2026 11:07:58 PM GMT+02:00, Namhyung Kim <namhyung@kernel=2E=
org> wrote:
>On Fri, 07 Aug 2026 17:08:34 +0200, Michalis Niarchos wrote:
>> Running =2E/perf kvm stat report with ASan, revealed some memory leaks:
>>=20
>> =3D=3D206006=3D=3DERROR: LeakSanitizer: detected memory leaks
>>=20
>> Direct leak of 72 byte(s) in 3 object(s) allocated from:
>>     #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan=2Eso=2E8+0x12bea9) (B=
uildId: 7f2845989b820f536270e19ec47df085ae89a675)
>>     #1 0x55f42795a0d5 in zalloc =2E=2E/=2E=2E/lib/zalloc=2Ec:8
>>     #2 0x55f42782d7f4 in per_vcpu_record /home/mike/git/linux/tools/per=
f/builtin-kvm=2Ec:929
>>=20
>> [=2E=2E=2E]
>Applied to perf-tools-next, thanks!
>
>Best regards,
>Namhyung
>
Thanks for reviewing and applying!

Kind regards,
Michalis
