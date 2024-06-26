Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2937347C7;
	Wed, 26 Jun 2024 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374464; cv=none; b=ALN/Wb2WDVCLT8Bgr9HxFwO5XdS5/9ZKY48FIv2weQ/f9MhD6qRWEuI2JwYHc3JnxVcT2FvDrOIRLsW7qFoh2poGRzOW5DL62PO/qPomxV/idKxO6flaZZL9OZmvVVp3Ildh4lOfL9BNgMla89a0DGIHRE7RSTxw68i2U+HSn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374464; c=relaxed/simple;
	bh=xNOTXSmRQ4wUF5Zya/8hjIS1vWh45OmkjuSgbQqQ4do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1bAQ0Hzy5cqBIAb/0OA+t7RlEGYL0zLyLndhDD5ypmKQi6wqDSlxtve37w/diN12K7SJtWVW380R45o5/lGYMrq2nj0Xq5ab5UEvMI4g4mqyErVG1IO6llIByFW8DRYR7E24a81qauvaUMVdg1wzuPTOeVv4DUgRxa04ZmtDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhwJ5OX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhwJ5OX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B91C4AF0B;
	Wed, 26 Jun 2024 04:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374464;
	bh=xNOTXSmRQ4wUF5Zya/8hjIS1vWh45OmkjuSgbQqQ4do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhwJ5OX0QXtrRyp/9PMat2xtOvH9eZx4pL/pP+yRWjIfDv2WuTbTHMWojrry45jwb
	 tpLbO83XxjjgCAbP0GhQyjrDrGpt4uA5AKTPdOeia/8L7iHWeGcH3D7Ib2FrCSZX1w
	 9EAH60/7Z1afMMXcejuWW67EfIiH958eYSgQELF4CmbB/c4NfVGSPBHuhD2UHT3WGk
	 Du42kLuwPBRjBxVPVn9cSa/q4lEg7we1IJ4P0T7hCmzalTXACg2g1DhccZlLQfgYXP
	 z4OB4VcW6BH/Iq8XxAl3c/wHDXYrVe2ilYYTVyGXdRuldswLaKIPTCLWa7peQxZKdu
	 CIj3kKGSJsZCA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	yskelg@gmail.com
Cc: kan.liang@linux.intel.com,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf unwind-libunwind: Add malloc() failure handling
Date: Tue, 25 Jun 2024 21:01:02 -0700
Message-ID: <171937445590.2860437.11253278806338067490.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240619204211.6438-2-yskelg@gmail.com>
References: <20240619204211.6438-2-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 05:42:12 +0900, yskelg@gmail.com wrote:

> Add malloc() failure handling in unread_unwind_spec_debug_frame().
> This make caller find_proc_info() works well when the allocation failure.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
