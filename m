Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29CBE5E
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997788; cv=none; b=I5/f6/80dIf0WYV8dfz7UFc4Ae4ICVdsdVajQDY/bbumQLNeA8keXtBABkaLBDydaxNhkZkGsJh+fKS37A/MVnJJzBcCyUJ4lO6k2pZoPlAY0Es/UTQ6SEMiYwQTHnyhFkEX/IkGSp7mQnqKNoZmSpsB9mNyX5tk3C3J6aTUjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997788; c=relaxed/simple;
	bh=rvW0IG94qSWM0dzaB2v2TlIVl8739p/t8x5WiK0pN+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfbOLezhpMCFoRei4VdaqUoDbjocXeAYDxB6sUEtULTHqNlbIifoR4XACg2su33QwZjn9iHQYrekl6gqiE94UwZX9hVaIoHFCNHUzGUm2S5bVzFjQkNk0/Nv4HX/8iVlvw01R4UojfJJL9ejKOOy1lNMLZU/x+ZLuh2DUdjEXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADWhCdBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADWhCdBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69283C4CEED;
	Tue,  8 Jul 2025 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751997788;
	bh=rvW0IG94qSWM0dzaB2v2TlIVl8739p/t8x5WiK0pN+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADWhCdBIDTjH7BgOPCT/h7In3Ynen/LYTGXsFKnGichPtEJsrNg2rs4PHUZGVEyvW
	 19MMWkHvc3+ncRgc5DglO4o6v9SuqBnu61ueidxj/bEOaKp70wJ6CsByLETTcU6vGu
	 4eFKxQEZHEizmz8Vcq5dt6kbBA1/C5ktyPkxj+oBGLx8PpK8ou1vARzlJaEkmdULRU
	 ELoFmF+x1iLq1KinnDxiMQdxCZF25X0Y/72IF+s3JgEx8skckB8kw5lZO5fHe0WLes
	 QlN3DN9mMUWevLtNKzNY+dVybhyiNQoda/PpJ4f5tICDgnUCSzqKhW7b38etSFuV1s
	 ah6pf1/fI1IvA==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3] perf: arm_spe: Relax period restriction
Date: Tue,  8 Jul 2025 19:02:58 +0100
Message-Id: <175199424407.415102.16311712812731761067.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627163028.3503122-1-leo.yan@arm.com>
References: <20250627163028.3503122-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 27 Jun 2025 17:30:28 +0100, Leo Yan wrote:
> The minimum interval specified the PMSIDR_EL1.Interval field is a
> hardware recommendation. However, this value is set by hardware designer
> before the production. It is not actual hardware limitation but tools
> currently have no way to test shorter periods.
> 
> This change relaxes the limitation by allowing any non-zero periods,
> with simplifying code with clamp_t().
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_spe: Relax period restriction
      https://git.kernel.org/will/c/ba2ff3e1b640

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
