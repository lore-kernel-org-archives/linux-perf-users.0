Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553981;
	b=3eZbgRBOona5GqtWKo+BfooS0MxmxB7nWVIOey1CuCuLXYcIZMCN+VSp/qx8PtcdT6az
	 ZIBvRRZZSk2UHkl+2LUajxRfvhwboaxI7QhvAy8gU+L9QLm1nzJ7BKTNwb6GmagRr2gar
	 OtqcXeHsoI+OJyLEzNJMNPF+FN2frwLQG9GG0SEThkOT9sfIaMPhLtpS9a6USm3jd8yZJ
	 dOAtipcAamicQLTaOK7dkH/7PFtO9RvNitf2yKxfWuB7KC9OF80CnV8ZxOXoZbqWDen7I
	 7fIXggYiRrs7xS/zO5rRFvwGz+DxhtA/tBsXth9ZpEh7jRg/WOfe1oQJ/S2zOfFXEXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553981;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=+ZtaVEhsUXlRsNyIwiphIXnchhtdpp3YjJsqRluXe68=;
	b=OoxqNQHm9Vi9K/XIDjZgmVkpkE5W5v9QFJRzgcu1gE1P8S6Bf3BBpmQjvVEnLxwhQPuj
	 DHkeNaHJhQZtE0WCUoXvhiHwrP9aHSZWSORNf2VPK1VTqzh3/KjPnyPl0N1PrZOhQGtKG
	 CHDQueMfSKujA4j8d7Yh+ZE6urOS5KMaOtFOPAaM65b0l7xJL+CmWVls1cF9XWOkPedjf
	 E0GL/lAblEphIy2JJrsDa/mZNUGOrhb4lf93Xlr0uCMUIi80wr7CCliYh9frQru37vLiZ
	 hnWBZkYH4Gy2ngYwna7a/3bOeEtexzV0K7GAYmhmKbKoxthg6uAEMhKZDtNIE0cstAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bJD/njvi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71103606A327;
	Tue, 24 Nov 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJD/njvi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157AE1F000C0;
	Tue, 24 Nov 2026 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553981;
	bh=+ZtaVEhsUXlRsNyIwiphIXnchhtdpp3YjJsqRluXe68=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bJD/njviPHUXlB131KD74p14HpbNXGZmY7TrmfUguyoMmBrPXS8PS+YzYCrskmjtE
	 XpS8oclmaFsBuDeDmrWDKVraxq1p1vg1bzolAteLUxT0WBR8nLULGr6ojM52Zu1+aS
	 I8C6emwa2gOMGTa9Vi+n5PMMSNDwJY6bqV4vNZ0k6mfTJvYPFSmf8l6TayGxx79Cka
	 q8yFM50Tg3rec2lFSr/PSyCwC/vJdZVkDCnppdhp2XLYi7cO3OaGLaJRHABQ3qAc1u
	 q9Ygwxc0XaaBymfmFRdQmkpZYqJWkUjaPGVG9M+8DwnIWG6BKz7Fa8fjEPWLCNUQzL
	 Nv3z7Je9PtIjQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Letian Jiang <letian.jiang@outlook.com>
Cc: jolsa@kernel.org, irogers@google.com, eranian@google.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CYXPR84MB34769BAF18918C609FCD3327827C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
References: <CYXPR84MB34769BAF18918C609FCD3327827C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v3] perf docs: Correct JIT_CODE_UNWINDING_INFO
 specification
Message-Id: <179555398029.1562760.15096971463772223894.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:59:40 -0800
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

On Mon, 16 Nov 2026 22:15:38 +0800, Letian Jiang wrote:
> The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
> the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
> unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
> .eh_frame_hdr.
> 
> Correct the unwinding_data description and the eh_frame_hdr_size field
> description to match the layout consumed by perf. Clarify that
> unwind_data_size includes both sections. perf subtracts
> eh_frame_hdr_size from unwind_data_size to obtain the .eh_frame size.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


