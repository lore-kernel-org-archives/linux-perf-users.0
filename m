Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437601A2872;
	Mon,  9 Jun 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482303; cv=none; b=THGp/Jv8aqBspXvQHx+JKwBrmaDaEJD9PWtj5IkPxhUE6IqGYzqd+oGBKBnNVLnwx9ct9bs22U6gu2eFtI+AlaiXxHjdn0NaL5/hlhaxSW9V4nIE+HnKn9uLQEhLRqzpSc//oqoDdLh+yZ5d5/FACPramLrltYkpKfK2pFkQ3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482303; c=relaxed/simple;
	bh=H6uWy1GaofghMpwUu9+Y5LyiD95Hf/reAF7DD+EdDl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/Izz/W5mfAHUhCf39z82AfN9MMmb1fm7vOIbOn3IQN7VuTKjk3tedveCJH70Y65pPrjY9WgjuY0d5+wIfNSCJjs4HeSrbEErDLD73dXDB9Rgkq4t4rVzc0GDHC6rqHCQ56DA1zakRzPx1c8PvHYyFDX8lKXwnrUMGCrNRbKoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjbgtTAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjbgtTAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BBAC4CEEB;
	Mon,  9 Jun 2025 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749482302;
	bh=H6uWy1GaofghMpwUu9+Y5LyiD95Hf/reAF7DD+EdDl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjbgtTAKfWMzIzwPv+TIM0OznEGUDD5KSTU02+FHMwfssVBYQ6v4wY2mNHgCjU6Gi
	 3MNHAHRCWyKbVpwxctzRUsglDC5KG/8QP6ASwWFznIY9NI2dfkjwy75yzchQ0yAyAT
	 +8LAfWucpB+x/OHLxQRn9wgL7404d4GC/E6QSAKdQmgScxVbDyf+cX7pPa2E3Vnkre
	 ebRSr+M6cE01BG29ECKWZgtWF3C55k65Ba9GhitPHaoMuHUcB5DeXqc5R5V0hwr7SK
	 U2AXP+6oZSI1oW+cMEJqP8eZpLLqREolFumeIK35sJAOj+JMdwkSb4+eAafUig53kG
	 wZRCKPigabmoA==
Date: Mon, 9 Jun 2025 12:18:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 v6.16] perf test event_uniquifying: Skip test on
 platforms without 'clockticks' events
Message-ID: <aEb7O44ddMygHAil@x1>
References: <aEHugAPinlWLuTAS@x1>
 <aEMqwmCmbyAlb1Y1@google.com>
 <aENM_KGb-x14pHRX@x1>
 <aENOrmDxKPYAaYNR@x1>
 <CAJpZYjU3o0uFbDNhttpRFOv4j+RfTfdJqeP_4bejp_-_qoUkDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpZYjU3o0uFbDNhttpRFOv4j+RfTfdJqeP_4bejp_-_qoUkDA@mail.gmail.com>

On Fri, Jun 06, 2025 at 07:55:54PM -0700, Chun-Tse Shao wrote:
> Thank you Arnaldo for finding this problem. Please feel free to amend your fix.

Thanks for checking!

- Arnaldo
