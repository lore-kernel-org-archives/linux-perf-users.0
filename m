Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393042;
	b=nV3Ik+AMBdeQn63iM+XT6c+5C3cFZdv6c8QpaY65w20KZ4iuy4qNp3ytDTu+Dgfruhmr
	 iPUmeOiunG/w7465N5NYozm2sS7xrXLi5w9SOoLtgB0dQNu9nW3D/zaMYupFdtk5SjNgE
	 dSARXgZoWzOMMgFYNCPQrhooPcgCNjeOti5jir3CHpHfamlO5JiLxfq+d3xpSMw7p3lV+
	 vq2xXKvAAXouRDJTnTS5hnY1hjQwQ1Oyd5Nno7Re/nbWmOqpSJOUwIOx0qJxj7DVFl/dQ
	 3GeKXU/rClhtvpPWfGZi6r7aLLPTO4gK6++jNSEWqv2JEonEgiS6qdJVxDsF/O3p2Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393042;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gLBgqxrZKnWMeKmi4tJvbQNgtevbaW4eCq1whTIpIYA=;
	b=FPwLvmI+9Rw11eSptnmt6PhJ5YewE+ZPIwOYIKEj6icrxWHDb/I6JwSaml+D+o/6zq+R
	 6sAFPKNJi6fLBLJrBd2kOqz2xbi+FpWJMZBMSKlTbX5JiE6CVLg2Old+kLXHuml/Nynw7
	 v4HTlL7SvRkNh3p/MH9KbSdE7Knfd9iaF5upu88HVmENWHxu6fzbG5hdPSn4LJHJV6Dcb
	 f2HtcZk0n0fLQEwXp7x7xzHUM1YuZ1iiTybp7f+OrkDszdf0cOUMDFcWdp4m3jch6JC5r
	 LF2fL0x5yP29AyGjpxamLFahkxKu/URbkQyG2vcJ3uI3/Tobjli2ggamJwf+n7HAn7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwAiMSSL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80892606A31A;
	Mon, 23 Nov 2026 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwAiMSSL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E12F1F000C6;
	Mon, 23 Nov 2026 00:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795393042;
	bh=gLBgqxrZKnWMeKmi4tJvbQNgtevbaW4eCq1whTIpIYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hwAiMSSL2OXgDhu0H50AyjFwAVTim0YCE7LRQAHtIhqq2HlX+LClrnGOZBVlAlX7V
	 ZJfDSLt7nbO8xg59JcCMGuanJN+8ADiQyhhBfT2qkETrWCw9KyfSyn6mt9SwJD19Fv
	 WHxIUdJ673zwQqMAxpn2IiTVZTEa77zrq/nKigGKumyvNONe7Rfq+S3rJS8cd/YKiW
	 kOwnGdYry4LRLFcr8eqas4eU/1ec6MJZfYX9JAtl9N6phNwcwCMc73uti+Ef8oo5v/
	 pwZzzpi5Sbj96cQ1os1nciNNLRN3L44xtbfgM7zKU5t7NE0HBaWSrC0rVAtwAu9pdt
	 TVEtc1zpT0UiA==
Date: Sun, 22 Nov 2026 21:17:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, sashiko-reviews@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 00/19] perf coverage: A harness for perf, and the
 fixes it found
Message-ID: <awOGDnjv_RLnCzPF@phoenix2>
References: <20261122214025.16769-1-acme@kernel.org>
 <sashiko-outbox-228398@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-228398@kernel.org>

On Sun, Nov 22, 2026 at 09:54:50PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko has finished reviewing this 19-patch series:
 
> - Patches 1-11, 13-17, and 19: no issues found.
> - Patch 12 ("perf test: Exercise the annotate stats output"): 2
>   potential issues (1 Medium, 1 Low)
> - Patch 18 ("perf scripts: Add a coverage harness for perf"): 1
>   potential issue (1 Medium)
 
> Detailed reviews have been sent as separate replies to patches 12 and
> 18.

Namhyung,

	I addressed these issues and have V12 ready, I'm just holding
off sending to give some time for human reviews.

	I can send it if you want, 

Best regards,

- Arnaldo
 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261122214025.16769-1-acme@kernel.org
