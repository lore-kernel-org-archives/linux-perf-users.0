Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816235;
	b=tn/7/IdyFygAOSdTI0O9aRT6k4wkHV3awYcBmq5Twc87EAl6RGrPb8FmaMZuyc/x3Z0T
	 dcmCrfcTm/xJdjD+Xa5LWbp3NEDWYEwbUf2BZDqmTQ1bUnLa1nJibgegr29oX93LhlRQA
	 78gOpguA9mrR152VbO9HyMKcJRoef56KAn7aBriR4znEw5D4qRNxb6zgjpx7kA3cO483V
	 X9ZUDQawbvD8oH5tEPTffk9eCOWBA1GrbJfpi1kvV4s3hwYKY0WHop++vTX50nUfCk+9+
	 JI1jD65LYSYPX4O6E5mUy1icGkUlzu12pqIbFW8MR/mFaCEiy5Xt9xGPLeh9RSMV5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816235;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4+vJzaNaeGRIahAAcqcSHLCv6EEY6IvTeEZnCp6y4sA=;
	b=wmaGzC/MFfwgxSkHO7wnEdJRcSEMdOXjvGjrFZPd9zqQEETMIFfzlhiZjESNzw5U63vp
	 TCcNb4twyvJf4IUs01raZ7BmhY/ehkeypDYWKKUecDO4C3N4bzgvtzvEBYbtOwT3VoVYW
	 GTJdn+FUDc21AteH8RlLzytOJtQKz7i5Iv8/hzLxKxWeYNZM2zbcQFIiLSOEME2cUt57Y
	 PTphy28IPYL4fwofjoGioznBVnHwqZ12OzAWebmRM3S1BOOzk/RQKhwAgm93zidBZF/Cw
	 scgeDpVYQPBSxYBjrKzuxBRxLtOiFxRb6IIxzWGm0U/tovuTBFw0CYn/0raiPnPasMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m7y5w/m3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAB606A31E;
	Fri, 27 Nov 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7y5w/m3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3147B1F000C1;
	Fri, 27 Nov 2026 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795816235;
	bh=4+vJzaNaeGRIahAAcqcSHLCv6EEY6IvTeEZnCp6y4sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m7y5w/m3OjJrj+5R4ikLU7JDrMEaSbKrnjTSf1QWAmR98ovVN2zl6t8KJ8jgLjOnm
	 lQxjlR9kpwVnEbP5P16pc5WNVRaxx3ufkQLGjZkCphaj6ZW36OHQqmHxWgrCVvukg8
	 O2+UBBGkOqVraRpTQLqUcSmBCMuEapy3kjLyRUSxVtCvlaaPOzCcoHj8++dAnLLsf6
	 aFH0lpCkdhoyLnvZDAu3I7v8MzDxd7tNhjYdo3lDd+OY52Kjvy8zNbPD6VBJAXt0ly
	 yvfcRSidsej6T+v+zviabcsKUu6F/Er4LTv3m4jRFgHV0MLADAinFwPHi6tZnli7rZ
	 +1+32wAO3SRug==
Date: Fri, 27 Nov 2026 13:50:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v4 00/19] perf cs-etm: Per-thread mode fixes and snapshot
 wrap support
Message-ID: <awn7KH6aDpurtZQH@google.com>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <fa4e19d5-2e66-4468-9860-19cd9f3ea8db@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa4e19d5-2e66-4468-9860-19cd9f3ea8db@linaro.org>

Hi James,

On Tue, Nov 24, 2026 at 05:35:37PM +0000, James Clark wrote:
> 
> 
> On 05/11/2026 11:44, James Clark wrote:
> > This series depends on:
> > https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com/
> > 
> > Fix a few issues with per-thread mode:
> >    - On nVHE, everything looks like guest trace instead of host
> >    - Tracing multiple threads didn't really work
> > 
> > After adding a tests for those, it turns out there were some snapshot
> > bugs not picked up by the other snapshot tests. That showed that the
> > different snapshot searches for Intel BTS and Arm SPE were inconsistent
> > and I think all tracers can benefit from using the same pointer fixup
> > logic, so that gets refactored into the common auxtrace.c. Then SPE can
> > just share the Intel BTS search as it was obviously copied from it
> > originally. IntelPT keeps the more advanced duplicate data search, but
> > in the future that could probably be made the common one and all tracers
> > would benefit from using it (except maybe BTS if it always has a very
> > small buffer, but I doubt the overhead of the duplicate search would be
> > an issue). For now this is more of a refactor rather than behavioral
> > change so don't do that yet.
> > 
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> > Changes in v4:
> > - Change test snapshot size to 128K for 64K machines
> > - Put patchset depencency in cover letter text
> > - Link to v3: https://patch.msgid.link/20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org
> > 
> > Changes in v3:
> > - Keep the find_snapshot() callback instead of adding
> >    snapshot_has_wrapped() and monotonic_snapshot_head boolean (Adrian)
> > - Add auxtrace_record__default_find_snapshot() for the simple search for
> >    BTS and SPE (Adrian)
> > - Add auxtrace_record__snapshot_fixup() for any snapshot search
> >    implementation to use to update the pointers (Adrian)
> 
> Hi Adrian,
> 
> Did you get a chance to check these changes? Sorry it took a while to send
> the V3 after your comments.

I've tried to apply it with Adrian's ack but it's didn't work.  Can you
please rebase?

Thanks,
Namhyung

