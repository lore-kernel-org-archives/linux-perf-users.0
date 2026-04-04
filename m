Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68914F112;
	Sat,  4 Apr 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261701; cv=none; b=P2Xp8Im0Qu3sdfh42ijwEvrj6T92X0Fdv6+FLRXB6h2WR32eqWhYlVfaLqupx0LydMv9SjovIq1iGgErPritg/8u5K58Y9eErl//a5YKjTtkD+qJBQydKUMng/rBNPAnBYYFRVYCsE57FJh5ZErKcv+hbtLVnk5AbpWZEmClfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261701; c=relaxed/simple;
	bh=a1cA2VuH9gx7o5zyfrOR9t8QM2OgfKxSfh7Z8o/lYKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JwME8XaMM8l8aJ9tepzmw1cYNqpG7L38FkI25KKEu/99mnyltUaWXTqzXKlUcVXS+TCZDQ85p+zdy3oOVPvVyNCTImbN+GivAc4yhXjLXXkrMhvyfzVIacFeG7gI6enzT4BVGt1H2DNLbQ+MxCYRUIkuXT62oZWTOM2iooRmSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7RJwPq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7RJwPq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F76C19423;
	Sat,  4 Apr 2026 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261701;
	bh=a1cA2VuH9gx7o5zyfrOR9t8QM2OgfKxSfh7Z8o/lYKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R7RJwPq5P7YZbwq2z+dASC1/BE9GNbHd54E6NhuIo2Oy9NGwiQjAN3FfQPV5uoReq
	 x+Fjr1SKsjk+EwJcgjIELBuqTsPl3PzOqERQoISjBoXD+ya1xbiChwBiDMN8MBvqQH
	 MX50y/oFMx+eiMPkq3l2I+HGzZ3Act8gJptF0vq8w76s8CZs9zJpOlYE1k1C4sNBL/
	 UVAx5Y1qAr6jhZwaeytwb/LhW1hQ0XRzpLbuuGv1cnbdGWql1/u4AfZPPGl4/ZZK57
	 A++JDPys0/Z+Ar3lauhGm/t7w6PWMJheLbN3Uc/eq94KO9kKMUEmesFjpHIKcKuk45
	 7UlskaI4ubvKQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 SeungJu Cheon <suunj1331@gmail.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 me@brighamcampbell.com, shuah@kernel.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
In-Reply-To: <20260402160410.425978-1-suunj1331@gmail.com>
References: <20260402160410.425978-1-suunj1331@gmail.com>
Subject: Re: [PATCH v3] perf header: Validate build_id filename length to
 prevent buffer overflow
Message-Id: <177526170118.2123878.2776545631982676157.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 17:15:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 03 Apr 2026 01:04:10 +0900, SeungJu Cheon wrote:
> The build_id parsing functions calculate a filename length from the
> event header size and read directly into a stack buffer of PATH_MAX
> bytes without bounds checking. A malformed perf.data file with a
> crafted header.size can cause the length to be negative or exceed
> PATH_MAX, resulting in a stack buffer overflow.
> 
> Add bounds checking for the filename length in both
> perf_header__read_build_ids() and the ABI quirk variant. Print a
> warning message when invalid length is detected.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


