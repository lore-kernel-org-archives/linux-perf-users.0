Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E403A63F6;
	Tue, 20 Jan 2026 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768953055; cv=none; b=dKStB+IpMkslB5zsDRmfn5a6zoRggmzlyD0JRyyOv9tCgH0/HXn5BMyBv6KcjQmSHt7vT4oXtRD/rWL/eC8Zstf3zBObHJ0dgOLVkUwcdkpP3FQU8uIhnOBFLrd2PCeIk3RqTqRpslfmJoD/BZSgAOF9Sz8IXUEtUXABoluZ5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768953055; c=relaxed/simple;
	bh=GUvGdKRyng8RXiP56nVTziFlcpi8vdBZO3nuPpbx7eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssq5r1YNzL1XNdwzLdymAwuK4ks/mF1LTVcig7nD+OLsOtRCwZCKMKWqh+OsS9nM6kEq7QqvCTsL9QblF3kPh5MpPFvluWdPTEo/ActlQ66am2F63gJPqCu4amFqA819cghMfMShNh6gX7vbiWWzvO78WAjEkFiaD2j5LIBCeQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOa3fXkr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOa3fXkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636B5C16AAE;
	Tue, 20 Jan 2026 23:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768953054;
	bh=GUvGdKRyng8RXiP56nVTziFlcpi8vdBZO3nuPpbx7eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOa3fXkrMwbVuKba1RWhR1YvUrAnW2YcYEUdsgrmnt/1ISfcJq4gjBKhqvuYXbInl
	 kmnGjRm715iewDGw30mTz2ZSQBGUegswQ+JNODNKKF4rHPNQ7hISTPa6/tPMyOlSGB
	 pSfzVfZByzIrk3fH3KJdWAAqe/wQqCEvnBCttAY3WpTygk5QoxygOz5SldpgTJstCi
	 G2IZZ/3k8nqfA7pI1hsrtBhJ6jjrie3p4XSDSBs0mK8ql1Ylaclwo0wgmSdquDwhCv
	 NQ6xfhV5lz9opLOBV5k4fXPK48yOq14J4cj8GP1tmjd4mYSJ7RSzbOrSBRUc+Me1uj
	 QyauI0oyba9gQ==
Date: Tue, 20 Jan 2026 20:50:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/4] Fixes for gcc 16.0.1
Message-ID: <aXAU20NpBGRVOfee@x1>
References: <20260120220900.366451-1-acme@kernel.org>
 <CAP-5=fXK-owoydNf0_AYFhNPnxAgoy5G9smQ6+LtbrUh6W2wDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXK-owoydNf0_AYFhNPnxAgoy5G9smQ6+LtbrUh6W2wDQ@mail.gmail.com>

On Tue, Jan 20, 2026 at 03:42:42PM -0800, Ian Rogers wrote:
> On Tue, Jan 20, 2026 at 2:11 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Hi,
> >
> >         A bunch of fixes for recent gcc versions,
> >
> > - Arnaldo
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> These look like the least bad resolutions to the new warnings, thanks!

Thanks!

- Arnaldo

> Ian
