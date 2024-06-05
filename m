Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219018F2E6;
	Wed,  5 Jun 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579931; cv=none; b=HYWf4d1ELGtGzxhc2pk1oPBZRR1DjHuwyyEdbDWl5gX5lVnhfX7ZHOCwKU+zByoYwBe/wmrUHpgR7lrfnlCdaIzAm+UWbc6/0SB97fKZJLNYfV0dq9H8on6Xx+EzwCUh8cTCe3Bg3K7BKtSr7Epbp4rMAgFHDUb9X/E+b0V56hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579931; c=relaxed/simple;
	bh=rvZsHcH33M9bdWf440Wz+IzjiAyhkGnfUqvIbzvyoBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpoZM2MSR0GZmlHejA1ArBDP5FWJWfxOEjL2clWCylzA8oYkaLFOGLrEEa58MMFw6z54EJxBVisaJ1vIULFZhRk5hoCOiyuXs+zkwxNJIbWLsa5gIjZXSO0/HNF9VDvNlyFNs6iXg2h6C/REVtWa/9A2uMZtUrtA6AH80kx0bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51238DA7;
	Wed,  5 Jun 2024 02:32:34 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC47A3F792;
	Wed,  5 Jun 2024 02:32:07 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:32:05 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>
Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Message-ID: <ZmAwYjyElYQqQy7c@J2N7QTR9R3>
References: <Zl4MYzhP0NB-Z1DW@x1>
 <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com>
 <Zl9jLtiFagBcH7oH@J2N7QTR9R3>
 <fc940d6d-7ac3-4f69-8ace-459955f72281@foss.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc940d6d-7ac3-4f69-8ace-459955f72281@foss.arm.com>

On Tue, Jun 04, 2024 at 09:01:41PM +0100, Leo Yan wrote:
> On 6/4/24 19:55, Mark Rutland wrote:
> 
> [...]
> 
> > > Now more and more Arm CPUs support the data source in SPE and share the same
> > > data source format. It's not scalable for us to adding every CPU variant
> > > into the file util/arm-spe.c.
> > > 
> > > I would like to expose the PMSIDR_EL1.LDS bit (Data source indicator for
> > > sampled load instructions) via the 'cap' folder, and then we can save this
> > > info into the perf meta data during record phase.
> > 
> > I'd be happy to expose fields from PMSIDR_EL1.
> > 
> > > In the perf report, we can parse the meta data and if the
> > > PMSIDR_EL1.LDS bit is set, the tool will parse the data source packet
> > > based on the common format.
> > 
> > I don't believe that's right.
> > 
> > PMSIDR_EL1.LDS indicates that the loaded data source field is
> > implemented, but even when it is implemented, the format is
> > IMPLEMENTATION DEFINED.
> 
> Thanks for correction. PMSIDR_EL1.LDS bit is necessary but not sufficient
> for using the common data source format.
> 
> > Today, Arm Ltd implementations happen to share a format, but that isn't
> > implied by PMSIDR_EL1.LDS, and there's no guarantee that future CPUs
> > will all use the same format.
> > 
> > For the moment we'll have to keep adding to this list.
> 
> I would like to use an opposite way - we can only maintain CPU variants with
> special data source format, otherwise, all other CPUs use the common format.

I think that's not a good idea.

Today, Arm Ltd CPUs happen to share *a* common format, but that's likely
to change at some point in future, and CPUs from other vendors are
likely to use different formats.

Assuming any format by default means that when CPUs with different
formats are released, we'll produce incorrect results for those CPU by
default, we'll need to update tables to exclude those CPUs, and we'll
probably want to backport that exclusion to minimize the risk of users
getting incorrect/misleading results.

While the current situation isn't nice, I think the alternative is
worse -- it will confuse and anger users.

I think we need to talk with the Arm architects to see if they can
define some discovery mechanism for the data source format.

Mark.
