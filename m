Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95AB207E19;
	Thu, 12 Dec 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987442; cv=none; b=R0XdENUp2CGfuohW2GNMH2who6rSxxiRh0DK+ryo4OLFez1p7wewyectB7iXXtl8eaAoowW/KJwwy0RVfuQFdGuJErpJyiQ8KGvZWA5vHIm/YRWhBJWLK2GkP8aDvhr6LOR4e2bHlqHXyfg1yN2fe7iNedC7uOMzdUCvB0+xfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987442; c=relaxed/simple;
	bh=WJbcliJGy8BdGmWSV8PbRvg8r0iO4sMcBSAG1ZnG2Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmEVoq4n+b+ZP8ftGdIkJjFfM+cemeei8czslv/iesCxXo4q6N64xS7NtGarlrXepBnz62ezDfCxa8KSnidy6Gf9ECBZwkJ7Uxt1A3rcimtx4vTLY5dLzZ6WcQAywo1kj/7/ZJ6rF7c0f8ePdjLaf0ZHKw50570baPWpsUdD/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYZwUaC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYZwUaC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F98C4CECE;
	Thu, 12 Dec 2024 07:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733987442;
	bh=WJbcliJGy8BdGmWSV8PbRvg8r0iO4sMcBSAG1ZnG2Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYZwUaC0AVpu3YSaOv4TRVl+F+wejPFB9z+/Ea0Xy4PKeMFy/pT0Rz3OWzDJgJlIE
	 7nmwk1nhrcJah9ELNBBppJEuj9I99YADFI5xTitqEuB6DDWA1SYxVy10Zz8r57cn11
	 8kjLVK/WAJqKLRIcBTAB1zxPsBJ2k6h7/b1o5UlFYF43OsHySimzHUD59SP2ctaHTn
	 zhMF2tLj8Zxkl9oi6UnLBVJ1rUXsY1j7rT1QIXLgevM/kMJKSsgZ52mtQXZ+PRc0o5
	 HB7gM8p9p2bH6hg/35ZkAXTUFyMUivyceqQNVd1xweDsq5DrNVYJDVs38wQcXGX1N9
	 gEqKUxfIwDRRA==
Date: Wed, 11 Dec 2024 23:10:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>, thomas.falcon@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid
 platform
Message-ID: <Z1qMcJq4qwN3EZz2@google.com>
References: <20241114160450.295844-1-james.clark@linaro.org>
 <20241114160450.295844-2-james.clark@linaro.org>
 <Z1hHc-Q-TKgagORu@x1>
 <eb8301ec-50af-4414-89e7-5d49585bda47@linaro.org>
 <Z1hLEQwYE3ymbrIr@x1>
 <Z1iEDRT-44aynAR3@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1iEDRT-44aynAR3@google.com>

On Tue, Dec 10, 2024 at 10:10:21AM -0800, Namhyung Kim wrote:
> On Tue, Dec 10, 2024 at 11:07:13AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Dec 10, 2024 at 01:56:21PM +0000, James Clark wrote:
> > > On 10/12/2024 1:51 pm, Arnaldo Carvalho de Melo wrote:
> > > > James, the second patch isn't applying to perf-tools/perf-tools.
> >  
> > > The second one applies on
> > > https://lore.kernel.org/linux-perf-users/20241113011956.402096-1-irogers@google.com/T/#m2a3587fb83e6ab2d970bae25982ae9d6c8d9e5cd
> > > because that also does an evlist__remove() which gets fixed up.
> > 
> > Right, I have to test that series on the ARM machines I have access to,
> > but there is a question from a tester that is waiting for a reply, I'll
> > see if I can reproduce that problem as well.
> > 
> > > But the first one is ok to go in on its own.
> >  
> > Agreed.
> 
> Ok, I'll pick this one to perf-tools and leave the patch 2 go into
> perf-tools-next.

Applied patch 1 to perf-tools, thanks!

Best regards,
Namhyung

