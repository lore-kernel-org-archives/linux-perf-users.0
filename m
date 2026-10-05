Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634634EF1F
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240449; cv=none; b=EBBq5eRZAkqQWG5tF/qm2VJ2Q0OwODflRI9g1gZx8BDMXRFHntMAjmvOtHP/IrDep1n+KAyObsrw7HeHbVwMJm5DwAPHnQjmrSZpKSiwKJofPG1Kl2PAcUovHpLM2L4Eb4z/bxYdLeua2FujM4nZfiU7EczXZi1k3ppYcwiA+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240449; c=relaxed/simple;
	bh=TqLCr9kvEGrfBgVQ9P+NLQD6g59gb1Ofp/EGHKzCnZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oerb8IMpr+ec5Jy+8nEHz9R0NrY194of8gtx88xagsVWa+SU9+Hh1n7LWrmT2nRqlLSOCuBcrdYotcwbi00WRjsxWwaJ4U9X8U39BKiSG8DPOLArrUAXx9zYfy9zDVvjGoO5uFd72DW6tiIc7xo6AjC8KW7n/70VIaRgH4O/rSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgazwCB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgazwCB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72761F000FF;
	Mon,  5 Oct 2026 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240446;
	bh=OtnojGfS9dbZW5QOHF6ThZuMNFGwmDszlMzCTPYmsX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XgazwCB4z5xTdqLWnaqbG0nrzwjgIlckacBwHzaC7RPPcDFfkljeSEXZ3H52fLeDD
	 QAY5OOwD3OcG+TD3dO8DFrAUiZ8LM+Zig2kOQ7dn8gWpV8v+biK68DS+Vxhu8V+yTq
	 eSlrqnkVPQU4JDWDbPcukAZu+g+UhN1GNBPVK0/gd59CxFXFrPThk7Lc27Jl1IFNmv
	 5szvFKqsTFdGQbX/iKpMXLzoFFA2KaMaL5xHIirv+LcGG31DJWfphwch2X5a1uuOFf
	 JxLYAa5/PTxtXF87jyZhtSo2/KYndOhfI7wdIwqgP09HtLeT+ff2/0KeynamUBErJA
	 HhDhjhdFiX/QQ==
Date: Mon, 5 Oct 2026 15:47:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com, acme@redhat.com
Subject: Re: [PATCH 0/2] perf test attr: Fix and re-enable the test
Message-ID: <asQo_ZqrjOAoJ1ux@google.com>
References: <20260924223027.799654-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924223027.799654-1-mpetlan@redhat.com>

Hello,

On Fri, Sep 25, 2026 at 12:30:25AM +0200, Michael Petlan wrote:
> Hello all,
> 
> I have noticed that a testcase formerly known as "Setup struct perf_event_attr",
> later renamed to "Perf attribute expectations test" has been disabled by
> accident during the move.
> 
> That also probably led to forgetting to update the struct size, which is now
> fixed by the second patch.
> 
> Michael
> 
> 
> Michael Petlan (2):
>   perf test attr: Propagate the return value from the test to the
>     wrapper
>   perf test attr: Fix wrong size expectation for events

The "Fixes" tag format is a bit different, but otherwise

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

