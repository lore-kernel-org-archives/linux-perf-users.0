Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4435206E;
	Tue,  2 Sep 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843572; cv=none; b=E6ISS+XTob6namyn0ONkA/j+0BjKXCBdOwmYZGNorPpE1DKHz22mlJRYfMni/giwPpaBhDpSwCJxXNM6haNfp0sUYoz4caI/gzZ60/WGS3dBgxQwQ9sXTMjPhWFe+32uciRN81nutMtSmkZADYBcBsfa+2PDbYYr/oXnup2xj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843572; c=relaxed/simple;
	bh=e/8ugNXFGCMc6CgvanPGd1Hg+ML6Seh4B4r3E+9dJ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGgEF3SM0cO8/13Vxl4pVy6BAqJgh+rllPOJopW3zln4wnl2IIIZaRCSh0ZX4kxcpgravJvdb6W+zGYL6XYKGG+bDKLJXUamC5AeyvJulhkYVVpdI/R1NuaMTGggGAhMSV49MQBA5Ld8BmSLzg+zLueVe9M6HazKE0PMaMtTWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVKDYAvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVKDYAvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6093CC4CEED;
	Tue,  2 Sep 2025 20:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756843572;
	bh=e/8ugNXFGCMc6CgvanPGd1Hg+ML6Seh4B4r3E+9dJ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVKDYAvUCcZk2O9EMoy/NJRovmfOn0evGeVAqFuySSWvd8vQqjifrTLUoO9HiANU3
	 lK+r/3yqInbqMF9/i4ud10wvj6jzQGWjsstehfZFccnyeZnfz6hCjJascDCmTQQFHJ
	 +7da1wuQUhgTD1V8BB3QSCXU/98INrXH/4npyIjARmRfUJ0aa3Jaduc9gZDLMjgaEb
	 AAPRm8Lq2F3lmfv7p2nLWexL916av6XdLGaYX6Y/7aFE8Eup2rAnzDTBLO65eOWliK
	 DJY/DtPdyc03uYC8egofV9dzpOgYPO/Gg8jjzG1AHxHAwBm4CUBx0eRm09kTPGYHD2
	 DxfoKO4Te6RwA==
Date: Tue, 2 Sep 2025 17:06:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 00/11] New perf ilist app
Message-ID: <aLdOMD0aszmtqvOl@x1>
References: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819013941.209033-1-irogers@google.com>

On Mon, Aug 18, 2025 at 06:39:30PM -0700, Ian Rogers wrote:
> This patch series adds a new ilist app written in python using textual
> [1] for the UI. The app presents perf PMUs and events, displays the
> event information as in `perf list` while at the bottom of the console
> showing recent activity of the event in total and across all CPUs. It
> also displays metrics, placed in a tree through their metric group,
> again with counts being displayed in the bottom panel.
> 
> To run it you need the updated perf.cpython.so in your PYTHONPATH and
> then execute the script. Expanding PMUs and then selecting events will
> cause event informatin to be displayed in the top-right and the
> counters values to be displayed as sparklines and counts in the bottom
> half of the screen.
> 
> There's been feedback on how the app works, simplicity of
> implementation has been chosen as the first criteria as the app can be
> further refined from what is here. The choice of the name ilist rather
> than say istat was deliberate as I wanted the app to encourage PMU,
> event and metric discovery, as with perf list. The output counts and
> spark lines are just to give an indication of what the event
> gathers. ilist comes from interactive list, there's probably a better
> name.
> 
> [1] https://textual.textualize.io/
> 
> v10: Add Howard's reviewed-by and address documentation fix. Rebase
>      and drop build up patches merged in v6.17 by Namhyung.

Thanks, applied to perf-tools-next,

- Arnaldo
