Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE451D2B13;
	Fri, 22 Nov 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313871; cv=none; b=K/rG1mm/9dr7a9K0KZzOjmFv5gGyDu++6QV4koqmqPLKELlIzWaZS/VaBskjdd6ai45qAh5hQAzJXXUW0qw/jgAE5wbHIeOly8hboYgKRZQUB0JvBSk1BI+mcIyDxNMwNi3eW6QYjvMF736hxVsW8UiEze8sAUsxfVzGzkVUWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313871; c=relaxed/simple;
	bh=e8PdmLqtMcgq/6C2vdHnmcRNCtMRORpWi5m7NmPTBWU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J7cbiYjGNfs7X39yW4btcgtOhZIEhuuB+EhAXJx8r1JpagDicbcGO9hJlokRGxwEE2dOG6Q0Xll+XhOBbRO3Z+aXW830g1i0R8VrgWwbezgedgovB/jXcgIzYDuOi8/I6le6vCRmGABlJ/C5rjIoexmhu5JbyVYOfqkiZE8QjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6o+pV3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6o+pV3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093FC4CED6;
	Fri, 22 Nov 2024 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732313871;
	bh=e8PdmLqtMcgq/6C2vdHnmcRNCtMRORpWi5m7NmPTBWU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=d6o+pV3lzEZbKK6kZxoD4A98ODnckZSpbPUmVqhisA/zwveWIKvWobNbrkiTqutWt
	 FeHjxEVyfa3ks4yuzMrArkEZ378oS91a6qP4P7Oh/QAdracflJJmUN/BAbPNuJUewg
	 yYlQ2QbAEPHwRK4LHjlJqsePHXImM8SOX+QCCNZ2u2gp2MIziN14/5FBswMax1e2bU
	 qJWk/aip4hMwqsZnCjs10ewejCgPVxNgrIvLnQPuK6nMI6EYRoCamLrYQElT1eTSE3
	 Qw37obaU2jRjEhUTIiyLQTwVrdNjeoknNrb0Dv2Sl+QXoYgp9i8b09jxHAjMtKaq0u
	 dDHxLIeJzNOLw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241119230033.115369-1-irogers@google.com>
References: <20241119230033.115369-1-irogers@google.com>
Subject: Re: [PATCH v1] perf hwmon_pmu: Ensure hwmon key union is zeroed
 before use
Message-Id: <173231387067.85365.10914157353769666187.b4-ty@kernel.org>
Date: Fri, 22 Nov 2024 14:17:50 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 19 Nov 2024 15:00:33 -0800, Ian Rogers wrote:

> Non-zero values led to mismatches in testing. This was reproducible
> with -fsanitize=undefined.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

