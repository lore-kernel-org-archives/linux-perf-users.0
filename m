Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555542C234A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200082; cv=none; b=GziETzs9lmTVR3hx+Uh5H8l2qZ//kzL8Q09w5loKcAQ628NHbXICNrVd+dO6N0A9+IN5HYODW22qS7dpvw6veQOqSlMNDVOR5RxegOBTqMAn/Goerx13cd87KyNsSIpGTlEdPaijuCYGibxM/EAg70CkOUOKhyGm7kM17bHsSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200082; c=relaxed/simple;
	bh=CjVr/v9YGgdYwb+qkZ92JctKmZ48epFoj3Pd2u3tZfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hyZbns2UM7dbHYSIjpnOb9h+7dtkjywkS6hzCyqvzpIE5xMXEhEAUu1s+V89OgNUs038wnyAlWEQImbSNeh7U6891SrbwM8nN2cFntTTFDrT5oMok1ytLxMJgWcC2LWNEI8CRvzxjrKDFW4w39j30MimhzJH6wWgJfW9hvqD4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXEr0AqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXEr0AqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7881F00898;
	Thu, 11 Jun 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200081;
	bh=Aa+F1P1VG81Q8vJO8K8csbr8xJz3maMXAJB7acyjwp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LXEr0AqHdkXnnanDcPw4XJivOuT/n852bVaPSTb2B8GizM9+FqNpa9skhZT5zgXmn
	 1x1PXnlMpkrSssy2zk2ye/5gZ24ei0lIPby3oRopuQv3+FuhHVQ8smZ9LKw2N37jua
	 HzI4n4nPlT7lN76BhQ0r8wRBLOhaqB/xVIuBjTiQ7+11TzSg8eXqaDb9tJmRVJcdik
	 G359xHaEuHiQ3KPEursoM+zR5T0IVw1Y/N+baLd54tcFlUCS7stfcNGloNa+LDSabU
	 kARfHxyrqoa7Ren14E7egGLDh57Rt6B7GXicGZQt2HDzUPsSTufkHmi+IcaYMn31Rv
	 PJjTt/rSKqzEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/19] perf python: Use evsel in sample in
 pyrf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-9-irogers@google.com>
References: <20260611171756.4008769-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:48:00 +0000
Message-Id: <20260611174801.1F7881F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing perf_sample__exit() in intel_pt_synth_ptwrite_sample() cau=
ses an unbounded memory leak of evsel reference handles.
--

commit 066c6045c7e42b049bde264949dd63e4c5d7f471
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event

This commit avoids a duplicated evsel by using the one inside perf_sample.
It adds reference counting to the evsel within perf_sample by applying
evsel__get() and evsel__put() during the sample's lifecycle.

[ ... ]

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 56a9e439f5f8f..11a5ebf3b2367 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1830,9 +1830,9 @@ static int intel_pt_synth_branch_sample(struct inte=
l_pt_queue *ptq)
>  		ptq->last_br_cyc_cnt =3D ptq->ipc_cyc_cnt;
>  	}
> =20
> -	perf_sample__exit(&sample);
>  	ret =3D intel_pt_deliver_synth_event(pt, event, &sample,
>  					    pt->branches_sample_type);
> +	perf_sample__exit(&sample);

[Severity: High]
Does this also need to be done for intel_pt_synth_ptwrite_sample() and other
similar synth functions?

In intel_pt_synth_ptwrite_sample(), the sample is passed to
intel_pt_deliver_synth_event() which eventually calls
machines__deliver_event().=20

Since this patch updates machines__deliver_event() to acquire an evsel
reference for the sample:

tools/perf/util/session.c:machines__deliver_event() {
...
    if (!sample->evsel) {
        sample->evsel =3D evlist__id2evsel(evlist, sample->id);
        if (sample->evsel)
            sample->evsel =3D evsel__get(sample->evsel);
    }
...
}

Because intel_pt_synth_ptwrite_sample() returns the result directly without
calling perf_sample__exit(&sample):

tools/perf/util/intel-pt.c:intel_pt_synth_ptwrite_sample() {
...
    return intel_pt_deliver_synth_event(pt, event, &sample,
                                        pt->ptwrites_sample_type);
}

Won't this leak the evsel reference handle for every synthesized ptwrite
event?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D8
