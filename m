Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E430CD95;
	Wed, 30 Sep 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791586; cv=none; b=LwVNd7fErF2wkuy3sXGMmQBw+MZrjWUN7AC82vSZp7o0hIBZSeUXLM2YDKD16ibBOzilxvn6LQzUsIIg63L3Dkz09TrAGlBGGofcYiq1EQF94W7kNZekmg/54EU7ju1B7ertr/+RfVKvpuioVZYVe9kRZ2FMfjqINptkauw7BQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791586; c=relaxed/simple;
	bh=WHLnm4ibS8eNFYZZC/yb8vXMKQ/T5bM6Qay7vtU2CJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UblC0pidZzDSJmCMpyrEAwRirON6yxosUDriM6V9fAVW+FBVYyyt3mbZDRWAXpI3FASBDSP8Sl5eoA30y68pKL6yWQJSCRqmD3Cj73nDO8BC9fL9ea/ZmVzNwajDPH0I5J8qK0kh0Uwdv/oAMARbPcPp2Qt7NVA6fbArNhhCU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcMa8HsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcMa8HsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170321F00899;
	Wed, 30 Sep 2026 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791585;
	bh=UdJhmbcIUQPdrpN02Nn7g3qF3ECiC90NDo65GpYMHHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KcMa8HsPfydJ+c4zAUrk+6Z9r36gpa+SZ2BISXPVrLDpnzayuqMowpro6AkS+3hXL
	 fNwFPZYmBaNcmiSscJoJ7YrKKSKXU6auOxoXQrx5F6okFMtkAp55hJZi2ByhByj57n
	 UHMOlgFKKzucAVtg5wF9IQeFE7iu7L1nuZC24ahdX4/kIViWYFWIAQ4KB+nq4KDeMl
	 /u3YUfcMLBehXPORDqpyE2Xdj4UyMeJESBxkkC0Zb91eiwFOoFOcE9Ay4rJ0yJ3OY/
	 aenDH1KMFcdNynaSxQ9+WUW7JhIq1e3oPmDS00nCC/JU2Gzt1eXE6vWgeF7G7tiQvC
	 vDuiwyfvTLO3Q==
Date: Wed, 30 Sep 2026 20:06:22 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: Tianyi Chen <hi@tychen.cc>, Namhyung Kim <namhyung@kernel.org>,
	irogers@google.com, ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched stats: Reject mismatched or incomplete
 snapshots
Message-ID: <ar1Pnn1EtP030Pq1@x2>
References: <20260916161125.2548499-1-hi@tychen.cc>
 <arZyC1oiFA8bZ9Zc@x2>
 <a7b96474-98b0-49b4-a524-89bda593275f@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b96474-98b0-49b4-a524-89bda593275f@amd.com>

On Mon, Sep 28, 2026 at 06:57:43PM +0530, Swapnil Sapkal wrote:
> On 25-09-2026 18:37, Arnaldo Carvalho de Melo wrote:
> > On Thu, Sep 17, 2026 at 12:11:25AM +0800, Tianyi Chen wrote:
> > > Identify the second snapshot by its timestamp or CPU ordering, and
> > > require matching CPU/domain IDs and versions before subtracting. Check
> > > that every record has a counterpart before printing, and propagate
> > > errors from either input of diff.

> > > Add a shell test with synthetic snapshots, including equal timestamps,
> > > CPU filtering, and missing or reordered CPU/domain records.

> > > Fixes: 5a357ae6ad63 ("perf sched stats: Add support for report subcommand")

> > Swapnil, can you please ack/review this one?

> I have reviewed and tested the changes. It looks good to me. Please feel
> free to add
 
> Reviewed-and-tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
