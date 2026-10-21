Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619310;
	b=ZUSDAFsUrvygHGba5ldDaUWJcPvNNHUtFpXvbEM8zf9qPTgnccFQr9hj1PHTqzdEr/Hl
	 wT3DagzoJ/+5l2ICEY/i5hIqbecvDwUyevyjpJsY4gQc8VK/hg0uYLEXdAm6Jcf6SN2iZ
	 YLuhOz2MoTk6dbwYGV6nO14rU44puTtx2JNzQ/uhdtdg9UazP3Tbu20l5jYNzALDtzD1l
	 qZMzEfQkbOAGiD9wmH56LtYdOp0Z+eYeu8P9F5fr19XL/tPTh+0NwkXVB3dcBtnMRdOxE
	 gWEZq5FLr98raAB0QleZkNS+cmxdlvh2Q2ZmdaDiVRtiKVlhUNdHb8HAbf8f+E/mDEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619310;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Lmu5YQAfpScGwvYRrddBHguYn8AYmmgDkAsX6xsNidE=;
	b=0Syyzu9v6dDbwZ/nTRiWoKgXdqpliHm+xh6IGJmE3Wunv6RmnpYQZpNTd7crc8L/6/eW
	 bViKY/eYPlswlasJzXtgDsnor5F1cnG1FJW4DWp+1XhI1/th1Q966xwCNYXY6dDakRNoR
	 n1mdggaHnVvpxBifCWQ3JYqC8tiYZ7aBDBR4TTOPtJ1UnCgC+If1mRSC7K+OHLmTgKMf+
	 7N1WC2wYonUlOF31bYrhQssG8OlsTeWvbglDe1O2fJ8kUfu2UN3IAbRBOhczqo2p1Mf5o
	 GsPaLkXitzfsa52HO4MQYWDicy1LMWL5CdDnGFNg3Xa68Hd2lxNua3hUUvgdfetONQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZUzB7CK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3906606A319;
	Wed, 21 Oct 2026 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZUzB7CK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5291F000C3;
	Wed, 21 Oct 2026 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792619309;
	bh=Lmu5YQAfpScGwvYRrddBHguYn8AYmmgDkAsX6xsNidE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KZUzB7CKylW8wqcHz3mSIYIyShZ0UkVuG1QG5iEr3o6PsFD2WoT1EPzJu7GhRFNpm
	 KZS/w9OnhP3iU7aKsxyP4Fr/4unp9P3vZTekdVI8GBiOIzzLeSuqeyp6C9EfwoWpxZ
	 Cb6WBhhOHu5vlgfYLux5n7ZyvcMONpf3mAWPctUMD+QIPN3QWNOrAcwkmazJ1WOHcn
	 83+UwYvulVet+rmKjnGBI+TdFfkPAVmYlL79tgnO1A24/7Su64ugqVrdNcY9DHIasO
	 M8FIjaa6SFxQCWfFKNaM4UMLSZn/dbSwTmiwgIYH6Fu6knM/WLalBlcxZyqgY9HLjS
	 +wVuwWxOUI1pQ==
Date: Wed, 21 Oct 2026 18:48:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
Message-ID: <atkzKm_TPnhyzgx3@x2>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <atFdpZG-b2JPS1St@google.com>
 <8fdf2566-bbac-4854-8faf-0276af5f936e@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdf2566-bbac-4854-8faf-0276af5f936e@huaweicloud.com>

On Fri, Oct 16, 2026 at 09:18:38AM +0800, Tengda Wu wrote:
> On 2026/10/16 7:11, Namhyung Kim wrote:
> >> Please let me know if you have any feedback.
> > 
> > Thanks a lot for your work!  Assuming you'll fix the issues from Sashiko
> > in the next version, you can add my:
> > 
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> > 
> 
> Yes, I'll address the issues reported by Sashiko and send a v8.
> Most of them are minor, and I'll fix them accordingly (or explain
> in the v8 thread if I think any of them is a false positive).
> I'll carry your Reviewed-by in the next version as agreed.

I applied the first 5 patches that are sashiko-clean, will push soon to
tmp.perf-tools-next and then to perf-tools next after test building on
my containers.

Thanks!

- Arnaldo
