Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198A218D69;
	Tue, 12 Nov 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439107; cv=none; b=B1kJ/PFryPrC+ytH4MJut/QU/g0ZVhcH8mKLy9Htj8w2T1ZIYNoB+U8dTeMLlbf1hzT+ExKFHeZgXuqTjdEQB/7x/PGyh0BQHNSFeYFOFRceuz3pbQUDChbH2aBQ1BRJZDQc0a4DCdCu6Qh1p+0jffwxiEMiZJD9BAw+3+Zwgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439107; c=relaxed/simple;
	bh=vCxWV/prWRyHLln5qk5UEhSPTS3TVlqQmzf7akzmtLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwoLnAgsfzqVYoTKdxaILzLeG1hAg/iddVc46Jm2HlbTJJwiUAWtuuUXVcMiZGuX6cRuWK2TUR0QnCAZemfSiyggPkD7OMjN/Xu9mgSEaI5SfnO2w2p5QNHuQUeaqPze91QP1CVzDmi53BBgG4pPN/hqfJxDL9WwmlBJA8tS4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teC4xAr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teC4xAr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF137C4AF09;
	Tue, 12 Nov 2024 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439106;
	bh=vCxWV/prWRyHLln5qk5UEhSPTS3TVlqQmzf7akzmtLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teC4xAr3oSHEXG9bRduZcP+P+LnDV1w8rt5DlcuMwGm7CHIL8Q3Mg0IbQCf/kl+vg
	 cezYM3ToHobixiQeIawnVovurFi6ef2sKOCop0VHE2GT76i7NyQWfXwxKPS9Bcq7Qh
	 t0lggBpZsEqAwldWyVO4n5Sk/cnR/ovH2EY77BViNkNUYjyEckjEuFP3E0U3Qsd2DT
	 v+q109WlVWDL6sayGURlQFjS4JCyIz4gC6ApLGi8vWQoVof0qM6kcohVG8lEOwJ7qu
	 NmN43lkKQmOrBANqEiyx+jcOxtbyvbkooFAN50pZm7Lc8T0J5B2PUuDqRLzYriZJ5w
	 3xpFS5umQsXgQ==
Date: Tue, 12 Nov 2024 16:18:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com,
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <ZzOp_b3Wm_kM7b0V@x1>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <ZzOg3Xlq2jsG85XQ@x1>
 <ZzOpvzN-OTLZPyFh@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzOpvzN-OTLZPyFh@x1>

On Tue, Nov 12, 2024 at 04:17:24PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 12, 2024 at 03:39:25PM -0300, Arnaldo Carvalho de Melo wrote:
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> ⬢ [acme@toolbox perf-tools-next]$
> 
> I squashed the patch below and I'm trying to apply the other patches to do some
> minimal testing on the feature itself, but the organization of the
> patches needs some work.

Fails a few patches later, trying to fix it.

- Arnaldo
