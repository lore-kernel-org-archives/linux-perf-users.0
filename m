Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C1D2F5
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907479; cv=none; b=esOJjT1euosc54sAQiKS36ecSXxnqFZfK5V+hTkGGUP2afy2izA1SbBKvuKKV0SzENaj+55ft0V9mgksK0MYXcOlIrGTE8hnB88ah3aA1JGPTV6Qc9EQsXqckgUqOFS8F98zhGI3n2O9oziJxYFRcrEhN66s4UjOwJ+EPc9V6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907479; c=relaxed/simple;
	bh=mCaCBKXQXDvefUuRUBoqaNyn0LR05PMoD2PbPfbScME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcXg2e6GsUYTdc5rf0TqbNX4b7vHDCF/oIL9S97Bd1ky0UHHP8hhl6xVagtEr18m3iWCAH8fjBVPnJwjhq9kBpVvHgHiphSuvaa3PJdk8Z+RYDYzRzowB5NUXTPnmCIDruST9yK32LoSKn3CrgZpTnVOm6duVS8wZJf0loKM0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgZ9MaiE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgZ9MaiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2418AC433F1;
	Fri,  2 Feb 2024 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907479;
	bh=mCaCBKXQXDvefUuRUBoqaNyn0LR05PMoD2PbPfbScME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pgZ9MaiEQIGx1p60tzB15tcSMLe/4V2l3A4njukbb1wlF9XhQBQdAZqwofaG84NfD
	 tZzO/kCQ58HNE7J0y+CgSCLcc8khLYuyaHHSNnKp1NsY9FOmXMAdjnfKRloDJhH9Jg
	 JJNWxtgtt6PPV10tBLQY8y8dqBAY2aIH88YfbqWeGGbOWhamJ5PfVX8itfLstIISC8
	 hebugzCprXjU0O+Rq/xpYurECumAdwzZqE7fS1L3JDve7pjSI7j4mC/2h7tZ8TsZCX
	 93evpbZ4bTEfL9ObrrTCFmRPNlRT25R1lYEBGxoNZPPqslYgCDGozUAQHT/WB9fvoj
	 MJ7ing151YZdw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf report: Prevent segfault with --no-parent
Date: Fri,  2 Feb 2024 12:57:58 -0800
Message-ID: <170690725032.1264496.7176979335645778887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240130185552.150578-1-ak@linux.intel.com>
References: <20240130185552.150578-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jan 2024 10:55:52 -0800, Andi Kleen wrote:
> Prevent a perf report segfault with the (non sensical) --no-parent
> option
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
