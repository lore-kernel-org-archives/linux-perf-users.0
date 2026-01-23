Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97D433B3;
	Fri, 23 Jan 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185877; cv=none; b=WIS5BIhQVITq3Wdof0KL6H/Y52XjejEOxk5t9nGc0xC9++NgqAZrrR7glnnqFNqMhF882bFIp+ja+vfOv4uBRWcYnl2LXflBE2AZDxIRlzimdpWTIwjiHwqfc41B3WZWhV4zWVuCkOibaZwuB/I49oJX/ts460sfUNo1O3d+zPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185877; c=relaxed/simple;
	bh=7D3nnB9+OVPQ2v2t86pD+r3z/xJn57UWAxHn//R61/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH/m/MIvhNxO2dy8UzVlW7giIjIEBkJzsc2/muPidyss8MrSJdFa5gcboN5I8r2L6S9U3MFeLN2eRCrugxw7cuavlqNWk67gMPmdnenPrO7ZXH2B3IEqLnyC9AROZkfb1TlCKHq6rWbvYRONI5yv4qedSP78VAqKiFoTOp3Bpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMWN5ytu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMWN5ytu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CCBC4CEF1;
	Fri, 23 Jan 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769185877;
	bh=7D3nnB9+OVPQ2v2t86pD+r3z/xJn57UWAxHn//R61/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMWN5ytuUCtBTty5l3Z7llLwrGAqjReD7282ib4vi043Je2FGfmqezFyiS48w+KFp
	 cZWdvgN0MWXASgpoYo7JS9nQipD7M3C4xS7jhzWJ51R2v2qbIkInPi/2Q5yV6RWV7k
	 yzYI5aVxZso/NWI3Yg9T153wRABgMacurgYnVehEFXfLvrTftj5FsaXBtoWMsMdPH9
	 +djZmZeDet3drv7o56419beCPOi/WagfqlpcAVlODFRexClHi3eowlmRatow9xjoY2
	 xQvTxzUKrDd1KGy8q3UlXhkz0hesK4h0kYITRlpnpYrKbGrKVq2KOGFP2ORoYt5/Jr
	 f0xMkyKpMC5bQ==
Date: Fri, 23 Jan 2026 13:31:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, ctshao@google.com, quic_zhonhan@quicinc.com,
	thomas.falcon@intel.com, blakejones@google.com, ashelat@redhat.com,
	leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com,
	yujie.liu@intel.com, graham.woodward@arm.com, ben.gainey@arm.com,
	vineethr@linux.ibm.com, tim.c.chen@linux.intel.com,
	linux@treblig.org, santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com
Subject: Re: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info
Message-ID: <aXOiUr--x8ZyYpt-@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-3-swapnil.sapkal@amd.com>
 <ae0de6b0-82d8-4016-8011-0439ae2851e2@linux.ibm.com>
 <16b0e37d-978b-4991-a16d-425f00e50029@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16b0e37d-978b-4991-a16d-425f00e50029@amd.com>

On Fri, Jan 23, 2026 at 08:49:40PM +0530, Swapnil Sapkal wrote:
> On 21-01-2026 22:48, Shrikanth Hegde wrote:
> > > +static struct cpu_domain_map **build_cpu_domain_map(u32
> > > *schedstat_version, u32 *max_sched_domains,
> > > +                            u32 nr)
> > > +{
> > > +    struct domain_info *domain_info;
> > > +    struct cpu_domain_map **cd_map;
> > > +    char dname[16], cpumask[256];

> > You should likely make cpumask and cpulist as NR_CPUS to be
> > safe.

> > 256 will work till 1024 CPUs no? These days there are systems with
> > more CPUs than that.

> > Making it NR_CPUS will likely cover all crazy cases/configurations.
 
> This was a miss at my end. This should be NR_CPUS.

Please continue from what is in perf-tools-next.

- Arnaldo
