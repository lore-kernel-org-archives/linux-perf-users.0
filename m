Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF8262A6;
	Tue, 14 Oct 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450594; cv=none; b=eHmY69AJWagn/l+Q5sz7fDc6aoUurCH4wIpgPP5YHeGUXoNMq6AhBLy6RsrrZpqP+5SB++yE3v1F5u+6iOG7M9YTziNWaaKO+p7J3IKDb+M56cjKxYH5//gaDK2gXt6fKtoejfH5GSSNtIh5d4DW/UAcOVHjN8yph7n8Zz7LO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450594; c=relaxed/simple;
	bh=6vj6tgMuzAD9VpM4zcc1cbIdK7/9JXd2aUyjU2+31io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueSrv++D5FbIso0wtTbK+ajYcOol1C0zNiAH3Ex9zUcrxCTcwCKP6pcFu+77bShQa/CJliT1Gxya2tj3FBaIyNrRPXsBHs8g4kWqx9bzlXax93G9vnRXe+4u10Fkqq2U3wdMheBLK4dngHydBkbMFjpeDEwU15L7743YDnhjyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZuenyGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZuenyGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47491C4CEE7;
	Tue, 14 Oct 2025 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450593;
	bh=6vj6tgMuzAD9VpM4zcc1cbIdK7/9JXd2aUyjU2+31io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZuenyGO7p1zUsmLfzaVhiv+gUjmRqkMFSMxiShwW3Nh3Hnj3e/aiiqdji24QlpmV
	 Tlr6ogPOvpVkBPkOUHuwZxpQzkPZlI7Ph8uAz0VeTXtNRG4LK6ntKMEIZ2R45viGE6
	 WaXGDT5ZWOCBL6PXxU4IFhH084Odbx/hdknKw6MUtH8V8whtFC3hFDGmuCPzIDdIn6
	 ievlMgKIaRnUeWMdU4ER85ICKpWgdO5AFtgPNmX3JgSxMvgc6lvH0EajgFZ0uSTS00
	 mQH4s4LiYpMb7dLxgz94ZitwnUw/SLTD8Ul6ayTbf9U5FsCu46FcLnvB1N5u+X7uHI
	 lg7i1YY6X1sqA==
Date: Tue, 14 Oct 2025 23:03:06 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com, acme@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tests: use strdup() in "Object code reading"
Message-ID: <aO5YGpR8nZzUy4as@google.com>
References: <20251008124201.875919-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008124201.875919-1-james.clark@linaro.org>

On Wed, Oct 08, 2025 at 01:42:00PM +0100, James Clark wrote:
> Use strdup() instead of fixed PATH_MAX buffer for storing paths to not
> waste memory.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

