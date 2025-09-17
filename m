Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0732773CE;
	Wed, 17 Sep 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131822; cv=none; b=PBf5sL3sOwZ44OEYVnCAI4IHgKaoub3W3IXt3y+Gb64EYPl5fbG1N5qFbElG3/S01UWyjhCiBqEl4okKmTh6FPPk2DRSDV5kCEanSMI2o38VW81gXE3xi1p7aK62sV2K/y2mTn5GQ8Zwl3R2jMGKJZolTpY9rNMS/ZoFQEkNOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131822; c=relaxed/simple;
	bh=67ffSzd5FeWwRmf2I/9jF06+U1mwUT8kfxZrOsoiHu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJeKGK63/MB+71ro3sftMHHi8CDYGwYtS9y9P1l5Fj1ciddj/m1who2Z4dFioSOLQaxzkuNeuto/vO19/k+G1iBb5G0l/FS2c+khHP8B2cpocQzfeHO6Iy3EHwSlsQQxVp/Akx+nYhfJC20o+Vp+kVeAD0ccz2z8oWz25aco2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leFSV0pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leFSV0pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3518FC4CEF7;
	Wed, 17 Sep 2025 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758131821;
	bh=67ffSzd5FeWwRmf2I/9jF06+U1mwUT8kfxZrOsoiHu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leFSV0pjTJStHKC1yptmZHoKANoD8KsuqwcsG3/oWcTRusRkBmC2B2msU7Lrm+vdm
	 NjM/0gVBZjoKEQxDdDF8upGJa4n9Jpm6Meb3aSf3t/fRBM5dEd9gHdFQKwoOM9mKKY
	 1052H41Jv4G+j162LX+4vnz3LxYZuA2MRHEeYy4u4gj1I3NjRYn2x/y3OKJ6u7aVnt
	 c1/Mso9Ru2wzyLBmCrjGMioEAtiYTE0KuGqNJg+wGZ3cBJ1NSHhplw3C4EjWdYmrY+
	 2gU5L5jIM1sWXxMkw9Uw02Up9Ixp271zhLpRdVtbczLaj2ji65HQqCGuEfOHCeLCJb
	 R52tCaDV6G6ZQ==
Date: Wed, 17 Sep 2025 14:56:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
Message-ID: <aMr2aokEOET8sdu-@x1>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
 <aJ-VWevppm9Srjmr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ-VWevppm9Srjmr@google.com>

On Fri, Aug 15, 2025 at 01:15:21PM -0700, Namhyung Kim wrote:
> On Mon, Aug 11, 2025 at 01:55:40PM +0800, Dapeng Mi wrote:
> > Dapeng Mi (6):
> >   perf tools kvm: Add missed memory allocation check and free
> >   perf tools kwork: Add missed memory allocation check and free
> >   perf tools kvm: Fix the potential out of range memory access issue
> >   perf tools: Add helper x86__is_intel_cpu()
> >   perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
> >   perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
