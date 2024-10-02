Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0911185;
	Wed,  2 Oct 2024 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906583; cv=none; b=Ue9/yRxuwWCIBiam3nH0Q1R8ig0w5+YFyc9RR7ya//2Dt5AyPlbNamryzPI5la3/mAkMvbLvXoesyZ9FThxnYlNq4zGZSyTNaadlQQT0IKmn4AkpKPHaEO8Z4fwSBMQhTqGVEWN8ZQHTfknOHwK2E6Y/zgsNXf446hz2pKSKvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906583; c=relaxed/simple;
	bh=Wxw0ENf1CfcIVNQGovTlDmiqp0xuZCkS2Gh23h2WqL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol6ZoRwuVFyA69XoNExwmDLMsyFQQQdIpFFwx/HTkqAtWBNgO+fKv/NoINeg6rmGiqfd2UWJxfpMCACpA8YjGGoRxmS0K0P35stVqaU86x8j2NbTjhUmcFyDJVBzJF5ueNnDGjLiwojJxDH+V5368M6QQDgdDQrQp03BMzVlQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoN9H1OT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoN9H1OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F5EC4CEC2;
	Wed,  2 Oct 2024 22:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727906583;
	bh=Wxw0ENf1CfcIVNQGovTlDmiqp0xuZCkS2Gh23h2WqL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoN9H1OTOps8twgaQ1F8x/1kVmUGs1Lovq8d4TEs4luAGUeZvcHg2C2+fugqV16KD
	 S5+mQuvBmRG+gKKgKReddje4XOHTlJqd6amKKYoHst0ZsGgqKWdi+ZfSF933EtEnH4
	 c/Fc8DuqBTE4zLx44biCf2NIrAVYnic01gmvYSCr9663SIxJCUmLPX9Vn78eNNO2Xe
	 cKrN6j+FswKHKm246BS3ksO80dGv9CRTN7aqt0vkOSlVEU0i1BnDnk5vzVkp+qGlEy
	 guEZ0BIDNGWFE8uBvBa5BON7IUgAuwpXMCcXYLKZzL1XXFpIXu3wJg6f8cGRgD/d4g
	 1N/+cGEmHpVXA==
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
	Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Cc: kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] perf jevents: Don't stop at the first matched pmu when searching a events table
Date: Wed,  2 Oct 2024 15:00:50 -0700
Message-ID: <172790631826.3078253.2849875866864219051.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001021431.814811-1-irogers@google.com>
References: <20241001021431.814811-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 19:14:31 -0700, Ian Rogers wrote:

> The "perf all PMU test" fails on a Coffee Lake machine.
> 
> The failure is caused by the below change in the commit e2641db83f18
> ("perf vendor events: Add/update skylake events/metrics").
> 
> +    {
> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
> +        "Counter": "FIXED",
> +        "EventCode": "0xff",
> +        "EventName": "UNC_CLOCK.SOCKET",
> +        "PerPkg": "1",
> +        "PublicDescription": "This 48-bit fixed counter counts the UCLK cycles.",
> +        "Unit": "cbox_0"
>      }
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
