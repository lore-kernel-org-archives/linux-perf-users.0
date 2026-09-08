Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259D582BB1
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888551; cv=pass; b=GYYKN06M9bMP/lqxcSd2QIHBJuAEjKmnrs31Ui+fAJgRfxxu9IeIyomiaM025DHSuhuxUBJQS64gWaHzrIQOMzlx2/Ne3wvnOW/IQ6JfO1UHbCS8kcZY4pxp85uD6S8sZ1hSJXE3oqgV6Ek+OcU3KTZL8EDboJaqpNDUiLD38Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888551; c=relaxed/simple;
	bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAmWIhnYjcdlh0YZLg8Le7/YJtm3L46L1sDBvy1J3Ws1fGrUOKSJFouyJy/QL6q+8NlIM73UzWzKf3ohN19bgi/X7MpkZMG9acI5l4Sv3iBk+5dwBbBjBmInRuBSt2NhNDxy+/XEjTon5ng8XaW0bnDxyAKuqofC7VMuyEt8oiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClyU+C3p; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClyU+C3p"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso618911cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 10:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788888549; cv=none;
        d=google.com; s=arc-20260327;
        b=pX+oaaL3wUi+N7onrgqs4CMUdp9f9hg9miLCItmMJPDkYyOriAnNNI5HjZQBkJyT/Q
         CN5yUr+UOKqEUfPNbNxEGmNRmU2spuRoGOcYtnHmDGHQcAdZsy0rsLcHkIQC6B4kUzOz
         em/tqDY+yGNo1v5nYw3mQAbpHobgPjTLIW33mGvifvz0j7xOm71jAn/kWWGrl+7QjREs
         PI6DBKjnz2cRe2QWEh8ZLBavU9uzT/s/yWG2YwW7iO+0f3rknUzapYy1mJkZUKXy6t7P
         2YadQ6Kso3Mk2CyxEvcZ9s8rpOa65ZZ2NuSpmk3oSrPCKR8LcK9jIYbC6ArzIzgTo/aq
         BtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
        fh=V/ZaiO3LoIbLNWqY5T8nKrzh/jUqxnxmnvQKFCa06So=;
        b=n2UUVqNBeEJzLtPp+0JuDtIZ2aKxznd/lPnJEF9e3GZqvnnp1VMQxvjGwGlBKyld9/
         +j1W+WIUyetYkWhV52rSn4QRqkxzXuuDCEe4WHE6fG58mCiGWCgb7jqmtKH5bePFnPlz
         a88xWOBbKSkWcDw1k65oeY8RCfmIZrJTRxgyuIDJjB0hsaV3ucPKd6haL5/S7TcOGEDt
         U1I68mWdGhzD6KNgRoBxIbveVZd35NqVkKVysHVmnhXGkvYD5wLuEv+asi+0KE0ecMvT
         w4qcAhkhd1/w6fiWOZfJvqrLM7kOxc925pN5O8Pjskn35hZasohvCGReakkT0iovEtlU
         K8Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788888549; x=1789493349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
        b=ClyU+C3p+S4ZDuxesv2O5eDPSOFArEp3ahXwDrZowQBInwyV14Gw2ZkAr2kk47/4/k
         xzdcLjU7r+CgWNrC59ORv00IbfZeaPV50bdcpMIGdU8IcYZu1Cy01EKeixOr62dIsOEn
         sTIG7KwhpFHIAJf5dZ+aXt1z2ZZFBOz0YKNq7yHrYn723s//wGQCtqYfmHswPgUL/Ysn
         z0ZTjeMC4O2JXb7t9f36uqSWwxM8sBZTnwd/LEw8V1yyO+d9p43X9lFN3BrimZ3oLWHe
         MiAOU7+6UX69wOTYflNRj89MbegsNzFD3riTBkVAfxlqMef8vBysdIkRaR2lMGj/rCam
         AZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888549; x=1789493349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV5fg2vDNwOsjIsuoNOpfutnb5SXppBqOtK/HP2PzCs=;
        b=BcHumSn1JYUnjGk8WVrB5Vmj/TO8ZaNJe9s7yY0P2PMx5fLk9iEzYMOXznkmFBG7Ng
         1Z2FlV5RB/A+ozVB1d7PPspd8f/jd2YxbGlOIWXz1bDWuwVpXu2+B3U0Dnraf3CjbhFQ
         o3XYZK3WZ7ewnpLEGq21MtIRJQrqYpujZLaGtRt2iCVojjQmUlI4m22NWmZOoGagnGX8
         xo/jxLAMW40Qptd0O2HSjPhcjuFiRkt/JlnQR8WnXKxD0z+GZvisKrTztQPNnBNdp03z
         iyZWdFt2NAfdQq9MuOqxTgNH8x6oUFTOrRnDfb+WDwPIFyB9m+Zc6tKyV2Be0tna1wUq
         uQSA==
X-Forwarded-Encrypted: i=1; AKwUvBwrSUPCo5z/y9MqT3bucq9UWYQtv/uynldkw+gzHbRkvBn32rzj8q8ZEcGspyqWYa9IG2/0sxgom4+KHvsT9Mk7@vger.kernel.org
X-Gm-Message-State: AFuF++kuE/d5/taUZDU3YXovklp5nvJSeXz4zJTdAFnKxCRXUD+C19rw
	GtgnVWUu3/uePlnhm7cbQkCFgxyCsWut8r1zWVnRdId1icPCIYYEtwPQGDhveFH5YEC0qUJe6wF
	dpu70xi7fAYhrQB6GZH0fMrdWA4qOT+IDhWdiavZ9
X-Gm-Gg: AYBFou1hVswSYZdz3AFjYlnlsDoPSh2zvoHSwAQQaxKm1PkiFl15RjYlMP6efM7xPnu
	B6QaQM7TVf6E1nUyfzpctn8XLVDOGQGb49SPlrkgY85IO9UrFn+ni92v25PDB3GElSBlMKEuJGi
	oFzucfXrjIIp4DQlMGMam1Pyxidgx9tjzewYQ1uwfx6D01Hr44TKKYbvMqc2Uj3MG+RnOeKTRpi
	72oJcFxZagG3cQ2TYB2EiZnskWUFxpDTsFEqph+k9y9N+Yiilzg60wDRpwgZ/Gbkzedj6lFHMr/
	WofXSeqaBi1jWBJbCqJ8+OVPPnPXNzCFyv5dNLxbWHSbjPpQ/gHcZ5EvbHWPkw5paeSv8qfkYzY
	=
X-Received: by 2002:a05:622a:1b17:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-530a3b7c7e8mr1827921cf.7.1788888547684; Tue, 08 Sep 2026
 10:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
 <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com> <CAEdQ38EMGjp5RbvZn_RStu1=OOS3H+VT8xHFdnEaVC+dof7Thw@mail.gmail.com>
In-Reply-To: <CAEdQ38EMGjp5RbvZn_RStu1=OOS3H+VT8xHFdnEaVC+dof7Thw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 10:28:56 -0700
X-Gm-Features: AcwNN1U0pzsDB7Ni4zxKoMakrdxYWC_p3L8TNTCtZOf0qYoAAkhxK8NQXfMaReU
Message-ID: <CAP-5=fWjxnoUxSHwrO3aQ=QPdz2zmjiE1kZZgj4o-eXYCx7Qdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
To: Matt Turner <mattst88@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 2:05=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> On Sun, Sep 6, 2026 at 4:59=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Sep 6, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com>=
 wrote:
> > >
> > > GTK2 is long dead upstream and increasingly hard to keep building on
> > > current distros. This series ports perf's GTK-based report browser to
> > > GTK4 and fixes it up so it's actually loadable at runtime after the
> > > port.
> > >
> > > Patch 1 does the mechanical port (build system, widget API changes),
> > > including the leftover-GTK2-call and signal-handling fixes that were =
a
> > > separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> > > port that prevented the browser from loading. Patch 3 fixes two stack
> > > buffer overflows in the hierarchy view that predate the port.
> > >
> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > ---
> > > Changes in v7:
> >
> > Matt, please stop the spam.
> > Wait for humans to reply before respinning.
> > 7 revisions in one day is way too much.
>
> My apologies. I figured it would actually save humans time if I went
> ahead and addressed all the sashiko-generated feedback. Dunno.
>
> Is there a way to get feedback from sashiko without mailing the public li=
st?

TL;DR: drop bpf from the to/cc list when sending patches. This work is
most interesting to linux-perf-users where multiple versions of a
patch series within a short period of time are common.

I appreciate having the latest patches to review. If Sashiko provides
feedback, the change goes on my 'to be reviewed later' pile, which
hinders getting code/fixes landed.
It is possible to configure Sashiko to 'embargo' its feedback for a
set number of hours. Networking does this, and it can be frustrating
when you must wait for a patch to receive review before landing it. It
also slows down developers.

Sashiko isn't adopted on all mailing lists, and while it is a widely
praised, others don't want the email churn. In a year or so, when the
models are better, I imagine the churn will decrease as:
1) If AI is used to create the code then it should be better able to
predict Sashiko-like issues,
2) Sashiko itself can report all problems, suggest changes, etc.
rather than its current drip drip of issues.

Thanks for the contribution!
Ian
