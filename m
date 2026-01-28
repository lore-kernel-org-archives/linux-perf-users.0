Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830552EC54D
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621040; cv=pass; b=bgJOwqEWwvgQirl/7QJsFbC06IYIkfpOH9dZ3unlxqgvN3KuMF/0wArHVVtuWEFawuoVvaUDVBWFRgpYCRwxO34kFeeHGTs2EkdnUVqcrt+RNoKvBnU3ISG1Rw6sWhVqtycn3kGJTtPKUNQ36QS1pdyJF3x6nvgt7yZu8nKU574=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621040; c=relaxed/simple;
	bh=kizkZuvdxw6uKJdz5CGeib2vOGGoPb1DUKZR/ygQBzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+NBlMNPEk2QeoeOOy85JaIGAih/2MBUUKAu62zHBYDQn3UAy4RS/SioD47WIFh2BYimzcgaRjzolNS26RPXU/JwVspOOeDZeq4IJ5b3jH2/frhYwhpCwLKn+LPoHdO3t9eDy7Aujd1Ia51OWY0Vlu9HKlMprVEVN8rngn92JMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLRINZ9Z; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLRINZ9Z"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f102b013fso118305ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 09:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769621039; cv=none;
        d=google.com; s=arc-20240605;
        b=gK7Xet3WwCIIFKcUYIcKd9JCRkOnHHDsQtH8sNp0VemnjjI+Czd1TsT1daOIDHnNrd
         XSQb15GKgoGVBsstCiTDUQE31eRpvZHpwvleFGrb6g7otubA2ZoCnaoGubb17HKKbsC3
         v2T941odYQGyejbFqU77/uB7ewqYj2PWj4oac8Mule4p5EYwKG3iAWfSzgVzlOojFj2X
         TEhsL1kKpl/di89OyB+P6IRUZXPugoHxU9uxejU3Bs9822GstPveyaKyfOUeRfoVHS1s
         NqK2EwZ9Y7QU7VBxYGU+sskQ/N1Sh6lhRE44eIPrx7xSskd0j4pAzTtFYRKOeu7qY/6l
         KIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        fh=hWtDYNVbCIJv94dm4GB/kBcxF+SO8R9tXo7KQ7PRNE0=;
        b=Ue5P+7tWpr8DoeSALs65UDL9GYwmxuHJ+vVvK/Jikq7nXgUS108TbQQg821Mujk6o2
         B3jsDvSIqpRjxravg6ki6z0b7NU5l3xMX5bcg3ox7+5Xwp5Knvz+smZVqY0Yo+fb2r6B
         LQxT9to5tBHwgXJBEjhoIbIq/yVj1zIbti9EUvH/tYkmX0oSv5UKz7HIP8B2b4YOvHwG
         XxPS5ZQcMSyhf9LJ5x4yURTkM83e9V5zxXJgaZW8RydD3tr5nJknzoz0sB5bdto4tcIV
         9f0IHSFWKDQMn7KuMkdrVvtqiIDtSv1NIm0/zocfNwOybJBE2pLgCmWyMIHU8M+/VoLB
         //Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769621039; x=1770225839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        b=RLRINZ9Z2mdC15RRQfK11I3dIYlKrJQt++jxEjPb5IUjwEYbqGwXI9TdsrC7Os1JLi
         zee3W3QMflyxCOu4sX4hcppUhInbgwXpQRjqbQy/QbsBTKJ1+oEAA6IldwpwN6qXZNfM
         aqPsoyMOTzd2LCGriFaZukmwgRRBLOlLWbtK5Uk4aWuxaipK9C7HTTGM1O6jLEcVzu2P
         a5UsxiFeCNBSVvYP5GkFcYIGQIFuGBKMsF+i4JBi/abCd9ZCRYmTODfFHUZ3Cq9SSMk+
         Y976E+Zzcp74NphQd/ssDhWrhz/IRAWOR78SwW0a7A6fvm+2jX8gFInJ+0rmCPkv5q3+
         RRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621039; x=1770225839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        b=lRArzdtL8pTrqoTkj9fKixg98275rpW+fiBdxSU3vU1SUwOkjP79UAhyM0ZTmucf89
         KY+CGFiTfKoGUQAs71TMv5Lz+CRcYJPU5mo9xrVPioJe3kXTnAlrmQy+K1ZhKiQus/g3
         rry8rfyAGQps2mdJXMowXmqQsMCfPrwbymJAKd/UFShL3YTJ1kOAt8N2mUZH5/VzWwhD
         q7wWTo++PFgDLJwP/sOd8GPG1N9R4p9P61ucMT2LkBPAlaXakYbLtRRH0Kc6c4JUtG8y
         F6xrbrCRZKITpaBFbDAA8dyno2C4mwYUSrep74IPpkV33SGR4o2sqZGa32iHqFmSnlcQ
         HErg==
X-Forwarded-Encrypted: i=1; AJvYcCW9GBcjm6qTI7Q3haOnjshEaYV3oX9YtxrV0/tO3O8Ra9qGzFZz0FbBU3O6h5YpATqmgh0lLt0J093UCCkz3LJs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5bqPowjP3AJdkz/DbEhcEmGRIrtrJiUuERzeLpbnzv5DShA8
	cb2BHWE52IlzLOWjHrhnTA7jcDJo47AOIVgcJ41SYZ4CI7R3bY16asXUf8LQBnsmv3QnSfB1Ixe
	PZoiI1n/LwugpNe4BlVMZJYR4IVY39IY=
X-Gm-Gg: AZuq6aJtUzAuO3NCR04/uERGTt+jwUT48GOceWBga9uekkwK6pccDkqRuDaPqvzqMh3
	yVyX2zcC0caxmCDo2RuG9L4M+R7wmufLGXM71MJB2TRCwgBJllZEatK93h2wsjn1HJny8SoWxan
	CXr/+Hal/x0PUSWa4d0Llmw7HBMmSdQ8vzkbAZdQpkf7fWN2cufkvh2DlSqsI1IVPg5COZo/b7e
	6S13Qkcx1BNki+dfQxn1rY/AYk3CvRl9OKm1iZuPtnl/YDJQnYkHudclGIDRk20YgrnvZuJJgcD
	aFIg+iv/vNY=
X-Received: by 2002:a17:902:e5c9:b0:2a0:d6d5:b342 with SMTP id
 d9443c01a7336-2a870dcbe7amr57082335ad.37.1769621038802; Wed, 28 Jan 2026
 09:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org> <aXoUOEhDfncEkC-f@redhat.com>
In-Reply-To: <aXoUOEhDfncEkC-f@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 09:23:45 -0800
X-Gm-Features: AZwV_Qj6rb3WoP_Y9fiHuFQxMtZyQOzI2dFswDQeqWIoSEtuJcdiEz7owWd2EyE
Message-ID: <CAEf4BzYJJiUdQTjDgr_uVSQ+uBhYWKki0vjS5VffTzbST1uS2g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: fix incorrect lockdep condition in filter_chain()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 5:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/28, Breno Leitao wrote:
> >
> > The list_for_each_entry_rcu() in filter_chain() uses
> > rcu_read_lock_trace_held() as the lockdep condition, but the function
> > holds consumer_rwsem, not the RCU trace lock.
> >
> > This gives me the following output when running with some locking debug
> > option enabled:
> >
> >   kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section=
!!
> >     filter_chain
> >     register_for_each_vma
> >     uprobe_unregister_nosync
> >     __probe_event_disable
> >
> > Remove the incorrect lockdep condition since the rwsem provides
> > sufficient protection for the list traversal.
>
> I hope Andrii will recheck, but looks obviously correct to me.

yeah, I did, and it also looks obviously correct to me, I didn't need
to use rcu flavor there in the first place, I think.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> > Fixes: 87195a1ee332a ("uprobes: switch to RCU Tasks Trace flavor for be=
tter performance")
>
> This commit just change the __list_check_rcu() condition...
>
> Perhaps
> Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly =
under SRCU protection")
>

yep, this one is the earliest change adding unnecessary rcu flavor of
list_for_each_entry


> makes more sense?
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
