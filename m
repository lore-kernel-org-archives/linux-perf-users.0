Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA4200C3
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620394; cv=none; b=YX3/8rC+pie8vUBFb4wb8BoI9fYGI5Jd9pB/QKyRmnwFzbv9vHfJspY/tfRZlQEk8HRxxuGst/ixG96Y14bZ/d6tPsTAE0WjxaGhpG/gCPvpvhFUXjnzsNeHeXfOR+qcsNJdm/dWvNpMPVGqGbn3WooXC6ElN1nolaPG+1rqmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620394; c=relaxed/simple;
	bh=lnR1APljmIH03rmMQHJl0kK8AphsBZFL2sGEtcS0pIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyekfpvcLFXjC7OfDczlTYyVOKhTnlatlzel4n4iRDxZiwLph+njlU9MmcDtwRpJTzNRA5+0DKM57FwnxeubuSLSTrgj04prrzQhOVqUeDtWmsQIGrKmAv3am2G+s5HTUYewtZZWPIiCDyJsKBFlF4z5UVkVEYiR784gFMW+4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VNWfQFD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VNWfQFD"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfe020675so860341cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715620392; x=1716225192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TITLmmYxLbFcBdgKs9jfudTIyaXBl3JLzkEtZcPj6iM=;
        b=3VNWfQFDww5D++cnMYUTAJEnp8H19Shi6nBrxXoKNonRjjREGtDCb8QWJPf6D/EZ1+
         h4d0JE+1iYy/Xrc4LtzaBvCI9RCanktuC+WJ3KXP0YWyqTsvPIaL2Zl3Dfnhi9Sgn2Xo
         Ly+I8dV4zV4XC9A6ZwUBmjmmD1BNy0oAQ3JwF+7mQ+L0q4K9FoiK1RO//RHJSky6NNPi
         ioNVKw9KXZtJqmNjvzO5MRtML1RN2CAsOSr7LcJBEEsNRox13GN5AIMo2bivPXkgY7po
         odNXAynYhBg7Mjpnv3aibD6V4Mxm7inm/Ne51Vg3OLEgUnRNI6XxKcdd/VZisCMT8MYW
         GzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620392; x=1716225192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TITLmmYxLbFcBdgKs9jfudTIyaXBl3JLzkEtZcPj6iM=;
        b=lk7il/ZdWjhD4upKYW6obXlOu5q0nC5q9zKQqjtpD7/mDLpyghlycAOUHNGY66WgN2
         4KbWgPIkADDdlyLVKiUcMdAOxBiEaG4j6DQYOTDMEuBZZLP3U68YfWEIOURF8rO8k7j+
         H1e+uDSziHDwNr5nvg8OTr+2dOmkz3ua1GW6hyxEs59e2xTO9k8ECWR5kOJuPy35QVbP
         TfMsvUeoGJwaiiZ7TR3quWgTrQ0fL5c3F8Tn4lqFrLjZIvFlK/45yffLAssuX3iuiyfM
         w2A9iK2IGsfV7fW+teNN46t5ExjEVaQ7Lfh9Tdb82uoqhwHOtFp/scXBGbUlRX2RvC2/
         LH4A==
X-Forwarded-Encrypted: i=1; AJvYcCXda7adJ/xwXNPmtcyrAmAZrsjcOWGXdFQ2JnW8lIdzDrSTA390RHcv5TbqF13z8bxb4Hgx6MWydfK3l72nSYH62l3Nk1EmGcnJdQNeS4CoHA==
X-Gm-Message-State: AOJu0Yz+3WFumni+ARP24XPBClDoH/GwmakK5xt2On0oRqd5/LRRb4Dn
	T3rEB/C/hKlQHMrNnYar/YgSIB9iCkG/qhT9jWEdD301oV2nYTN9rkntusvpYuRX4BlzJ+cL7NY
	gPZHzSetsVsY/QvGjzNEWC1rBP7oZIglqCuuS
X-Google-Smtp-Source: AGHT+IEAb7Fu5kKXgnCg0HYiSTA3/+R79Po1+IwMmEjCt9aXoksBEl8u8nhvj+mp18aBdE+jvaZmZMXcFsJzaoRrzgA=
X-Received: by 2002:a05:622a:4184:b0:43d:e294:3075 with SMTP id
 d75a77b69052e-43e0a21da9cmr4872671cf.7.1715620392377; Mon, 13 May 2024
 10:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508133518.3204221-1-leitao@debian.org> <Zj-WE1aG7ihtevG3@x1>
 <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>
 <Zj-qIbUN2XFBnvP8@x1> <ZkJI6Q6KVKlzDgSQ@gmail.com>
In-Reply-To: <ZkJI6Q6KVKlzDgSQ@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:13:01 -0700
Message-ID: <CAP-5=fU=tG9Gk+OfO3TVfBONTc35oksNqi3xm6Y_hjc0oOK=dw@mail.gmail.com>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
To: Breno Leitao <leitao@debian.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:08=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> On Sat, May 11, 2024 at 02:25:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > With Breno's patch the default doesn't change, --no-desc gets fixed but
> > --long-desc is broken:
> >
> > perf list --long-desc
> > <SNIP>
> > cache:
> >   longest_lat_cache.miss
> >        [Counts the number of cacheable memory requests that miss in the=
 LLC. Counts on a per core basis. Unit: cpu_atom]
> >        [Counts the number of cacheable memory requests that miss in the=
 Last Level Cache (LLC). Requests include demand loads,reads for ownership =
(RFO),instruction fetches and L1 HW
> >         prefetches. If the platform has an L3 cache,the LLC is the L3 c=
ache,otherwise it is the L2 cache. Counts on a per core basis]
> > <SNIP>
>
> Oh, both descriptions (long and "short") are being displayed.
>
> > Thanks for asking the question, I'm dropping the patch, Breno, can you
> > try again?
>
> Sure, let me think about it and send a v2.

Thanks Breno! My bug, thanks for digging into this.

Ian

> Thanks!
