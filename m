Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E263A1CD
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783931; cv=none; b=Ylm+0k9mOjWqBev0pi/mv0FYXfr9S/3fZyD7tmmHR/4XPYKSaqXUEtCFr37pdStVXeX5FF2CTKdekAyBVUwmTuy1jFy2xEE23WZILyJ8/qucWpCSLI6wV+if1nLp3LxuRGU821ZBfqv6BctQAGrn4p0/hfMmG6vC5Qyt1GxLlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783931; c=relaxed/simple;
	bh=Dfgbo6phlRYs3sHOaCfT7tdl/yidpZ1QKIUrWxYX6yk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dWo06679aqeB46exsEaZFFhV7NUglqZlfntoy4LMbTJJU0lw6lYyQC51fKXCdUgHq5TNOiuHEh+okenkF1hm4WJungOyZxD8sQO1zV8Xzgfq6/cWewXLVG3tbyz2ZVMhrJBeSIY63+uernhuv/yOQ2KYx2PVja94b3FNR2P+GfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs5o7M5N; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs5o7M5N"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55ad466ad1eso652163e0c.3
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767783929; x=1768388729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VKTt4+AFKpYKvPFTTRtpqXGnVYTIMubv2jP5/7+T4+I=;
        b=hs5o7M5Nh17lsyRRJsoUlfm0ghFFe8DW06vaOWDFM4SgLSYZrLXxkYKGD2us9tHNbn
         am3FLC1a5EoTlM1TaF3K8sETAsd5QSL4s2dRf6He71t2iQW6Kz44W38WNOPx7+MpmRAr
         MfepmufBu/JnKlFqx3nkEF68KLHH31g4zfmR8oxbJqSqukA/gktAMF+oihtyJoW5It4j
         mH0kBGPzn/VRKd8z0Tiq7JzhbaruYnV6eSgB3mP+4NNWqC5YaRK94asGrcrDKcwcXc0C
         dRhOzcOACjchzmqZ1+Ow6Csq0oEQDEyCXemobjYQYFDYk9GZerEa+kk8LqoAl5G8db01
         MDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767783929; x=1768388729;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKTt4+AFKpYKvPFTTRtpqXGnVYTIMubv2jP5/7+T4+I=;
        b=YN4inVpgbxFwlu1bf84AUHDKdgEbCOkgJpRTVoCor5/imml1+t6KoSonNcOB/Qqik/
         5bg9OrQXYImVbB+LTUEQl+ubwxwNwmGHRRTzUI9+9sSFvrIdQYK5++zuLBzabwFWLS4g
         ZlJbsUqMJw3bxhsIvs5UEWIUMFnBxKy1g3pWseT6jDKamYs2HBlahbwQontgOHEmz+bz
         461Iqeode8UFgZu3xAHtsAmBTl1Y2NHgMqBcgVLOyR6cQMcHPumVnLS5hRlLEyp+MI9d
         kACLhJkis186ma04K+h54jGKlA1R16RGsUcUAmC44cP3+pNpNUzlVvJRoOM0U/xh0XSz
         S5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5fr66tJlHnGKCCJYVGhuQ0dDjFAItQfC0AO8x0EblCTwLF4nZqr3Efzlgq9eivE5mZUTrd3/G/BO+xQWErMJL@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPYKUTyPCQhhmBoLD98EGwAhWASbrR5eOoqXoDfCZ/x5o/Yxo
	KL218C84JBLkMJ9BYSMwJR58pJm5+08zy6KmkbQc1EYlAYgsl9WoV5Dn5fhsJw==
X-Gm-Gg: AY/fxX7hM5VtcXl500YSid17K8CYENXXw28Fkt7i9Hgcc9lQpNhd6GKAphR35/eSNGF
	JULhbHRcgBKSX/zR6JcVEXVKQMR21SLWLLGgpVp4RU5/IAvEJejo3XzhhO5wFTI5bldDl6LhrYg
	EDx0QTGQs4tWKwShKDvl88yrfLip0+d3CiO0ZXy5imJ0kbRV+Gc2zTr7RCscuCTamnRqt2yI/kt
	zOGnqSX4h9oXGDwjvMGL8JKIQa2hPp9P4BnmnxS0prs5Ev4onyognVGZWZjmSF2eYi1+Sza3EYJ
	FZijysgJIjCyLrY/QP/MxxnMUKSn1tiGcV3hxwDh2rQUnBeIrzJ4gl6wnGt8O3JGVnL23/A8YML
	qucbs3vlKravUEIEfwVZS9LgYU3KuepWLOxxrUqYYb8CQ6MS3emyK1QXOoNZYTO3gx/ZlIrGTEJ
	2Odq0SGkycUttxe/R9Y5I/KQZOfeFlZi3N0A==
X-Google-Smtp-Source: AGHT+IGggPiftYVp3LtYBKjyF/Fdi5lbyANw2LP48BA89EBM/zaOrh+B00Aa4eeklC9Wq1oLgmSFxg==
X-Received: by 2002:a05:6122:31a5:b0:559:70bc:ca54 with SMTP id 71dfb90a1353d-56347fd1becmr510576e0c.14.1767783929046;
        Wed, 07 Jan 2026 03:05:29 -0800 (PST)
Received: from ehlo.thunderbird.net ([177.22.194.82])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a34acsm2382059241.10.2026.01.07.03.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 03:05:28 -0800 (PST)
Date: Wed, 07 Jan 2026 08:05:21 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Nicolas Schier <n.schier@avm.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Michael Petlan <mpetlan@redhat.com>,
 Jakub Brnak <jbrnak@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>
CC: Philipp Hahn <p.hahn@avm.de>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v2] perf build: Raise minimum shellcheck version to 0.7.2
User-Agent: Thunderbird for Android
In-Reply-To: <20260107-perf-raise-minimum-shellcheck-version-v2-1-019ef32d7711@avm.de>
References: <20260107-perf-raise-minimum-shellcheck-version-v2-1-019ef32d7711@avm.de>
Message-ID: <413A6A45-CA6B-46F8-BE19-5AD2D1559DD6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 7, 2026 5:13:26 AM GMT-03:00, Nicolas Schier <n=2Eschier@avm=2E=
de> wrote:
>Raise the minimum shellcheck version for perf builds to 0=2E7=2E2, so tha=
t
>systems with shellcheck versions below 0=2E7=2E2 will automatically skip =
the
>shell script checking, even if NO_SHELLCHECK is unset=2E
>
>Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
>paths"), shellcheck versions before 0=2E7=2E2 break the perf build with
>several SC1090 [2] warnings due to its too strict dynamic source
>handling [1], e=2Eg=2E:
>
>  In tests/shell/base_probe/test_line_semantics=2Esh line 20:
>  =2E "$DIR_PATH/=2E=2E/common/init=2Esh"
>    ^---------------------------^ SC1090: Can't follow non-constant sourc=
e=2E Use a directive to specify location=2E
>
>Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
>Link: https://github=2Ecom/koalaman/shellcheck/issues/1998 # [1]
>Link: https://www=2Eshellcheck=2Enet/wiki/SC1090
>Acked-by: Namhyung Kim <namhyung@kernel=2Eorg>
>Signed-off-by: Nicolas Schier <n=2Eschier@avm=2Ede>
>---
>Changes in v2:
>  * Add one of the shellcheck messages to commit message (Namhyung Kim)
>  * Link to v1: https://lore=2Ekernel=2Eorg/r/20260106-perf-raise-minimum=
-shellcheck-version-v1-1-b46739a78888@avm=2Ede
>---
> tools/perf/Makefile=2Eperf | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/perf/Makefile=2Eperf b/tools/perf/Makefile=2Eperf
>index b3f481a626afa314632876449a11eb79b2978824=2E=2Ee2d668fb7f439befd6d1d=
9cbf66765f8b815e3c6 100644
>--- a/tools/perf/Makefile=2Eperf
>+++ b/tools/perf/Makefile=2Eperf
>@@ -255,7 +255,7 @@ endif
> # minimal shellcheck version as v0=2E6=2E0=2E

I'm looking just add this patch, from the smartphone, but shouldn't the ab=
ove comment need to be updated as well?

- Arnaldo

> ifneq ($(SHELLCHECK),)
>   ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
>-        sed -e 's/=2E\+ \([0-9]\+\)=2E\([0-9]\+\)=2E\([0-9]\+\)/\1\2\3/g=
') \< 060), 1)
>+        sed -e 's/=2E\+ \([0-9]\+\)=2E\([0-9]\+\)=2E\([0-9]\+\)/\1\2\3/g=
') \< 072), 1)
>     SHELLCHECK :=3D
>   else
>     SHELLCHECK :=3D $(SHELLCHECK) -s bash -a -S warning
>
>---
>base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
>change-id: 20260106-perf-raise-minimum-shellcheck-version-5d684fe90a39
>
>Best regards,

- Arnaldo 
