Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794802227;
	b=s/wbUB0H8+t3B0A0OOBMaJs0zUWik2AouW/ilSTPtvAb1gVJK6+TF2fa0YOy3MVklvVm
	 Gi5p0trbYANESPUryfMsISIgxtEdBQz6S2AZHHDsTUL+vVkXgHchbpTHAZu8FKiZGRGJX
	 zwsGDZ9cM7kgUbROEa/SGp9+lX0DJ8AKVClHN0200RXYdbgzwQcyl5TRflWrLmsDqgUQS
	 rfGSO5x9fLY7HVgc66yXJgrbsdJAbO7rGGDYY6gLC1j/WL48qzm0jDHAA/pn0znR769PS
	 fSCcUTEev2ZNsB2R2GCAqxq9Yn9CMS20HdByckw/YIvQWBO/f28azgQpgq0onOf/+/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794802227;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BLGoZIEbUZKYyz8WVOO+AfyRS+PNn9AyXR8NGUdrbEY=;
	b=J4x+XHh6X/tSiT4RwGVS7UdAzDzTPgqo7vxj1lQIm57lIYtSJTC5F0w0WJ4PFJWMPQ3c
	 zV6uW3iL0WCrLPaJDGPHIC6i9Kz/NU3emUch+14ME09YbGj5wYoRcYrLYNOa3B9nG0kc+
	 VHQnIIPVWMMvYSuGtiyX3Ou1aDRmatlJuDeiXDdn1rCyFIGgHRRROiK/438asqxDXNUrt
	 c73zn3PtzvmXbkVIGUf2FkTt7KCLGF1gylxYViSls87ioM9sL81CFCErIT9pTlFe2DhKl
	 QwDWRkN1MBvyR3sII6rRiBqS0RfQNfjYQBF7jJxOgZNO1ko9p38aXC8eP2r5jUSnRGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6Q2F0WY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A00606A31F;
	Mon, 16 Nov 2026 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6Q2F0WY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CD41F000C4;
	Mon, 16 Nov 2026 04:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794802226;
	bh=BLGoZIEbUZKYyz8WVOO+AfyRS+PNn9AyXR8NGUdrbEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6Q2F0WYXcIyFoTzKa5qqJaTya4upul8SQWekfuI8W8R3n4aJvKwrjEZvTBpUpNZD
	 rFDzr2aAFOiwy4RzT/0DDbyilyYemLPY1O6CV4dWf0BdXzInx/0SpOf5i/aM63t+TD
	 6ke+ubqoZJjpPDttOnhKgEesinZu2yrS6xx9f1jx5ipzK6g/yiFMp+xyZfBd61An0S
	 qgDHYBNaOQdFMhMTIAfo4xeOfpNqVmml3rr8EcFV4TKdnT2TGCtCrb4l2yQrS/tImc
	 te3/5ZLhN31mpLKGokZvI/cG1LdhKaJVCm/D75VT6EPRXCFmzi0KkLf3lrCppvwrFr
	 nEiCbiWl7lMWg==
Date: Sun, 15 Nov 2026 20:10:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, haghdoost@uber.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 00/23] perf symbol: Sorted arrays, DSO-owned
 lifetimes, and memory shrinking
Message-ID: <avqCLir5KOrApFV1@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
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
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>

On Fri, Nov 13, 2026 at 09:17:11AM -0800, Ian Rogers wrote:
> When profiling large binaries or long-running workloads with many DSOs and
> threads, symbol and DSO tables frequently dominate perf's memory footprint
> and startup latency. Currently `struct symbol` has several structural
> limitations:

[...]

Applied selected patches to perf-tools-next, thanks!

Best regards
Namhyung
