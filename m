Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FE330641;
	Fri, 10 Apr 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845065; cv=none; b=mgTYoWLOzeAYYxEidEkBdbE6iZdqEQwOY7+P3MYxt3vDk/BtZnGox5+G3EHfAzYDRCaz80XXsD+G7xopu2o49ZapPLx3iEwB+H6AoY1Smixe9cBeVv57ybMGqeJ3b5Iy+VqwpSkBsaGDQAtNnBYRpB0v1DD3mihCV9LlTIDRFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845065; c=relaxed/simple;
	bh=SuJa5z1O4Ex3dm3isjIut9wwpnyyg1tTqQGk8pC4++U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMWYG1nVU94D1Btcee5THHCc+LkpUiRVRoFB0BTNtPEGfH43/a/ENgSf5PkhnHCJnntbw/882LES3dUN38oVpLQHvlqE1GgC3wpBwkgNChwhwFEyuAACFkeG/75j56bgLcnpu75qfYa7ZSHf4rIf9GSw1N101T756f1gZRgT3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr5xw3oB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr5xw3oB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AA9C19421;
	Fri, 10 Apr 2026 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775845064;
	bh=SuJa5z1O4Ex3dm3isjIut9wwpnyyg1tTqQGk8pC4++U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr5xw3oB6mQxDeVBWXS1JFjnmWLl3cTlZfyBJU3IYLpgT8Bb7LjaZALZ6MDwmWC5I
	 x8IBR9olqbwVMSLWQHyqxKRMC91qjYhYBxDoxHduCiqwB3Bmw5imnUQEaS+mKvo/pi
	 6vszb92F19ZYtUpIW8DZWIUJcdwKrra+pyIaMM6xtXHdv689zYjI9dzJBY9uyzuYNx
	 Fmp+OHtcQFqAVj5Sa1ohVP6qIc2POse9KxweGnjyHosNtvzh6Oa2L6YKqtkdb31Ie5
	 s6edTcFwoB5oxbcg7enyssfdLKO9Gu0jYNe0y369uDCtbtWhtGmIyvSijWCZprf94v
	 gsT45Dgn/y48g==
Date: Fri, 10 Apr 2026 13:17:42 -0500
From: Rob Herring <robh@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] perf: Fix uninitialized bitfields in
 perf_clear_branch_entry_bitfields()
Message-ID: <20260410181742.GA908431-robh@kernel.org>
References: <20260318171706.2840512-1-puranjay@kernel.org>
 <20260318171706.2840512-3-puranjay@kernel.org>
 <20260409162826.GX356832@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409162826.GX356832@e132581.arm.com>

On Thu, Apr 09, 2026 at 05:28:26PM +0100, Leo Yan wrote:
> On Wed, Mar 18, 2026 at 10:16:56AM -0700, Puranjay Mohan wrote:
> 
> [...]
> 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 48d851fbd8ea..d7f39b7e9cda 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> 
> BTW, I found you didn't include correct maintainers for perf core
> changes.  You might need to loop them in the new version.

Yes. And use get_maintainers.pl please. b4 tool will do that for you. 
That will get everyone including authors of commits in "Fixes". That 
would be Marc Z in this case.

Rob
