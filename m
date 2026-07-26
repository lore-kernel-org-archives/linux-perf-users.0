Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776AF3093CF;
	Sun, 26 Jul 2026 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785043438; cv=none; b=BGjSTb3nqRhd+DzrlwjVRHe5ZbEpE02NS0zH1mIrWbY+pBhTKR36MutjaNRtZ768bv0UHMW6Mft9X6vOFYwAQF7qSdbPkL0yadvGayTuG8Mv7DWV5+Z9DkPbdzczqZQo8hz05XO38QGt2PfNqlbaiI8NElOSyEhahSMzVc/BfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785043438; c=relaxed/simple;
	bh=FBBt3xdcrkp6b3gPO1JuvIhgrGVl6t5Zw+h01W0T+gQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AtxHgAfnjZ3mVL8unwL1RTIkhsR48QIdX335hYnoxowRWr7+RbOW03APHvoK+skNK+MSWTEEzSbK2JKNWvZ2QftPO0JURdnwsVKy32PJyw/gflsv7TLBP73YGouaqBT882KszpocPw+uRW+D0JIyLkcjDL98VIyLbuDZJ3/GgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHy8L6Sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHy8L6Sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE1E1F00A3F;
	Sun, 26 Jul 2026 05:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785043437;
	bh=yef5P7IaoTQzr8pJAmjfQwzd9o2YTYweIRZ+/1uRSOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mHy8L6SlWI3a7IzFAaeW8rxcWT7AHkeoEpz3LWxxq4smq5Gpq9gwd9XV836sLEDbz
	 WyYwmnM4pfS7zQxKy2kzGyH7O0C+1c3d9yJJNsoHYcy/q6s2mUoW4+eQga2azeR3n4
	 u11OgNY+D51I5rHiCNOdw2+2QUIfaW4fQX05LN1x0p0fK/iNyCmHVZJY+9iR7khAXS
	 lxCtwbg1Z32Kf5G0GScytLvr+dujI5kDvJPaBKYpxmsul7v1kLsw7dvmyYyIEubJFo
	 fDvvJTS3KpFXah6Sw60QDH+dJKnK07KEBuXYFi6KkFJOYkfidUGH8fGQeYcvQeeqDo
	 YeS+3brALH8CA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, 
 chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260722155050.503516-1-atomlin@atomlin.com>
References: <20260722155050.503516-1-atomlin@atomlin.com>
Subject: Re: [PATCH v4 0/2] perf trace: Correct cpumask formatting and add
 --bitmask-list
Message-Id: <178504343680.1075259.11521383454860356072.b4-ty@kernel.org>
Date: Sat, 25 Jul 2026 22:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Jul 2026 11:50:47 -0400, Aaron Tomlin wrote:
> This series corrects cpumask formatting inside 'perf trace' and introduces
> a new command-line option to display these masks as human-readable CPU
> lists.
> 
> Currently, when parsing tracepoints containing 'cpumask_t' fields (which
> are represented as dynamic non-array fields in libtraceevent), 'perf trace'
> incorrectly interprets and prints the raw length and offset descriptor as a
> decimal integer (i.e., "cpumask: 524320") rather than formatting the actual
> mask data.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


