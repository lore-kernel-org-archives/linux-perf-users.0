Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B2339A1;
	Wed, 12 Feb 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324342; cv=none; b=XLWPTGmBg1o3WZfiyDz8WEksEqOb8b4MumabUFYzOaUu6D5PzneJ+reAqYGe2d/eChV7Mq0EiyyyzV1lYFPPLWNnYuiTeqdPJ8UtVYhtqwR4ASFvfSqK92j9E/30RRvHyAvUgRdfZP+QZZ5ZsFU88vksqxmsoIo+nBV3lTtGWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324342; c=relaxed/simple;
	bh=zn8Homa3c0q2uLydqxaixc2tgtCYpbraDYIjjk6oP1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rG4x0Wt9kLbGLNHQKJ5ZeCwp4eWEQTRUUjXIhTtWW7j4Mc9Bo/+U7jR0Qv3GVSgjSUihMHWAX8DIDFuuLoHafNtQ3aY4FHOWf1J5tXxb4UScwga3rbFXSW+BSuY3pi9To+KfAwqMPV6PP+ZB5M8o9+udBTgMDRFX+p8usBQzqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCYv9/Iv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCYv9/Iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFD6C4CEDD;
	Wed, 12 Feb 2025 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739324341;
	bh=zn8Homa3c0q2uLydqxaixc2tgtCYpbraDYIjjk6oP1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VCYv9/IvnXOlYwDCRD8lXMN/h1HaIy+7xd3NfCQwgu1ugC0FTwRWzkcSH+9aeVcUA
	 fRoM8tHiG+Ti3fj8FLA5jaGfuZ1wNQY6OXklGqoIw+ookqWPtvexD2rmY5mqjhx8D/
	 FUDFgBBUPr+9LA3KDEUXu2IK9TGshboprbKMecPfwkhCq4aAwN+A0XoKpWiyDvTvpR
	 1mdjykOy/nGOgqNLPjXLpWDdL2oQKqcRicVT4FvVcn/4SWJAhX/e2m01tjJbsX3EHB
	 A9L+CPceQSOGgolwABY8K1DWchE5tsFj62gC8WPampW5R/5/4hv9Q/M5bc8aM9xO0o
	 hQzBZCJ95kTKA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, thomas.falcon@intel.com
In-Reply-To: <20250207152844.302167-1-kan.liang@linux.intel.com>
References: <20250207152844.302167-1-kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf tool_pmu: Add skip check in
 tool_pmu__event_to_str()
Message-Id: <173932434120.264355.5544623069913990027.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 17:39:01 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Feb 2025 07:28:44 -0800, kan.liang@linux.intel.com wrote:
> Some topdown related metrics may fail on hybrid machines.
> 
>  $perf stat -M tma_frontend_bound
>  Cannot resolve IDs for tma_frontend_bound:
>  cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)
> 
> In the find_tool_events(), the tool_pmu__event_to_str() is used to
> compare the tool_events. It only checks the event name, no PMU or arch.
> So the tool_events[TOOL_PMU__EVENT_SLOTS] is set to true, because the
> p-core Topdown metrics has "slots" event.
> The tool_events is shared. So when parsing the e-core metrics, the
> "slots" is automatically added.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


