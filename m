Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740442045A5;
	Fri, 14 Mar 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974222; cv=none; b=thD1/ykblT3NbDITm+SjEDn+uakWvI3CyveKVmPPF9PYuVFJwrOvZ9e8pfmFfPF5DgnlQ15Ttl1YRKMY5OotT+zk9fZdza4SaqhpUqeDQOmt2qSw6YWoSrd+0pAmrpnwnCDS0U91I4BuD0hzdMOKu3rpO/uHvadzKkZyUrYkFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974222; c=relaxed/simple;
	bh=OuqUNRtR8Ao+B4jo0qU03e/ijy8C0uzMm2+jHF4asMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dx6tiJFVveHcwIVH5UTMLBv/1Z3T4e71dhzAV+bQvWYY9DLy3XF8HNVWTb64ErsineXLegLoi52k5QdPLclIbaqEhzOnICeaAPXTELWJ3VqW+cKLhrNoO/wG4sFNIKQ4/+Xut5VEVHObbYTufRAnES2zzSHCFdy3ZLDxJgSX7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci+ncNus; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci+ncNus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ED9C4CEE5;
	Fri, 14 Mar 2025 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741974222;
	bh=OuqUNRtR8Ao+B4jo0qU03e/ijy8C0uzMm2+jHF4asMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ci+ncNusKJoXs/fb8AJbPROy3zae483imTY/Js+n81N8zgAZ+NkAtWDlu8Mu5ND4x
	 Nvrz9sTOcoDOFJJ2TDEMH5rWGmjuXMnTmnRzEba2O9gFf+HCDR/WN5sNPBivEW5Qm2
	 9RZSDFPx1iBVlqkbF4WWs1gDuWccM2+1P74SnDubu2jk8y107arFbOj8v+X8iRWtVF
	 hN+MhIw1VtNNjfWYrMOZ1eVdu2FkrxUOlPt1SmeQQ9JhPF9lvvLEc0KUr/A8/lHCbP
	 jXEs6VbwG7NbMP7Xub3YrraQ0ME/ZdG8e7nl84bgr/m8NhpG1EvEwwZWWUFlc+bPxW
	 xOCMGNWwQ0o5Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yujie Liu <yujie.liu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
 Martin Liska <martin.liska@hey.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20250312072329.419020-1-yujie.liu@intel.com>
References: <20250312072329.419020-1-yujie.liu@intel.com>
Subject: Re: [PATCH v2] perf script: Update brstack syntax documentation
Message-Id: <174197422150.4059945.13925183129838797579.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 10:43:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Mar 2025 15:23:29 +0800, Yujie Liu wrote:
> The following commits added new fields/flags to the branch stack field
> list:
> 
> commit 1f48989cdc7d ("perf script: Output branch sample type")
> commit 6ade6c646035 ("perf script: Show branch speculation info")
> commit 1e66dcff7b9b ("perf script: Add not taken event for branch stack")
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


