Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31D35946;
	Mon, 21 Jul 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057810; cv=none; b=asUO8BSBc/e2QdyVlz7EhSB9ydoC4AiUonymjHZBQ2TO0ulPbAB13igFHqF1b8eLpkqINj4kT97kZbUa+Z1ehCV0F45TEuTVMAudJFUl5sERtS1QzWYJAT3hV/BtvMTaVt6/ouljcLRhnJ9muG6dbsnqlTQLHNSG44cEwp2MdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057810; c=relaxed/simple;
	bh=Z3IQ//BUVuDYShz8oy9xXfu+5hwrpJS0iBCHzigaVV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2IK99am31mDnhhwiCijJdplyNSHieqJ2DpunnA/4LP5vSjdP9LG2nDiUtH/jB1IbSx40sidccdG+Yy1nY1TXPjgPjPR+tfviAUvFWa9SdA6JDa8Gd5YRDTza2WFI0DuVbALTOJ8Qi+H8AM4YQWVdj6Qfucn+BhSyrhs0xVWuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYQZrXPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYQZrXPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5AEC4CEE7;
	Mon, 21 Jul 2025 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753057809;
	bh=Z3IQ//BUVuDYShz8oy9xXfu+5hwrpJS0iBCHzigaVV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYQZrXPJte+ORULINt/7fnPZMWv95A8AnQxTsfKiw5NxE3XNuoyZ09l2sj8Hjrb7L
	 6Kfpp1493vPQjkjAp0n4oO06ESvRUse8EYwsD3a20IiRTx8fW0jIGtMtnb5p0BPaU6
	 EaRy9+MqJHi6gyoqvwnctSHZpwSudWFxjra0m6YswF1CV02Toe3j9dHqG6ttdZiq5q
	 xE2dkERHMAovAuxSel8/SFRi/VDV04Z96phqZwrXBqyTbovLYwXMyOFFAD2zc47dat
	 ncwOzZixvLR2PQpG55yARAS/8SWlit3uZGLkyKgOZzAM1yblxg8gQ1avy+5hcSdPrV
	 zDJjAsBMm7icA==
Date: Sun, 20 Jul 2025 19:30:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	jonathan.cameron@huawei.com, linux-arm-kernel@lists.infradead.org,
	james.clark@linaro.org, mike.leach@linaro.org,
	coresight@lists.linaro.org, krzk@kernel.org, linuxarm@huawei.com,
	suzuki.poulose@arm.com, dianders@chromium.org,
	ruanjinjie@huawei.com, linux-perf-users@vger.kernel.org,
	saravanak@google.com
Subject: Re: [PATCH v3 1/6] of: add infra for finding CPU id from phandle
Message-ID: <175305780744.3139904.12956973374132329407.robh@kernel.org>
References: <20250718094848.587-1-alireza.sanaee@huawei.com>
 <20250718094848.587-2-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718094848.587-2-alireza.sanaee@huawei.com>


On Fri, 18 Jul 2025 10:48:43 +0100, Alireza Sanaee wrote:
> Get CPU ID from phandle. Some drivers such as coresight, cti-coresight,
> or arm-dsu use this API for finding CPU node in DT. In particular,
> drivers do this by getting the CPU device_node through a phandle and
> then find the CPU ID using of_cpu_node_to_id(). This commit encapsulates
> CPU node finding and improves readability.
> 
> The API interface takes three parameters, 1) node, 2) pointer to
> pointer of CPU node, 3) CPU node index. API sets the pointer to the CPU
> node and allows the driver to work with the CPU node, for logging
> purposes for instance.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/of/cpu.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  9 +++++++++
>  2 files changed, 58 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

