Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC528DF29;
	Wed, 28 May 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454203; cv=none; b=f7WYOXbRAKNRN2AiN30xxqP3hn0I5TXcRNTKZ49BeiW7sOhiAy+RcmJxBq258ZSCeXLqqroDTIAteF2iWpruMfPISznx0UE2fblBG5yxX2cJFFzxBL7hhKTKxZNQLc1iPC/mtIacWV3UaRH6bN6rsslUE7X1T99aZFdCoKpbSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454203; c=relaxed/simple;
	bh=CIwIRMFWWPspYFOu0BAz//9Xigosv8kDtL+WE9KyOl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfz8dRp4bj3+FZ+WjRmhB7F9B8FdFxLQEwYFzWrUC1BA5xzBkUSOp+kAxd9/ujHXKhOiprjWiMOc/9CHPwbhscY4MgkF68uB30iJ2ey3a4+v/WqB/p2WmqEdh4QgHmoq4O+OXaVP+QSDhix6okZSP5A+jdVbGzAwi1iw1J8M/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS+iMhJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS+iMhJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E524DC4CEE3;
	Wed, 28 May 2025 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748454202;
	bh=CIwIRMFWWPspYFOu0BAz//9Xigosv8kDtL+WE9KyOl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CS+iMhJwT/6lflEALZmsRKey2NAtkT/8TgnMmSfBwJwzgm0FihTDdFdzaDfKhS1DC
	 RHYcZXFzX17fA/uvh6KZJENrkgRaNZbDbQcOW4LY6oAPRoRGX7HYheB9FJ0xrtwQSj
	 i9fdEFquZZ23RoexgOlXfh/zc+o0BHmfT9EFHAvycsJ/KHEI8WC9LraOdQH0b28cDV
	 U/PD2JvQLqxgwgip/sdF2/P2/TNXm/YdwHBBy59146ZSRdnT5hoXkPSR/UfBy3XRn6
	 eC/wjFFnttEzrMUJe/Qg5q+mS4eaYxW+yozK4m4CJamISFdp2jGgHyfqS4eNqvU/q+
	 TMLU1kCUD3SfA==
Date: Wed, 28 May 2025 14:43:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf mem: Describe overhead calculation in brief
Message-ID: <aDdLNw2f9aN5XPtp@x1>
References: <20250523222157.1259998-1-namhyung@kernel.org>
 <20250527101246.GG2566836@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527101246.GG2566836@e132581.arm.com>

On Tue, May 27, 2025 at 11:12:46AM +0100, Leo Yan wrote:
> On Fri, May 23, 2025 at 03:21:55PM -0700, Namhyung Kim wrote:
> > From: Ravi Bangoria <ravi.bangoria@amd.com>
> > 
> > Unlike perf-report which uses sample period for overhead calculation,
> > perf-mem overhead is calculated using sample weight. Describe perf-mem
> > overhead calculation method in it's man page.
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> For whole series:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo
