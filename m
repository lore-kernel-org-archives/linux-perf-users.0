Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40E364957
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702664; cv=pass; b=lnquZdE2+ZEZbbk0OE/5WgtG1WMlos8WoxUTURz2+EjUzZEdp1KxsWsEy2+c17jkVjc6DBj4gB60Z9wMGph1Qt+dvdGK4fNw6wPk3q8AvIMDV23GR9jGlsxbRcvuO3hxoWrlQFtrWJyZlAEAgGsrExX7W/EnchdSWUlHPJtcK3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702664; c=relaxed/simple;
	bh=1Du6tFZ9igGBv4DCcY8bAzPfTgYS+0w//bxO90ypQnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8PNqVn3lwnxNcmlkGh/TmYuPfaq06x7PkVhURDpmJEm7fDOqnzJpmKuGeSb4KoF4kXUfpXyJyvLQqPP6wMrcwr3yCMsQHX7biS3rawEymoY2/qJNV8n45jyrvm3bTGxgaWdkv0WayMIjhuC3afZgOb6GiN00kN9ibUG2sseSLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTBRAXD; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTBRAXD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d68f702851so42219285a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 19:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775702662; cv=none;
        d=google.com; s=arc-20240605;
        b=d2jf6fjESlX/B1e0VN/MatSXQT13lvE+ulkom2xe6m+RVATtalKwtcVhYMaWczyOJu
         GDtsPLACJAUfLSFw2NPfh/OiksPHEvEfzV838vGzWYpVGtS45kJ4fnOItAOND5pMA8dM
         0DQwBysMylPI22sMESHSRrDniyGNxa7kX5PQP7LuOF4yXDpRdV9LllTnOaW4gFXVT/ri
         Zw3x3EDfuKIeJoQrt0CKTd7wRuGVm7B9VXEfvlUfZ8GzIv9Lb9muzhlaIKd+LH980Mlc
         N9+scQQ/NgDPdOUADdCLJ6kr1TBJ58kdwGB0vnLaB/3qK71MyvWnbrnnkNHcwR1T3FCN
         Tc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=871gji8iXjZ8LzZcaRSdSaYLChR5t/TdtuEyvK6RFCA=;
        fh=5vSg9eS+eipkF0kPW27xHeRmEu3OtqeT8k8zhj/tUwI=;
        b=MRZPcRgjP5XQhyiw8jH3bKS3q5NJLeSeY04+QPaj8E8cgyZN2bN5wbmzalxlGUmUK2
         3XUpdOo4cc8B5vvCSbQ+b8NMPgcr5oSgDUq0xezWSf82xFTFmhqxvQ/oyEM5NpGCohCy
         eUsiit17oJlC33YA7vD/yp7RAK21YgIS4RuKdMSdDkYGL6col1nG5wBSop/mEl7Equuz
         qAw06YvmWgJytBhg73o5IrnXa21uhvxu45goGyuoGqPSgcyw3U+FLAmha05B00ePZ3qd
         sjEyLBlAAMeHtRIulpAcIoKjKRLylTQyrs26KzJ8MfwaptMdecYKwisIZbI7mPxrCWpo
         dUTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775702662; x=1776307462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=871gji8iXjZ8LzZcaRSdSaYLChR5t/TdtuEyvK6RFCA=;
        b=TyTBRAXDd4rH9yqvVuH+prVyKuAAqmAz4Ah1vhXuu1x20LUXD26dUjNYJdoWacoOUz
         2gn1pRfH2SOOz6fGOULRrkPrA87bgDSCnUXCxp70wgNGo2jEz5yJR2vJXUnl+231WJdx
         VGTiOq+0ZiqdWFrgjxxiQk1iKliVc26E2CCaBrwbSO/fsRG/VHrOs0PL5XafQabwKmn1
         Z2AdsGD9UahXpc5emsh2xQ72hpLUxk4ZySnS1MCsx7ruzKyqRh70QIS+KCRK4m3zzJjE
         dLpcj988S9t0YcUOyhRZ+itQJ2rg3U4KJEYuN9cuiKaZSh5wlvju5P9G5Ck/1sZvDarR
         uEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775702662; x=1776307462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=871gji8iXjZ8LzZcaRSdSaYLChR5t/TdtuEyvK6RFCA=;
        b=HYdMAqtYhNGorsBuRFMMWIkY+kbghBiZihyy9r1GtdJIGxhPY1cD+A/dQPE8TV63+A
         MV5kYnF30JLnNwtHaoryuAv1iF8kPHzMZNQlnryEVrSxM2WDY2sYQ4rmIN4vuBzjsCNn
         MEzHT1XZYGDfOQ5PsRzblh44VDgtsQiIC0V1rq2VJCPLtw9hHcZYcI6IDIbTCQY2h6y9
         QBHBmajnifi+A6++JHbS9tTBE5U4bfdm7rg33nJWcS5SfWRx5j/7R3G6kCmsHpYmsJLa
         30x2XfAuaNxPKuyd8E86lCdA+voKnA9/MbJSxdAW+r5aUYrCYIAdtVtNmqzikH8qBI2c
         RpzA==
X-Forwarded-Encrypted: i=1; AJvYcCWYzhzrjG1shlUcjXJBe06vKmEyX2mpgMnYHBAp3Wg3H8AFixsWJEZuJHV3t5s8m3J5sR4Q5WmRN2Jzu6SEVUyf@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtcOu/XfzgPAQe6E6IDKvYvBJ38epbijNuyor9b+HMrm6NlO4
	n9pbYIqCegIUlwYsu9+NyW9CxU9Jtj/zeMPjAQZiaEh9d0gI9WhvoIaqMNPk4no+16cm9+axFT7
	TADC4HBU3I5lGlXWM80Tqg6nPkKKRJyM=
X-Gm-Gg: AeBDievOWlX9xqU8NIDL4+d5oDaSmuKktWtw5J1vhT0BVAwx7e8xpqYD7wVZ/7CJ1cJ
	SNGPnEhbLvba10mPApDzNGjpG7Jxd1XHj7CxdvQ3YLmdIe1u+pgKHgDnbvqw5QxnAnNtAW7O8PF
	gPTjHJr4+q9zH4kzblNfSYgrqyaWMPBgN7pz772inKg3VJprwuQA+0SbOR35e2HJl5i4X34i9ap
	Vz/RxtJlU40J4TL77I6tLCLooJuCr/ZVh1WZABLR5U1gvusD7j6k0W5HluEfvTNO+U0vJR/6ev7
	SiVuyg==
X-Received: by 2002:a05:620a:2988:b0:8d3:cdeb:6d3a with SMTP id
 af79cd13be357-8d41e62f4a9mr3265255385a.57.1775702662334; Wed, 08 Apr 2026
 19:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408113143.1645091-1-tmricht@linux.ibm.com> <adcPeB5qc0M0K8Fw@google.com>
In-Reply-To: <adcPeB5qc0M0K8Fw@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 8 Apr 2026 19:44:10 -0700
X-Gm-Features: AQROBzDXtGknASP2wkzXWBfVH29fVRefhJPjjbxejEFqBfetRAxuoF_jRkjYAVo
Message-ID: <CAH0uvoiyqcR6+kqw2=6N7n8wCH1PA3P687vzSrQGVOeD0MDb9g@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Run test 126 exclusive
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung and Thomas,

On Wed, Apr 8, 2026 at 7:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Apr 08, 2026 at 01:31:43PM +0200, Thomas Richter wrote:
> > V1 --> V2 Fixed commit message
> >
> > Running both tests cases 126 128 together causes the first test case
> > 126 to fail:
> >  # for i in $(seq 3); do ./perf test 126 128; done
> >  126: perf trace BTF general tests    : FAILED!
> >  128: perf trace record and replay    : Ok
> >  126: perf trace BTF general tests    : FAILED!
> >  128: perf trace record and replay    : Ok
> >  126: perf trace BTF general tests    : FAILED!
> >  128: perf trace record and replay    : Ok
> >  #
>
> The test numbers can be different on other platforms, let's use the test
> names like below.
>
> >
> > Test case 126 fails because test case 128 runs concurrently as can
> > be observed using a ps -ef | grep perf output list on a different
> > window. Both do a perf trace command concurrently.
> > Make test case 'perf trace BTF general tests' exclusive.
> >
> > Output after:
> >  # for i in $(seq 3); do ./perf test 'perf trace BTF general tests' \
> >       'perf trace record and replay'; done
> >  127: perf trace BTF general tests                   : Ok
> >  155: perf trace record and replay                   : Ok
> >  127: perf trace BTF general tests                   : Ok
> >  155: perf trace record and replay                   : Ok
> >  127: perf trace BTF general tests                   : Ok
> >  155: perf trace record and replay                   : Ok
> >  #
>
> I believe I have a fix for this problem but it's blocked by a BPF
> verifier issue.  I need to find time to work on it again..
>
> https://lore.kernel.org/linux-perf-users/20250814071754.193265-1-namhyung=
@kernel.org/
>
> Until then, I think it's ok to have this.

Agreed.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Howard Chu <howardchu95@gmail.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> > ---
> >  tools/perf/tests/shell/trace_btf_general.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/t=
ests/shell/trace_btf_general.sh
> > index ef2da806be6b..7a94a5743924 100755
> > --- a/tools/perf/tests/shell/trace_btf_general.sh
> > +++ b/tools/perf/tests/shell/trace_btf_general.sh
> > @@ -1,5 +1,5 @@
> >  #!/bin/bash
> > -# perf trace BTF general tests
> > +# perf trace BTF general tests (exclusive)
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  err=3D0
> > --
> > 2.53.0
> >
