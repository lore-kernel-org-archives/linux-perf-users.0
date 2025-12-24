Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36226F476;
	Wed, 24 Dec 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766605159; cv=none; b=CU2UiJBkeY0LinJ2I/WBJ35fcJiZil0zXLdAg/vuWYWKzAJycxniOxqkefTQ+c2yTGeIj5aXVnBC3dJu9Pc36DjjecW7Fwg5YkjwEzzSI6ElJI6Qnpgqm/s+hVdl2/dteulJxzR2Hcvp08sRqk/VnHrhBf5Ss9irf82w9CYIeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766605159; c=relaxed/simple;
	bh=SFNVJjMGA+Rw1CX7XZX/bsK0mjL7TEWtQKvqmufwgVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE2Des8JphOt0jyv6egV+fbK3DYP4/HZHoR/A2nvnaZJEO8N3lJv3NGsBAPGuJcmyEgURIti0evA4Ced2HOZYPGJsDa/pFqF1N5yvDazzpvs8WYWg64OBg/xCS1R7zpMi0AoEMDk1uLM+d52rhZH2fd8V4o8pLneP8D6ZczwjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWFhUSQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWFhUSQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E12C4CEF7;
	Wed, 24 Dec 2025 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766605158;
	bh=SFNVJjMGA+Rw1CX7XZX/bsK0mjL7TEWtQKvqmufwgVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWFhUSQVAHFYLWsFLPwpjObKqwdbeNaYbM+sKwtzlMhAXT7ohO8B4hZMYXMY1QS7A
	 HygfczNsC18Cy8J5GWq8tJEzK8EWzyH32XAHNbTYTAmyzsHnxgZEZnEDsc2ATnUDIr
	 6xxu+Y5ZMuYdRQwU7EsBuRo7RGDAcyC9PXDRrnPJUlNy9s+GFi9CvYeLkHTYqSXYQA
	 F8EyTA0CMLbBQs41yUGLw0LsRrL+IyQkZt79y0a+dxUtcEaf7jL7PEO3sd7OUxzxjB
	 nq6O0pjsO3hN0a8vdK92JzDy19ZUOwU57IY3DkOfA/sWMjQCMZn2MbR0M+uaUvtDZn
	 X38LTc4S7oiKA==
Date: Wed, 24 Dec 2025 11:39:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: acme@redhat.com, leo.yan@arm.com, james.clark@arm.com,
	irogers@google.com, mark.rutland@arm.com, jolsa@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-tegra@vger.kernel.org,
	vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com,
	ywan@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH 0/2] arm64: Support NVIDIA Olympus for Perf Arm SPE
Message-ID: <aUxBY01uNp8gnEPq@google.com>
References: <20251219231325.2742580-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219231325.2742580-1-bwicaksono@nvidia.com>

On Fri, Dec 19, 2025 at 11:13:23PM +0000, Besar Wicaksono wrote:
> This series support NVIDIA Olympus CPU in Perf Arm SPE.
> The first patch syncs the kernel header to the tools header.
> The second patch adds NVIDIA Olympus into perf's Neoverse SPE data source list.
> 
> Besar Wicaksono (2):
>   tools headers arm64: Add NVIDIA Olympus part
>   perf arm-spe: Add NVIDIA Olympus to neoverse list

Applied to perf-tools, thanks!

Best regards,
Namhyung

