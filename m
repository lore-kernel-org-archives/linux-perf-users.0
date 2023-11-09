Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B1208BC
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqpM2CzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7460DC433C7;
	Thu,  9 Nov 2023 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699546353;
	bh=6v3NZwIXeiunZoxLw/nLe+B/ljE9jHx11AxZVwEeZIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqpM2CzMjXJ8579OjnqT+tlDsQhsLII1MxWXzO3ojmD+kKs16Gdrs+JjtfOsOV9pS
	 qnK553mRiPSU9wQ4RUhO0s0pMD+8412PyLhb2WrZVJgIONiIlYJsGo3RnVoqmCSlZi
	 dNbX80/EzXDNT8g1pcFnhhUNyu2J/k4tAk+v1+vIk11nB7SwkhYmJZJCBeMZXANC/N
	 /OIkN2VesMkqtSvTKjg0y+xvruGXELyNn24GL3R88CLBVsuNusuNP2rxVYUfGQZYlm
	 PXTAavo4hFwL/oxX7/Hvn/MOyTXYtzWE3YR8ExsMDfRtaRvvRg7le/pNO8UhGhxVBP
	 FXy9XvoFSEiJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 9310240094; Thu,  9 Nov 2023 13:12:30 -0300 (-03)
Date: Thu, 9 Nov 2023 13:12:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] perf report: Add s390 raw data interpretation for PAI
 counters
Message-ID: <ZU0E7j5UJn5ecCAT@kernel.org>
References: <20231109124105.3845355-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109124105.3845355-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 09, 2023 at 01:41:05PM +0100, Thomas Richter escreveu:
> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> added support for Processor Activity Instrumentation Facility (PAI)
> counters.  These counters values are added as raw data with the perf
> sample during perf record.
> Now add support to display these counters in perf report command.
> The counter number, its assigned name and value is now printed in
> addition to the hexadecimal output.

Can someone with access to a machine where these counters are available
try this patch to provide a Tested-by or Reviewed-by tag?

- Arnaldo
