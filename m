Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C70F9D6;
	Thu, 10 Oct 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520415; cv=none; b=uq94tP0QM+jnKSaSJ8w2l9/Iye73hwKko06tmJywY0slho2rw4aCsKpd/paaDrT2HrTUvZ60Vnw7zWEkcGAnZW9Yr9knJTblyquNlHXFCNnUXZn5gMjoxd8ecLfhHc0veZxtj9EddGHnqpQJuNdQgkhpds5RzJ9AbeuDInd7dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520415; c=relaxed/simple;
	bh=bLYLoR9zCeCxC6ft6XwdkDhKvXMrAg2eFwimb6+jaOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8F7+nmpLKv1Nr8MePCe4Xh73c7j3gqr8C7oL/WcG0cuMFN6WaqM4Z25FvGaqEpp2rPzKYqOwu5n+B2ZPVE3M9rgMpje2u92GjxDtRGrfbPI5ryOBVDLxTeC6UMR3fdBfCWD36X6STwj2tmXceR9N6Uykigl/1c/eUZBUCJnagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bji8pfHx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bji8pfHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1ACC4CECD;
	Thu, 10 Oct 2024 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520414;
	bh=bLYLoR9zCeCxC6ft6XwdkDhKvXMrAg2eFwimb6+jaOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bji8pfHxzyecyqLhzkQTngtgq+xLmXt2zEQ/lei5JrzpcG/u790cq4FMTFG4X2yNm
	 Enmq1ZQOG0rLafhYVoQukosIOXGZfb6MAN5B01RwjpVLyq/2SaZSAWMsDThUJxO31v
	 KqV2/j9dq3GaazlrO3V0eCVplouOtg+uRGxEg+/XDMCl/rALjPRhza5IIV/r7Qm0oE
	 EFMo/T10YUcXrozQnckS39jm0mBoBHx/7dH4CyPFw7F2QXStysc2rJGe8Dza3AjM1a
	 7aH5ZoYgrk1FoMwbFxwoTnU8DV+NOQGwLycRKyDMXm8CW6bBNTNlVzt0Pl5EDPhpQm
	 uI9ecrKOUx+PA==
Date: Wed, 9 Oct 2024 17:33:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux@treblig.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH] perf callchain: Remove unused callchain_branch_counts
Message-ID: <Zwcg3ULyehsSODxF@google.com>
References: <20241006012204.373803-1-linux@treblig.org>
 <ZwYVCTsf8p3v22HQ@google.com>
 <ba80cbe4-877a-4b5f-a5d6-de16fc1d2d4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba80cbe4-877a-4b5f-a5d6-de16fc1d2d4d@linux.intel.com>

On Wed, Oct 09, 2024 at 11:27:16AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-10-09 1:30 a.m., Namhyung Kim wrote:
> > On Sun, Oct 06, 2024 at 02:22:04AM +0100, linux@treblig.org wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>
> >> callchain_branch_counts() was added in 2016 by commit
> >> 3dd029ef9401 ("perf report: Calculate and return the branch flag counting")
> >> but unused.
> 
> It seems the original patchset was not well organized. This function is
> actually used by the last patch of the series.
> https://lore.kernel.org/lkml/1477876794-30749-7-git-send-email-yao.jin@linux.intel.com/
> 
> But for some reason, the last patch was not merged. I think Andi gave
> the Acked-by for the whole series. It might be just accidentally missed.
> 
> I think the missed feature is still useful.
> We will redo the test and re-post it.
 
Great, thanks for taking care of this.
Namhyung
