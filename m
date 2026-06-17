Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB453F0ABE
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699609; cv=none; b=dH9QSBWtpTPHkLsCv//NTV/FgHVXpceHzYnwzEZAQeNHaa7581Tisf3EeEPVZJeJzqbRBckWRlSIa3rUbon5eC+MnjVaca5u1P25TGm9XtQon9c5eT4p24fXTXubuBRnYp3Uw6tDB8O949Q6FEbTQW2dF/0dtbV7P46rPdjlsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699609; c=relaxed/simple;
	bh=r83KeuqB3hEVv5E42XQQjBHyG/qeI9tw84x0hh9E0RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZjGQE6mTtVSdRqipSeETTSKwoCyGHlx1na4Apka0mxZfMqWN35aQhfkqwtdTd9s9EX3aw040GUEc59DCtHmkLUMVRKFxrGS4pYdvnW66NfFSVkBkfoM3f0L4OdjqEqDM6Vk4fl1QMlA6o/HWuVVB8p4yAxVtZNO2g8fsDiZXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=knuQs4aK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="knuQs4aK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DCB4794;
	Wed, 17 Jun 2026 05:33:20 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B7A53F905;
	Wed, 17 Jun 2026 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781699605; bh=r83KeuqB3hEVv5E42XQQjBHyG/qeI9tw84x0hh9E0RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knuQs4aK6TdebO7fIYmkq/OWHeq/Jc4FF5+weqhAr3Z7aOlB0bBLXHDGr53Dhy6BK
	 mT85P3OhrChY/4Uc3edesHHtNqBkAVnQSk3GfKwRL05nrnKORjDFxPH+DfRYYr9ZZF
	 G7eXWf+Bo91zv/iG8yWI5orAOYABOdmR+OVGmOXI=
Date: Wed, 17 Jun 2026 13:33:22 +0100
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
Subject: Re: [PATCH v9 9/9] perf test: Add Arm CoreSight callchain test
Message-ID: <20260617123322.GD31870@e132581.arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
 <20260616-b4-arm_cs_callchain_support_v1-v9-9-f8fad931c413@arm.com>
 <6855d77f-d2f4-4dab-8481-a8c586e4872b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6855d77f-d2f4-4dab-8481-a8c586e4872b@linaro.org>

On Wed, Jun 17, 2026 at 11:03:07AM +0100, James Clark wrote:

[...]

> > +	# It is safe to use 'i3i' with a three-instruction interval, since the
> > +	# workload is compiled with -O0.
> > +	perf script --itrace=g16i3il64 -i "$data" > "$script"
> 
> Is there a reason we don't generate callstacks on branch samples and use
> --itrace=g16bl64? That removes the magic number 3 and reduces the output
> file size and test runtime a bit.

I checked Intel-PT which does not generate callchain and branch stack for
branch samples. I just keep cs-etm aligned.

I can add callstack / branch stack for branch samples.

> All I had to do was copy the same "if (etm->synth_opts.callchain) { ..."
> block to cs_etm__synth_branch_sample(). It seems like the grepping doesn't
> exactly match the branch sample format so the test fails, but I'm sure that
> could be fixed.

This is likely caused by the regular expr.

> I suppose there is value in testing instruction output, but maybe we can add
> the option for users to add callstacks to branch samples, even if it's not
> tested.

I will try to update the test for branch samples.

Thanks,
Leo
