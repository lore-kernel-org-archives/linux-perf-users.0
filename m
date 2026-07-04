Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D8524F;
	Sat,  4 Jul 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124073; cv=none; b=fNSWzWUIyTEgNtmFfKGIOQRkZhF4z1ncc+WkWRBhX8Dv/qkGLXciXaIMq5X9WNq5A2cQqK3KTcjsp0kPVaa1/az9/Rom034A81PK+H7nSPIdeYUnO0fm8WolHHY5r6bFUR+Qix/Ar7m8eclQc8kebRfAGmmfMYdl3PQMGVuzm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124073; c=relaxed/simple;
	bh=1c199UVOEhVYWpf+LDXIjQ9OvDv8xfrJZOYI6Znqyks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtOr34/mEja5+dvl7YjRyNOYHeEmoSuX58e5ESfPt80MxBSYcV9B2K1ZZO2pnatT+SCPgnw65vgjnw/Z7PNceHXK9aWH6vHjcNE+fI2C6WtOtCSwwVpYi4WlXVMgIQhGPbpLQNBe93v48/2L88ojiAC8eIq3O6xnTiJ2laSdfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwVzdDne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwVzdDne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71901F000E9;
	Sat,  4 Jul 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783124072;
	bh=h8U9/D27+nsEEEOIUayV7FjzCZtFcZN66dpc8GvwcyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RwVzdDnenaP7+jnQZ3+b6s1twDAf6n3wlaVn1SjV5l2xkJ+lxfw4ibPZIr1A8Avmo
	 THWPWLLmsoyEdAfZo3kzYTX7uuaQ1222Nj5q9UpbKnsMuXOve4/ChHG1LKdC6POhfR
	 wO5ZobXo9eQkE4zKJeC2Fv506Q4U7in4wA6OR2WgFx0Xkg6NXO76PVnrBXFu6suAcw
	 YOtj61HzKqMGIoH0GeXsKQmCJvZ3h63GWIn71AYAGveE6Qz/eifdTTyFbeyu2mdnrW
	 8BGSYV6hOkFzeYerW948aejBTiACddFQkiaqRIHjY2tfjjpLKmb4mV9ergkkjhdlxw
	 ezw2GEtmQs90A==
Date: Fri, 3 Jul 2026 17:14:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: record: Clear BPF headers if not needed
Message-ID: <akhQZTF_yveg840q@google.com>
References: <20260701141347.4098670-1-mayuresh.chitale@oss.qualcomm.com>
 <20260701143148.0B4811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701143148.0B4811F000E9@smtp.kernel.org>

On Wed, Jul 01, 2026 at 02:31:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch conditionally clears BPF header features based on `rec->opts.no_bpf_event` too early in `record__init_features()`, failing to fix the spurious error messages for default and dynamically evaluated cases when `perf` is compiled without `libbpf`.
> --
> 
> commit 9515d1b27d6dcc9884718d4505a8cf399d665c9e
> Author: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> 
> perf: record: Clear BPF headers if not needed
> 
> This patch clears the HEADER_BPF_PROG_INFO and HEADER_BPF_BTF bits from the
> file header feature bitmask when the '--no-bpf-event' flag is passed. This
> aims to prevent spurious error messages about missing libbpf support when
> writing perf data.
> 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index e915390556752..692ab7138d2c3 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1829,6 +1829,11 @@ static void record__init_features(struct record *rec)
> >  	if (!record__comp_enabled(rec))
> >  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
> >  
> > +	if (rec->opts.no_bpf_event) {
> > +		perf_header__clear_feat(&session->header, HEADER_BPF_PROG_INFO);
> > +		perf_header__clear_feat(&session->header, HEADER_BPF_BTF);
> > +	}
> > +
> 
> [Severity: Medium]
> Does this conditionally clear the features too early in the initialization
> process?
> 
> If the user does not explicitly pass the flag (the default case), or if the
> flag is dynamically updated to true later (e.g. if updated after checking
> !evlist__needs_bpf_sb_event(rec->evlist)), this condition will evaluate to
> false.

Probably we can move this check before record__init_features().  It
seems there's nothing can change the evlist between the two points.

Thanks,
Namhyung

> 
> Will this leave the spurious errors unresolved for default and dynamically
> evaluated cases when perf is compiled without libbpf?
> 
> >  	perf_header__clear_feat(&session->header, HEADER_STAT);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260701141347.4098670-1-mayuresh.chitale@oss.qualcomm.com?part=1
