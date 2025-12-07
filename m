Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9091E9B3F
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Dec 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765074515; cv=none; b=cLpy9KG7Tbpw7nvNhx9/B2tCQUqk+g6Yd3JvX33mQLYCxRUSnd9W2QZqct0QHWM54BH2LOPQSsrGOMRsrbZoFtkHvVBi9FA98+XQdZW8tPkw/7s8MOBsASU4PkN882ckY2ueDM6+pvNoutynR/J2m/97boWTTzi0TJlCTzsM1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765074515; c=relaxed/simple;
	bh=fHnND8ON3tRMMExO04Gq8eNeQKNFh7wS110U4GZhFOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHhxU360o31s4u2guEsqeZ9D3NEVu9hpIgzh2RiIT34ZZTH+YShuqM8V0KiQ5HnN/Wtlp9/TdNDfOlqnAlfE7wpLsTABUfA2/quD9Nh/2HsCrm+urwBN4/H/V3oMHlv6ErWEB9sBJpbULS87I29uaPpMC5kd24ab5rnAUnN8qiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnFiiz+P; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnFiiz+P"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295c64cb951so198415ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Dec 2025 18:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765074513; x=1765679313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsEN5JBzzaGnvNB+9uUeQ5X4RPGbRf+oIloCaIWDjbY=;
        b=fnFiiz+POVT7FLUvniO6NcLNoHpbtbTzLvdBAl+qGjEa1ZAR/UbGgRWoyDd53wPP8a
         Dn0YHkyHkt1mYsB9Fpib8wEvjyiaAYK75bwSrTtD/2dTyI3aRbjFEfyUKI0c3HtEX8GQ
         ONP4nAGDtKbTwiIx6jpHY7i2gEDCtua+L/ep2O2EDqMXnJNyod4Xk9aZdQo18V0C48qB
         fhA0Khycom1R9VYq/Ip4Lbpy0XR0rlcZJ2BJiEN7Oe4jkBCrdlAgm9NdCKgX0GFTypjA
         onn/8tie29FVa7AYrylhqtEE2IA2I2WzJK/AmR1Jf57poor505s+UOmrdDjwA3bILcxP
         ETEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765074513; x=1765679313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsEN5JBzzaGnvNB+9uUeQ5X4RPGbRf+oIloCaIWDjbY=;
        b=Q91S3PrPRPnYz6QnstrlO4L6UJDI81R+1F0XqOC1napuo06bh1MQYl0p7xXqr0eLBE
         yOiD1fseG4ihJxuwrtIKz94RLeLpOmIJKAfc+RlDEIQDdIEa4ipYS1lKqYmjBBlrwRgw
         rBgJz4a1Xl/jtYmlzGt/UgYcF2okBcsGOMnGOsnfL8NMsuV3YtJfkfwwKrT9y+mRLeFG
         jxbzwqmyotxIoyZc97FK0rQ1QDBW7/k708Y57O2crQap3ikRXNvXkzbM20FIYP7fJKdD
         3iHcEo7VT3iMekEuIdomS889yebq8oAQFvp0e5cdcjUbn5YlkH0TDoxwSshryATx/fyl
         umlw==
X-Forwarded-Encrypted: i=1; AJvYcCWHbWW6ungc+OPBfBG6BTcpUUeyCcsXE35oEA5gw/zu4byC/eJ+tiGyDepMbEmqD8B16l+YiBr4anh2Y7+wF/+k@vger.kernel.org
X-Gm-Message-State: AOJu0YxGejGvx6kPmvoNT2a+RyzR+B9GW3nghj+7rQO2Pte3eE0QxCkl
	MZkJUwhU+fnpYv92rqXYpnk39pMlWFSBgZQw7rRavFDLoAxjwzuMPbOK19/XBRJwWdfVWafLTaj
	vqLHcdA3FyKsq9rQr/c2/j9WX1Ob6g5X0h02WDdTp
X-Gm-Gg: ASbGncuDcJCJJSeDnqt+UE/NiIQ+syZHx7Lene1GzZvDNRjKdHmyp6mJot9qD5BWGSE
	iDoE8+XZcN/z3KkBvaA4Wy/uGPmapqsjiQMTQgEBNAkGF45bzM+zWj+1/1fbGIHQHDNRXunstB4
	FJPDE5Qi9HGMCXbaAKkupyyqYbQDTjc/8l/UFR5z6KCg6gmPS79rfg+kFYVyZTO9Smjfb/Z2iVn
	t289lbOjNbDtsu7sNgo7vOmX4pwcSJVk5AYCGqmQ9oqLnVifbSQBIFjTCrYXNp+hw1WLPBa
X-Google-Smtp-Source: AGHT+IGfqYlNFJJpdQXHZadMdlMe45h7ticFowQoYEN9vNDw6D48eGKAUeCzNDtWu/3nIZzESWbV66vR0ydSj/xTx0Q=
X-Received: by 2002:a17:902:f683:b0:29a:7af:b3c9 with SMTP id
 d9443c01a7336-29df4a39f43mr2322835ad.16.1765074512559; Sat, 06 Dec 2025
 18:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com> <20251201205509.195451-11-irogers@google.com>
 <CAP-5=fWe-Aax42D_9goaX3e-QFpSQBagqWh6ZD+JgLkrMLSe8w@mail.gmail.com> <aTNMNt4wIZJ0q_lR@google.com>
In-Reply-To: <aTNMNt4wIZJ0q_lR@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 6 Dec 2025 18:28:21 -0800
X-Gm-Features: AQt7F2rz9U5X7r654mtDRqzM6lLWUPROVtrTHT4zxaRyLaIWpT053ioG8L7YqYQ
Message-ID: <CAP-5=fWAZWGGNBRY8T3iDV+GSbAoc_Qe3_JF2Wn192sYr0rRew@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] perf symbol: Fix ENOENT case for filename__read_build_id
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 1:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Fri, Dec 05, 2025 at 11:40:12AM -0800, Ian Rogers wrote:
> > On Mon, Dec 1, 2025 at 12:55=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Some callers of filename__read_build_id assume the error value must b=
e
> > > -1, fix by making them handle all < 0 values.
> > >
> > > If is_regular_file fails in filename__read_build_id then it could be
> > > the file is missing (ENOENT) and it would be wrong to return
> > > -EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
> > > reported if other errors with stat haven't occurred.
> > >
> > > Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regul=
ar files")
> >
> > We might want to prioritize this fix.
>
> Sure.
>
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-buildid-cache.c | 6 ++++--
> > >  tools/perf/util/symbol.c           | 3 ++-
> > >  2 files changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-=
buildid-cache.c
> > > index c98104481c8a..539e779e3268 100644
> > > --- a/tools/perf/builtin-buildid-cache.c
> > > +++ b/tools/perf/builtin-buildid-cache.c
> > > @@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct d=
so *dso, int parm __maybe_unused)
> > >  {
> > >         char filename[PATH_MAX];
> > >         struct build_id bid =3D { .size =3D 0, };
> > > +       int err;
> > >
> > >         if (!dso__build_id_filename(dso, filename, sizeof(filename), =
false))
> > >                 return true;
> > >
> > > -       if (filename__read_build_id(filename, &bid) =3D=3D -1) {
> >
> > This check here is clearly wrong when -EWOULDBLOCK is returned from
> > James' change.
> >
> > > -               if (errno =3D=3D ENOENT)
> > > +       err =3D filename__read_build_id(filename, &bid);
> > > +       if (err < 0) {
> > > +               if (err =3D=3D -ENOENT)
> > >                         return false;
> > >
> > >                 pr_warning("Problems with %s file, consider removing =
it from the cache\n",
> > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > index 76dc5b70350a..f43e30019e21 100644
> > > --- a/tools/perf/util/symbol.c
> > > +++ b/tools/perf/util/symbol.c
> > > @@ -2008,8 +2008,9 @@ int filename__read_build_id(const char *filenam=
e, struct build_id *bid)
> > >         if (!filename)
> > >                 return -EFAULT;
> > >
> > > +       errno =3D 0;
> > >         if (!is_regular_file(filename))
> > > -               return -EWOULDBLOCK;
> > > +               return errno =3D=3D 0 ? -EWOULDBLOCK : -errno;
> >
> > I've made the fix after the other changes as it is simpler to fix in
> > one filename__read_build_id rather than all the libbfd, .. variants.
> > If we don't want the series in the short-term perhaps we still want to
> > carry some parts of this fix.
>
> Yeah, I hesitate to merge a big series at this moment unless it's a
> critical and obvious fix.  Can you please separate this change and send
> it out?

Sent in:
https://lore.kernel.org/lkml/20251207022345.909535-1-irogers@google.com/

Thanks,
Ian


> Thanks,
> Namhyung
>
>
> >
> > >
> > >         err =3D kmod_path__parse(&m, filename);
> > >         if (err)
> > > --
> > > 2.52.0.158.g65b55ccf14-goog
> > >
