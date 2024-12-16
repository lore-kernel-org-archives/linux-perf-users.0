Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1586C2FD;
	Mon, 16 Dec 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379128; cv=none; b=TppZ/55TgHOzNLteOg71uvSXYSakrz88eNtYaGrM2VYxwjr/2QVPCtRL7Aw9so1t6kZkITtQW4IdcN/yieaZWubDMuUJIbWvXfO+lmg00K759AwqdIfhZZoZkTe2VuW/3odccJW1tWHLVvSWZ+tGbhXXD3ap5rP/tTHiCOrkKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379128; c=relaxed/simple;
	bh=+VDg43IbfYvW2IUTm6S9mw7HuSVuma4Ql+8/EqdgyUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9EVdQhz17gCHnHB7o/9hZhL0/aL2UwV6ccAqOBFwPwCY8Q5jDAwL/eoJG5Kzs+x/siC5+dsMrSEB3aR9HYIAV5flI5b5LW46vHlF4JjjlHNRoTI24/5NwWwsfbOzF70g5gzaCbaqEaVfpIMIsnjGu2vkRv0OW5Q+VNNgtATe0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PisJxMNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PisJxMNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB650C4CED0;
	Mon, 16 Dec 2024 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379128;
	bh=+VDg43IbfYvW2IUTm6S9mw7HuSVuma4Ql+8/EqdgyUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PisJxMNfYjqy4jXXTyoq9TgNs3ddvph72MGX5OGkNIzOxBulCPmOYVB+L8aCk9LJe
	 EHC0f7P79m7iTntirVO9rxuMYNKEyB6fHZ2CXZ2j4R/2E3dFIozopBEg+dboZj3l+y
	 s6/i8tdmrvzCfrf1eng28BA62o3VUThPj/bPEQ6tq6l48Rx8HjV30t9OY4iYShiiXc
	 4V6TIxMm2s9OECUwEIRzujnNmN/nhP//Fu1E9EcYxcm+vT1njThxo14JVbN2N7c0fd
	 fZK/QXdUNmoKLjVYDk12pqaOj0YmIUxz/V4sb/UOVovBol6P98QICScte9450Bacbs
	 d7XKFCvyktrsQ==
Date: Mon, 16 Dec 2024 11:58:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z2CGdi5xpJy6C6sv@google.com>
References: <20241215190712.787847-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241215190712.787847-1-howardchu95@gmail.com>

On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> Changes in v4:
>  - Use if -f to check the existence of vmlinux BTF, and exit if it
>    doesn't, so trace_test_string will not overwrite $err, and keep
>    running the test.
> 
> Changes in v3:
>  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> 
> v1, v2:
> 
> The previous version of the perf trace BTF general augmentation tests
> didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> <acme@kernel.org> for pointing this out), this version uses bash instead
> of POSIX shell to pass Shellcheck.
> 
> This patch series also adds documentation for the new option
> --force-btf, which is used in the tests.
> 
> Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> 
> Howard Chu (2):
>   perf trace: Add tests for BTF general augmentation
>   perf docs: Add documentation for --force-btf option

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-trace.txt     |  5 ++
>  tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
> 
> -- 
> 2.43.0
> 
