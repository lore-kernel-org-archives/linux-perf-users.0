Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499BD531;
	Thu, 14 May 2026 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802596; cv=none; b=Ey2PALbQkHnFuZ5QWLh5Yotjsln+kYqTQ0/EfEZ9NjkbBVNc7r7zE6TlzMsG7GOu8bD+N7ZytmMfAgCtFVaudZC18UXujJNXApU+BhbdN7S01eGUj7pTtqWQVEKkb5zISiW7uD+A+ssi4mtOrj5MUQY54pW32Jkr/Td1DOXoJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802596; c=relaxed/simple;
	bh=TmAevODjhHZElM4G8U/haaPgw/WZu5pMLQPDCwmCXJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDirF0NRq3yp+TLtfvn3+WMa0FB+Gm6QoF0fW3+I1zzKQlHF7cJcvG/c/otJQmJYATYLOqfRXTbwZ+qbI4Uxu8mmvBJFhZSSThO8GmthvR0AodzbWjfSh4MNIeqw4f/d+9MrZ2FtlwL8xneAE6sfbwMFV9nUaZ2dyCYmH7RZyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URFfURfg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URFfURfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654AEC2BCB3;
	Thu, 14 May 2026 23:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778802596;
	bh=TmAevODjhHZElM4G8U/haaPgw/WZu5pMLQPDCwmCXJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URFfURfgVGgzEYd8Mj9WJP8dbk1n67SD7BBTY1psdrs8lvi172VGJa8CSNFSxVxhT
	 JF+jTmgX2RsUoYZmn+9ruk3zmTTvThlorID4d4yccop0Tk5/5i8nxhrli4eAWBqmQR
	 3Mx2xSZCGnJKRn+yGvKFF/LgrBuyNrZ5hjpXap9SyIKPwy9umFrCfl+dgL8htfgoM0
	 FBUnKMgH+avDF7NUtdicunn/YPY9OrM9BKF8DVuuOrYaQZt5Fdw2fci2y3fALpjaD+
	 eMz2y0HfUHJZcwulblRKfkVuw9/XVEYiZnM2SzIHGh6CR+fGHki4aj9TBWps7d/Q0C
	 Rmv55SGmSOGdg==
Date: Thu, 14 May 2026 20:49:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: james.clark@linaro.org, namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, dapeng1.mi@linux.intel.com,
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	mike.leach@arm.com, mingo@redhat.com, peterz@infradead.org,
	shimin.guo@skydio.com, will@kernel.org
Subject: Re: [PATCH v2] perf record: Refactor ARM64 leaf caller setup out of
 arch
Message-ID: <agZfoDoXEVjF7fBK@x1>
References: <20260507170622.611933-1-irogers@google.com>
 <20260512054140.3427725-1-irogers@google.com>
 <CAP-5=fU7Y5b2KERuYJuKBK0nqD6GAo_r_QhxesbVw6T3bqrgQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU7Y5b2KERuYJuKBK0nqD6GAo_r_QhxesbVw6T3bqrgQQ@mail.gmail.com>

On Thu, May 14, 2026 at 10:38:07AM -0700, Ian Rogers wrote:
> On Mon, May 11, 2026 at 10:41 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Code in tools/perf/arch causes portability issues/opaqueness and LTO
> > issues due to the use of weak symbols. Move the adding of LR to the
> > sample_user_regs into arm64-frame-pointer-unwind-support.c conditional
> > on EM_HOST == EM_AARCH64 (false on all non-ARM64 builds). This also
> > better encapsulates the use of the sampled registers by
> > get_leaf_frame_caller_aarch64 and the set up by the new
> > add_leaf_frame_caller_opts_aarch64, exposing opportunities for
> > possibly sampling PC and SP to help the unwinder.
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
