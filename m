Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D243D0C09
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745313; cv=pass; b=awaK+O13PhIMZvjyaKkjFSABRWTU/vZp+EE5l433YhMoIDMnHR18bRsU+TBZeM7chNiEwtMDYkIhNoPuVj17NfPPM4xvPepwx9nGZSPn0bzxl/y8zlAU06tjP1PbDJE1jVsgslJPcHMHRPEhojUebqHjZTZ09V/IclCJSZnfjzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745313; c=relaxed/simple;
	bh=vAKHwi/+46La1lVZj6I0OUdfUfqhDDBZXGHemI1QJAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccHfIBAOmc7tcT/KaLxnNwrlHGwL8Dg4kPzGb/2NVbDrPxDnG855rMPg63VRYOTgxdAWKZRn5mQjbWdSFwKrF8IAycFr6d8B/8hsT6V12GFWqc9+2V6NE/lCaNadKp8oGggycSgzGE4uyVhNZ7ioM1ynVHWhqGProByWOooRCvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uytzo477; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uytzo477"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1332772f6b3so6324546c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 00:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778745310; cv=none;
        d=google.com; s=arc-20240605;
        b=QqM5Do94ZJ9dFdmeImFDahrW/TYsCTb90yKTZC076qVB4+xWLPnXQmyxBvJqRijqBT
         bl7VfHlnqM8m+LNcIpTwJTTPPWn31tLNA6Vx1nsb2ZqVw4vTGrXUFJmT5BuUDoENmdkM
         MvbtIIs8pxc+8kZosNfddxHBSQiayENboV5w0yue5+6tLE0neOdv4eveXJpmIQfd8P4c
         thQ4yXr0DXnG+nSt7S3EpHdhw/K86b+8jOZpunbTg0xvor3tafHhwbIFI1+sI8O5W71X
         RBQZWHwTd8+dE5G1uLn7zRbKK5e3Wb05jutcvX0Ilxi2mSp/OF0oemvUyxeufW+qxYge
         RFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ILxCmYkL50pA0BzEcihF0YhatRIafK5z4/k4jZSf+Gs=;
        fh=pW0V0l2WioLDNnxbDX2O5+XjzKU2CsIuMb04DpThSCY=;
        b=MidH+swsWTIfaUXNyxwZuD4G9Ck52pu3g86CSMgUg6VTTRKf6DerUlfOXeJnSRXOj4
         Exd2y132ocC9I11ENYr6JNpm/VxZSvf1js2kMrnoT9WZ2+oUxEobIuZQUQUD2KEJNMy5
         WV4hGLfbdLUnOgQz51ML8IDG7r+MDXnsYQPXEUeZZq+pBwJFR2HSny6fR0Q99Wl7dH4w
         BlJ0CVRsOFqw840KK/dvYlDGxO4c+W2wL+bzQ+jL28sAiOZ3JmN/xiQTPF2L63bD4369
         58Ay/jb9XrDhUYWZiYzYr8r7ENEsyvMHhLh0ewCH9+fnRjuI4bo5EdI+4Y3tx9GNLaGz
         fltA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778745310; x=1779350110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILxCmYkL50pA0BzEcihF0YhatRIafK5z4/k4jZSf+Gs=;
        b=uytzo477x08SpHQC9uceQjFEqoO0aXi9qfuPLn4aD/W/M0iv368kUEzt7YXGiWt7V2
         4V0WeaDYcZlRJsOnYsQ+Qi3QKeE6/FAo4FdRoFexR/oo+RwdwRNOD/IswYmeBaZ4ttHC
         s7x4x9lieiBVGJHHEehr6E+nCb3cMr9t1qUD7d46IVMgV8dv5xIv5SZXGl3YaasHLN6y
         zSxeIJjKHXuW9xo05fCN5nTYAf1TZ2vdme8hOsG9/IuG3xNaRnbUyVNLZj0/fGLkOEfh
         HZQNl+zB+iluTq2MS+Tzc3nLgB7QsfLdNLvWRDZBprAAYtVydThJguTv7+j0HllEh949
         bn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745310; x=1779350110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILxCmYkL50pA0BzEcihF0YhatRIafK5z4/k4jZSf+Gs=;
        b=q/AGPWEg5i3bF1YVZkw0TCV4k23n6RqKypJUg1YdMObTeVP3SXr3lJK13Dr9PEJyCF
         hrV4nRaQeKnt1bv6CscCURgJAyf2SpbKjgIFI4DMHTPagQ/Y3+tNNS7WSd1pD4udZc7y
         Ov+IJk3Gd9IScIaVq+ezmfzq2HXMG3yehQ+njK2pbRUr7nH4bynxRu/yfmFlEPuftoc/
         KPTV8Qy/t5x/f3zbWUg1VUOF2siRhuqim+7D0e2hyldyPWJyxm6ybS8JeB+UEh5pSA5z
         Y+M6dt1eOMqir+itfqA/RiA4+7uJqywXsp/E4PJ0G36fV8kCG/p7DEZ43XrcZmzBO0rf
         ZqJA==
X-Forwarded-Encrypted: i=1; AFNElJ9AEz1/PoDpVcjBjNrt7uGbZ3xugp6gAObnkIEk4qhet8iSfdn+06zME1r1moRzEvcab5qds9/Ue1iW0Cygxwah@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVNTOH4gsT7IsFOhWJynJiK80kh3n5m0g1CXty+cLZJT1/hgZ
	XzfYNSCSM+jd8Bw96BwOJArpvDZRlCKjv5RUesMXcSXS8ngPNM3SL7zbbfD9++3jl1xXdVrewk9
	c8XwEYFLtE2anF3uh4jCrpwpVyLSCcRzcphGd8bCiZwPybnfIXr/KxThDzKQ=
X-Gm-Gg: Acq92OGSzpGxcEz16KswciM6P/NaIz+pwn/kMO7b3DuK+BJgYKmjgq/LU4RCs0K8qZc
	r9yW20r/4tayvQIcXabtUqRnJgUWP5RIQJ1PsMfKUKNH+B4z3uhsZSGWW73sABbyBGbLxNKmIxA
	muG06ikwLIJLnI5FBdLPvty0i1DCzJf49yFwTukg3GI21cBpAYJERkrAbitJzWef1zhI3BPwUcl
	wE2bWc+7aH/gfK2LzL9ppWblLLn0P9eigqdrJad0fy2OYjOsBowTHkYRABIfICDme/UhOvXAmOP
	27Aewf0wRsfSMw7GhvojxMiuAy0nVE3tQH1QS0GPoCVmxTqoGA==
X-Received: by 2002:a05:7022:f9a:b0:132:2486:b47 with SMTP id
 a92af1059eb24-1342ef3d502mr4606238c88.3.1778745309159; Thu, 14 May 2026
 00:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514050455.2954509-1-justin.he@arm.com> <20260514050455.2954509-3-justin.he@arm.com>
In-Reply-To: <20260514050455.2954509-3-justin.he@arm.com>
From: Marco Elver <elver@google.com>
Date: Thu, 14 May 2026 09:54:32 +0200
X-Gm-Features: AVHnY4JSKKs4-AOrzjQCzwh9kSmbyo54JL-yInX3IhQgKt6h5_imJyB2qQ8DYtg
Message-ID: <CANpmjNMLa39q=Ss7TVzSi=TTef60AX4_C67XUifanio9YeHB9Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] kfence: kunit: skip when no pool is available
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

On Thu, 14 May 2026 at 07:07, Jia He <justin.he@arm.com> wrote:
>
> When KFENCE is compiled in but disabled at boot (KFENCE_SAMPLE_INTERVAL=0)
> or __kfence_pool is not allocated, every kfence kunit case fails with
> -EINVAL.
>
> Use kunit_skip() so they are reported as skipped instead.
>
> To: Alexander Potapenko <glider@google.com>
> To: Marco Elver <elver@google.com>
> To: Dmitry Vyukov <dvyukov@google.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
>
> Signed-off-by: Jia He <justin.he@arm.com>

Acked-by: Marco Elver <elver@google.com>

Fair enough - typically this failure was a way to know something went
wrong in the test setup. But I also understand that it's not always
possible to just not load this test if kfence is not enabled, say with
some compliance test suites or such.

> ---
>  mm/kfence/kfence_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 5725a367246d..e376329dd621 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -822,8 +822,10 @@ static int test_init(struct kunit *test)
>         unsigned long flags;
>         int i;
>
> -       if (!__kfence_pool)
> -               return -EINVAL;
> +       if (!__kfence_pool) {
> +               kunit_skip(test, "kfence pool not allocated or kfence not enabled");
> +               return 0;
> +       }
>
>         spin_lock_irqsave(&observed.lock, flags);
>         for (i = 0; i < ARRAY_SIZE(observed.lines); i++)
> --
> 2.34.1
>
