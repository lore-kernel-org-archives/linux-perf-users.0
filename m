Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687024336D;
	Fri, 24 Jul 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872077; cv=none; b=ivzRUgpVCekKgQjYEwlpaI7iTLo/9MNJ36rx3uuMONZsBSgXhS3Pmw6xE9kbFkZi2qDXILPLLltZ5HVfSsA6OqQDQxqputjF1VRbyNrvG4MmQAXa3MYAEJ+44wJ84373jjfZXfAnY2jDM2IcyDzerB2dJ74aIE1EqYlSBEKhbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872077; c=relaxed/simple;
	bh=9S6t33Kt/s0SKnuZez3a2frufd5qLytCC6Ut6pkY8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLCkg3m6HOQVroBMz+A5BZ+KaCMLJU0T7C8Y5s01UKjymJzvrjua/rZUzA1n9d4Ea7R73wvKbPB6o++/ru8gvTBOn/bxkOLToNufhH8bsAhFdfyVUHfgNz3ujKg+79v8rx+jUTUkQo/jQQPZdWEy2e/oOVDb0kajlBa2Cl/ynHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOLcE+Pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOLcE+Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776451F000E9;
	Fri, 24 Jul 2026 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784872075;
	bh=5c6px/NKFl5ekTSD9oL5y9dX8xFZLK9PfF82fPvMeqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOLcE+Pn7gOU5c+WwlHYbTgEkAtbfHmsWQYlXNo5+J7z1NuVEGjWHBcHS/Cbs4ZUh
	 h6TdrXTEmwttJrSTZFJuTBeWZ3NsQ9WUNHKF5h4+zlmi9lyXnAKkOp3UkcXb21dLD+
	 3p8ERay3XmH1JcP3W3n1fZpGPuklYyJA1gbdTxCfAfsAoTsb4M3f6iOZ8YvkL0JdAR
	 UuaeMwYTGoXK7SPjB82LNd0FP0fmhtJHrf4Ziku4gmCow+wsgXlL/EjwhcJiyfe8md
	 P2Ov8ipTeiQr7vxjzYJxcTgoQDHpQmhFLqwebYPuYXj++bl72zkeVQacrX45lwffCl
	 vpieq85TOHWtg==
Date: Thu, 23 Jul 2026 22:47:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, abyssmystery@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3] perf cap: Remove used_root parameter and simplify
 capability checks
Message-ID: <amL8icNhBkZvTzEB@google.com>
References: <20260716074028.568999-1-irogers@google.com>
 <20260723050640.992865-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723050640.992865-1-irogers@google.com>

On Wed, Jul 22, 2026 at 10:06:40PM -0700, Ian Rogers wrote:
> Refactor perf_cap__capable() to completely remove the used_root out-parameter
> as requested by the maintainer. Relying on an explicit used_root boolean
> poisoned sequential capability checks (e.g. failing CAP_SYS_ADMIN checks
> poisoning the flag for subsequent CAP_PERFMON evaluations for unprivileged
> users) and created redundant complexity across check_ftrace_capable(),
> symbol__read_kptr_restrict(), and perf_event_paranoid_check().
> 
> Streamline the capability API to perform a pure true/false boolean
> evaluation. The function checks the Effective set using SYS_capget; if
> the syscall is missing or fails on legacy kernels, it cleanly falls back
> to checking EUID == 0. This perfectly preserves modern capability-aware host
> sessions, guarantees transparent fallback for older kernels, and correctly
> rejects privileged operations for containerized root processes that have
> explicitly dropped their capability bounding and permitted sets.

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

