Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71141F1908;
	Tue, 25 Mar 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932171; cv=none; b=OfNzwIh3x13kh0pfJoBLqWMvq0qPKbCR6NcCPvPU3PceQW6Gn6BslBFIQSn62y6//3R+B2KaMuz34/rcCHdgbD7KbIQMbr6Y7DTq1Mp37XbFluViD5sTfIYJZ5JrRKdeeLwcIRmrJItYpP1HmW2eceuoc6M7o91lgMiZ1ZktZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932171; c=relaxed/simple;
	bh=WWd/YrN0uGmkm67PqzMZZTfLmW2NmIhpsLUlNRtNTHA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ifCiO4trr+/ORqucxUUHPCA/wU1bgTXB8NIjcVq5OfgABGczCTnW+UyiDNmqNKxj7ZFDlF2FmDbSy7eSWwfCydcpVV/LRJ2ZjhhNXCDeRb5l92cTbGWVOgYEQWR1WxNJqs3JLE1FP+WkcU8LUVj6ke18PlasE5wDGzu/mLiz6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDFPOv5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDFPOv5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D79C4CEE9;
	Tue, 25 Mar 2025 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742932171;
	bh=WWd/YrN0uGmkm67PqzMZZTfLmW2NmIhpsLUlNRtNTHA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lDFPOv5fXNfBwph6rbj5bQKmxi+p5ewhYNfSalwO4awpPzzM/iijWCAkVPNGsIQxi
	 XwfwjZNJpz+R5q9ylZnzn3rdSzXWpVLq1XpdxMLIykkVkZ1Qr4NH2O2pkcctLmf07S
	 4dtd+uCcTt4n1vMKdtaNzKMR9qDcVKY/yRVe0qBWxX+nvuOsAW3s6w0LVd4bzzzRe4
	 0Vt9cMh7WeuvOeg4sS6FrEDHefOcAu4l0uNXehx8a6dEQI+Zotap4w8KCSUIQRRoHM
	 m2eMtbPXAwUAlwxVc0ZL6xufp/MBCdstCI1brln3AfcgpeQBpdzLwY7pc7OT4mzlye
	 H43HNdlFsvYFQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 carsten.haitzler@arm.com, james.clark@linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marcus Meissner <meissner@suse.de>
In-Reply-To: <20250323085410.23751-1-meissner@suse.de>
References: <20250323085410.23751-1-meissner@suse.de>
Subject: Re: [PATCH] perf: annotate asm_pure_loop.S
Message-Id: <174293217088.2401011.11487295532545841599.b4-ty@kernel.org>
Date: Tue, 25 Mar 2025 12:49:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 23 Mar 2025 09:53:45 +0100, Marcus Meissner wrote:
> Annotate so it is built with non-executable stack.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


