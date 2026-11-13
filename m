Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587656;
	b=Hl/Hezy/76FZ9l2vj0G7GoAerxujYm4YWTHCswwj50BVwAfbPlvG2y9o2Xunz2OJEiUy
	 DYehjF8703dMKU/Zuyd3RcMBRaaWMHBHV+wLgRuXnoPpEF5FoJKzRCrtyQrjedTs/rqGo
	 gtwnJwhnHm1Np16I5+UZGKHddCbPFhuP9DMNdhA4pmtkeP3jCiuTv5n2cpqh9Kog+BqXi
	 cbguOsZKZxAu/eXrbOAm3tkrpNWXRm2d0hgcjBVUpU70zWtsi+S4nntC3YjKKFuEmMKZd
	 hXLWJNL63H4QTi+d2jV2CODXy+ThE9AB16CUHmX8CuY9HwJEwx55341I0QlEkQAub3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b7eNSuyQa1tFtsvn3toNo5OxAf5vVLIkRrt+TsETnhM=;
	b=KCIkHx0yQlcwahlvdXobkRabfCq94DKAGGNYboYZgB4pAMOnWoQ+6kHhyRfktN6yaliP
	 45NvVdXqvCL51AARKRrSyMyCiOIHC0hdD/vPmDB6PrfbXPLA+VUs4Dw0lxtlAq5ZGrTaG
	 NIunRr+Vy0A5eKwFfQk1yUa+FqZldOxyXIUE6V45sDbrWVeaFsKf97woVgq97mVvG/7Vt
	 9sdM6VwAwtdlHlQwbFOGjPtMZqOr6P7b7tJq3nTC9OEWYlSaTne1xTLyau29UagBm73/+
	 LvY9KGjwqey1htB7BrGzPDnUATNXbznEoKlImOPJ63SGlVVd4ddTe47PrudGhUs2TQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mtbbepee;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0F606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5D0F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mtbbepee
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5383c97c8cfso447321cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:34:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587654; cv=none;
        d=google.com; s=arc-20260327;
        b=Nn4UVbLxNKXil2Rm7cWX1/dFoGamj8ZjQuidkbEI6/hbM0vLsR2Rfk+KONPQu2QPwB
         VD9H/QUS8ZIil3s3gYLvVOva3VM3FifR/9J72DBgYeWxsswcTZXUxHbgFmvceiDB20ko
         iz+XuuegyWT4HiS7VRL+Bj6wMhY93u3K1K6BEPlYKKQXO7Qex8hCUvL4sIFdRB15JR83
         8w9W2GXN38IVG5NRWXlVUvCT+//syPacuwrbM+Sf406TzhmPmDtStQI4u9A1uYOMC1T7
         nLx8yDDnKFLF+csCZjkz3C+9TjXvBftRECn6Y6vLmf9A8J4Lj9/kiEJmDn9a8eROGdlM
         HgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7eNSuyQa1tFtsvn3toNo5OxAf5vVLIkRrt+TsETnhM=;
        fh=xzOcYodKpwTAWv9VEcMf/LNMjaSaS4BNAGTjGsNwulc=;
        b=QX+BpC85xwGaBYj6dUZ1B+GI2pLrNo59Utv7A9e0xDjFDV+0yTIG9Ic2Ih9OsyP32f
         svznykEaTUUVQu/pQf1lKdjuWfjHytrjRMKo829V2BQSKQrVC6fCH2cKfhHuLVximHH6
         8RCB4KemCqGiRRx9xIbqnIF6WU0zaNZSvHxfl64SNLq5N/PhQRkFlu6moH4UeVhlj7Eg
         BJHypnwgqNQIvkRZoGin4XQQGGFjvVlkEGb/8KXrbIWQSLdDPhsfbs256RV2jCtTJo/6
         QgQTdtVy7D1wpdiU6e6/6vKq2KZmnKtQHcaQcClyOjbjGKjb57bo/tzyUXCcv9LllQjs
         ySwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794587654; x=1795192454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7eNSuyQa1tFtsvn3toNo5OxAf5vVLIkRrt+TsETnhM=;
        b=MtbbepeeZ10d7k60k3KA4r8wO+9uBNo1Ay6NO1CPPfexW51Z6McEmtPLakjEgtm6Iu
         SsWZkQ1m/znOTYaj/z6nEhVPa+8Ey1K5NhsrMDIMPhSIB7X10z/P6NuiovCjixfURv+F
         jgsrtZWo+oME1eyUKMt4dIyZfu3kwb7DSgIYDWHi9ZcTd7GbHKWLyOWZo+iG2Hron6N4
         WsXBFaWbnQkltWHvAlU3uPaLNknvX+MOQ2opJSmwz95dClEuVWW92x2hwpESHJ1BMWvQ
         5KoszhijZJ9FT4cfferIRgnz0fJjsPUSufXo/vppPbBdelJMtL6ngROd9nbzbEMqd/S3
         Mhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587654; x=1795192454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7eNSuyQa1tFtsvn3toNo5OxAf5vVLIkRrt+TsETnhM=;
        b=SgIXsg4WSDrTwPm45C60bXM6HYT/SZthn1ZWeboB138nNQvAC6/oi/8LljhyFt5tiZ
         5eNl7ut+s5TlfpGCfLGAKa+K0KoQESas3w4/221vi1m6IRwsctbIgkYhzP23xKxyetd8
         XxbENKeYyx/xi3ACygJe2nVVb17u0t6JAoxhcFC14e5fTeUI8WJsDZWPFBjUBX9JSHYZ
         l2gFYHXVHZmKws2iPhLudonoiDufgelHhOh0H6tQyeirlfZ0juIvJCYW9pxtBnZNjHLJ
         YEYuKrJSOg+bUjUFz/qaD15UKs0Kyuymq3Vy7aOmJCp7JJ/DMlI0s887l7+hCm0GUkiA
         nrTw==
X-Forwarded-Encrypted: i=1; AL+hErGHbChCig4hnpEXbQVS21KkFtjEPqJpt53mq1yeMzX0BNGsfpUpWRTInGfRYzRmKS34wGchPnMJQN0rLqpTb+EQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/gz41I9x340ZX3baAsUX6jCD4X3gCoQ+5wUgTdCtjY9/r+vahE
	QRWUrbwq5XqfFqbRNdPdJnaRUH1U8/Fg7+Z2YlvynZXubpdnkxmQTNYVVh5v1gV57N9xlgVs43p
	UQMJ86RtCqTNSvubmHSXTNxSUkzmNn0MODi3Li4X2
X-Gm-Gg: AYBFou3UmAD8te5e4t0hl6SREk407JgA002yfTW/JDF6tnXlHPbutiHLZpJ4Pr9a25U
	1H9C+aZb/pXwDUpHqEDUruRsK/2t+2zFYhGHalUoNAi3w9KsAKZM/OVQzZ6XGpjrcjrSA7V4VRR
	3p+PNU3nsPXvbu2bii7tCJY3oEJB7NhYZee3F6jQiIVDhmsErS9tRAihAdTBQnrKnAX3YB8CMPx
	5eabxVi1P/9Yf6PzFwdrgoz+wpxcUTRnyFpq3niahrJ8fKtjuAYPSm+wbVWnGZJVEBo8dHVyzr+
	6hjs+fXQR0iz8W5Po5yisQHmWYIQ8hn2IzSyGsJkNIh2r2/OMW3CygABz0amqzADUVPuFhX0vsA
	qqUIlIVgZM2fTkOv27B/dGzZD+lIMH7B3pH05gwQUz2qWynmNCkaW67kCzgDSjyV3RUY=
X-Received: by 2002:a05:622a:408d:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55ad7e74d7dmr15053831cf.2.1794587652968; Fri, 13 Nov 2026
 08:34:12 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com> <20261111174213.3526604-13-irogers@google.com>
 <avVicOfEPnzFYChm@google.com>
In-Reply-To: <avVicOfEPnzFYChm@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Nov 2026 08:34:01 -0800
X-Gm-Features: AclHuK9OqGSk8ck1I4JLjB0pnpSD93w92b8e_EbtkFL6s6Mk7Zb6EDKfDxyZGp4
Message-ID: <CAP-5=fVq3rovyLZCKBRSec2mOtpoqQizgLmPPg4n=WEtTRTk_Q@mail.gmail.com>
Subject: Re: [PATCH v12 12/20] perf dsos: Use read lock fast path in dsos__findnew_id()
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 10:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Nov 11, 2026 at 09:42:04AM -0800, Ian Rogers wrote:
> > In dsos__findnew_id(), try finding the DSO under the read lock first an=
d
> > only acquire the write lock when a new DSO must be inserted or an
> > existing DSO needs its ID updated (checked via dso__needs_improve_id())=
.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/dso.c  | 16 +++++++++++++++-
> >  tools/perf/util/dso.h  |  1 +
> >  tools/perf/util/dsos.c | 10 ++++++++++
> >  3 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index f0e02062c09c..4dc518f7cb7d 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1685,6 +1685,18 @@ const struct dso_id dso_id_empty =3D {
> >       }
> >  };
> >
> > +bool dso__needs_improve_id(const struct dso *dso, const struct dso_id =
*id)
> > +{
> > +     const struct dso_id *dso_id =3D dso__id_const(dso);
> > +
> > +     if (!id)
> > +             return false;
> > +
> > +     return (id->mmap2_valid && !dso_id->mmap2_valid) ||
> > +            (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_gene=
ration_valid) ||
> > +            (build_id__is_defined(&id->build_id) && !build_id__is_defi=
ned(&dso_id->build_id));
>
> Don't we prefer build-ID over inode?  I'm curious if it needs to check
> existing build-ID is defined first and return true.  Any chance it'd
> overwrite a build-ID with an inode?

struct dso_id keeps the maj/min/ino fields and build_id as separate
members rather than a union (unlike perf_record_mmap2), so build_id
wouldn't be overwritten in memory, though setting mmap2_valid did take
precedence in __dso_id__cmp() and `perf report --mmaps`.

Agreed we should prioritize build-ID over inode. In v13, I've moved the
build-ID checks ahead of the inode checks in __dso_id__cmp(),
dso__needs_improve_id(), and __dso__improve_id(), returning early when
the existing DSO already has a defined build-ID so inode metadata isn't
added on top of it.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +}
> > +
> >  void __dso__improve_id(struct dso *dso, const struct dso_id *id)
> >  {
> >       struct dsos *dsos =3D dso__dsos(dso);
> > @@ -1692,6 +1704,8 @@ void __dso__improve_id(struct dso *dso, const str=
uct dso_id *id)
> >       bool changed =3D false;
> >
> >       /* dsos write lock held by caller. */
> > +     if (!id)
> > +             return;
> >
> >       if (id->mmap2_valid && !dso_id->mmap2_valid) {
> >               dso_id->maj =3D id->maj;
> > @@ -1715,7 +1729,7 @@ void __dso__improve_id(struct dso *dso, const str=
uct dso_id *id)
> >
> >  int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
> >  {
> > -     if (a =3D=3D &dso_id_empty || b =3D=3D &dso_id_empty) {
> > +     if (!a || !b || a =3D=3D &dso_id_empty || b =3D=3D &dso_id_empty)=
 {
> >               /* There is no valid data to compare so the comparison al=
ways returns identical. */
> >               return 0;
> >       }
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 9e38b3b69e9b..df1748763d95 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -802,6 +802,7 @@ void dso__delete(struct dso *dso);
> >  int dso__cmp_id(struct dso *a, struct dso *b);
> >  void dso__set_short_name(struct dso *dso, const char *name, bool name_=
allocated);
> >  void dso__set_long_name(struct dso *dso, const char *name, bool name_a=
llocated);
> > +bool dso__needs_improve_id(const struct dso *dso, const struct dso_id =
*id);
> >  void __dso__improve_id(struct dso *dso, const struct dso_id *id);
> >
> >  int dso__name_len(const struct dso *dso);
> > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > index fbbf98c4ccae..1b3f8b84ed30 100644
> > --- a/tools/perf/util/dsos.c
> > +++ b/tools/perf/util/dsos.c
> > @@ -349,6 +349,16 @@ static struct dso *__dsos__findnew_id(struct dsos =
*dsos, const char *name, const
> >  struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, cons=
t struct dso_id *id)
> >  {
> >       struct dso *dso;
> > +
> > +     down_read(&dsos->lock);
> > +     dso =3D __dsos__find_id(dsos, name, id, false, /*write_locked=3D*=
/false);
> > +     if (dso && !dso__needs_improve_id(dso, id)) {
> > +             up_read(&dsos->lock);
> > +             return dso;
> > +     }
> > +     up_read(&dsos->lock);
> > +     dso__put(dso);
> > +
> >       down_write(&dsos->lock);
> >       dso =3D __dsos__findnew_id(dsos, name, id);
> >       up_write(&dsos->lock);
> > --
> > 2.56.0.542.g3ef89b7020-goog
> >
