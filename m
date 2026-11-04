Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825941;
	b=TT4ArWpG51dObUbEOXDNS+pl6KdsDvfMQP9IcXSXSvIndqwHQcxz/idvmuNJ7XKpyzFF
	 Dlm8nwFx704mjrrU69R1+gL3+jOHtr59dUyOrXxRf+HlToJBiduvL0Xi6oo4ylpWqrhIL
	 SN9SYqStcinbE5qee2X5rGbaPBpebrKCD4t+l94zb7y5FGSb3jCjwVk2H1igEV9s7AzPc
	 7X6gdtw3Hvv1bAYau3lfYsWsYJe9IvA3miAh/1CEs+Qu+bvN5/5SOciDqVRqgCMg/u3Fz
	 ACBUhfJhXuFrvxQ1B/YpQn5wgTku/7CPB0FHpD2kXpuwdsBrP8+U7wBKl7jReaVTO6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825941;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=68FQQXsoJksoeoLSDrKS2zwovVFM1JhIN0EjI4tp+08=;
	b=wsSGaA3HOGuW3E+Pg1faqjz5Am72Bga/wMc5Db7kwJOgAyrkKYT8Z/kkViqGWhrNQD2Y
	 bh2JrjvKkFJk5NCqLqE9H/xUH9PVRdEM6zsd57VOWuOOFdVv6Cv/bkPQ009U9x+ROPj5c
	 6TUBIexlMnuGBKuYlKNPDWvbf5rq3QIpneBQ99r1UEvrs8OOxyiaeh+0tnuHST4zbza5R
	 /R2qkQjPae5qbffyrc0+B4pIeORvh30/Tq/NARPSep1+YRVpzpJTdxF8hGx3Bz4PtCKMq
	 8Dqbb3j8XqPFgGL+Hsf/HLNWx87265GzGHuosRMpgCG3rd1O02YDO4EiaiEYWeyT9pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRPUjx8Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AF606C599;
	Wed,  4 Nov 2026 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SRPUjx8Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643811F000C1;
	Wed,  4 Nov 2026 20:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825940;
	bh=68FQQXsoJksoeoLSDrKS2zwovVFM1JhIN0EjI4tp+08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SRPUjx8Zy48vSwkkaX/POKZ30Re+UiT7fzDFUOg6XDpSdch/779uWITaYR++cIW1t
	 Yznj4/ZzvtLH3vrEYIF2RFx4aitSQxeYlD2lUaHQft6lRa0zEUiSROPPWGq6sMQ+i7
	 bzPT33Z5UOQHtpU9RegDhicrFq0frj/EaOP+pp0nr5iG0PyAgn0C52FmXdv/KYRI9J
	 bNCpdCwj64zRjhZZh7qORt3ph1rsYndYtAWqE1QjKrRJ45qcLIBkds6gz67/irrjAZ
	 pCdn+yEPv2rBJJHooDTVLQgbo9paAfeD553vL/zGB1k0IspviixUrWCR5BUBMJBmKg
	 UMTKkG/wnmLmQ==
Date: Wed, 4 Nov 2026 12:58:58 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] tools: perf: allow opt-in "no-dso." files in /dev/shm
Message-ID: <auuckurvVVn0YXSg@google.com>
References: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>

On Tue, Oct 13, 2026 at 02:38:41PM -0700, Stephen Brennan wrote:
> Applications can place JIT-compiled code in POSIX shared memory so that
> multiple processes can execute the same code. On Linux, these shared
> memory objects appear as file mappings under /dev/shm.
> 
> Perf uses /tmp/perf-$pid.map to resolve symbols for executable SysV
> shared memory mappings, but it treats /dev/shm mappings as ordinary
> DSOs. As a result, applications which provide perf-map symbols for JIT
> code in POSIX shared memory don't get those symbols resolved, while they
> do with SysV shared memory.
> 
> It would be incorrect to classify every /dev/shm mapping as no-DSO
> memory though, because /dev/shm is just a tmpfs mount, and it can
> contain ELF files.
> 
> Add a filename prefix "/dev/shm/no-dso." which is recognized by
> is_no_dso_memory(). Applications can opt-in by naming their shared
> memory objects "no-dso.<name>". Executable mappings with this prefix
> will use the perf-map file, while other /dev/shm mappings will keep the
> existing behavior. This allows applications that already emit perf maps
> to use POSIX shared memory for JIT code, without needing to implement
> jitdump support.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Applied to perf-tools-next, thanks!

Best regards
Namhyung
