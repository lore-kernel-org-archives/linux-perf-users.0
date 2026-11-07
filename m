Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794026345;
	b=gKTNzr2GL8fM/ZjBrPKLnetLVdnvJqRbvK9KDShPJTOAddry/zMgKQfCE5+84aGQkM5L
	 WFk33Rf9d+4J6IWqtRdzD4F7Somloi53WPEeIwjZ2B9+fOE8npvtuyKXPc3cZJi6KkASa
	 RZjSLHLhO1jIwH6ldCNr0ZQcD0vg5gcHy5fsYcRyQqKqKNeyPpZBMnvLJutSRuQOlXeUC
	 HoyR7Mldnjp7+fzoD8miROfBDrLZLV37bUheV/+Vl+zSCgWj/qeCvaiE9fC1D4BXOpHqH
	 SbyGhRvRz3Gr1BB4GczeE6WMdwcZARy6h0KhDzOxS/J8MMVldjwo8k7bjm0csPyR0bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oANw8V6bwbcERQLMzjBwqJLCJQnzOOw7LkVw2UMELt8=;
	b=hUmU890kB7Tb+6gHNeSuVhYoWoKBhZnONw5tmKh0/G1eysOS80lkFmnYoL409cbaeoZt
	 2nvfjSb0nkMEmQrsZHi81e6PPB2zppA/Ucg0BoipgrnT5fiSFTTbzeJ4PJJjChrq8wIfC
	 eNkWouOd3+aH+EQtpIfWKnAIMV1oZDGsHfNyP1mT8AeeyGcAh3zatOCr1cs/P3/xkdkkW
	 I0BJ+WBbK1XTKRTMon5X7eDFCQI8q+T8eh3HleTjTnsrlX0tJ3xyUOmXPS7zL7MpfER2a
	 tHVrFh8VzjOIbhgLD2zL/MRLrgu9UeKMCX3YGrQhIc+8pK11DlvCjeo6/kCZXFBBT6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ncsu.edu;
	spf=pass smtp.mailfrom=ncsu.edu;
	dkim=pass header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=E29vCMH+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484B606A32C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D484B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=E29vCMH+
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso764889a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794026343; cv=none;
        d=google.com; s=arc-20260327;
        b=ljIlU94AIeYk29n+s8RE9ZN0m3XmrkslosGEVpMwb1Y+57FUexPPSLqE7RtuVnY1wc
         RxiCFzIewO5iblNIZcJC85bEkvjyROtD2kbPl7IhFADbDT7L8CLJjIs7G0WVle3gHmWV
         L8z3q5X27pUaPmiVbiBeXbwyTnF0mEQqsHK4MOztoXlRh+jstNesiYYeI0hAyVkiB2UF
         9S5Ti1aV+mTaem/L07VQnAxBh4f9xf0AgF0Q3Qsb2cQEh7QygCPAEDf1hpLOG5oYz3eL
         62voDmFSdyMO3ccBW4S6kAksWTrZdtIWdAEptuH5ULelAfi760D1L35VAmB0h6gY9xMG
         0qoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oANw8V6bwbcERQLMzjBwqJLCJQnzOOw7LkVw2UMELt8=;
        fh=KB9Soulb3IIRgwPGYl07w2jM27WcqH/Na+Bd9ayQ90o=;
        b=WGSvaYZAtROJpAQiSmI38rq5yLUzVhTyF1ewB/43wqWuPiq4EPNynOgO2JGurSU2PG
         2+pSAQ4lLGXXJ//g/2LhYCNrUfekIa6A2kjtxqKHz7BS7FV6XOvidnfPtjiRCFAen2xX
         KW+JkU4u7dEVvbFIbUSfYSBN+cnMm9HU0p3RdKQvPYonsdIwN67gKh2JlmN+ZcDr0pcN
         e0GvhPJrDTCTmVyko3MPDvAggzI3AWkKmkEJJLLx4PzPqHuFUhOAUB3EQjcoyZlaWQ3y
         eg0MKWGq3wbICuG6IFLDy/SR3nSfwCrcvZ+v3qk3wD6FH7rGsXNRic2BDgiEt8xEYGrz
         1GSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1794026343; x=1794631143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oANw8V6bwbcERQLMzjBwqJLCJQnzOOw7LkVw2UMELt8=;
        b=E29vCMH+emxMbDFPMj+AolPx77VpV84pX66UwTgidf9NKdt31GmY9X57Ysoh2j4y9t
         qP8Ia0CzNTHbMNvVZCjRQhO7BEOzwNN2121GmzlcDm7TZNCb11m+iyHVnM9qFFzBcgtM
         ZjsM8ALNJvFNbD9x8Q3c/1UjIE5OGQGBSixsauL0w2DyBVbdw7+BLmW+mD5hVjBgPTVQ
         uXwQ9ZLJRfkVvGLice1fKd/KfR/PZ+Rrfu0rqEsp0tRMm/lMk6JUsEJ33Yl3WAlC3Lsq
         xGfP7/C1NpX1MIjGZ9gnUEbTb7YDlkulIJKb3Es6tnm8Or033BZy5c+Jo4HcFYcQZpvZ
         45BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026343; x=1794631143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oANw8V6bwbcERQLMzjBwqJLCJQnzOOw7LkVw2UMELt8=;
        b=2akx6Yyy355NvpUII0dTR2S93HV9NTbHU8hB7oxOJ74Tx5EH0KvEzuUfvgBt648IZS
         9Si2DvWWgYlp0rRt29wd5EtnuncrGhMQkXTmOHCmchQH9ise9UZzkdoEeufD1QPaSXeN
         FRc+Hmhqd58Qfl+XUUb8OuDJN/dTAZqEAhKzbRsvDnTcxQDGJa3F3oU8XGhxGRwPMH5m
         T4xA1mwraV6iBP9gXb4MViTAB3eiMsgqlroBcycVK+76mRXGgq5OEfMcUjlQBY6DumKq
         5kPq1q08Zvai74FrAUOzLb0UZ74VIJQSXyFsedP9X8TmikfDmxzZBqW9S9ytoPyA1V8c
         B+Xg==
X-Forwarded-Encrypted: i=1; AL+hErE8HP4cR+xmOjh3RDIWzMeMsdaUaIG4EhcHI+V0mT+hu4oJe3ro8+kqXfegkcuYcd0qAqj+aTNQ/yu/p85B0l6H@vger.kernel.org
X-Gm-Message-State: APuU4Z9FbYFSYqPrwAJH7s5g2yNB1ABhIudKBRl+JDVEsmKsCkkYNd7m
	vDnghLFHySjWUN1+JAQeNi/Nw2wl51ODLNbz+WAIBpKmpXjupEqM52Kr6lyjsF12fCLrqt1xg5L
	71VtKZJjJl8LqPzGUd7vSAetdYqgC86DNQ7fXIMOv
X-Gm-Gg: AYBFou0EP45mK8YMUgOF040dU4bhj9TUKdjjtKDnFGFSmggWecnLwiVuoWsKenyntjw
	zpNYd4kMma1XJbY8iAkpARSXiCDjTwVz8nd5t/eBujWzfNNjF+p9M4jJ0rFtWOIHFr1MDUG+0rh
	sfTcvL68ZmAtWMdxwrJSo5HNiUTMlbU2+VgSHurmsn0RptXSWuerMQvSg5AGu30wedmL1x+JAAg
	0OiZ25M1ug2URR88HWdlV9I349VgvlgyXlfwZeyTY5sopq047bK0atQd7ypRkiyWpiTGwwpKg+/
	q3L+7Q5ea5AOn0tDzoXNS6NM2YbIjvQL34cu1lfrtmIgooV3YCOoX7yVJVzFfqsWOVFFQ0XQaoi
	8+0OJmGw6FRpDXRJExSWwgU3TFz4JfdsvsQYrO95iyTZ0EJIul5L+1VfFCHZ8aF2fiZet
X-Received: by 2002:a17:90b:5690:b0:3ac:c03a:38b0 with SMTP id
 98e67ed59e1d1-3b0db5f72ddmr4797535a91.8.1794026343039; Fri, 06 Nov 2026
 20:39:03 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105181949.43198-1-yzhao62@ncsu.edu> <179400075255.23155.12765347975568669027.b4-ty@b4>
In-Reply-To: <179400075255.23155.12765347975568669027.b4-ty@b4>
From: Yanbo Zhao <yzhao62@ncsu.edu>
Date: Fri, 6 Nov 2026 23:38:52 -0500
X-Gm-Features: AclHuK_CMhT7GRldVqAMjtGoKGLPm5_hmYdQbY8LleU3g0NqW63HhzB1vc3gsDA
Message-ID: <CA+J8viYG9JUShGDyZXJwgEb2+W-MqX1APFm-szL0fr2ksAPyrg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf annotate: Data type profiling support for C++
 classes and virtual calls
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks very much for your help!

Best,
Yanbo Zhao

On Fri, Nov 6, 2026 at 4:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, 05 Nov 2026 13:19:46 -0500, Yanbo Zhao wrote:
> > Data type profiling currently only understands C struct/union types.
> > For C++ workloads, member accesses through base class subobjects
> > cannot be resolved, and virtual function calls (indirect calls through
> > the vtable) lose the return type of the callee: the register holding
> > the returned value becomes unknown, which matters when it's used
> > directly to access memory like 'p->next()->val' where no DWARF
> > variable describes the temporary.
> >
> > [...]
>
> Applied to perf-tools-next, thanks!
>
> Best regards
> Namhyung
>
>
