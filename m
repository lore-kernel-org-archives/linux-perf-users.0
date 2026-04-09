Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B62D2496;
	Thu,  9 Apr 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752111; cv=none; b=ZkPjC/VZOsG1O9e2t6ZjQ5VlMrU6M8YfNDrXG+A35G5ke0hFihBmyXR2tosdlTI6Q9SD/AOS+VMdHeAkVFR6GNbPe7vAucJwXxcLFZgAJb5VoXBp604GN/9KOCXHncSeYzKKk141Yr+HJG3EwVQ1+nXxbdvyhHq420ai/WVGCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752111; c=relaxed/simple;
	bh=mS0+4tVHW5CPuehmB2qvZU92Djvs7OnTPDGBJtsLHvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFN0f05yjt8aGWt6DQsGIUbvVJf39Wbe0aDsFyy8E5MQuSOVx6TLtkN8LoiiBw0Mp9UYPj/wFlt3hU9pF0HIAxCVVPvXnBlgC40GQ82gBP2aCC3WiTC5bd80Q3TlHLP1bGKasuAS1vvpYWU6jcNiU22OKa5kC8RfQSidX2D4j/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DDB4zHVR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DDB4zHVR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE55C452F;
	Thu,  9 Apr 2026 09:28:23 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 127023F641;
	Thu,  9 Apr 2026 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775752109; bh=mS0+4tVHW5CPuehmB2qvZU92Djvs7OnTPDGBJtsLHvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDB4zHVRP754Y+6JyGLXpKvVICURuVCUvu19SAznMP4bCA6nqiMO7fo/IHa4I3FWp
	 hK7XDfa23OPvzSAAD2wsEpQm4lzKFoXhI81C7H5a0m/+jflQU35DlXK17yMfez72Bu
	 BiyNa2YBYSz0LFzfb4LHWC0PeimVwh9x1vbIhwSQ=
Date: Thu, 9 Apr 2026 17:28:26 +0100
From: Leo Yan <leo.yan@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Herring <robh@kernel.org>, Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] perf: Fix uninitialized bitfields in
 perf_clear_branch_entry_bitfields()
Message-ID: <20260409162826.GX356832@e132581.arm.com>
References: <20260318171706.2840512-1-puranjay@kernel.org>
 <20260318171706.2840512-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318171706.2840512-3-puranjay@kernel.org>

On Wed, Mar 18, 2026 at 10:16:56AM -0700, Puranjay Mohan wrote:

[...]

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..d7f39b7e9cda 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h

BTW, I found you didn't include correct maintainers for perf core
changes.  You might need to loop them in the new version.
