Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22B193085;
	Tue, 10 Sep 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980150; cv=none; b=Vu+qAfcoKAi2p1fGxwcDnmyqw2k1zsssjsN2i4CIHRbJB2FM4TOej3VTwo+4TRh2c9n+1nZxwM9ScqLLQqoqql54UiPkveU3OmslmPJITCAUf52OpSVzeEui+MY7oVZaxOweVkuob4Jqd0bjFN8Y2OyUVMNekP5plCEZe2QuXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980150; c=relaxed/simple;
	bh=NHI0/d24/Wxd3gv3h5IkIPm9sADZWveCyWMLuO1n4PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2rpqVooKEPCE9VoWFW70fbxtU2BeRDRuE7zV4AVHwIp2ZMBAGv1k8R+jkUfQ/ucftre/QE42oQ6yqbMefiiT21pu7yv7rkCJmTlnxJ3N1B7cvmd/+sH2bNOdTGj2QZgiQbiWOFmzt0Xeo/2DPdnNiBoZTSUTkWNTehJ4HY6NBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoM65GYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoM65GYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96081C4CEC3;
	Tue, 10 Sep 2024 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725980150;
	bh=NHI0/d24/Wxd3gv3h5IkIPm9sADZWveCyWMLuO1n4PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoM65GYdUWa3H/4pLP3w+s3iAuKoCqdd//U3SCndS6lxfZlh8zBjonIP9SM4nbzYE
	 m8dr3KO4KjF2T7TtzUcVAyZsu5IlPk+H7oON/NsjbWB5mDW4TQruHsrlYFSyNNuXRy
	 KSqYLFqi6wmx6eu4I9PJDOzm940KvC9eZznugYGwNCIB//fB2dN/GqUQiZ9KmbSts+
	 VHFEYG2QtR7PqVjZUC7JLPmrehcZ4fh4CJAbPMHhUbBXC9BhGDKWQQched1NGOQ62p
	 4SeCTWC94gV3Rg5MdLIdas3ge7BHDfbRF3kxAU7X2ZPg9ZBFom9DS/J724s4amdp1z
	 pXO8O+7WfkHwA==
Date: Tue, 10 Sep 2024 11:55:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Casey Chen <cachen@purestorage.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf inject improvements
Message-ID: <ZuBd8qMDfGcpBi9d@x1>
References: <20240909203740.143492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909203740.143492-1-irogers@google.com>

On Mon, Sep 09, 2024 at 01:37:36PM -0700, Ian Rogers wrote:
> Fix the existing build id injection by adding sample IDs on to the
> synthesized events. This correctly orders the events and addresses
> issues such as a profiled executable being replaced during its
> execution.
> 
> Add a new --mmap2-buildid-all option that rewrites all mmap events as
> mmap2 events containing build IDs. This removes the need for build_id
> events.


Thanks, applied to perf-tools-next,

- Arnaldo
