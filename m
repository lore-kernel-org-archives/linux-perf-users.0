Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BF9463
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277136; cv=none; b=AkKhAGrCc05RritDV92wD9wcb19b+R2/EtLEfeH+LepmMpwlptmUG5Di+wC3/Nxs9/PelanBs6ilGYeLpaM9lk75ZmylxaQlbT4x9B8QEZ1fh+hCZ9zcXBqq4LhR1mG09FsiqQX1S2UeHcOpGLbht3todSY96StMZWcrLfGAXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277136; c=relaxed/simple;
	bh=a4sO/x13cy+ur9tShy5ydNUY7od1qFXGLVqKn3Du8Eo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kPsEwRqGm5TygwygN2e/hNdqKJB0/u1MvXuMlVjrwAZIi3mmhyZq86LNnW/6bN0gpkBwzVz9VpR0m4y7bdXdU7W/jS6Rnz3RdZ3kNf/AfVGeJsnc2rSMznR3t4wTj2mdogEAO8GI29DqGLiFoWQV1s40quLKu1CFw/VQcNtd72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+/cUj9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+/cUj9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A508C4CEF8;
	Thu, 27 Nov 2025 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764277136;
	bh=a4sO/x13cy+ur9tShy5ydNUY7od1qFXGLVqKn3Du8Eo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E+/cUj9AZBPYsm5M9YFN9shSz9t9xz3SOrkEvbu54UU9sUuqsAOxgRdze2R3Fe4Jw
	 M+b8JW+bQWu81gfG2ux4VWTRUBBL8rivB8JWeEfankWh2mE3HlcjJbH8fNgZ1+Cv+7
	 +6xmsMdpRHYEwpWpKE7qj/JJstnwZTedkaM44dKoOVepcS6dItgQ1EeIg0OiBWmhOQ
	 BDcfkLI1d7EDjpVd2atAye8lgyaLY5keU4uIAIMRjLJVdvQ1Z3IYcqRZqlfEHJqMPa
	 qIRFAOdVdcL28AiIoZN9FVikSIPjXK+g6knYakUCIB8ltxlvv4ktKcEerL0e9sSgEe
	 cw1vJN/o9Fh1w==
From: Namhyung Kim <namhyung@kernel.org>
To: mpetlan@redhat.com, acme@kernel.org, irogers@google.com, 
 linux-perf-users@vger.kernel.org, Anubhav Shelat <ashelat@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 dapeng1.mi@linux.intel.com, james.clark@linaro.org
In-Reply-To: <20251125114118.196089-1-ashelat@redhat.com>
References: <20251114220547.496562-2-irogers@google.com>
 <20251125114118.196089-1-ashelat@redhat.com>
Subject: Re: [PATCH] perf pmu: fix duplicate conditional statement
Message-Id: <176427713507.3725736.9636827039100435192.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 12:58:55 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Nov 2025 11:41:18 +0000, Anubhav Shelat wrote:
> Remove duplicate check for PERF_PMU_TYPE_DRM_END in perf_pmu__kind.
> 
> Fixes cedf1f4852ae.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


