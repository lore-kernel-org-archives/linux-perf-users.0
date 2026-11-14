Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624996;
	b=MNsEv7ZJVg7mzDmLiS7cVJQAZruJd1hThCwKxsLFSntjW8CAuU2/m3SjOuzMPsx146hX
	 EJWRXQIAh4BPkcoIB2HJq4bYXMs6hl5jxyGegEtn+/5yJ03xCwvILCZrxK1VLlfp45ACz
	 uvGOZVOMwaWnNE9TAlyoDvkX+FYGAiETRbYsfVPR5ID/bQTZcjvIbdkM99YWs9gRw8Cb2
	 hFSke7yiDSS/pvAPMUl5zroe5JUE0Z/RsTAVa2WaufapaY2S21DJiY2Ze9UxgNK65gzyG
	 CQks13HoEgzNDlOfCLjPcHdnMy+5eKh+Ir3wGBGGNUylEw0mDQVeQ98rC8HVQuZiRcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624996;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=4uPdj1q0dwlQ2TwjgT8KIFsg9HWLPMm9FUpycKV1caM=;
	b=gXGJTN7I367Qw220tsv1FcWX0jOrszbJLeEaL5uP7IrZLOOHiqq+vLOwU5NVjVl6Ft1U
	 T/PnT7hfqKpCFOeAyPqA3F3kUacOyctjJcsJbP8FwYx/bgZ9jQE6jbgSuBpDyBRSZgT+K
	 udjz/q9PCB195Ym9GIdaZZIPQzcqQsTMkKOcrGyjx4kgrM8dmcwGq+qogliNG8YCMaLwO
	 6uJ51SwDvPXsGz03/1y0LjW53s1qr8mCBicnuH7fBXTLQ+ZQ6rUnDhAj3uvDghen5IFc4
	 qjVIX9viRWf0NGN3A5PGKDBs9PZY5eCnUZol8a8vAmv02hjlTIIIImHi7O/wSRPCj+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuxlHytr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F74606A33E;
	Sat, 14 Nov 2026 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RuxlHytr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920E81F000C4;
	Sat, 14 Nov 2026 02:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794624996;
	bh=4uPdj1q0dwlQ2TwjgT8KIFsg9HWLPMm9FUpycKV1caM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RuxlHytrVTO8rejQIoyxxp2iW+8P4iUbuZvJlwx11GstPGut8L/wh7dV/1s1zScZb
	 wgjzQZg8sVDy6odiG4rs63uK9DDwkwcDZ84GR5yYTZ7xNb4zshlqZJKt5Gop8IEZrp
	 5CX+eAh+FIRXANH/TfRzcLtthIz7enGG9S1MKZwIOaRAoCqfyAzLWTnFiiONQx/jC5
	 ZblGzYT/hj1E5eQLYG3Rzvd1i+yg5C0/05+JuRK72au1A7aQK4uyPxcwzVDTmi8B2J
	 5Ds/Aa0qrnZPkn0kQ8NWfvS/UQ2bRYAIBHB/mEA4VQuFjPPQ/uX7u/zgzC5T51MAf8
	 XCDk4LSKu/QWg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, irogers@google.com, ctshao@google.com, 
 Besar Wicaksono <bwicaksono@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, mochs@nvidia.com, 
 rajjoshi@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, 
 john.garry@linux.dev, will@kernel.org, james.clark@linaro.org, 
 mike.leach@arm.com, leo.yan@linux.dev, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com
In-Reply-To: <20261104160716.2910873-1-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
Subject: Re: [PATCH v3 0/7] perf: Add NVIDIA Tegra410 uncore PMU events and
 metrics
Message-Id: <179462499501.532197.7672292578194020003.b4-ty@b4>
Date: Fri, 13 Nov 2026 18:56:35 -0800
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

On Wed, 04 Nov 2026 16:07:09 +0000, Besar Wicaksono wrote:
> Add event aliases and derived metrics for the NVIDIA Tegra410 uncore
> PMUs, and fix perf's aggregation of the Tegra410 PCIe PMU instances.
> 
> The series covers the UCF, PCIe, PCIe target, CPU memory latency, and
> chip-to-chip interconnect PMUs. It provides symbolic names for the raw
> event encodings and metrics for bandwidth, frequency, and average read
> latency.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


