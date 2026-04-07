Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11F3CBE9F;
	Tue,  7 Apr 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576815; cv=none; b=V3m3VwQRE4GEquMKmkM8JIbggX4YCQLdvcE0eTEq1Y7WqW38ZlCfeFC68b99TlJGLwOgqEgSNTgi3C9j5AAg4SUz0WCy+EMvigKnErdl9RNda2fmZEplGM3r6EaECJZUQbDrUMMxs0RFL94GHGUNsZULSZcoeJb+D2znegKzA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576815; c=relaxed/simple;
	bh=kzrFuta6aAlyM9AC+a86T1/0BzbNjSd+fqW9MS1+b50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh2lN/eYTTvbZAaqE3p3RynKRLg+fqhC5qM/EECQzsTh6VLzNJJQUPozE+uT/CT/F/372LuHQf7dcJYFXJ+/G7L/nL3U7/OXelS7B3TK2SMAg+i5g5Pxd8OK94baXk8+VsosMaVenOZqacu6RbIZXcsZii2WY0mWkk2TCQjgCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DdcSG/CB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DdcSG/CB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 742A114BF;
	Tue,  7 Apr 2026 08:46:37 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4A843F7D8;
	Tue,  7 Apr 2026 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775576803; bh=kzrFuta6aAlyM9AC+a86T1/0BzbNjSd+fqW9MS1+b50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdcSG/CBIn49CNcvnjc3toPLVVbSOVDt954Skq6f0hDXxt8CMSOrIi/28v4Tpu0dz
	 4MbRvrVRRTL0NtjkO98OQiQ3jiagpz/gV4ZVHcQuTI/UrmzqWysILy5fqYFR8RQDkr
	 rpqMu6Pc4J6vJ4oq5QJf869wWmUHayJYYJstIKhM=
Date: Tue, 7 Apr 2026 16:46:40 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] perf arm_spe: Print remaining IMPDEF event numbers
Message-ID: <20260407154640.GQ356832@e132581.arm.com>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <20260407-james-spe-impdef-decode-v2-6-55d3ef997c48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-james-spe-impdef-decode-v2-6-55d3ef997c48@linaro.org>

On Tue, Apr 07, 2026 at 03:05:20PM +0100, James Clark wrote:
> Any IMPDEF events not printed out from a known core's IMPDEF list or for
> a completely unknown core will still not be shown to the user. Fix this
> by printing the remaining bits as comma separated raw numbers, e.g.
> "IMPDEF:1,2,3,4".
> 
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
