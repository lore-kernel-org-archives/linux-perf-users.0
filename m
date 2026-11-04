Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827089;
	b=Ef49Y8TZyca6l4Lw4u+YMS69859WKwjSPGXighcgRIpFuCtCOp+njFjcwyOjRzmXE53u
	 mh2GzlCk57y7pTiAIJoB99ZPD3A0prZiUbNJjNz2IK+t1AIJNJVr/x/3APx9tV/fXEn+f
	 Cloht2IznXAAZrngsxg7jSqZzIw19YQ2NhPut5SkGj1NZxwLB68bucB7KuY+2Vf3XnyuA
	 uz+hODvVL/vniydzYO0Ftegy3PxwIrSSBXepicvXLiAePzaEYFITaTn5XNUGtJMCHDXG1
	 bDZNa4R5MTG3mJvaJ6QyxmpDo+BzOCsCWyVHVT43md2gOBghqcbJfhJXyDlvaCiIAjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827089;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2V4wZDgT7OWmGpYep2ZRml031rIr27X2lGMzGtxRgHI=;
	b=3ku2Er2PClqCv19zTDBJ2Pt2aKnJ51yBD2zUY8OXyXGGXS8o0aelmDsWPsgEo6a2tRBN
	 co7vIMFGyxZfwIyjGzReNP6OWMGKehrzWxLuSwt+mXLdWe7bGVzvLiqulzDvUD2T743V6
	 bUs8PiDaBZhz25hgnqi12Xi1fneYemIPfdGsrqNPNC77uv9p9Y1g33m2+U7y9j3fbchcC
	 19TUj66ntTkOIxoub7svuVz/1gaOo4IY0GG7tQqLiIB6QvyLdgEeZi55KgcC1hOxxYZBw
	 CwQW1VRE71LF9RFIrBABPIL08JAxxYO0wWIgixmmlLYKt3ozMD81aEjCj+baWdWP0sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byWFOa64;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07431606A86D;
	Wed,  4 Nov 2026 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byWFOa64
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EF61F000C1;
	Wed,  4 Nov 2026 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827088;
	bh=2V4wZDgT7OWmGpYep2ZRml031rIr27X2lGMzGtxRgHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=byWFOa64coQSsouDYTz19kYUcYsAL0KfuuJmuVgPyGR37fOLcccvkrJJhl5oGA3by
	 ARAPhj+/yBNA/JOK7kytBzwsS/V20PP1Sv1wh7+dlkrRMPJemKJUCFXc0UOdTyB1c4
	 GpnKWdYTA12HcWWoN/AKOJE5wO81d5OeQzncnhQnz8LFkAsVxtVhJegm9mzF3QIsCI
	 dknqS1TnRhY9NyBSGNqeARRbOTVcuXlaHYssGXUFdhlWy9w+ZxvWBSvm9Eu9MDg3DR
	 PJTLqWkPvB+npDCDIlPDTUjKP8QWRzd7N3FOiv1qsX1pkc+q8OysUDzDfSQMiNklJR
	 C05z3bO/0DhTw==
Date: Wed, 4 Nov 2026 18:18:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: lirongqing <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Free the old snapshot reference array
 after growing it
Message-ID: <auuhDZzGm-WSkw3w@phoenix2>
References: <20261104021951.1779-1-lirongqing@baidu.com>
 <cf0d3547-e4ba-474c-9a25-ef8f59225dac@intel.com>
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
In-Reply-To: <cf0d3547-e4ba-474c-9a25-ef8f59225dac@intel.com>

On Wed, Nov 04, 2026 at 11:50:02AM +0200, Adrian Hunter wrote:
> On 04/11/2026 04:19, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Growing snapshot_refs allocates a new array and copies the old entries,
> > then overwrites the only pointer to the old array. Snapshot recording
> > with more than sixteen AUX mappings leaks that allocation on expansion.
> > 
> > Free the old array after copying its entries. The reference buffers are
> > still owned by the entries copied into the replacement array.
> > 
> > Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for v7.4.

- Arnaldo
