Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECE489880;
	Fri, 31 Jul 2026 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533936; cv=none; b=BpFhKJdUzKASNovn/VGM6fdh4GQ3MIpS1tNgezUchpSgE3ollFQCBWRqfI6ACeYND00eeTn5DoCwc1papynJyi7NscTpQCqnf22haflxZffZgyH1k7YzDY3xvSPhdBarJBDhlExOgu1KEFZs2HLdoJePaIJhQIyBp4G7I64WHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533936; c=relaxed/simple;
	bh=DyZw7AGljBoK3nBYaRFU4Cokkji8D/vcyRIh2MMB+Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9G8T1ZZ4w8p3aMlJ2Bv51C6Q45dqRwcwU+xFsZqELWrD3frLLDGCgKXciJkKGYucY1pGJwjcDYEcMYuOWBT/7/PWx+bcGdu12nHgz8RaGV1C4Itv2MsCwIF7zT3iDubww3h0+jMVoS3w2p3e5ySkQne6jvnxpUqnh6G4eA6sWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUusZT6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUusZT6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A91F00AC4;
	Fri, 31 Jul 2026 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533935;
	bh=ZO+FgU+V7w4bQTOACIQ7IyGnWBu1ibO2wy00mEyxy8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RUusZT6AKxUFwYLFkZO1mWYtto8ySN8BZXuA7U6EzTYy2vzZ5jWIqhDKpQmcL3yPf
	 m3aDuDWofiGmpK2Fuk9TmFOwv44GnSqRn21xXGFTvhOwOZHSLhi7BXVvzY5j1F89Db
	 Y84sicdtvwqY6l3UP/54DAuV7utPg3M78GXOnVj4Hez2IjNyufvKd7eDrM/IgQXDmY
	 enMT3jFOxQ41Bciq/92Akv0WFUaW01x5DmBV7MWL5e6zL+ps5CT4A1e0Qb908AecwT
	 TbhBJ+nIFNZKLDWm/qbIVKimieL/b1E6FXb5QiDCgiMOYk/nGbbUPHAW6KzRv8XlhJ
	 DG9gXCBg5uC8A==
Date: Fri, 31 Jul 2026 14:38:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"Rogers, Ian" <irogers@google.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 5/6] perf header: Support memory ranges
Message-ID: <am0V7muVNcfsLQYr@google.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-6-thomas.falcon@intel.com>
 <amjn98atBKIZDC3c@google.com>
 <329ae3d6ad1419fc356995badc5f7de5be422ba3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329ae3d6ad1419fc356995badc5f7de5be422ba3.camel@intel.com>

On Tue, Jul 28, 2026 at 09:33:13PM +0000, Falcon, Thomas wrote:
> On Tue, 2026-07-28 at 10:33 -0700, Namhyung Kim wrote:
> > On Mon, Jul 13, 2026 at 07:43:58PM -0500, Thomas Falcon wrote:
> > > Memory ranges were created to track different types of memory,
> > > such as persistent, high bandwidth, or CXL-attached, that may
> > > be present on a system for performance monitoring and resource
> > > control purposes.
> > > 
> > > Memory range data are parsed from the ACPI MRRM table and exposed
> > > to userspace tools via sysfs [1]. Memory range data is read from:
> > > 
> > > 	/sys/firmware/acpi/memory_ranges/rangeX
> > > 
> > > With the following attributes:
> > > 
> > > 	u64 base;
> > > 	u64 length;
> > > 	int node;
> > > 	u8  local_region_id;
> > > 	u8  remote_region_id;
> > > 
> > > Read memory range data from sysfs if present and save it in
> > > the header of the perf data file under a new feature bit,
> > > HEADER_MEMORY_RANGES (35). Memory range data can be viewed with the
> > > --header or --header-only options of perf-report and perf-script.
> > 
> > Can you please add an example output here?
> 
> Hi, thanks for reviewing. To be honest, I have not been able to get
> access to supported hardware yet so the only example I can provide
> would look like this (on a non-capable system)
> 
> # memory ranges (nr 0):
> 
> I will look into getting access to one and, in the meantime, make the
> other changes you requested.

Thanks, it'd be nice to see a real output. :)

Namhyung

