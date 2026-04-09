Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA83DB65E;
	Thu,  9 Apr 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744890; cv=none; b=s1f50nM4hui6J4kBt49uJasPEO4n5y9+Cp8xKZlE4T68oiNIj9WkKNcDf4BBqDmYWaq1QUC1NPUQlImekXyh2PHCud18TeIFiPdMP1XngocYk6R2F15CaQ6ajPhBzdIyjXAStXSYigc9/hC99mvARcUnCNTcvxK6FmSaLwrNkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744890; c=relaxed/simple;
	bh=IoJNYfM+Mn+BFe5mjuehAoualrFBYvdI39XI+cuiCQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTr+NLaxrqtXCqjtIk873TuL8iSXXgYk477uXNnuxlCbzUK55RgUPu2u24IBnCgYyCm5vvVkNJHxegXqyt1ZSp4nj7j5ysP/Oh/mwTyo9InhbxTeGsy1Dfs2zey9oEGeN+MfQCrd9ChUNU/BINaLvFGYX6DEgacK3l/8+S/qmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mnd/rLtU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mnd/rLtU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B88432BC4;
	Thu,  9 Apr 2026 07:28:00 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3C933F632;
	Thu,  9 Apr 2026 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775744886; bh=IoJNYfM+Mn+BFe5mjuehAoualrFBYvdI39XI+cuiCQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mnd/rLtUGdn8bdxWrAR8qG76OdAn4WsoEOoRZcDsUkwHptl5aN/fDFUHnW0trQUsT
	 taJuFzZsYTkMqyeHUcWCyUnQA6IArkpUvKlmvqih+ed3VgBadWWQ9MMcjUXpkG3IMB
	 2M4+XJodDtKkUOOf6pe2TWtuI0vdIAWJY6NPSddw=
Date: Thu, 9 Apr 2026 15:28:03 +0100
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
Message-ID: <20260409142803.GS356832@e132581.arm.com>
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
> perf_clear_branch_entry_bitfields() zeroes individual bitfields of struct
> perf_branch_entry but misses the new_type (4 bits) and priv (3 bits)
> fields. This means any code path that relies on this function to produce
> a clean entry may expose stale or uninitialised data in these fields to
> userspace.
> 
> The function was introduced by commit bfe4daf850f4 ("perf/core: Add
> perf_clear_branch_entry_bitfields() helper") specifically to "centralize
> the initialization to avoid missing a field in case more are added."
> Unfortunately, the commits that later added new_type and priv to struct
> perf_branch_entry only updated the UAPI header and did not update this
> clearing function.
> 
> Zero new_type and priv alongside the other bitfields.
> 
> Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
> Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/perf_event.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..d7f39b7e9cda 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1481,6 +1481,8 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
>  	br->cycles	= 0;
>  	br->type	= 0;
>  	br->spec	= PERF_BR_SPEC_NA;
> +	br->new_type	= 0;
> +	br->priv	= 0;
>  	br->reserved	= 0;
>  }

We already know this does not work well. Instead, we can define a union
for bitfield and use memset to clear it, later we will not bother for
this kind of issue anymore.

  struct perf_branch_entry {
          ...
  
          union {
                  struct {
                          __u64   mispred   :  1, /* target mispredicted */
                                  predicted :  1, /* target predicted */
                                  ...
                                  reserved  : 31;
                  };
                  __u64 bitfields;
          };
  };

static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
{
        memset(&br->bitfields, 0, sizeof(br->bitfields));
}

Thanks,
Leo
