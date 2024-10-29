Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46F201003;
	Tue, 29 Oct 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226586; cv=none; b=f9IfrRcQaC1IGEeJNb/2m9/qY/nARzEe6aZ/Mu89wReYxBqd2a5bFeuMCLNw+oSz87SnwbQWl4CA+LZTWlnWsVG0+DTBeslMXRpc3edf9JOkk41R8V57KQ6LQ4uPfov1I0oBou+3XFR+UCEseRw99n8yiKOL6gfn5nq3iCqKl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226586; c=relaxed/simple;
	bh=UCgYXyHDHZOpF0R5/uphJySyNxle9b54Ia2xXewkD34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ/klnUNMKRFBfW6reWATVNRVqv1czc3Aowucc9MnvO+3HjiqUq5gv5Wz+OFHss5y6aO/Zt2XWYmJ77geFKBjLJ+ZuLmNiE/Emfv9YCgB3jmYkxFR/Exs53UBiaV26OS0bhQD2PdHEEq9p8bCBOWLiFvXsd9Ve+P2fXop8QDGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp4sGmz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp4sGmz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA5FC4CEE4;
	Tue, 29 Oct 2024 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226586;
	bh=UCgYXyHDHZOpF0R5/uphJySyNxle9b54Ia2xXewkD34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jp4sGmz1SNrfNmEKtpfI9Cw7nHUPYRkTBfI7Y6yZBLmKKwu0R5zPND37+UYPqRgPc
	 fFMOZQ4+lBYw2LyvxPefLMkQmEvnQN9UUD2yaKjx6IeaQF2KN2dhOraV0yGDR1miXl
	 YYdH7sCgOYHJXOFJCChfDzqqylJ7FCUcIuqRDXFCgrh3TwaCOGH2vknQiL1VhsnFNx
	 wTp51+SLiymnnpNAnOes/1NtsoIgEyzThK75Nl+n/pBpQqyXA5lztLHBFCLnI/sQDj
	 D82yT13hTG1vZvXtEqiKQXC31Hu/ecS8QLiiAPAs/zNtHcZ4Ku/5MxjykRc96wMRFs
	 8vDUo8HlRszCQ==
Date: Tue, 29 Oct 2024 11:29:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf vendor events arm64: Add i.MX91 DDR Performance
 Monitor metrics
Message-ID: <ZyEpmC5yKBXR0JfN@google.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924061251.3387850-3-xu.yang_2@nxp.com>

On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> Add JSON metrics for i.MX91 DDR Performance Monitor.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
