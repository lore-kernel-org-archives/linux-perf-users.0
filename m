Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0453E7150
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880259; cv=none; b=VlRQz7wv29u7lFPOychYQq5Y35RKgl0lpLaP8gjNAl32XxtWPPQjXZlMEtswwiIDsjVXbxahtErLsUgIyOa5ALoSqZkWvn7pHxj1w7PTfefhWJIvT1BSbjZvBfktJ4MD2eVEJhEYb979R+rK3bQJaAtkcNhbh3f4YD39T9aJ5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880259; c=relaxed/simple;
	bh=+7ltxjK0z9a5bLZ7ijNauLz/pPZguT+MCK8ie1ot3KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltZgerA/UgKgko82BwrZ+Dcdu+wuxIA3rLiakGpjlFMxCM9Ii8orkxv8e4VxB4lL8B39oIJigLGLmxcMGD2ffVnxFdv4LYTA3i/Vvu0GOVvXaZFzFRags+75qpYIyUoh4WZV0AV2lzKuQfdRbQsgTx2sqVbgrd32zU6YZeG3Cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMAwibdt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMAwibdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DBA1F000E9;
	Wed, 27 May 2026 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779880258;
	bh=KGqTFvvS9ROJQGSXgijEDECJPV5OA75EyXyQP/46Uas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lMAwibdtFEPs4M/x9xSDBKS4MJget8jlsBqtXFFoxMhxbrCx6tJ8I5slvO/epSGaP
	 CgZEUlzy0WTIT1ro6EXwGMzVp/gwCjsljH3DvDsutyje5altcgYspjhpHA3NjmZ9sG
	 E8SddKRAxtfkhDizkkUAL3llpi4Y2BK85PZwjjdgQcNenzsksMi+U6l1SsFyF4c92N
	 BSI3rCQoLVCarmkFb4CRo572rtHJan/dKm1uo+C7UnzJlinCxdpMh+YztbWMe5zWvy
	 /0UfJX8KDd7XhzIaEAn5kMTWymDHyxcAgQVLKIWhG5F7mG6ZPj2105Eq3NFKKWJQ9s
	 zccoRlEZOuEIA==
Date: Wed, 27 May 2026 08:10:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
	maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Subject: Re: [PATCH V5 1/2] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
Message-ID: <ahbRPjZwe2NsNQIA@x1>
References: <20260504151321.12346-1-atrajeev@linux.ibm.com>
 <afwtl1zodrSUpK7n@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afwtl1zodrSUpK7n@z2>

On Wed, May 06, 2026 at 11:13:43PM -0700, Namhyung Kim wrote:
> On Mon, May 04, 2026 at 08:43:20PM +0530, Athira Rajeev wrote:
> > Fixes: 1dbfaf94cf66 ("perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc")
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> 
> For both patches,
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
