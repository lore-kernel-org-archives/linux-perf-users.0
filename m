Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E586261B75;
	Tue,  2 Sep 2025 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841678; cv=none; b=ueztZlFFlbow5AcdBdWT1qMWqg1lkZiF9GlghifXCSGmEJnK9meL2WskSVGhUbT9rTSSgWEDkPwWm98TDRnp9XbGbFJxhR65BDKE50iFGp9aCJyvsWra70U83bcPPjuzzbJHg3e7ORS35iNWwF7S0hG3djeP/sTPkQtO48Iy1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841678; c=relaxed/simple;
	bh=AVJqsMoqyaKf25NmmQszc8ljG86h2048p4UE177s1tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVwESvL11eIa8ysuqkxlpQ2by0Yo0vDqTx2xw7R5fl3joZ1hkxohDNIRhon8JRkECnpFuHkfkF1jdPn3DVT4X1DJ9NP/NhRGazKcH/I6YkFJyGNGDTNu3u1ZZOKDMa2Gx7xJlOLRxBYbRwo3dA0pa1oVJYa8E/nWzcUSsFpv/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZk9xWhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZk9xWhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A3AC4CEED;
	Tue,  2 Sep 2025 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756841677;
	bh=AVJqsMoqyaKf25NmmQszc8ljG86h2048p4UE177s1tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZk9xWhKktLD4SMKR2oaNHgT4a0fJnJeZpKsKY5j8lNQsbV1VTiSVflPuOpt0e7QG
	 QuR7ursxVfJNH0eIQoVHdIUPeHDu1UqehjWkovwgRtpoHMnAxRLcGpi4i3dV6/ymLG
	 Z8JxUufNwGk8ytD/zWMS5b2HklTvlx2ltGkNasl5qzresD7o9aR+9+jowIQq6joMZm
	 0gxxw0tAQPTL+BaTos2EunHUeS84JCmkPgkchSF6cNkQmewDPKc5zfd19N3DBymjYA
	 6n/2UhjHHG2/wKviPNQaVQjyxJZrwjy9KUV6s2eOTGp20MOxijH0lysiLpA6SyNitq
	 OmRj6ur/5ImcQ==
Date: Tue, 2 Sep 2025 16:34:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Blake Jones <blakejones@google.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Various fixes around undefined behavior
Message-ID: <aLdGyqmRIqfaRj0-@x1>
References: <20250821163820.1132977-1-irogers@google.com>
 <8b7351d2-6a45-4fef-a149-ae511b52f552@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7351d2-6a45-4fef-a149-ae511b52f552@linaro.org>

On Tue, Aug 26, 2025 at 09:38:22AM +0100, James Clark wrote:
> On 21/08/2025 5:38 pm, Ian Rogers wrote:
> > Fix various undefined behavior issues, improve tests to make them
> > easier to diagnose and add assertions so that problems don't recur.
 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
