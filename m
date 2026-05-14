Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F51E515
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745720; cv=pass; b=ImFtyCMF9tNl2RSu4qTAXTYoNPwSkAKDV7IZntVa8/+af7ffKPBoHWnoNRvaEaAXUnq60/JBBEKtE3JkshyazEklaf/qCmpF11kFcNn61kCKTW00y7RNHvy/IIuytOWa3Bo8LLxN8/B9CQh1Kw2mqydXI+7JyXe0y5S81Mz9dxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745720; c=relaxed/simple;
	bh=81kN/c0whuLRH0kfnXp/GgeU5xeC5H9AC8PyLrKwRWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpBIftzpvzNknS0uRbNurM7O/mDT4tfz/c/8AD6P9FMAK79BTZb/uGfyp2mRMGYKlG21yV73ebNuNpY9hGyQymHLXv2X1i0i5P5yVfv12K21Q2G96Q18yCBUcquT1GumQAPgThTTRKvqqEBtzAQ92T+/KXBHhcB1xOGsvuhr5ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKFUEsSe; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKFUEsSe"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-134ac81c445so2387870c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 01:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745717; cv=none;
        d=google.com; s=arc-20240605;
        b=JxwFBQnIYelO1BwWPpqABoZjYA4dFvnz4puLbNX3P9fVm5Hyng90reA1uuD1QZvRoO
         +0OUy7914DvsAfrbQuOxJAMDtKGSK2P6OoCOCi9oI/tkc8mNx+3hThvmBeAftmo/avst
         bYX1csQ+Lo27Co7s/qlNVk+dio+biU4uvCUFH4MiSsXOMmDNlwIvMdqSKCdk7xTsUbnO
         6fMU3S52iHD5FobgnAz9gla/dBa14ROkKv63N2g5nPfdOOaq0dTipO37UpwQRf3RN8ar
         9GDDQRlPAlnv8MGrNOaFMeuaen4o8ARgEvm1ByzQVhdwKe8Drgw0giOXiPSdPu6yW1Dv
         os+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R3rMcHi+SRGerVbM0q8doN39gwMZLkcDzykkfyfOtI8=;
        fh=Sz1q6ar+efR5NKU7eO39VknFnbGfH6SgLI9s+FjZjXE=;
        b=FxziCPy911CBkN3Vn595LnQCiAgTKbzWq7kmgoZi0A0OBYBmwSCY30/4J6tAaYBBiY
         ZzMTtMLbVrkazM7eH4IVcI4B6l1IBXW6ON9X7C+tP8qDQlPZz118/1+9veFF13MKEGX0
         4oUcWOT1RStS9VLIcOomX/etRZujrFjgUgqUOuMxOK+KpLKJ2PWzsZcEWvYnSG2Nmzpr
         HmA6K8f1wIZ3JA+xuWQ+iHCGAp204fRQp1D9DVxkCJ48OqndIjAn/ZBx988PWtI3CV+C
         k69WJYDQ0/YlXLihELUmPRIRQkdOlk0qxb++l8GaeswCH5+WbdGsUFNUKXGR2QGpBYld
         HiUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745717; x=1779350517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3rMcHi+SRGerVbM0q8doN39gwMZLkcDzykkfyfOtI8=;
        b=fKFUEsSeSYMSDVkCMtt5pEXXkHrte4cGizJMM1N82Q2Vegxnc3Syj9YvD0XPKZKtjt
         EpbOMOEwV3HZ/2myULhHtcOLZoC2z1TF4x+LE1zOwyDOmA2vFfwzyRlSQgplymgW8eXR
         Y5CaM/nja9ImztJ4unodiGVZGogD1hTm+1Cd6lQ0s8OfYNQX0CjHbyEDcpQqtOtylZaQ
         PFEeOBl8GeCRWBPJ9wAE9e7q5y5l8o48ND8z48mFSZVJbxLn6vnBllt2U0lOVoFPg2On
         5mr+8buy/0TJ/HsnwKCdCBJMR0f4eGOTitUN4bF4YD6EesQBQwI93YZVdLARw/6O2ula
         bhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745717; x=1779350517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3rMcHi+SRGerVbM0q8doN39gwMZLkcDzykkfyfOtI8=;
        b=j+5tdSrpZA/JCNp6dS0F3SBMryUiuLzshOAeD+yT/gOA3AuJ6ylKxZ+ASQKRggC4Vl
         Nqf2oMbnHDIb2+xJkV5TCSxZx4hpKsM06c0IVQMlgCwmxZya9zkHjNTPDBcAixDMJQNt
         38EZQlW5sc+is2jPcJ48yoH8FSm2IYJlA1AwxL+SV7Hh6n4YcKCLmhgUm0fRYzBQE5/x
         9GYOMnZYocbOv7VWhXmTfOJX7m+NCPWCH7TzVA/dVnP9b0WdmENGxKVzodKp5N/ZWD11
         0SDoB19m9vDy0chgAYazbLvNBFGTvRfqwDckDqE4d/68UUduxFaC80jddNtjDTBuKl6E
         FpUw==
X-Forwarded-Encrypted: i=1; AFNElJ/z2YAkYuf26hVwlJmFRR66vn17HO9wVewHs1ePJ++kefuko1ihzVR/l+YP6v46HkoOFByJq7BPT2/3onuBTZ5V@vger.kernel.org
X-Gm-Message-State: AOJu0YwUCU8SsAfh7PaupIWNaaPw2hn3SnDbdGkbq89QwoZ/qVmyClBO
	Tk+8ltTE/X3PDjU301Z4SbzwEW2njsjrff/xhqvbKrYoZqC73wfAWCVbRO82fdp2D8YgVTzi1PG
	ML5TM40r9HMF+/6jo5uDhfWqDR00IT0VEgIGoThM9
X-Gm-Gg: Acq92OE+WjEhBFP2M72IjgHVVZGQjcnXf9LXg14+S+AeSASZYIWY0P738WhFMkOIT92
	NxGx4u1AZeJmQT8fOcvAZCljkueg2+U1uA1mW0ZNmBgRg45aNyKtdXhqZEOG77u4FjTVll3wmZj
	ks2W5DBs+CSSakpbH8RMG+KifayXe22vHXn/PuDbfKVlHbJVYgDoHp8+6aNR8exB3vAIV0lED/v
	JiAduPQvqAu9XOP5GAjC5vb0VjSONhMMOb9j3W9KpJC98z5MwEaRphOEn96+aW25yM2TY4RbGPG
	wI4f1SAYp6mgY2zG+KAPh0zN4ttyU0IDABdviW+n84S3h9LhKA==
X-Received: by 2002:a05:7022:b89:b0:12c:5e48:4c01 with SMTP id
 a92af1059eb24-1342ee3e06cmr4229857c88.1.1778745716497; Thu, 14 May 2026
 01:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514050455.2954509-1-justin.he@arm.com> <20260514050455.2954509-7-justin.he@arm.com>
In-Reply-To: <20260514050455.2954509-7-justin.he@arm.com>
From: Marco Elver <elver@google.com>
Date: Thu, 14 May 2026 10:01:19 +0200
X-Gm-Features: AVHnY4LXtb13xHae_HjNLF3uu8TPNuAYGsyBqY2dhhK2QMuCmkBsOtE8ngXwGcI
Message-ID: <CANpmjNNAb0apuxu4+tdihHr6PDmdYK5L7Fhg_3SxrVG3UV3_3A@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw_breakpoint_test: fix test_many_cpus failure on
 large systems
To: Jia He <justin.he@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>, David Disseldorp <ddiss@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 07:08, Jia He <justin.he@arm.com> wrote:
>
> On systems with many CPUs (e.g. 128 cores x 4 HW breakpoint slots =
> 512 = MAX_TEST_BREAKPOINTS), test_many_cpus() advances idx to
> MAX_TEST_BREAKPOINTS after the last fill_bp_slots(). The subsequent
> register_test_bp() call hits WARN_ON(idx >= MAX_TEST_BREAKPOINTS),
> returns NULL, and the -ENOSPC expectation fails.
>
> Bail out of the loop when idx reaches the limit. Earlier iterations
> already validate the NOSPC path on other CPUs.
>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
>
> Signed-off-by: Jia He <justin.he@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/events/hw_breakpoint_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> index 2cfeeecf8de9..943d040d2224 100644
> --- a/kernel/events/hw_breakpoint_test.c
> +++ b/kernel/events/hw_breakpoint_test.c
> @@ -137,6 +137,9 @@ static void test_many_cpus(struct kunit *test)
>         for_each_online_cpu(cpu) {
>                 bool do_continue = fill_bp_slots(test, &idx, cpu, NULL, 0);
>
> +               if (idx >= MAX_TEST_BREAKPOINTS)
> +                       break;
> +
>                 TEST_EXPECT_NOSPC(register_test_bp(cpu, NULL, idx));
>                 if (!do_continue)
>                         break;
> --
> 2.34.1
>
