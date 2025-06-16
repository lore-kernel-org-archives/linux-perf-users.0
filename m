Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DD2882DB
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091467; cv=none; b=ZHug8XHmCEflG5ea2fPonC2AkLCMChCwza5OO/CdZZjEUwL7tBxCIFF/hBryoQGR0X5HdtaUXf401JHyA2Bru/LvQ0uum6/RFjnu2I2JnrZ7HgiU0/Mu0n6jDQPIea9AXrpup4Q4EmtKexmluB7LMFfLODBylWHQNWacLWirKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091467; c=relaxed/simple;
	bh=Cm5virMos3DWSgEmZWrzNg6yYqKXWG/OooADfpRNMoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePt5LpCU3UrtuTY+PVaBdlfnbQexHPDvHtVClMRfftGahAnPgYv30ct5IrE2FxKpuillm5vYg8xDr94P+QV2xgHXVU2gYc4mUn1HlOKG2w1XHcwBShEn5hXmm3uqQsSmqmjVHNteBVhC6EMy/Rsh/MZfCWVsVrqhQFEM3f7aPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXVGMXHF; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXVGMXHF"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3de210e6076so19455ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750091465; x=1750696265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq/FoSaNMIyl/e8Lf2VrD4cN1FNaINRo1rslH1GJtZk=;
        b=aXVGMXHFDNIdamTBXGyFDooUOkgIcehe1c9zCRDwcG3iO7dd9vX1VhSDFn0ZTd+1Yc
         P4OO54ifsgBmc/IScj+QI7NfH9gaOKvFrB7KtOwrRwCmBSE0bU86ORvNgQcGZg2SZagD
         viBf293ZGafydCCPkzlqeEcWcBgACvWuWxE2dU5zjvwNioBG14Y6RU16NM3iToPzCUQq
         3KBW20KjXzmsluI7dL2swVibsz6i3Bty6tHXd4jw1LuEZsrK5x/SOLixR9iICV2i2NdS
         ZtVvV6m0Cgv1b1nqP5kk1s6+hFPjIJDv5hfZb3Im2tGvDAuGmk6K9gT5QZJj4Cbf7NnI
         eIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091465; x=1750696265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq/FoSaNMIyl/e8Lf2VrD4cN1FNaINRo1rslH1GJtZk=;
        b=K3UCnenxdYRZrW9tgIx3JBmoTLDHldG08ySe6z3deq+Ixq/O8w2slMYhiiepBGAeLX
         nONpCf7kRKc57embEED0z7uWB6FJhCnfsQLkIftN9gPeK4oKAw7RzpuNIhlCQmxkY3OU
         v1Asyj6mWFU7zj/6g1R+Rie/cfixt+aDURB8H+QaoRHu2EdtztpDVDWifd6m62ZR1DxH
         /3Hw8ohVtFrFjX3ihOh6U5OJ/P7EAENSh9nNFpn0hlNwTVi9ecAAJXOJ5jY8FZQk3x6l
         cZ9KoZwlOSaOjCLTaKET4SqST2o5FtxDTeYUyLG/FhChIKicv+5imgRc2Q05CtBqtkfy
         e3rA==
X-Forwarded-Encrypted: i=1; AJvYcCW+b9Pyj4VOGMDcXEOm2mlhJ58S5DzbO0zto4z/+DnxrzK+o3DNeQEvyfQn2gkqtW65YRN2hfCcUsaYBuzTo4R9@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoWBQ0SCy4ID0QNciWhxu/ATKR+Jub3Yjpb2z8Qfs23kqY0JW
	mU/wNLjnHCAbQwmQ/6rRvSOYKFh/SjUloPJZlHKo+ww+FS25ExCkYnUrsAMUSVCjMvmCuyLnrZf
	eUM/XxbnAQAcgjh6Y1fYQD0zb1AXH3iXhXjw8KwXw
X-Gm-Gg: ASbGncvIRrcQjqy2sstqCKiWmrjeq+sPVFUeyu6ZFRLr5kYYrqinisAftUpLU5a5abY
	+GRUejby7z1+lYE/IjiM+6JgQgbM8VPagnoQJ56RXtDTvquu+vWgF0l/PUUp9sfyCAXKyJ9fAfx
	hTVk8MCyuCW3yzj3jVT/ENQ8yqakktvwLDwNibF8B3tvQNLRKgq9HJmVKsYa7XRJq+8tX82n7Jq
	3YcW3FU
X-Google-Smtp-Source: AGHT+IGHSwvj2lv1V7O9rVJ1zs/I6lV6OAxCiaPZhFpbO2SixxEQ+9O1rvzKl6msJvPcZ2is64kPuSZ5+2UJLLns3iM=
X-Received: by 2002:a05:6e02:219d:b0:3dd:c9e4:d475 with SMTP id
 e9e14a558f8ab-3de08e32e89mr6183305ab.22.1750091465130; Mon, 16 Jun 2025
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614004108.1650988-1-irogers@google.com> <20250614004108.1650988-2-irogers@google.com>
 <CAP-5=fUz6ViPHDdS9GCAEYUN39L4MpAnRR4CzJWggg0S8vn39A@mail.gmail.com> <aFBFOBUhHnF87R9q@x1>
In-Reply-To: <aFBFOBUhHnF87R9q@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Jun 2025 09:30:53 -0700
X-Gm-Features: AX0GCFvE9nrOqBE66rQ8Ea547F5mV_NdM-Lcl5er8Z_7hgpu_f6HZqD3TrsPnK4
Message-ID: <CAP-5=fWcKkdoP=i9zZMWtHWZ=XWWR_DLKVWEZ8vfxr11j9YADA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf evsel: Missed close when probing hybrid core PMUs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:24=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jun 16, 2025 at 09:04:41AM -0700, Ian Rogers wrote:
> > On Fri, Jun 13, 2025 at 5:41=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > > Add missing close to avoid leaking perf events. In past perfs this
> > > mattered little as the function was just used by perf list. As the
> > > function is now used to detect hybrid PMUs leaking the perf event is
> > > somewhat more painful.
>
> > Given this leads to leaking perf events on hybrid systems it would be
> > nice to land this 1 liner in the next v6.15 rc pull request fixes if
> > possible.
>
> Sure.
>
> Just one nit: while looking at:
>
> void evsel__close(struct evsel *evsel)
> {
>         if (evsel__is_retire_lat(evsel))
>                 evsel__tpebs_close(evsel);
>         perf_evsel__close(&evsel->core);
>         perf_evsel__free_id(&evsel->core);
> }
>
> And then:
>
> void evsel__delete(struct evsel *evsel)
> {
>         if (!evsel)
>                 return;
>
>         evsel__exit(evsel);
>         free(evsel);
> }
>
> and:
>
> void evsel__exit(struct evsel *evsel)
> {
>         assert(list_empty(&evsel->core.node));
>         assert(evsel->evlist =3D=3D NULL);
>         if (evsel__is_retire_lat(evsel))
>                 evsel__tpebs_close(evsel);
> <SNIP>
>
> I think that tpebs_close could be done just at evsel__close(), no?
>
> The way it works I think there is no problem with calling it now twice,
> but it fits better in evsel__close().

Agreed. It'd be nice if we could assert that it was closed given this
has been a problem. Retirement latency events are pretty unusual so
I'm not overly worried about needing this :-)

Thanks,
Ian
