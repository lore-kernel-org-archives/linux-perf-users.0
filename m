Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377050;
	b=TQl43tpenkKAY4tEOlEDSLXJkTyCyFi13tP8zMg7Pnp7s7HoZd7hdSYCWAq7ZphwnpWw
	 ktEevK5Z+W08wp6Hr9NH5UvXppLFDymkCy0wqH1w+HMx9VmjSNr1V3eJDxnGRpuETG19K
	 7Qk+1++zG+VRwXOxDe0hgi3c4QW9a4AGzKzfBzgCcTiWjGR2ynKjp5jNxxAPclXldy0RW
	 5koa0l4iy6XKl7QZvNNWVo9lIDGZNKe4G/Gsi3P4Yync/1RBEdb1p28rArDrjxOMUb/yy
	 ivMYC/Kz4UzLlpOv591V1V88dIiRYlsmZXBGn2765GEkV0xlKMI6UGIZNr7Msx9Ec0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377050;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=QVF42TBUWpgRLvGNbT0DcKY1US8bNGorw18yutx3ZNw=;
	b=XhGbxERBYvYMoOvDPQem3xygyJEMgygEXp428b8cjrkLFLUxB9wyDdU2u+Q+jXrolSSH
	 ywDGAUZMUwdWpS1KgB8FP5bSlXqu/ZgI2Q4OU4fmsEMc4OO23VEBABIYN01HQGhyqFi+z
	 +If4ZS05s1blZfycgZOE00woIksfs2c6YJsiD38g5xFlQfElPwYIn5hlrNbqCaJufLYRX
	 K1PaQyohi4Yt06TqtehnmG6oxlfDu3GahZxu3IsyYykd3sz9/nOjkxUTpCksHlbpOwUGg
	 NObQ7zXXfa9WF7mYu5Qq9o9VVM/ABOuOls/UaueMndQ+kwqLP36JXgYfFKO/KmhzYJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5fxf1Qh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E2606A320;
	Wed, 11 Nov 2026 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H5fxf1Qh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506FE1F00A05;
	Wed, 11 Nov 2026 06:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377050;
	bh=QVF42TBUWpgRLvGNbT0DcKY1US8bNGorw18yutx3ZNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H5fxf1QhH8eu2T0aHyXr+vZHP5xwB9VfAu/BXy1pavlaclo33MxTKfGFOUb6W+Fs+
	 LVZuwk5iV9VzWUIotgFbvHnPWYxVqqnFEMRYSVACHXa0xrawMtg3H6QCrwLPJ9UBlm
	 Jm9eSkV5JkgL2ccG0J2k7SnJJ5odxvDfonW9wevZmJVUgxRp/ucWS4PHvyEN69jnBy
	 OlFn2thNGreBxV85LofB8QXLKvyTg7mjS0d5vcAI/6XBTRIYBcMCMg0eVZdV1u95Q/
	 c8xBLcrNpW+c+F3JO/0d5B5QeyugV7gPYy6I5fOLqJ5Q+AS7p71E0VWbud3rv//WvL
	 hrUnVgoxH/Lxw==
Date: Tue, 10 Nov 2026 22:04:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tools build: Fixes for libbfd -lzstd dependency
Message-ID: <avQFWPoQpqA6MeTJ@z2>
References: <20261104043006.1199857-1-irogers@google.com>
 <CAP-5=fVJfHEt1NTJg43tyGoQuJO4AgBaHzBZQHN9fqPef7i5=A@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJfHEt1NTJg43tyGoQuJO4AgBaHzBZQHN9fqPef7i5=A@mail.gmail.com>

On Tue, Nov 10, 2026 at 12:54:09PM -0800, Ian Rogers wrote:
> On Tue, Nov 3, 2026 at 8:30 PM Ian Rogers <irogers@google.com> wrote:
> >
> > This series addresses build problems when linking against static
> > libbfd/libopcodes on distributions like Fedora where binutils is built
> > with zstd section decompression support (requiring '-liberty -lz -lzstd'
> > together).
> 
> Hi,
> 
> Namhyung/Arnaldo, could you help review the tools/build and tools/perf
> parts of this (patches 1 and 2)? The objtool and bpftool changes have
> Peter's and Quentin's tags.

Can you please reply to the bpf bot review on the patch 1?

Thanks,
Namhyung

