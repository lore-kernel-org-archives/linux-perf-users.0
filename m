Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762849;
	b=O2nCEugdpYEgIliSpgnQiyAsp1hYPuScAUTVHvlFJv3qxsWqtbp3jBTnCQbH1u92ZcOt
	 auRzqTL8Q1mmhtnPWaDEFz1Ge3EGxzXMFZO0ggl4Ym72B5EaVFjUtQJeKIEQi0SeyE6Zv
	 LAhaj5K5lrJnTHleC04cOrV9Ol1xSRU4lOTVzcY6rOkaupEqZcrvRjNoFr5FH6ZHX7noj
	 o5elUolnI/9XPB6jb3AWwKMMf26sLpJCNPxIXqgLle2kinIqUnK6GGqWpdOPsKT0r0eYL
	 XIl4vPvHWn++T/FUOhwUsmuarrFwmYIWqKkApcVN50hih5hW6Yz3yo8WlNXypXxegnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762849;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vzeTdzvzzsU3+XcM6p6LC/N3jh31Ht8TX2n79esKUoo=;
	b=qJ7x3jM8FMQfC6fOsWyYXvJUBLWsjAo2xsHyXsNfLXOUkVH5kPRD4JNz8AXUiBJhbkX9
	 x2H4bNKZzuMUHNFpvqWq03R/xcn04jez3DIUHgvcKqbnjAhdurJlE1c+TMunw/W6kbpgB
	 lWnAENTfeet8UtQyWmWPAWIKpoz1E+uoew4ZU1eJllaXPls+aRaS4kW316vBYR+VDjL15
	 V3v8FiGen0BpCvJW5tpG3LeZM3vMZHCFL3Irjb4XFcqM1NKQfqTCijgcZeQ709bMvyZTN
	 5nkhnIhbInwujNdFWuSWvzkLJTmjNH00zHUkwV5AOIoRMaKJHHOET58rkmyqF3W/CGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GoWH9yaA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7E60A2627
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 13:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB7E60A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GoWH9yaA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 846FE1C0A;
	Fri, 23 Oct 2026 06:40:44 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEC03F673;
	Fri, 23 Oct 2026 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792762847; bh=K1HD8rncu7Y8lGdtnvMo8h+JWetDsjoxDoD7nMr/Y5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoWH9yaAFTkL2oSaSqrIQRszfoB12EBZMsSWkp697LYb3vrwLj7N5TrTapbfEP4Q5
	 tJYq/gOcq9nAGjufCG32/ndT0jkmVe4X6NmE2/jH2Gwz91aMo/iSXwCRjFOtfQpSQc
	 qvbXMAwXqcRBP85LhVFv4wCVJITkRVpQHA+un1Mc=
Date: Fri, 23 Oct 2026 14:40:45 +0100
From: Leo Yan <leo.yan@arm.com>
To: Lalit Maganti <lalitmaganti@gmail.com>
Cc: irogers@google.com, alice.mei.rogers@gmail.com, acme@kernel.org,
	namhyung@kernel.org, james.clark@linaro.org, leo.yan@linux.dev,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Subject: Re: perf build: default build fails in pylint (pylint 4, missing
 optional modules)
Message-ID: <20261023134045.GJ26205@e132581.arm.com>
References: <20261018070110.927636-1-lalitmaganti@gmail.com>
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
In-Reply-To: <20261018070110.927636-1-lalitmaganti@gmail.com>

On Sun, Oct 18, 2026 at 08:01:10AM +0100, Lalit Maganti wrote:

[...]

> Since 5fe83fb352c8 ("perf build: Make pylint build test opt-out
> (NO_PYLINT=1)") the build runs pylint whenever it is installed, and a
> default build of perf-tools-next (1c90f0a3c8a1) now fails in pylint for
> me, on Fedora 44 with Python 3.14.8 and pylint 4.1.3. With make -k, four
> files fail:
> 
>   python/treport.py:625:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
>   python/ttimechart.py:1086:8: W0201: Attribute 'virtual_size' defined outside __init__ (attribute-defined-outside-init)
>   (and a few more of the same kinds in treport.py and ttimechart.py)

I try to avoid duplicating others' work, but our CI failed to build perf
due to W0201 warning, so I sent two patches to fix it:
https://lore.kernel.org/linux-perf-users/20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com/T/#t

I haven't found other reported issues so far, so I'll leave it to Ian
and Alice to take a look.

Thanks,
Leo
