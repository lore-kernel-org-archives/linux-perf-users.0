Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470139;
	b=k2XStnQaoAwloNMFnnFRKgXeVVvzoIzHOzl60y/oNP6C9EqBAHVCpJJjB3vzh6QWvNb/
	 0bpMw4S9i9EGR9janYk/peAOwjQad4HKpPg4//VZhTwMtm3K/yUtzSDkF537gUfLASMN3
	 +AezdaFG1vMf3zef+5rI+5/U/N3ZQuxnd6XC60Q/EFCzeUVSaT+C6QO2qah+n8L4FBFCt
	 rGWUkPATHT3mJAnE+29JRNEAPR9UVY6fln4rmAB+RTCvGsAb7ANGp0AtLGJP6LDQOiSm5
	 AI8DO/6t5e5tQoJRz6wy2iPpAO5eIv6Gdj/Nij3cwjWDvmq/Tb0RVAfVUIW7LGK9pkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470139;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=tvWKEa7sW7hqM8IXTCuuvyVs44O8ZoRdUQz3cjoo/Vk=;
	b=HIodHgIgYE4f2W4bYXlwwu0LCzn72LFJAaq9MckT5PKbm+jaNppQtEXN+KWBL0x2Qkvb
	 rq+oLAcE9PuZPwI4mXnkaAO7FjFpCIEPweB8ohOSaHj1TxA8tLRT2mu+D++gtvK05Whr0
	 +2tAku0Kz0LPhgVtpoJNGm1y+gjrFkuKC3zjoLlWEC+7dyxfumUITxH+ZO2mzOy0wHJOs
	 kGoHzsoM3bZ31cCMeiDQzOM/j2csokt79ZGLRb4Asofho0KLyNjc9i1hpGpeLsBiGb0Xi
	 UZ4nxIYhYR0W+WgkJe01C+TQ6w3jVKmH5WkVfNP7AcMAIdQC7VoSK/nRPHvEh14TA7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2oPR40R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5D606A31E;
	Mon, 23 Nov 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2oPR40R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2212A1F000C6;
	Mon, 23 Nov 2026 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470138;
	bh=tvWKEa7sW7hqM8IXTCuuvyVs44O8ZoRdUQz3cjoo/Vk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J2oPR40RkOi0OwKPeYKckICMhLk/a3PcfLQsYaII7Wu5YzfZDNKsdPE57apkIQOOx
	 2XDlh3mgVtKu/17KkU6T54JqD87azNYahvIAjImb7wAwXMLG0hsL+3fnSVEZ4E15b+
	 wfYKy7NIF4ZHNLluMWn6GH4yaY4zk+p+WkgH2fwCQd0gxIo2eiaNljn6jdlAS/Z2g9
	 HYxYgH3QZBKb+Lx5HXXZCKxmQuuFnze58IqALG01Erb9l1hrOMdnPn7xZC5CCk0cVO
	 wK5Cq6UVRL6AlMzuYLTGxqzcGVZPhpHRS1qTxVtQVKOa3evj5zqbTTMBhF7P6nK8ZG
	 JdcpweUPXyMGA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261120-bperf-attr-map-err-v1-1-b12b6b550273@gmail.com>
References: <20261120-bperf-attr-map-err-v1-1-b12b6b550273@gmail.com>
Subject: Re: [PATCH] perf bpf_counter: Say why the perf_event_attr map
 can't be used
Message-Id: <179547013808.1307628.8006860065256784042.b4-ty@b4>
Date: Mon, 23 Nov 2026 13:42:18 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 20 Nov 2026 14:49:03 +0800, Hang Zhengyang wrote:
> When 'perf stat --bpf-counters' can't set up the pinned map it uses to
> share counters, all it prints is:
> 
>   Failed to lock perf_event_attr map
> 
> Arnaldo asked for better wording when bperf was added.  The map can
> fail to be created, pinned, opened, checked or locked, and the message
> says neither which step failed nor why.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


