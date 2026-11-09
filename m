Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200052;
	b=EvUtAJ3NInsgh2EzbHOLYPYaH8h45w7qcNSy03h4+MHqhR3+0aBBnC81drZOS1Ad+DC2
	 C1sf+IhjtPSsThuBzfkBofvbT03J69oqUf/FLfzH9oJRhjbuiLOT8R7MKMpy7MrfDept1
	 RvcQK+vRaBh9Px6xcw17SicewRlB4HJjDDRPI9QfeTim04ZJHVt3gvGKyKM/qnTSHCbVn
	 4jpBSXYWIN5+ag/WBoeAHhMdY8hbWhA7QR64jpXuQdTGTgNv9g0wlncY0aaf3+3Cr7xDm
	 EkvqdgbRj2pXRSkVqWIrDJ7tWXbveeMRLGHvJDJVNPQR+S3nRWuvVmLSpnpENMLVdBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200052;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sd2WwpJ7V11KSwVkYLBiWfHVWV9mru2Fe0vNaIGhdo8=;
	b=IX6OxGTBxkmzA/pnjjfmHfrHzjT++4fFdKh36euFa9fMGnByFHx5v+8c/DCUBbSLS+bp
	 zOJLlpIZO0QIIW6ttD3iXafIo7xrvJZF0cxsG3iCloeEqwN/1oNM96VmKqCzjqH5v4O7d
	 /bXNbehPmomIo/kqQFvecvV4TsZMSz/2gRENGFER1o0UV7cMFc6nIZ//GkWLz08Gm79z+
	 5U+QuK2SZX+neU17T96YWWLY4vp8aj9Hku1EWbagfkclmE+ULieI0l9XN95bUz3YW+3uU
	 7TCJDSDWwQYl/GvECojgmqxd2LukaCUjN/8yK7dXIaBQeh5J0BvWapvPZp2YuiSjNfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/DQneqK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F2606A321;
	Mon,  9 Nov 2026 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/DQneqK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7981F0089F;
	Mon,  9 Nov 2026 04:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794200051;
	bh=sd2WwpJ7V11KSwVkYLBiWfHVWV9mru2Fe0vNaIGhdo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j/DQneqKA5ka4IAFJQjewxXYG2T5A8HY8BH4FUPrF5Qmri+QCXO/kFoMESvn7ZSfO
	 88dOfaYqEW3egkUl8GU4EkjOd36MEQdt7MHollWYEkm0HBKDuXxr/PD9XW2yWcLTIh
	 Qp8ztnwHFcGe3GII+12YsgAqyLG5HRdc55YvdqOL1Um3mEAyQ8jLNffc9dbUStqV2i
	 up+fsIe4jh2QPX0KFiOlzfkAhRtcIZNoQInn9M1ujW9XmVfQm3unDX5TG5DIZrr65m
	 tDS3mea3Zbt9jHTVsl+jYMSYn92kK4uHM6C1yORlM3Uyw+K9G6MAiG60/ctfJwiF4E
	 yir/oVcQDgCdw==
Date: Sun, 8 Nov 2026 20:54:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf tests: Assign return value of ioctl in
 wp_modify test
Message-ID: <avFR8t2S7Q0ZeKqB@z2>
References: <20261106092808.6914-1-yangtiezhu@loongson.cn>
 <20261106092808.6914-2-yangtiezhu@loongson.cn>
 <sashiko-outbox-201127@kernel.org>
 <79708703-7e59-315b-04f6-9d24a694eece@loongson.cn>
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
In-Reply-To: <79708703-7e59-315b-04f6-9d24a694eece@loongson.cn>

On Fri, Nov 06, 2026 at 05:51:35PM +0800, Tiezhu Yang wrote:
> On 11/6/26 5:36 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> 
> ...
> 
> > [Severity: Low]
> > This fixes a missing return value assignment introduced when the
> > watchpoint test was added.  Should the commit message include a Fixes
> > tag?
> > 
> >    Fixes: 2e85d5979e8d ("perf test: Add watchpoint test")
> 
> This is just a simple test case fix, so I'll let the maintainers
> decide if a Fixes tag is necessary when applying the patch.

Yep, I'll add this.

Thanks,
Namhyung

