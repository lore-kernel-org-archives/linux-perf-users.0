Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FE470117
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047767; cv=none; b=BEWusdKulyBDyotgs1u+t4HhlXxA9FLQ8ifdg5QPBhLA5RzPp/UuDiFDTICyx186b033Ym4/3cB6YxAS76oYjG9Rvo4rEO3KhRcUlC67MhfN98Ugo3QxlPR6s+4XF1zCRxU+zW+k1vS1RoMn2viiX5xxVaGaBrLMlVMJ8Pabg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047767; c=relaxed/simple;
	bh=wNUTYRUPIku6viyxSi8VHdJM6SHCNlktioU0yo2RmbA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R5s/+lU78EgVr4kXRwqW63sHEev9T3pWj+/vUn8B7ygS9w96o9TL4Gt7PWvYNx+yKT0l8q5bFWsjIpsz0QM6WaoLNGMk7ZhgPUP9nTvZwI1YDRWl8FDja0YE6w/EGCrusKrZKZACl2WqK/HGzoqXZ/09cJ09wqR/BesTfMN21pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi8iFVxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi8iFVxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4EB1F000C4;
	Thu, 15 Oct 2026 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792047760;
	bh=aE3Yy5SWppxThC0c7kDXOFz4i0c/tdwuP8GHcS+3s+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oi8iFVxRHlmcJ3E1tdYLQQ5qsjhf8QU+Pgcdt8MEZKiVs6kjyR+TPq4wyOUlQ7brD
	 m/djxfos/X5rNmWBMcmIRslYQc+HC5Rgj5+gIQrjPEQP1IrlDMQT2b93oCWKZ7l87T
	 lSF39x48Zp29KelJIRcxcbnwT2GfBBiL3y6+n6+C5ChsWJFpLxH6+TXBtLnCbGyJLf
	 Udi3ZhNaXC2OkFA4BtjLC04NEMGQWOG3kgiUW3CZ7vDxgr1OlBDpd5LNPHMihn0SVb
	 TDTSMXynsFMRMjvost/jDa/wO9WkgjSgBE9KXAo9gKgi5GJF4TN5uuiorMhslEMANn
	 hby9ZBobNz4BQ==
Message-ID: <sashiko-outbox-172377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf c2c: Fix memory leaks on output fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015064850.43366-1-namhyung@kernel.org>
References: <20261015064850.43366-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:02:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: memory leak of format fields on the error path in print_pa=
reto()
--

commit 5a86eb27e5b5cc05d78fa3b2c7aa2c282a65fdb5
Author: Namhyung Kim <namhyung@kernel.org>

perf c2c: Fix memory leaks on output fields

This commit addresses memory leaks by freeing the perf_hpp_list after use.
It adds cleanup calls for the main c2c hists list during report exit and for
a local list in print_pareto().

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 4222ac784fabe..b2b07e6a2a717 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2577,6 +2582,8 @@ static void print_pareto(FILE *out, struct perf_env=
 *env)
>  		c2c_he =3D container_of(he, struct c2c_hist_entry, he);
>  		print_cacheline(c2c_he->hists, he, &hpp_list, out);
>  	}
> +
> +	perf_hpp__reset_output_field(&hpp_list);

[Severity: Medium]
Does this leave a memory leak on the error path earlier in print_pareto()?

If hpp_list__parse() fails halfway through allocating format structures, it
returns a non-zero error code but leaves any successfully parsed elements in
the list.

The error path returns early and bypasses this newly added cleanup:

    ret =3D hpp_list__parse(&hpp_list, cl_output, /*evlist=3D*/NULL, env);
    if (WARN_ONCE(ret, "failed to setup sort entries\n"))
            return;

Should perf_hpp__reset_output_field() also be called before returning on
that error path?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015064850.4336=
6-1-namhyung@kernel.org?part=3D1
