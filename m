Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779427;
	b=YY+WtSlNgdwMPixwvVqqsiJsnmV50OF2HRhFUCkgWVwwPS059TCApxI8lyjacoh61NIu
	 bbHXe5ic91VoUchCDm7caFRDuKtJ1HByevBGD0B/8avsz0bm8VtOCph8VuaUbdzFPGEeN
	 uVXqvmgif7WIBAkOANiOZPnQMy8wab/RTJjLwci3wxMkwcYm9Ycbl4JCHN+MaFS3vV1G5
	 +8lacHuRb7HPhGXple1zgWLrpwE03KMGSHp1Tm0mYJ6f6qQiFQFi/h5uDlPLmTDBDiP8m
	 k3QqKjtwsLuYfHXyYxIAr7lVzXs8F0x432Gs4PbuKr21l+7xZOkcu+L0mdBYR3CdDSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779427;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rq/f9lFvbKOsyeAv0AQkPXaXsc6C44TDCVVQHKNDSpY=;
	b=D2RKm4UcencY2I4uCdkp/bl6Sz9FEHsrCGGnX4voeOu3sGmYpDJ9nVqGALBDWDWJQiW3
	 l2wKtRJrubOe6sG4r2En2mFET8djUSkZeZZI/bCHiY6BoZ2PYC7UKhcepCad1uHSpYu7U
	 P0vHwCX4lmxKTgyL4cH6rjE4Ca1Emaf5uoNJLiYrx2KxSHrkAkHPdDIc+zG5ljW+rUyqM
	 ldoFJ+TUCycJ8gqviQHL40K39OoT0DgMdofr6uvyhVUHoPMX7Fh6UejQ2pa8FsS7LqIYV
	 auELxZJWeiOxdeOXmpPwlwbMEf9gZ+S7xT3p+kxv8BMRYC3dbPNk4IWZdnDgKqqiNlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qE1MB7Rq;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE4606A31C;
	Fri, 27 Nov 2026 11:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CE4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qE1MB7Rq
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F841756;
	Fri, 27 Nov 2026 03:37:02 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFAD93F632;
	Fri, 27 Nov 2026 03:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795779425; bh=VaL97qzaUmOSKTZ/hgP4z/MhSjBcXOvVasIuwl15ZDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qE1MB7RqAPGz0qVbB1y9yXcqxh2QipFGWiHzbGQ/g36VDd7oSlwiwZP3Hmfv0U4Vc
	 55l2f/5EMEJEtsYhiFBmHUxPadbIz/k/Nvl8CGpei6qloV0vEX+YgFX3OXYmzNVvfG
	 jRskp9GXyUfwG1MzdZhYEso83Xb86fxlDjj3ybho=
Date: Fri, 27 Nov 2026 11:37:02 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf kvm: Don't create an empty perf.data in live
 mode
Message-ID: <20261127113702.GD861809@e132581.arm.com>
References: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>

On Wed, Nov 25, 2026 at 03:12:13PM +0000, James Clark wrote:
> Running the perf tests drops an empty perf.data file in the cwd which
> gets in the way sometimes, especially when the tests are run as root.
> 
> Fix an existing error path bug to appease Sashiko, then fix the empty
> data file.
> 
> Assisted by Claude Opus 5.5.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

For the series:

Reviewed-by: Leo Yan <leo.yan@arm.com>
