Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64084BD344
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608382; cv=pass; b=h3hRw8VgFeND6VerDATfhVSoWrAwHqRyxT9VNnxEWpH+/VdgWplIvzcCtZQQlsBi71vgxD/olkz5Ac6CyJctXydCgLts2wVEi7VOIT+uWjoIVMhJWYGOBdbIrWkUVEb0c28bV/MQLeEJ6NGs5t3nA2uBJf82qHmLQI4KJd+cEA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608382; c=relaxed/simple;
	bh=JR1hrQWKX7jg/qNMgCjsxKYNdwEk6pcyjk1ECPhUtfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO6pDT5I76exA5MTuncyO6oZZq77q/PSkjE6yYnmw1tMpXOy7R54nvfbzfFh11YcQImlqK/lQQdPKayaag9DzX+jaQMmfJKEdaSXK2ika6Pi86kELgJ9omJqTGgtWK0T8bd/7ma/R0ySeLj3Gm5y4WWBRTJHniH9EsNncpq23Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZ/ZyZ0e; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZ/ZyZ0e"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db33db4de9so94205ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608380; cv=none;
        d=google.com; s=arc-20260327;
        b=BpRQKZOM+gtQsplJH8lx8GivFKUpHDzrmqkKXtEKH7FvdC304P41B8fBhmFs+oGci+
         artStYDVYoGSB25zvIDXjHq6xVxUxVM8yex2+8HsDh0x5U8vqIEJFWXxP4yfq0e8eCul
         WiyzUf0GqORmOd/aRpUPgnfH42J45hUH3LQWaoz58fbhpgqeoaY034rsSCsYEVjQZawX
         dzl+EfEjNtBdq/0HDmwk83UlpRvUUllXJqHxjN9a6q7zjywG+meZt608jgUtC8eL9S3e
         oooBcLWPQa821cg9VL1oKpI2UdPZotKsurNdRr0jOkgKRdEP5FYh1iJBkqGzxYYITpq4
         8RzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGU5OC9UL1Fxe8p0Y+9x9ZwdzEgQ8g5qJnEW4rmjmBk=;
        fh=dAzmSd2kRbKMgSYxqpke7KUXmBX/7/nUEYzDAZt9spY=;
        b=d1AO3at8jvs9Xj9S3e71ik4hNJSVsNyPhkX0+7ezatuIbiDZMDuYxaarqPdQ5CPHkK
         WAvr7/Ty7saazs0H2PCaGKnNdjX0OUp7CVLrmtVvK3Sw8QFeAISo8xf1aiHaiSIGgK3K
         Kyq7ej2NGty1Im8j4RpMNYPAndFvwX8NdfneviV4z24A6ipqWxs2MXa8ADGm2w6KhlRN
         2zvpoyLTnZI+Or29BwWsh5GsxCvgLy7eFOY58L8HSznyXAV0g6fu4lfNILa90wEEHDpS
         ksuzoadBb/ndWlrVvUhplsDgNwwqdml7LGon9IbOufoAsbjbL5oYHBlbeCiS39KOBeVN
         Eb6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790608380; x=1791213180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oGU5OC9UL1Fxe8p0Y+9x9ZwdzEgQ8g5qJnEW4rmjmBk=;
        b=wZ/ZyZ0e4Z5EPOL+ZPxnaJ7mw8d0Wf/r3n4hjHpPpN+bpEFZXBLIXSxgN5aZBoyGnr
         +6FB10XOWaRuyObPnMOlggD8ZqUGksLZzNkwHMsh0ZqbNbDMukXbsMcwNkccA87oHiyv
         jUkuI0p7kP0g5I+ZK2Waa2Wk51WPbvwdlj0A9gY35GkcIWGnO4IwHXqQRwBTNAwOORn2
         DG/BlCimUTbEB0iqurGBOTaZmTDTzb96YxsG5n/FGvERGV1KfxjYNvqQk1XKCFrQAgHc
         OZhytPTjqsWGWgmDE3nRLzn7ygXgXU2aHaT7DEVMJ/t7yJqmB5K0lL2wbO2+eM3CWBvn
         SnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790608380; x=1791213180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGU5OC9UL1Fxe8p0Y+9x9ZwdzEgQ8g5qJnEW4rmjmBk=;
        b=YL7x0MqixftxqaRnc8mto6DQRaLDdTfT2T+pCR+2+R05dtUliKGmqggNMp1GYBbDeP
         npJcONZ+Dq/5rd8CvpYO7wwJBri4UEYnkxy8TMuFSg4Ta4J1KnD1LhmxT7whRK4HUGM1
         LS+IV9azcPgMilKe5QtdjcGAAVWeUTJFgRBtPlg/qGgazIYwV8GVYW6omyuP71A/lQ2c
         FlymyNEYoLygIeDsT1fenXSFUQd+hIGbirhvtbd4tJV877evYyYrqV3PdOaRCNFfm5bx
         D2mumkQXxYdKn1CfkPGsUhoq9FbW0KU1Z0p3Gfgc+WnXpG8ooNFsBXb20j7ODRDWhhn7
         3rqQ==
X-Forwarded-Encrypted: i=1; AKwUvByt3NogmaHZFxOYHKdk6EnSxUVXuY7w+8vkFf2GZHSfBgl6QuetqBBakRweTTdiPOKWXiC58R0ZCSQok15rihpD@vger.kernel.org
X-Gm-Message-State: AFq9FYLjO/3b8ieuHmwHvkQQgU0TNgZ4/1WTBm/+ZfZ4TqAPh4b71vfQ
	ZyHsmaO2dXVGnQQZ7ZNF+iVQcvSTmHlKGt85pgU5oWA5kUEOL6CXvtFYysUVgrdXLl9ky+4e48k
	X1Tq6GR41xp0J1TOxD9tsYLE8BKBVejjbiyshojFb
X-Gm-Gg: AYBFou3v6jpwYts4C4Cn9yJkHS+y4SLTwGEDyiZ/Ggx2Y2WBngUvrjB+Rvt1B3NhBzt
	Xtt6nbXnGsOA+fivTQpmdAcpGsdvLYrp6/3KGNspm51nb5Xr1E8x9SfFnn+wkXoGqnZghYGhxW1
	iODs7QpwUsQkvGi19zMMtrXrjqlPzIKRHZTtWcETEQnV4cvG4/DBmnRWyh89ueQ80yVbYiN111V
	kDVFqbfsa+FH754iWCcB4FRZnvAyQ62R5tL8px9+qNRK0/OosQsPviDlUu0C1hxcslKrW7gPiHJ
	k9UpIlklOtkmlaYkprCbBPJIUyl9iTavs9E7WXjGiVXAbVGkDDN9E3x1q/r/UQRvXoI3oYONkxj
	+/AyTyHOprkaFiakHV4E=
X-Received: by 2002:a17:902:f54b:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2dfa6248695mr6726435ad.12.1790608379244; Mon, 28 Sep 2026
 08:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arpXYeRUu3B-ouqB@x2>
In-Reply-To: <arpXYeRUu3B-ouqB@x2>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 08:12:45 -0700
X-Gm-Features: AclHuK-dyGstuwO2fM-ksmDxDJQpBUHXqUWMhxhUaife7hKFIU9g5KIHP8FLMSs
Message-ID: <CAP-5=fUyYuheX6jC=+WOYw4kM3Ak0S1SFk45QgCXhgy23V+F3g@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools feature gettid: Undef _GNU_SOURCE before
 defining it
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:02=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Since most of tools/build/feature/test-*.c feature tests are included in
> tools/build/feature/test-all.c, we can't just define _GNU_SOURCE as it
> may already been defined and this will break the build with:
>
>   acme@alta:~$ cat /tmp/build/perf-tools-next/feature/test-all.make.outpu=
t
>   In file included from test-all.c:26:
>   test-gettid.c:3:9: error: "_GNU_SOURCE" redefined [-Werror]
>       3 | #define _GNU_SOURCE
>         |         ^~~~~~~~~~~
>   In file included from /usr/include/python3.13/pyconfig.h:9,
>                    from /usr/include/python3.13/Python.h:14,
>                    from test-python-module.c:2,
>                    from test-all.c:14:
>   /usr/include/aarch64-linux-gnu/python3.13/pyconfig.h:1810:10: note: thi=
s is the location of the previous definition
>    1810 | # define _GNU_SOURCE 1
>         |          ^~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   acme@alta:~$
>
> I.e. pyconfig.h is included by the new test-python-module.c, that is at
> the start of test-all.c, defines _GNU_SOURCE, noticed on Debian 13
> (/usr/include/aarch64-linux-gnu/python3.13/pyconfig.h, libpython
> 3.13.5-2+deb13u5), and then test-all.c includes test-gettid.c that was
> defining it as well, undef it first as does several other tests.
>
> Fixes: 1b7e0280e247b93d ("perf Makefile: Update Python script installatio=
n path")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/build/feature/test-gettid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/build/feature/test-gettid.c b/tools/build/feature/test=
-gettid.c
> index ef24e42d3f1b877d..a8fdb26196697b66 100644
> --- a/tools/build/feature/test-gettid.c
> +++ b/tools/build/feature/test-gettid.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redha=
t.com>
> +#undef _GNU_SOURCE
>  #define _GNU_SOURCE
>  #include <unistd.h>
>
> --
> 2.55.0
>
