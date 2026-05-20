Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4036A35F;
	Wed, 20 May 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308887; cv=none; b=eIs+XS46g9Wv7DOriKZp+hvNh9Fvi/mA7O1qjqAxMcNxV1f7FoYN7Wa/aDqC/HuzhGHZ6d0Y4W5/575fipReZgyRjpezjw9B2Vhikxqf0FtFUJ/CLr/EGfe64tb54b4tl3EqA0JMQxa8guBmsKghvp8/kLeQl8LH28CWI64lCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308887; c=relaxed/simple;
	bh=eMI9IWXEfQQ7GV6t/Psl9Uwh7YK6vo+ks6EYFJ1MbCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E09Nw+uk7XxpAVxR5QbBzEjAAd+CWtWV4OVSczDASDLLQ7nHB8UM49LcLinTI3B/KPtcrEIwJHihN7TUHUg5rDetUARK/f9gsJRoGEYnFB1FG02sM1enowP2DCXwJ1lGD8Cj2ccio6b53IErMZ/w/BTOqOPz2RCjLU+ZIfQlWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYMi/seK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYMi/seK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA91F00A3A;
	Wed, 20 May 2026 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308886;
	bh=MEORKWFCTffhnnk334C+E8UsQuSBrEHXKXve7+xW+Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bYMi/seK5NeLodb52PVr/GXLtaN8YXL6Ai5vPY4l504ZJWcnjdZMJLQE001u/qfPJ
	 6yqKp2pRyiP87oXRaGN4FXZWqWJ8HnCakPLvUQTE8PsgB3p1eVuo2D+unYse/krsfO
	 WwOi+J43meFHqPF0zeH7t8HWRBx9EdVKetX3Qi7NpyKRB2D41HdKs1bN1++CRV6YiV
	 gwv9dV6oi7W56kRpYZMoQNwtscT/Cq8oTMKQTOPwLFGKvZ3wGn3a9GTyE355zTf5pB
	 YqBiqMUcQWl83zDdBzeohLDG337i5URRx9TNsdtZILLz03C5NMKgXpSn7oApfGUrSk
	 SNxjiVAOotDHQ==
Date: Wed, 20 May 2026 13:28:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, 9erthalion6@gmail.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com,
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
Subject: Re: [PATCH v8 0/2] perf tests: Add uncore and x86 topdown event
 sorting tests
Message-ID: <ag4ZUv4EtGIG0jmS@google.com>
References: <20260518043140.2522141-1-irogers@google.com>
 <20260518062904.2591616-1-irogers@google.com>
 <CAP-5=fVQ_t-kd0ZcN-GO32-SsRkO2q3QYRU76TKYYG6pqYSs1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVQ_t-kd0ZcN-GO32-SsRkO2q3QYRU76TKYYG6pqYSs1w@mail.gmail.com>

On Wed, May 20, 2026 at 08:31:31AM -0700, Ian Rogers wrote:
> On Sun, May 17, 2026 at 11:29 PM Ian Rogers <irogers@google.com> wrote:
> >
> > A patch thread changing event sorting highlighted a lack of testing
> > for the more complicated uncore and x86 perf metric event sorting:
> > https://lore.kernel.org/linux-perf-users/CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com/
> 
> Purely test changes with green analysis from Sashiko:
> https://sashiko.dev/#/patchset/20260518062904.2591616-1-irogers%40google.com
> It would be nice to get help landing this.

On my AMD machine, it looks good now.

  $ sudo tools/perf/perf test -v sorting
    6: Uncore event sorting                                            : Ok
   76.2: topdown sorting                                               : Ok

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

