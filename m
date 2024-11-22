Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F951D3564;
	Fri, 22 Nov 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313871; cv=none; b=u0gkYNr6nhu6/XrN3kMzHhl6hJr6F2vh0OT9clcVNMb6LCKW9B3zB+9SDBVtJ/3L6h4Si/I0P7iSIQV5241Z51HP/dn+aSQxAvQF2hKGkM6/V3lnpBjGSOBPdHzJT5ndI67Y/vqVFo1KjhpE7VS+ZyR2ejTZRfzydhnhS5NjoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313871; c=relaxed/simple;
	bh=bv1t9l1QP1Q0Ovtwrd02+D1FwP1+lyZuV7v48r0XJ0s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WzwmhXiE+eBe7YWHS4+ljHExU5C6mBDcnFp3ZXakkqYiI50pMWv/sUmdvK9rq/SMx2iILSVRKkIyB7BbtWPyDvRDeVLZ1R6EInj5XHVVkBvMBVsm3PB8KVF83sYQ8V2t+2ha8E2WVARBy8nroxbd4NSHQsvsnUgd2Dkl6d9vIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuS760mA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuS760mA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1ECC4CECE;
	Fri, 22 Nov 2024 22:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732313871;
	bh=bv1t9l1QP1Q0Ovtwrd02+D1FwP1+lyZuV7v48r0XJ0s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZuS760mAS8DzpHmgktVnCPx5ylyLLmw9PTjmeTyDsvkT7hzmfmgtGrgOpLcQkuXm9
	 8jiEv2TkbnF996R5xW5NL8L12JvtkTKNjCRFlw7KS0FMnXz6XwkUgbhiKQViP6ig02
	 NglgfQZlSgdKvAZUvCUlyVECIoDDXqzMBrkd4CRSea1fgWP3TbfJuU1Ocvav/aXmRW
	 Iu7IZUMAQEisFm+2VAuWvHwkcp+SKGYIe0RfFho0BYrTulNKb3BYfN0HlYPP3IAHwI
	 2h8+bj4rBKwCWQYRWBqigOth7VZKivlXcwUj+Cl0vyDJo8ex87b4vFgThmvsWlH21s
	 GDKkyY/1puKgA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241121000955.536930-1-irogers@google.com>
References: <20241121000955.536930-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
Message-Id: <173231387113.85365.5801712506844120208.b4-ty@kernel.org>
Date: Fri, 22 Nov 2024 14:17:51 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 20 Nov 2024 16:09:55 -0800, Ian Rogers wrote:

> Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
> address issue with hwmon_pmu__config_terms needing to load events - a
> load bearing assert fired. Also fix missing list deletion when putting
> the hwmon test PMU and lower some debug warnings to make the hwmon PMU
> less spammy in verbose mode.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

