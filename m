Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58414A60D;
	Fri, 27 Sep 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456471; cv=none; b=WH3XNzVPigIO2CgU3/dgtFWNvTudwuq7m7Aia4sTwqjkDrzs9pW1PRkXqOvj33o7/N0wV2LBlG7hPhvZbSsa+eEw4OruUvf6P9fcHQX8SWxiTElzB+Bp9f0AeAH244VWedmKGqZSrPPfEEvq1yuRz6LNZ49v14tzQlGkM2fQA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456471; c=relaxed/simple;
	bh=nfGmlZyKWXhUfyL6Uiib+V6OTJ4RlkJGw/X7+drkjlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gmiz4Q627ohokaoWku7LbmL+fAHY5ckb1K5MAwbNq5lNfoiRZCc/8hcGHIywcNVtqpQayfz1vYMQ1q2ISL6NHfGBCEgffg8JHMDH4HAXjRNNj2hUkDK7vhIhRYjECb03a67shGGu0MBc3jRmVD+Gp5iX0FqvViJwRuONcchVwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTw96Rs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTw96Rs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9902C4CEC4;
	Fri, 27 Sep 2024 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727456470;
	bh=nfGmlZyKWXhUfyL6Uiib+V6OTJ4RlkJGw/X7+drkjlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTw96Rs1ZIJojJO96JoYyIDBVRCIgtfWDpblW7u8j1g8e/5zYBwyg74qGrgHMhA5R
	 RUy3EzZXOUZg5d3koSTpP++joVB7E/Bl23WXNH2XtLWMw+RR0dRA1biOTLGBKF0oqb
	 AKSamoePIKPjx2hXUcvhBhifs8InCJz+tXn2/btjcbVq+LI0sAG7W8OeVkG80Svujt
	 iCIWrNi11sDOB9l8qE3YpgaKTnzyJw8jzttguMimTbkQkR4cTlmuAQbhf0a0umTogC
	 77m8oGWkUFiYs2OL3ySzXCqbxlJrts4p3qDD4NEpTKFJHJljB7Bf+yEUrJLgaf4d2t
	 QsJJMtfLprr1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Subject: Re: [PATCH v2] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
Date: Fri, 27 Sep 2024 10:01:08 -0700
Message-ID: <172745645324.248940.2142953233468778675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240926144040.77897-1-thomas.falcon@intel.com>
References: <20240926144040.77897-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 09:40:40 -0500, Thomas Falcon wrote:

> With commit 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h
> with the kernel sources"), 'perf mem report' gives an incorrect memory
> access string.
> ...
> 0.02%	1	3644	L5 hit	[.] 0x0000000000009b0e	mlc	[.] 0x00007fce43f59480
> ...
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
