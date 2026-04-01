Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343353B4EA2;
	Wed,  1 Apr 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080374; cv=none; b=XWa+EEtrPHbYIlXUYkFoG+V4+AeaxLhnxhMn4akscrE473rpam1pCIw5CpKHUmc2QgUP83zGIcA1jv1rm4hsugrpYUqeHkLdMPhu3zx2o1sFtw1UJB0XHITi5h6+5dAjqdVbldRaEPbiTaFZM/NziLxmwsPrw6ADpak4a2ajmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080374; c=relaxed/simple;
	bh=zsFVn9A+gsxuKivYdZi2ROuaNkJ9YDxZ3Wx+xb+ykIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qp/98mhySZgsNwBITFNOlhJXESM6DrT5lk8514CtLm21xTeepVUdB4dov6SX14+deOZyoMCzzQX732g8qZxpGIONwuMUedwi4soeIo1upiBQ2otIu5aGVNitOa9gCaOXH3s4hTVbKKoAkWgRd+qp5i+7ux6ccHZ4UqOLUXqjcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb5G8oxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb5G8oxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799ADC2BCAF;
	Wed,  1 Apr 2026 21:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080373;
	bh=zsFVn9A+gsxuKivYdZi2ROuaNkJ9YDxZ3Wx+xb+ykIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lb5G8oxumwsc7TQBiy9KaCuicSnsWPIYQ0ZwQ1HcfkIyBGBHPnL2j0swg0WqOuugu
	 dA7PrRpp81re8IEINnWN642190EpK12BU3GZfZi5w+FkYz3K/dZz+TiJ5u65YkLFUP
	 peBvaZky90go8yTNgRvT4y4l+h5DuHzJUaaGzhEhxL/BDk9UVrCC4pobKe+zEcFzct
	 uOA2hYEmHfF1Ut4G5h987Zhlb5nruc4LqpTO71wYZiJq8dueWWZEUMjKWeY/KqqqAR
	 y83waG59AhVXPCK2KHCY86NiQYitlo36gnhJKaMHkhVdiUF3D+3mTdca8RMtuE2qwL
	 QQ6IcvCeL6xgQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260331180520.4052231-1-irogers@google.com>
References: <CAP-5=fUJb+a4s45p4aL8_qf-nC3EdTxL9oey1xh6ax=1rjUr=A@mail.gmail.com>
 <20260331180520.4052231-1-irogers@google.com>
Subject: Re: [PATCH v3] perf tests task-analyzer: Write test files to
 tmpdir
Message-Id: <177508037344.42628.990676570031111864.b4-ty@kernel.org>
Date: Wed, 01 Apr 2026 14:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 31 Mar 2026 11:05:20 -0700, Ian Rogers wrote:
> Writing to the test output files in the current working directory can
> fail in various contexts such as continual test. Other tests write to
> a mktemp-ed file, make the "perf script task-analyszer tests" follow
> this convention too. Currently this isn't possible for the perf.data
> file due to a lack of perf script support, add a variable for when
> this support is available.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


