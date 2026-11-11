Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424174;
	b=NoWZCbz91KCx1ZF1UtbqCsUo82n6ovzwepqn41NLySC7eOqgUacmoPJ44Y9E1gtvIy9o
	 MuTKpjrX3B6utVsXWJa6pE9CGW0tOlhhXveoeR8rdWNA4PW+WGmLUn/rzS8gqQzGJIckw
	 ZegUFFMYSlhAqDxoi0OS9a5kdKZT7EEAFAQprmacrIoO4laP6k+CSGzDzckK9rhsKWa15
	 hfcxaIvhOTUwMmiYAtbk14ihP7P7rG9ca4431qPiYYrBXI1BQD2iOfQDNTvYeVui91vhl
	 FCrNMh3zXqlmusvvA5Y5TAZZo42Qw2hRjEUWyC0eK7UF9xQC4WkbOEGaVe+VhVVtRGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424174;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=sBLvfooJz/TBQ1KvAdmewHc377ArYIPCH8KTfuPvfKg=;
	b=dpDuMTpT5oTA7HKau6TAIVBu6HE9ZqrfMORKiehFZSBZ+awVWuQV2OzjFADR9QHBlmS1
	 Q9iG9XeKs06I62v4Drk1CYYN26o/xmxbh3Ls2NFU+m4wJu/gZCLADzBJXKIivHRN0jj02
	 R4M1f0WEjHED5rcIz14JyXO+/zI2oiZb0dQGX3b4LoQUNCOrrN3OsrGO4pQv0qoC0Y5ES
	 8vAJx1set9GwAFcw1tHvpHkAoqmgCSqht/p5rogTez7ftl9bmhDAdXwo/+3wk3K16bGwD
	 2WZTDAddcUznaZRvm58pEhuesAKCm59GD7kzyhnuPRDCnNNSRftuZo4w5kyBGqED6wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXnJuSbi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C6606A89F;
	Wed, 11 Nov 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXnJuSbi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66A01F00A06;
	Wed, 11 Nov 2026 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424174;
	bh=sBLvfooJz/TBQ1KvAdmewHc377ArYIPCH8KTfuPvfKg=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=HXnJuSbiXtl8ctaRceuPznXya+x2fkKyOJ0re0xCwixwY3zWquL+tx7IMD75UolVV
	 1aHQQNTtDGlTQwW3pKQ6b0LonuA8+7g6VyZBqNmTRKvoLvOTFTw/OyJ1lYsbgnnxYo
	 +ppNqTXJicvxfdPdPLchDocYUaRdekQyZN1CI5TbTGNs9wHrLIBbiOgSp4O8imZ5MP
	 m32gBDT4srpB/9V1OyHKxf556ab6RjfeNHlMzEwBt6o7a3u9yDQamF138fZ6ghhdtL
	 jnM44P8bI+VVQbvwGi2WJR42MsgEZ0acajiASm2cOG4H1t0zhlpvHctiBMQCVdReDD
	 XuuGKzjVidjUg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Antonov <alexander.antonov@linux.intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lirongqing <lirongqing@baidu.com>
In-Reply-To: <20261109090143.1749-1-lirongqing@baidu.com>
References: <20261109090143.1749-1-lirongqing@baidu.com>
Subject: Re: [PATCH, next, v2] perf iostat: Release the port list if
 command allocation fails
Message-Id: <179442417255.676192.17219284909215847181.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:32 -0800
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

On Mon, 09 Nov 2026 17:01:43 +0800, lirongqing wrote:
> iostat_event_group() takes ownership of the root port list and frees it
> via the err: label on both the normal and parsing-error paths. When
> calloc() for iostat_cmd fails, however, the function returns -ENOMEM
> directly, leaking the list, its pointer array and every port in it.
> 
> Route this failure through the existing cleanup path instead. At this
> point no port has been transferred to an event yet, so
> iio_root_ports_list_free() releases the whole list, and the trailing
> free(iostat_cmd) is a no-op on the NULL pointer.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


