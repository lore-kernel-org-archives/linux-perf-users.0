Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07B20FA9D
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521875; cv=none; b=cahUC+FPJUIzml3V/ZN2t2OyYYQSZuZ3vU4OfxkfhgEgSQ5iN3sRhWvhCh9jKUA41aLrRjd+/Np87fQYOqZp/PltreTeICgW+4zT1lWpA7SSgX+hUWwMc2KEtvhl7zHhxNE1NeXwHmCzaBMGiqNyuwp0qyi4Y3TG8yrOE0bhZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521875; c=relaxed/simple;
	bh=fBtxHDseE7pX1JFiiIw30h4s/j/FhtCbTciY4vyNYAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzhOVHoxhc6PNrFhXao2QndLL7mMu34mIe0DiI2oaTABAjDjFv5s1/HD51nBls0+ZqAxmJOPAhmqDZ7Ob2LX44LrwFXEnkJrTPjja7wwq+2Pbhwy+ysiIlXAHK4ueIsxYQj0v5cmfqebK3+uplNQQHx1dEuTflxBOyWLihMoWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1mwqHcG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1mwqHcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736521873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fBtxHDseE7pX1JFiiIw30h4s/j/FhtCbTciY4vyNYAQ=;
	b=e1mwqHcGMfOtcLoBQRjOHYX4F5JOfvJlin9JlneTDw5XO8cDOySloPM2vKV5EA6gYc3zYq
	ifUubWCRzsmFspCbkcqTkFHYd/aTrBIA3zy4X3EZTvmgqfx1Jf34t5oakrlIJKMTUSQLOu
	hstArswNs8xQuTlWZRYP9dKdHW2oYAA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-SXbVrg4VO_mKISWFgHfYQg-1; Fri, 10 Jan 2025 10:11:09 -0500
X-MC-Unique: SXbVrg4VO_mKISWFgHfYQg-1
X-Mimecast-MFC-AGG-ID: SXbVrg4VO_mKISWFgHfYQg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso18902815e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 07:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736521868; x=1737126668;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBtxHDseE7pX1JFiiIw30h4s/j/FhtCbTciY4vyNYAQ=;
        b=NZTM9Of9FF2AAhTIfY2FpR0C5wKA2hblWpPPIaD1+BI7JWmOOI4SthBWiNKKgRmFZO
         7d8jaUMidO77JVPyTpoQl+IZU4EgIBpffLV3rmWK3MeB4SSli6RwTfOJMwjmYDGP5EA5
         IYmFy8gelMzqZX5YGVDPZIiMjk4CZJgsdTc40pLbajkHGfqiJVywc8pm4Wb6eiX+p649
         BS/yuo9PB1Oub3YS/SHFtkG/UAiI/NThACfIKJTN0eei13MOtlfnbUkTi45a3xNbSszR
         VPdHkXkiz7TOdJC/dTSKs2i7IXmylDHwo9b2UKwh+w441ni8PCRAF6eJpy/uWsfPn2B8
         KQbA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Pim/8uSIkeWdzMTP8NvWaNfqLPebJ/9LmpkQnEtqlmfwpTvC7+OK6KPPugy8frn4aTNSi7irfVd7zLEb+505@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/qlN+QCStEIg3gCjJqc0VIfl9H5KcG47xiP0/9R7UjHugWJu
	badYqHSewruFjnK/NBYnLBxt/Jl3Bw2dAWtVQoQV0EZFBY+ThS5tc2CovkOuS5cvPFcZap5emIG
	sbZLj2LNUjGRXokXC5ECSClqcAqL/8qdO9PEAQOOK8ENHHX3Z0zfLj30HG/g4HEkzwLo=
X-Gm-Gg: ASbGncsFpPDn1xu3p54V6Uj/sHmrFifWPbFY/x6xbkEQJ63VbpdvQO8l5BniDbcTgSB
	80zPScAyRh+zLwuXfHEVlwzdHk3islod9S1Sh8uNqVkGxSM04MpGFuFSu1uN+8aohlnudMsKgr7
	CxGV1+o5mwcOT7AG/EbkFwRehdioIFWjyctzgbV8KUXh6b4nMEWl8q32IXGqXtfnim4VYMFYvRH
	LUM0Zibv14oL+eEJnJyq7LgbGU9yDHTPeWbOsHtZTuDF4mIFCOXGlD6dvLV+XrhWvLPrhiSzQrK
	s7tnML4=
X-Received: by 2002:a05:6000:1a8c:b0:385:e176:4420 with SMTP id ffacd0b85a97d-38a872fc261mr10299007f8f.10.1736521868683;
        Fri, 10 Jan 2025 07:11:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxREE6mTpseXK/ypN3wX8QUqL2Tj0EYQN5GiON0BLkUx0dsFbjASjpylvSWEKJ9BTHpfmTkg==
X-Received: by 2002:a05:6000:1a8c:b0:385:e176:4420 with SMTP id ffacd0b85a97d-38a872fc261mr10298986f8f.10.1736521868334;
        Fri, 10 Jan 2025 07:11:08 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1f2esm4768279f8f.98.2025.01.10.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:11:07 -0800 (PST)
Message-ID: <2ce46fa93b5c33491797e97c6995759b4ed31da4.camel@redhat.com>
Subject: Re: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket
 range
From: Gabriele Monaco <gmonaco@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Kan
 Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter	 <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar	 <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Date: Fri, 10 Jan 2025 16:11:05 +0100
In-Reply-To: <Z4EonTmShlWn3n0X@x1>
References: <20250108210015.1188531-1-namhyung@kernel.org>
	 <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com>
	 <Z4Bt8aIkX5uErX8a@google.com>
	 <0ef32d5e-594a-43a4-ae5c-e8ad05a2d320@redhat.com> <Z4EonTmShlWn3n0X@x1>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Fri, 2025-01-10 at 11:03 -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 10, 2025 at 10:09:14AM +0000, Gabriele Monaco wrote:
> > 2025-01-10T00:46:49Z Namhyung Kim <namhyung@kernel.org>:
> >=20
> > > On Thu, Jan 09, 2025 at 08:53:02AM +0100, Gabriele Monaco wrote:
> > > > On Wed, 2025-01-08 at 13:00 -0800, Namhyung Kim wrote:
> > > > > It's an optional feature and remains 0 when bucket range is
> > > > > not
> > > > > given.
> > > > > And it makes the histogram goes to the last entry always
> > > > > because any
> > > > > latency (num) is greater than or equal to 0.
> > > >=20
> > > > Thanks Namhyung for fixing this, something definitely slipped
> > > > while
> > > > testing..
> > > >=20
> > > > I confirm your patches work well also when the bucket range is
> > > > provided but the
> > > > min latency isn't.
> > > >=20
> > > > I'm wondering if it would be cleaner to propagate your changes
> > > > (using
> > > > min/max latency only if bucket_range is provided) also to
> > > > make_histogram. That function currently works since we assume
> > > > min_latency to be always 0, which is the case but probably not
> > > > considering it altogether would look a bit better and prevent
> > > > some
> > > > headache in the future.
> > >=20
> > > It looks good.=C2=A0 One thing I concern is 'num +=3D min_latency'
> > > before
> > > do_inc.=C2=A0 I put it there to make it symmetric to 'num -=3D
> > > min_latency'
> > > so it should go to inside the block too.
> > >=20
> > > Or you could factor it out as a function like 'i =3D
> > > get_bucket_index(num)'
> > > so that it can keep the original num for the stats.
> > >=20
> >=20
> > Good point, I can have a deeper look at that. But I'd say it can
> > come as a cleanup patch later.
> > I have a couple more changes in mind and this would be no longer
> > related to your changes.
>=20
> I'm tentatively taking this as an:
>=20
> Acked-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> But it would be great to have it as a Reviewed-by and perhaps a
> Tested-by, provided explicitely in response to this thread, ok?
>=20
> Thanks,
>=20
> - Arnaldo
>=20

I did test after applying both patches, went through the code and
confirm my test worked as expected, and I confirm the issue is there
before patching. I tested also in between, so feel free to add to both
patches:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Tested-by: Gabriele Monaco <gmonaco@redhat.com>

(I'm assuming you are referring to 1/2 and 2/2 and not the little patch
I sent in the first answer)

Thanks,
Gabriele

