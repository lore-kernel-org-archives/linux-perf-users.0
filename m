Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB81348866
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922326; cv=none; b=r+cMWYvgChZ6vLqAzcdrHyJZ9U28XaS1YdPv7Lh4gMpNfT+m98Yd+qmVLJ/w9cVMo/JFXLWHw87UKzYQJ48cUNusDCWCqHnIC9uo9HGtCyWdNFiaOJuGFjSbKM9sV3VwBUyrvaTupq5v9pIUqbcCRqsWS9YvcXjsILE5lbVN0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922326; c=relaxed/simple;
	bh=6/wR7/qZ06/YbREpfOLKqB0ZjddthOSRFEKY1wxpGWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS/aCMi6hQvJneM+RV4Jp5mQKc3CpWPRCWrfdTQofUrq+rxyPabV6QN2Ms5V3lKke2KsqW1SuM4Q0H/MT5QhP7Lb9ZwRnct5slCxPmjak8VXYTMIKhoaNsvs+ibcWQk9qwEhT9DeIltbVqBVJiFKarIVnhxCU6kRWXHC1zZHmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fJ6qmE3z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fJ6qmE3z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06F32437;
	Mon,  8 Jun 2026 05:38:37 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C5743F632;
	Mon,  8 Jun 2026 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780922322; bh=6/wR7/qZ06/YbREpfOLKqB0ZjddthOSRFEKY1wxpGWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJ6qmE3zggln04xv+1TtzMMr/x6+hGwdVAxCtfAXpyA0Pvelixi7M421phEg9PJTc
	 +ydeHqMeeLAoBaU3Qyw2DLZHMll3uAMLcuNNEFN/p4aU4/D1Xo1UjtT4aA7bIbzdSf
	 1hE3zFtQcQZnZn7STHp1CiS2BIHqxWVu5Kf1Y4RY=
Date: Mon, 8 Jun 2026 13:38:40 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v6 3/8] perf cs-etm: Use thread-stack for last branch
 entries
Message-ID: <20260608123840.GN101133@e132581.arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com>
 <9d1e0448-27d7-42d3-aaa3-2d09489f18d9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1e0448-27d7-42d3-aaa3-2d09489f18d9@linaro.org>

On Thu, Jun 04, 2026 at 03:09:26PM +0100, James Clark wrote:

[...]

> > @@ -1798,14 +1746,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >   	tidq->period_instructions += tidq->packet->instr_count;
> > -	/*
> > -	 * Record a branch when the last instruction in
> > -	 * PREV_PACKET is a branch.
> > -	 */
> > -	if (etm->synth_opts.last_branch &&
> > -	    tidq->prev_packet->sample_type == CS_ETM_RANGE &&
> > -	    tidq->prev_packet->last_instr_taken_branch)
> > -		cs_etm__update_last_branch_rb(etmq, tidq);
> > +	cs_etm__add_stack_event(etmq, tidq);
> 
> Would it be cleaner to call this whenever a branch sample is generated?

We should not couple stack event and generating branch samples.

The reason is the stack event can be used separately by instruction
samples, e.g., the option "--itrace=i100il64g16". And the branch stack
and call chain must get ready before synthesing samples.

> Seems like the conditions for calling thread_stack__event() and
> cs_etm__synth_branch_sample() are slightly different (ignoring the fact that
> branches are only generated when the user asks for them).
> 
> Maybe the conditions should be different, but maybe a comment why or if
> they're the same, a shared function for the conditions would help.

I can add a helper to check if a packet is taken branch and it can be
used by cs_etm__add_stack_event() and generating samples.

  bool cs_etm__packet_is_taken_branch(struct cs_etm_packet *packet)
  {
      if (packet->sample_type == CS_ETM_RANGE &&
          packet->last_instr_taken_branch)
          return true;

      return false;
  }

Thanks,
Leo
