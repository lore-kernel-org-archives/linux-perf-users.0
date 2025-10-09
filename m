Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9C2494D8
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014171; cv=none; b=TZsrJF1LDHxfQ+xNREr3GSkB7+q/0lEz8DqdKH06/8lTAJ+wHpJhQVXZbPjpxtpOMTTfiF5PYkI5dLMTuZ4Vq0ybZI/VMgaNRJ2bUNiErS2Uh7RiX1+2zLekz117BITb3H25VNQylB+/LzsLu4lyNpxEr89gHZ8wBAMQm3RnKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014171; c=relaxed/simple;
	bh=4o67N+5muSrhDMynCVeCRqgka2MTM/1TesakMxevxuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iinzmPlZarK3i16WhKnMnp1Qos73VhITLZSpSLn2ZQwROkxkzVSMpe9Y4qowmb14j3zxqXd0bEUDVs9MVRF6xsLOVzcwpnMyZzKeK/oPgi9QasZdbb7W3ic3Kp37SNq4ojmrcLR2rAwxMG/HXAD20a0Btagm84TWiOV7rAIJLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9nFG0mJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9nFG0mJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305BCC4CEF8;
	Thu,  9 Oct 2025 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014171;
	bh=4o67N+5muSrhDMynCVeCRqgka2MTM/1TesakMxevxuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9nFG0mJdWVIIiQRfBT/gO332Y+WpK6xSEMOl/MsxyXIM7Bcyi6788wM0vxpFjBc1
	 xqN7/R9QVMhssrXXF3Lg7sA7pi8qEC7w7SAWa6jWaogukSYop0S9JgnTpKxyHX8bPm
	 xg582shf5IbSTsBjDrP9wVENxe+61UNmpMz2gsrGnW1mWLVgEFRibdC+UiD14a0saJ
	 Fuwv9vEknXYlpA9TakfXLma/pzcamRwbZeAKgUbNk2aDBIkk5iWJrWfHIL+Vn04Hra
	 wH91vvBVloENHSgJrYfbKIcjVzFQ3NdS+oETx5BrmFkxJIEi7uHSjtlzm4OmWNDCLz
	 n+qgs9UOms+Aw==
Date: Thu, 9 Oct 2025 09:49:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 20/25] perf mem: Print extended fields
Message-ID: <aOevVyDVBj_oKvlR@x1>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-20-1150b3c83857@arm.com>
 <10332b1f-f73c-4bfb-a4d4-74e1953b75ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10332b1f-f73c-4bfb-a4d4-74e1953b75ff@linaro.org>

On Thu, Oct 09, 2025 at 11:02:35AM +0100, James Clark wrote:
> On 29/09/2025 5:37 pm, Leo Yan wrote:
> > Print the extended operation types and affiliate info.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   tools/include/uapi/linux/perf_event.h | 28 +++++++++++++++--
> >   tools/perf/util/mem-events.c          | 58 +++++++++++++++++++++++++++++++++--
> 
> Minor nit: I would separate the commit to update the header and the tools
> change. That way you can describe that it's a straight header copy, rather
> than something else.

Agreed.

- Arnaldo
