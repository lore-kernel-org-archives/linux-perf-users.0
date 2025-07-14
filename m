Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CF1F4CBB;
	Mon, 14 Jul 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470147; cv=none; b=DwJpIims0732RZbRukTOzNs0RTJzf63EgwbU8PCgcwtmdqG1/rZyWjd7TTRqPLKY/Ppc+h32eNv/PUfeknG51eIRg2v4pYHJJfTcuQcheoIqlEI1FfjS4YorgBInMYUYv5hyN/Pq/htR9HaGztOFwhOlMu2gwmRxa2mtcbVbbjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470147; c=relaxed/simple;
	bh=thh1XgY/SVk5OpwWCUhi4ogjwQf9J3PUZtkRf2Su1ow=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nw9j77VuOnfu9vy17eQT9L901tgNUwsLSoMXWSYeq/FWKOyi1qh97fWevInJNLm1ioXFrrMttBNkXGyU74NDzANF9atk2nuHOiM/THLxvI+sQiD+yrcVcP+irUaHQxvEc28CaC/+a6owf3PnP8xusGy5LBjL/DzUW4eTXDR9Dzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcBqUR+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcBqUR+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1B3C4CEF6;
	Mon, 14 Jul 2025 05:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752470146;
	bh=thh1XgY/SVk5OpwWCUhi4ogjwQf9J3PUZtkRf2Su1ow=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=gcBqUR+5dUHan5NNpsi5kxG8Ia8CSUIebThCjWkt9jAASQ2cNPMJChzFkHwoYa/cT
	 5r3yElxcJUu6lBXwINpaqy4JXaD7TNNUUjad7+A+0y+7gjbVXNkEwo10mTCcg6iW1n
	 Ucs+bMhxKXHbSbv1b8p/nPMpaYqn0sUFAKuE4npNNEEhRGfxisaMraf3oeKb/MSs6d
	 YHD61yblqUPG8mzFVL9ahTenfvjhlV9v2IZA2/GsA+GCOKZvmmrsMmF/2HYig2I2Kq
	 X0luhNt71g2jHd65czdsLyEVZXjoPHyX30W0bUzDyX8RFIkyqG7HCMvWhtlv7toSom
	 LUUqcN7mCVSWw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, 
 Gautam Menghani <gautam@linux.ibm.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
References: <20250710235126.1086011-1-irogers@google.com>
Subject: Re: [PATCH v2 00/13] Python motivated fixes and cleanup
Message-Id: <175247014620.2439485.15132380175284657909.b4-ty@kernel.org>
Date: Sun, 13 Jul 2025 22:15:46 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 10 Jul 2025 16:51:13 -0700, Ian Rogers wrote:
> Various fixes and clean ups done as part of creating the ilist app,
> the v4 patch series of which is posted here:
> https://lore.kernel.org/lkml/20250628000929.230406-1-irogers@google.com/
> 
> These patches are separated out to give something smaller to review
> before adding features. As requested by Namhyung.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


