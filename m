Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146845;
	b=V5oz2mOqNGzVZqQf8NoHfCRKzOK24sLL/TCeruosMAup5xVIaV/+/qGz/1GbmP05Oow2
	 Nz5mwjHnp9+41RKpSbrseKmYw6Fk2UZQIwcGqMM/r80mb1WicZmNknoSieGeC2uCAiJtK
	 nTma8Xn9JnAqU+o6IlPpZgeFM/DCK6xJ3MvETDXZ4OrJ9yVomxwDfc9h+s3vYrPM29tTy
	 ykR5p46BLw5hvEiYVmasBB87dNUsWo718BJ8eXdSO+yaTHZ7iJomglMNJBf3d1JOeJ5w+
	 Z51Mz9abcOPOLYj4Zp4uDq+i4gVXfyPnf5CYyg41QvMU+PKAqT/fm5pJ2FVu2XeDgPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146845;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=bqf9xDIOkQeyHaNMdAAO5LAlXwTgQvDVKAjSE98tRF0=;
	b=l8PiWVAUbBXf/n487rmpCfdR6DCmXtOQsErOvwxzAwMtjgU2ob22Vi6RC2DRCfoQbCmx
	 1UVTOeTkdr59HIECWGIFYRCXVnsOEveWUid2Mgzao1l9AL7w+2FuVQPdTiPYRZzTvTGjv
	 xATvGeeCe6i30hQlK65kjeGSPRXKOqJs5i7Nu/EVQ8ofXpYfs+kKOyGh+Q3sQBAhlbpu9
	 LfT01HwyJ3xn0h0I4z/mW5bwPLpsQEoDFJnsEAieKyHGnevVHt5mFyZRcoF6mFPv6qpfu
	 d8hdbYwm75Cvf5DuE8fy7+217K2Dfu/QLn04JYR1LXvAqtBgZqQRoGT6D2iblT+tyVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYJJw3hR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A40606A325;
	Fri, 20 Nov 2026 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYJJw3hR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D191F000CF;
	Fri, 20 Nov 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146845;
	bh=bqf9xDIOkQeyHaNMdAAO5LAlXwTgQvDVKAjSE98tRF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hYJJw3hRTz8Bse62KOeOn4QzCm3c4A6/YOxPUZnFuzqwwBGUxi77ti/G2T9680WcE
	 MXEMv0aS7J4FHC611eFoStRoMUf/aVwhtVywHKFqWcsvz3yZBPPQkWijWsvrRfSemK
	 J1JDMabz7erzoVATkcG/Xn+K2KAg7bz1yl7USdYr6jpF9drwBREJGFscs3IxlQ6V+t
	 npp9uqKDIItawYET2QJiZKS935BpNA5ATMkNIFKF8uDLiY2eYGdsphYwWLxEBOxMpI
	 /JhC9WMn6zJa4rT06COiKAXsbm9Nm5rIFjg0HZME77b/fC/K4Cw2QLeLZir6LwLHoH
	 UhyZ5n5hNUxTQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Rui Qi <qirui.001@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@vger.kernel.org, 
 irogers@google.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org
In-Reply-To: <20261111022648.71649-2-qirui.001@bytedance.com>
References: <20261111022648.71649-2-qirui.001@bytedance.com>
Subject: Re: [PATCH v2] perf parse-events: default data breakpoints to any
 size on RISC-V
Message-Id: <179514684397.638421.15135482862928184027.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:03 -0800
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

On Wed, 11 Nov 2026 10:26:49 +0800, Rui Qi wrote:
> When the length of a data breakpoint is not specified on the command
> line, perf defaults it to HW_BREAKPOINT_LEN_4:
> 
>   $ perf record -e mem:0x30020:w ./prog
> 
> That assumes the length describes a byte range that is compared
> against the address of the access, which is how the x86 debug
> registers and most other architectures work.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


