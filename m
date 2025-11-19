Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E93702E8
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513924; cv=none; b=F92L2VNZQTvaRDmuvUGFhysSiruJRXTRpc/WEwY8Q6XBlvugkl89QDXCLjla0xTyIkP1XKziEG4rYVlcu7r7yosBilnB64dN/d887HQGffj7eD6YfIitjdcuG9Xwby931rCadkRknRFf4P8Z6Xfv56NbvtDfA1NI7kOZgKE3Ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513924; c=relaxed/simple;
	bh=GwVpQy9p9osfDjoLkz/2+ZEd3Vac0wNDCbA/vjX4IzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1cU6rOHd3/d8lYCeZAosuRmpAtHxfoXg9SV72RA8BMEflXHlH9nWSHxsaPuWiTVUnn0yta3wm5u0hdz8PODOBi2wUF47HtK+YpWt6wZZ9EBuV7d+foKO7sNopQmJRRszm5lRWG7AHggcHUkKRBZl4XfS2WLfIuLOA6PfovCBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohvrc8Pg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohvrc8Pg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso51865ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763513922; x=1764118722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwVpQy9p9osfDjoLkz/2+ZEd3Vac0wNDCbA/vjX4IzE=;
        b=ohvrc8PgnBPL1zix+EJemwR40jVBsaesPSLRGh1PsKHgzNoqZeBbwa5hZ+3ZtvTZiS
         fCRWjVAxUuGWdBRC2sBsmXKMXSWLkOfblzO/YouIH0Gs2tKOsfT/Y7VgZ1wRZmJ2Vbpq
         UE5L/kEU6R8dnvHzhNXX7t/8QD59Rg6ABxCpotvJP+ZHri7PNLpF8Hpjs4DxCLgG5+NS
         k3xbypBqgiitFex3kQikpAlfEc0YJjL6n9sNnTHLov13nZ1ITiuhLRoi5M/El5FWZSxa
         QtSPpzkApuL5lM4rJEtKoaCHtwfvI4fuBsY+YI9XUuFc5uXh+1kPYNpWzB9y8oAAPKt2
         bY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763513922; x=1764118722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwVpQy9p9osfDjoLkz/2+ZEd3Vac0wNDCbA/vjX4IzE=;
        b=JLunLpVG8k49KN/DwAl5DMQR/EsUdMoO5nTnNHsy4NlYsiM1t1MGpeyKTvM5PIUamS
         8SmWCgS6YwSptd6yWohtwQuXDhPU0tO3T46Mip2jzYKpMT80UTzvcHAjB3DQrupQZChj
         t/UwaVtnKDGeAFBoUohyCb4xCNFbBNJSbDP22Nt9uh0HdpLUq+epJRWVQ05gemzsugiV
         S8ppyGY/koZ187h8cAbSfM4MJxBJuHVYb69CScn3cvOcon9e9BRk1bU+sMkLB8STouEg
         +VpMFl2UbFacKwnbVOlX0j1tO7VbXT45C5Iic1Sm7MGPJdN1yrfg+Ny1TCkx/DGYzEw7
         JKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWveb0xF4+dU/CKr7w9KaegmMYDEXonbCtebDwxC5J7i+85avpN/GW6gPpwSOJnXwF/XYkxtARJkXETWpB8liMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNgx6WFffkDlNHX05aHtnELnhndLaqXwhpA00ld9ZstZABS9o
	JGjHgwI4BnWCDBOmiK+O4+GD04wnYhTt/6FVzTzPvwhMbrOSFdlF3teeONieW/5Y8eR+qKggqfB
	ve7Jqwr9PkbqHpi/qthgM0oZWgFUgzOc+14aLR5xv
X-Gm-Gg: ASbGncuLoTw5ELAEHgxFngcV4P4l4frYaocDjHQ9l2/5z+dJyGm1B//Fx/fjNetlJ44
	MZ5qSNqb72fpGtEw8xvrdHQxV/qNTcTkv/Ea0gqffsZP7PUtrF+NmtwLmR/apn3AT/nCON3iboW
	Dpnt6Oy6tLbg2aiHnTkMp88V70JNg+Zz6u0nCC+OVnC6HGDci43lXAuVW4DvBaXNFlGinPeqCvq
	T4wwMOsog2xyRbsK/xkP+zAhZG3jZRw4igXZedtNPBz+UskS3nHwmTCqC40sfsjMyts36i0l6av
	3zL/9QN4JnJwKNxu363y4lBALzTLqb7xjvXo
X-Google-Smtp-Source: AGHT+IEQCQoM3oAb3/g0ua7BMXx06hWekLGuHKFxLIW/sFW1co+BOv8s/Z+96MRyfLRZqdTAtzt7bVEWROIm3z9mwlE=
X-Received: by 2002:a17:902:c412:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-29a05fa3a9emr990865ad.5.1763513921749; Tue, 18 Nov 2025
 16:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118211326.1840989-1-irogers@google.com> <20251118211326.1840989-4-irogers@google.com>
 <aRz-6jQf9GH4JROi@tassilo>
In-Reply-To: <aRz-6jQf9GH4JROi@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Nov 2025 16:58:29 -0800
X-Gm-Features: AWmQ_bkQuffoviTgy5y0ooHnLqsR-dISriW1Vp4fzGv_kitVXgMSGfRHOn6PnJs
Message-ID: <CAP-5=fWSXboT2jEYtua_N8AnaXc0SUeoC2iBgxSz5QRF09bfoQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] perf stat: Add no-affinity flag
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:19=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Tue, Nov 18, 2025 at 01:13:26PM -0800, Ian Rogers wrote:
> > Add flag that disables affinity behavior. Using sched_setaffinity to
> > place a perf thread on a CPU can avoid certain interprocessor
> > interrupts but may introduce a delay due to the scheduling,
> > particularly on loaded machines. Add a command line option to disable
> > the behavior. This behavior is less present in other tools like `perf
> > record`, as it uses a ring buffer and doesn't make repeated system
> > calls.
>
> Like i wrote earlier a much better fix for starvation is to use
> real-time priority instead of the old IPI storms this flag
> is bringing back.

Ack. This is only adding the flag to perf stat, are the storms as much
of an issue there? Patch 2 of 3 changes it so that for a single event
we still use affinities, where a dummy and an event count as >1 event.
We have specific examples of loaded machines where the scheduling
latency causes broken metrics - the flag at least allows investigation
of issues like this. I don't mind reviewing a patch adding real time
priorities as an option.

Thanks,
Ian
