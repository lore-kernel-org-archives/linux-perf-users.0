Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1154936E
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907059; cv=pass; b=ugg2fsVOYDTWQ71PKucrJtgcTboLJm49jvR4iJmIKA/cAeqg5n9G5UFJ7B15B8+1HFU41BLOE4dOGku/9PGlxSPtrzPM9g3yfUJTTlHPU9v7gNY4zngiWKCbZrBdIxHA5DBtcuRxYGjgvN8bs81rDv7MtjKa0sJ9TjvR22CT0L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907059; c=relaxed/simple;
	bh=avfAmNq50TjCdzdERK1ZxzNqg1PNH53ghjGpjf87958=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYKrJ1+B7UOHthSjgO0RYD/lHPnf9dVH0Thp50BFQRuePZLTmSNPtyaXP4hNbl5ysPQH+vfLWt/KvyOUTvQn7IuiaWqhjTyn9UhvDXsp4a+t5HhXpTn8qIA9nDmPTIQ0LoL5WNsg9S/43U96E4wHwIguRIv8pPPDYHOsFt+FLP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdSyEIz5; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdSyEIz5"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso28341cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 15:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788907053; cv=none;
        d=google.com; s=arc-20260327;
        b=Rf9u3fhcA4WmkMq9kbWSft/LIRcM1o9vSkMLibhIQX1Vl8c++Z5WFV/9QDx1j33pmb
         zX2IhUxN2Zi58KHskfFBFhDb5ETQ90v6qg3UJG2i/GHOch978A2FtCOcmyQVh3HlKRd4
         bllG7qEiOWQ7N49PbffkonE85JxL1r6aaAWpcBEhbLbXwM0qOxzmZ+c5pk2VboSttdmd
         FZFQTfr9jVPmQpacOiMWoOwjrrbFJWJPah67i8YTCVPWscLgDEtUDQhVpguLVSD94eFK
         AtDTw2pq8JZrTGMov5XBoyFs9DX28jttEPlF4gGMhPXMKQwh+j38EDPkDt3Kvpb4o2ht
         +VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GlBVIXnHx2dtgSFGVRz0lOWrV/ts1nALJe741lEtcc=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=PvovAMcDguDOeBlVaf251HKw/41YRisNJi+IbxLkY6Qo3R1TmStuHoliPlnPmMtMPV
         2VuZ/HJt6u9+SlecwJpQYmcdQKks+rYJwtY+/8axr3PFgMaR9NHECPkQNAhbEOIaDeDY
         NHNjEXJKbC2v9Yy2ucaKTrMb5tE4jjEQwflEpxiRgzg2FeLSa0Al35JAE7XqNyYRc2Ts
         QfWCmCjaajpzYRBabP3F0goLI3eWzuP7vQBj/VCkxybHvrbnKfRyQScYpOoYk0E9ZQl+
         TuX2NqmrDzrcYgVvuQJuuDWjESAl0eRUm3CLWGvUj3QJhfN37oX9ef0S3mYhQZOIwD4o
         HPPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788907053; x=1789511853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6GlBVIXnHx2dtgSFGVRz0lOWrV/ts1nALJe741lEtcc=;
        b=gdSyEIz5qdJVZLU3ankvplF3rRuDgdjLaySiaFD/wEme0x0PLQxvoweSgcRdpJhgDd
         j1n92Uf9FfI35ZG61phP1LL4Trxo7FeT1pyzf+qxVK8ejOEPNJ5QUD0erGCxdZKfgHC4
         BKPfbDBMKArLErMO09Unj45Vs0o0fIw5KSr6yWd2Bpi0WSaj5oAWT+PUz7cjAAXBvwcM
         3KQIzy1aLmHXsa2UBNwuzv8E+Xw4FKp4ddRb3cABR2rWeZd4JZZwOb2uP7HDnKrIVjO8
         vccPVvbRwQgQ2CITeg3Xg4tp0PLarUgHvKpkdv2xEviiPKJerDuFFDOQwnlENIt0ikyJ
         sGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788907053; x=1789511853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GlBVIXnHx2dtgSFGVRz0lOWrV/ts1nALJe741lEtcc=;
        b=b+0ieWr+Gz6PUzsVWY53j2mbekn+4j+IZzIlvcEPCwmhEZkN+Yp9k2lGaOE93i4Hj5
         peUTl/HyrPs3d63UgiLwulS9rII5EZC0wsX3UyCHGjI+M4QXrQ4NcQ1LEWgaL34J45U3
         9rCODVq8R090qRK6i0LBtiEx9FU2beeR5lniM3WLNL10GvVJpoGl1wS1DhnCkmilcZM3
         jX06jcIP4STY31ksd5PQ6vt/wzTZQ7iWvS/Tn/gDtfBUgHGYWcHl95BP90nNzD85H0GF
         1jImp8wVMjgU4wyvQg9w8ZS7ZY+L29bOp2e4IDB39PsAG57ixmrpFwFyCMgvr8WQdBVt
         UV4g==
X-Gm-Message-State: AFuF++l1QFA/OW61ZzhEGoOpkikFCqoinhdpommzXVu/ZhXL6BQpQpHc
	m3QYsye9+NWgMLva0cNh3TGR/MYz64dD6bRPaVK9tvwgS5HbUcrvc8JgLOatKPTAm9yNSEVY/Ka
	RaHb14Z70CJKMQCvLnjnHbCguz4hsP2oNrx5dykUMKh6Q1q4q2zViNPuDKgc=
X-Gm-Gg: AYBFou0UvdJe4T1CKZkyh5GGCDLZSNTn8KP+6HMxQ9RPhv5KjZMGTDd9CrpYsQjVqFn
	JtTlajVYrFI4C/R0/n3xQonNtR1Qde2mwCAa92auXwSBJtbeZeonJZZRg/wmkln5c7BOA6e83j8
	jZAlmK+6PqmBT66ZXR+GaGHHr6wxqPbb5aBFwtcmMNMVJ+fteKpV+lRQosFHp/5mykVx4LZLwhi
	x3q9EgtNjRwJsgVGnI/atTMfpyTPEsdvS8jvo4P3dNuH9qMe/c/7z1KjX+s77VE/CmXPCiL/ZS8
	vxY6Z6w3pvHhF7AQJUPTu8v6tffjNqlxKMWPoP07QN/oPnCkJdHFImBM+6Ml2WfPTkv5r4GogZ7
	fXqn1DCL/WlE=
X-Received: by 2002:ac8:5904:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-530a498e209mr3106141cf.10.1788907052860; Tue, 08 Sep 2026
 15:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908220720.564614-1-irogers@google.com> <20260908222333.DC4B51F00A3A@smtp.kernel.org>
In-Reply-To: <20260908222333.DC4B51F00A3A@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 15:37:21 -0700
X-Gm-Features: AcwNN1XV-UR6xHf26kqDMbQzIvJ6pQfNsD06hMzMYv-UCUokbLpKwr3viBl5McY
Message-ID: <CAP-5=fWQzkhwWpeXYUr+1VfgryBoVB+1NOuJn5j6guCkyYvykA@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Avoid uninitialized memory read on error
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Atomic Conclusion: Unchecked ERR_PTR from hashmap__new() causes =
predictable application crashes. The return value is incorrectly checked ag=
ainst NULL instead of IS_ERR().

Yep, libbpf's hashmap is a thorn in the side of correctness and
ERR_PTRs are the devil's work. The hashmap code also intentionally has
undefined behavior. I sent this series:
https://lore.kernel.org/linux-perf-users/20260322005823.981079-1-irogers@go=
ogle.com/
to address this. Since the BPF folks are happy with the current state,
I think we should fork the code to avoid issues in perf - we'll still
suffer with the hashmaps in libbpf. I was investigating whether we can
add some form of generics to hashmaps too. Anyway, the issues reported
here are correct and genuine bugs, but they aren't relevant to this
patch.

Thanks,
Ian

> --
>
> commit 525c560536a62c39331ec585b1ce897decf7179c
> Author: Ian Rogers <irogers@google.com>
>
> perf stat: Avoid uninitialized memory read on error
>
> If has_supported_counters fails then msg was passed to ui__error
> regardless of whether an error was written into msg leading to reading
> uninitialized memory. Avoid this by always terminating msg at
> initialization.
>
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index c50cf230f16ed..37752d6bfef45 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
>
> [ ... ]
>
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed that the return
> value of hashmap__new() is incorrectly checked against NULL instead of
> IS_ERR().
>
> Since hashmap__new() returns an ERR_PTR on failure, this will
> cause predictable crashes under memory pressure instead of graceful error
> handling.
>
> For example, in tools/perf/util/pmu.c:perf_pmu__init():
>
>         pmu->aliases =3D hashmap__new(aliases__hash, aliases__equal, /*ct=
x=3D*/ NULL);
>         if (!pmu->aliases)
>                 return -ENOMEM;
>
> And similarly in tools/perf/util/pmu.c:perf_pmu__create_placeholder_core_=
pmu():
>
>         pmu->aliases =3D hashmap__new(aliases__hash, aliases__equal, /*ct=
x=3D*/ NULL);
>         INIT_LIST_HEAD(&pmu->caps);
>
> Also in tools/perf/util/fncache.c:fncache__init():
>
>         fncache =3D hashmap__new(fncache__hash, fncache__equal, /*ctx=3D*=
/NULL);
>
> Should these locations be updated to use IS_ERR() when validating the res=
ult
> of hashmap__new()?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908220720.56=
4614-1-irogers@google.com?part=3D1
