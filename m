Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D863175A95
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666617; cv=none; b=Vv0uIPYCpg4esp5RR6m/RsCqbvze/+/faw56nNvpkBytc1A6M7T9piVb72uBCWA5nsrebEcfwCvuubg3GJhUZkKbhQ+p+yALQ32zl4FG7m3OMtVSty5SJ+X4uWm6US55428Wm6OtE8/s1o69fQz+yd0I5baCSm6wrBOHGbV76X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666617; c=relaxed/simple;
	bh=mWfPbZnjKygdD3K994aKr9h0f/aqB0e0rYs84lUqVbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tUcuZCLMZnHAT4bpu6MSoF7wsJRno2U9e7eJT3cGmv9abs5x39TcJnzmRUnW4AOqFY9bAe6FxsfuMXelCzoLZREAXrMw+gLlRE/NF4Bk3cPckG3oZcYLAQskPfDSp6OOqh/79ZFEYSQpi2C4iSgNRAeYD37xfm+iX52RM5NPW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf5dtgqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf5dtgqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62491F000E9;
	Fri, 14 Aug 2026 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666615;
	bh=kRLHhOTgf9cPWPBdpSSH9PCMY+UWTsKzWC5dnCBE3Vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pf5dtgqYRmVJb8QQeGwwUabFWvS+hXasmyHZcuGpsPWvalmdDll1K4dDeQmX66W7J
	 7XY7IwGsgyV8Qip6VgyVxWGUPSYghTl/qB39ushV2k0U7BrhLgFtKeF+1HYQmIAy1+
	 1EwzdEQh4NcVrRRsPNMjAm7fspfiCIFK2Ss9Lt/Tld6h7y/hBNvyJOKTox6f7cnUiK
	 XjVsULxVG9mOw/0ZRc9M23Gy1PQlkZqOw00G8PAQUdUPKekflzdJ8dJOMF3VGytCFM
	 Psb/pjYMLc8eq669HsbLJg/ANHkxzvYoRpxQhmlhkaOXUP48aSLknlmSg98LiEwWAz
	 3EBy/JIXQf0SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/25] perf db-export: Remove evsel from struct
 export_sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260403204017.2919994-13-irogers@google.com>
References: <20260403204017.2919994-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:16:55 +0000
Message-Id: <20260814001655.A62491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of perf_sample dynamic resources on an error path in=
 guest_session__inject_events.
--

--- Patch [12]: [PATCH v5 12/25] perf db-export: Remove evsel from struct e=
xport_sample ---
commit 02552ec2b6c1689ee30f03697d74752609caef8e
Author: Ian Rogers <irogers@google.com>

perf db-export: Remove evsel from struct export_sample

As the sample contains the evsel avoid the duplication. Remove the
evsel from db_export__sample as it can also read from the sample.

> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index a1f578c3a8d50..fdfd825c7ef48 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
[ ... ]
> @@ -365,7 +364,7 @@ int db_export__sample(struct db_export *dbe, union pe=
rf_event *event,
>  	if (!machine)
>  		return -1;
> =20
> -	err =3D db_export__evsel(dbe, evsel);
> +	err =3D db_export__evsel(dbe, sample->evsel);
>  	if (err)
>  		return err;

While reviewing the sample tracking changes in this series, I noticed a
potential leak on an error path in guest_session__inject_events in
tools/perf/builtin-inject.c:

> 		if (sample->cpu !=3D (u32)-1) {
> 			if (sample->cpu >=3D gs->vcpu_cnt) {
> 				pr_err("Guest event with unknown VCPU %u\n",
> 				       sample->cpu);
> 				return -EINVAL;

[Severity: Medium]
Will this return statement bypass the perf_sample__exit cleanup code?

A prior patch in this series added proper resource tracking and converted
the other return statements in this loop to use break to ensure
perf_sample__exit runs.

It appears this specific error path still returns directly, which can leak
dynamically allocated resources in perf_sample (such as user_regs and
intr_regs) when processing an invalid guest perf.data file.

> 			}
> 			/* Change to host CPU instead of guest VCPU */
> 			sample->cpu =3D gs->vcpu[sample->cpu].cpu;
> 		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260403204017.2919=
994-1-irogers@google.com?part=3D12
