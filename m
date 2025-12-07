Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C803B8D6A
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Dec 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765145787; cv=none; b=c5FA+lxPuM7icDOE6lOajgUJHidAKhOWARENsmqbGgGBrc7WJ0LeGQBbnXdGUuEWDdx7IiRTE1cFBHnB3LaZWOeoDIm27IBr3KQvfMz1mbkTIrbGNTl+xskFIc/08RnLbb+j9oq0Fc3Glmp22ovFTrBD/9R4y/5bbqdvnO97PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765145787; c=relaxed/simple;
	bh=1kuopOAKGVNXohs9CC9mHpY68RKSdIHUKULeVgcfIxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq32bJpCpzRlIIupA1DAOibpFXqHJtYtHMdMQfjyvLsF4NgBk/AcTsk51mB7H2DgcGbHgyqHJ7oH4qlnaSTK/llCVoN+avJbUB6vcc5DG9dTTKvLe7vMYudHEyeFsbOaHAdV3JyRWyVbyZ6YJugmcpIkLCnPWCe1kK3Naq0Outg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nw3oSBoW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nw3oSBoW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e13bf404so252925ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Dec 2025 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765145785; x=1765750585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOKn7B3DTjsirgx5sNgxjcazI3r/2UC/qYEGSRVJrlk=;
        b=Nw3oSBoWUOvdiD1DNJssJKHxDrOufi7AmyuwlQsme8KKwgmqEgv8QU0Rb0l+AcSdN4
         p9NMzFkJDGst0UKnGayNffIWQE64IbLk4veFUmNsfbabYQ6NdLk95xEA5VFvLdwD/AxR
         LkHp9V0qvbu3Iros7kEEGYgcObwRQNXIoPkByphReE1SLkLnb0SScoc1amQ1A1tELzwS
         K66ZzSVnWMWeA+rtIsfGTgocZqKQ/FoMl72s/OZbFtLh44uxEfYN3o8uWGvXZ9ojd1xM
         E3oZKgKCTiC8sXpx0aRCU/dERoOQJMLtiExAixOoHDZu+k9SQUqWgVScSfwj8OoNeepB
         ZZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765145785; x=1765750585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOKn7B3DTjsirgx5sNgxjcazI3r/2UC/qYEGSRVJrlk=;
        b=i3LxpURJpM/K9rMyeCR7aSFkz3B4YpVSipVcvIpNybZg2s/FOPadvil3vrRVl80d21
         jOwrH8xe4FHxsTHDwW7K69EhQgLoGVrEKG6ett4e/lqKzfFKOac+0lNf2NTaVVBOJZnl
         bK26vMgUsA6g3PiAAIYKHeq7vpY5phLQh7WWQyZa7ZsFATjQH6kgRdddnHxyDS1cttJW
         np4vCUK6YJm4fpOVTDAm08lLjUjx63SL8KPiaXnHNk2c5qt2vo/CCXa+Mj8vzYswGcI8
         Q7i5dm1ju38wuC18sQ7qq/XJGuldhe99t+k1LYjcoNdgtQuthUx/ubRHB9ffVpK+5808
         OyBg==
X-Forwarded-Encrypted: i=1; AJvYcCUqec8xIWHuj/J/ThgWHUblqdozrWzV+7XOLFysXSOmvSu5H8OVMWots+3uXXmz4KHzQjD5U0HhGu6WaPHQ6axn@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0fe6Tvm3fBoLTfXUfhNlfx6Pke00J83zJOctcJlz65vez4Dn
	BFpRhO9G8JL37e9A+eWySKlQXUy0AhwEZPJv7SRrt5QE6UAE2W1DCR6ND5mzhfcGwQJmSKpEgdV
	PqGcrDwQ5146flvp+Py1K2Nwci+V/8zjIi++CGxXk5pCIOzj7aIdKvUmjcoQ=
X-Gm-Gg: ASbGncu3pTbwRf9hF+GqW+avoAODeRhTNiHFrsSWIbE28jT1BmZQlwIuKQSRyYoTxo0
	6Ydp+JY22x37VYBw1icX5J1tKUpYXIODc1nFZyry35DCo4iAw4F5eBTkO7U8b+RfktF5ibvypgr
	g64lTuxjBcVujZJcZ/Ay1taU1iXm74TsuElE43LQJA5WfIX8a7y1g3dhWTHGSXGGff8eNDNrRjr
	MAS6Xjm8qkzCEbXsq+HjFVPzak14W67Tqh9QoF8+SlH7pXmLjdF1CxQsJCUH/A38pjJ/j2b
X-Google-Smtp-Source: AGHT+IEoi4xpZKlyU/9dq85L2YZd4ENGBrwQTPR8NVAMiUWj9Dd6uOi64RfcTww4BIjHOxjVrTGkaHQ79EMt5tU26Wc=
X-Received: by 2002:a17:902:e752:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-29df4984885mr3176185ad.4.1765145784589; Sun, 07 Dec 2025
 14:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202213632.2873731-1-sjayaram@akamai.com>
In-Reply-To: <20251202213632.2873731-1-sjayaram@akamai.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Dec 2025 14:16:13 -0800
X-Gm-Features: AQt7F2rG9maatDfCgvzmv08kJhSpWZ4YsQj1cgKyBjR8zL9RWJFCR5SgcpDazSk
Message-ID: <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
Subject: Re: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
To: Sri Jayaramappa <sjayaram@akamai.com>, Guilherme Amadio <amadio@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joshua Hunt <johunt@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:40=E2=80=AFPM Sri Jayaramappa <sjayaram@akamai.com=
> wrote:
>
> When there is no exclusion occurring from the cmds list - for example -
> cmds contains ["read-vdso32"] and excludes contains ["archive"] - the
> main loop completes with ci =3D=3D cj =3D=3D 0. In the original code the =
loop
> processing the remaining elements in the list was conditional:
>
>     if (ci !=3D cj) { ...}
>
> So we end up in the assertion loop since ci < cmds->cnt and we
> incorrectly try to assert the list elements to be NULL and fail with
> the following error
>
>    help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NULL' fail=
ed.
>
> Fix this by moving the if (ci !=3D cj) check inside of a broader loop.
> If ci !=3D cj, left shift the list elements, as before, and then
> unconditionally advance the ci and cj indicies which also covers the
> ci =3D=3D cj case.
>
> Fixes: 1fdf938168c4d26f ("perf tools: Fix use-after-free in help_unknown_=
cmd()")
>
> Signed-off-by: Sri Jayaramappa <sjayaram@akamai.com>

Thanks Sri! Guilherme reported a related issue and I think your fix covers =
it:
https://lore.kernel.org/lkml/aTXQw9dtP5df7LmP@gentoo.org/

I came up with the following test based on your commit message, could
you validate it covers the case for your fix:
```
diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.=
c
index 2280b4c0e5e7..9da96a16fd20 100644
--- a/tools/perf/tests/subcmd-help.c
+++ b/tools/perf/tests/subcmd-help.c
@@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct
test_suite *test __maybe_unused,
       return TEST_OK;
}

+static int test__exclude_cmdnames_no_overlap(struct test_suite *test
__maybe_unused,
+                                            int subtest __maybe_unused)
+{
+       struct cmdnames cmds1 =3D {};
+       struct cmdnames cmds2 =3D {};
+
+       add_cmdname(&cmds1, "read-vdso32", 11);
+       add_cmdname(&cmds2, "archive", 7);
+
+       TEST_ASSERT_VAL("invalid original size", cmds1.cnt =3D=3D 1);
+       TEST_ASSERT_VAL("invalid original size", cmds2.cnt =3D=3D 1);
+
+       exclude_cmds(&cmds1, &cmds2);
+
+       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt =3D=3D 1);
+       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt =3D=3D 1);
+
+       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1,
"read-vdso32") =3D=3D 1);
+       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") =3D=
=3D 0);
+
+       clean_cmdnames(&cmds1);
+       clean_cmdnames(&cmds2);
+       return TEST_OK;
+}
+
static struct test_case tests__subcmd_help[] =3D {
       TEST_CASE("Load subcmd names", load_cmdnames),
       TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
       TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
+       TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_over=
lap),
       {       .name =3D NULL, }
};
```
If you build perf you can run the test like:
```
$ perf test -v help
 68: libsubcmd help tests                                            :
 68.1: Load subcmd names                                             : Ok
 68.2: Uniquify subcmd names                                         : Ok
 68.3: Exclude duplicate subcmd names                                : Ok
 68.4: Exclude disjoint subcmd names                                 : Ok
```
Perhaps you can think of other values for the test so we don't run
into more issues.

Thanks,
Ian

> ---
>  tools/lib/subcmd/help.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index ddaeb4eb3e24..db94aa685b73 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -97,11 +97,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdna=
mes *excludes)
>                         ei++;
>                 }
>         }
> -       if (ci !=3D cj) {
> -               while (ci < cmds->cnt) {
> -                       cmds->names[cj++] =3D cmds->names[ci];
> -                       cmds->names[ci++] =3D NULL;
> +       while (ci < cmds->cnt) {
> +               if (ci !=3D cj) {
> +                       cmds->names[cj] =3D cmds->names[ci];
> +                       cmds->names[ci] =3D NULL;
>                 }
> +               ci++;
> +               cj++;
>         }
>         for (ci =3D cj; ci < cmds->cnt; ci++)
>                 assert(cmds->names[ci] =3D=3D NULL);
> --
> 2.34.1
>
