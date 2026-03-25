Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B867303A37;
	Wed, 25 Mar 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422269; cv=none; b=HK1UhRuJaoJdz5zDCkAUnf2YtEtI2lhlwvmxXb6zU3I0sEI4Op7yUUmMr+JDPwyV5Px73CWRqhlP67Yn84rjVXZLqsmU+J+v7qu8mw5wCFZJ4iIwFarwYsQvNUlwkv83TAUggV0Vn+qynCiiyll+iyXnkQxu5QWlzu03cz/OCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422269; c=relaxed/simple;
	bh=K+uIfD/5MwJpE0PF60639QV5WOFKoqnxkj2F4lLRo0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eENQHznrGELWVKUJOAtBKpzhKeBgb9eDhNinZadpmmqhqAe5aydl7s1WYcZlaTQgIMbu/QSrFYaB0oHpEX2O4KUeHaaYZyBINzI+X6ML0qhJAwXK56H7YpybPcog7aKGN+QW668SYE6LM2DONIL1ftkyV0XMEx8EqtKq3+ilWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGdu37mL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGdu37mL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84157C4CEF7;
	Wed, 25 Mar 2026 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774422268;
	bh=K+uIfD/5MwJpE0PF60639QV5WOFKoqnxkj2F4lLRo0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGdu37mLDQkFX/6ZQPKV+mFilg5XnRLWNtaVm2HAsTtqIY0AAYrQyyWC0CCnI7NSe
	 szsdHkh3968tIyT5VmexHAY6WK3qDosbcSB3nOqRj0fwMUY/u/F0jOJ4s1aC6P1tAV
	 vuUviqpJA/c1QCCEONmBrzfDkYwBnN50t3dMT20h2uv7T34Hdt7dx6hKrzgtzVrtlg
	 wej29u32JTerQXXlJfbxadxYthXLSwxcJmR0q6wV7wOfRu/b+H7Wx+Qg7xEVxVIRlY
	 9jLfG26OdDNM/HrUp8y6wYwmbggmamJhhA5UvhfpAhYgcPKQ9f0tIs5VDHRigZ/p6G
	 my24K+gr/rgXA==
Date: Wed, 25 Mar 2026 00:04:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org
Subject: Re: [RFC PATCH v1] perf test: Fix perf stat --bpf-counters on hybrid
 machines
Message-ID: <acOI-3Rtjys7JPyl@google.com>
References: <CAP-5=fW5Cx-a0hm_PKNLDSmo=L0xu=LizKiAPyJF1YtH-coFdg@mail.gmail.com>
 <20260323202409.194123-1-irogers@google.com>
 <CAP-5=fXwDgZ-+JT2c8y3sJLURGAz1njduLZRxTJ548xbW+H9Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXwDgZ-+JT2c8y3sJLURGAz1njduLZRxTJ548xbW+H9Jg@mail.gmail.com>

On Mon, Mar 23, 2026 at 01:26:11PM -0700, Ian Rogers wrote:
> On Mon, Mar 23, 2026 at 1:24 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Events on hardware PMUs may open on >1 hardware PMU on hybrid
> > machines. Unfortunately multiplexing introduces a scaling issue as
> > reported in:
> > https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
> >
> > Switch to using task-clock which as a software event runs on all CPUs
> > and has a single PMU.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> With hindsight, maybe the better thing to do is Namhyung's patch plus
> the "--no-scale" option to `perf stat` to sidestep the scaling issue.
> It'd be great to make this test not "(exclusive)", it shouldn't be
> necessary. You can test for flakiness with the '-r' option to `perf
> test` which takes a repeat count.

I think your fix is simpler and better. :)

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
