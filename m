Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7928FC;
	Mon, 14 Oct 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925070; cv=none; b=GkoWzRmPSbclzq5coVKlN76t4pPj32qmz/kD+Vf2cUU9YfOqKaf1o8tuvpejn4ZSWd6lboh0ndSB7cQesV40n7IOue2VF7IjPI99lpvL05Qx9DymaYkp2QGziof+DRA1KIhVKCl4yPWgQQ9P0oJPr/es/eKmEmjjwBsatpeWXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925070; c=relaxed/simple;
	bh=uVgNkMnd/3ACRkYOJdqI9kVTo9dWEW5ZuZS2b8xr1Jk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBlROyhJ15IPnS8z1kNdVgzjxlBGI/AW6xuE2/1rN86iCSQkRiaMcERxaVhNpyRSviCpSV9Y2L5Va/m5W0TkZeXEIJRnMZh/s3+Q1EPBt94Mn6RSLmrhkJKPZx73utWlgQmbxNlWvuR96NMTnzPVBgc8/uYbXLWe1NKS/i8ZNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOl/8S8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOl/8S8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CBEC4CEC3;
	Mon, 14 Oct 2024 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925069;
	bh=uVgNkMnd/3ACRkYOJdqI9kVTo9dWEW5ZuZS2b8xr1Jk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EOl/8S8NThqlGNFzJlhSi61S4VMB5E/59kQ0OMsnMqAT8y19uC1LS4jSDxlphozkS
	 cB68GkYmirTKMY9I5nmMnHvt3uFxA0lscpBDCtA1IX/wfjuuPkEQhQp6YYi2bLwV80
	 U8qwxwuXtYsbF+4Cw1ykQ5UUvEM/FFtFgydD5Q1y9DRRTP9WZDaHYTVrZK4uqtOW6D
	 +IfOb8z68LvuJ20H+sQDPwGxbViMcCPLSCthfCe4kQC6Go8Y3MAbO6vPUVz9R+ZE9s
	 FCOvgKiFVaRAyEw5MOIF+4lmcnE8NH25QMj4HtPoymTubBT85hU8WATztKNZz8uEzS
	 oBCdOGzZ5EYrA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Weilin Wang <weilin.wang@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Ze Gao <zegao2021@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ian Rogers <irogers@google.com>
Subject: Re: (subset) [PATCH v3 00/13] Tool and hwmon PMUs
Date: Mon, 14 Oct 2024 09:57:44 -0700
Message-ID: <172892501876.15689.3033776452114241279.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
References: <20241002032016.333748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 01 Oct 2024 20:20:03 -0700, Ian Rogers wrote:
> Rather than have fake and tool PMUs being special flags in an evsel,
> create special PMUs. This allows, for example, duration_time to also
> be tool/duration_time/. Once adding events to the tools PMU is just
> adding to an array, add events for nearly all the expr literals like
> num_cpus_online. Rather than create custom logic for finding and
> describing the tool events use json and add a notion of common json
> for the tool events.
> 
> [...]

Applied patch 1-10 to perf-tools-next, thanks!

Best regards,
Namhyung
