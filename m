Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40C33DED5
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806497; cv=none; b=YZDFSKnKi6E0fqKUY7nrLSVyr5HHW7RxtyW3ZgypAeSYcC6U8tTHWi9CJPcEWPro2yZRIFttvvKvkjTd6QjOrEgOmDDxFXIrAUGc1gQqndyVxvnE/GDokFdS3mBnOdEskNSiRrJtFSD0beLMtSrm8l0lG4vcZDW/kwa0nrsTTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806497; c=relaxed/simple;
	bh=3dt6b5NFS6OMkaxBDU5Vw8gZWuujHEwxgHO+tc15hWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jczpZPnOZkE2umCfhus5WNOh1mNdWPO8fyslBfr6qhkKA/FRKMrNKbbRpKFaBk4oxvR0cHcsfrb0rxA3KIU/3/9iy3aFNGE76xbUPC6dEa1C4cxHsZOXy+bGdk66efs88DgmlQJqImFWcC4c9ZBFcBHAK0QqfWEDCaRFcxgEao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RbJVWVAD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RbJVWVAD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C5A1CE2;
	Fri, 10 Apr 2026 00:34:48 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7353F3FAF5;
	Fri, 10 Apr 2026 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775806493; bh=3dt6b5NFS6OMkaxBDU5Vw8gZWuujHEwxgHO+tc15hWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbJVWVADOhWYJ31F/RpHT4ldw6QNo1V1GBvc2jmrGLoJtSGpsf8+DcCbgVIHOtdjv
	 ovO/VwSCnBA/f+XWM+8gK/xRNkXtLCzoAIVPGeLT6BrgYbb+J06ZiRWxwagj1heNV/
	 LiR48gDoor5rDV0aiCrM+go283dvBpSI+HmYcOLY=
Date: Fri, 10 Apr 2026 08:34:51 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/4] perf arm_spe: Extend SIMD operations
Message-ID: <20260410073451.GY356832@e132581.arm.com>
References: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
 <adiGR-A-N1tMzxTE@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adiGR-A-N1tMzxTE@google.com>

On Thu, Apr 09, 2026 at 10:10:31PM -0700, Namhyung Kim wrote:
> On Wed, Apr 08, 2026 at 10:42:30AM +0100, Leo Yan wrote:
> > This series extends SIMD flag for Arm SPE and updated the document.
> > 
> > Since I failed to get perf core maintainer's review for uAPI header
> > updating for data source fields (since last year's Sepetember), this
> > series I dropped uAPI changes and sent only SIMD flag changes, hope
> > it is easier for perf tool maintainer's picking up.
> > 
> > Anyway, uAPI patches will be sent out separately.
> > 
> > This version is rebased onto the latest perf-tools-next branch.
> 
> Unfortunately it doesn't apply due to a recent change.  Can you please
> rebase it once again?

Sure, I will send out a new version.  Thanks for taking care of this!
