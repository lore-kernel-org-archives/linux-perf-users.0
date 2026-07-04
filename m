Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE93A4520
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Jul 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181464; cv=none; b=uZ+SSHdlCVuZxcn5pe9pCHVw79LXWjtAJ1tibvh3I+tnKmvs1OUYp8j/udgC3tZFseQ3Ee8lil/O/5gc1Fsge2glXzg2GiC5D0CI86asMopgg7SXfFCzcp99WrLHMDqvTMvKAuBvSLML04KnjQaIcEpUhDzvsD27c+Vtv6uLnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181464; c=relaxed/simple;
	bh=/tXK/kuXuQJCrVdyfsUbxmVy7A6wl/+JLCsNx8LV6nA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jE93QTrrRkgeTLIQsOLwpSkQhamX14YlV4yyLTSsApUX3b5IO72u5Y4UZZRdpPqH07dwTMBcRJa3+4FRn6xQfOF6JZgaD6G4aKjFvj7ecxm8rX3NwyA468VSrvc3dQTJIVR8H4k/0W9310vAs82syL+NhWeocG+ZEbUHWN2lkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYAHUVAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYAHUVAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A297D1F00ACA;
	Sat,  4 Jul 2026 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783181463;
	bh=QwB8FGCq3eCoQl3SKVpOQbv8DuiqoTDev9lDz7Av2U4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oYAHUVAoFAGAcpfKtqekWqpffNDz+hwxnk5I3Q1D+I8295A3l8IX0I8eeft6zARIH
	 nXEMMi2/E8LXi0/uhHWh5ka3UTZjKQtAA8TrMHetqWarEX7JD7XJ+O6sPWOWfiN0QN
	 q5bgZqHULAuBgC8er0u1168POq/OWw8AJ+C5zM/uC69rSbeyzFjNXUSSQJ5VYQmgbc
	 xhS0detE1cmPOPS9UCv9o2m5+yFf084VPqSQoamEQvQOkNvv860gUdLhaml39nbHcr
	 1DU7HB8ZtzNbZAVo/zFFfhISkIfWzELg3koSx2NrrOa8whM8t0mgKpKgJ/VccbWL3A
	 EAHl58FPpeewQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
Subject: Re: [PATCH v11 0/9] perf cs-etm: Support thread stack and
 callchain
Message-Id: <178318146263.1194818.17858862135868990368.b4-ty@kernel.org>
Date: Sat, 04 Jul 2026 09:11:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 02 Jul 2026 20:51:35 +0100, Leo Yan wrote:
> This series adds thread-stack and synthesized callchain support for Arm
> CoreSight, which comes from older series [1] but heavily rewritten.
> 
> CS ETM previously kept last-branch state in a per-trace-queue buffer.
> That effectively makes the state per CPU, while the call/return history
> belongs to a thread. This series moves branch tracking to the common
> thread-stack code.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


