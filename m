Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794334496;
	b=3XDEhByJhc5OayjZV7oGTQS6llLNDVwyLqxWMluUMNjZATxs/oTLs7E3WYY1N/stkMJl
	 pwsNLXcbfUkirs8jr1ayztQpYl65iUu6lQnowypM4YhiePdbb/hCxiLKGILeTXbHph9yh
	 3XaoRnJW3hANnJIhSFiV/GuZyPBseAAC/Enmtqu1HMW5w4Mo2jvSlJQ9hmU9wWG2oshh9
	 OERNMsGB6CsZJhAkrrU/jhoWe6DoU8rZH6JM0vka+FwuGXwi8PeN9/Ur8NHVH/yVaETxm
	 rv3owIVnGqgGvQrnU+AvfK/OlaIkocTvwYb+RAPAwvAWRowj8JH32zoG1K/Khvf+ADA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z/T19qwkUhRsiOdHXZPOOueJ4FV/Vspzv786LxtKzAs=;
	b=xngeF3b8P4zHI0rlAWK0MxLWW/9Wp66L6f1QB1cO2P/0p0CJiyf3PwRgi1yWpGe7BXV0
	 /2A4IitWssaFTxv437er+nX2iQhbdQWycaQVHRTT3gaKyKFBhQmA0zbgt4JBtPYx+Sjft
	 mou+qpJRAI1Mrlt4x73jENrELurVhQHf0igZYHlLJMEn7poKTIX3d83ix3SUKRK4qkQd8
	 ka2XKaXqgdTJjjkg33tQjvGo/oxOUA5TfFap+JylkwjV7Vdcx25TNQVINxwcQHq4pPW/N
	 6KhA9LvgOm13bgx5Wh787Vpj7T/6te1aD+Z3eIMZs0yS4DLcIvgKPRpoWMAw2Su5OlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qii2TyZ7;
	arc=fail smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31E606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA31E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qii2TyZ7
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54492d8a988so8311cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 10:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794334495; cv=none;
        d=google.com; s=arc-20260327;
        b=qIZ8UR6DWScvF9cMcFn7GVHNxkp1k8M2gUWlep6KFV9yaHK/2wUXDQpyWm+d214GoT
         QHwzY2FdcLvJCiSYwWXJjFKeAQyuGjngFSBmOdgL108QMSB2v8avQxGQPbJZBPghUkVa
         y8PrHDwKOuMqM4b4tgurLC/JmIM2sgxydo/R+bbq1vRItrzyBoC4uZEl8w2NplS9iPCb
         GQBruFXxYGRzMcTxtbH9gXfCfm228JHTIDAQLDf/2rJbSgnp1/BbGymAdU1dZVUCf6EY
         ss/aHVwofFET8dNSUmlZUroYyCXnD0aUhfOS4oD0HO5cmzkqDtIGUpPV5mgNEv9ounyh
         Xopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z/T19qwkUhRsiOdHXZPOOueJ4FV/Vspzv786LxtKzAs=;
        fh=oi+xONp853Ymq3Cg12ptXRyDqtwg/q79mYS/BXFezt0=;
        b=g/9ovGSv2ZrxGeQU14fBzS3YEli0k5fSjdpuEztw4jNfO4CNBfUymsiLB0y1PIxXUw
         OQsczwHifNjv5cvNsPtFAi+w3KW0uEWy7QuQ2i0qtSJ7mCNFObgOf3lIaCziqalS6i1S
         07of1jrX98BegVC+hrG5UV27tSBxVpJIT0SvOn3rzMFximMciQGgVp1ByM/xxAU/yjqi
         Kk87QV67JX1xSF9bk0XBtCuQlqqZ3tmKC7muaa+EU1pozym+N1Cl2jg9Ur/FUiugdJKC
         DjLLUS2EDTFdGYzY6zXQ9D6WDIsjat8NLyXHih4a0suxKjUXI/jMkjX8/1EG2aitPUm7
         +/cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794334495; x=1794939295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/T19qwkUhRsiOdHXZPOOueJ4FV/Vspzv786LxtKzAs=;
        b=Qii2TyZ7jCHfr9Ifg1uG1l0L4Vo7zZoQ477vdRT7bBObbfapFSMUNJUUS9e6evAISl
         Q4fni0WpJftiDQlaAZnWe/k1lb1jGD7BKoAINmB+/2no1PwYIZJ/a/hbcG5HDoKUb4kd
         Du5BIyXy6U6uc+15eisV6pjyrwaDIzi3xN4Mpi91JkuV+1Jn0fLxun22+8QwkG/Jphln
         DdhtcnrO7a1XqFHh0DWXtLUA94wMF9NCKlMZbvLWnAOiIs2IrH9kEUjfCJqG2XirLsh+
         oXCKNERJq646eWiUDnp1iGQS0cGBRE7zpMSEwLLR1FlzSW4I6xc2RkzWMmTXdYSxIx9w
         ILNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334495; x=1794939295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/T19qwkUhRsiOdHXZPOOueJ4FV/Vspzv786LxtKzAs=;
        b=zAU4vouRersn1GsZbSMLAFQAkObGbcQgY7DKubysm0OUR9l/boN73oz85vdqtzBASx
         geWOOKCJrncX78Ecbmi6+vULl0rA2+24gAnteev8dKOqoN2uQxolbJhT310twxqLr67l
         wjbjMP/pi6ZjgKPfuRHMpi47LrO/j+p2/YOAhb3jkUpXHFlzGnIH+5r78xzd0yHKIiWd
         hDP7crmZpR0dRF7E72thtlqkQ+2cOW94bvx2cSLXpT9o+2TUqBLH7CmWpVW9t+dePTOZ
         q0v993AHCw+Fq7JYRKDrsdWVZT/zpNtvmzLsE/jAv1uFuWRKzEoDRqFxDQ0idQVH+Nnl
         VBUg==
X-Forwarded-Encrypted: i=1; AL+hErEKwqFiqS4jK61Gfj5JNnivV04YpAsSMxCulriK0mQ6s6dpNTj99SKKWQ6tjf7IkpjWmKGL+dv5t/ijvLBladTk@vger.kernel.org
X-Gm-Message-State: APuU4Z/mrpG5JkOioS0Hd2lSvsG1huES271lQnr3qZqOYZBYb3Wg0o7R
	OcJ9L9n2oeE1jLT8dINjPbWdjikPR0seZah87tT2uNHk04fJbVgLmfg8fVHW5+EtuP3Xhmj2kvn
	IVoi3OWN3Dn98QzWC+fzC/fpoyJMxHUVENbrSDqlb
X-Gm-Gg: AYBFou2VK5PuL4EJeyrYzVQ3PmMakxsOM6qsh04XDY1tDin7GdOKinPkoORuJBc5UGJ
	6NlNJd5BRRj8AHWnR0cE040gWzgXvbS63RcJFAzSeOfOemno/jS6cgk6IHSv/kHiVklrEruY+cW
	HI2lYP28mR0V3TRNkJ4o0PYhV2jryUyHoBJHmC5OZRitxIAZbDU190gwKDy2Ho0npgnh8JTlcRc
	UOPjwHo8ge3qy27w6B9eJ0mW8mP/hLEWRIKIaectpSY2T8wvG9Guiechjodo0njjCx1ZKDdlKop
	zV3G+J351sya7Cq39Xb04jsKkt13o4GVz6PE5KHeM/T38t8ZXS1n85PrgzkKOnANd96VekFvCtT
	xpGB/RsXkqXA0qdheXfc0vhpdVzZo9b9NYa6lv2mJjyllhUGcKLVxHCTs9Ee9vXmBJiA=
X-Received: by 2002:a05:622a:2b0f:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-5569bc21f5bmr15411cf.1.1794334493987; Tue, 10 Nov 2026 10:14:53
 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-tp-glob-errno-v1-1-6c2cb609c590@gmail.com>
In-Reply-To: <20261110-tp-glob-errno-v1-1-6c2cb609c590@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Nov 2026 10:14:42 -0800
X-Gm-Features: AclHuK9xIbr7pga1JS6cGGqHrO7XBZ0oZ6bzuqE2kkPmCpNtl3AFPDmJMPPFj4I
Message-ID: <CAP-5=fUFXZBtHEfSRzcR1rXFXb9jXqzUpp+gvCJH=9V6cEb7HQ@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Don't report unreadable tracepoint
 globs as unknown
To: hang.zhengyang1010@gmail.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 7:05=E2=80=AFPM Hang Zhengyang via B4 Relay
<devnull+hang.zhengyang1010.gmail.com@kernel.org> wrote:
>
> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
>
> When the events directory can't be read, a tracepoint glob like
> 'syscalls:*' is reported as an unknown tracepoint, with a hint about a
> missing CONFIG_ option.  A plain tracepoint name reports the permission
> problem instead:
>
>   $ perf stat -e 'syscalls:*' true
>   event syntax error: 'syscalls:*'
>                        \___ unknown tracepoint
>
>   Error:  File /sys/kernel/tracing//events/syscalls/* not found.

Thanks Hang! The Sashiko feedback seems like overkill to fix here.
Could you give a before and after comparison of the console output for
this change?

Thanks,
Ian

> add_tracepoint_multi_sys() reports ENOENT whenever nothing matched and
> ignores the error returned while reading the directories, which got
> lost when this code moved to tp_pmu.c.  Report that error when there
> is one.  As a normal user 'syscalls:*' now gets "can't access trace
> events" and the remount hint, and perf test 5.1 is skipped again
> instead of failing.
>
> Fixes: d002aab87de8 ("perf tp_pmu: Factor existing tracepoint logic to ne=
w file")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> ---
> Found running perf test as a normal user.  Tested on perf-tools-next
> 13a8d580433a.  As a normal user, 'syscalls:*', 'sched:*',
> 'syscalls:sys_enter_open*' and '*:sys_enter_openat' now report the
> permission problem, perf test 5 passes with 5.1 skipped, and the rest
> of perf test is unchanged.  As root, 'nosuchsys:*' still reports an
> unknown tracepoint, 'syscalls:sys_enter_open*' counts, and perf test
> 5.1 passes.
>
> The issue was found and the fix and changelog drafted with Claude; I
> reproduced the issue and reviewed and tested the change.
> ---
>  tools/perf/util/parse-events.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index f3ba70d4f76b..8a6d5a13863d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -572,8 +572,10 @@ static int add_tracepoint_multi_sys(struct parse_eve=
nts_state *parse_state,
>                 ret =3D tp_pmu__for_each_tp_sys(&args, add_tracepoint_mul=
ti_sys_cb);
>         }
>         if (args.found =3D=3D 0) {
> -               tracepoint_error(err, ENOENT, sys_glob, evt_glob, loc->fi=
rst_column);
> -               return -ENOENT;
> +               if (!ret)
> +                       ret =3D -ENOENT;
> +               tracepoint_error(err, ret, sys_glob, evt_glob, loc->first=
_column);
> +               return ret;
>         }
>         return ret;
>  }
>
> ---
> base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
> change-id: 20261110-tp-glob-errno-672ea1eb786b
>
> Best regards,
> --
> Hang Zhengyang <hang.zhengyang1010@gmail.com>
>
>
