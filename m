Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073586;
	b=rPYsnuYuNH9nEJayS7GdSbjs6aZk/QakNqxh4TwwcYNBx5AGhiENzWZqqkF7/cPEMav3
	 wz9wzktkiWuMLZ0syxOx3W8ubrxHWPaNpy2TREKDjiFaXSgHqWkGrU5eVidbqveVOWIWk
	 OYJwwyag0sCkK7NCIPwBjCvNF06Ofm+xURGKQ4FXo3uEKBMLBiMxKCSt85F1UKdg/KYze
	 CODxyiwKb6Z61P4FTS6J/+aSSk4kd9DEY4GLpWkqwCkenTjy9oSfJUPXZnaJZpbMCnzEx
	 Cygo00K34wLr6Otcmg9tslpyBFEzu+TYUj7MqnOWC4jyMG85rMfO+gMeQ/WVWA1CF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073586;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mGFsewEB2bXggwMVTJVNR2no13B4SjHbMIW9Z11YGC4=;
	b=jRYuqJSiyclRJP2MX9R3POtdyka6pSNRin08nzulTqqxjfMFLRj7GZAMmJxj9JaXYf6e
	 O2tDcVfiyY+GVujQtEiY+cDmY4WhzHd0J7F4I8sAa9AtlpLPkjBmrMusLMrm9gW0RqkzJ
	 INHkzF1KkBrNoviMJig+tqVCVSyQgd/ZGMcHImjdFAb+bvdG88T+F/gm3CIgbfNQh6akb
	 behCZcmYgkmNM0u+A47a9FRPvmVSkUinYB4JPSbDAcBomhZMNWv7r51Zuipnw0HHPm/Ad
	 RNf+qVhry6ZBJKzeHLVUCdIOZfz/qAt/DAcaOnM6PiLhlSKkzMFEeONNc2lhOBGyMbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK0cGkct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC048606A325;
	Thu, 19 Nov 2026 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QK0cGkct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98CE1F000C4;
	Thu, 19 Nov 2026 07:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073586;
	bh=mGFsewEB2bXggwMVTJVNR2no13B4SjHbMIW9Z11YGC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QK0cGkct7q/vy5NUVuI1sCF+nPtC/1AqY0PkJFhloYTtwN2rGC5mTUEh1met/aZT/
	 orwjIzHJO/HOre2JZXLnyxBMY7FIBHuvWYx/XJp2sD/89/KnvFB2wCZ+grdDoiMKng
	 VrIQm5IUJwUz8BYZWKSnU7CxmuxrNf8gYMcCvT2/gIIlLLd/SbrCtF1fuv/67pEvZR
	 nfh5vWL2yfuqyXcO9hJbYfazmnkDEA/ZQZjRmHEOv0qxjzg0dq8O8yi9vtfLr1oZ+v
	 UPN75JwCvoMBWn/MQlftjus0Rq/rkAuiraY0Jg3teTLU03Anip3uUkoO97uqi1xYg5
	 /q2krcEcEM9nw==
Date: Wed, 18 Nov 2026 23:33:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 01/13] perf jvmti: Link the agent with EXTRA_CFLAGS
Message-ID: <av6mMOKGBfPVH38C@google.com>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-2-acme@kernel.org>
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
In-Reply-To: <20261117200433.45174-2-acme@kernel.org>

On Tue, Nov 17, 2026 at 05:04:19PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The jvmti objects are compiled with EXTRA_CFLAGS but the agent is linked
> with LDFLAGS only, so flags with link-time parts never reach the shared
> object.  With -fprofile-instr-generate the agent's __profc counters had
> no __llvm_profile runtime to write them, and its files showed 0.00% in
> the coverage report.
> 
> Pass EXTRA_CFLAGS at link time, as the dlfilter rule already does.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This was applied to the perf-tools-next, thanks!

Best regards
Namhyung
