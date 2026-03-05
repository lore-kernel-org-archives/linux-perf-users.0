Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B0364040
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749780; cv=pass; b=uGQqrbWoQMVPS6CF4nOQGHzp7Y07KOcpLgYyFo+prFHD2oK/CWVAKrXofzwSnzyhr70Z+mB+0S1XI5oltIXoDkAboa8yM0oB7wHaSxX69X1jcDtwJmUdJ8WCvkxvLPiDk2CiF+TQXGcsXedF3AnQqu9+RqMvIv0nLsv3vFVS+Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749780; c=relaxed/simple;
	bh=Blv2OasudfPZulWksn522tW4awN7q2wCXx7ImUJLbCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+jXmeTwilBuX+C22nUGc/I2KinARFbkKY/81QNF0yOvrkAMTScnjwGZrb9c1zqEX0lhPdna60+yzBJ123VPOrsaIx/l6/MsWa7s61Ujx9YtD/u+aPeB0pSXVFzj+eV66Te6jJ/MalaeyGD1ZEJa3kO7mFKnw5eZdkWd/yid+30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLBEmwN+; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLBEmwN+"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124a60cc9a1so2608c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 14:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772749778; cv=none;
        d=google.com; s=arc-20240605;
        b=NQhHEoRadNUSaZKXRrbMNnH1zi2eqjwDiDhrpyFsCJ9YDKjWMRTVdzZGOjtc/cjbx6
         jdh7v+v3QapDlfWAseEkYtV5KhZBDbZH8Ah7ky6lLtvBZvQV2Z9BDRcZSF01w+0/Eppu
         DLnEecwPoarzedCMmzDLvt6U5pxj3uB/u9decKE5O/Or8TNbDCbEugqBB+k2FRpPq37t
         DHpwF9aAl4VzPIfd8fNwi1I16BHZNgIKLjM9n0DPw+8ia3fz/TOXoUY8v3WuYyCiDpw7
         ay/DENcTcn7uILXnaS6GpuLDPywIevKpJ1wtGVSd23gi8CVhORIJwGwyAeYuPdU9xL1L
         mjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oA+zfwKkklsNIIftyQIHXHfkZwVWdSWG+65a72MBZMc=;
        fh=GfDN1HEcecITzUqIYluhSrIAoQkuOVposCY6AVgPwxc=;
        b=dmvyw2IKqMeU9eRyYVsVTL+2CrxUal2ltjIs7OXz2eX9p8zJ4X2GVcVpcuf1hwYbwr
         Dz4pooQpW9UIA0dlmOMg5ctQhMThzS35vqrom2PhcWQ4grX1unk72z93/aqeyKUgxNUn
         SP7jbXjlAc7juVaM3gtP3g/4cWFxEY+NaqPDV2o/zGtQtxPBRIZ3GShVKa73CG172cpi
         3yUR0LXgaFxsPadDyMA5IBCHTEXg/N3XfQHnfeoIsbYvbMNt3/sM18s9LN2HCGH99Pdn
         wDfZr6Wg2tzmEOhRamgEUzeRujjZWzwPIc647q2HUMkcmkE6Q2zKOalmrF8VHhRsel2K
         wHbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772749778; x=1773354578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA+zfwKkklsNIIftyQIHXHfkZwVWdSWG+65a72MBZMc=;
        b=uLBEmwN+Xv4EKExgGHkHgClerFzP0/8mGFeWnr2iv/GWsXzGbCiOdNQplHCZ4BfDZu
         kB5KfMjmsfSyUdbFj7MrZd9dlAqg7zHRTpWlUd84fm3zUsSNq2Vlnlkref62l7JV3Bmy
         Q2wJ6jOr3H2bVO7ieAp9kmUN1ars7fhW6pGa95EN47/9/M9DFpYWNdIZqYwBWXnB8rF6
         VGECJvUrRiufefabd7kMpRpzOleh4yR5z3vngeYg0h1ck3T5lW8qY9/WXwU/aPW3/97B
         MOoZYbhWPso1a9xOBC+zfAFegsLgx6+qInNezC+RM7ufumg0jUW10IV7IoiMGio/2zQE
         sChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749778; x=1773354578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oA+zfwKkklsNIIftyQIHXHfkZwVWdSWG+65a72MBZMc=;
        b=TwIqwLHfpbzJ70u2mbbGq7b/e685oPHQTOGBDy4G/KiMCGFFOnR1+u4gPIwiAD0aro
         fCc5s+pE+WL7f6LsBS4Kxwhv+WdmKsdad6JgKGv8/SCdgV3j0qqecHteNT6moSP2ijUM
         wJPvCaElOxhDH3/BBh8BeDlyNdJToAJAur3oAejnke6nLDWX59wHK2ux9925M1xtwMaH
         8wkC6O/gLCOdTNGTcDzgPcGqdigHN3HoTVIpEjZ1M8+Z4XnjZSxu5hEgw8JfImW5E4I+
         x87dUrWe5Mulbb+qPcUmVuYHzpHO+CE5f5TKDOIQx8jmz88DjmHQ9jY86YF++BHzFRZ9
         rxIg==
X-Forwarded-Encrypted: i=1; AJvYcCUj4KtJ/iHTUeO28ZKXS8FIsumG5MDVyPJ44sEp9FBVb0wjjAqEPXf6wwbziAUG47L70DKbIC6Ja1KnWWqVeGI2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37X+ZhSOoHOGKg7v9P8mYHmMJJnK58CqJLm0kAI4vjmGiCzPm
	kUEmQ3jsr9/ESUYg8NActbp3JscLxwtEasat4v+TA4o5iFRTV28Suxsyfz4QU7EORFUAA+nupBA
	wTeYC/aCMCbgi4qaFZjWlM6o9IbUxmZhYWVkJztm2
X-Gm-Gg: ATEYQzxUztc08V7W8JEtlHPh4xmmv+W7MULMHFBhhuVaA6EifXJrBHQRnjFaW6XHp1z
	blBbl/8U3lxeFwaUE0rIsv7L3S5SiMz29YE1yUlTX9WdW2nqIavViybKEbswSTsefGziD0+A4xa
	ONHfYMQx3VkdzxFGI4nqR89rkwGBPx/ycnpKvxVCFJ4vLI2Oo/F1idD/l50ZKoqgz7jQaDndf8Y
	pBZDyxv7C+InEqzelY+RvSma/7WowawSIAwJRdd2jg/XBpN/G8w8YzDs/lS5VIzI7XD+SPj42tU
	vtszCpv7x1399X957Za6pG8jfmtgThhIZEui
X-Received: by 2002:a05:7022:ec7:b0:127:abc:9a89 with SMTP id
 a92af1059eb24-128c25f5e13mr12081c88.7.1772749777178; Thu, 05 Mar 2026
 14:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305021721.593803-1-nichen@iscas.ac.cn> <CAP-5=fXpwdpvv6bTF18S6tDB0E7KRm+Uz=BwYOM-CE-NOAFKKA@mail.gmail.com>
In-Reply-To: <CAP-5=fXpwdpvv6bTF18S6tDB0E7KRm+Uz=BwYOM-CE-NOAFKKA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Mar 2026 14:29:25 -0800
X-Gm-Features: AaiRm513YvFr030R0hQNhrQV_9Mpp8-DTPYichpff9kaVjnY0tBjMvdCHh9lu7A
Message-ID: <CAP-5=fVLXBOxYSGZoaH7=pcJ0-VbEQ=gdgNBwq=nzod7i5+4QA@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix NULL vs IS_ERR() check in annotated_source__alloc_histograms()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: namhyung@kernel.org, acme@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, jolsa@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 2:26=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Mar 4, 2026 at 6:18=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote=
:
> >
> > The hashmap__new() function never returns NULL, it returns error
> > pointers. Fix the error checking to match.
> >
> > Fixes: d3e7cad6f36d ("perf annotate: Add a hashmap for symbol histogram=
")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>
> More on the ERR_PTR is a source of bugs..
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/annotate.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 2e3522905046..64ab5c36ac02 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -44,6 +44,7 @@
> >  #include "strbuf.h"
> >  #include <regex.h>
> >  #include <linux/bitops.h>
> > +#include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/string.h>
> >  #include <linux/zalloc.h>
> > @@ -137,7 +138,7 @@ static int annotated_source__alloc_histograms(struc=
t annotated_source *src,
> >                 return -1;
> >
> >         src->samples =3D hashmap__new(sym_hist_hash, sym_hist_equal, NU=
LL);
> > -       if (src->samples =3D=3D NULL)
> > +       if (IS_ERR(src->samples))

Actually, should probably assign `src->samples =3D NULL;` here in case a
later read tries to use the ERR_PTR.

Thanks,
Ian

> >                 zfree(&src->histograms);
> >
> >         return src->histograms ? 0 : -1;
> > --
> > 2.25.1
> >
