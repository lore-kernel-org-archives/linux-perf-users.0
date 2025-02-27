Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936791DDC30
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675028; cv=none; b=IJfFWHA1AKINk4TfB/bMvxOMsiYyo6CmLQBDGzDxS20pVRxBLY1qm0dl6Oh5KHi+nBOooOCtUha3BqM82E0vobYJCKUqNYxwN5l43R4g8yjM7xIZO03f1oZ+OKnPvarPrEQGjjL27yOvXLcK9zOJzpL7zWJ78PbTT06hcjHigR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675028; c=relaxed/simple;
	bh=vGzYbABsEZES14wNelq5aaknya5cl/i8HQMd55vQGN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=foJDcfFODJUw1WTnwi9ZJPH7amI6JUydkmuEXFzJvT7P8aUYPetOsNEd/SC7BzNjqAus/FkVjnlFdX0X22nXR+6xL2iI8Uk+yzdyjolk0c3crx8DaFQ4dhl4bmKCVmpEua3RwgJFTZsw/xCedAKmR/P/g/WQniobc9DQfvyLXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWr2j6nQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWr2j6nQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1392C4CEEB;
	Thu, 27 Feb 2025 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675028;
	bh=vGzYbABsEZES14wNelq5aaknya5cl/i8HQMd55vQGN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tWr2j6nQWCp6GW/OdvFGYRhqDOWStwZshAd7JJ3lPdinzK2po2RRPspQDtc6GEnXb
	 oW9e7FC7+4JY63xfyAYyrF8tfdSayMa5ETUi2qFWskuC9Q1hRZzDvzoQA6ZhY1t3Rx
	 kuCx0neg9zXpWkYENFVJx5Bgv/fo4vJYqrZEMuBy1/igQ65DAkmfmipSopwIQ9kW3+
	 bkaPZzBa19PwHgismKUXY43Mm+n/BhL4GVJqDgtmG+mvwU+zqV2+e17kDK3DJuiNXZ
	 hanMRcDqOW4idid/Bmt1CwWlu2ZOrKR2CJuBXbGoGxCuVDkBI1U6lBViaJ+g8t2LFq
	 gtQKxls4c5iXA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
 hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com, Tejas.Manhas1@ibm.com
In-Reply-To: <20250225113157.28836-1-atrajeev@linux.ibm.com>
References: <20250225113157.28836-1-atrajeev@linux.ibm.com>
Subject: Re: [PATCH] tools/perf: Use perf_tool__init() to initialize
 default values in builtin trace
Message-Id: <174067502768.1401960.9231492676290649257.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Feb 2025 17:01:57 +0530, Athira Rajeev wrote:
> Perf trace on perf.data fails as below:
> 
> 	./perf trace record -- sleep 1
> 	./perf trace -i perf.data
> 	perf: Segmentation fault
> 	Segmentation fault (core dumped)
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


