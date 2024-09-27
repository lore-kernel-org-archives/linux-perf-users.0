Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C33218B;
	Fri, 27 Sep 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456484; cv=none; b=PL82ubih3Y3k/xQbInPHIR2WPL5FcQSZ9vHJTjm05ABiss/F+6V7GzZL6nlT/pQDtzn29R69UjPbDeGp6AyUzIjX609BVG2hF+b48UxwgWlmExvj7GEiYSLjcSU6w8xhhlaUmR117H5J0J9o5Jn0khIUYpiDjDVikDm++SF5pmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456484; c=relaxed/simple;
	bh=C9O7Pg6sUk4vcHczMt4ZIiHyJ6Uj9YFut8WWW1j2yPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEArtDJsFm1Iyx8KU2DN6oztPiyFE6FpTyrSyDJoQy3Ijsn+36lZ/hm80H0NUWAQqu3zZLVE1YWOTSbcYRhUBj5PR/oBxXD8Sep5Spbv4PyePdAjU1VIuYJcZaTHGOFDo6YAqbxsft6muF6Dk5SkFM4zbOoRsm/irqc5W0bo+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6KD4BKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6KD4BKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46098C4CEC7;
	Fri, 27 Sep 2024 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727456483;
	bh=C9O7Pg6sUk4vcHczMt4ZIiHyJ6Uj9YFut8WWW1j2yPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6KD4BKrAyJk9705ckOaw04uj7htqoo98Pe+NWDT5tiV44pSSlFBa5OCv9wJMBmSQ
	 rS5+duZz3Ak0RUDafIt5sj+9lcfwyCn6Itd2A6C9aloW1wd3lmb297yc4D71ABBMPT
	 qboVakf2BLHR2sJHbaI95ABLdVVdl8D3y9RUyEwtmX/fQyWNeakPEaYYZKg68YTVo9
	 FryEzQvyG5SmiE4gnVmPj+CW+QtlLP+nWq8n3BGyo/2KVPC6GGYuXAgkIIW1q4SOrL
	 tWcm7eeuvC4IadJU0VWMoAiIkxB/B4mZbTLrHcC1BkJhCwe8HNKHx920aXATCDagxL
	 Jr0xl6eZjfEfg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: Speed up test case perf annotate basic tests
Date: Fri, 27 Sep 2024 10:01:21 -0700
Message-ID: <172745647507.249132.14579942709365708239.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240917085706.249691-1-tmricht@linux.ibm.com>
References: <20240917085706.249691-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Sep 2024 10:57:06 +0200, Thomas Richter wrote:

> perf test 70 takes a long time. One culprit is the output of command
> perf annotate. Per default enabled are
>  - demangle symbol names
>  - interleave source code with assembly code.
> Disable demangle of symbols and abort the annotation
> after the first 250 lines.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
