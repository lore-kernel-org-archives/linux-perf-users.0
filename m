Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192E215C72;
	Wed, 30 Oct 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323848; cv=none; b=rniI4JB95eCkgg5H6Oyd+Dc/6AgiYDVuzg4HCfBV1C4umqlgU1K/YJQCwStQ0HazE/E2eX0h6PRA/NoytSyl8AU+/RiIms/EypAMpZD6Kn4lli2OrTbBVi2kMf+NgOMfsDNrLejBqOTF4MBguk0lHBeX9CHQNgA+sYLMmNX4nEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323848; c=relaxed/simple;
	bh=Ez0u9KTu4Fk9iohQ1J7Ru8euvaEcmW1vF6+OLTjqlzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f1rwJF6s3Et+b1DZRzoXJOa9+gdJ/dJ/DhN2rsTtxi/ZJaDXmd4a6G5j7TGwqBxqKxN4sTf91AnGZXU2bg/x9WBG+Tu33u3LwJSzTJzbH9QuicHqsZj+fk37fnvb72YlDQGbrzsiYJvcYc6HnA4VV1IFxNIyW4Wbm0XTFbr6CzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDOByLr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDOByLr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F986C4CECE;
	Wed, 30 Oct 2024 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323847;
	bh=Ez0u9KTu4Fk9iohQ1J7Ru8euvaEcmW1vF6+OLTjqlzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lDOByLr2z55hpCBv7hg++3LKpkYVCh8mR8tK6ZfOtsZL5HCbR/Pgd1wNYS700B97i
	 I4CdcF1q/PrHA+hwiQ9t30nLymE9TBgCoxLUbd5Gfj76LPjcW1l4VhA0s7Ljoq05aa
	 XQq4c90++hHu2UM5/LqJvEr9Qu4R8dqoS3437nJpmF5ygyNWIntcjPB/EQvhoIquo3
	 XFe5OopBJ1k1gfdt83KCqh+V/iM462Rw7BWb22vXjlIJiK+qIJHUumHkIVchQfAFbR
	 6mwxt+MTMulKhGE+7caAvtfGPB1utNcVJ0IwaiwpxtikMCyJt5NVaDii7Zz3ticc43
	 /Kq0AGMi5NNuw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org, 
 irogers@google.com, james.clark@linaro.org, mike.leach@linaro.org, 
 leo.yan@linux.dev, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Graham Woodward <graham.woodward@arm.com>
Cc: nd@arm.com
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Message-Id: <173032384741.1221980.12077485873903328897.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 14:30:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 25 Oct 2024 15:30:05 +0100, Graham Woodward wrote:

> Currently the --itrace=b will only show branch-misses but this change
> allows perf to synthesize branches as well.
> 
> The change also incorporates the ability to display the target
> addresses when specifying the addr field if the instruction is a branch.
> 
> Graham Woodward (4):
>   perf arm-spe: Set sample.addr to target address for instruction sample
>   perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
>   perf arm-spe: Correctly set sample flags
>   perf arm-spe: Update --itrace help text
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

