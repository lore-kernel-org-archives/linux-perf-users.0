Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79D3947AC
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611773; cv=none; b=nz5MTkJDX+y0V1alh95I+HYdLW/G/ZIYjbfuPLurbDgkByMLDM2Vbp5H7a9oa7IalLdCQHq9vokW3qad+bNYibBrFXNl3EjqOOBFo5UeOfUrleS9JvESxPksVvB5pCxVnKcmLyR8t794BLAOx5PHYmPrQncg4XFmSKin7rNvrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611773; c=relaxed/simple;
	bh=ZIDFmW33s/BYlp1smiEqjUhUoomUB1ECsNVlkPtGt/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEH6p31uziayJ31eQljhfmtFG1MMGwjHwmoQ9dkb1Y7r4N+e3gLm3EMUF/Enks5h6R4RuQIUtf7xgIvijtgSMEvUooCj1+JGUVeXJ9+FQa5edi4lMW2IUZVCqzpVm7eLOg9fbRa00i+Q39gSSr5pJzN+NgztDAOT3Xq+4b1nxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=WPODuLkQ; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="WPODuLkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1787611770;
	bh=ZIDFmW33s/BYlp1smiEqjUhUoomUB1ECsNVlkPtGt/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPODuLkQR2a8jRjCl+m1pQbej2W9Y1R7HL5E7MMPBrg5Mi2Mzv8dn0Ji6iuDEd7px
	 21U9+k/aNxeUJgFv1DaFqK+yqG/CFeZmXnf5l2k9TlBzEJe4SdzXIiDPYlw15Ma0AW
	 2eFQ4/vzcZeTJ6JXvv72Qk5y4qq1E1+xu/1OyeSU=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id AED635EA52; Tue, 25 Aug 2026 00:49:29 +0200 (CEST)
Date: Mon, 24 Aug 2026 15:49:29 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com,
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v1 1/7] perf evlist: Implement evlist__can_merge_hybrid
 using first_wildcard_match
Message-ID: <aozKea7UWmKNSED8@firstfloor.org>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824063744.1533837-2-irogers@google.com>

On Sun, Aug 23, 2026 at 11:37:38PM -0700, Ian Rogers wrote:
> Add logic to dynamically identify mergeable events spawned from the same
> wildcard alias via first_wildcard_match, breaking reliance on hardcoded
> PMU metrics or type IDs.

I'm not fully sure what first wildcard match is. That means just
matching on the name? FWIW I think it's ok for common cases, but there
are definitely also cases where the same event doesn't quite mean the
same on hybrid cores.

but anyways as long as it works for "cycles" it's fine because
that's nearly everyone uses with perf top.

-Andi
