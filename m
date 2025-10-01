Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFEB12CD8B;
	Wed,  1 Oct 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343562; cv=none; b=Sc58nzAzTgl9L5VrSqhcQDlsAOsMAM89u+lVnimMo/0OhnfYeYO0hfdV3Zv9+seAawDkwoeJWSU5SNCcr71vXNczJpCY+NxtIPlLrpeLZCdUacQaff99FQ2rKmJC4x4lkp0Yk823k/S+0dj2CUJex2kmQN/6ouVBHdrXx3dp5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343562; c=relaxed/simple;
	bh=BEURVzfZqEzoeF1kIh6pm+16i2eQu0KW7jPOXQl2bnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf/rohMJ4eXDJWXRHyTve7wPORWeYYMQOUMwUfrDL8PIEqpysf/22oy1CNW9c0SmN40dKemTJRjPUbiryU6i6vbnG6VlUdRHIgNpidMtT6dA3cdcfLroRXlgFwoYFUNcmwsGasFcKQTWDRT/++4Uy/JUEIH2lZP1pzqoW0glC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5hcAwmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5hcAwmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177D8C4CEF1;
	Wed,  1 Oct 2025 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759343561;
	bh=BEURVzfZqEzoeF1kIh6pm+16i2eQu0KW7jPOXQl2bnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5hcAwmrbLXYhz/8vrMruJu7uKUOOrHF98iMZLqa16GLIyz3s7BQaA2UT2iFNFESq
	 QYdXDjCDtB6LYNzFDN1S5yIZwyyIoxYYXywWN7tuhOMBbXDt6TVmMnSfynlg7CVGIy
	 NBT10vmkTUQI7iOr76fb31dZWco4SXGwl+lnVbALAMdd8paR5MHMcqOdTsQVbKu2Zz
	 QtWHODMJEy+tLePqDzvdAHGrFVrB2Abl6pa3FfFtivOr9h5N0ypbqb6xdPTCkmO8NP
	 zWtMoWqKtBtUusxi2YuYoPOAn90mXARHBIEWE8ePDN3uYlDTkaD0A+v1+LGkbYKidI
	 wG1iUp3QSQUow==
Date: Wed, 1 Oct 2025 15:32:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>, German Gomez <german.gomez@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 0/3] perf test: Extend branch stack sampling test for
 arm64 BRBE
Message-ID: <aN1zxi0paPUMgrkk@x1>
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
 <CAP-5=fXdFQCgeF5DRH=-cUErz2opU98H6u1cTTO3ZPJ7SMQfMw@mail.gmail.com>
 <6baf0f01-a333-4bca-b39d-d01f8624e170@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6baf0f01-a333-4bca-b39d-d01f8624e170@linaro.org>

On Wed, Oct 01, 2025 at 02:49:08PM +0100, James Clark wrote:
> On 18/08/2025 10:38 pm, Ian Rogers wrote:
> > On Wed, Aug 13, 2025 at 6:39 AM James Clark <james.clark@linaro.org> wrote:
> > > Refactor and add some extra tests for all platforms which were useful
> > > when developing and testing the BRBE (Branch Buffer Extension) driver
> > > [1]. Then lastly extend the test for new features which are BRBE
> > > specific.
> > > Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.

> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58074a0fce66
> > > [2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms

> > > Signed-off-by: James Clark <james.clark@linaro.org>

> > Reviewed-by: Ian Rogers <irogers@google.com>

> Hi Arnaldo,
> 
> If you have a chance can you take this one please. It still applies cleanly
> to perf-tools-next.

Thanks, applied to perf-tools-next,

- Arnaldo
