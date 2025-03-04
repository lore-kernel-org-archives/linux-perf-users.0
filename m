Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481A208A9;
	Tue,  4 Mar 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088043; cv=none; b=MwXx6xvpD3THhHX7QTz91QgbWgJcWLB1r02uIFZycLY5jhiOveJ4Xv6Z2VQyEElU7ms2+45jw4xjTDJvD7yOAbsZfQWn+zjka1EuzGXdbSga5i0RFHDZF1pJRC5SMK9lmQkzyxpAwVnwDlvAYbBav3Yot6RuLHz/8Q65jwr+SmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088043; c=relaxed/simple;
	bh=OSaHtJELfI/aomBjHKyTEv/ZMYxODYf6bl6A6qy7Yns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg5xio1AesYN61uuR7dOW2sTbM12/Crjrp4z1lj7glDJ/njp4iYelvJEAr9zb+yO2yYXu+dBDnDde3q0Zkga6rp/Te8CK+WdS9ZYpb6GNt5q7fwGfedPrdkH9hzEzA12vxOEVcTmzqqJak90UjOR9vJ+/DJFhNfWdo9GmsYckOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C189AFEC;
	Tue,  4 Mar 2025 03:34:14 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21523F5A1;
	Tue,  4 Mar 2025 03:34:00 -0800 (PST)
Date: Tue, 4 Mar 2025 11:33:50 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/12] perf script: Refactor branch flags for Arm SPE
Message-ID: <20250304113350.GK2157064@e132581.arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250303093853.GG2157064@e132581.arm.com>
 <Z8YYY2Q_ZPIaZ74g@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8YYY2Q_ZPIaZ74g@google.com>

On Mon, Mar 03, 2025 at 01:00:19PM -0800, Namhyung Kim wrote:
> On Mon, Mar 03, 2025 at 09:38:53AM +0000, Leo Yan wrote:
> > Hi Arnaldo, Namhyung,
> > 
> > On Mon, Feb 17, 2025 at 07:58:56PM +0000, Leo Yan wrote:
> > > This patch series refactors branch flags for support Arm SPE.  The patch
> > > set is divided into two parts, the first part is for refactoring common
> > > code and the second part is for enabling Arm SPE.
> > 
> > James has given review tags (including the new added patch 06).  Could
> > you kindly pick up this series?
> > 
> > Sorry for pushing a bit, as we have dependency on it.
> 
> No problem, I'll add it to the tmp branch and run some tests.

Thanks a lot, Namhyung!

I saw you have picked patch series v3 in the tmp.perf-tools-next branch.
On the other hand, to follow up on Adrian's comment, I have sent out
v4 to remove an unnecessary change in patch 01, and the rest of the
patches are exactly the same as v3.

Please consider picking the latest change (either the whole v4 series or
just the updated patch 01 would be fine).

Thanks,
Leo
