Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858E267714;
	Tue,  3 Feb 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129193; cv=none; b=HnR35DrZRkwGIf67yGXflvO6Yq834SftVEHiI32Ho49cqCnj6QnK1wDs02Qb4M6YP2Ij5BohFMYicTgSRLz1zlOxVZ2JtInbY+BaUIG8K3b8SxQeUvcFgtyIIzQ79E0YZ8mAkg3I0YZB46TXYsyfiEp/a0xZkrefojRi48F5v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129193; c=relaxed/simple;
	bh=A1OlLMbB3g1FKP6UZmkX18lAmXYQG6EwebD+eqvaJ7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubWJOSIDyr6/Mvuww0eRPfab6Q/225fGTevXkzxm6Ae11L6AFWvuAp4ok8JwkSMCwpWztxAtpIcuY0BcpKsmhbxSLDnJqU6fPo+SNhOMo/bxhbcAICgBDaXpBSgdBS4Ync43Uz/cZ2v/3wa16iVNmXkNL91CVIJYCa2qCwqtjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chv3Xho2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chv3Xho2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D0DC116D0;
	Tue,  3 Feb 2026 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770129193;
	bh=A1OlLMbB3g1FKP6UZmkX18lAmXYQG6EwebD+eqvaJ7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Chv3Xho2Eqx7R59ajs2bsE/Z73sKLFRb7v8r32egOA5yYw/3+FtpsKN+uBX1RW9OI
	 oELo/ZsuAQwwtofM2kShgj4+xMxIT1GcnWdXQdRa80FcpJXd7jnH3d+K2WzK5wPMCT
	 JMhR42DfOlBsf0SZHGmZ0R/qAkKIRQM1Xd6M8L5GirHGC5LTO4ewQnJ3XAiFCmo3O7
	 AF8IJZbLcqHp3fTKi7HSsMY9iPtGUxjXB9D1EuL6mXB0YIUv0imTtOh1PCk9BI/lG2
	 4q7RfkC22yZ1epHB8PiVfeL9B9nSYa1VXecD39WiZeZH1+nykHCN1KabCDsOtevGvX
	 poH0nGowrEKJA==
Date: Tue, 3 Feb 2026 11:33:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Remove NO_LIBCAP that controls nothing
Message-ID: <aYIHJnkLm7d0qaCr@x1>
References: <20260130233539.648186-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130233539.648186-1-irogers@google.com>

On Fri, Jan 30, 2026 at 03:35:39PM -0800, Ian Rogers wrote:
> Using libcap was removed in commit e25ebda78e23 ("perf cap: Tidy up
> and improve capability testing"), however, some build documentation
> and a use of the NO_LIBCAP=1 were lingering. Remove these left over
> bits.

Thanks, applied to perf-tools-next,

- Arnaldo
