Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378539;
	b=XmmkPo0KwHwyJI+GwmA513x4T6jk3MFw/y++zB9k95NPgQBMbVSs1abKpyrp83fErCNZ
	 LLtZdz0JCX9h8kDOIdHgznQz05dBNYq+s4ULwKX7l3N1PPLX3UoHquILrvobHlqVdmq/T
	 /oYZC98mMaviPaTlWj6jW1lRDLEkxWRpmM1PZleSqFMcJBSQINFkgOvp8xZ7Jn7r2O4cW
	 /h8qBAiJ0ZvAuAp8Olbbcrw7rG9WXdb6m20lUTnqP+LZeCujq25ALTTuOs1no9nFFzFzx
	 6WOFfFU4JytD0SHss5vWznxXBXWbONeQ3sQgqoepWDIHUFcE8zw7igifZzpe+TyA6Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378539;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DVQhGbTZgIPtd+eX7z3bPGipZ1TFe1EBBcrqYJed8to=;
	b=aEl91jW/UWrUhCbK050rHcxNjBA2xszt21kHmSBPXuFk0N/DEVLGylBVxClM9/W6X1vz
	 hb4sOlAmXbwwIqqc/JfEE5JO+duHIEUyTqgjDSO8dnIVeFr5RTTIpSWPwwfrmryINYAgA
	 8UmoTjzSAOsP8NORcAKaFvi8srP6VyCyRM1bh9t1vbOjnJZ+cX6zMsYL/rgRMinG0VtVK
	 1exhMPNmyh7Zh+ZPG1gBSeOxszrgGhAKL19I3ZuxmTA1pq7yYEE3m8dAILkqgLriIleKd
	 5uv1JKAJVm1JKaj2IMa39DcqTnL0kGLukiwcJLIsG5AaR15GZ8+C+iv+9PkcNKOFIwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCZ0sWP+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43F606A338;
	Wed, 11 Nov 2026 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCZ0sWP+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FD81F00A08;
	Wed, 11 Nov 2026 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378539;
	bh=DVQhGbTZgIPtd+eX7z3bPGipZ1TFe1EBBcrqYJed8to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GCZ0sWP+IC0QMP3CX0DWjEK7cK41nEq7wasrRDxVgnc8pW9jMtDOU553Xn3Xdn84V
	 m7TxBc0QvHh/FXxOm0iyoV66JW7/n0Nw7as9scxwVBdRxTe84tuWKSlLwnLE8zvyEv
	 tWrzqQHmF9XpzVeJ/Jdjp8+kwwABa46VmqmE5QqP+4wq+Xdzl0D5UFOGj+IvpC0e98
	 2qPwlJkFufSAO2BBQB/Qa4diwrK6UZ6BQn77WPMgHZiEksJjUR1BGtEy/Bg3aP1mD1
	 SlKfIPjbjwiw60ma9h31V0CAAiqdek7WB10ncRkiBC21DbDG1X892GS2bOVIz0qXT+
	 tEQ7uL0hqypug==
Date: Tue, 10 Nov 2026 22:28:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Message-ID: <avQLKYycwzv68fVf@z2>
References: <20261030192537.3079368-1-ctshao@google.com>
 <20261110032240.3080302-1-hang.zhengyang1010@gmail.com>
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
In-Reply-To: <20261110032240.3080302-1-hang.zhengyang1010@gmail.com>

On Tue, Nov 10, 2026 at 11:22:38AM +0800, Hang Zhengyang wrote:
> On Fri, 30 Oct 2026 12:25:37 -0700, Chun-Tse Shao wrote:
> > When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> > JSON output mode (`-j`), [...]
> 
> Tested on AMD Zen 3 on top of perf-tools-next 13a8d580433a.  With
> '-M l3_cache,data_fabric,iotlb -a -A --metric-only -j' the metrics are
> now on separate lines labeled amd_l3, amd_df and amd_iommu_0.  STD, CSV
> and aggregated JSON output are unchanged, and the stat linters pass.
> 
> Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> 
> Two changes the changelog doesn't mention:
> 
>  - Without -M, 'perf stat -a -A --metric-only -j' now prints two lines
>    per CPU; the first is labeled "pmu" : "software".
> 
>  - Plain 'perf stat -a -A -j' gets the "pmu" key too.
> 
> Are those intended?

I believe it's intended and looks fine.

Ian, are you ok with this?

Thanks,
Na
