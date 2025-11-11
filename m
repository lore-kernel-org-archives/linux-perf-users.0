Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1772F6582;
	Tue, 11 Nov 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881788; cv=none; b=psSGXeMC99yelz6104jPBErU83zcpEu2xHwJW1MVd6wJF+vRR+9TClLuhi5maDgbBFU6qnXOx/63clhN/YWsUg7Psg4d6EkdzK4SF1H5DGBkR/3EmAz0IlR3kiykcNfXpnibWXNsFoiRK8MGF/3dRj4z6JTM0dB4Vlx+C0xai08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881788; c=relaxed/simple;
	bh=jSit3MaHvxBxOXQtbkDeF8hJwH2XgApqGLO5VPCYbO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BbWPqN+0GbA9fnweV/FWU0NxRlPfKRuDS99kBKhLiaqbjuCVNfMvdAHAZ4cedOG0rt60GBrObUzpH2WPGoGBGeNQE9OY61fKZ1bFvQY6HHV0rurMkKxXKlqVhyrQIceIUOUQlOA5+NwPx9N6r3fNJXHk9nJ2hn3w4+4u5GZSsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/kbXBHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/kbXBHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE30CC4CEF7;
	Tue, 11 Nov 2025 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762881788;
	bh=jSit3MaHvxBxOXQtbkDeF8hJwH2XgApqGLO5VPCYbO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t/kbXBHnne7AxjEaWVBGBUWZ2aTMnR364xmA2Jku1kkhr0yIE/G2rqUcnLeLXw4mh
	 qh6L+2i3zTtkcsRO/2YyupssU0QhzR+ys1UNQ42D9xnEP7dA2/KXdb8ksDLXF4bDC1
	 hvac64Uf9aGyMfG3+fIeFgGB1r8cr15igU8PEjmq2FuvKnex7Kgz49eFFd03/ArsL/
	 C86fIiEEcYdSIhH0DX2xqEd2P6vuxNo4l6pX+Ff8jZlWtkE4eCFxVc/idu7vDXO3e1
	 qouYSeVoUyAY2G+DY8MjihFntsh+43mCKkxgR/DOtWgeaAYIqe0IQD3buli4JDHmmG
	 QK9qRW2CwuAnw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 song@kernel.org, thomas.falcon@intel.com, kan.liang@linux.intel.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251111054415.3694140-1-nichen@iscas.ac.cn>
References: <20251111054415.3694140-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] perf symbol: Remove unneeded semicolon
Message-Id: <176288178672.1455271.12825828031055352324.b4-ty@kernel.org>
Date: Tue, 11 Nov 2025 09:23:06 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Nov 2025 13:44:15 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


