Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8516C444;
	Wed, 24 Jul 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852772; cv=none; b=A4UQN+8OTtYJY2Jt2tQ4lu9u8A23LzZ2F0rmSeHgKGOB+MxZ4mg/0gOrYZrXI+vPHnMsUvR2r1d9IHRT4AIGyNuBMFQVjCzCKO4NioP2sJpRLunLb+3A/5XwPtuzf2b36l/dIYfXNzRCD8+Xe0VLFzgA0mtCUhsOFc8mgXrXs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852772; c=relaxed/simple;
	bh=tYTQl6qwF29qdDqIH8Smburok5zHIk6Lga+b9KE0wpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsMkR6GP8KAh9ssNYa91bCPtUvI+BIL831yXRf2E/w6qPIZoseZ74ZTlDqgSqCNn1FXjAOB9Ir5C6YgUQDKBu+Hx4wwIO01PAG/CCGcm1jmFgY+HZFJXHUW1D1MkaPEWoZ1W6Y3MqJNwW98Lr4sjwHzM7Vgon8iIdThMH1y2Jf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Gvgz0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Gvgz0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0245C32781;
	Wed, 24 Jul 2024 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852772;
	bh=tYTQl6qwF29qdDqIH8Smburok5zHIk6Lga+b9KE0wpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4Gvgz0lhqA3yuvP1R09Qnt73RbSfl3VuxvnWy6DbdolwaqpRBZuS9yB1mVLxX1Xv
	 hk/T+iKFY23uYFGxBw2VyrKML9s84sbKElNRQiS7CgxkTSJWZC49dq1wQktVMxOH04
	 d0vi96aU9vYUpyTs6xBM/X2DPprX4usJAp6vzNOuUSTapgaFFyCxVnhmtGxlFk0rOr
	 y2oBCXcasbOvWL38arRFVYe8X5kXaeKFFfEhqBi+j5OTDJKozcNi5lXIbsvYT4n1Ul
	 pxOKl8aLdLAvcX0Y4MR3++A+tw+o7hXkFx1RvRQPe9oeIS1oc/SrQFZt3GgjXkuQ1L
	 UNPqtzzHUpgkQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Yunseong Kim <yskelg@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dso: Fix build when libunwind is enabled
Date: Wed, 24 Jul 2024 13:26:10 -0700
Message-ID: <172185273054.1508886.14969248999578638389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240715094715.3914813-1-james.clark@linaro.org>
References: <20240715094715.3914813-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jul 2024 10:47:13 +0100, James Clark wrote:

> Now that symsrc_filename is always accessed through an accessor, we also
> need a free() function for it to avoid the following compilation error:
> 
>   util/unwind-libunwind-local.c:416:12: error: lvalue required as unary
>     ‘&’ operand
>   416 |      zfree(&dso__symsrc_filename(dso));
> 
> [...]

Applied to perf-tools and the mainline. :)

Thanks,
Namhyung
